Return-Path: <linux-wireless+bounces-28442-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6423C2402F
	for <lists+linux-wireless@lfdr.de>; Fri, 31 Oct 2025 10:07:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 013551A622B8
	for <lists+linux-wireless@lfdr.de>; Fri, 31 Oct 2025 09:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F0B032ED3A;
	Fri, 31 Oct 2025 09:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="R5g3NVIJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BCBE32E72E
	for <linux-wireless@vger.kernel.org>; Fri, 31 Oct 2025 09:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761901459; cv=none; b=vAuZjAQMdUXkhn/UElxe4eeEbFoW3nQvvQ+G3Z3AbWgX60E4t7vDJ7JIi/73nRH+3tBd5jOI7rTXx7MzxJ/HZo0Mjx4W2ZuSDPIcmU/H6QCaKKmrh8yCQ4dnKqVO/CZN4o1xszE/5p1+IVzeog2KCN/0KafUsDar9C1GxuzSVr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761901459; c=relaxed/simple;
	bh=7A36hBsPN9YpWq10Cg6kYl1ayeekdHM7Io6aRjPI5N0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qfe/FAubdy4k+bAQmQI6kJqpGn6oyxJ6bGg7kqjw/yQNKy1YXORk9MBQlb85IwKnQ2lOpVCy0muFFcSZGSuCqlNOevUNlSEj0C76Y7KURjjGcgifaFaGqY6rSdXJqB9RmAwYw7TYWAJkg6b1g3uOs5CMsPJXdabyQeqpajnkA34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=R5g3NVIJ; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 8e15801eb63811f0b33aeb1e7f16c2b6-20251031
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=g2bHH6elkTX7dT7zGw2clqTWCwh+eDW53GJJ8jXiJDM=;
	b=R5g3NVIJd5BceXAGW7w8noMOv/hz+f2uqws5vr1mU8pEfriC20pLbKUnIl4bsDAZK23r3Yuw4yQ5sQWH3pT0tP5VG7URsTOfZMmacc/6SPgFkZc6svwWrkXHAyvCBFq+RHtk6A3eiDIGpG3kN79z/3TCVtKweIadAs2IrN3QAKY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:4df21f31-6f82-4d76-bd48-51a35c426e6e,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:a9d874c,CLOUDID:445e7726-cfd6-4a1d-a1a8-72ac3fdb69c4,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102|836|888|898,TC:-5,Content:0|15|5
	0,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 8e15801eb63811f0b33aeb1e7f16c2b6-20251031
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw02.mediatek.com
	(envelope-from <mingyen.hsieh@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1625772143; Fri, 31 Oct 2025 17:04:06 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 31 Oct 2025 17:04:05 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1748.26 via Frontend Transport; Fri, 31 Oct 2025 17:04:05 +0800
From: Mingyen Hsieh <mingyen.hsieh@mediatek.com>
To: <nbd@nbd.name>, <lorenzo@kernel.org>
CC: <deren.wu@mediatek.com>, <Sean.Wang@mediatek.com>,
	<Leon.Yen@mediatek.com>, <Michael.Lo@mediatek.com>,
	<allan.wang@mediatek.com>, <Eric-SY.Chang@mediatek.com>,
	<km.lin@mediatek.com>, <Quan.Zhou@mediatek.com>, <Ryder.Lee@mediatek.com>,
	<Shayne.Chen@mediatek.com>, <linux-wireless@vger.kernel.org>,
	<linux-mediatek@lists.infradead.org>, Ming Yen Hsieh
	<mingyen.hsieh@mediatek.com>
Subject: [PATCH 0/6] wifi: mt76: mt7925: update the regulatory domain control
Date: Fri, 31 Oct 2025 17:03:46 +0800
Message-ID: <20251031090352.1400079-1-mingyen.hsieh@mediatek.com>
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

From: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>

This patchset introduces a series of improvements to mt7925. The main
goals are to enhance compliance with 802.11d specifications, improve
runtime regd switching, and ensure user-set regulatory domains are
respected.

Ming Yen Hsieh (6):
  wifi: mt76: mt7925: refactor regulatory domain handling to regd.[ch]
  wifi: mt76: mt7925: refactor CLC support check flow
  wifi: mt76: mt7925: refactor regulatory notifier flow
  wifi: mt76: mt7925: improve EHT capability control in regulatory flow
  wifi: mt76: mt7925: add auto regdomain switch support
  wifi: mt76: mt7925: disable auto regd changes after user set

 .../wireless/mediatek/mt76/mt7925/Makefile    |   2 +-
 .../net/wireless/mediatek/mt76/mt7925/init.c  | 148 +---------
 .../net/wireless/mediatek/mt76/mt7925/mac.c   |   5 +-
 .../net/wireless/mediatek/mt76/mt7925/main.c  |  26 +-
 .../net/wireless/mediatek/mt76/mt7925/mcu.c   |  13 +-
 .../wireless/mediatek/mt76/mt7925/mt7925.h    |   2 -
 .../net/wireless/mediatek/mt76/mt7925/pci.c   |   4 +-
 .../net/wireless/mediatek/mt76/mt7925/regd.c  | 265 ++++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7925/regd.h  |  19 ++
 drivers/net/wireless/mediatek/mt76/mt792x.h   |   2 +
 10 files changed, 302 insertions(+), 184 deletions(-)
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7925/regd.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7925/regd.h

-- 
2.34.1


