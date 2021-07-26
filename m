Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70E8A3D54AD
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Jul 2021 09:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231874AbhGZHNm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 26 Jul 2021 03:13:42 -0400
Received: from lpdvsmtp10.broadcom.com ([192.19.11.229]:54854 "EHLO
        relay.smtp-ext.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231725AbhGZHNl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 26 Jul 2021 03:13:41 -0400
Received: from bld-lvn-bcawlan-34.lvn.broadcom.net (bld-lvn-bcawlan-34.lvn.broadcom.net [10.75.138.137])
        by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id F1ABEA5;
        Mon, 26 Jul 2021 00:54:09 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com F1ABEA5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1627286050;
        bh=HJ5nsDnJITC00V1X0DUyUcupZe7VHTkb2LGU3xhIHh8=;
        h=Subject:To:References:Cc:From:Date:In-Reply-To:From;
        b=BFgi1UNCh9177dcZcO1VT9ITEi4Em/NKQzvCiO/JQeyGOYwExTMbBdcQu3OVEnt9p
         UJHWSbU7UXMHF2jUn02jn7o/GqCd+wM3c9zRj50ap77oRwDFOP1TSlzy3OdTF6MCtR
         iO4uBjIkpsYi5+SGEFQxdiXap3o70lNLDY7Lez3c=
Received: from [10.176.68.80] (unknown [10.176.68.80])
        by bld-lvn-bcawlan-34.lvn.broadcom.net (Postfix) with ESMTPSA id 1E4C91874BD;
        Mon, 26 Jul 2021 00:54:08 -0700 (PDT)
Subject: Re: Current mainline brcmfmac reports error on supposedly supported
 ap6256 chip
To:     Piotr Oniszczuk <piotr.oniszczuk@gmail.com>
References: <CB0AA0D2-A8F3-4217-A3C1-E14D7E9FF11E@gmail.com>
 <17ad94781a0.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <6F6333F3-0BDB-48AF-B445-723958ABA8C9@gmail.com>
 <be6c2b7f-2c85-59fb-3013-d0590c487c51@broadcom.com>
 <53E7119F-D158-4EF0-940C-D0AA59C23CF6@gmail.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Ondrej Jirman <megous@megous.com>
From:   Arend van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <3da7f271-0c5c-50de-375a-a8c67ca127f5@broadcom.com>
Date:   Mon, 26 Jul 2021 09:54:07 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <53E7119F-D158-4EF0-940C-D0AA59C23CF6@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

+ linux-wireless, + Ondrej (who added support for 4345 rev 9)

On 7/25/2021 12:16 AM, Piotr Oniszczuk wrote:
> 
> 
>> Wiadomość napisana przez Arend van Spriel <arend.vanspriel@broadcom.com> w dniu 24.07.2021, o godz. 23:20:
>>
>>
>> I am not so sure what is going on so maybe you can apply the patch below and see what comes out.
>>
>> Regards,
>> Arend
>>
>> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c
>> index 4faab0170ffa..71fb34753528 100644
>> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c
>> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c
>> @@ -691,9 +691,11 @@ static u32 brcmf_chip_tcm_ramsize(struct brcmf_core_priv *cr4)
>>         nbb = (corecap & ARMCR4_TCBBNB_MASK) >> ARMCR4_TCBBNB_SHIFT;
>>         totb = nab + nbb;
>>
>> +       brcmf_err("corecap %x nab %u nbb %u\n", corecap, nab, nbb);
>>         for (idx = 0; idx < totb; idx++) {
>>                 brcmf_chip_core_write32(cr4, ARMCR4_BANKIDX, idx);
>>                 bxinfo = brcmf_chip_core_read32(cr4, ARMCR4_BANKINFO);
>> +               brcmf_err("[%3u] %08x\n", idx, bxinfo);
>>                 memsize += ((bxinfo & ARMCR4_BSZ_MASK) + 1) * ARMCR4_BSZ_MULT;
>>         }
>>
>>
> 
> Arend
> 
> Pls find dmesg output with patch:
> 
> [  121.226458] brcmfmac: brcmfmac_module_init No platform data available.
> [  121.227955] brcmfmac: brcmf_sdio_probe Enter
> [  121.232119] brcmfmac: F1 signature read @0x18000000=0x15294345
> [  121.237659] brcmfmac: brcmf_chip_recognition found AXI chip: BCM4345/9
> [  121.245832] brcmfmac: brcmf_chip_cores_check  [1 ] core 0x800:51 base 0x18000000 wrap 0x18100000
> [  121.252695] brcmfmac: brcmf_chip_cores_check  [2 ] core 0x812:54 base 0x18001000 wrap 0x18101000
> [  121.261363] brcmfmac: brcmf_chip_cores_check  [3 ] core 0x83e:9  base 0x18002000 wrap 0x18102000
> [  121.270071] brcmfmac: brcmf_chip_cores_check  [4 ] core 0x83c:14 base 0x18003000 wrap 0x18103000
> [  121.278783] brcmfmac: brcmf_chip_cores_check  [5 ] core 0x829:21 base 0x18004000 wrap 0x18104000
> [  121.287508] brcmfmac: brcmf_chip_cores_check  [6 ] core 0x135:0  base 0x00000000 wrap 0x18107000
> [  121.296206] brcmfmac: brcmf_chip_cores_check  [7 ] core 0x240:0  base 0x00000000 wrap 0x00000000
> [  121.304917] brcmfmac: brcmf_chip_set_passive Enter
> [  121.312079] brcmfmac: brcmf_chip_tcm_ramsize: corecap 0 nab 0 nbb 0

Well. That explains the fact that RAM size ends up being zero. I want to 
be sure the ARM CR4 core is up so can you retry using the patch below. 
It is just getting bit more info, no fix.

Regards,
Arend

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c 
b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c
index 4faab0170ffa..b829ad2f3865 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c
@@ -691,9 +691,12 @@ static u32 brcmf_chip_tcm_ramsize(struct 
brcmf_core_priv *cr4)
         nbb = (corecap & ARMCR4_TCBBNB_MASK) >> ARMCR4_TCBBNB_SHIFT;
         totb = nab + nbb;

+       brcmf_err("up %d corecap %x nab %u nbb %u\n",
+               brcmf_chip_iscoreup(&cr4->pub), corecap, nab, nbb);
         for (idx = 0; idx < totb; idx++) {
                 brcmf_chip_core_write32(cr4, ARMCR4_BANKIDX, idx);
                 bxinfo = brcmf_chip_core_read32(cr4, ARMCR4_BANKINFO);
+               brcmf_err("[%3u] %08x\n", idx, bxinfo);
                 memsize += ((bxinfo & ARMCR4_BSZ_MASK) + 1) * 
ARMCR4_BSZ_MULT;
         }

