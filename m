Return-Path: <linux-wireless+bounces-38728-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ElKfAVjGTGo6pgEAu9opvQ
	(envelope-from <linux-wireless+bounces-38728-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Jul 2026 11:26:48 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CEB2719BE3
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Jul 2026 11:26:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=realtek.com header.s=dkim header.b="akqVaOn/";
	dmarc=pass (policy=none) header.from=realtek.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38728-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38728-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 76B10313F08F
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Jul 2026 09:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41434395AED;
	Tue,  7 Jul 2026 09:11:56 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F2438F251
	for <linux-wireless@vger.kernel.org>; Tue,  7 Jul 2026 09:11:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783415516; cv=none; b=JGSPAbtZgH5k5U0kfNNwP+dTDgvOzfwHUZ03Yps/L0CQgfkY1zz7L38h0OVNNhpi66XRNv3jGoaff4GmLTfJXyc50yzcyrzmsAqECJfYUAa0GbcMqxGm+q/L/ylSiCYpzDkv92AgfhU85/wJFX3WYfPA43HtdAJ3Ly7IsL7k0mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783415516; c=relaxed/simple;
	bh=8eDzQWPjoqL5O0CJt7ZfdMpD3OBrstj8P2EmEctvAJ4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NQyJ46JFKbzIPQpBlgdeSXeAVa2BJSVIWeUO243j8GIVcVQecEw+28w0YT5M4pbG5lDYKoHEqvI+V/eO09G2lb8LFc7NCFNXBUiItHVIrhUVyWlXnHoN1HEEvVie88F/HzxPkgIvAzZpSo1IlgFmQVRKQh2ApbzvZOK6w1F2stw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=akqVaOn/; arc=none smtp.client-ip=211.75.126.72
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6679BqbT61359400, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1783415512; bh=qUggzElK38QK6LwvAvrEERcnHF5e3ydTZjXGbE+LqMg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=akqVaOn/L/PO3T0It8o5NF5icLd95bg40Dk+/Mt9Hsc3XSWZIQVp5FyZ3zS2i6ajK
	 E6EDpSJ4vMPmADaTTZolAuFqbRt1EY9g97T5SMvmFkgYE38OgBlMtk1I3aYf4PB/wm
	 9xy0gBQUB0l0D1LiOmWP4565qmVMdDgj6DjjMEYFaHjcD5C3mHF00BFb4iWyJ6HNsS
	 jDtuS+QR8KIH3GOed7pTCYt7EMMR7vkG/Lj6tXxtUoP2bF54GOKar09TMTkjijZxq+
	 FTR56nsorO/GpI8JqPqSIARlmZ+339foIYiCVNKpse8xgwD7mWqS7yrokAnh7JoNvz
	 dVu9sTbq/cziQ==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 6679BqbT61359400
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <linux-wireless@vger.kernel.org>; Tue, 7 Jul 2026 17:11:52 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 7 Jul 2026 17:11:52 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 7 Jul 2026 17:11:52 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Tue, 7 Jul 2026 17:11:52 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <echuang@realtek.com>
Subject: [PATCH rtw-next 00/15] wifi: rtw89: add voltage thermal protect and some random patches for RTL8922D
Date: Tue, 7 Jul 2026 17:10:41 +0800
Message-ID: <20260707091056.42771-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-38728-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-wireless@vger.kernel.org,m:gary.chang@realtek.com,m:echuang@realtek.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,realtek.com:from_mime,realtek.com:dkim,realtek.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7CEB2719BE3

First 5 patches and patch 11 and 13 are related to PHY settings to
improve PHY performance.

Patches 6-9 are main change to support voltage thermal protection, which
adjusts voltage according to thermal value to reduce power consumption.

Patch 10 is to adjust hardware clock for ANA circuit.

Patch 12 is a improvement of RTL8852A.

Since we have prepared firmware containing BB/RF parameters and etc, notify
users that we are going to remove built-in tables of BB/RF parameters from
driver. Patches 14-15 are to add transition state to notify users to update
their old firmware. Currently users can still use old firmware, and we plan
to remove built-in tables years later.

Chih-Kang Chang (1):
  wifi: rtw89: 8852a: fix RSSI report when average beacon RSSI is not
    ready

Eric Huang (4):
  wifi: rtw89: 8922d: remove CCK bandwidth compensation
  wifi: rtw89: 8922d: dynamic adjust channel smoothing
  wifi: rtw89: 8922d: fix EMLSR BB switch sequence for MLO mode
    transition
  wifi: rtw89: phy: fix bandedge primary channel for 2.4GHz 40MHz and
    6GHz

Ping-Ke Shih (10):
  wifi: rtw89: 8922d: set TX compensation by format v2
  wifi: rtw89: efuse: no need to export rtw89_efuse_read_ecv_be()
  wifi: rtw89: efuse: read thermal calibration value for RTL8922D
  wifi: rtw89: 8922d: read default digital voltage calibration values
  wifi: rtw89: add thermal protect by digital voltage reduction
  wifi: rtw89: 8922d: set ANA CLK enter to 500KHz
  wifi: rtw89: 8922d: update scaling factor for RX path
  wifi: rtw89: phy: add NCTL check for WiFi 7 chips
  wifi: rtw89: unify access struct of TX power track tables
  wifi: rtw89: set needed firmware elements for early chips transition

 drivers/net/wireless/realtek/rtw89/core.c     |  17 ++
 drivers/net/wireless/realtek/rtw89/core.h     |  34 +++
 drivers/net/wireless/realtek/rtw89/debug.c    |   1 +
 drivers/net/wireless/realtek/rtw89/efuse.h    |   7 +
 drivers/net/wireless/realtek/rtw89/efuse_be.c | 117 ++++++++++-
 drivers/net/wireless/realtek/rtw89/fw.c       |  10 +
 drivers/net/wireless/realtek/rtw89/fw.h       |  27 ++-
 drivers/net/wireless/realtek/rtw89/mac.c      |   7 +
 drivers/net/wireless/realtek/rtw89/mac.h      |  47 +++++
 drivers/net/wireless/realtek/rtw89/mac_be.c   |  40 ++++
 drivers/net/wireless/realtek/rtw89/phy.c      |  33 +++
 drivers/net/wireless/realtek/rtw89/phy.h      |  25 +--
 drivers/net/wireless/realtek/rtw89/phy_be.c   |  45 +++-
 drivers/net/wireless/realtek/rtw89/reg.h      |  53 +++++
 drivers/net/wireless/realtek/rtw89/rtw8851b.c |   4 +-
 .../net/wireless/realtek/rtw89/rtw8851b_rfk.c |  20 +-
 .../wireless/realtek/rtw89/rtw8851b_table.c   |  15 +-
 .../wireless/realtek/rtw89/rtw8851b_table.h   |   2 +-
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |   6 +-
 .../net/wireless/realtek/rtw89/rtw8852a_rfk.c |  36 ++--
 .../wireless/realtek/rtw89/rtw8852a_table.c   |  27 +--
 .../wireless/realtek/rtw89/rtw8852a_table.h   |   2 +-
 drivers/net/wireless/realtek/rtw89/rtw8852b.c |   4 +-
 .../net/wireless/realtek/rtw89/rtw8852b_rfk.c |  36 ++--
 .../wireless/realtek/rtw89/rtw8852b_table.c   |  27 +--
 .../wireless/realtek/rtw89/rtw8852b_table.h   |   2 +-
 .../net/wireless/realtek/rtw89/rtw8852bt.c    |   1 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |   4 +-
 .../net/wireless/realtek/rtw89/rtw8852c_rfk.c | 101 ++++-----
 .../wireless/realtek/rtw89/rtw8852c_table.c   |  35 ++--
 .../wireless/realtek/rtw89/rtw8852c_table.h   |   2 +-
 drivers/net/wireless/realtek/rtw89/rtw8922a.c |   1 +
 drivers/net/wireless/realtek/rtw89/rtw8922d.c | 196 ++++++++++++++----
 33 files changed, 750 insertions(+), 234 deletions(-)


base-commit: 2b7858891b100587c10c136cf07205335a897be0
-- 
2.25.1


