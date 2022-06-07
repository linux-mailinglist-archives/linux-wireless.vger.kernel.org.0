Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C62E54199E
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Jun 2022 23:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377959AbiFGVX2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 7 Jun 2022 17:23:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377988AbiFGVWg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 7 Jun 2022 17:22:36 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DCE8225882
        for <linux-wireless@vger.kernel.org>; Tue,  7 Jun 2022 12:00:19 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id h23so25986343ejj.12
        for <linux-wireless@vger.kernel.org>; Tue, 07 Jun 2022 12:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:to:cc:references
         :from:in-reply-to;
        bh=Jzm9VhR6NXV83vdPAp6CxKl90yuylT35MPVTXJ6/h6g=;
        b=eP+CHzIUj8ZO0cnZr+yPHOrldJizRLtKyXPCCOmby7TGGfJUVbS6ukpLlEJhsjPf4x
         L9p+WDwwrL5DQ8FEVxJoI3bx00DwM4KPcAx0k0uM+mPK9KV1TV/jcFtS1jYd12BR3xWF
         81XUoOiss38MoChx7XYv0+ootUzbcw6VxqKAk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :to:cc:references:from:in-reply-to;
        bh=Jzm9VhR6NXV83vdPAp6CxKl90yuylT35MPVTXJ6/h6g=;
        b=fht293no69UTUShqQWm4ySZJehIr5iQHjNULKhC3GWWm/nI48bJ+JqAZAKEUh9ZT2n
         0Mxp0dd4wjcQZddLJmLHx0/5pPeUus/XrBQjcbFXvLxPlyb5ePX8MceJ80iPj6tZi9pX
         M39I/hJ/NpGG2zVTAU4yuKC6sbvNroZhHmJjs6eeZO87N8vfK2eDlxYHqsBunpVGxl7c
         hCUvIa5NnnaHD31mIvbtQVHp6h1jp6Tjhu4h3cYVUB7ToaV7f26bpBzKC0pF9xzb2NND
         FF+p/i8MX248QNIbkfZgvORudkPgdJ2/nLFwVWB6P1Nl4jhwju0ayjdmL0mzdygGxUti
         Lqlw==
X-Gm-Message-State: AOAM532B8PxE0fA2lk4z7rpEmZ5mYG2nPegQ/ovqwtcXxhVyhQlX5R1W
        X/t2gl4MR3xHa5W4/ba7S9u8y9N+DP3Nj3xEW4GkqQ==
X-Google-Smtp-Source: ABdhPJxzw0o0aUA18207sJWOJ24dg/LHPGY2BKZF6Uq2Z41vI/WuWBGrHtHvSvUgYehW6o+ZE+STAA==
X-Received: by 2002:a17:906:6d05:b0:709:2c7d:5846 with SMTP id m5-20020a1709066d0500b007092c7d5846mr29034779ejr.158.1654628416181;
        Tue, 07 Jun 2022 12:00:16 -0700 (PDT)
Received: from [192.168.178.136] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id l23-20020a170906645700b006fe8a4ec62fsm8139292ejn.4.2022.06.07.12.00.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jun 2022 12:00:14 -0700 (PDT)
Message-ID: <1a116224-66ff-17b1-bb8b-9c0918dd47e4@broadcom.com>
Date:   Tue, 7 Jun 2022 21:00:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] work-in-progress: double-free after hardware reset due to
 firmware-crash
To:     Danny van Heumen <danny@dannyvanheumen.nl>,
        Franky Lin <franky.lin@broadcom.com>
Cc:     Arend van Spriel <aspriel@gmail.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "brcm80211-dev-list.pdl@broadcom.com" 
        <brcm80211-dev-list.pdl@broadcom.com>,
        "SHA-cyfmac-dev-list@infineon.com" <SHA-cyfmac-dev-list@infineon.com>
References: <UXibAXk2GByhvw88A6LIDXHSlkP79-ML7FrtyfnHuiC34qUd-zx03BAJAtzluyEvfwPBR0tac4hC72zKI1qT3CtgmvvVohr1v8a49TqYVSw=@dannyvanheumen.nl>
 <Uba0mwWYafMZd4JdEJVxMd-Uh8M6T4dHoTse71YdCikdJLYLxunwtrxxbasffgMuXtPVi_JmJrtAnqviM6x-99_SyysHZm-Yvz933mPXr74=@dannyvanheumen.nl>
 <Y_XMhLmW7kj2Ls3X8pCfFd2RdWzXd9UWdv3ksFrVi7xh79wY7l6K52N3ODhI3_UK_IqG1uJcIEv0PxT-wQG9tdYu9krraq7gxsprUu-RtjQ=@dannyvanheumen.nl>
 <51CC1C7B-400C-4A7A-A5D3-EB457DC6862F@broadcom.com>
 <jJuvC2YezD_e1G6VFXwJjFFUAir0HFcDnBaZGRvKtnaY69v8aI3KkCouzzyOjrb9bZOnSzinETjNNxHvlmYCwNijdmts_5bEXZSV7dMNi0s=@dannyvanheumen.nl>
 <B08447EB-F222-49B5-A411-0DB6848A80ED@broadcom.com>
 <EbyrCYK_mR6ppJYbSc5JfGGG_QZEZb2Zp8Htx9f-orZ_wX0Dpz1pXhDjQ9P1nGuyTH041zvsScaRIPllClzLpLgwVuff4ZTTAiVOXe5-Mwg=@dannyvanheumen.nl>
