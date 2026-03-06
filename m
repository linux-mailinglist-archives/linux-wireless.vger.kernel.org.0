Return-Path: <linux-wireless+bounces-32669-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eBM3FYtiq2mmcgEAu9opvQ
	(envelope-from <linux-wireless+bounces-32669-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 07 Mar 2026 00:26:03 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B1C0D228A79
	for <lists+linux-wireless@lfdr.de>; Sat, 07 Mar 2026 00:26:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A899B3089571
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Mar 2026 23:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB8D235F8D1;
	Fri,  6 Mar 2026 23:23:23 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD1E37418B
	for <linux-wireless@vger.kernel.org>; Fri,  6 Mar 2026 23:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772839403; cv=none; b=N5rNs9/kXazmU4yClJegOwYEXQugzTD7qEjbvf2c2qQFZMAIR23oisHYQjpJ66XxKtPvJW34as9QiLJDol67ocCN3xDAGeWaxO36K6cNre0Bq34l+b0K13dR+Irs3ItXNkeMKXyzFr51bcWEVbPiba++xxMfhG8F6KmlR1s8+bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772839403; c=relaxed/simple;
	bh=z9pg2SkvQr6F+Dhk/4DmRUQnsisniRHhH3C0s45/FlE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MdaZoywrgI7diTLxEadQckn7LMbUZbm4AyLaOmRSEK9G2+mNdaTlryM0C+8JscK/7XlG9a/QdEHsGnQRQmmT8Z7hVmD7hAfwhZtZdZEWVS4QEOv4qPi7yCwS6fMlX9qyVMnuEaVFsIZnSr73eCUfT4N53arBhW6+iFpaHTyl+cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7d19bfe1190so8455665a34.1
        for <linux-wireless@vger.kernel.org>; Fri, 06 Mar 2026 15:23:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772839401; x=1773444201;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eOD3zRJqOCMqqpCjIadZc4fQHL5fDXCfN6bs+v14d2E=;
        b=lt3lUMdeuWVDhOBl/eBsmugc0JTVP6joAW9LAXKvjLQYBx0oJCUYfMBhihPqEmVxqy
         GBJUQpG2qQusLrTsh59RtM1mc3nzGoG1aH1h8yQpkHDet4qC+ie0N62ZImPo6bUZ5EQA
         fsML8s7lk8fLX/vEidAY8psZFnJZHk4s4Qk6jRi+kG1AGfVjrXgWnoTyYjXrBDrHSYNC
         J9SITqizNrmJla4TQt7LhPhA9bPv19KXN7hoT80sRtQdmM4VP4B0BJOrtp2YMbSshEJ2
         xOqi0QRoZLk4S9UosOfD/NKvnNj8iWSGYtMVo5GpIZS6ArFJtltw4rolpvNebPBYC5c6
         V37g==
X-Gm-Message-State: AOJu0YzRBKNZsTzCnj3f73ZF+KNjNuwBkUKJH1K1NaprMZ1GZ2BsZGh3
	FfH4k2+juRhhLu9wRab6vASVAAVj2UeIpODc2LBPaZhZ6CqIhz5t8+hg
X-Gm-Gg: ATEYQzwt11o02Gwf0PATPTjDCHvS1dobhZqlWjBkluphYLocRqcAoC678TI/szrBbVJ
	SATGKCnZd9eGu3EUaNQSL/6UTMGXA3ut8/0EIxZ1i+C39L6IG+oI4EFOKkMx5viThASaJiitg/U
	MZAssJgmmd/3duOmMXg8Rgcmz6+YrTzvQPLgvAiMQzeW0e+o8bNVn5WvALFI/ERDgGiw7RB4xBi
	DvYIoU/sOGOCE3EcQZ8puay9c/lacBhlCS4n6PDjNFaTFD6ZAN9FYJVFkdyxZLgc1NMG7DLSc+r
	PiYOyXvQxt73tiN7WRCijLMtwpD2ANmdE7yQawFqcU2vo3R0ddZBig1vw0ij6lvLVQ96Dyt6G/q
	kDX+P+7XgM1UhfMxUCgKW9hfHwfVAx38PQqVMUsqXfbhaRduK0OevvqtiOdjcDyc6+NyleHBPz8
	VMCm3CfhCywlPgADTNJFj9E9yti3y2Ezcweoc+OJ2gY826u3E=
X-Received: by 2002:a05:6808:6713:b0:462:dbf2:514f with SMTP id 5614622812f47-466dca56ff3mr2400468b6e.23.1772839401106;
        Fri, 06 Mar 2026 15:23:21 -0800 (PST)
Received: from sean-HP-EliteBook-830-G6.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-416e65b1c82sm2572344fac.5.2026.03.06.15.23.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 15:23:20 -0800 (PST)
From: Sean Wang <sean.wang@kernel.org>
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH 04/19] wifi: mt76: mt7925: pass mlink to mcu_sta_update()
Date: Fri,  6 Mar 2026 17:22:23 -0600
Message-ID: <20260306232238.2039675-5-sean.wang@kernel.org>
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
X-Rspamd-Queue-Id: B1C0D228A79
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-32669-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FROM_NEQ_ENVFROM(0.00)[sean.wang@kernel.org,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.390];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mediatek.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: Sean Wang <sean.wang@mediatek.com>

