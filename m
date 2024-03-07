Return-Path: <linux-wireless+bounces-4451-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B4B9874D03
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Mar 2024 12:08:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D453B212CF
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Mar 2024 11:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A8D3127B7C;
	Thu,  7 Mar 2024 11:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="hOIzRp3P"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6CE1E52A
	for <linux-wireless@vger.kernel.org>; Thu,  7 Mar 2024 11:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709809709; cv=none; b=oDyiwTE/CankwAzZBiYY3ZWyYRpqqbTiSA3gA4M/rnCG6X3zTpp2Xh9CCY0A6zQGn5NZ8uxBTEdyDrZCn2k0reMftDDlwPuBu+0hORYI/unsRy4Otyk48nz9M/Qfhe7JbVfvAMfYyKW92wAiGxywFp/ufwwAad5I2YzUjM9EpC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709809709; c=relaxed/simple;
	bh=MlJEDnz3lc4Jvj7xN4NWhZIiaR0f5ZBKVRaT+9GWcNc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=M4katBGsB0zOGT1n1BkKnve0KSwnnQungf9htjCYp0kuwxRxsRCC57S8Jcp1CxZwQSU4phwVmpsu3qsdUtEVqwFC8z1PAqzrLhUwBElz0eAsZaDYrEEMvUkPF4fLnmkO/ytBZ9M6OMq8Jb+fB2b3NnYRwFb/o/JgWOltgzzeDfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=hOIzRp3P; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 01d80504dc7311ee935d6952f98a51a9-20240307
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=oP6i39R/fK+jF6uZWGIiot3B/64njBTpoJW5U6r7Zd4=;
	b=hOIzRp3PPz6/yat1ZpG9MamFksgiR8fl74ke8FTwDTaSJKoUTEzUx0IoxrGiP6wy7lrowYWKfx3lXiKeFgRDS1mcYNtiVm+6mBvMwdEnrI8Dqgh63YNpf+T7xlf/ZLfuXqY6cY6UtUt9k3qjGGTXs2ya8M0qbvmdAdhJ4HxrZ4A=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:43c0f9bb-a3bb-4ff3-a04b-a8623e0440f1,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:f89e9fff-c16b-4159-a099-3b9d0558e447,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 01d80504dc7311ee935d6952f98a51a9-20240307
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
	(envelope-from <mingyen.hsieh@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 2086597899; Thu, 07 Mar 2024 19:08:20 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 7 Mar 2024 19:08:16 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 7 Mar 2024 19:08:16 +0800
From: Mingyen Hsieh <mingyen.hsieh@mediatek.com>
To: <nbd@nbd.name>, <lorenzo@kernel.org>
CC: <deren.wu@mediatek.com>, <Sean.Wang@mediatek.com>,
	<Soul.Huang@mediatek.com>, <Leon.Yen@mediatek.com>,
	<Eric-SY.Chang@mediatek.com>, <km.lin@mediatek.com>,
	<robin.chiu@mediatek.com>, <ch.yeh@mediatek.com>, <posh.sun@mediatek.com>,
	<Quan.Zhou@mediatek.com>, <Ryder.Lee@mediatek.com>,
	<Shayne.Chen@mediatek.com>, <linux-wireless@vger.kernel.org>,
	<linux-mediatek@lists.infradead.org>, Ming Yen Hsieh
	<mingyen.hsieh@mediatek.com>
Subject: [PATCH] wifi: mt76: mt7925: ensure 4-byte alignment for suspend & wow command
Date: Thu, 7 Mar 2024 19:08:15 +0800
Message-ID: <20240307110815.527-1-mingyen.hsieh@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--2.722700-8.000000
X-TMASE-MatchedRID: K1/iR2xcoOfwa4iJAsefGDQlj13qze9pLoYOuiLW+uU1LB46LFAAklO4
	BD7nLMxn4ZH8wasvhJf8uYcF5GffsqmVr/PsmqxPdE/dhjO8a+T0O7M3lSnTW5soi2XrUn/Jn6K
	dMrRsL14qtq5d3cxkNRqXnrxrKCOXF7DZKeo3Cs2hOSsaDAFb6nDL8L6nn4dfX7wf7//XRh+eVw
	YTr6L30KUA5kk8GugVrqf4jZC2Wrxm1z+N6ypGjYN/qZcpq7vWF0aD5ljt43pMcHZD6gqu7wxMj
	fifIXfowkvVoA11Twp+3BndfXUhXQ==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--2.722700-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	3ECA7F6D3A5597C68898AB61E16C428324056E3158A9EB0AFDBE3C6B9F5406682000:8

From: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>

Before sending suspend & wow command to FW, its length should be
4-bytes alignd.

Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c | 1 +
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.h      | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index af0c2b2aacb0..ef29d093f9c3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -2527,6 +2527,7 @@ int mt76_connac_mcu_set_hif_suspend(struct mt76_dev *dev, bool suspend)
 			__le16 tag;
 			__le16 len;
 			u8 suspend;
+			u8 pad[7];
 		} __packed hif_suspend;
 	} req = {
 		.hif_suspend = {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h
index 2a0bbfe7bfa5..b8315a89f4a9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h
@@ -535,7 +535,7 @@ struct mt7925_wow_pattern_tlv {
 	u8 offset;
 	u8 mask[MT76_CONNAC_WOW_MASK_MAX_LEN];
 	u8 pattern[MT76_CONNAC_WOW_PATTEN_MAX_LEN];
-	u8 rsv[4];
+	u8 rsv[7];
 } __packed;
 
 static inline enum connac3_mcu_cipher_type
-- 
2.18.0


