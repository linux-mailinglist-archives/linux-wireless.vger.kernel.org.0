Return-Path: <linux-wireless+bounces-11534-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C29DE95462E
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Aug 2024 11:51:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 773741F22266
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Aug 2024 09:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC3061714D6;
	Fri, 16 Aug 2024 09:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="EqyWnft0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB350171098
	for <linux-wireless@vger.kernel.org>; Fri, 16 Aug 2024 09:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723801825; cv=none; b=DjG00ctmsP3yyG3Mou5d+H0WhbhPey3Xa+eg63cG6NY8skCMkaHjulGbe0F2zUAyttSNY+8wkcl4iCjBUDh9YD4JFQ5PPVHsS4f0Oy0BgABQQab4vV3BKY0pUVcZSGJUNa7VwOuNxhLONRRNBIPy5L+QcO+eMCmPUvoYpEF0kIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723801825; c=relaxed/simple;
	bh=NEu2vdVxQ+/oMb0Wc2Y1OvuNERNhgaPt0K8q9MSyQI8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oVnEFTFQfJoyqbxr0cKjSvA+FQGr+tkkhQVjimrzJY2Psx4O+iCnXy/SOdgHS7GitcD18uxMYo228X2Xs/8oiUyHUPmcvkbcTVpvYzFcaqffe9nLBdelxLh21B+LNdHYdLAeMWaqXhk+VieyMUsmbJijMmI2ErJMaRiSL2lVCpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=EqyWnft0; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: f0a6015c5bb411ef8b96093e013ec31c-20240816
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=0P8Q5aPYJ95Nkv+yhaexcDyfyP79mJeFOtrPENogz6Q=;
	b=EqyWnft0RiMIsj3XBm14MaK/F1noCLqhD9XdKVqYF19pyD4LmWuVqsimDzxBmzCMYRcWkvPO4TRuNgNhpVfD4FSlLTNYoCpWrgynR1+gcpJ6HKfqusR69gMByuuyth31wHYgB8TvQ7XmY7pVFDv1+Dn5fFtpXx5Mzez8SKXODlM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:573665e9-e62f-4544-85f2-3b559ea1748e,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:78c6b6c1-acff-4a0f-9582-14bcdf4ed7e0,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: f0a6015c5bb411ef8b96093e013ec31c-20240816
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
	(envelope-from <shayne.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 503935617; Fri, 16 Aug 2024 17:50:16 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 16 Aug 2024 17:50:16 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 16 Aug 2024 17:50:16 +0800
From: Shayne Chen <shayne.chen@mediatek.com>
To: Felix Fietkau <nbd@nbd.name>
CC: linux-wireless <linux-wireless@vger.kernel.org>, Lorenzo Bianconi
	<lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, Evelyn Tsai
	<evelyn.tsai@mediatek.com>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Michael-CY Lee
	<michael-cy.lee@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH 12/12] wifi: mt76: mt7996: set IEEE80211_KEY_FLAG_GENERATE_MMIE for other ciphers
Date: Fri, 16 Aug 2024 17:46:35 +0800
Message-ID: <20240816094635.2391-11-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20240816094635.2391-1-shayne.chen@mediatek.com>
References: <20240816094635.2391-1-shayne.chen@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--6.424400-8.000000
X-TMASE-MatchedRID: 72n23NsrtG5Dn01oiZfuY4Q6iEG+7EHnVNyumldWne3fc2Xd6VJ+yjFa
	TRf5dTetdwvRxvSoxhzX3CBAz92EpWNvKIW9g24opvwZ9GmdwDNMkOX0UoduuQqiCYa6w8tvxjf
	J+i+nbHSPvzCryM/S54Ay6p60ZV62fJ5/bZ6npdjKayT/BQTiGkbHfwjbIquItEKd2FZKuTfUvi
	hDc8zGGPsVh7XWXFhv56vXtoWyuGHAvpLE+mvX8g==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--6.424400-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 854B1E48823A03FE6D506702CAEB90D599A40A29D76B55F8503079D1F7322EDF2000:8
X-MTK: N

From: Michael-CY Lee <michael-cy.lee@mediatek.com>

When beacon protection is enabled, FW checks MMIE tag & length in the
beacon for every cipher mode. To pass the check, driver needs to set the
key flag IEEE80211_KEY_GENERATE_MMIE to let mac80211 generate and
initialize MMIE.

Signed-off-by: Michael-CY Lee <michael-cy.lee@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7996/main.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index 1ab2fb292266..d43bd5c2432e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -364,14 +364,14 @@ static int mt7996_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 	case WLAN_CIPHER_SUITE_SMS4:
 		break;
 	case WLAN_CIPHER_SUITE_AES_CMAC:
-		wcid_keyidx = &wcid->hw_key_idx2;
-		key->flags |= IEEE80211_KEY_FLAG_GENERATE_MMIE;
-		fallthrough;
 	case WLAN_CIPHER_SUITE_BIP_CMAC_256:
 	case WLAN_CIPHER_SUITE_BIP_GMAC_128:
 	case WLAN_CIPHER_SUITE_BIP_GMAC_256:
-		if (key->keyidx == 6 || key->keyidx == 7)
+		if (key->keyidx == 6 || key->keyidx == 7) {
+			wcid_keyidx = &wcid->hw_key_idx2;
+			key->flags |= IEEE80211_KEY_FLAG_GENERATE_MMIE;
 			break;
+		}
 		fallthrough;
 	case WLAN_CIPHER_SUITE_WEP40:
 	case WLAN_CIPHER_SUITE_WEP104:
-- 
2.39.2


