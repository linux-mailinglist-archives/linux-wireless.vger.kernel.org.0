Return-Path: <linux-wireless+bounces-36238-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eKp7ApgIAmqknQEAu9opvQ
	(envelope-from <linux-wireless+bounces-36238-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 18:49:28 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 11484512A0D
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 18:49:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9ED9131765C1
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 16:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5913243635D;
	Mon, 11 May 2026 16:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=justthetip.ca header.i=@justthetip.ca header.b="s9e6OWNS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76FE4436347
	for <linux-wireless@vger.kernel.org>; Mon, 11 May 2026 16:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778515711; cv=none; b=rJmMD39lhF7Tp9TYSIXgp9jUzpw7Z3KLF12GOBmDaFtmZbv36KKXXczLeFMvIef/zU9yBXtnYf/YVsVyaWpWY5ZwKqT1f7F/wAw1eR2JyDH2qlxVWMlMVySs2do03+637TdrSjbMrRLn6G/2KEZOaUJk79P21X1vynVGmxLOLsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778515711; c=relaxed/simple;
	bh=fuUTjtAAxgbRCsDFjwRmNa3YZdQiC6yiZw8Z6TFh94E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MT7dwgHEXXxIci4Dop3jHeVy7Fq+UO5I8qR8/qy9zIlCBBDaeyszWphvq1gS7zmwShZRpUYWq7Bkv+qhNpQFyk313r8O05AMPsfETw0TF/EsNuM8COs0AwQ4MaU1998rUMr9svUgNHAToKtK6CHAsRvP1IfCRhLSHivB5/dbVN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=justthetip.ca; spf=pass smtp.mailfrom=justthetip.ca; dkim=pass (2048-bit key) header.d=justthetip.ca header.i=@justthetip.ca header.b=s9e6OWNS; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=justthetip.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=justthetip.ca
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=justthetip.ca;
	s=key1; t=1778515697;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cMajrjBMOFr81A6WwaAK6DOUFAmEyTUDsbfZ00S+En4=;
	b=s9e6OWNSqqawEpiFvyNyqqBPsVJLw/TxiGcO03Jrf1AeHb9fQohxSX4JSBOZs+HlWvMnfC
	xMwVjsHSl2ERTFcorhsXbjSQdOQGynwWFO+RtyZnKLxH3vks3zkBLOgAK0nA0YopZQPsCZ
	uOhvk1jNoMOsEJroq9njn7Msn2jrbIiYdsXtwebILhhzee+NFE63AwDgH5E5/Bv3PxcwD1
	+8wzu3c3ZFi+HFEoMmwLR5tZtVJpDFjvtwjv6up7bTjMb8UIlvLJh0V0DWNtVwRJHU7i0A
	vgG8plBDjyP3/5CHCsh0diCmZCPW/LaEDmZWHzN3U5Zu7nw08zXpwS0KmIASyA==
From: Devin Wittmayer <lucid_duck@justthetip.ca>
To: linux-wireless@vger.kernel.org
Cc: pkshih@realtek.com,
	rtl8821cerfe2@gmail.com,
	linux-kernel@vger.kernel.org,
	Devin Wittmayer <lucid_duck@justthetip.ca>
Subject: [PATCH rtw-next v2 0/1] wifi: rtw89: usb: Support switching to USB 3 mode
Date: Mon, 11 May 2026 09:08:10 -0700
Message-ID: <20260511160811.17647-1-lucid_duck@justthetip.ca>
In-Reply-To: <20260508054421.128938-1-lucid_duck@justthetip.ca>
References: <20260508054421.128938-1-lucid_duck@justthetip.ca>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 11484512A0D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[justthetip.ca,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[justthetip.ca:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[realtek.com,gmail.com,vger.kernel.org,justthetip.ca];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-36238-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucid_duck@justthetip.ca,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[justthetip.ca:+];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[justthetip.ca:mid,justthetip.ca:dkim,checkpatch.pl:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

This patch adds USB 2 to USB 3 mode switching for the AX-generation
chips in the rtw89 USB driver (8852AU, 8852BU, 8852CU and helper
variants). Without it, those adapters enumerate at USB 2.0
high-speed on first plug and stay there, capping real-world
throughput around 260 Mbps TCP regardless of radio capability.

It is Bitterblue Smith's morrownr/rtw89 commit cd287ccf544b
(2025-07-16) rebased onto rtw-next without code changes:
author's Signed-off-by preserved, my Signed-off-by added as
relayer, Tested-by per chip based on the matrix below.

Changes since v1
================

- Rebased onto pkshih/rtw rtw-next (HEAD c1ed02655f91) per
  maintainer feedback. The patch diff is unchanged from v1; the
  test matrix below carries forward.
- Cover letter tightened to AX-generation scope only.

The bug
=======

These chips present as USB 2 devices on first plug. The driver is
expected to send a switch-mode register write to make them disappear
and re-enumerate as USB 3 SuperSpeed. Mainline rtw89 does not issue
these commands anywhere. Every user with one of these adapters on
a mainline-derived distribution sits at the USB 2.0 ceiling for
the life of the plug, regardless of negotiated radio rate.

The fix
=======

The patch covers AX-generation chips (8852AU, 8852BU, 8852CU and
helper variants) via R_AX_PAD_CTRL2. It also adds the
switch_usb_mode module parameter (default on) for users who
experience 2.4 GHz interference under USB 3.

Mainline precedent
==================

The same mechanism is in mainline rtw88 across three commits
between July 2024 and April 2025, all authored by Bitterblue Smith:

  commit 315c23a64e99 ("wifi: rtw88: usb: Support USB 3 with RTL8822CU/RTL8822BU")
  commit 82a35723a67c ("wifi: rtw88: usb: Support USB 3 with RTL8812AU")
  commit bf1103654df9 ("wifi: rtw88: usb: Enable switching the RTL8814AU to USB 3")

Test results
============

60 plug-cycles + 30+ gated throughput cells captured 2026-04-11
to 2026-05-07. Both x86_64 (Tiger Lake xHCI) and aarch64
(Broadcom RP1 xHCI) reproductions confirm the bug and the fix.

  Hosts:    Framework 13 (x86_64, Fedora 43 / 6.19.13, Tiger Lake xHCI)
            NucBox K8 Plus (x86_64, Arch Linux / 6.17.9, AMD F19h USB)
            Raspberry Pi 5 (aarch64, Pi OS / 6.12.47, BCM2712 + RP1)
            Banana Pi BPi-R4 Pro (aarch64, OpenWrt / 6.6.93, MT7988A;
                                  also used as a controlled lab AP)
  Adapters: D-Link DWA-X1850 A1 / B1 (RTL8852AU)
            BrosTrend AX1L compact / AX4L high-gain (RTL8852BU)
            BrosTrend AX8L AXE5400 / EDUP AXE5400 (RTL8852CU)
  APs:      consumer multi-band router (WPA3-SAE / WPA2-PSK)
            BPi-R4 Pro single-band lab AP (WPA3-SAE)
  Server:   Linux iperf3 host on 2.5 GbE wired Ethernet

Full per-cell evidence (raw iperf3 stdout, dmesg captures, sysfs
snapshots, iw link snapshots, byte-counter deltas, per-host detail)
at https://github.com/Lucid-Duck/rtw89-usb3-gap.

Plug-cycle. N=10 cycles per (chip, host) cell. Pass = post-plug
/sys/bus/usb/devices/<id>/speed reads 5000 (USB 3 SuperSpeed),
zero WARN/BUG/Oops in cycle-bracketed dmesg, non-empty association
BSSID after settle.

  Adapter (chip)               FW13 6.19      K8 Plus 6.17
  ---------------------------  -------------  --------------
  DWA-X1850 A1 (RTL8852AU)     10/10 PASS     10/10 PASS
  BrosTrend AX1L (RTL8852BU)   10/10 PASS     10/10 PASS

  FW13:    Fedora 43, 6.19.13, wireless-next + this patch
  K8 Plus: Arch Linux, 6.17.9-arch1-1, morrownr/rtw89 (upstream
           fork; identical AX-gen behavior to this patch)

Throughput. TCP iperf3, N=10 30-second iterations per sub-cell,
four sub-cells per cell (P=8 and P=1, each direction), to a Linux
2.5 GbE host. Per-cell /32 host route forces traffic onto the WiFi
adapter; per-iteration byte-counter cross-check on every cited cell
shows wireless tx/rx delta at 103-108% of iperf3 reported bytes
(excess is normal TCP/IP framing), so wired-NIC bleed is ruled out.
Linux tuning applied (rmem 32 MB, RPS=ff on the WiFi RX queue).

FW13 stock (in-kernel rtw89, USB 2 stuck) vs patched (USB 3
SuperSpeed), same adapter / AP / kernel / capture script, P=8 mean
Mbps, AP is the consumer multi-band router:

  Adapter (chip)              Band, width      UL stock  UL patched  DL stock  DL patched
  --------------------------  ---------------  --------  ----------  --------  ----------
  EDUP AXE5400 (RTL8852CU)    6 GHz, 160 MHz       269        1364       327         579
  AX8L AXE5400 (RTL8852CU)    6 GHz, 160 MHz       269        1440       324         510
  AX4L AX1800 (RTL8852BU)     5 GHz,  80 MHz       208         597       293         695
  AX1L AX1800 (RTL8852BU)     5 GHz,  80 MHz       235         608       273         843
  DWA-X1850 A1 (RTL8852AU)    5 GHz,  80 MHz       254         748       264         707
  DWA-X1850 B1 (RTL8852AU)    5 GHz,  80 MHz       248         706       265         679

USB enumeration verified at SuperSpeed (5000 Mbps) on every
patched cell, both pre and post.

K8 Plus second-rig spot check, kernel 6.17.9-arch1-1, consumer
multi-band router, single-link 5 GHz 80 MHz, TCP P=1, N=10:

  DWA-X1850 A1 (RTL8852AU)    788 UL / 693 DL Mbps (sigma 16 / 54)

For comparison, every stock cell above caps at 208-327 Mbps, the
USB 2.0 ceiling.

Submission notes
================

Applies cleanly on pkshih/rtw rtw-next HEAD c1ed02655f91.
checkpatch.pl --strict: zero errors, zero warnings, zero checks.

Bitterblue Smith (1):
  wifi: rtw89: usb: Support switching to USB 3 mode

 drivers/net/wireless/realtek/rtw89/reg.h |  4 +++
 drivers/net/wireless/realtek/rtw89/usb.c | 41 ++++++++++++++++++++++++
 2 files changed, 45 insertions(+)

--
2.53.0


