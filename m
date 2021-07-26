Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A91B3D56CA
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Jul 2021 11:45:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232897AbhGZJFS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 26 Jul 2021 05:05:18 -0400
Received: from lpdvacalvio01.broadcom.com ([192.19.166.228]:40456 "EHLO
        relay.smtp-ext.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232838AbhGZJFR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 26 Jul 2021 05:05:17 -0400
X-Greylist: delayed 467 seconds by postgrey-1.27 at vger.kernel.org; Mon, 26 Jul 2021 05:05:17 EDT
Received: from bld-lvn-bcawlan-34.lvn.broadcom.net (bld-lvn-bcawlan-34.lvn.broadcom.net [10.75.138.137])
        by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 49FC27FF8;
        Mon, 26 Jul 2021 02:39:33 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 49FC27FF8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1627292373;
        bh=uhImgPTOoCBlIqAYAqJm1Dg9iHJaY4RCDYfQVv680u0=;
        h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
        b=TqYr8YMYCwtOKiT7ZmDyJlww7NN0h1rVAQeNwLtum68YT1HFoVbL0gPgwfLF2igvR
         6euZbKaJ0Ft+4WfGlkqJUF592duyzCYixYw3waBrP4d7TOBiXdhQ/hzvZfH6BAuJ9M
         3VJMcwv4KqhnyoFmAT8AtQQhhjMBpp45ehD9p7EU=
Received: from [10.176.68.80] (39y1yf2.dhcp.broadcom.net [10.176.68.80])
        by bld-lvn-bcawlan-34.lvn.broadcom.net (Postfix) with ESMTPSA id 9B55F1874BD;
        Mon, 26 Jul 2021 02:39:32 -0700 (PDT)
Subject: Re: Current mainline brcmfmac reports error on supposedly supported
 ap6256 chip
From:   Arend van Spriel <arend.vanspriel@broadcom.com>
To:     Piotr Oniszczuk <piotr.oniszczuk@gmail.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Ondrej Jirman <megous@megous.com>
References: <CB0AA0D2-A8F3-4217-A3C1-E14D7E9FF11E@gmail.com>
 <17ad94781a0.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <6F6333F3-0BDB-48AF-B445-723958ABA8C9@gmail.com>
 <be6c2b7f-2c85-59fb-3013-d0590c487c51@broadcom.com>
 <53E7119F-D158-4EF0-940C-D0AA59C23CF6@gmail.com>
 <3da7f271-0c5c-50de-375a-a8c67ca127f5@broadcom.com>
 <286E2774-FAA5-47E3-A1FC-FDB09EB37FDC@gmail.com>
 <1a5588e2-38fc-1ec2-580a-30ae03ee73e1@broadcom.com>
Message-ID: <28fdbe0c-023d-82a3-877b-7b158b109e52@broadcom.com>
Date:   Mon, 26 Jul 2021 11:39:31 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1a5588e2-38fc-1ec2-580a-30ae03ee73e1@broadcom.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 7/26/2021 11:37 AM, Arend van Spriel wrote:
> + linux-wireless, + Ondrej
> 
> Hoi Piotr,
> 
> Please reply to all. This might interest others with a similar device.
> 
> On 7/26/2021 11:31 AM, Piotr Oniszczuk wrote:
>> Arend,
>>
>> pls find dmesg with extra prints you proposed:
>>
>> [  144.634234] brcmfmac: brcmfmac_module_init No platform data available.
>> [  144.638974] brcmfmac: brcmf_sdio_probe Enter
>> [  144.643057] brcmfmac: F1 signature read @0x18000000=0x15294345
>> [  144.648718] brcmfmac: brcmf_chip_recognition found AXI chip: BCM4345/9
>> [  144.656662] brcmfmac: brcmf_chip_cores_check  [1 ] core 0x800:51 
>> base 0x18000000 wrap 0x18100000
>> [  144.663690] brcmfmac: brcmf_chip_cores_check  [2 ] core 0x812:54 
>> base 0x18001000 wrap 0x18101000
>> [  144.672346] brcmfmac: brcmf_chip_cores_check  [3 ] core 0x83e:9  
>> base 0x18002000 wrap 0x18102000
>> [  144.681031] brcmfmac: brcmf_chip_cores_check  [4 ] core 0x83c:14 
>> base 0x18003000 wrap 0x18103000
>> [  144.689683] brcmfmac: brcmf_chip_cores_check  [5 ] core 0x829:21 
>> base 0x18004000 wrap 0x18104000
>> [  144.698365] brcmfmac: brcmf_chip_cores_check  [6 ] core 0x135:0  
>> base 0x00000000 wrap 0x18107000
>> [  144.707019] brcmfmac: brcmf_chip_cores_check  [7 ] core 0x240:0  
>> base 0x00000000 wrap 0x00000000
>> [  144.715678] brcmfmac: brcmf_chip_set_passive Enter
>> [  144.722499] brcmfmac: brcmf_chip_tcm_ramsize: up 0 corecap 0 nab 0 
>> nbb 0
> 
> I see. That helps. Let me come up with a patch for this.
> 
> [...]
> 
>> btw:
>> to be sure about is my DT correct i done following tests:
>> 1.boot my distro binary on other board with ap6256 (radxa-rockpi4b). 
>> works ok
>> 2.selective disable wifi pwrseq and clock dt fragments. disabling 
>> stops chip detection so indirectly concluding my dt fragments seems to 
>> be ok
> 
> The fact that the wifi device is probed is enough proof. There may be 
> some additional clocks needed, but for now it looks like SDIO bus is 
> properly functioning to access the device.

...but feel free to share the DT source so I can have a look.

Regards,
Arend
