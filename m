Return-Path: <linux-wireless+bounces-1953-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BA0582E7FB
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jan 2024 03:49:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A61C1F23833
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jan 2024 02:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE7E963B6;
	Tue, 16 Jan 2024 02:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="mARwXO0R"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9DC517CE
	for <linux-wireless@vger.kernel.org>; Tue, 16 Jan 2024 02:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: d257932ab41911ee9e680517dc993faa-20240116
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=HJ9/hb1oR3z6QYtFtb59VUDRsqEpUqDNna+ijRv/ZZ4=;
	b=mARwXO0Rf0uMxKw47lYmt4Yujlzm0L52uluMY0EghVJdAL2QZk6uPa5zWjHNPILU1v8rRx/lYk5/7uItmEswIUqC34goKIvnltZPrXxc0P5jsbsyMvdgMEKejxuswK1CsVCRuuXliKtxJmw7TfbBNTl5tdqTL973ar9Uc4IDWR0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:f61164fb-8396-494a-bd0c-2a2d95e780bb,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:5d391d7,CLOUDID:a905e382-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
	DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: d257932ab41911ee9e680517dc993faa-20240116
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
	(envelope-from <mingyen.hsieh@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 435706312; Tue, 16 Jan 2024 10:49:09 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 16 Jan 2024 10:49:07 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 16 Jan 2024 10:49:07 +0800
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
Subject: [PATCH v2 0/4] wifi: mt76: mt7921: fix potential issues for mt7921
Date: Tue, 16 Jan 2024 10:48:53 +0800
Message-ID: <20240116024857.9071-1-mingyen.hsieh@mediatek.com>
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

This patchset includes some bugfixes for CLC (Country Location Control),
suspend/resume and ACPI SAR.

v1:
    remove patch, "mt7921: fix potential command timeout issues when suspend",
    and add patch, "mt7921: fix the unfinished command of regd_notifier before suspend"
v2:
    In "wifi: mt76: mt7921: fix the unfinished command of regd_notifier before suspend",
    after regd update, the variable "regd_in_progress" should reset to false.

Ming Yen Hsieh (4):
  wifi: mt76: mt7921: fix incorrect type conversion for CLC command
  wifi: mt76: mt792x: fix a potential loading failure of the 6Ghz
    channel config from ACPI
  wifi: mt76: mt792x: update the country list of EU for ACPI SAR
  wifi: mt76: mt7921: fix the unfinished command of regd_notifier before
    suspend

 .../net/wireless/mediatek/mt76/mt7921/init.c  |  6 ++++
 .../net/wireless/mediatek/mt76/mt7921/mcu.c   |  4 +--
 .../net/wireless/mediatek/mt76/mt7921/pci.c   |  3 ++
 drivers/net/wireless/mediatek/mt76/mt792x.h   |  2 ++
 .../wireless/mediatek/mt76/mt792x_acpi_sar.c  | 28 ++++++++++---------
 5 files changed, 28 insertions(+), 15 deletions(-)

-- 
2.18.0


