Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C279554A1A
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Jun 2022 14:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241794AbiFVMg2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 22 Jun 2022 08:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230476AbiFVMgY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 22 Jun 2022 08:36:24 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A27A35AB7
        for <linux-wireless@vger.kernel.org>; Wed, 22 Jun 2022 05:36:20 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id o18so8230201plg.2
        for <linux-wireless@vger.kernel.org>; Wed, 22 Jun 2022 05:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:to:cc:references
         :from:in-reply-to;
        bh=heSxLF11QgYHttTAqhG8oCmZoCO+1xR7GFLh1Q02oeg=;
        b=aOGzgzJwrBs9kg4JpF/WMYNP+n8cXfTx9Nt9murYIA/jM4jaxYx5LGdT5TL4ewCROE
         Y+l1tDaCkPPUjzxYiHwO8QERKqE/dRP2VcNO7fTpyC1l7SWmsxCZeH6DPo9P8wxH9EvS
         OYFT2sGQL9Np4/j7bUrKLeZeRxOV/mrqywACc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :to:cc:references:from:in-reply-to;
        bh=heSxLF11QgYHttTAqhG8oCmZoCO+1xR7GFLh1Q02oeg=;
        b=OEKYL4bKg35WsuUmOt1HjKQOWgup5oNQXy1QHd8RnrJAUdc3acjHPeNYhGKXRMPj99
         XgC2ej37FqKuwnXjGrxuuRMM5rHm64TWZPubIagSgrNmIhGxAk7SHnHCKaswmTqsjEmn
         OHSAxtVa2gvxcm1WxUMmN5vJxb0ut446Xy20qZ5UCUza8rAm312G28TTGxWjK7TkLdey
         a/SEkDvVU+A/Bg4i3to/6SmVQb1T5Y6Xo8RXnq77MSU+QuiBrxcdJ9zojpy43hpOJkz4
         eIply3Od+GI16uBTgU5n5w90Ma8ogRcZJ3fy49IHLQDlk/Zc7dhqS/LyHdP/PNcFuobC
         XM4w==
X-Gm-Message-State: AJIora8Ja+LdIw/UIkiYzDMgZ5FT22QgwA7iB7K/wRXdqy67d19Bfhjz
        jH4n5mt9EpymXCsWezrpMV6eNg==
X-Google-Smtp-Source: AGRyM1sIdFL3XxPiErN6RQL0n38J5oT6ueziNC4s7mI7aweNvFACj2YqbCj9xhHJtvt24ctQaym0uw==
X-Received: by 2002:a17:903:110d:b0:168:c610:9a80 with SMTP id n13-20020a170903110d00b00168c6109a80mr33854374plh.12.1655901380045;
        Wed, 22 Jun 2022 05:36:20 -0700 (PDT)
Received: from [10.176.68.61] ([192.19.148.250])
        by smtp.gmail.com with ESMTPSA id z22-20020a637e16000000b0040cc830b0cfsm5491252pgc.39.2022.06.22.05.36.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jun 2022 05:36:18 -0700 (PDT)
Message-ID: <f14afd46-0bad-9d7b-1361-203bcad92e06@broadcom.com>
Date:   Wed, 22 Jun 2022 14:36:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3] brcmfmac: prevent double-free on hardware-reset.
To:     Danny van Heumen <danny@dannyvanheumen.nl>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc:     Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
References: <ThT2jwvySn9tFQm9FxrlPNMQkiGUnx_87cOhmmeexoVOFZqOkpjmAntCWG-kIBMj2830LHZaOULlJxQKiRXkVtGYrrT8rBaB7R65qjIinYo=@dannyvanheumen.nl>
From:   Arend van Spriel <arend.vanspriel@broadcom.com>
In-Reply-To: <ThT2jwvySn9tFQm9FxrlPNMQkiGUnx_87cOhmmeexoVOFZqOkpjmAntCWG-kIBMj2830LHZaOULlJxQKiRXkVtGYrrT8rBaB7R65qjIinYo=@dannyvanheumen.nl>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000008ed4f005e20895e8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--0000000000008ed4f005e20895e8
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

+ Uffe

