Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21AE93D56CC
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Jul 2021 11:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233060AbhGZJGs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 26 Jul 2021 05:06:48 -0400
Received: from relay.smtp-ext.broadcom.com ([192.19.166.231]:45020 "EHLO
        relay.smtp-ext.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232776AbhGZJGl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 26 Jul 2021 05:06:41 -0400
Received: from bld-lvn-bcawlan-34.lvn.broadcom.net (bld-lvn-bcawlan-34.lvn.broadcom.net [10.75.138.137])
        by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 80E97A2;
        Mon, 26 Jul 2021 02:37:59 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 80E97A2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1627292279;
        bh=/uBoYDadCnXFgHu2vQNxbiLnGA2LuhdWM2hyKXYQF64=;
        h=Subject:To:References:Cc:From:Date:In-Reply-To:From;
        b=WoFiuSn3r9ZxrA9NBG7ZiISQCrxp471BsqJ+9XykIhRxm3f9kGn45Km3E8MC/+7n0
         qHgB/SsjaZQubmm1YdJPyvL+MoCSXzXwCqLiM6pHLr+6DBNBI0j+uNyChYgBYYSrzP
         Y034qCxg5cSMwiJ+bNSt+fc+fS1OacJC6vlIjFCo=
Received: from [10.176.68.80] (39y1yf2.dhcp.broadcom.net [10.176.68.80])
        by bld-lvn-bcawlan-34.lvn.broadcom.net (Postfix) with ESMTPSA id D44BF1874BD;
        Mon, 26 Jul 2021 02:37:58 -0700 (PDT)
Subject: Re: Current mainline brcmfmac reports error on supposedly supported
 ap6256 chip
To:     Piotr Oniszczuk <piotr.oniszczuk@gmail.com>
References: <CB0AA0D2-A8F3-4217-A3C1-E14D7E9FF11E@gmail.com>
 <17ad94781a0.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <6F6333F3-0BDB-48AF-B445-723958ABA8C9@gmail.com>
 <be6c2b7f-2c85-59fb-3013-d0590c487c51@broadcom.com>
 <53E7119F-D158-4EF0-940C-D0AA59C23CF6@gmail.com>
 <3da7f271-0c5c-50de-375a-a8c67ca127f5@broadcom.com>
 <286E2774-FAA5-47E3-A1FC-FDB09EB37FDC@gmail.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Ondrej Jirman <megous@megous.com>
From:   Arend van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <1a5588e2-38fc-1ec2-580a-30ae03ee73e1@broadcom.com>
Date:   Mon, 26 Jul 2021 11:37:56 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <286E2774-FAA5-47E3-A1FC-FDB09EB37FDC@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

+ linux-wireless, + Ondrej

Hoi Piotr,

Please reply to all. This might interest others with a similar device.

On 7/26/2021 11:31 AM, Piotr Oniszczuk wrote:
> Arend,
> 
> pls find dmesg with extra prints you proposed:
> 
> [  144.634234] brcmfmac: brcmfmac_module_init No platform data available.
> [  144.638974] brcmfmac: brcmf_sdio_probe Enter
> [  144.643057] brcmfmac: F1 signature read @0x18000000=0x15294345
> [  144.648718] brcmfmac: brcmf_chip_recognition found AXI chip: BCM4345/9
> [  144.656662] brcmfmac: brcmf_chip_cores_check  [1 ] core 0x800:51 base 0x18000000 wrap 0x18100000
> [  144.663690] brcmfmac: brcmf_chip_cores_check  [2 ] core 0x812:54 base 0x18001000 wrap 0x18101000
> [  144.672346] brcmfmac: brcmf_chip_cores_check  [3 ] core 0x83e:9  base 0x18002000 wrap 0x18102000
> [  144.681031] brcmfmac: brcmf_chip_cores_check  [4 ] core 0x83c:14 base 0x18003000 wrap 0x18103000
> [  144.689683] brcmfmac: brcmf_chip_cores_check  [5 ] core 0x829:21 base 0x18004000 wrap 0x18104000
> [  144.698365] brcmfmac: brcmf_chip_cores_check  [6 ] core 0x135:0  base 0x00000000 wrap 0x18107000
> [  144.707019] brcmfmac: brcmf_chip_cores_check  [7 ] core 0x240:0  base 0x00000000 wrap 0x00000000
> [  144.715678] brcmfmac: brcmf_chip_set_passive Enter
> [  144.722499] brcmfmac: brcmf_chip_tcm_ramsize: up 0 corecap 0 nab 0 nbb 0

I see. That helps. Let me come up with a patch for this.

[...]

> btw:
> to be sure about is my DT correct i done following tests:
> 1.boot my distro binary on other board with ap6256 (radxa-rockpi4b). works ok
> 2.selective disable wifi pwrseq and clock dt fragments. disabling stops chip detection so indirectly concluding my dt fragments seems to be ok

The fact that the wifi device is probed is enough proof. There may be 
some additional clocks needed, but for now it looks like SDIO bus is 
properly functioning to access the device.

Regards,
Arend
