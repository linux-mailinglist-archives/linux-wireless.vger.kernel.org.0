Return-Path: <linux-wireless+bounces-1821-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B0E582C377
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jan 2024 17:20:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25D4C1F22EC9
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jan 2024 16:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D72E745C8;
	Fri, 12 Jan 2024 16:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="hdSGdPOc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E9D73198
	for <linux-wireless@vger.kernel.org>; Fri, 12 Jan 2024 16:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40e5f746ac4so23565965e9.1
        for <linux-wireless@vger.kernel.org>; Fri, 12 Jan 2024 08:20:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1705076417; x=1705681217; darn=vger.kernel.org;
        h=mime-version:subject:user-agent:references:in-reply-to:message-id
         :date:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FY+BiN+cbH/kD9/6L5ZaKTmMlFc7BT5FGU+dWUj/bjg=;
        b=hdSGdPOcA1+ibBOSM3BeSG6aywKFvgQS3m5P3U0vjILBLmxXS77f3I8vJDH4nBZKVE
         MjwrCFaJLzNUWFBVA/bgxGkjAedV/TQlSwZYVbY0r2VM07AB7G3J0hC1vkBtvrqSCUjt
         5rFxwsNpeD0Y+NAPjndhUxZ1wPmDo+QUO8iJo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705076417; x=1705681217;
        h=mime-version:subject:user-agent:references:in-reply-to:message-id
         :date:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FY+BiN+cbH/kD9/6L5ZaKTmMlFc7BT5FGU+dWUj/bjg=;
        b=mtJOhQkjbCvi2Bc2n7YdIKVmJOrbZPS42ruMnt9H1ZuHP8pxXdEiEug5VEkZ18RqGA
         3RjOjhF+lhYBubDO1eAJw7N3IXeuFPPaH2a14L5FREC6hRjCpeX0ufKeXxBNpaqmyLOi
         BcSoz6jCf5H8IOjtt7MqoJF9Q11Hq8t7LaBsqk51qVPFpwZ1pcqoQtyY7cqu9xCq51dt
         sAVv6pEa6C9H5UI91cX6tvtFkGu2cdRi3B/lncoSGdem1tGF7bCInP2dLNvnuXecNVj5
         s8ybcKOAHOEL3g+JaTGrzYs2XeMHuvOtZpLp3oE7uILFiiKU/WIUpuH5x23ZE5KxupF5
         ZeKQ==
X-Gm-Message-State: AOJu0YwWgcvXhF/jyIF+504OD07StIVtUZIGG5DSFvQacfrFUGwjVCxE
	vxeKLLpb3LuD5QbxajPUL2OFB0UHDbjw0LNQR6pwf7Xwsh1e
X-Google-Smtp-Source: AGHT+IFFyPCKk3tINwcUTqKdlk1HyL+y+aaVsk+fWMFZBKtKyouAbFU4gQiJ39VfMZTi4QUZtc+Ilg==
X-Received: by 2002:a05:600c:314c:b0:40e:45be:3a44 with SMTP id h12-20020a05600c314c00b0040e45be3a44mr941741wmo.141.1705076417634;
        Fri, 12 Jan 2024 08:20:17 -0800 (PST)
Received: from [10.230.43.52] ([192.19.152.250])
        by smtp.gmail.com with ESMTPSA id t18-20020a05600c199200b0040e5951f199sm6144251wmq.34.2024.01.12.08.20.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Jan 2024 08:20:17 -0800 (PST)
From: Arend Van Spriel <arend.vanspriel@broadcom.com>
To: Marcel Ziswiler <marcel.ziswiler@toradex.com>, <linux-wireless@vger.kernel.org>
CC: <andy@warmcat.com>, <angus@akkea.ca>, <franky.lin@broadcom.com>, <wiagn233@outlook.com>
Date: Fri, 12 Jan 2024 17:20:16 +0100
Message-ID: <18cfe795e00.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <18cfdd438a8.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
References: <c7b331edd65b66521a6605177d654e55051568a3.camel@toradex.com>
 <18cfdbb0388.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <0af8657d5aebf3ecf3d256606b2d8139acb9e0dc.camel@toradex.com>
 <18cfdd438a8.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
