using ShellObjects;
using System;
using System.ComponentModel;
using System.Diagnostics;
using System.IO;
using System.Runtime.InteropServices;
using System.Text;

public static class DefaultBrowser
{
    public static bool OpenUrlInDefaultBrowser(string url)
    {
        string browserProgId;
        if (!GetDefaultBrowserProgId(out browserProgId))
            return false;

        string browserCommandTemplate;
        if (!GetCommandTemplate(browserProgId, out browserCommandTemplate))
            return false;

        string browserExecutable;
        string parameters;
        if (!EvaluateCommandTemplate(browserCommandTemplate, out browserExecutable, out parameters))
            return false;

        parameters = ReplaceSubstitutionParameters(parameters, url);

        try
        {
            Process.Start(browserExecutable, parameters);
        }
        catch (InvalidOperationException) { return false; }
        catch (Win32Exception) { return false; }
        catch (FileNotFoundException) { return false; }

        return true;
    }

    private static bool GetDefaultBrowserProgId(out string defaultBrowserProgId)
    {
        try
        {
            // midl "C:\Program Files (x86)\Windows Kits\8.0\Include\um\ShObjIdl.idl"
            // tlbimp ShObjIdl.tlb
            var applicationAssociationRegistration = new ApplicationAssociationRegistration();
            applicationAssociationRegistration.QueryCurrentDefault("http", ShellObjects.ASSOCIATIONTYPE.AT_URLPROTOCOL, ShellObjects.ASSOCIATIONLEVEL.AL_EFFECTIVE, out defaultBrowserProgId);
        }
        catch (COMException)
        {
            defaultBrowserProgId = null;
            return false;
        }
        return !string.IsNullOrEmpty(defaultBrowserProgId);
    }

    private static bool GetCommandTemplate(string defaultBrowserProgId, out string commandTemplate)
    {
        var commandTemplateBufferSize = 0U;
        NativeMethods.AssocQueryString(NativeMethods.ASSOCF.ASSOCF_NONE, NativeMethods.ASSOCSTR.ASSOCSTR_COMMAND, defaultBrowserProgId, "open", null, ref commandTemplateBufferSize);
        var commandTemplateStringBuilder = new StringBuilder((int)commandTemplateBufferSize);
        var hresult = NativeMethods.AssocQueryString(NativeMethods.ASSOCF.ASSOCF_NONE, NativeMethods.ASSOCSTR.ASSOCSTR_COMMAND, defaultBrowserProgId, "open", commandTemplateStringBuilder, ref commandTemplateBufferSize);
        commandTemplate = commandTemplateStringBuilder.ToString();

        return hresult == 0 && !string.IsNullOrEmpty(commandTemplate);
    }

    private static bool EvaluateCommandTemplate(string commandTemplate, out string application, out string parameters)
    {
        string commandLine;
        var hresult = NativeMethods.SHEvaluateSystemCommandTemplate(commandTemplate, out application, out commandLine, out parameters);

        return hresult == 0 && !string.IsNullOrEmpty(application) && !string.IsNullOrEmpty(parameters);
    }

    private static string ReplaceSubstitutionParameters(string parameters, string replacement)
    {
        // Not perfect but good enough for this purpose
        return parameters.Replace("%L", replacement)
                         .Replace("%l", replacement)
                         .Replace("%1", replacement);
    }
}