Return-Path: <linux-wireless+bounces-36439-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2K0rNZF6BmqFkAIAu9opvQ
	(envelope-from <linux-wireless+bounces-36439-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2026 03:44:49 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EFEB5487F7
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2026 03:44:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B6CEA30041D3
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2026 01:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CF15336EDE;
	Fri, 15 May 2026 01:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="IGDVr3Qz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA60C2C08AB
	for <linux-wireless@vger.kernel.org>; Fri, 15 May 2026 01:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778809486; cv=none; b=NNRBf7M+XebI8jCbhGJmqs9BwOQMPqgQGmEvEDe2JFkUl98O4DOBmJotTqfYKPbWSiQuQyjMJEV28MWLxApGEQhpaVbTCZugXC5nN1Ep0UV142GyF08atdSDUeyOffohWxedqvU9cElPGi4caypa8r/nD1anOufU2/ydFEMdlV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778809486; c=relaxed/simple;
	bh=g6Qwv2KNj+BTaJE47Dod2+MYXXgrONp7EFBIbwhHyJY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=luESjLG7qzM73b5TSbCkwDXg9ph5FRkUp6rsNZLY39jJiBZxrKm2jDS2r69I8PiHxOT65K70dWg7GBTWmazZ/B1qRXQegGDYKQhiB7H6UbbB+7afDbLxq0nwo/5z6KyYNvMpWU300Ay27R8U8WGeGU0+xUvtUJqE/SjURrHaeZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=IGDVr3Qz; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 64F1iflaF2587034, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1778809481; bh=C08if+aanXkAtJAY6zkI5DlVe27kc3O2lQ64JTTmv00=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=IGDVr3Qz7DmwHZXBolrkQzzyLYLHmXzdygM+DcG7OwpoG2F8CJja1+OQx1MGPE1wP
	 dW4qKc7UU8GXY341vWjpDAziDL11kFJUqPnbhy8YvGJDnp123MAy1ndRh2Mg9+YIbe
	 Z7q2tC14mHKrDv9lFNGHpH15kqmozTHwrRBqfv9IYvupCmhfrUcfdYRNId7jY5YGLn
	 8YWl9r3woiWUJ9/sv2nUm7sSAhOzt9vPGiX8Cr8mvBQPKCCu9qq4oSynU7VeLoT6Pc
	 DRUJnxbpDLkAntXAuxbgooseq60aIGF+ijiUa7MH2Wx3bR5L/xPWiHaImaxySexPXo
	 iR53cXj01H1KA==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.27/5.94) with ESMTPS id 64F1iflaF2587034
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 15 May 2026 09:44:41 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 15 May 2026 09:44:41 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS05.realtek.com.tw
 (10.21.1.55) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Fri, 15 May 2026 09:44:41 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <timlee@realtek.com>, <dian_syuan0116@realtek.com>, <phhuang@realtek.com>,
        <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 00/13] wifi: rtw89: update SER, PCI, WoW and quota settings
Date: Fri, 15 May 2026 09:44:20 +0800
Message-ID: <20260515014433.16168-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Rspamd-Queue-Id: 7EFEB5487F7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36439-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Update many stuffs according to internal updates.

Patches 1-3 are related to SER, which is to simulate SER trigger and dump
more related registers for debugging.

Patches 4-6 are PCIE PHY settings.

Patch 7 is to clear (reset) calibration value of delay function.

Patch 8 is to keep connection alive in WoWLAN mode.

Patch 9 is used to correct logic to handle malformed AMPDU packets.

Patches 10-13 are to extend quota definition for RTL8922D, because there
are many variants with different quota values.

Chin-Yen Lee (1):
  wifi: rtw89: wow: send ARP reply packets instead of Null packets to
    keep alive

Dian-Syuan Yang (1):
  wifi: rtw89: pci: enable LTR based on pcie control register

Ping-Ke Shih (7):
  wifi: rtw89: pci: not disable PCI completion timeout control for a
    variant of RTL8922DE
  wifi: rtw89: pci: disable PCI PHY error flag 8
  wifi: rtw89: clear auto K delay value before downloading firmware
  wifi: rtw89: 8922d: change naming number and update values for WDE/PLE
    quota
  wifi: rtw89: mac: add field of release report size to DLE quota
  wifi: rtw89: mac: consolidate quota into a struct for variant chips
  wifi: rtw89: 8922d: add quota for RTL8922DE variant

Po-Hao Huang (1):
  wifi: rtw89: correct drop logic for malformed AMPDU frames

Zong-Zhe Yang (3):
  wifi: rtw89: debug: Wi-Fi 7 show count of SER L0 simulation
  wifi: rtw89: debug: Wi-Fi 7 update simulation of SER L0/L1 by halt H2C
    command
  wifi: rtw89: fw: dump status of H2C command and C2H event for SER

 drivers/net/wireless/realtek/rtw89/core.c     |   3 +-
 drivers/net/wireless/realtek/rtw89/core.h     |  21 +++-
 drivers/net/wireless/realtek/rtw89/debug.c    | 107 ++++++++----------
 drivers/net/wireless/realtek/rtw89/fw.c       |  12 +-
 drivers/net/wireless/realtek/rtw89/mac.c      |  26 ++++-
 drivers/net/wireless/realtek/rtw89/mac.h      |  27 ++++-
 drivers/net/wireless/realtek/rtw89/mac80211.c |   3 +-
 drivers/net/wireless/realtek/rtw89/mac_be.c   |   7 ++
 drivers/net/wireless/realtek/rtw89/pci.c      |  30 ++++-
 drivers/net/wireless/realtek/rtw89/pci.h      |   4 +-
 drivers/net/wireless/realtek/rtw89/pci_be.c   |   3 +
 drivers/net/wireless/realtek/rtw89/reg.h      |   4 +
 drivers/net/wireless/realtek/rtw89/rtw8851b.c |   6 +-
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |   6 +-
 drivers/net/wireless/realtek/rtw89/rtw8852b.c |   6 +-
 .../net/wireless/realtek/rtw89/rtw8852bt.c    |   6 +-
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |   6 +-
 drivers/net/wireless/realtek/rtw89/rtw8922a.c |   7 +-
 drivers/net/wireless/realtek/rtw89/rtw8922d.c |  96 +++++++++++++---
 19 files changed, 275 insertions(+), 105 deletions(-)


base-commit: 4c13e00cc6798f8e63354982ec172b7829ae825a
-- 
2.25.1


