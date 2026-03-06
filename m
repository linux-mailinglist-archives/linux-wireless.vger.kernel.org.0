Return-Path: <linux-wireless+bounces-32677-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8LhcIgJiq2mmcgEAu9opvQ
	(envelope-from <linux-wireless+bounces-32677-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 07 Mar 2026 00:23:46 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5032D228A0D
	for <lists+linux-wireless@lfdr.de>; Sat, 07 Mar 2026 00:23:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B52583025133
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Mar 2026 23:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1813735E950;
	Fri,  6 Mar 2026 23:23:45 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8135035BDC4
	for <linux-wireless@vger.kernel.org>; Fri,  6 Mar 2026 23:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772839425; cv=none; b=iYmsI+zpjPLWUHqCpXTleREPY4yigUCUlCy9XWkubg0MGOnqNNp6sWIa7CxkKoMbQZ/bJn+tou9XgJfOzdECIYv0Wc5RFsHrNssAO+PfmHZDGsvaDmflGqBna23WVZmDDkIVJLkFYRLYVRwuv4HFJhhIpyAy+OO5fndDKuCl10o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772839425; c=relaxed/simple;
	bh=87EZZACJNQcrBWMD51DN02l7hMWx8EwC/GVCBltUBis=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CUJN8h/AiK/+QgmIVpOuNO3J94Qyp57Gh8YqS98CVfsf7PL92YpaOx8zmO7rcHs4Vs84Toq96xP8Xoij6Py0tk3sS0Q4mXnZ4Ob2jCtuQ7Xn1GmDNKaO9jJ3Jsgx43CoFx/gKk7sHMbcbNiZ1T7HTKZhFm2FpdSCWQ8eCSEZ5IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-4639279c7a6so3355100b6e.1
        for <linux-wireless@vger.kernel.org>; Fri, 06 Mar 2026 15:23:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772839422; x=1773444222;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+uJCt4RmhP+UGOxRLo81UpdyClyYP5NEI25cnmpITUY=;
        b=qStrf45koI3G6k2nhg2Ltv/ECE9ZNZpLhmTN7e8TnBP080cjP2A9cq/Drh2YlLHKzp
         nsVppb3ywI5gUwFGcebILcTEutQ8G/K1q25gB9n6BUbiPcvDnwDblZaVa2ssLeLIX0gv
         wc9eDbXXtrXKDlGXfW+mEyCWuPO1xVxL23QmOWtXfU/m/yPK7Z4iVOMy2lAIGHuZFD21
         X1uw2O34rsgQBeovJtI9MmULjPe6tKuhgUfGzgKiMq00RyZ5ql5vcOWe9O4V9moNcmIH
         ieI2PLSzoDgVYE/FLZhzTV2LEf/BiHxlVs2XgcTVUzZiucO1W1WZpcG0jJjwxvNnWpqh
         RtSg==
X-Gm-Message-State: AOJu0YxhCt9M43LukJ3NTStgLLKxyTB2aGGAXsytRe2F4ZrLQW/tPBKm
	qFc8FalTjYOu4VlGG2EspYZylO9zjBRN1eZXkBUG34EGDx3NqMTL8OE7
X-Gm-Gg: ATEYQzxn7ZJsUZo/YjPDYwSsBZG/m18Fm9lvPWm3fjBgIkrzL6RApuQC9t7tSzlClwX
	C28mC1DV22Yib8FTNLKwyMU+KA1g2g9mSv/K5UWCEw968PLXLCfTPeYCzgtOKWWOXpB5W9hyMOO
	yPda/xLx/ZxS9PrONM6CBkGSezrsOvsV1vo/CXkB3w3xwqPnQM1txjNQQ2VG5xowpBkPapjiMEu
	/9zh/ZNvb02lAGIXATUWAtr4yArncS4vX2yfdW8oq/qR44vG6ufn6UjX6va39U6kdfp2uGAc+El
	CTW64pojM+0/QhQIttbep4px/X3u83TJjq1vALxFLzFpTYNYEfzmrrjVgLvNHG9sT3LZbq0r1c0
	xxrOkFc65XiCwMXOMOZ8uNdHmT7e2+aY3C6uHv+XN5rRx6zjpobcqLCdTBB6PdKN7bXI4XjdefT
	54XjCJkUWEMbX0PHtaP+dwv9HvMS6jzk9gkgDAlkGDQBushf0=
X-Received: by 2002:a05:6808:1b0b:b0:45a:5584:9bf6 with SMTP id 5614622812f47-466dcb27f98mr1968964b6e.39.1772839422517;
        Fri, 06 Mar 2026 15:23:42 -0800 (PST)
Received: from sean-HP-EliteBook-830-G6.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-416e65b1c82sm2572344fac.5.2026.03.06.15.23.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 15:23:42 -0800 (PST)
From: Sean Wang <sean.wang@kernel.org>
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH 12/19] wifi: mt76: mt7925: pass mconf and mlink to wtbl_update_hdr_trans()
Date: Fri,  6 Mar 2026 17:22:31 -0600
Message-ID: <20260306232238.2039675-13-sean.wang@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306232238.2039675-1-sean.wang@kernel.org>
References: <20260306232238.2039675-1-sean.wang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5032D228A0D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-32677-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FROM_NEQ_ENVFROM(0.00)[sean.wang@kernel.org,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.398];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mediatek.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: Sean Wang <sean.wang@mediatek.com>

