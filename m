Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A9B766563E
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Jan 2023 09:39:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231997AbjAKIjo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Jan 2023 03:39:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231846AbjAKIjj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Jan 2023 03:39:39 -0500
X-Greylist: delayed 60 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 11 Jan 2023 00:39:37 PST
Received: from h2.cmg1.smtp.forpsi.com (h2.cmg1.smtp.forpsi.com [81.2.195.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66BA7C763
        for <linux-wireless@vger.kernel.org>; Wed, 11 Jan 2023 00:39:37 -0800 (PST)
Received: from lenoch ([91.218.190.200])
        by cmgsmtp with ESMTPSA
        id FWczpL4n6Pm6CFWd0pWYif; Wed, 11 Jan 2023 09:38:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triops.cz; s=f2019;
        t=1673426314; bh=l0RcFkzmMrH/bSRzXQpFt7Km/jg+S8OLp9WMGVak8jc=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
        b=fH1rchVtm/DD6WTNt1La7P/QChltZnruCmWEw/zqFwredTnosyIGpgY65RN+GSrvh
         b/bvPB8hBV1LeRBUzXJMMUULywGd3okF8Dt/enzonWtkGXx+weUlpskjum/Bcrhf33
         +cu7m/tJfVjBlJdwtMgEF1hQ5+oXjEZ25GeYOhfAH4yBPiqkkbx3sqs575wfXz1seP
         9cs8FXQ1yxv3icHjl7/8vzHyLNqgcd2m0ZskfvT5ijsAfWEk0NdrcqiYcChqH2rTEB
         9XpVltMCwrJlnFNs7Lh/3Do/YtOobShX/WSvDGC1CPNb5jJXdszXVvZaI6qBTRNUWP
         yq35hAgUEVaOQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triops.cz; s=f2019;
        t=1673426314; bh=l0RcFkzmMrH/bSRzXQpFt7Km/jg+S8OLp9WMGVak8jc=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
        b=fH1rchVtm/DD6WTNt1La7P/QChltZnruCmWEw/zqFwredTnosyIGpgY65RN+GSrvh
         b/bvPB8hBV1LeRBUzXJMMUULywGd3okF8Dt/enzonWtkGXx+weUlpskjum/Bcrhf33
         +cu7m/tJfVjBlJdwtMgEF1hQ5+oXjEZ25GeYOhfAH4yBPiqkkbx3sqs575wfXz1seP
         9cs8FXQ1yxv3icHjl7/8vzHyLNqgcd2m0ZskfvT5ijsAfWEk0NdrcqiYcChqH2rTEB
         9XpVltMCwrJlnFNs7Lh/3Do/YtOobShX/WSvDGC1CPNb5jJXdszXVvZaI6qBTRNUWP
         yq35hAgUEVaOQ==
Date:   Wed, 11 Jan 2023 09:38:33 +0100
From:   Ladislav Michl <oss-lists@triops.cz>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org
Subject: [BUG] wifi: mac80211: Unable to handle kernel paging request
Message-ID: <Y751ia5Mub0J3RXF@lenoch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CMAE-Envelope: MS4wfHar6EHWuZ7W+FaZ2uxLc+GqWtLr2v009ulmEavPfMIV2pE1uZaziiPvyTAoR7KChQDD7zuA59Qwkf4gEMI9DfLI422Ou8dAaq92IqhmL5otWShv0CiP
 qQvPhGvEGAEeZJEUPsxc9M2EcfQF5e4K7GTjwM0uwsgoAURwnP31fRzzm19/ccfWdablcx5uowPXUEOiTbEg4d7u3SgwvSli2jc=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

following issue was triggered while debugging xHCI on custom Cavium
Octeon III (MIPS) board with linux-6.1.4.

Ralink 802.11n WLAN dongle is inserted into USB port:
usb 1-1: new high-speed USB device number 29 using xhci-hcd
usb 1-1: New USB device found, idVendor=148f, idProduct=5370, bcdDevice= 1.01
usb 1-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
usb 1-1: Product: 802.11 n WLAN
usb 1-1: Manufacturer: Ralink
usb 1-1: SerialNumber: 1.0
usb 1-1: reset high-speed USB device number 29 using xhci-hcd
ieee80211 phy16785: rt2x00_set_rt: Info - RT chipset 5390, rev 0502 detected
ieee80211 phy16785: rt2x00_set_rf: Info - RF chipset 5370 detected
and a script is periodically enabling and disabling it. After a few rounds
kernel panics:
Unable to handle kernel paging request at virtual address ffffffff8117ca0c
...
Call Trace:
 [<ffffffff8117ca0c>] del_timer+0x14/0x68
 [<ffffffff8158dd30>] led_blink_set+0x30/0x80
 [<ffffffff8158f4d0>] led_trigger_blink+0x48/0x78
 [<ffffffff818b265c>] tpt_trig_timer+0x10c/0x120
 [<ffffffff8117c48c>] call_timer_fn.constprop.0+0x24/0x98
 [<ffffffff8117c908>] run_timer_softirq+0x318/0x3a0
 [<ffffffff818ed580>] __do_softirq+0x100/0x2b0
 [<ffffffff81104940>] plat_irq_dispatch+0xb0/0xd0
 [<ffffffff811131a0>] handle_int+0x140/0x14c
 [<ffffffff81113020>] __r4k_wait+0x20/0x40
 [<ffffffff818ed3f8>] default_idle_call+0x30/0x48
 [<ffffffff8115b85c>] do_idle+0x74/0xe0
 [<ffffffff8115bb68>] cpu_startup_entry+0x18/0x28
 [<ffffffff818e4640>] kernel_init+0x0/0x110

It seems timer is still running at the time device is removed. Disabling
MAC80211_LEDS makes issue dissapear. Does it ring a bell?

	ladis
