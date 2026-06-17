Return-Path: <linux-wireless+bounces-37875-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id m3iiJsMVM2ot9QUAu9opvQ
	(envelope-from <linux-wireless+bounces-37875-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jun 2026 23:46:43 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 374E769C90F
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jun 2026 23:46:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=mythread.it header.s=a1 header.b=k2VbzSkn;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37875-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37875-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=mythread.it;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5DFFB308056B
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jun 2026 21:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA0A63BB664;
	Wed, 17 Jun 2026 21:46:05 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtpcmd14162.aruba.it (smtpcmd14162.aruba.it [62.149.156.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29312ECEB9
	for <linux-wireless@vger.kernel.org>; Wed, 17 Jun 2026 21:46:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781732765; cv=none; b=NbZviw0IBnsiJk1DEjfLHT1iBSd+m6Z+RuPsciqjMVup5JP3fgflpODNzdCer8DL7tlXzmubPYIQo9rS012op2kqxzDguG22slBgAR1W7tEAmn9Uo5bM/Bbs5EVP6ozwMlHwi9Q5kAaxoye5AWI4BBWpol3udNSTQnWFQZSK+Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781732765; c=relaxed/simple;
	bh=f+XtEgkPLZSHekMUUvMVbtdPZm0NJYx2eEDhla3URaM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=TwC5JC43ZeZyFrN604vkmnmp7Be0Pch5lvouIQ0RAPj1P8VuZxKlLILuLAqe62zIOofSlxzumjD9Dpk/US3TbTAcPUHphT59EOlcsKeLWGZP64ohc/ddLhrmPhv9S7U6SeXYDe9jysbFoF5KmMaWxh0592STHYhk0mHzOy10hlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mythread.it; spf=pass smtp.mailfrom=mythread.it; dkim=pass (2048-bit key) header.d=mythread.it header.i=@mythread.it header.b=k2VbzSkn; arc=none smtp.client-ip=62.149.156.162
Received: from [192.168.1.237] ([94.34.125.0])
	by Aruba SMTP with ESMTPSA
	id Zy28wJnjp4OeoZy28w468w; Wed, 17 Jun 2026 23:42:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mythread.it; s=a1;
	t=1781732572; bh=f+XtEgkPLZSHekMUUvMVbtdPZm0NJYx2eEDhla3URaM=;
	h=From:Subject:Date:MIME-Version:Content-Type:To;
	b=k2VbzSknT7viOgP9pXtVmlAThTv7A0jk7DaiSiD90PeLGjM3tenS+5J+RIkv+ctMc
	 eF2mx804mgO5X3l9mPnxm4WQ56Ma2UukSEdg/b0z5X52GM7lgWauUeTfAOdx+lltdM
	 Mlqg9/i69Yl4YVSZ3ujYtSp/nCu0rM5/a2JKZ4ZzdMCCAkPv2448iEQAPrGk6Ey8Zf
	 ukL1pSQ6JElpUj04o2VoWhLOWZlRDKhRfczqXXs654xPKfataJzMX07Nae2X2EQrag
	 piG7OvPw8IJXS8gtEjXi5H0Qx5xX8L+c9AG6mruupRlQZ1Mqm7jTrMQ95zDWQW9NYG
	 7OIwdbBu2vFsg==
From: Alessio Ferri <alessio.ferri@mythread.it>
Subject: [PATCH 0/4] bcma/ssb/b43: BCM4352 AC-PHY wip
Date: Wed, 17 Jun 2026 23:42:07 +0200
Message-Id: <20260617-b43-add-4352-wip-v1-0-c81323496720@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MPQqAMAxA4atIZgO28f8q4lBN1CwqLahQvLvF8
 RveixDEqwToswheLg167Akmz2De3L4KKieDLWxd1KbBqSR0zFhSZfHWExeayRGbquMWUnZ6WfT
 5l8P4vh8yHx2+YgAAAA==
X-Change-ID: 20260617-b43-add-4352-wip-f3c3a3d159d8
To: =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <zajec5@gmail.com>, 
 Michael Buesch <m@bues.ch>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 b43-dev@lists.infradead.org, Alessio Ferri <alessio.ferri@mythread.it>, 
 Alessio Ferri <alessio.ferri.3012@gmail.com>
X-Mailer: b4 0.14.3
X-CMAE-Envelope: MS4xfLXwwPZf+zvRvaxi04KLBEA+7NwsGZPt9cEHom9ia9PgTlNGuLphhMD0DYzzhzekT46IGqoJ5Ci+Kv0ZjxbyfCH3JefsPZwnhqNHbOgW39uO49hQBP5p
 Splrew9fv0Oh69c1jydST3GMK31ZUjC2UNWnoBedbHQHGbshruON6Pz7A298As4uFC4oG9gmHfKSkUFr2W+nN1X4HXptdwrPjekUYgEDcY6s8vUJt6eqj0Fv
 NkbAHhct2USse8BkK/cgGQoJ+B8SKA7b8l4bZrIvCqox+9UWYLSs2vcQlRgCxJ6rHt3v1JXYEPfKlyHmPkRDv/93Wu1CrnlNm0XJ5MFzVYv2fi8zEwrBkUPR
 w39iFSpaFaIwlk86rmDfMUFWpRSJQHuJ7f6yX/k1jmw6tW/Ke63EXNVeykJ/I3AUlt4Rk1n3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_MATCH_TO(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[mythread.it,none];
	R_DKIM_ALLOW(-0.20)[mythread.it:s=a1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37875-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,bues.ch];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:zajec5@gmail.com,m:m@bues.ch,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:b43-dev@lists.infradead.org,m:alessio.ferri@mythread.it,m:alessio.ferri.3012@gmail.com,m:alessioferri3012@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[alessio.ferri@mythread.it,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[mythread.it:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alessio.ferri@mythread.it,linux-wireless@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,mythread.it,gmail.com];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mythread.it:dkim,mythread.it:email,mythread.it:from_mime,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 374E769C90F

This series introduce the initial support for BCM4352, an AC class
chip, this is just a gentle introduction before the bulk of edits, 
because in reality i already have AC support working up to RX signal 
and now debugging TX.
From the latest dmesg grepped from my router, this patch series allow
the user to reach to the "Bus registered" message plus the correct init
of the DMA that took me two weeks to discover.

[   18.280000] bcma-pci-bridge 0000:01:00.0: enabling device (0000 -> 0002)
[   18.280000] bcma-pci-bridge 0000:01:00.0: bus0: Found chip with id 0x4352, rev 0x03 and package 0x01
[   18.290000] bcma-pci-bridge 0000:01:00.0: bus0: Core 0 found: ChipCommon (manuf 0x4BF, id 0x800, rev 0x2B, class 0x0)
[   18.300000] bcma-pci-bridge 0000:01:00.0: bus0: Core 1 found: IEEE 802.11 (manuf 0x4BF, id 0x812, rev 0x2A, class 0x0)
[   18.320000] bcma-pci-bridge 0000:01:00.0: bus0: Core 2 found: ARM CR4 (manuf 0x4BF, id 0x83E, rev 0x02, class 0x0)
[   18.330000] bcma-pci-bridge 0000:01:00.0: bus0: Core 3 found: PCIe Gen2 (manuf 0x4BF, id 0x83C, rev 0x01, class 0x0)
[   18.340000] bcma-pci-bridge 0000:01:00.0: bus0: Core 4 found: USB 2.0 Device (manuf 0x4BF, id 0x81A, rev 0x11, class 0x0)
[   18.380000] bcma: bcma: SPROM rev 11 parsed: board=0x0668 rev=4947 ccode=0x0000 txchain=0x3 rxchain=0x3 antswitch=0 subband5gver=4
[   18.390000] bcma: bcma: SPROM r11 chain0 rxgains 2g={0,0,0} 5gl={3,6,1} 5gm={7,15,1} 5gh={7,15,1}
[   18.400000] bcma: bcma: SPROM r11 chain1 rxgains 2g={0,0,0} 5gl={3,6,1} 5gm={7,15,1} 5gh={7,15,1}
[   18.410000] bcma: bcma: SPROM r11 chain2 rxgains 2g={0,0,0} 5gl={3,6,1} 5gm={7,15,1} 5gh={7,15,1}
[   18.420000] bcma-pci-bridge 0000:01:00.0: bus0: Bus registered
[   19.340000] b43-phy0: Broadcom 4352 WLAN found (core revision 42)
[   19.340000] b43-phy0: Found PHY: Analog 12, Type 11 (AC), Revision 1
[   19.350000] b43-phy0: Found Radio: Manuf 0x17F, ID 0x2069, Revision 4, Version 0
[   44.250000] b43-phy0: DEBUG pre-PSM_RUN: MACCTL=0x00020504 IRQ_REASON=0x00000000 SHM[UCODEREV]=0x0000
[   44.260000] b43-phy0: DEBUG post-PSM_RUN: MACCTL=0x00020502 IRQ_REASON=0x00000000
[   44.260000] b43-phy0: Loading firmware version 784.2 (2012-08-15 21:43:22)
[   44.270000] b43-phy0: phy-ac: rxgain_init applied (2 cores, UNII-1 5gl, sprom rev 11)
[   44.280000] b43-phy0: phy-ac: rxgain core0: triso=6 elnagain=3 trelnabyp=1 (gainctx=0x14)
[   44.290000] b43-phy0: phy-ac: rxgain core1: triso=6 elnagain=3 trelnabyp=1 (gainctx=0x14)
[   44.500000] b43-phy0: DEBUG dma_setup RX DMA64: base=0x020c0000 alo=0x020c0000 ahi=0x80000000 addrext=0x0 translation=0x80000000 in_low=0 ctl=0x0000084d
[   44.720000] b43 bcma0:1 phy0-ap0: entered allmulticast mode
[   44.730000] b43 bcma0:1 phy0-ap0: entered promiscuous mode

The two patches generated with the help of claude are marked as such.
The other two are minimal and did not require assistance from claude.

Assisted-by: claude:claude-Opus-4.8
Signed-off-by: Alessio Ferri <alessio.ferri@mythread.it>
---
Alessio Ferri (4):
      bcma: host_pci: add BCM4352 device ID 0x43b3
      bcma: pmu: program max resource mask on BCM4352/BCM4360
      ssb: bcma: add SPROM revision 11 extraction
      b43: align DMA64 descriptor ring to 64K on AC cores

 drivers/bcma/driver_chipcommon_pmu.c    |   8 +++
 drivers/bcma/host_pci.c                 |   1 +
 drivers/bcma/sprom.c                    | 100 +++++++++++++++++++++++++++++++-
 drivers/net/wireless/broadcom/b43/dma.c |  20 +++++--
 include/linux/ssb/ssb.h                 |  31 ++++++++++
 include/linux/ssb/ssb_regs.h            |  44 ++++++++++++++
 6 files changed, 199 insertions(+), 5 deletions(-)
---
base-commit: e771677c937da5808f7b6c1f0e4a97ec1a84f8a8
change-id: 20260617-b43-add-4352-wip-f3c3a3d159d8

Best regards,
-- 
Alessio Ferri <alessio.ferri.3012@gmail.com>