Drop the mt792x_sta_to_link() lookup in mt7925_mcu_sta_update() and
pass the resolved mlink from the caller instead. The link context is
already known at the call site, making the lookup redundant.

This keeps the helper lookup-free and makes WCID selection explicit.

No functional change intended.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7925/mac.c   |  3 ++-
 .../net/wireless/mediatek/mt76/mt7925/main.c  | 27 +++++++++++++------
 .../net/wireless/mediatek/mt76/mt7925/mcu.c   | 12 +++------
 .../wireless/mediatek/mt76/mt7925/mt7925.h    |  4 ++-
 4 files changed, 28 insertions(+), 18 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mac.c b/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
index 82eedd80f694..139c2a7871fc 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
@@ -1285,7 +1285,8 @@ mt7925_vif_connect_iter(void *priv, u8 *mac,
 	if (vif->type == NL80211_IFTYPE_AP) {
 		mt76_connac_mcu_uni_add_bss(dev->phy.mt76, vif, &mvif->sta.deflink.wcid,
 					    true, NULL);
-		mt7925_mcu_sta_update(dev, NULL, vif, true,
+		mt7925_mcu_sta_update(dev, NULL, vif,
+				      &mvif->sta.deflink, true,
 				      MT76_STA_INFO_STATE_NONE);
 		mt7925_mcu_uni_add_beacon_offload(dev, hw, vif, true);
 	}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index 353461f0e169..c65e32a14c01 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -919,23 +919,31 @@ static int mt7925_mac_link_sta_add(struct mt76_dev *mdev,
 
 	if (ieee80211_vif_is_mld(vif) &&
 	    link_sta == mlink->pri_link) {
-		ret = mt7925_mcu_sta_update(dev, link_sta, vif, true,
+		ret = mt7925_mcu_sta_update(dev, link_sta, vif,
+					    mlink, true,
 					    MT76_STA_INFO_STATE_NONE);
 		if (ret)
 			return ret;
 	} else if (ieee80211_vif_is_mld(vif) &&
 		   link_sta != mlink->pri_link) {
+		struct mt792x_link_sta *pri_mlink;
+
+		pri_mlink = mt792x_sta_to_link(msta, mlink->pri_link->link_id);
+
 		ret = mt7925_mcu_sta_update(dev, mlink->pri_link, vif,
-					    true, MT76_STA_INFO_STATE_ASSOC);
+					    pri_mlink, true,
+					    MT76_STA_INFO_STATE_ASSOC);
 		if (ret)
 			return ret;
 
-		ret = mt7925_mcu_sta_update(dev, link_sta, vif, true,
+		ret = mt7925_mcu_sta_update(dev, link_sta, vif,
+					    mlink, true,
 					    MT76_STA_INFO_STATE_ASSOC);
 		if (ret)
 			return ret;
 	} else {
-		ret = mt7925_mcu_sta_update(dev, link_sta, vif, true,
+		ret = mt7925_mcu_sta_update(dev, link_sta, vif,
+					    mlink, true,
 					    MT76_STA_INFO_STATE_NONE);
 		if (ret)
 			return ret;
@@ -1075,7 +1083,8 @@ static void mt7925_mac_link_sta_assoc(struct mt76_dev *mdev,
 			       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
 	memset(mlink->airtime_ac, 0, sizeof(mlink->airtime_ac));
 
-	mt7925_mcu_sta_update(dev, link_sta, vif, true, MT76_STA_INFO_STATE_ASSOC);
+	mt7925_mcu_sta_update(dev, link_sta, vif, mlink, true,
+			      MT76_STA_INFO_STATE_ASSOC);
 
 	mt792x_mutex_release(dev);
 }
@@ -1119,7 +1128,7 @@ static void mt7925_mac_link_sta_remove(struct mt76_dev *mdev,
 	mt76_connac_free_pending_tx_skbs(&dev->pm, &mlink->wcid);
 	mt76_connac_pm_wake(&dev->mphy, &dev->pm);
 
-	mt7925_mcu_sta_update(dev, link_sta, vif, false,
+	mt7925_mcu_sta_update(dev, link_sta, vif, mlink, false,
 			      MT76_STA_INFO_STATE_NONE);
 	mt7925_mac_wtbl_update(dev, mlink->wcid.idx,
 			       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
@@ -1744,7 +1753,8 @@ mt7925_start_ap(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	if (err)
 		goto out;
 
-	err = mt7925_mcu_sta_update(dev, NULL, vif, true,
+	err = mt7925_mcu_sta_update(dev, NULL, vif,
+				    &mvif->sta.deflink, true,
 				    MT76_STA_INFO_STATE_NONE);
 out:
 	mt792x_mutex_release(dev);
@@ -1887,7 +1897,8 @@ static void mt7925_vif_cfg_changed(struct ieee80211_hw *hw,
 	mt792x_mutex_acquire(dev);
 
 	if (changed & BSS_CHANGED_ASSOC) {
-		mt7925_mcu_sta_update(dev, NULL, vif, true,
+		mt7925_mcu_sta_update(dev, NULL, vif,
+				      &mvif->sta.deflink, true,
 				      MT76_STA_INFO_STATE_ASSOC);
 		mt7925_mcu_set_beacon_filter(dev, vif, vif->cfg.assoc);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index 7582a8c48607..fa4915b65fcc 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -2036,7 +2036,9 @@ mt7925_mcu_sta_cmd(struct mt76_phy *phy,
 
 int mt7925_mcu_sta_update(struct mt792x_dev *dev,
 			  struct ieee80211_link_sta *link_sta,
-			  struct ieee80211_vif *vif, bool enable,
+			  struct ieee80211_vif *vif,
+			  struct mt792x_link_sta *mlink,
+			  bool enable,
 			  enum mt76_sta_info_state state)
 {
 	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
@@ -2051,14 +2053,8 @@ int mt7925_mcu_sta_update(struct mt792x_dev *dev,
 		.offload_fw = true,
 		.rcpi = to_rcpi(rssi),
 	};
-	struct mt792x_sta *msta;
-	struct mt792x_link_sta *mlink;
 
-	if (link_sta) {
-		msta = (struct mt792x_sta *)link_sta->sta->drv_priv;
-		mlink = mt792x_sta_to_link(msta, link_sta->link_id);
-	}
-	info.wcid = link_sta ? &mlink->wcid : &mvif->sta.deflink.wcid;
+	info.wcid = &mlink->wcid;
 	info.newly = state != MT76_STA_INFO_STATE_ASSOC;
 
 	return mt7925_mcu_sta_cmd(&dev->mphy, &info);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h b/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h
index 0f0eff748bb7..95f29dae4d9d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h
@@ -250,7 +250,9 @@ int mt7925_mcu_set_bss_pm(struct mt792x_dev *dev,
 			  bool enable);
 int mt7925_mcu_sta_update(struct mt792x_dev *dev,
 			  struct ieee80211_link_sta *link_sta,
-			  struct ieee80211_vif *vif, bool enable,
+			  struct ieee80211_vif *vif,
+			  struct mt792x_link_sta *mlink,
+			  bool enable,
 			  enum mt76_sta_info_state state);
 int mt7925_mcu_set_chan_info(struct mt792x_phy *phy, u16 tag);
 int mt7925_mcu_set_tx(struct mt792x_dev *dev, struct ieee80211_bss_conf *bss_conf);
-- 
2.43.0


