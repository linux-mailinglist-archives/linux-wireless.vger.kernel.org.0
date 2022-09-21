Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C5E35C054E
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Sep 2022 19:32:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbiIURcU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Sep 2022 13:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbiIURcT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Sep 2022 13:32:19 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D611A1D4D
        for <linux-wireless@vger.kernel.org>; Wed, 21 Sep 2022 10:32:16 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id sd10so6865116ejc.2
        for <linux-wireless@vger.kernel.org>; Wed, 21 Sep 2022 10:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=VnAeJAvK42eDipj3K88C5//uGtbGsaLzf7QZGTbFoDE=;
        b=FPsrSvJAb5PNun0J/RPKfvmn/Z4uwuq+D7Y7X8KtaO2fqOxjHwSKaldw0qb2gzlNsl
         hmH68gHKeioGAsU5eWEZTuSOZ5ang1nsJqO/cqMlzG8ghybKTRvDfzF1Ss6vyFqzsC5r
         H5sdBcNl5XeddOsjM/4jUI+k/6pKvCzrGHz5k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=VnAeJAvK42eDipj3K88C5//uGtbGsaLzf7QZGTbFoDE=;
        b=z6tKRDi2lOcXZvzizxg7qzZMSEfgwGlYFPK9oeBR8ZKjevTjX8iKM8LYUV/J3nPfE+
         ufGPvfYn2FT7FF7/8CjLBA9fEzjaUE4Ra+xh5firfSJ+wfllANhw1KXUt1jM/FllYcuV
         CPDVaFjBaNoTtkQU+gIWhuXywUaexOWlXT0GRWRfPS77ZO6a7g/Q4QYVALjDKUVo+s/A
         l/PHWgAnAye7Vv2yW6QmgnZCECYEV5BhHOSQs6TywjJe1qcYu/nfbWOZESSHzevOxvQf
         8VnY1Pp8aox/zixqvwjY2DC7vLu7Ahh/AGTi/LrbuHU3Hg9buPU0Mf1AK0DTmRMZAWwk
         wxrg==
X-Gm-Message-State: ACrzQf0q/VVHJnAyMjOuQ6EmLo5JzdQwZV3c1o9yUk+kQLIsfzj9PcbV
        6KFvofaRjlwKy93/rMrmgnswj+4CFgY/Y4mPO3Z3LAQPRVXMWYflBIKXELE/SZI++01Zvjvi9v8
        jJSIRIVA0RgLLxO7EdbHqofnsFYMImurNvw==
X-Google-Smtp-Source: AMsMyM6Dw5VLdfBvfo6ekolWnP07SpoWFIrJh5eKxuKVaME3liRUd2Ym3YntE/auOB0h/NSbkUFd9DZQ7Olm6Hje41w=
X-Received: by 2002:a17:907:9718:b0:77b:45b6:b047 with SMTP id
 jg24-20020a170907971800b0077b45b6b047mr21705735ejc.479.1663781534539; Wed, 21
 Sep 2022 10:32:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220921015951.16178-1-ian.lin@infineon.com> <20220921015951.16178-3-ian.lin@infineon.com>
In-Reply-To: <20220921015951.16178-3-ian.lin@infineon.com>
From:   Franky Lin <franky.lin@broadcom.com>
Date:   Wed, 21 Sep 2022 10:31:47 -0700
Message-ID: <CA+8PC_dGtLbh67ecartZA2Hs+66cj+9DQTzCfcCHxqpgrnfa8g@mail.gmail.com>
Subject: Re: [PATCH 2/3] brcmfmac: Fix interoperating DPP and other encryption
 network access
To:     Ian Lin <ian.lin@infineon.com>
Cc:     linux-wireless@vger.kernel.org, brcm80211-dev-list@broadcom.com,
        hante.meuleman@broadcom.com, kvalo@kernel.org,
        Double.Lo@infineon.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000005fd70f05e93353ce"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--0000000000005fd70f05e93353ce
Content-Type: text/plain; charset="UTF-8"

On Tue, Sep 20, 2022 at 7:04 PM Ian Lin <ian.lin@infineon.com> wrote:
>
> From: Kurt Lee <kurt.lee@cypress.com>
>
> 1. If firmware supports 4-way handshake offload but not supports DPP
> 4-way offload, when user first connects encryption network, driver will
> set "sup_wpa 1" to firmware, but it will further result in DPP
> connection failure since firmware won't send EAPOL frame to host.
>
> 2. Fix DPP AP mode handling action frames.
>
> 3. For some firmware without fwsup support, the join procedure will be
> skipped due to "sup_wpa" iovar returning not-support. Check the fwsup
> feature before do such iovar.

It is not a good practice to fix multiple issues in one patch. Please
break this up.

