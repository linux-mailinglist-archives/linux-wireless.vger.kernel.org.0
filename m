Return-Path: <linux-wireless+bounces-20913-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69666A743A1
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Mar 2025 06:54:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26A8D3AE9EC
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Mar 2025 05:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7451B1DE2BA;
	Fri, 28 Mar 2025 05:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="JXHl+k08"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD2EE573
	for <linux-wireless@vger.kernel.org>; Fri, 28 Mar 2025 05:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743141245; cv=none; b=n4WLH9mTdpQKAuUM6gUQfkRtVa2AioqJ9y6cbynfPKf0gnnAU2MlNoob7Td6JNb+4XSH5YDI/l/4iAsWpZDPtcKA7q0Ut003SbWfXbjMKi0OGfHSZFZimZb2WnmCBuZb9MXouyFRkWjboILq3Zt6mG2tZLO5UI8VARHm1r5kodg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743141245; c=relaxed/simple;
	bh=9m1yJd3Ma+tRnZ3XYKTx7s6FX3eOp9M6snLCRUvDSNQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ncstG28zoC7ZEbdddTtRD4YM6PWk9ufDQdhG9MCOIuyYvySkW2kdkQ0PM2NMUa26pQ5IZSRhHdTGpMfEUgXULBklQZcOyS5EGcAuiFYyY9ZM4yGO7GH/tHUZ0Ym5tZT1HcXmMCDVO0aXd/5AiZaw0MEzTHEhXlchOSgv5n7mx8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=JXHl+k08; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 0a6394c60b9911f08eb9c36241bbb6fb-20250328
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=7/9qD9xLBxCprsdcm2KyVrAxQtaTMp4jDWc4NveFj4c=;
	b=JXHl+k08gZO4zi0KnBY3En4bP0znUaM2IMnN2m39w9jbgZe6xBx+iSONpLVxqx2hSaiRwBI0wQhU82HiRfs+daJGYdKkPBkj/G2z6oaqezhdUzlb1yYTVrWdtRemBHJHk6iirAIm9LWOfnIoja1wCsl8LntPCOqLqPurDuKvGN8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:27ecc36d-5090-48a3-9c87-7827bef41f34,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:0ef645f,CLOUDID:e79b67a5-c619-47e3-a41b-90eedbf5b947,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:-3,IP:ni
	l,URL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_ULS,TF_CID_SPAM_SNR
X-UUID: 0a6394c60b9911f08eb9c36241bbb6fb-20250328
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw02.mediatek.com
	(envelope-from <shayne.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 2018417766; Fri, 28 Mar 2025 13:53:58 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Fri, 28 Mar 2025 13:53:56 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Fri, 28 Mar 2025 13:53:56 +0800
From: Shayne Chen <shayne.chen@mediatek.com>
To: Felix Fietkau <nbd@nbd.name>
CC: linux-wireless <linux-wireless@vger.kernel.org>, Lorenzo Bianconi
	<lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, Evelyn Tsai
	<evelyn.tsai@mediatek.com>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH 00/10] Add MT7990 support
Date: Fri, 28 Mar 2025 13:50:48 +0800
Message-ID: <20250328055058.1648755-1-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

This series introduces support for the MT7990 PCI Wi-Fi device, a Wi-Fi 7
chipset that supports Dual-Band Dual Concurrent (DBDC) on both 2.4 GHz and
5 GHz bands.

This series is based on:
https://patchwork.kernel.org/project/linux-wireless/patch/20250320015909.3948612-1-StanleyYP.Wang@mediatek.com/

Peter Chiu (4):
  wifi: mt76: mt7996: rework WA mcu command for mt7990
  wifi: mt76: mt7996: rework DMA configuration for mt7990
  wifi: mt76: mt7996: adjust HW capabilities for mt7990
  wifi: mt76: mt7996: add PCI device id for mt7990

Shayne Chen (2):
  wifi: mt76: mt7996: add macros for pci decive id
  wifi: mt76: connac: rework TX descriptor and TX free for mt7990

StanleyYP Wang (4):
  wifi: mt76: connac: add support to load firmware for mt7990
  wifi: mt76: mt7996: rework register mapping for mt7990
  wifi: mt76: mt7996: add eeprom support for mt7990
  wifi: mt76: mt7996: rework background radar check for mt7990

 .../net/wireless/mediatek/mt76/mt76_connac.h  |   7 +-
 .../wireless/mediatek/mt76/mt76_connac3_mac.h |   1 +
 .../wireless/mediatek/mt76/mt76_connac_mcu.c  |   3 +-
 .../wireless/mediatek/mt76/mt76_connac_mcu.h  |   2 +
 .../wireless/mediatek/mt76/mt7996/coredump.c  |   4 +-
 .../net/wireless/mediatek/mt76/mt7996/dma.c   | 192 ++++++++++++------
 .../wireless/mediatek/mt76/mt7996/eeprom.c    |  41 +++-
 .../net/wireless/mediatek/mt76/mt7996/init.c  |  18 +-
 .../net/wireless/mediatek/mt76/mt7996/mac.c   |  42 +++-
 .../net/wireless/mediatek/mt76/mt7996/mcu.c   |  77 +++++--
 .../net/wireless/mediatek/mt76/mt7996/mcu.h   |   6 +
 .../net/wireless/mediatek/mt76/mt7996/mmio.c  | 192 ++++++++++++++++--
 .../wireless/mediatek/mt76/mt7996/mt7996.h    |  50 +++--
 .../net/wireless/mediatek/mt76/mt7996/pci.c   |  21 +-
 .../net/wireless/mediatek/mt76/mt7996/regs.h  |  51 +++--
 15 files changed, 549 insertions(+), 158 deletions(-)

-- 
2.39.2


