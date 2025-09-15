Return-Path: <linux-wireless+bounces-27300-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BD68B57218
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Sep 2025 09:59:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D9641898A3F
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Sep 2025 07:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED5442EA477;
	Mon, 15 Sep 2025 07:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="GyqHQqhi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A552E9EC0
	for <linux-wireless@vger.kernel.org>; Mon, 15 Sep 2025 07:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757923161; cv=none; b=pWL1k+ocd9O4rIQnuurLQpZHwACLm6I0j01S4jIJqCEkumhh1n1cqFAUdGhDfeklh7MqqbGggUXkPB1WNKXtMy/OLS3g9dbp3XwVCjJIVyBaxxgJcvPnvWSzmqwl/0/zy5ZqU4sUuRZrLHwscN+AmsMonxlQG9+sYrdrJ+R9ET8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757923161; c=relaxed/simple;
	bh=Wxs5rg/0n8QMdxl2yuKa9kOdtetzJvUtR8q08gFL5ZY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UOwlh9DHdkAvd3z3l1NOGqYgw1UxxJbX6ZdK7ykj9Fy18GVvxFMaKDjFf285JBmekr3Jho5npAVBHA0/Lbd6wiouoooPZwNiTRRc0T6oa100IdVnd5hhx5HMsv489eiUEzyURQGPLzJmfcML925neMoYJ4qMUHCfg8yJKgQTJXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=GyqHQqhi; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=jRSNJeAkVxvQ4KKn+6d/Sbz1T7hF6HViyMbgXI37Q3M=; b=GyqHQqhiJYCwJfLQnf5g8tgMux
	dGoTpsiDHLK/v6jG2Fzikk5Ld0lKMjZHwl+vcClneSBzPoNrCCrhG2DbvvBNb8laTD2aqd08RFq6T
	aG+pnAebeWnb7I+TM+JOPlVceImQIgVJ1hRekuYSCKJ6pl6s5vygi9SC2SLeAUwYFpxA=;
Received: from p5b206816.dip0.t-ipconnect.de ([91.32.104.22] helo=Maecks.lan)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1uy47D-0078GN-21
	for linux-wireless@vger.kernel.org;
	Mon, 15 Sep 2025 09:59:11 +0200
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Subject: [PATCH mt76 04/15] wifi: mt76: mt7996: fix setting beacon protection keys
Date: Mon, 15 Sep 2025 09:58:59 +0200
Message-ID: <20250915075910.47558-4-nbd@nbd.name>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250915075910.47558-1-nbd@nbd.name>
References: <20250915075910.47558-1-nbd@nbd.name>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Include beacon key information in the STA_REC_UPDATE call.
Remove mt7996_mcu_get_pn - when installing a new key, we should
not reuse any existing PN value.

Signed-off-by: Allen Ye <allen.ye@mediatek.com>
Signed-off-by: Michael-CY Lee <michael-cy.lee@mediatek.com>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 .../net/wireless/mediatek/mt76/mt7996/main.c  |   7 -
 .../net/wireless/mediatek/mt76/mt7996/mcu.c   | 156 +++++-------------
 .../net/wireless/mediatek/mt76/mt7996/mcu.h   |  14 +-
 3 files changed, 45 insertions(+), 132 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index 8fbe60723071..84d5e0430a94 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -262,13 +262,6 @@ mt7996_set_hw_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 
 		mt76_wcid_key_setup(&dev->mt76, &msta_link->wcid, key);
 
