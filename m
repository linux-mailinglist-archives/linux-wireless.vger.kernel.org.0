Return-Path: <linux-wireless+bounces-36105-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8IViGEB6/Wm6ewAAu9opvQ
	(envelope-from <linux-wireless+bounces-36105-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 08 May 2026 07:53:04 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CF1BC4F2201
	for <lists+linux-wireless@lfdr.de>; Fri, 08 May 2026 07:53:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DDF3430BAAAE
	for <lists+linux-wireless@lfdr.de>; Fri,  8 May 2026 05:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BD05373BEB;
	Fri,  8 May 2026 05:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=justthetip.ca header.i=@justthetip.ca header.b="ONBEzCSM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A4D372698
	for <linux-wireless@vger.kernel.org>; Fri,  8 May 2026 05:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778219084; cv=none; b=EQRv5EKFeikAdYwL83hFlUUuqeTJEyQD5+govN78F+DpvKC2GuQ3+fKhb0c7QMhpjT7GtnXO8WiZQbIhSSqTt9C9jM9gQA1XV8G44coqq6ieWhOGZkEwWOzVFfbmHjPWipTVgiuRLYErOgteZMYrXkmDINfirXAw64YK+A4JrjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778219084; c=relaxed/simple;
	bh=vxHNWCSxekTiBjGgZHrWefFWfIrepGngUj2Qw/3eACc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sGwYOBCuZqJvuJ1K7mgLqIWCb3yd51lYNB2MFWQ2K8stl+XGGr8DLN8lW4R+VZdlARkiNe7Hxv4Lvr2HJE8WxE6L/vqiiMG/YHArpfyAi24jEzi4fS/8IVa00fWiOSS6d/fKy/hYKX3LnrU0NrIWB6TS7Og+Ih1HtVC+gz7b0BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=justthetip.ca; spf=pass smtp.mailfrom=justthetip.ca; dkim=pass (2048-bit key) header.d=justthetip.ca header.i=@justthetip.ca header.b=ONBEzCSM; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=justthetip.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=justthetip.ca
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=justthetip.ca;
	s=key1; t=1778219069;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=QOA24LwO7qZP1kUENXRKqVBU39k5xTFSJ/ib56rUT/o=;
	b=ONBEzCSMWWq2Df7OWH9D5EgEiAv90bLF82VvZFwONfpPOdT+LZh7BlRH262dG3YuFptM5v
	kud4eJJohtvzDVNPVN1O7BM1WqajT7gwTerhLLDrxFHalIBh4BX0pOl76+Gd5/F1yrUKbS
	CCor/7ceIlGGV/mAxjKJyBbCyUa8Bi6da/fQNcYOU+zyuzIKbrOlvcLFl6wB3L+Ry3OIyZ
	p2QMLlaCxIgaKcX6dUTVhBBegUFGwUGsx55LA4mFefUCZL5yo+lEC1Z5C+H604KkzKLj8d
	gaWBqA37q+qEcXIaNTsB3SFTfNPa6nqZYTLOilzx2mmYbKhdhPB8pljw5Movgg==
From: Lucid Duck <lucid_duck@justthetip.ca>
To: linux-wireless@vger.kernel.org
Cc: Ping-Ke Shih <pkshih@realtek.com>,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	linux-kernel@vger.kernel.org,
	Devin Wittmayer <lucid_duck@justthetip.ca>
Subject: [PATCH 0/1] wifi: rtw89: usb: Support switching to USB 3 mode
Date: Thu,  7 May 2026 22:44:20 -0700
Message-ID: <20260508054421.128938-1-lucid_duck@justthetip.ca>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: CF1BC4F2201
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[justthetip.ca,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[justthetip.ca:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[realtek.com,gmail.com,vger.kernel.org,justthetip.ca];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-36105-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucid_duck@justthetip.ca,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[justthetip.ca:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,justthetip.ca:email,justthetip.ca:mid,justthetip.ca:dkim,checkpatch.pl:url]
X-Rspamd-Action: no action

From: Devin Wittmayer <lucid_duck@justthetip.ca>

This patch adds USB 2 to USB 3 mode switching for the AX-generation
chips in the rtw89 USB driver (8852AU, 8852BU, 8852CU and helper
variants). Without it, those adapters enumerate at USB 2.0
high-speed on first plug and stay there, capping real-world
throughput around 260 Mbps TCP regardless of radio capability.

It is Bitterblue Smith's morrownr/rtw89 commit cd287ccf544b
(2025-07-16) rebased onto wireless-next without code changes:
author's Signed-off-by preserved, my Signed-off-by added as
relayer, Tested-by per chip based on the matrix below.

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

Reviewer of record: Ping-Ke Shih, current rtw89 maintainer.

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

Future work: BE-generation (RTL8922AU) USB switch-mode
======================================================

The same mechanism applies to BE-generation chips (RTL8922AU) via
R_BE_PAD_CTRL2.
The implementation is in morrownr/rtw89 commit c8a8ac49996b
("wifi: rtw89: usb: USB 3 switching for RTL8922AU", 2025-08-07)
by Bitterblue Smith, but that commit has no Signed-off-by; the
public two-week notice in
https://github.com/morrownr/rtw89/issues/82 (2026-04-21,
deadline 2026-05-05) did not produce one. checkpatch --strict
rejects third-party submission on the missing trailer.

I tested c8a8ac49996b on a BrosTrend BE6500 (RTL8922AU): plug-
cycle 10/10 PASS on both FW13 and K8 Plus; consumer-router MLO
3-link 1430 UL / 995 DL Mbps P=8; BPi-R4 Pro single-link 5 GHz
160 MHz EHT 1335 UL / 1058 DL Mbps P=8; switch_usb_mode=N forces
USB 2 at 255 UL / 311 DL Mbps. Detail in the rtw89-usb3-gap repo
above.

Adding the BE-gen switch-mode to mainline today cannot yet help
RTL8922AU users on its own, because mainline rtw89 has no
in-kernel rtw89_8922au USB driver: RTL8922AU adapters do not
attach to mainline at all. Switch-mode becomes load-bearing for
BE-gen the moment the rtw89_8922au USB driver lands upstream;
until then it would sit as dormant code. The path upstream for
the switch-mode itself is either Bitterblue's Signed-off-by on
c8a8ac49996b, or a Realtek developer carrying it as part of the
broader 8922au USB enablement.

(The AX-gen gap that this patch fixes does affect every mainline
user with an RTL8852AU/BU/CU adapter today. BE-gen is a separate,
strictly forward-looking concern.)

Submission notes
================

Applies cleanly on wireless-next HEAD 7baf5857e15d.
checkpatch.pl --strict: zero errors, zero warnings, zero checks.

Bitterblue Smith (1):
  wifi: rtw89: usb: Support switching to USB 3 mode

 drivers/net/wireless/realtek/rtw89/reg.h |  4 +++
 drivers/net/wireless/realtek/rtw89/usb.c | 41 ++++++++++++++++++++++++
 2 files changed, 45 insertions(+)

--
2.53.0


