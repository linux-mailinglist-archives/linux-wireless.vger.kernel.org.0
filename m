Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C40F511C8D2
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Dec 2019 10:08:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728218AbfLLJIF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 12 Dec 2019 04:08:05 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40169 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726382AbfLLJIF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 12 Dec 2019 04:08:05 -0500
Received: by mail-wr1-f65.google.com with SMTP id c14so1837538wrn.7
        for <linux-wireless@vger.kernel.org>; Thu, 12 Dec 2019 01:08:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2Hu/MS9L5n4G0gw2ZH4C/VxcBKW5KE+W0/2NE1EwQR4=;
        b=J0ki0mpIANJ0DLtMSDg78/wNj2S84b8xvY5QhdQZJUoRH+UtbmniWfwfy3EQQcKshq
         xgxbzXWMCY5zZ9y04Ur4PXNjhFxG/mqUHWl+MyRnZzkjXGXcwS/xXbvtmeXwsBSEWWse
         fiaFpcq2N/I1Nx+3Z5psWpn3j63Tzv6+1st28=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2Hu/MS9L5n4G0gw2ZH4C/VxcBKW5KE+W0/2NE1EwQR4=;
        b=EiQOm5gggLE0iuP+QzMn1Fju7hKrqjzTaG/HE31jnEHdzASheD0fV74bWDyFZpaozt
         C3zGfRwCnRpY2n6eNyZ3f+3QDQJ0vmyOalHeZLNw5hoK89GSXWJTEe9iQPz/OHtLI2id
         DQGCiFFxCgos/wk1lvNvoUWiZhD+MyUQWUOgtGu3MglBp4V2EQOw85e97DvHOLrVFQn4
         IHo13zcbJcqCeu1DP3d5H8Fz4OYH2FkW4VVSrZ3WDs38TtcwbK3ZBYxyqXgpG//3obw9
         5zns0nZIPQaQiNxH3/fPxD054ARDFrWGLfU1wnXa0c6FTsX0SI05kS2CfTLHKKH6Krft
         quIA==
X-Gm-Message-State: APjAAAXjqHBcIz6kRBSSXH0eSElRwFy1ohRGL8sbKmMQg6QNSs+Q60sf
        UkLdRfZW3lwmAtS55+pmB+wemQ==
X-Google-Smtp-Source: APXvYqybizocTItIxfsOb4L9MlvTZRGFzBr4V7cMgj7X9Ao9AnDjY4lLXSSubi+CTOqpFm0JAihhtQ==
X-Received: by 2002:a5d:5307:: with SMTP id e7mr5161104wrv.146.1576141682013;
        Thu, 12 Dec 2019 01:08:02 -0800 (PST)
Received: from [10.176.68.244] ([192.19.248.250])
        by smtp.gmail.com with ESMTPSA id k13sm5421907wrx.59.2019.12.12.01.08.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Dec 2019 01:08:00 -0800 (PST)
Subject: Re: [RESEND] brcmfmac support for BCM4359 sdio on arm64 ??
To:     Christian Hewitt <christianshewitt@gmail.com>
Cc:     linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        brcm80211-dev-list@cypress.com, Wright.Feng@cypress.com,
        Neil Armstrong <narmstrong@baylibre.com>,
        Christoph Muellner <christoph.muellner@theobroma-systems.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
References: <F5C2858A-498E-4AD3-859D-FA9D14BF6B37@gmail.com>
 <37d2964d-1c2b-51bd-ac98-2cc171aa0c9c@broadcom.com>
 <30516339-BAD7-40F4-980B-D30CDF504A08@gmail.com>
 <db1e6182-d8fe-a68a-e769-b6460c68fab0@broadcom.com>
 <8CDC4B4E-D131-4590-9A63-DDD87FAE1D79@gmail.com>
 <cf2d4640-21b0-dc95-6f67-8c3639e6d8b3@broadcom.com>
 <25DA691B-1804-4801-9A3E-1F29B1AC4D13@gmail.com>
 <096CB8E8-5D24-4EEF-B283-746D6AA7C105@gmail.com>
