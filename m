Return-Path: <linux-wireless+bounces-31353-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wEl5HdVcfGkYMAIAu9opvQ
	(envelope-from <linux-wireless+bounces-31353-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 08:25:09 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E8453B7E51
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 08:25:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F2F033012BD6
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 07:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9B4B24729A;
	Fri, 30 Jan 2026 07:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="szH8vbsu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E1A2620E5
	for <linux-wireless@vger.kernel.org>; Fri, 30 Jan 2026 07:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769757904; cv=none; b=T4Sc06cbx+or7c1TLNY8Wm7VtZN/uLqAvRoQ8QlHR+bC8ZAXBiRrxaCVAdkLS+znG7z4yoYSU5KW6FTnCsxUg0wZmtpS6BfpcFf4ZndeRHNDCA9ZZWOtLZft/jkM81zla0gfFMOn19mvwWNzAV2xU5AAL8XKwRfOtK58ohkDcCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769757904; c=relaxed/simple;
	bh=5+X9c6hunYrPp6VzT9+AmoIHnb6QsEe5sNe3Oq6Mhxg=;
	h=From:To:Subject:Message-ID:Date:MIME-Version:Content-Type; b=oSEQb6jkIMdcGQEGZgr8LIGLr6BwZZ5d14xVU8Ovno9OKQ6qjNvUTJES0rBKM2Mf7fFW/MzXNpxMuH1mM1Qq/k2gBoeMOEnZm4rkaEmFSYWvONDQPLxZ+NjKMiwNCixklBvpN8eE5woEY6EvpXtDAp7ARXLVY1g787DZdA/PFTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=szH8vbsu; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 60U7P0lC4495495, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1769757900; bh=3I23nPjhQ3A5Iwr4Ysq1U4hS8eNSYjwPJSdVIsv/Cuw=;
	h=From:To:Subject:Message-ID:Date:MIME-Version:Content-Type;
	b=szH8vbsu3rkUsqzYH2zpVubMhI1wOY4cuLgVYWdp1GVn+3357UzCjSEu7HuQ0zoMa
	 rakb1R+vE3amMA/yvlKr5H3IeHhwUXnBUfdFUd+59jv23PB3bG74snw8Tk+bIHjV3I
	 7a/nqcu2TK0j+lN7OyjOwme88HBwkXch7pH6esgpmnVTxqE4wUnwjHauDjBfJo7xMU
	 DJMfo8bdtyF2CjgQzX4Eod8LjBfHtRRiTusGJjzh4C2jnfhxnYaHLq2pz0C2h6RbJ+
	 eTc1dvSz4Isk4pKe7VujX5rdI8NSFcBsZqkqdvoABqTjKIQ9vpxJUbdL9JjdqMkoCK
	 abJPm9l3Uz0Nw==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 60U7P0lC4495495
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 30 Jan 2026 15:25:00 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 30 Jan 2026 15:25:01 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 30 Jan 2026 15:20:00 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Fri, 30 Jan 2026 15:20:00 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: pull-request: rtw-next-2026-01-30
Message-ID: <ceb89fce-d448-4978-9063-ee79641131a6@RTKEXHMBS03.realtek.com.tw>
Date: Fri, 30 Jan 2026 15:20:00 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31353-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	DKIM_TRACE(0.00)[realtek.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,realtek.com:dkim,RTKEXHMBS03.realtek.com.tw:mid];
	TO_DN_NONE(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: E8453B7E51
X-Rspamd-Action: no action

Hi,

This is another rtw-next pull-request to wireless-next tree in this -next
cycle. Please let me know if any problems.

Thanks
Ping-Ke

---

The following changes since commit 1e1dd9eeaab3908746d1dce5db6b0c29e0d28d6d:

  wifi: mac80211: mark iface work SKBs as consumed (2026-01-19 10:22:35 +0100)

are available in the Git repository at:

  https://github.com/pkshih/rtw.git tags/rtw-next-2026-01-30

for you to fetch changes up to 4c1552473acf03cad828884b4e1c90b97a89b265:

  wifi: rtw89: pci: warn if SPS OCP happens for RTL8922DE (2026-01-30 13:56:19 +0800)

----------------------------------------------------------------
rtw-next patches for -next

Mainly refactor flow for preparation of rtw89 RTL8922DE. Others are random
fixes and refinements.

----------------------------------------------------------------
Chih-Kang Chang (1):
      wifi: rtw89: wow: disable interrupt before swapping FW for 8922D

Dian-Syuan Yang (1):
      wifi: rtw89: pci: restore LDO setting after device resume

Eric Huang (5):
      wifi: rtw89: phy: extend register to read history 2 of PHY env_monitor
      wifi: rtw89: phy: update bb wrapper TPU init
      wifi: rtw89: phy: handle C2H event for PS mode report
      wifi: rtw89: phy: add H2C command to send detail RX gain and link parameters for PS mode
      wifi: rtw89: phy: update edcca log parsing for RTL8922D

Marco Crivellari (1):
      wifi: rtw88: add WQ_PERCPU to alloc_workqueue users

Ping-Ke Shih (22):
      wifi: rtw89: mac: clear global interrupt right after power-on
      wifi: rtw89: phy: add {read,write}_rf_v3 for RTL8922D
      wifi: rtw89: phy: add ops rtw89_phy_gen_be_v1 for RTL8922D
      wifi: rtw89: phy: abstract start address and EHT of PHY status bitmap
      wifi: rtw89: phy: abstract BB wrap registers to share initial flow
      wifi: rtw89: phy: update BB wrapper RFSI
      wifi: rtw89: phy: write BB wrapper registers with flush
      wifi: rtw89: phy: refine initial flow of BB wrapper
      wifi: rtw89: phy: add chip_ops to calculate RX gain from efuse to support PS mode
      wifi: rtw89: phy: add firmware element of digital TX power compensation
      wifi: rtw89: mac: clear DTOP disable excluding CID7090 variant for RTL8922D
      wifi: rtw89: mac: set force MBA duration to 0
      wifi: rtw89: rfk: add firmware command to do TX IQK
      wifi: rtw89: rfk: add to print debug log of TX IQK
      wifi: rtw89: rfk: add firmware command to do CIM3K
      wifi: rtw89: rfk: add to print debug log of CIM3K
      wifi: rtw89: rfk: update RFK report format of IQK, DACK and TXGAPK
      wifi: rtw89: fw: correct content of DACK H2C command
      wifi: rtw89: phy: add PHY C2H event dummy handler for func 1-7 and 2-10
      wifi: rtw89: pci: validate release report content before using for RTL8922DE
      wifi: rtw89: mac: set MU group membership and position to registers
      wifi: rtw89: pci: warn if SPS OCP happens for RTL8922DE

Po-Hao Huang (3):
      wifi: rtw89: phy: fix incorrect power limit by mac_id
      wifi: rtw89: fix unable to receive probe responses under MLO connection
      wifi: rtw89: 8922a: add digital compensation for 2GHz

Shin-Yi Lin (1):
      wifi: rtw89: Add default ID 28de:2432 for RTL8832CU

Zilin Guan (1):
      wifi: rtw89: debug: Fix memory leak in __print_txpwr_map()

Zong-Zhe Yang (6):
      wifi: rtw89: phy: update TSSI flow for RTL8922D
      wifi: rtw89: 8922a: configure FW version for SIM_SER_L0L1_BY_HALT_H2C
      wifi: rtw89: get designated link to replace link instance 0
      wifi: rtw89: regd: update regulatory map to R73-R54
      wifi: rtw89: debug: rename mac/ctrl error to L0/L1 error
      wifi: rtw89: debug: tweak Wi-Fi 7 SER L0/L1 simulation methods

 drivers/net/wireless/realtek/rtw88/usb.c       |   3 +-
 drivers/net/wireless/realtek/rtw89/chan.c      |  31 +-
 drivers/net/wireless/realtek/rtw89/core.h      |  40 +-
 drivers/net/wireless/realtek/rtw89/debug.c     |  97 +++--
 drivers/net/wireless/realtek/rtw89/debug.h     |   1 +
 drivers/net/wireless/realtek/rtw89/fw.c        | 297 ++++++++++++-
 drivers/net/wireless/realtek/rtw89/fw.h        | 188 ++++++++-
 drivers/net/wireless/realtek/rtw89/mac.c       |  23 +-
 drivers/net/wireless/realtek/rtw89/mac.h       |  23 +
 drivers/net/wireless/realtek/rtw89/mac80211.c  |   4 +-
 drivers/net/wireless/realtek/rtw89/mac_be.c    |  23 +-
 drivers/net/wireless/realtek/rtw89/pci.c       |  17 +-
 drivers/net/wireless/realtek/rtw89/pci.h       |   1 +
 drivers/net/wireless/realtek/rtw89/pci_be.c    |   2 +
 drivers/net/wireless/realtek/rtw89/phy.c       | 381 +++++++++++++++--
 drivers/net/wireless/realtek/rtw89/phy.h       |  36 +-
 drivers/net/wireless/realtek/rtw89/phy_be.c    | 563 ++++++++++++++++++++++++-
 drivers/net/wireless/realtek/rtw89/ps.c        |   2 +
 drivers/net/wireless/realtek/rtw89/reg.h       | 368 +++++++++++++++-
 drivers/net/wireless/realtek/rtw89/regd.c      |  20 +-
 drivers/net/wireless/realtek/rtw89/rtw8851b.c  |   1 +
 drivers/net/wireless/realtek/rtw89/rtw8852a.c  |   1 +
 drivers/net/wireless/realtek/rtw89/rtw8852b.c  |   1 +
 drivers/net/wireless/realtek/rtw89/rtw8852bt.c |   1 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c  |   1 +
 drivers/net/wireless/realtek/rtw89/rtw8852cu.c |   2 +
 drivers/net/wireless/realtek/rtw89/rtw8922a.c  |  58 ++-
 drivers/net/wireless/realtek/rtw89/wow.c       |   6 +-
 28 files changed, 2047 insertions(+), 144 deletions(-)

