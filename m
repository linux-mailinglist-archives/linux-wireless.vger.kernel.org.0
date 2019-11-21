Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E559104EA3
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Nov 2019 10:00:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726170AbfKUJAQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 21 Nov 2019 04:00:16 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34059 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726132AbfKUJAP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 21 Nov 2019 04:00:15 -0500
Received: by mail-wr1-f65.google.com with SMTP id t2so3397600wrr.1
        for <linux-wireless@vger.kernel.org>; Thu, 21 Nov 2019 01:00:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Z7WxYXT7haNhErf84Euqi8xYpKgq5Abng8o/Dc7Sg64=;
        b=EY8WpS8rLyzrEmKE1FqQ3nW6XrXh85x3GWTge7nUAPURW2HXAEvepwu3uRbBaXhHC6
         azc3oWBLIHcuCXPrOORrCQ2lcqbMHQOzf9rklujuMs/knGtr0WRNHn9H67nGj+563gST
         UqQvNoreYPdsTUYxdqoSUG5AZApKXLYhoa+cI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Z7WxYXT7haNhErf84Euqi8xYpKgq5Abng8o/Dc7Sg64=;
        b=ujPR1QgObiPQisdqsET+yfdNoIghAq4MIC7H1JYf12gUVVcpzQjDtEZ4+/1EqKyH9n
         sXcRX0/4qM3GNLZoeAZwTp/UAua9v8l3f2ns/6lVZR01cLRv0peslhZpYqX5JHWdxNiW
         fnvuW6zohuejSEsEE9rQeGgxQR1i0z6S3l7drpSVHScEJrfPljLNNmZQ6NOPEOBRCFYo
         H6Xj9nyjYrNV9ZK+9fzRNRKmAEdv/AszN9H08IxIIg4HLgU+cwDqkQDl7rEJ8QOyEDPA
         aC5Zmke1/kIb6nUIzgn/mFUOpGznQYQIgTl9b3IoiiRuBP96Y1DhkMCjAPxWd9QJaXT/
         6jlA==
X-Gm-Message-State: APjAAAVpsnaPwcM6+xdyvWMAZpCHwqMFGq2vaAbQ2dbT5J2ApGEZqW6S
        PjOH+9dgKHiMdUjR06jiaONWIQ==
X-Google-Smtp-Source: APXvYqx9e9vIVVl/ig2c/BLdlEU7NqAlBRyMKeqK44yAKiyApLq6MQcfroTlqsCx859aBablmlhW5Q==
X-Received: by 2002:adf:e40e:: with SMTP id g14mr9551138wrm.264.1574326811155;
        Thu, 21 Nov 2019 01:00:11 -0800 (PST)
Received: from [10.176.68.244] ([192.19.248.250])
        by smtp.gmail.com with ESMTPSA id 188sm2171233wmz.13.2019.11.21.01.00.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Nov 2019 01:00:10 -0800 (PST)
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
From:   Arend Van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <cf2d4640-21b0-dc95-6f67-8c3639e6d8b3@broadcom.com>
Date:   Thu, 21 Nov 2019 10:00:09 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <8CDC4B4E-D131-4590-9A63-DDD87FAE1D79@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