User-Agent: AquaMail/1.49.1 (build: 104901407)
Subject: Re: SparkLAN WNFB-265AXI (AP6275P) / bcm43752 pcie on mainline brcmfmac
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000003550eb060ec20a68"

--0000000000003550eb060ec20a68
Content-Type: text/plain; format=flowed; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On January 12, 2024 2:19:54 PM Arend Van Spriel 
<arend.vanspriel@broadcom.com> wrote:

> On January 12, 2024 1:59:47 PM Marcel Ziswiler
> <marcel.ziswiler@toradex.com> wrote:
>
>> Hi Arend
>>
>> On Fri, 2024-01-12 at 13:52 +0100, Arend Van Spriel wrote:
>>> On January 12, 2024 11:46:41 AM Marcel Ziswiler
>>> <marcel.ziswiler@toradex.com> wrote:
>>>
>>>> Hi guys
>>>>
>>>> I stumbled over this thread from a little over a year ago [1].
>>>>
>>>> I lately tried my take at this, however, initially even on latest
>>>> linux-next it did not even recognise my card.
>>>>
>>>> 0000:01:00.0 Network controller: Broadcom Inc. and subsidiaries Device 449d
>>>> (rev 02)
>>>>
>>>> Once I added that PCI device ID to
>>>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c the driver at least
>>>> picked it up:
>>>>
>>>> [   27.712436] brcmfmac 0000:01:00.0: enabling device (0000 -> 0002)
>>>> [   27.826371] brcmfmac 0000:01:00.0: brcmf_pcie_probe: failed to parse OTP
>>>> [   27.833126] brcmfmac: brcmf_pcie_probe: failed 14e4:449d
>>>> [   27.838498] brcmfmac: probe of 0000:01:00.0 failed with error -22
>>>>
>>>> Looks like it needs more information but I am unsure to what exactly to add
>>>> where. Last I got the following
>>>> (git diff at the very end):
>>>>
>>>> [  412.947747] brcmfmac 0000:01:00.0: enabling device (0000 -> 0002)
>>>> [  413.059831] brcmfmac: brcmf_fw_alloc_request: using
>>>> brcm/brcmfmac43752-pcie for chip BCM43752/2
>>>> [  413.096587] brcmfmac 0000:01:00.0: Direct firmware load for
>>>> brcm/brcmfmac43752-pcie.txcap_blob failed with
>>>> error -2
>>>> [  419.211343] brcmfmac 0000:01:00.0: brcmf_pcie_download_fw_nvram: FW
>>>> failed to initialize
>>>> [  419.219481] brcmfmac 0000:01:00.0: brcmf_pcie_setup: Dongle setup failed
>>>> [  419.226214] ieee80211 phy0: brcmf_fw_crashed: Firmware has halted or crashed
>>>>
>>>> Not sure what exact firmware I would need to use. From SparkLAN I got the
>>>> following:
>>>>
>>>> Archive:  FW_AP6275P_101_v2.zip
>>>> Length      Date    Time    Name
>>>> ---------  ---------- -----   ----
>>>> 80602  07-01-2021 15:01   FW_AP6275P_101_v2/BCM4362A2_001.003.006.1012.1017.hcd
>>>> 30993  11-12-2021 20:16   FW_AP6275P_101_v2/clm_bcm43752a2_pcie_ag.blob
>>>> 936074  07-13-2022 14:28   FW_AP6275P_101_v2/fw_bcm43752a2_pcie_ag.bin
>>>> 7458  01-10-2022 12:11   FW_AP6275P_101_v2/nvram_ap6275p.txt
>>>> 7808  08-30-2022 15:53   FW_AP6275P_101_v2/nvram_ap6275p_m2.txt
>>>> 8576  02-25-2021 14:51   FW_AP6275P_101_v2/nvram_ap6275p_mp.txt
>>>> 673  04-21-2023 16:32   FW_AP6275P_101_v2/ReadMe.txt
>>>> ---------                     -------
>>>> 1072184                     7 files
>>>>
>>>> Did anybody ever progress on getting this to work?
>>>>
>>>> Any help would be much appreciated.
>>>
>>> I assume you use the .bin and .blob already. Which n ram you need I don't
>>> know. Does the ReadMe have any clues on that?
>>
>> Yes, sorry, it does indeed:
>>
>> NVRAM file
>> --------------------------------------------
>> WPEB-265AXI(BT)   - use nvram_ap6575p_mp.txt
>> WNFB-265AXI(BT) - use nvram_ap6575p_m2.txt
>> AP6275P - use nvram_ap6575p.txt
>>
>>> Cypress/Infineon added 43752 SDIO support so I am not sure if your patch is
>>> correct in marking it as WCC chip.
>>
>> I am also not sure. I thought it was owned by Synaptics now.
>>
>>> Can you run strings command on firmware
>>> file, ie.:
>>>
>>> # strings fw.bin | tail -5
>>
>> ⬢[zim@toolbox FW_AP6275P_101_v2]$ strings fw_bcm43752a2_pcie_ag.bin | tail -5
>> 7.K^
>> @% ,
>> @%",
>> <UCODE-TAG>path=.../dot11_firmware/branches/BCM4362_LEM35RC387_1440_17800@40298
>> major=1440 minor=17800
>> diff_ct=0 prebuilt=0
>> <FW-TAG>4362a2-roml/config_pcie_ampak_release_he Version=18.35.387.23.146
>> (g412cc5ec) Date=2022-07-12T10:55:29Z
>> FWID=01-93c53be6
>
> The git hash is my only clue, but looks to be Synaptics indeed.
>
>>
>>> Also let's try to enable some debug levels. Can you enable CONFIG_BRCMDBG
>>> and rebuild the driver?
>>
>> Yes, let me try that and get back to you.
>>
>>> Then load the driver module with debug parameter set to 0x1c1416.
>>
>> Okay.
>>
>>> Regards,
>>> Arend
>>
>> Cheers
>
> I refreshed my memory reading the email conversation you referred to. What
> got things going was sending a seed to firmware after download. That is in
> the driver [1] but it's only done when otp is valid.
>
> Maybe you can hack it to be unconditional and see where it gets you.