From:   Arend van Spriel <arend.vanspriel@broadcom.com>
In-Reply-To: <EbyrCYK_mR6ppJYbSc5JfGGG_QZEZb2Zp8Htx9f-orZ_wX0Dpz1pXhDjQ9P1nGuyTH041zvsScaRIPllClzLpLgwVuff4ZTTAiVOXe5-Mwg=@dannyvanheumen.nl>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000ffd14105e0e0329e"
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--000000000000ffd14105e0e0329e
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/7/2022 3:52 PM, Danny van Heumen wrote:> Hi Franky,
 >
 > ------- Original Message -------
 > On Tuesday, June 7th, 2022 at 01:50, Franky Lin 
<franky.lin@broadcom.com> wrote:
 >>
 >>
 >> Hi Danny,
 >>
 >> My apology. I didn’t read the thread carefully and failed to notice 
the rev1 to rev 2 change of the patch.
 >>
 >>> On Jun 4, 2022, at 7:59 AM, Danny van Heumen 
danny@dannyvanheumen.nl wrote:
 >>>
 >>> Hi Franky,
 >>>
 >>> ------- Original Message -------
 >>> On Saturday, June 4th, 2022 at 00:58, Franky Lin 
franky.lin@broadcom.com wrote:
 >>>
 >>>> Hi Danny,
 >>>>
 >>>> [..]
 >>>>
 >>>> Thanks for reporting and sending out a patch to fix this.
 >>>>
 >>>> If the problem is double freeing the freezer buffer, it should be 
addressed from the root by setting pointer to NULL. Same thing might 
need to be done for sg table as well. Sorry I don’t have any sdio module 
to reproduce and test. Please see if the below change fixes the problem.
 >>>
 >>> Your suggestion to set the freeze buffer address to zero was also 
my first proposal. I have since
 >>> revised, because there are a few things I considered, although I am 
not sure:
 >>>
 >>> - does zero-ing the address prevent future detection of 
double-frees with the hardened memory
 >>> allocator? (If so, I would prefer to avoid doing this.)
 >>> - IIUC correctly, 'sdio_set_block_size' does not do any meaningful 
"activation" or "allocation".
 >>> Therefore would not need to be undone. (repeated probes would 
override previous calls)
 >>> - Starting with the call 'sdio_enable_func', I guess/suspect more 
elaborate "cleanup" is necessary
 >>> therefore, leaving the 'goto out' from that point on. I would 
assume (for lack of evidence to the
 >>> contrary) that the logic at 'goto out' provides proper clean-up.
 >>
 >>
 >> While directly return without invoking clean up process makes 
perfect sense for the issue described here, it doesn’t address the 
broader issue that sdiodev might hold on to couple stale pointers that 
might subsequently be used in somewhere down the path because sdiodev is 
not freed. Setting these pointer to NULL after freeing them could help 
us to catch such issue which is more catastrophic than a double-free. 
The perfect solution of course is to rework the code to free sdiodev 
whenever brcmf_sdiod_remove() is invoked but that can not be done in 
short-term unfortunately.
 >
 > - True.
 > - If the two early returns are appropriate -- I think they are -- so 
