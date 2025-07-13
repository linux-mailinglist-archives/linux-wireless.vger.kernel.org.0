Return-Path: <linux-wireless+bounces-25331-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E19D4B02E58
	for <lists+linux-wireless@lfdr.de>; Sun, 13 Jul 2025 03:28:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A1004A1496
	for <lists+linux-wireless@lfdr.de>; Sun, 13 Jul 2025 01:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57CDF22094;
	Sun, 13 Jul 2025 01:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=melanic.xyz header.i=@melanic.xyz header.b="fI1F8d7S"
X-Original-To: linux-wireless@vger.kernel.org
Received: from butterfly.birch.relay.mailchannels.net (butterfly.birch.relay.mailchannels.net [23.83.209.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12C04A1E
	for <linux-wireless@vger.kernel.org>; Sun, 13 Jul 2025 01:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=23.83.209.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752370120; cv=fail; b=X+e3fX3lo95B81ihxKjeSwqX4MxT/CI02YzSTdX2MF/nhynPhiGNeKHo5Ufb44dlY2/w/1IBcUcAtnYfXEtuDuqX7cd8E2U6hSuqBMjSNNN7eeNEFGlVc55aW1SSFEwMhiHsB6rQb7w8e4V4qefdw0Gtg+2KOfv1DJbah6Qi/kA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752370120; c=relaxed/simple;
	bh=svWnScUXbjNpseQrXQmi57MuxfFLd3IRBao/2iTRo44=;
	h=MIME-Version:From:To:Subject:Message-ID:Content-Type:Date; b=MfVtGQXbCZdLyzg2MpDC42jYwGuGHWBx6C1S412MUhGsdrJCVDQJ8uW6efhHbj+l4Co5djrbByk7/lNxfHh8Vt4X/fvBdw9lZjmPdrJEV6Jcbq6zXMqZqawnq5H/xDwwwFsluvdw/4ibin3b49V+iE4UP1yPL8cdTeBuEJ9NCq0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=melanic.xyz; spf=pass smtp.mailfrom=melanic.xyz; dkim=pass (2048-bit key) header.d=melanic.xyz header.i=@melanic.xyz header.b=fI1F8d7S; arc=fail smtp.client-ip=23.83.209.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=melanic.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=melanic.xyz
X-Sender-Id: hostingeremail|x-authuser|andyman@melanic.xyz
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id CF514903E4B
	for <linux-wireless@vger.kernel.org>; Sun, 13 Jul 2025 00:12:12 +0000 (UTC)
Received: from nl-srv-smtpout9.hostinger.io (100-114-117-211.trex-nlb.outbound.svc.cluster.local [100.114.117.211])
	(Authenticated sender: hostingeremail)
	by relay.mailchannels.net (Postfix) with ESMTPA id 19DD5903DFD
	for <linux-wireless@vger.kernel.org>; Sun, 13 Jul 2025 00:12:11 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1752365532; a=rsa-sha256;
	cv=none;
	b=l4bKVXt+Jvleakzv0i5kR40Jtfi704fZfa4IFU03OD9BbfbyXwfgHl8xsff0wJ+hvH0b+z
	8zbuVOEmRs8ziXmH0ixp+oucUVqWjC/00mtlzBpcL0QZ2i0qbQqpOUafhoudOuyJBviNWN
	g8GdMeMTGtSvITWADu9nWXFX0EP2jOKwWcPw3aF18K4sTzSXHgZW3lVe0SxLVNtVrDnFvH
	zGbjnuS3f5ENbrJYixIONulkIATRuEDlU4tOvlsmpZFA2tGhSCZBCuLFdhFhVDf8je1Ndp
	wwwBlU7aZzk0WT+katJgUNhBA/qYknjHgs0iG2TaeMfQyawtjcRYCIWQxnuhQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1752365532;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=VgKKsfDywV/o7i/WlkUyQLYuXopStdzR7GUeypQ4LPg=;
	b=TLFphThhDUqX1sZsaAyNnABKxjJcZrI0nZKtJfnpD3JhOJI6NyUw7FEr72wV1sEt+2qTR1
	eCyQtm058gNgg/lx7FhRKEaRF2nfopNRMQQfp/eg1lSMt8+TkX6NaXer+n/6kyjtq4iSMc
	p/bY709ygsI/58txhwtbjVXfGxkh6xGhe64Ez1/RrL4XFL2CgvjF1l32mXEYggQl7pFBlz
	Y0/SQ1XDpy+vz2vC2+SAmS0nZ4CHFcmqtGwKuC5wbDcou7ADgvPTNEp+H0zpH33eNy6JmD
	JY7TCkZ7cKvS3nMuil2Ytm/2E/knf6/g+58+AUMUFovZ5Mn0ny/y5FhyKIJmkA==
ARC-Authentication-Results: i=1;
	rspamd-5c976dc8b-wfkdl;
	auth=pass smtp.auth=hostingeremail smtp.mailfrom=andyman@melanic.xyz
X-Sender-Id: hostingeremail|x-authuser|andyman@melanic.xyz
X-MC-Relay: Neutral
X-MailChannels-SenderId: hostingeremail|x-authuser|andyman@melanic.xyz
X-MailChannels-Auth-Id: hostingeremail
X-Scare-Exultant: 71505ba010609332_1752365532692_3561811649
X-MC-Loop-Signature: 1752365532692:807910464
X-MC-Ingress-Time: 1752365532692
Received: from nl-srv-smtpout9.hostinger.io (nl-srv-smtpout9.hostinger.io
 [45.87.82.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.114.117.211 (trex/7.1.3);
	Sun, 13 Jul 2025 00:12:12 +0000
Received: from mail.hostinger.com (122.132.242.35.bc.googleusercontent.com [IPv6:2600:1700:7b50:2cf0:609e:c94f:9893:c5b9])
	(Authenticated sender: andyman@melanic.xyz)
	by smtp.hostinger.com (smtp.hostinger.com) with SMTP id 4bfm960mhSzGY3Xk
	for <linux-wireless@vger.kernel.org>; Sun, 13 Jul 2025 00:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=melanic.xyz;
	s=hostingermail-a; t=1752365530;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+Ios/6tOLJOs9JZqQLCRMzc0DWcj2UbB9A3TYThX8Lc=;
	b=fI1F8d7SbnXPKebFSelGFZ6iIdXLu1GjZf6ezUcOL521dWgGKINrA2bEf5P2p7rD3/OoCd
	VGbJ9yXqAFiUItN7dzIxo4QymBpu5/GL+c3CVJn0g3tH+4Dr89H4/A9p4d0DOFxzieC9FL
	vv7YAbf0wR7I0evcvuJn2nCpjhZ+HlD7D7uHBILXErEkQtdi38eCVNZUwvZNDqTALNmlWB
	eY5nztMqOt8skPjB1gnbLAR8GE/iTnSyQy8kMUyMIqTpVjbkMgLkU4NH6RSXFu+gP0iNWJ
	rwe/ZOeVgN3MP8T0nmzZMwvk2zFt9/UNfqUQ5TPjWLV1qQNka18lslChC3/XYQ==
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: andyman@melanic.xyz
To: Linux Wireless <linux-wireless@vger.kernel.org>
Subject: MT7922: Frequent disconnects and a failure to bring up on boot
Message-ID: <0b99450be5a37676a0afa3c17590ce15@melanic.xyz>
X-Sender: andyman@melanic.xyz
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Sun, 13 Jul 2025 00:12:10 +0000 (UTC)
X-CM-Envelope: MS4xfKZGo+WsnNq4shRzdcAMhIGSh2Z+ZmFsEmivvXHwibJ9nRulr08zp2Um4CRWCliTwZ8gjAuZi13W6dIHU8mrrbOasahc0KaB3TKbv935Ico73lRU9jcF WAvpE0/xN63yttGSRTalTqkuzwb7MWy7hM4f2hKIBBeOrCrDxHUCNPqkze34wgyurGOx4++K7z1jzVmhHDbgpBPrltE5cfO5KeoZyEmFr+WDQaNeWXx60IPO dRkSVqmsHyh3oKK8Ddp8nobf42XQExvyvuLePKkd86Y=
X-CM-Analysis: v=2.4 cv=OrcdyD/t c=1 sm=1 tr=0 ts=6872f9da a=RC2A8uE2lK0PEXFq6u+tzw==:617 a=9zTY3BIwtN1Myf9W:21 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=MKtGQD3n3ToA:10 a=1oJP67jkp3AA:10 a=ivH2Aw7XoB-j8qGvbTcA:9 a=CjuIK1q_8ugA:10 a=XReUu7uucrU0zjlRU2xT:22 a=RADZSm3owst0GkL05-i7:22
X-AuthUser: andyman@melanic.xyz

Hi all.

I have this device, in NixOS 25.05, on a Framework 16 laptop:

01:00.0 Network controller [0280]: MEDIATEK Corp. MT7922 802.11ax PCI 
Express Wireless Network Adapter [14c3:0616]
         Subsystem: MEDIATEK Corp. Device [14c3:e616]
         Flags: bus master, fast devsel, latency 0, IRQ 131, IOMMU group 
13
         Memory at 7810900000 (64-bit, prefetchable) [size=1M]
         Memory at 90b00000 (64-bit, non-prefetchable) [size=32K]
         Capabilities: [80] Express Endpoint, IntMsgNum 0
         Capabilities: [e0] MSI: Enable+ Count=1/32 Maskable+ 64bit+
         Capabilities: [f8] Power Management version 3
         Capabilities: [100] Vendor Specific Information: ID=1556 Rev=1 
Len=008 <?>
         Capabilities: [108] Latency Tolerance Reporting
         Capabilities: [110] L1 PM Substates
         Capabilities: [200] Advanced Error Reporting
         Kernel driver in use: mt7921e
         Kernel modules: mt7921e

Unless I disable power management on the card, it pretty frequently
randomly disconnects from the AP. Sometimes it runs for half a day,
sometimes it disconnects every 10-20 minutes. This is pretty consistent
across kernel versions (6.6.93 up to 6.15.3 at least) and firmware
revisions back to Feb 2024. Disabling power management ("iw dev wlp1s0
set power_save off") seems to make the connections stable. My usual
setup is an environment with a few different APs with the same SSID,
some with good signals and some others with very weak signals, but that
may not matter; I've also seen the dropouts when it's connected to just
a single AP (even just when tethering to my phone which is sitting on
the table right next to the machine.)

I started running 6.15.5 to test, don't really have much to say yet
in terms of whether it shows the disconnects also, but I just saw it
completely fail to bring up the card on boot:

[    2.360745] usb 1-5: new high-speed USB device number 7 using 
xhci_hcd
[    2.512351] usb 1-5: New USB device found, idVendor=0e8d, 
idProduct=e616, bcdDevice= 1.00
[    2.513874] usb 1-5: New USB device strings: Mfr=5, Product=6, 
SerialNumber=7
[    2.515263] usb 1-5: Product: Wireless_Device
[    2.516510] usb 1-5: Manufacturer: MediaTek Inc.
[    2.517681] usb 1-5: SerialNumber: 000000000

... and nothing else about the wireless card in the log; no messages
about mt7921e, the string "mt7" doesn't even appear in the kernel log.
The mt7921e driver module doesn't load and the wifi interface doesn't
come up. This is, I guess, a combo Bluetooth / Wifi card with both USB
and PCIe interfaces? I'm honestly not sure. It's a Framework 16 laptop
with the built in wireless module.

This is the first time I've seen this failure-to-come-up behavior, I've
only seen it once. The frequent disconnects have been consistent with
this machine across kernel versions in NixOS, although I haven't been
able to get them to happen with a couple of days of testing on Ubuntu
24.04 LTS.

Happy to post any logs or etc, or other information. Cheers.

