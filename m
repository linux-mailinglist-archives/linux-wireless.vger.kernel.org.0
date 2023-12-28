Return-Path: <linux-wireless+bounces-1298-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3408C81F635
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Dec 2023 10:08:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 659091C2280A
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Dec 2023 09:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52A006FD5;
	Thu, 28 Dec 2023 09:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="iW1/t5mq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B956D38
	for <linux-wireless@vger.kernel.org>; Thu, 28 Dec 2023 09:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 94ad18d2a56011eea2298b7352fd921d-20231228
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=hGhlwRfsvh1VIk7xPS4HXHKBBmn9B6a0IjI9XgEG/b8=;
	b=iW1/t5mqSocuug1LzA0NT41iXOjRxy8gSkLPkSfdDh9xthcXruEfqpGQnk5BA7hK20LWdlzc4sShk4gTR2WeAxQqZNiHe8bGyfy8NXMtw71h4lziFqmw1HB48umKDwesMB95q6RckWuHiUQJX4yvFo7SrXBwmsiB6TvAcwtbQro=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:338699b1-7b5a-415b-ba8c-f4d47384dcaf,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:5d391d7,CLOUDID:61e6932e-1ab8-4133-9780-81938111c800,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
	DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 94ad18d2a56011eea2298b7352fd921d-20231228
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
	(envelope-from <mingyen.hsieh@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1748594495; Thu, 28 Dec 2023 17:07:52 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 28 Dec 2023 17:07:51 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 28 Dec 2023 17:07:51 +0800
From: Mingyen Hsieh <mingyen.hsieh@mediatek.com>
To: <nbd@nbd.name>, <lorenzo@kernel.org>
CC: <deren.wu@mediatek.com>, <Sean.Wang@mediatek.com>,
	<Soul.Huang@mediatek.com>, <Leon.Yen@mediatek.com>,
	<Eric-SY.Chang@mediatek.com>, <km.lin@mediatek.com>,
	<robin.chiu@mediatek.com>, <ch.yeh@mediatek.com>, <posh.sun@mediatek.com>,
	<Quan.Zhou@mediatek.com>, <Ryder.Lee@mediatek.com>,
	<Shayne.Chen@mediatek.com>, <linux-wireless@vger.kernel.org>,
	<linux-mediatek@lists.infradead.org>, Ming Yen Hsieh
	<MingYen.Hsieh@mediatek.com>
Subject: [PATCH 00/10] wifi: mt76: mt7925: fix connection and throughput issues
Date: Thu, 28 Dec 2023 17:07:39 +0800
Message-ID: <20231228090749.15191-1-mingyen.hsieh@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

From: Ming Yen Hsieh <MingYen.Hsieh@mediatek.com>

Hi,

Recently, we have some tests on the mt7925 driver and find a number of
potential connection bugs and throughput issues. This patchset contains
bugfixes and cleanups for these issues.

Thanks,
Yen.

Deren Wu (1):
  wifi: mt76: mt7925: update PCIe DMA settings

Hao Zhang (1):
  wifi: mt76: mt7925: fix mcu query command fail

Ming Yen Hsieh (6):
  wifi: mt76: mt7925: fix connect to 80211b mode fail in 2Ghz band
  wifi: mt76: mt7925: fix wmm queue mapping
  wifi: mt76: mt7925: fix fw download fail
  wifi: mt76: mt7925: fix WoW failed in encrypted mode
  wifi: mt76: mt7925: fix the wrong header translation config
  wifi: mt76: mt7925: add support to set ifs time by mcu command

Quan Zhou (1):
  wifi: mt76: mt7925: add flow to avoid chip bt function fail

rong.yan (1):
  wifi: mt76: mt7925: fix SAP no beacon issue in 5Ghz and 6Ghz band

 .../wireless/mediatek/mt76/mt76_connac_mcu.c  |   2 +-
 .../wireless/mediatek/mt76/mt76_connac_mcu.h  |   4 +
 .../net/wireless/mediatek/mt76/mt7925/main.c  |  26 ++-
 .../net/wireless/mediatek/mt76/mt7925/mcu.c   | 176 +++++++++++-------
 .../net/wireless/mediatek/mt76/mt7925/mcu.h   |  92 +++++++--
 .../net/wireless/mediatek/mt76/mt7925/pci.c   |   2 +
 .../net/wireless/mediatek/mt76/mt792x_dma.c   |  13 +-
 .../net/wireless/mediatek/mt76/mt792x_regs.h  |   8 +
 8 files changed, 227 insertions(+), 96 deletions(-)

-- 
2.18.0


