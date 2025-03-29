Return-Path: <linux-wireless+bounces-20950-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BC21A75709
	for <lists+linux-wireless@lfdr.de>; Sat, 29 Mar 2025 16:48:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE4C716ED87
	for <lists+linux-wireless@lfdr.de>; Sat, 29 Mar 2025 15:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B484F1DE2D4;
	Sat, 29 Mar 2025 15:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="MDAuvGst"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90431DD9D1
	for <linux-wireless@vger.kernel.org>; Sat, 29 Mar 2025 15:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743263270; cv=none; b=k2s+BeL8sbhXFIr+vGiauMTw0fYJgkNDiNMXokcE2g9Hy9pQan15CU7IMnlNdCQ1bhi4QGP00w9hPoYapHtABIriaAbg0rvy8gfe15Gyly+rhsaR5oBUSyH1wbeDon5PcBjtUNOtHKQhsCE1FhU5NF8u3dd3wBWloajFn0I8Dgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743263270; c=relaxed/simple;
	bh=q7PkLwfRP2P6xXHruFOISUsGcmylSUIQcLYDCnOnW9U=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rXvi0x+G/ed/iUu3J7kR9rpUe5uHGE9vwHkhzkjkDsJms1p6vmw8g9+iDeQZlncE2TWX9Ho9RyJtbfljABXlzS1OdsLOoRd8s8l3aiJUFWdWwhrIo/2ZdbT8OdpGIqS/Q7onP+vjA1XideaKXYjMoDJXaxkMbE/TcFJg5YKMQug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=MDAuvGst; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 24382d900cb511f08eb9c36241bbb6fb-20250329
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=AKOfDWOa6YPYRz1gzTUCF1QBJ75c/q7qL+CFu7q0BYc=;
	b=MDAuvGstBXhl6ygPpMWQs+kCUCzPT7cItYQGNwAN4NopGXQrfCnPGS3XX/LeSltaqSEz+oyN+5nlZ5DrJRzUWBKj2vklcDos78W5DFEknQCkPyszE0gepoBIv+NLDl4efEGcrpKCjzMFb2anr2xbEWHwiP0sW0c/ZpPG7enbLfQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:3ae61b91-f92a-4ad9-8083-f6fa216aaadd,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:0ef645f,CLOUDID:7cecfa8c-f5b8-47d5-8cf3-b68fe7530c9a,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:-3,IP:ni
	l,URL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: 24382d900cb511f08eb9c36241bbb6fb-20250329
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw02.mediatek.com
	(envelope-from <shayne.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1024974653; Sat, 29 Mar 2025 23:47:38 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 MTKMBS14N2.mediatek.inc (172.21.101.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Sat, 29 Mar 2025 23:47:37 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Sat, 29 Mar 2025 23:47:37 +0800
From: Shayne Chen <shayne.chen@mediatek.com>
To: Felix Fietkau <nbd@nbd.name>
CC: linux-wireless <linux-wireless@vger.kernel.org>, Lorenzo Bianconi
	<lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, Evelyn Tsai
	<evelyn.tsai@mediatek.com>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH mt76-next v2 00/10] Add MT7990 support
Date: Sat, 29 Mar 2025 23:47:20 +0800
Message-ID: <20250329154731.2113551-1-shayne.chen@mediatek.com>
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

v2:
 - remove accidentally added tag in 03/10
 - fix variable used uninitialized in 06/10
 - add target tree name

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


