Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40FF32A945B
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Nov 2020 11:29:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbgKFK3Q (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 6 Nov 2020 05:29:16 -0500
Received: from mail-out.m-online.net ([212.18.0.10]:45930 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726897AbgKFK3Q (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 6 Nov 2020 05:29:16 -0500
X-Greylist: delayed 154636 seconds by postgrey-1.27 at vger.kernel.org; Fri, 06 Nov 2020 05:29:15 EST
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4CSGpK4hvXz1rx8b;
        Fri,  6 Nov 2020 11:29:13 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4CSGpK078hz1qsXj;
        Fri,  6 Nov 2020 11:29:13 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id YCy5m4QzT_BY; Fri,  6 Nov 2020 11:29:10 +0100 (CET)
X-Auth-Info: PVTK2iwMaYBiRFQRuSJPNGNH01LlXD129pXF/yNKc1k=
Received: from [IPv6:::1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Fri,  6 Nov 2020 11:29:10 +0100 (CET)
Subject: Re: rsi: unusably slow / no tx
To:     Martin Kepplinger <martink@posteo.de>
References: <f909c001-e91a-1292-1239-18e41cbc693c@posteo.de>
Cc:     amitkarwar@gmail.com, siva8118@gmail.com, kvalo@codeaurora.org,
        kuba@kernel.org, linux-wireless@vger.kernel.org, kernel@puri.sm,
        siva.rebbagondla@redpinesignals.com, fariyaf@gmail.com,
        jahnavi.meher@gmail.com, prameela.j04cs@gmail.com,
        amit.karwar@redpinesignals.com, karun256@gmail.com,
        Angus Ainslie <angus@akkea.ca>
From:   Marek Vasut <marex@denx.de>
Message-ID: <754ee188-263d-a70e-9ac4-fd0d39333804@denx.de>
Date:   Fri, 6 Nov 2020 11:29:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <f909c001-e91a-1292-1239-18e41cbc693c@posteo.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 11/6/20 11:12 AM, Martin Kepplinger wrote:
> hi,

Hi,

> I start the driver with options rsi_sdio dev_oper_mode=13 and (try to) 
> connect to a usual wpa2 encrypted network:
> 
> The rsi driver is unusably slow for me still. It slowly (sometimes) 
> connects to a network, but even then it's unusable. To me it seems like 
> the drivers sends way too little; tx() that is registered with mac80211 
> is rarely called - just 4 times in the below logs (where other drivers 
> would send data for each received packet afaik).
> 
> Thanks a lot Marek for working on the driver! I already use 
> https://lore.kernel.org/netdev/20201015111616.429220-1-marex@denx.de/ here.

Make sure to add also:
https://lore.kernel.org/netdev/20201103180941.443528-1-marex@denx.de/
that one made a lot of difference on RX performance, not so much on TX 
though.

I also have this locally (better use the module param than patch the 
kernel), because it seems wifi/bt coex is broken.

diff --git a/drivers/net/wireless/rsi/rsi_91x_sdio.c 
b/drivers/net/wireless/rsi/rsi_91x_sdio.c
index 1bebba4e8527..2b2a9485aae0 100644
--- a/drivers/net/wireless/rsi/rsi_91x_sdio.c
+++ b/drivers/net/wireless/rsi/rsi_91x_sdio.c
@@ -22,7 +22,7 @@
  #include "rsi_hal.h"

  /* Default operating mode is wlan STA + BT */
-static u16 dev_oper_mode = DEV_OPMODE_STA_BT_DUAL;
+static u16 dev_oper_mode = DEV_OPMODE_WIFI_ALONE;
  module_param(dev_oper_mode, ushort, 0444);
  MODULE_PARM_DESC(dev_oper_mode,
                  "1[Wi-Fi], 4[BT], 8[BT LE], 5[Wi-Fi STA + BT classic]\n"

There seem to be a huge amount of issues with those RSI WiFi devices, 
thanks to Angus for keeping track of them here:
https://source.puri.sm/Librem5/linux-next/-/issues?scope=all&utf8=%E2%9C%93&state=opened&search=redpine

There is also the downstream driver here:
git://github.com/SiliconLabs/RS911X-nLink-OSD
unfortunatelly, there is no changelog nor separate patches, just one 
huge code-dump. The driver is some sort of derivative of the upstream 
driver, so you can do a diff, but the diff is some thousands of lines of 
change.

You can however try compiling it and see whether this makes your wifi 
work, if so, then try to figure out which change is the fix. That's how 
I came to the TX EAPOL fix, I just spent an insane amount of time trying 
to figure out what change made the wifi work against iwlwifi AP in the 
vendor driver, removing parts of the diff until I came to the one line.

> Does anyone actually use the driver or at least has seen similar 
> behaviour, or even know what could go wrong?
> 
> 
> So I added messages at a few spots in the rx/tx path and this is while 
> connected to a network (without doing much):
> 
> [  124.277947] rsi_91x: RX Packet Type: QOS DATA
> [  124.377107] rsi_91x: rsi_mgmt_pkt_recv: Msg Len: 333, Msg Type:    2
> [  124.377118] rsi_91x: rsi_mgmt_pkt_to_core: rssi=33 channel=5
> [  124.377123] rsi_91x: RX Dot11 Mgmt Pkt Type: BEACON
> [  124.377128] rsi_91x: RX Packet Type: BEACON
> [  124.377915] rsi_91x: RX Packet Type: QOS DATA

I haven't seen this one, no, sorry. How is your AP configured (which 
wifi is in it, how is the hostap configured, ...)?