On 11/21/2019 4:52 AM, Christian Hewitt wrote:
> 
>> On 24 Jun 2019, at 11:04 pm, Arend Van Spriel <arend.vanspriel@broadcom.com> wrote:
>>
>> Hi Christian,
>>
>> Here it is. Hopefully unmangled this time.
>>
>> Regards,
>> Arend
>> ---
>> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
>> index ec129864cc9c..7be8064c6dc7 100644
>> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
>> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
>> @@ -785,7 +785,8 @@ void brcmf_sdiod_sgtable_alloc(struct brcmf_sdio_dev *sdiodev)
>>                       sdiodev->settings->bus.sdio.txglomsz);
>>         nents += (nents >> 4) + 1;
>>
>> -       WARN_ON(nents > sdiodev->max_segment_count);
>> +       WARN(nents > sdiodev->max_segment_count, "max_seg_cnt=%u, host_max_seg=%u, nents=%u\n",
>> +                sdiodev->max_segment_count, host->max_segs, nents);
>>
>>         brcmf_dbg(TRACE, "nents=%d\n", nents);
>>         err = sg_alloc_table(&sdiodev->sgtable, nents, GFP_KERNEL);
> 
> Hello Arend,
> 
> I’ve resumed testing on 5.4-rc8 with ^ this patch and https://github.com/chewitt/linux/commit/07fd0f25ceb72b15aa8c3fbd149aa41cbc55d035 applied and brcmfmac.debug=30 in boot params. Here is more extended output:
> 
> [    6.115132] brcmfmac: brcmfmac_module_init No platform data available.
> [    6.116841] brcmfmac: brcmf_sdio_probe Enter
> [    6.118695] brcmfmac: F1 signature read @0x18000000=0x17294359
> [    6.118910] brcmfmac: brcmf_chip_recognition found AXI chip: BCM4359/9
> [    6.120687] brcmfmac: brcmf_chip_cores_check  [1 ] core 0x800:52 base 0x18000000 wrap 0x18100000
> [    6.120692] brcmfmac: brcmf_chip_cores_check  [2 ] core 0x812:59 base 0x18001000 wrap 0x18101000
> [    6.120695] brcmfmac: brcmf_chip_cores_check  [3 ] core 0x83e:8  base 0x18002000 wrap 0x18102000
> [    6.120697] brcmfmac: brcmf_chip_cores_check  [4 ] core 0x83c:21 base 0x18003000 wrap 0x18103000
> [    6.120698] brcmfmac: brcmf_chip_cores_check  [5 ] core 0x812:59 base 0x18004000 wrap 0x18104000
> [    6.120700] brcmfmac: brcmf_chip_cores_check  [6 ] core 0x829:22 base 0x18005000 wrap 0x18105000
> [    6.120702] brcmfmac: brcmf_chip_cores_check  [7 ] core 0x840:5  base 0x1800a000 wrap 0x00000000
> [    6.120703] brcmfmac: brcmf_chip_cores_check  [8 ] core 0x135:0  base 0x00000000 wrap 0x18109000
> [    6.120704] brcmfmac: brcmf_chip_cores_check  [9 ] core 0x240:0  base 0x00000000 wrap 0x00000000
> [    6.120706] brcmfmac: brcmf_chip_set_passive Enter
> [    6.121378] brcmfmac: brcmf_chip_get_raminfo RAM: base=0x180000 size=917504 (0xe0000) sr=0 (0x0)
> [    6.121438] brcmfmac: brcmf_chip_setup ccrev=52, pmurev=26, pmucaps=0x3a0c3f1a
> [    6.121441] brcmfmac: brcmf_get_module_param Enter, bus=0, chip=17241, rev=9
> [    6.121618] brcmfmac: brcmf_sdiod_sgtable_alloc nents=35
> [    6.121621] brcmfmac: brcmf_sdio_kso_init Enter
> [    6.121635] brcmfmac: brcmf_sdio_drivestrengthinit No SDIO driver strength init needed for chip BCM4359/9 rev 9 pmurev 26
> [    6.121998] brcmfmac: brcmf_sdio_probe completed!!
> [    6.122003] brcmfmac: brcmf_fw_alloc_request: using brcm/brcmfmac4359-sdio for chip BCM4359/9
> [    6.122008] brcmfmac: brcmf_fw_get_firmwares enter: dev=mmc0:0001:1
> [    6.293561] brcmfmac: brcmf_fw_complete_request firmware brcm/brcmfmac4359-sdio.bin found
> [    6.309769] brcmfmac: brcmf_fw_complete_request firmware brcm/brcmfmac4359-sdio.txt found
> [    6.309772] brcmfmac: brcmf_fw_request_nvram_done enter: dev=mmc0:0001:1
> [    6.309840] brcmfmac: brcmf_fw_request_nvram_done nvram 000000007040259b len 3564
> [    6.309843] brcmfmac: brcmf_sdio_firmware_callback Enter: dev=mmc0:0001:1, err=0
> [    8.206959] brcmfmac: brcmf_sdio_download_code_file Enter
> [    8.272184] brcmfmac: brcmf_sdio_verifymemory Compare RAM dl & ul at 0x00180000; size=636647
> [    8.354229] brcmfmac: brcmf_sdio_download_nvram Enter
> [    8.359730] brcmfmac: brcmf_sdio_verifymemory Compare RAM dl & ul at 0x0025f214; size=3564
> [    8.367550] brcmfmac: brcmf_sdiod_ramrw: membytes transfer failed
> [    8.373550] brcmfmac: brcmf_sdio_verifymemory: error -84 on reading 2048 membytes at 0x0025f214
> [    8.382188] brcmfmac: brcmf_sdio_download_firmware: dongle nvram file download failed
> [    8.389982] brcmfmac: brcmf_sdio_firmware_callback failed: dev=mmc0:0001:1, err=-5
> [    8.397514] brcmfmac: brcmf_sdio_remove Enter
> [    8.402641] brcmfmac: brcmf_detach Enter
> [    8.434899] brcmfmac: brcmf_chip_set_passive Enter
> [    8.458772] brcmfmac: brcmf_sdio_remove Disconnected
> 
> I’m using renamed nvram.txt and fw_bcm4359c0_ag_apsta.bin from the bcmdhd.1.579.77.41.x driver (https://github.com/chewitt/bcmdhd/). In the full dmesg: https://pastebin.com/raw/DUUGSjWw there is some kernel splat starting 6.121488 that appears to be from probing. FWIW, the BT side of the device appears to be working fine.
> 
> Any suggestions?

This is a differing issue, right? Sorry it has been a while back and I 
did not search for your earlier emails.

The error -84 is -EILSEQ which we get from SDIO layer. I think this is 
returned when CRC errors occur on the SDIO bus. It would trigger a 
retune in the host controller.

Were you seeing similar issues on earlier kernel?

Regards,
Arend
