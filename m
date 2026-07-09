Return-Path: <linux-wireless+bounces-38810-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id njvtFD1UT2pDegIAu9opvQ
	(envelope-from <linux-wireless+bounces-38810-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 09 Jul 2026 09:56:45 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B8FF072DFCC
	for <lists+linux-wireless@lfdr.de>; Thu, 09 Jul 2026 09:56:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=mediatek.com header.s=dk header.b=stHWIHxD;
	dmarc=pass (policy=quarantine) header.from=mediatek.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38810-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38810-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 500A23028E99
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Jul 2026 07:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBA423D75AB;
	Thu,  9 Jul 2026 07:56:22 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD48F3DF009
	for <linux-wireless@vger.kernel.org>; Thu,  9 Jul 2026 07:56:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783583782; cv=none; b=oRhN/ynMGdE2uniLuB7aGDjhi26PP3vG6zEb6Xx1IT/LrkS6/C/z1WsHPLe7S7H3EKQqVMaPNMufsydU0p5DlV+GP/ngkZR9GhzWiag+ka5GuYFEyDkHmsTA6vw9f2twElf2YkM3LCiidk1THuXh3cXyEnPQ8iDRL2mpXoEzx/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783583782; c=relaxed/simple;
	bh=KdV7ZNl/uIA7O9vBF9sUTQNyMVZlG0bEb0Haz7SAsO4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=W0tSqdmJ7sBpbDkG15/Pjj1NfjtXda/DU9W3ovLGwbxDaoaybR3Zo0aC3mXKXimONzYtiol6Gdt2h7sTmay+4nF+v6EgNZe013f2QfuCJI5ZiKpEU3WltDXPXn3pWskX5iwAEGEmKjjV+JlbrfJm410wm/OXlRyAlLzI9/S4oF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=stHWIHxD; arc=none smtp.client-ip=210.61.82.184
X-UUID: a89196f07b6b11f18dc8c9802ae25ab1-20260709
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=miRr2Vh2qV0uzgDRTJNRMD3Yv5mTPwM32SzzMgMj50I=;
	b=stHWIHxDZ6hmqVUNy2JgwS0egw2Wu2wPX9XUp7CnfxLC2eE/q4rimHLvvhD+cDALPI2WPfeJ8uaM5LfcmpYQWrX4DZjOj9FtGdufQJynR9EshJMTaBUunESsJ7jxOseSVMVx4c43iiCpzjxso4bQwVTdpUbna/sYTdwGMUBLK38=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.17,REQID:30a83245-d60d-4044-b308-12f88ccf2719,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:d497b38,CLOUDID:544be918-ab14-4403-9336-76696324c5a8,B
	ulkID:nil,BulkQuantity:0,SF:102|836|865|888|898,TC:-5,Content:0|15|50|99,E
	DM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OSI:0,OSA:0,
	AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: a89196f07b6b11f18dc8c9802ae25ab1-20260709
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
	(envelope-from <eason.lai@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1855363146; Thu, 09 Jul 2026 15:56:14 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 9 Jul 2026 15:56:13 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Thu, 9 Jul 2026 15:56:13 +0800
From: Eason Lai <eason.lai@mediatek.com>
To: <nbd@nbd.name>, <lorenzo@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
	<Yf.Luo@mediatek.com>, <kun.wu@mediatek.com>, <deren.wu@mediatek.com>,
	<sean.wang@mediatek.com>, <quan.zhou@mediatek.com>, <ryder.lee@mediatek.com>,
	<leon.yen@mediatek.com>, <litien.chang@mediatek.com>, <jb.tsai@mediatek.com>,
	<eason.lai@mediatek.com>, Eason Lai <Eason.Lai@mediatek.com>
Subject: [PATCH 0/3] Fix TX performance degradation when IOMMU is enabled
Date: Thu, 9 Jul 2026 15:55:55 +0800
Message-ID: <20260709075558.1654164-1-eason.lai@mediatek.com>
X-Mailer: git-send-email 2.45.2
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[mediatek.com,quarantine];
	R_DKIM_ALLOW(-0.20)[mediatek.com:s=dk];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-38810-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[eason.lai@mediatek.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:nbd@nbd.name,m:lorenzo@kernel.org,m:linux-wireless@vger.kernel.org,m:linux-mediatek@lists.infradead.org,m:Yf.Luo@mediatek.com,m:kun.wu@mediatek.com,m:deren.wu@mediatek.com,m:sean.wang@mediatek.com,m:quan.zhou@mediatek.com,m:ryder.lee@mediatek.com,m:leon.yen@mediatek.com,m:litien.chang@mediatek.com,m:jb.tsai@mediatek.com,m:eason.lai@mediatek.com,m:Eason.Lai@mediatek.com,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eason.lai@mediatek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[mediatek.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,mediatek.com:from_mime,mediatek.com:email,mediatek.com:mid,mediatek.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B8FF072DFCC

From: Eason Lai <Eason.Lai@mediatek.com>

This series adds a TX preallocated buffer mechanism to fix the TX
performance degradation observed after enabling IOMMU.

Currently this feature is only enabled on MT8196, where it has been
validated.

Eason Lai (3):
  wifi: mt76: Separate skb and page_pool_buf pointers in mt76_txwi_cache
  wifi: mt76: mt792x: Add TX page pool support for IOMMU-enabled systems
  wifi: mt76: mt792x: Restrict TX page pool to MT8196 platform

 drivers/net/wireless/mediatek/mt76/dma.c      |  55 ++-
 drivers/net/wireless/mediatek/mt76/mt76.h     |  15 +-
 .../wireless/mediatek/mt76/mt76_connac_mac.c  |   6 +
 .../net/wireless/mediatek/mt76/mt7925/pci.c   |   4 +-
 drivers/net/wireless/mediatek/mt76/mt792x.h   |   2 +
 .../net/wireless/mediatek/mt76/mt792x_dma.c   | 330 ++++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7996/mac.c   |  10 +-
 drivers/net/wireless/mediatek/mt76/tx.c       |   2 +-
 drivers/net/wireless/mediatek/mt76/wed.c      |   6 +-
 9 files changed, 398 insertions(+), 32 deletions(-)

-- 
2.45.2