The remaining issue was related to scanning:

    5.083312] brcmfmac: brcmf_escan_prep ### List of SSIDs to scan ### 1
[ 5.083313] brcmfmac: brcmf_escan_prep 0: Broadcast scan
[ 5.083314] brcmfmac: brcmf_fil_iovar_data_set ifidx=0, name=escan,
len=180
[ 5.083722] brcmfmac: brcmf_fil_cmd_data Firmware error: BCME_VERSION
(-37)

However, I think the driver has that covered now.

Regards,
Arend

>
> Regards,
> Arend
>
> [1]
> https://elixir.bootlin.com/linux/latest/source/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c#L1714
>
>>
>>
>> Marcel
>>
>>> Thanks!
>>>>
>>>> [1]
>>>> https://lore.kernel.org/all/2db80338-c92d-b006-c281-dab943029168@warmcat.com/T
>>>>
>>>> Cheers
>>>>
>>>> Marcel
>>>>
>>>> ---
>>>>
>>>> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
>>>> b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
>>>> index 80220685f5e4..b596762a1cd2 100644
>>>> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
>>>> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
>>>> @@ -66,6 +66,7 @@ BRCMF_FW_DEF(4365C, "brcmfmac4365c-pcie");
>>>> BRCMF_FW_DEF(4366B, "brcmfmac4366b-pcie");
>>>> BRCMF_FW_DEF(4366C, "brcmfmac4366c-pcie");
>>>> BRCMF_FW_DEF(4371, "brcmfmac4371-pcie");
>>>> +BRCMF_FW_CLM_DEF(43752, "brcmfmac43752-pcie");
>>>> BRCMF_FW_CLM_DEF(4377B3, "brcmfmac4377b3-pcie");
>>>> BRCMF_FW_CLM_DEF(4378B1, "brcmfmac4378b1-pcie");
>>>> BRCMF_FW_CLM_DEF(4378B3, "brcmfmac4378b3-pcie");
>>>> @@ -104,6 +105,7 @@ static const struct brcmf_firmware_mapping
>>>> brcmf_pcie_fwnames[] = {
>>>> BRCMF_FW_ENTRY(BRCM_CC_43664_CHIP_ID, 0xFFFFFFF0, 4366C),
>>>> BRCMF_FW_ENTRY(BRCM_CC_43666_CHIP_ID, 0xFFFFFFF0, 4366C),
>>>> BRCMF_FW_ENTRY(BRCM_CC_4371_CHIP_ID, 0xFFFFFFFF, 4371),
>>>> + BRCMF_FW_ENTRY(BRCM_CC_43752_CHIP_ID, 0xFFFFFFFF, 43752),
>>>> BRCMF_FW_ENTRY(BRCM_CC_4377_CHIP_ID, 0xFFFFFFFF, 4377B3), /* revision ID 4 */
>>>> BRCMF_FW_ENTRY(BRCM_CC_4378_CHIP_ID, 0x0000000F, 4378B1), /* revision ID 3 */
>>>> BRCMF_FW_ENTRY(BRCM_CC_4378_CHIP_ID, 0xFFFFFFE0, 4378B3), /* revision ID 5 */
>>>> @@ -2062,6 +2064,8 @@ static int brcmf_pcie_read_otp(struct
>>>> brcmf_pciedev_info *devinfo)
>>>> words = 0x170;
>>>> break;
>>>> case BRCM_CC_4387_CHIP_ID:
>>>> +//brcmf_pcie_probe: failed to parse OTP
>>>> +// case BRCM_CC_43752_CHIP_ID:
>>>> coreid = BCMA_CORE_GCI;
>>>> base = 0x113c;
>>>> words = 0x170;
>>>> @@ -2694,6 +2698,7 @@ static const struct pci_device_id
>>>> brcmf_pcie_devid_table[] = {
>>>> BRCMF_PCIE_DEVICE(BRCM_PCIE_4366_2G_DEVICE_ID, BCA),
>>>> BRCMF_PCIE_DEVICE(BRCM_PCIE_4366_5G_DEVICE_ID, BCA),
>>>> BRCMF_PCIE_DEVICE(BRCM_PCIE_4371_DEVICE_ID, WCC),
>>>> + BRCMF_PCIE_DEVICE(BRCM_PCIE_43752_DEVICE_ID, WCC),
>>>> BRCMF_PCIE_DEVICE(BRCM_PCIE_43596_DEVICE_ID, CYW),
>>>> BRCMF_PCIE_DEVICE(BRCM_PCIE_4377_DEVICE_ID, WCC),
>>>> BRCMF_PCIE_DEVICE(BRCM_PCIE_4378_DEVICE_ID, WCC),
>>>> diff --git a/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h
>>>> b/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h
>>>> index 44684bf1b9ac..b97b4c640d1b 100644
>>>> --- a/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h
>>>> +++ b/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h
>>>> @@ -59,6 +59,7 @@
>>>> #define CY_CC_43012_CHIP_ID 43012
>>>> #define CY_CC_43439_CHIP_ID 43439
>>>> #define CY_CC_43752_CHIP_ID 43752
>>>> +#define BRCM_CC_43752_CHIP_ID 43752
>>>>
>>>> /* USB Device IDs */
>>>> #define BRCM_USB_43143_DEVICE_ID 0xbd1e
>>>> @@ -93,6 +94,7 @@
>>>> #define BRCM_PCIE_4366_2G_DEVICE_ID 0x43c4
>>>> #define BRCM_PCIE_4366_5G_DEVICE_ID 0x43c5
>>>> #define BRCM_PCIE_4371_DEVICE_ID 0x440d
>>>> +#define BRCM_PCIE_43752_DEVICE_ID 0x449d
>>>> #define BRCM_PCIE_43596_DEVICE_ID 0x4415
>>>> #define BRCM_PCIE_4377_DEVICE_ID 0x4488
>>>> #define BRCM_PCIE_4378_DEVICE_ID 0x4425




--0000000000003550eb060ec20a68
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
2Gzj3QNJRLsZu1TLyOyBBIr/BE7UiY3RabgRzknBGAPmzhS+fmyM8OtM5BYBsFBrSUFtZZO2p/tf
Nbc24J2zf2peoZ8MK+7WQqummYlOnz+FyDkA9EybeNMcS5C+xi/PAgMBAAGjggHdMIIB2TAOBgNV
HQ8BAf8EBAMCBaAwgaMGCCsGAQUFBwEBBIGWMIGTME4GCCsGAQUFBzAChkJodHRwOi8vc2VjdXJl
Lmdsb2JhbHNpZ24uY29tL2NhY2VydC9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcnQwQQYI
KwYBBQUHMAGGNWh0dHA6Ly9vY3NwLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24y
Y2EyMDIwME0GA1UdIARGMEQwQgYKKwYBBAGgMgEoCjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3
dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAJBgNVHRMEAjAAMEkGA1UdHwRCMEAwPqA8oDqG
OGh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3Js
MCcGA1UdEQQgMB6BHGFyZW5kLnZhbnNwcmllbEBicm9hZGNvbS5jb20wEwYDVR0lBAwwCgYIKwYB
BQUHAwQwHwYDVR0jBBgwFoAUljPR5lgXWzR1ioFWZNW+SN6hj88wHQYDVR0OBBYEFIikAXd8CEtv
ZbDflDRnf3tuStPuMA0GCSqGSIb3DQEBCwUAA4IBAQCdS5XCYx6k2GGZui9DlFsFm75khkqAU7rT
zBX04sJU1+B1wtgmWTVIzW7ugdtDZ4gzaV0S9xRhpDErjJaltxPbCylb1DEsLj+AIvBR34caW6ZG
sQk444t0HPb29HnWYj+OllIGMbdJWr0/P95ZrKk2bP24ub3ZP/8SyzrohfIba9WZKMq6g2nTLZE3
BtkeSGJx/8dy0h8YmRn+adOrxKXHxhSL8BNn8wsmIZyYWe6fRcBtO3Ks2DOLyHCdkoFlN8x9VUQF
N2ulEgqCbRKkx+qNirW86eF138lr1gRxzclu/38ko//MmkAYR/+hP3WnBll7zbpIt0jc9wyFkSqH
p8a1MYICbTCCAmkCAQEwazBbMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1z
YTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMgUGVyc29uYWxTaWduIDIgQ0EgMjAyMAIMTv1t
bpIzNUky46LXMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCAZo5KuayIJ/MzQ7b8J
II/C7CLLJGHU3uLah2B/cuUuVTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJ
BTEPFw0yNDAxMTIxNjIwMTdaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFl
AwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzAL
BglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAsWR4Omm/yInzLIt8yitebkIiAWFNZ/AqiHrU
b61rkpZMoAqJuDPhCtUzgHvFj6tiVBibasPW/5VKAxZNUTrz/8M+L/KYE5Nfn0EglGQJg/S4ucJA
GiDne/jNGt2e2gu8e5/BLYp1fWMkqUwo2nEEEZ4yPpwsa6OlRuu8+cIQpjGi2KCBmhgUdeLSLOYP
4B3z2MH9GzJ/QrUL4xJmdM0pqZ2Rh/osJhTNWtHZ3yNWqrOZblYYeLYyL91kEiE3ntDa9K1jpoB+
iVLMs/6ll11ifph+Izt6jih1Zfa3gdQ379rAglgpcbqKSTHdVREj5VeQGga0vwanto4nvTBDhNRz
Cw==
--0000000000003550eb060ec20a68--