-		if (key->keyidx == 6 || key->keyidx == 7) {
-			err = mt7996_mcu_bcn_prot_enable(dev, link,
-							 msta_link, key);
-			if (err)
-				return err;
-		}
-
 		err = mt7996_mcu_add_key(&dev->mt76, vif, key,
 					 MCU_WMWA_UNI_CMD(STA_REC_UPDATE),
 					 &msta_link->wcid, cmd);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index 29552ab16089..5c16e4b780ad 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -2545,41 +2545,58 @@ mt7996_mcu_sta_key_tlv(struct mt76_wcid *wcid,
 		       enum set_key_cmd cmd)
 {
 	struct sta_rec_sec_uni *sec;
+	struct sec_key_uni *sec_key;
 	struct tlv *tlv;
+	u8 cipher;
 
 	tlv = mt76_connac_mcu_add_tlv(skb, STA_REC_KEY_V2, sizeof(*sec));
 	sec = (struct sta_rec_sec_uni *)tlv;
-	sec->add = cmd;
+	sec->add = 0;
+	sec->n_cipher = 1;
+	sec_key = &sec->key[0];
+	sec_key->wlan_idx = cpu_to_le16(wcid->idx);
+	sec_key->key_id = key->keyidx;
 
-	if (cmd == SET_KEY) {
-		struct sec_key_uni *sec_key;
-		u8 cipher;
+	if (cmd != SET_KEY)
+		return 0;
 
-		cipher = mt76_connac_mcu_get_cipher(key->cipher);
-		if (cipher == MCU_CIPHER_NONE)
-			return -EOPNOTSUPP;
+	cipher = mt76_connac_mcu_get_cipher(key->cipher);
+	if (cipher == MCU_CIPHER_NONE)
+		return -EOPNOTSUPP;
 
-		sec_key = &sec->key[0];
-		sec_key->wlan_idx = cpu_to_le16(wcid->idx);
-		sec_key->mgmt_prot = 0;
-		sec_key->cipher_id = cipher;
-		sec_key->cipher_len = sizeof(*sec_key);
-		sec_key->key_id = key->keyidx;
-		sec_key->key_len = key->keylen;
-		sec_key->need_resp = 0;
-		memcpy(sec_key->key, key->key, key->keylen);
+	sec_key->mgmt_prot = 0;
+	sec_key->cipher_id = cipher;
+	sec_key->cipher_len = sizeof(*sec_key);
+	sec_key->key_len = key->keylen;
+	sec_key->need_resp = 0;
+	memcpy(sec_key->key, key->key, key->keylen);
 
-		if (cipher == MCU_CIPHER_TKIP) {
-			/* Rx/Tx MIC keys are swapped */
-			memcpy(sec_key->key + 16, key->key + 24, 8);
-			memcpy(sec_key->key + 24, key->key + 16, 8);
-		}
-
-		sec->n_cipher = 1;
-	} else {
-		sec->n_cipher = 0;
+	if (cipher == MCU_CIPHER_TKIP) {
+		/* Rx/Tx MIC keys are swapped */
+		memcpy(sec_key->key + 16, key->key + 24, 8);
+		memcpy(sec_key->key + 24, key->key + 16, 8);
+		return 0;
 	}
 
+	if (sec_key->key_id != 6 && sec_key->key_id != 7)
+		return 0;
+
+	switch (key->cipher) {
+	case WLAN_CIPHER_SUITE_AES_CMAC:
+		sec_key->cipher_id = MCU_CIPHER_BCN_PROT_CMAC_128;
+		break;
+	case WLAN_CIPHER_SUITE_BIP_GMAC_128:
+		sec_key->cipher_id = MCU_CIPHER_BCN_PROT_GMAC_128;
+		break;
+	case WLAN_CIPHER_SUITE_BIP_GMAC_256:
+		sec_key->cipher_id = MCU_CIPHER_BCN_PROT_GMAC_256;
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	sec_key->bcn_mode = BP_SW_MODE;
+
 	return 0;
 }
 
@@ -2603,95 +2620,6 @@ int mt7996_mcu_add_key(struct mt76_dev *dev, struct ieee80211_vif *vif,
 	return mt76_mcu_skb_send_msg(dev, skb, mcu_cmd, true);
 }
 
-static int mt7996_mcu_get_pn(struct mt7996_dev *dev,
-			     struct mt7996_vif_link *link,
-			     struct mt7996_sta_link *msta_link, u8 *pn)
-{
-#define TSC_TYPE_BIGTK_PN 2
-	struct sta_rec_pn_info *pn_info;
-	struct sk_buff *skb, *rskb;
-	struct tlv *tlv;
-	int ret;
-
-	skb = mt76_connac_mcu_alloc_sta_req(&dev->mt76, &link->mt76,
-					    &msta_link->wcid);
-	if (IS_ERR(skb))
-		return PTR_ERR(skb);
-
-	tlv = mt76_connac_mcu_add_tlv(skb, STA_REC_PN_INFO, sizeof(*pn_info));
-	pn_info = (struct sta_rec_pn_info *)tlv;
-
-	pn_info->tsc_type = TSC_TYPE_BIGTK_PN;
-	ret = mt76_mcu_skb_send_and_get_msg(&dev->mt76, skb,
-					    MCU_WM_UNI_CMD_QUERY(STA_REC_UPDATE),
-					    true, &rskb);
-	if (ret)
-		return ret;
-
-	skb_pull(rskb, 4);
-
-	pn_info = (struct sta_rec_pn_info *)rskb->data;
-	if (le16_to_cpu(pn_info->tag) == STA_REC_PN_INFO)
-		memcpy(pn, pn_info->pn, 6);
-
-	dev_kfree_skb(rskb);
-	return 0;
-}
-
-int mt7996_mcu_bcn_prot_enable(struct mt7996_dev *dev,
-			       struct mt7996_vif_link *link,
-			       struct mt7996_sta_link *msta_link,
-			       struct ieee80211_key_conf *key)
-{
-	struct mt7996_mcu_bcn_prot_tlv *bcn_prot;
-	struct sk_buff *skb;
-	struct tlv *tlv;
-	u8 pn[6] = {};
-	int len = sizeof(struct bss_req_hdr) +
-		  sizeof(struct mt7996_mcu_bcn_prot_tlv);
-	int ret;
-
-	skb = __mt7996_mcu_alloc_bss_req(&dev->mt76, &link->mt76, len);
-	if (IS_ERR(skb))
-		return PTR_ERR(skb);
-
-	tlv = mt76_connac_mcu_add_tlv(skb, UNI_BSS_INFO_BCN_PROT, sizeof(*bcn_prot));
-
-	bcn_prot = (struct mt7996_mcu_bcn_prot_tlv *)tlv;
-
-	ret = mt7996_mcu_get_pn(dev, link, msta_link, pn);
-	if (ret) {
-		dev_kfree_skb(skb);
-		return ret;
-	}
-
-	switch (key->cipher) {
-	case WLAN_CIPHER_SUITE_AES_CMAC:
-		bcn_prot->cipher_id = MCU_CIPHER_BCN_PROT_CMAC_128;
-		break;
-	case WLAN_CIPHER_SUITE_BIP_GMAC_128:
-		bcn_prot->cipher_id = MCU_CIPHER_BCN_PROT_GMAC_128;
-		break;
-	case WLAN_CIPHER_SUITE_BIP_GMAC_256:
-		bcn_prot->cipher_id = MCU_CIPHER_BCN_PROT_GMAC_256;
-		break;
-	case WLAN_CIPHER_SUITE_BIP_CMAC_256:
-	default:
-		dev_err(dev->mt76.dev, "Not supported Bigtk Cipher\n");
-		dev_kfree_skb(skb);
-		return -EOPNOTSUPP;
-	}
-
-	pn[0]++;
-	memcpy(bcn_prot->pn, pn, 6);
-	bcn_prot->enable = BP_SW_MODE;
-	memcpy(bcn_prot->key, key->key, WLAN_MAX_KEY_LEN);
-	bcn_prot->key_id = key->keyidx;
-
-	return mt76_mcu_skb_send_msg(&dev->mt76, skb,
-				     MCU_WMWA_UNI_CMD(BSS_INFO_UPDATE), true);
-}
-
 int mt7996_mcu_add_dev_info(struct mt7996_phy *phy, struct ieee80211_vif *vif,
 			    struct ieee80211_bss_conf *link_conf,
 			    struct mt76_vif_link *mlink, bool enable)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.h
index 7b21d6ae7e43..c841da1c60e5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.h
@@ -351,17 +351,6 @@ enum {
 	BP_HW_MODE,
 };
 
-struct mt7996_mcu_bcn_prot_tlv {
-	__le16 tag;
-	__le16 len;
-	u8 pn[6];
-	u8 enable;
-	u8 cipher_id;
-	u8 key[WLAN_MAX_KEY_LEN];
-	u8 key_id;
-	u8 __rsv[3];
-} __packed;
-
 struct bss_ra_tlv {
 	__le16 tag;
 	__le16 len;
@@ -531,6 +520,9 @@ struct sec_key_uni {
 	u8 key_len;
 	u8 need_resp;
 	u8 key[32];
+	u8 pn[6];
+	u8 bcn_mode;
+	u8 _rsv;
 } __packed;
 
 struct sta_rec_sec_uni {
-- 
2.51.0


