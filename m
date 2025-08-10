Return-Path: <linux-wireless+bounces-26235-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3C41B1FC10
	for <lists+linux-wireless@lfdr.de>; Sun, 10 Aug 2025 22:36:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76D50173763
	for <lists+linux-wireless@lfdr.de>; Sun, 10 Aug 2025 20:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE2E870808;
	Sun, 10 Aug 2025 20:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="rhrIz5i/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4A91E515
	for <linux-wireless@vger.kernel.org>; Sun, 10 Aug 2025 20:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754858199; cv=none; b=NhsSvxfJqpQLHB5d0CbzZyU8mQ0Lr3TDYjCvzI4joxpvMDppqQDVON1Opefj27NSSyZ9BF0X39l2grEiyRP61gJV2JQxlkcO2zVHyido2DubIh2dvUCmeKbS3xe4dfaHlnicr0p/5rmwlDaX3r1IcHWJYc0ixFj7EWMXnymvy28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754858199; c=relaxed/simple;
	bh=xC4oNac+tJVc5rbkZDWjweN8OAkG0CaRCc4y+ssfy38=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=Cm7TZt+zkvx40k1hGFf+F0tEimfggvfrgfUzvH8qLzVFrthO3gXlwYu8pVor3NYL7nhBZdOHm6bJi+BYfZWEFBMNMB6cRusB9iOUXqVfxbGdE+07ra4SJOIfjK5oIsXpkQu4O2K9iFhUT0WEOvy+1OkEHvuzcYLQ187HmOcig60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=rhrIz5i/; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1754858195; x=1755462995; i=deller@gmx.de;
	bh=Q668NPqWGYVd3t6xv31Z6wTZdkWSxelzYUVSGgNoqdg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=rhrIz5i/4ECD3Omgi15y2olnfiqlV+V2aR1Jg+bLmv5Z3cCYCKKb+CDsRoRR6iBx
	 lNbpA4ssEETgvNALjI5edvTkvJ8AWJ0X3JkpbM/BPp4ISUzQqP2foVElZ03W6v7gu
	 1VAr7ATeMx3AXzMtnjl6o0gR/hSLidfPKE/5qHLj/CdxonhB0PSL6yYIcWeeh5gaz
	 2QBxPsB8CAAa4BXia9fioXIsqd5Xw2qgXIA1BINOSWNn8MkoLp09Umn48Xxn383QG
	 5kP7Xf1vp7xeJHZYDOxTbYyvACKvyoGqYsJ8l0LI7r0n0accvdUf23k2O+hudhMSe
	 CA2ptOCVCkamoeza+A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.173] ([83.135.217.215]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MVeMG-1vCoK71aiq-00PZHH; Sun, 10
 Aug 2025 22:36:35 +0200
Message-ID: <ee0acfef-a753-4f90-87df-15f8eaa9c3a8@gmx.de>
Date: Sun, 10 Aug 2025 22:36:34 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Jes.Sorensen@gmail.com, Ping-Ke Shih <pkshih@realtek.com>,
 linux-wireless <linux-wireless@vger.kernel.org>
From: Helge Deller <deller@gmx.de>
Subject: RTL8188S WLAN Adapter failure
Autocrypt: addr=deller@gmx.de; keydata=
 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
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:r9DCQi7QDoPWCpkph9X4ogSsANKqQAQx+huKkPdTkUP3zF7y185
 k9gxXmv0t042B9tGBwydw+/8g7KU+9PpnQV47LbHpH5Vj3TVmS2ldiZ4Ky+K+l8+4tRGv1T
 RV+noLg0MMUxRApMdEM7PeRwSTjawMhBvHrPfAgZlvajBZy4cnUkdLQ2Ao3cFhgU346rXw2
 M5jYqFO7lejmsXzpTltqQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ZNdKqfOMfzA=;28rk/XQTL6z0KpNH5Sg5AD45dTJ
 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
 k13P3OEtFRhZO5SXswwA==

The USB dongle which came with my DreamBox DM7020HD years ago seems to fail now.
Any idea or suggestion what I should try?

[427792.562049] usb 3-7: new high-speed USB device number 56 using xhci_hcd
[427792.689358] usb 3-7: New USB device found, idVendor=07b8, idProduct=8188, bcdDevice= 2.00
[427792.689376] usb 3-7: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[427792.689381] usb 3-7: Product: RTL8188S WLAN Adapter
[427792.689385] usb 3-7: Manufacturer: Manufacturer Realtek
[427792.689388] usb 3-7: SerialNumber: 00e04c000001
[427792.695145] usb 3-7: This Realtek USB WiFi dongle (0x07b8:0x8188) is untested!
[427792.695151] usb 3-7: Please report results to Jes.Sorensen@gmail.com
[427792.934142] usb 3-7: Dumping efuse for RTL8188CU (0x200 bytes):
[427792.934151] 00000000: 29 81 00 00 a9 16 00 00 b8 07 88 81 90 85 62 9c  ).............b.
[427792.934155] 00000010: 06 00 ec f0 0e 16 44 3f 17 03 4d 61 6e 75 66 61  ......D?..Manufa
[427792.934157] 00000020: 63 74 75 72 65 72 20 52 65 61 6c 74 65 6b 20 18  cturer Realtek .
[427792.934159] 00000030: 03 52 54 4c 38 31 38 38 53 20 57 4c 41 4e 20 41  .RTL8188S WLAN A
[427792.934160] 00000040: 64 61 70 74 65 72 20 00 00 00 00 00 00 00 00 00  dapter .........
[427792.934162] 00000050: 06 02 00 00 00 24 24 24 00 00 00 26 26 26 00 00  .....$$$...&&&..
[427792.934163] 00000060: 00 00 00 00 00 00 00 00 12 00 00 09 0d 00 00 00  ................
[427792.934164] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
[427792.934166] 00000080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
[427792.934167] 00000090: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
[427792.934168] 000000a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
[427792.934170] 000000b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
[427792.934171] 000000c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
[427792.934172] 000000d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
[427792.934174] 000000e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
[427792.934175] 000000f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
[427792.934176] 00000100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
[427792.934178] 00000110: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
[427792.934179] 00000120: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
[427792.934180] 00000130: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
[427792.934182] 00000140: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
[427792.934183] 00000150: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
[427792.934184] 00000160: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
[427792.934186] 00000170: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
[427792.934187] 00000180: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
[427792.934188] 00000190: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
[427792.934190] 000001a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
[427792.934191] 000001b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
[427792.934192] 000001c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
[427792.934193] 000001d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
[427792.934195] 000001e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
[427792.934196] 000001f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
[427792.934198] usb 3-7: RTL8188CU rev A (TSMC) romver 0, 1T1R, TX queues 3, WiFi=1, BT=0, GPS=0, HI PA=0
[427792.934203] usb 3-7: RTL8188CU MAC: 44:3f:17:03:4d:61
[427792.934206] usb 3-7: rtl8xxxu: Loading firmware rtlwifi/rtl8192cufw_TMSC.bin
[427792.938371] usb 3-7: Firmware revision 88.2 (signature 0x88c1)
[427792.939417] rtl8192cu_power_on: Enabling LDOV12D (24)
[427793.115145] rtl8192cu_power_on: FSMCO_MAC_ENABLE poll failed
[427793.115156] usb 3-7: rtl8xxxu_init_device: Failed power on
[427793.116003] rtl8xxxu 3-7:1.0: probe with driver rtl8xxxu failed with error -16