Drop the mt792x_vif_to_link() lookup in mt7925_mcu_wtbl_update_hdr_trans()
and pass the resolved mconf and mlink from the caller instead. The link
context is already known at the call site, making the lookup redundant.

This keeps the helper lookup-free and makes link ownership explicit.

No functional change intended.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7925/main.c  |  4 +++-
 .../net/wireless/mediatek/mt76/mt7925/mcu.c   | 20 ++++---------------
 .../wireless/mediatek/mt76/mt7925/mt7925.h    |  5 ++---
 3 files changed, 9 insertions(+), 20 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index 135a803b4382..151dc79f7c12 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -1590,8 +1590,10 @@ static void mt7925_sta_set_decap_offload(struct ieee80211_hw *hw,
 	valid = ieee80211_vif_is_mld(vif) ? mvif->valid_links : BIT(0);
 
 	for_each_set_bit(i, &valid, IEEE80211_MLD_MAX_NUM_LINKS) {
+		struct mt792x_bss_conf *mconf;
 		struct mt792x_link_sta *mlink;
 
+		mconf = mt792x_vif_to_link(mvif, i);
 		mlink = mt792x_sta_to_link(msta, i);
 
 		if (enabled)
@@ -1602,7 +1604,7 @@ static void mt7925_sta_set_decap_offload(struct ieee80211_hw *hw,
 		if (!mlink->wcid.sta)
 			continue;
 
-		mt7925_mcu_wtbl_update_hdr_trans(dev, vif, sta, mlink, i);
+		mt7925_mcu_wtbl_update_hdr_trans(dev, vif, mconf, mlink);
 	}
 
 	mt792x_mutex_release(dev);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index 0b096838bca6..2be6160873a5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -1066,7 +1066,6 @@ EXPORT_SYMBOL_GPL(mt7925_run_firmware);
 static void
 mt7925_mcu_sta_hdr_trans_tlv(struct sk_buff *skb,
 			     struct ieee80211_vif *vif,
-			     struct ieee80211_link_sta *link_sta,
 			     struct mt792x_link_sta *mlink)
 {
 	struct sta_rec_hdr_trans *hdr_trans;
@@ -1096,29 +1095,18 @@ mt7925_mcu_sta_hdr_trans_tlv(struct sk_buff *skb,
 
 int mt7925_mcu_wtbl_update_hdr_trans(struct mt792x_dev *dev,
 				     struct ieee80211_vif *vif,
-				     struct ieee80211_sta *sta,
-				     struct mt792x_link_sta *mlink,
-				     int link_id)
+				     struct mt792x_bss_conf *mconf,
+				     struct mt792x_link_sta *mlink)
 {
-	struct ieee80211_link_sta *link_sta = sta ? &sta->deflink : NULL;
-	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
-	struct mt792x_bss_conf *mconf;
 	struct sk_buff *skb;
 
-	link_sta = mt792x_sta_to_link_sta(vif, sta, link_id);
-	mconf = mt792x_vif_to_link(mvif, link_id);
-
 	skb = __mt76_connac_mcu_alloc_sta_req(&dev->mt76, &mconf->mt76,
 					      &mlink->wcid,
 					      MT7925_STA_UPDATE_MAX_SIZE);
 	if (IS_ERR(skb))
 		return PTR_ERR(skb);
 
-	/* starec hdr trans */
-	if (!link_sta)
-		mlink = &mvif->sta.deflink;
-
-	mt7925_mcu_sta_hdr_trans_tlv(skb, vif, link_sta, mlink);
+	mt7925_mcu_sta_hdr_trans_tlv(skb, vif, mlink);
 	return mt76_mcu_skb_send_msg(&dev->mt76, skb,
 				     MCU_WMWA_UNI_CMD(STA_REC_UPDATE), true);
 }
@@ -2022,7 +2010,7 @@ mt7925_mcu_sta_cmd(struct mt76_phy *phy,
 		if (!info->link_sta)
 			mlink = &mvif->sta.deflink;
 
-		mt7925_mcu_sta_hdr_trans_tlv(skb, info->vif, info->link_sta, mlink);
+		mt7925_mcu_sta_hdr_trans_tlv(skb, info->vif, mlink);
 	}
 
 	return mt76_mcu_skb_send_msg(dev, skb, info->cmd, true);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h b/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h
index e28972f0615b..46b480f7d813 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h
@@ -370,9 +370,8 @@ int mt7925_mcu_add_key(struct mt76_dev *dev, struct ieee80211_vif *vif,
 int mt7925_mcu_set_rts_thresh(struct mt792x_phy *phy, u32 val);
 int mt7925_mcu_wtbl_update_hdr_trans(struct mt792x_dev *dev,
 				     struct ieee80211_vif *vif,
-				     struct ieee80211_sta *sta,
-				     struct mt792x_link_sta *mlink,
-				     int link_id);
+				     struct mt792x_bss_conf *mconf,
+				     struct mt792x_link_sta *mlink);
 int mt7925_mcu_wf_rf_pin_ctrl(struct mt792x_phy *phy);
 
 int mt7925_testmode_cmd(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
-- 
2.43.0