From:   Arend Van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <36c7930b-c986-daef-6fe6-cc79117fd188@broadcom.com>
Date:   Thu, 12 Dec 2019 10:07:59 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <096CB8E8-5D24-4EEF-B283-746D6AA7C105@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 12/10/2019 3:15 PM, Christian Hewitt wrote:
> 
>> On 21 Nov 2019, at 8:01 pm, Christian Hewitt 
>> <christianshewitt@gmail.com <mailto:christianshewitt@gmail.com>> wrote:
>>>
>>> On 21 Nov 2019, at 1:00 pm, Arend Van Spriel 
>>> <arend.vanspriel@broadcom.com <mailto:arend.vanspriel@broadcom.com>> 
>>> wrote:
>>>
>>> On 11/21/2019 4:52 AM, Christian Hewitt wrote:
>>>>> On 24 Jun 2019, at 11:04 pm, Arend Van Spriel 
>>>>> <arend.vanspriel@broadcom.com 
>>>>> <mailto:arend.vanspriel@broadcom.com>> wrote:
>>>>>
>>>>> Hi Christian,
>>>>>
>>>>> Here it is. Hopefully unmangled this time.
>>>>>
>>>>> Regards,
>>>>> Arend
>>>>> ---
>>>>> diff --git 
>>>>> a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c 
>>>>> b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
>>>>> index ec129864cc9c..7be8064c6dc7 100644
>>>>> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
>>>>> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
>>>>> @@ -785,7 +785,8 @@ void brcmf_sdiod_sgtable_alloc(struct 
>>>>> brcmf_sdio_dev *sdiodev)
>>>>>                     sdiodev->settings->bus.sdio.txglomsz);
>>>>>       nents += (nents >> 4) + 1;
>>>>>
>>>>> -       WARN_ON(nents > sdiodev->max_segment_count);
>>>>> +       WARN(nents > sdiodev->max_segment_count, "max_seg_cnt=%u, 
>>>>> host_max_seg=%u, nents=%u\n",
>>>>> +                sdiodev->max_segment_count, host->max_segs, nents);
>>>>>
>>>>>       brcmf_dbg(TRACE, "nents=%d\n", nents);
>>>>>       err = sg_alloc_table(&sdiodev->sgtable, nents, GFP_KERNEL);
>>>> Hello Arend,
>>>> I’ve resumed testing on 5.4-rc8 with ^ this patch and 
>>>> https://github.com/chewitt/linux/commit/07fd0f25ceb72b15aa8c3fbd149aa41cbc55d035 
>>>> applied and brcmfmac.debug=30 in boot params. Here is more extended 
>>>> output:
>>>> [    6.115132] brcmfmac: brcmfmac_module_init No platform data 
>>>> available.
>>>> [    6.116841] brcmfmac: brcmf_sdio_probe Enter
>>>> [    6.118695] brcmfmac: F1 signature read @0x18000000=0x17294359
>>>> [    6.118910] brcmfmac: brcmf_chip_recognition found AXI chip: 
>>>> BCM4359/9
>>>> [    6.120687] brcmfmac: brcmf_chip_cores_check  [1 ] core 0x800:52 
>>>> base 0x18000000 wrap 0x18100000
>>>> [    6.120692] brcmfmac: brcmf_chip_cores_check  [2 ] core 0x812:59 
>>>> base 0x18001000 wrap 0x18101000
>>>> [    6.120695] brcmfmac: brcmf_chip_cores_check  [3 ] core 0x83e:8 
>>>>  base 0x18002000 wrap 0x18102000
>>>> [    6.120697] brcmfmac: brcmf_chip_cores_check  [4 ] core 0x83c:21 
>>>> base 0x18003000 wrap 0x18103000
>>>> [    6.120698] brcmfmac: brcmf_chip_cores_check  [5 ] core 0x812:59 
>>>> base 0x18004000 wrap 0x18104000
>>>> [    6.120700] brcmfmac: brcmf_chip_cores_check  [6 ] core 0x829:22 
>>>> base 0x18005000 wrap 0x18105000
>>>> [    6.120702] brcmfmac: brcmf_chip_cores_check  [7 ] core 0x840:5 
>>>>  base 0x1800a000 wrap 0x00000000
>>>> [    6.120703] brcmfmac: brcmf_chip_cores_check  [8 ] core 0x135:0 
>>>>  base 0x00000000 wrap 0x18109000
>>>> [    6.120704] brcmfmac: brcmf_chip_cores_check  [9 ] core 0x240:0 
>>>>  base 0x00000000 wrap 0x00000000
>>>> [    6.120706] brcmfmac: brcmf_chip_set_passive Enter
>>>> [    6.121378] brcmfmac: brcmf_chip_get_raminfo RAM: base=0x180000 
>>>> size=917504 (0xe0000) sr=0 (0x0)
>>>> [    6.121438] brcmfmac: brcmf_chip_setup ccrev=52, pmurev=26, 
>>>> pmucaps=0x3a0c3f1a
>>>> [    6.121441] brcmfmac: brcmf_get_module_param Enter, bus=0, 
>>>> chip=17241, rev=9
>>>> [    6.121618] brcmfmac: brcmf_sdiod_sgtable_alloc nents=35
>>>> [    6.121621] brcmfmac: brcmf_sdio_kso_init Enter
>>>> [    6.121635] brcmfmac: brcmf_sdio_drivestrengthinit No SDIO driver 
>>>> strength init needed for chip BCM4359/9 rev 9 pmurev 26
>>>> [    6.121998] brcmfmac: brcmf_sdio_probe completed!!
>>>> [    6.122003] brcmfmac: brcmf_fw_alloc_request: using 
>>>> brcm/brcmfmac4359-sdio for chip BCM4359/9
>>>> [    6.122008] brcmfmac: brcmf_fw_get_firmwares enter: dev=mmc0:0001:1
>>>> [    6.293561] brcmfmac: brcmf_fw_complete_request firmware 
>>>> brcm/brcmfmac4359-sdio.bin found
>>>> [    6.309769] brcmfmac: brcmf_fw_complete_request firmware 
>>>> brcm/brcmfmac4359-sdio.txt found
>>>> [    6.309772] brcmfmac: brcmf_fw_request_nvram_done enter: 
>>>> dev=mmc0:0001:1
>>>> [    6.309840] brcmfmac: brcmf_fw_request_nvram_done nvram 
>>>> 000000007040259b len 3564
>>>> [    6.309843] brcmfmac: brcmf_sdio_firmware_callback Enter: 
>>>> dev=mmc0:0001:1, err=0
>>>> [    8.206959] brcmfmac: brcmf_sdio_download_code_file Enter
>>>> [    8.272184] brcmfmac: brcmf_sdio_verifymemory Compare RAM dl & ul 
>>>> at 0x00180000; size=636647
>>>> [    8.354229] brcmfmac: brcmf_sdio_download_nvram Enter
>>>> [    8.359730] brcmfmac: brcmf_sdio_verifymemory Compare RAM dl & ul 
>>>> at 0x0025f214; size=3564
>>>> [    8.367550] brcmfmac: brcmf_sdiod_ramrw: membytes transfer failed
>>>> [    8.373550] brcmfmac: brcmf_sdio_verifymemory: error -84 on 
>>>> reading 2048 membytes at 0x0025f214
>>>> [    8.382188] brcmfmac: brcmf_sdio_download_firmware: dongle nvram 
>>>> file download failed
>>>> [    8.389982] brcmfmac: brcmf_sdio_firmware_callback failed: 
>>>> dev=mmc0:0001:1, err=-5
>>>> [    8.397514] brcmfmac: brcmf_sdio_remove Enter
>>>> [    8.402641] brcmfmac: brcmf_detach Enter
>>>> [    8.434899] brcmfmac: brcmf_chip_set_passive Enter
>>>> [    8.458772] brcmfmac: brcmf_sdio_remove Disconnected
>>>> I’m using renamed nvram.txt and fw_bcm4359c0_ag_apsta.bin from the 
>>>> bcmdhd.1.579.77.41.x driver (https://github.com/chewitt/bcmdhd/). In 
>>>> the full dmesg: https://pastebin.com/raw/DUUGSjWw there is some 
>>>> kernel splat starting 6.121488 that appears to be from probing. 
>>>> FWIW, the BT side of the device appears to be working fine.
>>>> Any suggestions?
>>>
>>> This is a differing issue, right? Sorry it has been a while back and 
>>> I did not search for your earlier emails.
>>>
>>> The error -84 is -EILSEQ which we get from SDIO layer. I think this 
>>> is returned when CRC errors occur on the SDIO bus. It would trigger a 
>>> retune in the host controller.
>>>
>>> Were you seeing similar issues on earlier kernel?
>>
>> BCM4359 has mainline support for some time as a PCIe device. I’m 
>> attempting SDIO support by patching ID’s to the usual places.
>>
>> I’ve seen the probing kernel splat on probing on all kernels I’ve 
>> attempted to use. I’ve been attempting since ~4.19.
>>
>> I’m testing with a selection of Amlogic boards/boxes covering 
>> Amlogic’s GXM, G12A, G12B and SM1 platforms. The G12*/SM1 boards are 
>> based on the OEM vendor reference design with relatively minor 
>> variations between them. I have G12B boxes (same base platform) that 
>> work fine with other Ampak modules. I have devices of all varieties 
>> that have the same Ampak ap6398s module. In all cases the BT side 
>> works fine, but the WiFi shows the errors ^ above.
>>
>> I don’t see any special handling for the BCM4359 in the bcmdhd code, 
>> but it appears to be grouped alongside 4349/4355 chips:
>>
>> https://github.com/chewitt/bcmdhd/blob/f7009015df77fdeb35f9c7d6925f83861acc54f3/include/sbchipc.h#L3989
>>
>> None of those chips appear in current mainline code under the SDIO 
>> path (4355 shows under PCIe) so my guess is that it’s not CRC errors, 
>> but these chips need a slightly different firmware loading process. I 
>> don’t see any special ifdef/handling for BCM4359 in the bcmdhd code, 
>> but then I’m not a coding developer so my ability to read and 
>> understand the code is limited.
>>
>> Recent-ish bcmdhd code is known/working on the same hardware with 
>> minor nip/tuck changes:
>>
>> https://gitlab.com/baylibre/amlogic/atv/linux/commits/narmstrong/v5.1/aml/integ-5.1-bcmdhd
> 
> Arend, is there any more input/context I can provide?
> 
> If it would help to have hardware with this chipset to explore what’s 
> needed, it can be easily arranged.

Hi Christian,

I noticed some upstream patches for 4359 sdio from Cypress couple of 
days ago. Here is one of the patches from v2 series: 
https://patchwork.kernel.org/patch/11286555/

Regards,
Arend