we can leave those in. (Again, I'm unfamiliar with the code-base.)
 > - Setting the pointer to NULL at least has the benefit that behavior 
(even if bugged) is the same irrespective of memory allocation behavior.
 > - I checked your suggestion for 'sdiodev->sgtable': it is not a 
pointer, so setting to NULL will not help. If I read this correctly, 
'sg_free_table(..)' is already resistant to multiple freeing attempts 
with a test of '.sgl'.
 >
 > .. as for the control flow. Sure, rework would be nice, but -- to me 
at least -- it is not clear if it is really necessary. Maybe I'm 
mistaken, but there seem to be few entry-points to take into account. 
The "hardware-reset after firmware-crash"-logic was added later IIUC, so 
maybe it was an oversight? Regardless, I have updated the patch.

The reset-after-fw-crash was indeed added later. I am wondering is we 
can leave the remove-reprobe dance to the mmc core. Maybe mmc_hw_reset() 
could do the trick, ie. simply call mmc_hw_reset() in 
brcmf_sdio_bus_reset() and be done with it. Maybe opening a can of worms 
here, but I always felt uncertain about calling .remove and .probe 
callbacks directly from the driver itself as it may cause issue like 
this double-free, but also the bus is unaware and I don't know that is a 
bad thing or not.

Regards,
Arend

 >>
 >> Also I forgot that our IT attached a legal footer to all emails sent 
to an external party. I am sorry about that to anyone reading my mail 
but there is nothing I can do at the moment.
 >>
 >> Thanks,
 >> - Franky
 >
 > I have attached the updated patch. As mentioned before, I will be 
running the changes myself.
 >
 > Regards,
 > Danny
 >
 >
 >
 >>> So, returning immediately with the errorcode seemed more 
appropriate. Regardless, I have only
 >>> incidental knowledge from checking the code just for this 
particular problem. In the end my goal
 >>> is to have the issues addressed so that I am not forced to reboot 
my system to get it back in
 >>> working order.
 >>>
 >>> As for your remark about sg-table: I had not considered that, but 
if my notes above check out,
 >>> maybe this does not need to be treated conditionally at all.
 >>>
 >>> Kind regards,
 >>> Danny
 >>>
 >>>> diff --git 
a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c 
b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
 >>>> index ac02244a6fdf..e9bad7197ba9 100644
 >>>> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
 >>>> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
 >>>> @@ -802,6 +802,7 @@ static void brcmf_sdiod_freezer_detach(struct 
brcmf_sdio_dev *sdiodev)
 >>>> if (sdiodev->freezer) {
 >>>>
 >>>> WARN_ON(atomic_read(&sdiodev->freezer->freezing));
 >>>>
 >>>> kfree(sdiodev->freezer);
 >>>>
 >>>> + sdiodev->freezer = NULL;
 >>>>
 >>>> }
 >>>> }
 >>>>
 >>>> @@ -885,7 +886,11 @@ int brcmf_sdiod_remove(struct brcmf_sdio_dev 
*sdiodev)
 >>>> sdio_disable_func(sdiodev->func1);
 >>>>
 >>>> sdio_release_host(sdiodev->func1);
 >>>>
 >>>> - sg_free_table(&sdiodev->sgtable);
 >>>>
 >>>> + if (sdiodev->sgtable) {
 >>>>
 >>>> + sg_free_table(&sdiodev->sgtable);
 >>>>
 >>>> + sdiodev->sgtable = NULL;
 >>>>
 >>>> + }
 >>>> +
 >>>> sdiodev->sbwad = 0;
 >>>>
 >>>> pm_runtime_allow(sdiodev->func1->card->host->parent);
 >>>>
 >>>> As for submitting patch to linux-wireless, please follow the 
guideline. [1]
 >>>>
 >>>> Thanks,
 >>>> - Franky
 >>>>
 >>>> [1] 
https://www.google.com/url?q=https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches&source=gmail-imap&ust=1654959604000000&usg=AOvVaw1Q6aXVZjiKkrq9qmyYVVDa
 >>
 >>
 >>
 >>
 >>
 >> --
 >> This electronic communication and the information and any files 
transmitted
 >> with it, or attached to it, are confidential and are intended solely for
 >> the use of the individual or entity to whom it is addressed and may 
contain
 >> information that is confidential, legally privileged, protected by 
privacy
 >> laws, or otherwise restricted from disclosure to anyone else. If you are
 >> not the intended recipient or the person responsible for delivering the
 >> e-mail to the intended recipient, you are hereby notified that any use,
 >> copying, distributing, dissemination, forwarding, printing, or 
copying of
 >> this e-mail is strictly prohibited. If you received this e-mail in 
error,
 >> please return the e-mail to the sender, delete it from your 
computer, and
 >> destroy any printed copy of it.

--000000000000ffd14105e0e0329e
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
h9J/RI6gsHbuMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCDAmhjt6pYNMllTHx03
3a4HqMBP9k4aa709GrRiA2m27zAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJ
BTEPFw0yMjA2MDcxOTAwMTZaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFl
AwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzAL
BglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEApJ9PHwmDu4fJFYKoiyhUDeorl62znEsPi+SX
IVP0Vi+9Y1y3yf9t3qyCLxcp4dK7nXtgGL5XIAagfd+ENoV1rcDzbgOMF+ctH38sIl/n0w6IIbOx
2oKkx8GMFFF6i+kbQYvdXDvHKZUFWSaowFiK3LbNVuGXkAWO3T1/Ob9uTSMIHb2BOY+EjYiB0esu
QCOuh5YpfADbCPGGLBnG7DJdrHwDX9Q8oSCxj0h3JuyeMqBVhMdvmsu5kJZqgRV/RTvuLTvNjol1
JQofge14IVcRcp0xiJ2kR0OKV3S6/K9qQdMSIYPbqAP/yvXfaP7MYsIgwvJNyh/IhluBVmpg1/GJ
fA==
--000000000000ffd14105e0e0329e--