>
> Signed-off-by: Kurt Lee <kurt.lee@cypress.com>
> Signed-off-by: Double Lo <double.lo@cypress.com>
> Signed-off-by: Chi-hsien Lin <chi-hsien.lin@cypress.com>
> Signed-off-by: Ian Lin <ian.lin@infineon.com>
> ---
>  .../broadcom/brcm80211/brcmfmac/cfg80211.c    | 68 ++++++++++---------
>  .../broadcom/brcm80211/brcmfmac/p2p.c         |  5 ++
>  2 files changed, 42 insertions(+), 31 deletions(-)
>
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
> index 4a8aceda8fe8..c0e184db0e5d 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
> @@ -2128,44 +2128,50 @@ brcmf_cfg80211_connect(struct wiphy *wiphy, struct net_device *ndev,
>                 goto done;
>         }
>
> -       if (sme->crypto.psk &&
> -           profile->use_fwsup != BRCMF_PROFILE_FWSUP_SAE) {
> -               if (WARN_ON(profile->use_fwsup != BRCMF_PROFILE_FWSUP_NONE)) {
> -                       err = -EINVAL;
> -                       goto done;
> +       if (brcmf_feat_is_enabled(ifp, BRCMF_FEAT_FWSUP)) {
> +               if (sme->crypto.psk) {
> +                       if (profile->use_fwsup != BRCMF_PROFILE_FWSUP_SAE) {
> +                               if (WARN_ON(profile->use_fwsup !=
> +                                       BRCMF_PROFILE_FWSUP_NONE)) {
> +                                       err = -EINVAL;
> +                                       goto done;
> +                               }
> +                               brcmf_dbg(INFO, "using PSK offload\n");
> +                               profile->use_fwsup = BRCMF_PROFILE_FWSUP_PSK;
> +                       }
> +               } else {
> +                       profile->use_fwsup = BRCMF_PROFILE_FWSUP_NONE;
>                 }
> -               brcmf_dbg(INFO, "using PSK offload\n");
> -               profile->use_fwsup = BRCMF_PROFILE_FWSUP_PSK;
> -       }
>
> -       if (profile->use_fwsup != BRCMF_PROFILE_FWSUP_NONE) {
> -               /* enable firmware supplicant for this interface */
> -               err = brcmf_fil_iovar_int_set(ifp, "sup_wpa", 1);
> -               if (err < 0) {
> -                       bphy_err(drvr, "failed to enable fw supplicant\n");
> -                       goto done;
> +               if (profile->use_fwsup != BRCMF_PROFILE_FWSUP_NONE) {
> +                       /* enable firmware supplicant for this interface */
> +                       err = brcmf_fil_iovar_int_set(ifp, "sup_wpa", 1);
> +                       if (err < 0) {
> +                               bphy_err(drvr, "failed to enable fw supplicant\n");
> +                               goto done;
> +                       }
> +               } else {
> +                       err = brcmf_fil_iovar_int_set(ifp, "sup_wpa", 0);
>                 }
> -       }
>
> -       if (profile->use_fwsup == BRCMF_PROFILE_FWSUP_PSK)
> -               err = brcmf_set_pmk(ifp, sme->crypto.psk,
> -                                   BRCMF_WSEC_MAX_PSK_LEN);
> -       else if (profile->use_fwsup == BRCMF_PROFILE_FWSUP_SAE) {
> -               /* clean up user-space RSNE */
> -               err = brcmf_fil_iovar_data_set(ifp, "wpaie", NULL, 0);
> -               if (err) {
> -                       bphy_err(drvr, "failed to clean up user-space RSNE\n");
> -                       goto done;
> -               }
> -               err = brcmf_set_sae_password(ifp, sme->crypto.sae_pwd,
> -                                            sme->crypto.sae_pwd_len);
> -               if (!err && sme->crypto.psk)
> +               if (profile->use_fwsup == BRCMF_PROFILE_FWSUP_PSK)
>                         err = brcmf_set_pmk(ifp, sme->crypto.psk,
>                                             BRCMF_WSEC_MAX_PSK_LEN);
> +               else if (profile->use_fwsup == BRCMF_PROFILE_FWSUP_SAE) {
> +                       /* clean up user-space RSNE */
> +                       if (brcmf_fil_iovar_data_set(ifp, "wpaie", NULL, 0)) {
> +                               bphy_err(drvr, "failed to clean up user-space RSNE\n");
> +                               goto done;
> +                       }
> +                       err = brcmf_set_sae_password(ifp, sme->crypto.sae_pwd,
> +                                                    sme->crypto.sae_pwd_len);
> +                       if (!err && sme->crypto.psk)
> +                               err = brcmf_set_pmk(ifp, sme->crypto.psk,
> +                                                   BRCMF_WSEC_MAX_PSK_LEN);
> +               }
> +               if (err)
> +                       goto done;
>         }
> -       if (err)
> -               goto done;
> -
>         /* Join with specific BSSID and cached SSID
>          * If SSID is zero join based on BSSID only
>          */
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
> index 4636fc27e915..3d96ad872593 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
> @@ -1318,6 +1318,10 @@ static s32 brcmf_p2p_abort_action_frame(struct brcmf_cfg80211_info *cfg)
>         brcmf_dbg(TRACE, "Enter\n");
>
>         vif = p2p->bss_idx[P2PAPI_BSSCFG_DEVICE].vif;
> +
> +       if (!vif)
> +               vif = p2p->bss_idx[P2PAPI_BSSCFG_PRIMARY].vif;
> +
>         err = brcmf_fil_bsscfg_data_set(vif->ifp, "actframe_abort", &int_val,
>                                         sizeof(s32));
>         if (err)
> @@ -1867,6 +1871,7 @@ bool brcmf_p2p_send_action_frame(struct brcmf_cfg80211_info *cfg,
>         /* validate channel and p2p ies */
>         if (config_af_params.search_channel &&
>             IS_P2P_SOCIAL_CHANNEL(le32_to_cpu(af_params->channel)) &&
> +           p2p->bss_idx[P2PAPI_BSSCFG_DEVICE].vif &&
>             p2p->bss_idx[P2PAPI_BSSCFG_DEVICE].vif->saved_ie.probe_req_ie_len) {
>                 afx_hdl = &p2p->afx_hdl;
>                 afx_hdl->peer_listen_chan = le32_to_cpu(af_params->channel);
> --
> 2.25.0
>

-- 
This electronic communication and the information and any files transmitted 
with it, or attached to it, are confidential and are intended solely for 
the use of the individual or entity to whom it is addressed and may contain 
information that is confidential, legally privileged, protected by privacy 
laws, or otherwise restricted from disclosure to anyone else. If you are 
not the intended recipient or the person responsible for delivering the 
e-mail to the intended recipient, you are hereby notified that any use, 
copying, distributing, dissemination, forwarding, printing, or copying of 
this e-mail is strictly prohibited. If you received this e-mail in error, 
please return the e-mail to the sender, delete it from your computer, and 
destroy any printed copy of it.

--0000000000005fd70f05e93353ce
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
BZrfei1PlO2m9d3AfpeD7Y1pVL1SrZC1yvhXeDO463M8rGKz/l8XZrJY1P6qU8U6QwxjFgXr5o5B
9N6Yw9IhwXhZI3m6F1pe3mMdZ9cFC3xS3Ke+awIDAQABo4IB2DCCAdQwDgYDVR0PAQH/BAQDAgWg
MIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDovL3NlY3VyZS5nbG9iYWxzaWdu
LmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3J0MEEGCCsGAQUFBzABhjVo
dHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMDBNBgNV
HSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xvYmFsc2ln
bi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBAMD6gPKA6hjhodHRwOi8vY3Js
Lmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNybDAiBgNVHREEGzAZ
gRdmcmFua3kubGluQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNVHSMEGDAW
gBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQU0v383z+6bcUXkukYi4fq7VBiM6swDQYJ
KoZIhvcNAQELBQADggEBABUIiuJPuLq9vbb6/7d0VJ6LS6osA6kNs0Tph9iEX49TxPQJtvA97oy4
AgPCjWNiAMLkmu+kNQKlNZG3Vl3S4A+VMOogB6aKtiLlz73Cs0sPgpohw6GSS41TKVt17PrAzo0o
/xuXczzIbtvrpoi6OnGlsW4aVCqQSOqKUamG8wU8u3/h+iPM1rr4z6ZHdyrllNi+ukH/Z6Dpn6wF
ATUa+n5ReFZpli4TzcqVHw7i+OaB23TMHCwed4OPFm0H3zcCJgVtgt3z95IPak7bBuYLAGMT2c3K
Xkdn27MnpydqZw5mnP970DgyUMHXY3Jvj65UAVioJUr4LkNBL7Tsk/6q0FExggJtMIICaQIBATBr
MFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhHbG9i
YWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgxcbvtv+NUbtJoPDWwwDQYJYIZI
AWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIG6OP+cCaap9x+TngqCFWWPXLdPQOr8A8XgZokPj
AJ3UMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIyMDkyMTE3MzIx
NFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQB
AjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkq
hkiG9w0BAQEFAASCAQAq8NOOc5KrWTPF60XLHe2FVswbXD02CVEvRpqUv/xpsCvQDhCDaUHDuC0r
OD2Q8G+odAUXMgtcQc/ayIsIThxcNPmKzYVcpb7/Iylb833OZd7ryfQXwFrNCeGtvNT3FLgj25kL
DQUVywxm92fAhP4ho3WJG4Blr8grAqNTB47fJApWyzml1UuEwLpi2z+1ixb4VFvjKjnC6Eudtcgs
lk5ULtWkWd8/pPoG645MpmxnU081AaAb93hSiVlcDS1U8o/MoTpPTZVmryKzQjNaG4nQ1V3wRvTj
RgJZ4rvtOW5i6VTbUtL7MJnGVESoSIE1A4kGJymKyEptaNS6PjjbdeGj
--0000000000005fd70f05e93353ce--
