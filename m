Return-Path: <linux-wireless+bounces-2535-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 295A883D7ED
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jan 2024 11:23:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3B83B332CF
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jan 2024 09:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40CA91CD32;
	Fri, 26 Jan 2024 09:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="MlDdAYkg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7680F54279
	for <linux-wireless@vger.kernel.org>; Fri, 26 Jan 2024 09:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706260206; cv=none; b=dQf3m5aEx0gqKYUoUUJph+u+qkd9F/5ydbOWEPIEF+Ntml2DBa8w7rtqMkwVNaSeuVWYwzwmWURAe1rHsjA1iLQr+pDSIW+wsiZX71EWXcfFddLspSMx8/2Cr3J0BrefelLGVMTNa8kSSvEky4MWLP4ISedswU8RU3+2de1hXxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706260206; c=relaxed/simple;
	bh=AN93mku1aufsQfIJLhRqaON5/0zVS3Pf5FIZ8N+JJbA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JNILVZNBIYnjQgQsN+IPSHG/IAJLAbbdONSn3PBPrcenhDafz6pZlUHEsLvmIwL/X10wSEiC2BdlKpb07sFl9cYYCQBmdaCfBX8LxVr4SZIO6H2Mbcru0ePjSboxKSHcsZ8bKgv+gw6/m6ENhxl1nTx+oEDwFPbSlhzUeQsJAAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=MlDdAYkg; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: a9a9bb92bc2a11eea2298b7352fd921d-20240126
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=EEku9dH/c4UtKmMn5ZT6SVK916xuuKS3jPzR8xW3rN4=;
	b=MlDdAYkgomLnRqrW+fmmmW3+2+JkPFRSKYXjQAkFMwnQ8WJGlD4rltXpHFZpIjyuM+9geAVNDyfCTD0CFE93la0KiHbBlHwICOHQqO3g7p9Vhy6Q1ubkJFJ7COA1ZV07uoLN22zv3HqCw0Cu93o+Xa/daZEPQ5pyglwjGpQqP80=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.36,REQID:4a6f2b2e-5c4f-42c5-8478-65887832efe7,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6e16cf4,CLOUDID:0956b08e-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: a9a9bb92bc2a11eea2298b7352fd921d-20240126
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
	(envelope-from <shayne.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1804268111; Fri, 26 Jan 2024 17:09:51 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 26 Jan 2024 17:09:50 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 26 Jan 2024 17:09:50 +0800
From: Shayne Chen <shayne.chen@mediatek.com>
To: Felix Fietkau <nbd@nbd.name>
CC: linux-wireless <linux-wireless@vger.kernel.org>, Lorenzo Bianconi
	<lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, Evelyn Tsai
	<evelyn.tsai@mediatek.com>, Bo Jiao <Bo.Jiao@mediatek.com>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Michael-CY Lee
	<michael-cy.lee@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH v2 07/12] wifi: mt76: mt7996: mark GCMP IGTK unsupported
Date: Fri, 26 Jan 2024 17:09:18 +0800
Message-ID: <20240126090923.6357-7-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20240126090923.6357-1-shayne.chen@mediatek.com>
References: <20240126090923.6357-1-shayne.chen@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--2.147500-8.000000
X-TMASE-MatchedRID: OIVA+JRTAb8WBq7RS3cuV6b8GfRpncAzQl/FdRYkUZLfUZT83lbkEEtH
	ojrK13E4XUK/AuCTjqP7EkkKzK8KjLJ/7yxc9ZFfngIgpj8eDcAZ1CdBJOsoY8RB0bsfrpPIcSq
	bxBgG0w4GtPt3RUtNdmndJu/1A2jWEI+R0mdFK+6Pard4lOnWI3f7g+WdcDAtCqDdWHrlrUbUJi
	AW+ts/DOmKpv/ZxJ2tE+wpbqQ41kF5lSmbrC6fdtr/To2FgNrjDLMIOOVTHz12N6Rg5qIpOg==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--2.147500-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	28CFFD74325242E336AA699B21FC4755B6D476FBD8CAF0FC904897487CD0942F2000:8
X-MTK: N

From: Michael-CY Lee <michael-cy.lee@mediatek.com>

Since the FW does not support to handle the integrity and validation of
IGTK in GCMP mode, return -EOPNOTSUPP to let it be handled by upper layer.

Signed-off-by: Michael-CY Lee <michael-cy.lee@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7996/main.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index 51deea84b642..339753c25709 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -350,9 +350,12 @@ static int mt7996_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 	case WLAN_CIPHER_SUITE_GCMP:
 	case WLAN_CIPHER_SUITE_GCMP_256:
 	case WLAN_CIPHER_SUITE_SMS4:
+		break;
 	case WLAN_CIPHER_SUITE_BIP_GMAC_128:
 	case WLAN_CIPHER_SUITE_BIP_GMAC_256:
-		break;
+		if (key->keyidx == 6 || key->keyidx == 7)
+			break;
+		fallthrough;
 	case WLAN_CIPHER_SUITE_WEP40:
 	case WLAN_CIPHER_SUITE_WEP104:
 	default:
-- 
2.39.2


