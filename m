Return-Path: <linux-wireless+bounces-5259-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6B988B619
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Mar 2024 01:31:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2CB81C363FD
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Mar 2024 00:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 424E914A85;
	Tue, 26 Mar 2024 00:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="tqQEq4jA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D96D1B7E4
	for <linux-wireless@vger.kernel.org>; Tue, 26 Mar 2024 00:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711413060; cv=none; b=DiAi7PuF2mXuSV8vnZdOVsSEWHYVhIL6pCHxNbZP5rZj6G9/2BFN3T/FCavLkvJqiCtIUpPLLztjiwWfZbwLFham/vqZa0OUIEGYMNhq9ZIvYHr7hWjU3yC9zywpOGZws/HGLZNGwrOzr630y27PUzP9xny2Oa7j8kww3opYbsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711413060; c=relaxed/simple;
	bh=+2QdTD/7XZNbn+OCqxENYNmtQGOxatH1Ztd+gW9L1P8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bWuowL1Co5P0PJXPIl+SqxudvRnfxcBQM4H3YtnJbPLy3Kj6f7D/lD/a+wr5UnLZlVGgsHlf3cXUIJ7n1ctmMUcJfAnCk6Q0jYUZaBCcJdtzyASLjV2CkCv6CK6tWTvB209Dwz8CWvos2vYwFmbFRSQN59Ro8AF1IOny6vf6pDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=tqQEq4jA; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 1a80b3e6eb0811ee935d6952f98a51a9-20240326
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=d5EWYJtwADKsUoaus/ouDpTQKGw+PIs1wCdfP57Bel0=;
	b=tqQEq4jAYEFsbFaGdNd5L4b6dL2tz00J/DCSwmmVMB5lVUfB+4jnCkWNFgRFd9coiYI6LJPLLr4jfI9cnYGJ1dcGtp5gD92V8BMfeyLT1xbb4v8J7RAaItC25/llqUhysKstSP39d0L3PXoh2T8HhAvkHWyt3PO/76vd2Wm+24Q=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:eb72bd18-ead9-4782-acbb-009d80d698cb,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:6cda5000-c26b-4159-a099-3b9d0558e447,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 1a80b3e6eb0811ee935d6952f98a51a9-20240326
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
	(envelope-from <michael-cy.lee@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 967355950; Tue, 26 Mar 2024 08:30:53 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 26 Mar 2024 08:30:51 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 26 Mar 2024 08:30:51 +0800
From: Michael-CY Lee <michael-cy.lee@mediatek.com>
To: linux-wireless <linux-wireless@vger.kernel.org>
CC: Johannes Berg <johannes@sipsolutions.net>, Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>, Evelyn Tsai
	<evelyn.tsai@mediatek.com>, Money Wang <money.wang@mediatek.com>,
	linux-mediatek <linux-mediatek@lists.infradead.org>, Michael-CY Lee
	<michael-cy.lee@mediatek.com>
Subject: [PATCH] wifi: mac80211: extend IEEE80211_KEY_FLAG_GENERATE_MMIE to other ciphers
Date: Tue, 26 Mar 2024 08:30:36 +0800
Message-ID: <20240326003036.15215-1-michael-cy.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

This commit extends the flag IEEE80211_KEY_FLAG_GENERATE_MMIE to
BIP-CMAC-256, BIP-GMAC-128 and BIP-GMAC-256 for the same reason that the
flag was added.
(a0b4496a4368: mac80211: add IEEE80211_KEY_FLAG_GENERATE_MMIE to ieee80211_key_flags)

Signed-off-by: Michael-CY Lee <michael-cy.lee@mediatek.com>
---
 include/net/mac80211.h |  4 ++--
 net/mac80211/wpa.c     | 12 ++++++++++--
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index f5b6f46..7709854 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -2133,8 +2133,8 @@ static inline bool lockdep_vif_wiphy_mutex_held(struct ieee80211_vif *vif)
  *	@IEEE80211_KEY_FLAG_GENERATE_MMIC on the same key.
  * @IEEE80211_KEY_FLAG_NO_AUTO_TX: Key needs explicit Tx activation.
  * @IEEE80211_KEY_FLAG_GENERATE_MMIE: This flag should be set by the driver
- *	for a AES_CMAC key to indicate that it requires sequence number
- *	generation only
+ *	for a AES_CMAC or a AES_GMAC key to indicate that it requires sequence
+ *	number generation only
  * @IEEE80211_KEY_FLAG_SPP_AMSDU: SPP A-MSDUs can be used with this key
  *	(set by mac80211 from the sta->spp_amsdu flag)
  */
diff --git a/net/mac80211/wpa.c b/net/mac80211/wpa.c
index daf1bcc..e66f917 100644
--- a/net/mac80211/wpa.c
+++ b/net/mac80211/wpa.c
@@ -903,7 +903,8 @@ ieee80211_crypto_aes_cmac_256_encrypt(struct ieee80211_tx_data *tx)
 
 	info = IEEE80211_SKB_CB(skb);
 
-	if (info->control.hw_key)
+	if (info->control.hw_key &&
+	    !(key->conf.flags & IEEE80211_KEY_FLAG_GENERATE_MMIE))
 		return TX_CONTINUE;
 
 	if (WARN_ON(skb_tailroom(skb) < sizeof(*mmie)))
@@ -919,6 +920,9 @@ ieee80211_crypto_aes_cmac_256_encrypt(struct ieee80211_tx_data *tx)
 
 	bip_ipn_set64(mmie->sequence_number, pn64);
 
+	if (info->control.hw_key)
+		return TX_CONTINUE;
+
 	bip_aad(skb, aad);
 
 	/* MIC = AES-256-CMAC(IGTK, AAD || Management Frame Body || MMIE, 128)
@@ -1048,7 +1052,8 @@ ieee80211_crypto_aes_gmac_encrypt(struct ieee80211_tx_data *tx)
 
 	info = IEEE80211_SKB_CB(skb);
 
-	if (info->control.hw_key)
+	if (info->control.hw_key &&
+	    !(key->conf.flags & IEEE80211_KEY_FLAG_GENERATE_MMIE))
 		return TX_CONTINUE;
 
 	if (WARN_ON(skb_tailroom(skb) < sizeof(*mmie)))
@@ -1064,6 +1069,9 @@ ieee80211_crypto_aes_gmac_encrypt(struct ieee80211_tx_data *tx)
 
 	bip_ipn_set64(mmie->sequence_number, pn64);
 
+	if (info->control.hw_key)
+		return TX_CONTINUE;
+
 	bip_aad(skb, aad);
 
 	hdr = (struct ieee80211_hdr *)skb->data;
-- 
2.25.1