On 6/17/2022 4:24 PM, Danny van Heumen wrote:
>  From f1fcceb65d4a44c078cd684ea25a2f2c7f53deb2 Mon Sep 17 00:00:00 2001
> From: Danny van Heumen <danny@dannyvanheumen.nl>
> Date: Tue, 24 May 2022 18:30:50 +0200
> Subject: [PATCH v3] brcmfmac: prevent double-free on hardware-reset.
> 
> In case of buggy firmware, brcmfmac may perform a hardware reset. If during
> reset and subsequent probing an early failure occurs, a memory region is
> accidentally double-freed. With hardened memory allocation enabled, this error
> will be detected.
> 
> - return early where appropriate to skip unnecessary clean-up.
> - set '.freezer' pointer to NULL to prevent double-freeing under possible
>    other circumstances and to re-align result under various different
>    behaviors of memory allocation freeing.
> 
> Given a firmware crash, function 'brcmf_sdio_bus_reset' is called. It calls
> 'brcmf_sdiod_remove', then follows up with 'brcmf_sdiod_probe' to reinitialize
> the hardware. If 'brcmf_sdiod_probe' fails to "set F1 blocksize", it exits
> early, which includes calling 'brcmf_sdiod_remove'. In both cases
> 'brcmf_sdiod_freezer_detach' is called to free allocated '.freezer', which
> has not yet been re-allocated the second time.

For testing you can also trigger the brcmf_sdio_bus_reset() through debugfs:

# cd /sys/kernel/debug/ieee80211/phyX
# echo 1 > reset

So I did that without your patch and observed following:

[  531.481045] brcmfmac: brcmf_sdiod_probe: Failed to set F1 blocksize 

[  531.487314] brcmfmac: brcmf_sdio_bus_reset: Failed to probe after 
sdio device
  reset: ret -123 

[  531.495893] mmc0: card 0001 removed 

[  531.550567] mmc0: new high speed SDIO card at address 0001 

[  531.556561] brcmfmac: F1 signature read @0x18000000=0x16044330

So I looked in brcmf_sdio_bus_reset() and noticed that this function 
actually does a call to mmc_hw_reset() which is what I suggested 
earlier. Looking at this log it seems the actual remove and subsequent 
rescan is a deferred work and it will take care of probing the driver anew.

So I changed debug message level for the sdio ops and then I see:

[ 1327.686828] brcmfmac: brcmf_sdiod_probe: Failed to set F1 blocksize 

[ 1327.693091] brcmfmac: brcmf_sdio_bus_reset: Failed to probe after 
sdio device
  reset: ret -123 

[ 1327.701626] brcmfmac: brcmf_ops_sdio_remove Enter 

[ 1327.706333] brcmfmac: brcmf_ops_sdio_remove Function: 1 

[ 1327.711557] brcmfmac: brcmf_ops_sdio_remove Exit 

[ 1327.716203] brcmfmac: brcmf_ops_sdio_remove Enter 

[ 1327.720911] brcmfmac: brcmf_ops_sdio_remove Function: 2 

[ 1327.726135] brcmfmac: brcmf_ops_sdio_remove Exit 

[ 1327.730768] mmc0: card 0001 removed 

[ 1327.785458] mmc0: new high speed SDIO card at address 0001 

[ 1327.791068] brcmfmac: brcmf_ops_sdio_probe Enter 

[ 1327.795687] brcmfmac: brcmf_ops_sdio_probe Function#: 1 

[ 1327.800988] brcmfmac: brcmf_ops_sdio_probe Enter 

[ 1327.805610] brcmfmac: brcmf_ops_sdio_probe Function#: 2 

[ 1327.811317] brcmfmac: F1 signature read @0x18000000=0x16044330

So to me it seems mmc_hw_reset() is doing everything we need and we can 
make brcmf_sdio_bus_reset() a bit simpler. The only scary part here is 
that brcmf_ops_sdio_remove() is called first for func1 and then for 
func2. Upon rmmod this is different, ie. first func2 and then func1. 
Looking at the implementation in brcmf_ops_sdio_remove() it means we run 
into use-after-free upon mmc_hw_reset().

Regards,
Arend

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c 
b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
index 212fbbe1cd7e..21e15f571eea 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
@@ -4158,24 +4158,15 @@ static int brcmf_sdio_bus_reset(struct device *dev)

  	brcmf_dbg(SDIO, "Enter\n");

-	/* start by unregistering irqs */
  	brcmf_sdiod_intr_unregister(sdiodev);
