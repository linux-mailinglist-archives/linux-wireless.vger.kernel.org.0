Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60FD737347A
	for <lists+linux-wireless@lfdr.de>; Wed,  5 May 2021 06:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231636AbhEEEvo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 5 May 2021 00:51:44 -0400
Received: from mx3.wp.pl ([212.77.101.10]:38029 "EHLO mx3.wp.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229895AbhEEEvo (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 5 May 2021 00:51:44 -0400
Received: (wp-smtpd smtp.wp.pl 12743 invoked from network); 5 May 2021 06:50:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1620190245; bh=eea2FzFifVuQf4y/aTsiEfdYXepf4D9/qCcKFc4XwQ8=;
          h=From:To:Cc:Subject;
          b=p3dqO3QsqJjHwEVMW1seUCAGZmIzu3gUb+w2P3pr8uTDzNzvTxJ1RFAxBGBAVfrSo
           K4kaAk1SA4vOPep0RulrA4knDZJZTzaumtNJ+0AqD8d29dH3pfc7Fy76+Fr6Rzb6Wf
           gbytcRsFa1mQ8esuqzdzYIh9Un1jWzYR9vCI8Xew=
Received: from 89-64-4-144.dynamic.chello.pl (HELO localhost) (stf_xl@wp.pl@[89.64.4.144])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <rsalvaterra@gmail.com>; 5 May 2021 06:50:45 +0200
Date:   Wed, 5 May 2021 06:50:44 +0200
From:   Stanislaw Gruszka <stf_xl@wp.pl>
To:     Rui Salvaterra <rsalvaterra@gmail.com>
Cc:     lorenzo@kernel.org, kuba@kernel.org, linux-wireless@vger.kernel.org
Subject: Re: [RFC PATCH] mt7601u: make the driver work again
Message-ID: <20210505045044.GA735251@wp.pl>
References: <20210504212828.815-1-rsalvaterra@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210504212828.815-1-rsalvaterra@gmail.com>
X-WP-MailID: 5a53c093045847177a7d3f42443eb4b1
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000002 [cSGx]                               
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, May 04, 2021 at 10:28:28PM +0100, Rui Salvaterra wrote:
> This is a tentative fix for a long-standing issue [1] with MT7601U devices. In
> my case, this is what I see in the dmesg when I plug the device in:
> 
> [  660.810386] usb 1-7: new high-speed USB device number 119 using ehci-pci
> [  661.031390] usb 1-7: New USB device found, idVendor=148f,
> idProduct=7601, bcdDevice= 0.00
> [  661.031400] usb 1-7: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> [  661.031404] usb 1-7: Product: 802.11 n WLAN
> [  661.031408] usb 1-7: Manufacturer: MediaTek
> [  661.031411] usb 1-7: SerialNumber: 1.0
> [  661.200379] usb 1-7: reset high-speed USB device number 119 using ehci-pci
> [  661.403137] mt7601u 1-7:1.0: ASIC revision: 76010001 MAC revision: 76010500
> [  661.404566] mt7601u 1-7:1.0: Firmware Version: 0.1.00 Build: 7640
> Build time: 201302052146____
> [  661.828765] mt7601u 1-7:1.0: EEPROM ver:0d fae:00
> [  662.005518] mt7601u 1-7:1.0: Error: MCU resp urb failed:-71
> [  662.005525] mt7601u 1-7:1.0: Error: MCU resp evt:0 seq:5-4!
> [  662.010015] mt7601u 1-7:1.0: Error: MCU resp urb failed:-71
> [  662.010020] mt7601u 1-7:1.0: Error: MCU resp evt:0 seq:5-4!
> [  662.014269] mt7601u 1-7:1.0: Error: MCU resp urb failed:-71
> [  662.014275] mt7601u 1-7:1.0: Error: MCU resp evt:0 seq:5-4!
> [  662.018516] mt7601u 1-7:1.0: Error: MCU resp urb failed:-71
> [  662.018521] mt7601u 1-7:1.0: Error: MCU resp evt:0 seq:5-4!
> [  662.022768] mt7601u 1-7:1.0: Error: MCU resp urb failed:-71
> [  662.022775] mt7601u 1-7:1.0: Error: MCU resp evt:0 seq:5-4!
> [  662.022779] mt7601u 1-7:1.0: Error: mt7601u_mcu_wait_resp timed out
> [  662.350350] mt7601u 1-7:1.0: Vendor request req:07 off:0080 failed:-71
> [  662.650344] mt7601u 1-7:1.0: Vendor request req:02 off:0080 failed:-71
> [  662.950339] mt7601u 1-7:1.0: Vendor request req:02 off:0080 failed:-71
> [  662.950389] mt7601u: probe of 1-7:1.0 failed with error -110
> [  662.950850] usb 1-7: USB disconnect, device number 119

> 
> This loops continuously. The device never comes up.
> Turns out, this issue has been narrowed down to a possible calibration
> problem [2]. Stanislaw repeatedly asked if disabling DPD calibration only
> (keeping the RXIQ calibration) would fix the problem, but nobody seems to have
> paid attention. :) Additionally, he asked for contents of
> /sys/kernel/debug/ieee80211/phy0/mt7601u/eeprom_param, so here they are:
> 
> RF freq offset: 5f
> RSSI offset: 0 0
> Reference temp: f9
> LNA gain: 0
> Reg channels: 1-14
> Per rate power:
> 	 raw:05 bw20:05 bw40:05
> 	 raw:05 bw20:05 bw40:05
> 	 raw:03 bw20:03 bw40:03
> 	 raw:03 bw20:03 bw40:03
> 	 raw:04 bw20:04 bw40:04
> 	 raw:00 bw20:00 bw40:00
> 	 raw:00 bw20:00 bw40:00
> 	 raw:00 bw20:00 bw40:00
> 	 raw:02 bw20:02 bw40:02
> 	 raw:00 bw20:00 bw40:00
> Per channel power:
> 	 tx_power  ch1:0c ch2:0c
> 	 tx_power  ch3:0b ch4:0b
> 	 tx_power  ch5:0a ch6:0a
> 	 tx_power  ch7:0a ch8:0a
> 	 tx_power  ch9:0a ch10:0a
> 	 tx_power  ch11:0a ch12:0a
> 	 tx_power  ch13:0a ch14:0a
> 
> The attached patch fixes the driver for me. Sending as RFC because this will
> probably warrant some kind of quirk to be fixed correctly. Besides, there's an
> additional DPD calibration in mt7601u_temp_comp, which I haven't touched, since
> it seems a bit more convoluted. The driver works for me regardless (I've sent
> this email through one of my MT7601U adapters).

I'm not sure if DPD calibration is needed. Maybe is ok to disable it for
all MT7601U devices. However safer fix would be doing it only for
devices that know to need it for work. For example: add dev->no_dpd_cal
variable, set it based on USB ID (using usb_device_id->driver_info) and
do not perfrom calibration when it's set.

Also please clarify "work again" in the topic. Have your device ever
worked with mt7601u driver in some older kernel version? 

Stanislaw
