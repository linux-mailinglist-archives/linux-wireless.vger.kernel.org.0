Return-Path: <linux-wireless+bounces-1075-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7645C819B4C
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Dec 2023 10:22:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8EDC1C256DC
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Dec 2023 09:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D4971DA4F;
	Wed, 20 Dec 2023 09:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="TCnhTfyh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CADDE1D6BD
	for <linux-wireless@vger.kernel.org>; Wed, 20 Dec 2023 09:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 31ae97f89f1911eea5db2bebc7c28f94-20231220
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=UnlStqmYRAlfvxrZQ5+BdKf3D8frk3pBfaawlyt78ZI=;
	b=TCnhTfyh/ovGzNX6FORx+0e2rFpm8GBBHClavQBhxJ6W8rYGsO3lYi8J06LgObMCQR5StCsyu1vuM/aBG7KKmOmrVXQXY3bDTkJ9CeLCThuwDTP2CP9tzcixvzVMA+XGoZvxP8JVWXxHlSetLDZXcZ1tnn25Ykog5UID6RBkpyg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:3af25eff-8fff-406c-86a5-abfc705b53eb,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:5d391d7,CLOUDID:bede797e-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
	DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 31ae97f89f1911eea5db2bebc7c28f94-20231220
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
	(envelope-from <mingyen.hsieh@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 2034948249; Wed, 20 Dec 2023 17:21:45 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 20 Dec 2023 17:21:43 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 20 Dec 2023 17:21:43 +0800
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
Subject: [PATCH 0/4] wifi: mt76: mt7921: fix potential issues for mt7921
Date: Wed, 20 Dec 2023 17:21:34 +0800
Message-ID: <20231220092138.12830-1-mingyen.hsieh@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--5.137900-8.000000
X-TMASE-MatchedRID: 4M8Lw78TDBDZK1rQqyNiGTQlj13qze9pFAr+wPWe7jEFi3R9x/2qQoy9
	bZLB2g0gX9TqmrRnueWcLyHbQAbhbRqXhvBXA7wb4bl1FkKDELdMkOX0UoduuQCGaccd4ae9XaT
	Eoipb2i/i8zVgXoAltmHJPdY2OmlS0C1sQRfQzEHEQdG7H66TyF82MXkEdQ77/pY551MkBh8ZGz
	M72QCXy6tXJZ/bai5SBJehHlD3Ahw4/uC4eWuzKA==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--5.137900-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	F14A6D68CD1AA75A0B5CFB0D2B28BC6ECFA263416674C845491D98645F6630872000:8

From: Ming Yen Hsieh <MingYen.Hsieh@mediatek.com>

Hi,

This patchset includes some bugfixes for CLC (Country Location Control),
suspend/resume and ACPI SAR.

Ming Yen Hsieh (4):
  wifi: mt76: mt7921: fix incorrect type conversion for CLC command
  wifi: mt76: mt7921: fix potential command timeout issues when suspend
  wifi: mt76: mt792x: fix a potential loading failure of the 6Ghz
    channel config from ACPI
  wifi: mt76: mt792x: update the country list of EU for ACPI SAR

 .../net/wireless/mediatek/mt76/mt7921/mcu.c   |  4 +--
 .../net/wireless/mediatek/mt76/mt7921/pci.c   |  2 ++
 .../wireless/mediatek/mt76/mt792x_acpi_sar.c  | 28 ++++++++++---------
 3 files changed, 19 insertions(+), 15 deletions(-)

-- 
2.18.0