-
  	brcmf_sdiod_remove(sdiodev);
+	brcmf_bus_change_state(sdiodev->bus_if, BRCMF_BUS_DOWN);

-	/* reset the adapter */
+	/* reset the card */
  	sdio_claim_host(sdiodev->func1);
  	mmc_hw_reset(sdiodev->func1->card);
  	sdio_release_host(sdiodev->func1);

-	brcmf_bus_change_state(sdiodev->bus_if, BRCMF_BUS_DOWN);
-
-	ret = brcmf_sdiod_probe(sdiodev);
-	if (ret) {
-		brcmf_err("Failed to probe after sdio device reset: ret %d\n",
-			  ret);
-	}
-
  	return ret;
  }

--0000000000008ed4f005e20895e8
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
XSlOP9s1dqWlRRnnNxV7BVC87lkKKy0+1M2DOF6qRYQlnW4EfOyCToYLAG5zeV+AjepMoX6J9bUz
yj4BlDtwH4HFjaRIlPPbdLshUA54/tV84x8woATuLGBq+hTZEpkZAgMBAAGjggHdMIIB2TAOBgNV
HQ8BAf8EBAMCBaAwgaMGCCsGAQUFBwEBBIGWMIGTME4GCCsGAQUFBzAChkJodHRwOi8vc2VjdXJl
Lmdsb2JhbHNpZ24uY29tL2NhY2VydC9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcnQwQQYI
KwYBBQUHMAGGNWh0dHA6Ly9vY3NwLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24y
Y2EyMDIwME0GA1UdIARGMEQwQgYKKwYBBAGgMgEoCjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3
dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAJBgNVHRMEAjAAMEkGA1UdHwRCMEAwPqA8oDqG
OGh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3Js
MCcGA1UdEQQgMB6BHGFyZW5kLnZhbnNwcmllbEBicm9hZGNvbS5jb20wEwYDVR0lBAwwCgYIKwYB
BQUHAwQwHwYDVR0jBBgwFoAUljPR5lgXWzR1ioFWZNW+SN6hj88wHQYDVR0OBBYEFKb+3b9pz8zo
0QsCHGb/p0UrBlU+MA0GCSqGSIb3DQEBCwUAA4IBAQCHisuRNqP0NfYfG3U3XF+bocf//aGLOCGj
NvbnSbaUDT/ZkRFb9dQfDRVnZUJ7eDZWHfC+kukEzFwiSK1irDPZQAG9diwy4p9dM0xw5RXSAC1w
FzQ0ClJvhK8PsjXF2yzITFmZsEhYEToTn2owD613HvBNijAnDDLV8D0K5gtDnVqkVB9TUAGjHsmo
aAwIDFKdqL0O19Kui0WI1qNsu1tE2wAZk0XE9FG0OKyY2a2oFwJ85c5IO0q53U7+YePIwv4/J5aP
OGM6lFPJCVnfKc3H76g/FyPyaE4AL/hfdNP8ObvCB6N/BVCccjNdglRsL2ewttAG3GM06LkvrLhv
UCvjMYICbTCCAmkCAQEwazBbMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1z
YTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMgUGVyc29uYWxTaWduIDIgQ0EgMjAyMAIMMSnY
h9J/RI6gsHbuMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCA2Dzx8Y+e4/fBDGpZR
nkRiSzOw0r/ImkhCFGf1GNHUATAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJ
BTEPFw0yMjA2MjIxMjM2MjBaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFl
AwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzAL
BglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAicbFtyD5wlOBeNHvT7wfNPJrW+szmvDN3Z8K
UwjJ9IZN2rBXPXB2itcaOoGj8XVTu4JPabHRz3v4RP1fuUyUXCMikVTulCigvW063IR62iY91+rF
vIw8OiuVhSTEoG6+ZQX6HTHB7wWioM/LoQoJImMzcwSbReREkUajxhlqSE851WC++sdE+iW784n6
HoIZeMDGI9MPl4fy6R7qmUBe+QmFMtv/uTA7R70mxwRhxP2xIJkYadbnsZYB96yht2CbUh5ntmoT
ZTdVuyBSEaYuHmzYauGAFBlWJnP06+IuQU0roZAe2MuNLmeoAx4gNTkYjJje/MhF4OVC+Z+RydLE
RQ==
--0000000000008ed4f005e20895e8--
