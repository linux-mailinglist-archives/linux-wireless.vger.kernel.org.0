Return-Path: <linux-wireless+bounces-35293-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yOWPOkfi7GlvdQAAu9opvQ
	(envelope-from <linux-wireless+bounces-35293-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Apr 2026 17:48:23 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 58906466CA9
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Apr 2026 17:48:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 17DE5300D932
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Apr 2026 15:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7240C282F2F;
	Sat, 25 Apr 2026 15:48:21 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA5614F70
	for <linux-wireless@vger.kernel.org>; Sat, 25 Apr 2026 15:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777132101; cv=none; b=C3F2w2YWA1UlHpRvYqfa9tUxYpe9Fh/Ayqz0hrI5zywscvssqgHZ2bxXlx36aoZT+aUwQVrBkqdwOZRm2Bfe7Oo8cGBzSKBACskpUulIgg6wVqJi272/Z1wHSUlP3Fw7aaB7cAoa6Qd5VZ85xQct3oKZySci3gPrOWbxmuKkKug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777132101; c=relaxed/simple;
	bh=dVMvR3qgQBaSfFoZFox5c9pDN3TkcjfbQZCl+Q+SM30=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U/LjasdATmCMoIiC0jw0dQSCIm5yBB2oFLnrb3cYGBENyqL80AEz8l2SjLYsuJipxAi5CMFuXsWLvXFqK3YzaZ1riSq7L6vH6phZN2mvFUy8TqynuqgWPw08BCtM0LhxEgIILb/RGFLECy7kQ785WZhxCPL4yyLg9kanoQkfu9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-694932346a1so2177086eaf.3
        for <linux-wireless@vger.kernel.org>; Sat, 25 Apr 2026 08:48:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777132099; x=1777736899;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IMZ4OKxAOpjq1wTGWUMmzIk1+fYlw284KMgTkrD2fbY=;
        b=Dg74MKppQJGhptcHJU1ScRDSMwBkP/D5Hb7AUgAw15RyrLhkgC9sq+VSBCeo0wMX5H
         5HtL7rQKYXkf2rtAqYwSOMjsOKZrHUAvuLNBH/UR3l9K6Ez1ZgcS1it2QZXoqRyGZ/9B
         qfI4RJ4RDwkGvb1XPPSqfU1Tp8gcfmSCSbOB68jtnRMUNgnmQbeZsiqJBMlg6QLLNbJN
         ZrMLsnEIUII836Jiz4ZqEgXiayooLbZS0gpoX+bQkdUyQFFv/m1Qeps3VBVx49Klm+Yq
         O+9D+PGSUp8nTbz1im7rnkWuJ64OtohgNofhtOSTRc3pBZfKTBlvPicIUBOKzXrQmCr0
         ge6A==
X-Gm-Message-State: AOJu0Ywf7rGq7uvBX+1e9tsmza23MVl9KpwoDM0NgjLSkc2VaUXF8hJJ
	kw1nTr4/roEyPLXxVCpUDiE0Vaf/MxrWymVPl1s3YdVqGZfgmHB/v3Ym
X-Gm-Gg: AeBDievcDI1kZr+W0AsQZZhUlecFWNdbZqSaFLB67SNwLapdE6Pq0M3CiyEv5F+eHu4
	Ec286meaCt02MKlGcsHuP8mYqJRXyw6Q6ZG66WORQddD2wsMxIVcvrzOTc34PvwbcYAbwbqicQH
	FKZQJFmteWz4gVGIfA8dXpjHNvumxd4EHQQEhdqibT/OH71yQ3UWvy7XW7W66P5mxn1pSbiUHbc
	oM5TQdomJaG5CeR5TKbrq7RzGSN6RsJ72S9EdkVSG4SMtvLBgU1iU0WrAoBiw/TuMHYVSbBVpa/
	g2dBdaSZ8phSDut6181NffcPofBdM7xUEGRN/rCNCa+gnBiN4CAdRacJL0w6H8y+FlEIn4dSgXq
	t5KmBSGowVKCGuUMBb5B6F1vgXd3dIuN3kUwB/uj0iGvOYiAzWEKABaG9AwV8P+PaYlXFlkaEb4
	e3aeDOxt4sqBs7uuen3tYzkOWm7rPVtooFLq7ewTuOCeFEXDJ8V+K0q9yATeZcOlCeoRL+uoA2m
	OxFErx3tFqJ
X-Received: by 2002:a05:6820:1693:b0:694:9861:ec59 with SMTP id 006d021491bc7-6949861f23cmr12572803eaf.28.1777132098843;
        Sat, 25 Apr 2026 08:48:18 -0700 (PDT)
Received: from sean-HP-EliteBook-830-G6.attlocal.net ([2600:1702:5083:7610:9f96:11d3:5f6c:5582])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69493183021sm10094808eaf.13.2026.04.25.08.48.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Apr 2026 08:48:17 -0700 (PDT)
From: sean.wang@kernel.org
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Sean Wang <sean.wang@mediatek.com>,
	Yao Ting Hsieh <yao-ting.hsieh@mediatek.com>
Subject: [PATCH 3/3] wifi: mt76: mt7925: program BA state on active links
Date: Sat, 25 Apr 2026 10:47:21 -0500
Message-ID: <20260425154721.738101-3-sean.wang@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260425154721.738101-1-sean.wang@kernel.org>
References: <20260425154721.738101-1-sean.wang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 58906466CA9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-35293-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sean.wang@kernel.org,linux-wireless@vger.kernel.org]

From: Sean Wang <sean.wang@mediatek.com>

With MLO, traffic for one TID can be sent on any active link. Programming
BA state only on the default link leaves the other active links out of
sync.

Program BA state on all active links instead.

Fixes: 766ea2cf5a39 ("Revert "wifi: mt76: mt7925: Update mt7925_mcu_uni_[tx,rx]_ba for MLO"")
Tested-by: Yao Ting Hsieh <yao-ting.hsieh@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7925/main.c  | 10 +--
 .../net/wireless/mediatek/mt76/mt7925/mcu.c   | 67 ++++++++++++++-----
 .../wireless/mediatek/mt76/mt7925/mt7925.h    |  4 +-
 3 files changed, 59 insertions(+), 22 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index 73d3722739d0..7c20fd9522cf 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -1372,22 +1372,22 @@ mt7925_ampdu_action(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	case IEEE80211_AMPDU_RX_START:
 		mt76_rx_aggr_start(&dev->mt76, &msta->deflink.wcid, tid, ssn,
 				   params->buf_size);
-		mt7925_mcu_uni_rx_ba(dev, params, true);
+		mt7925_mcu_uni_rx_ba(dev, params, vif, true);
 		break;
 	case IEEE80211_AMPDU_RX_STOP:
 		mt76_rx_aggr_stop(&dev->mt76, &msta->deflink.wcid, tid);
-		mt7925_mcu_uni_rx_ba(dev, params, false);
+		mt7925_mcu_uni_rx_ba(dev, params, vif, false);
 		break;
 	case IEEE80211_AMPDU_TX_OPERATIONAL:
 		mtxq->aggr = true;
 		mtxq->send_bar = false;
-		mt7925_mcu_uni_tx_ba(dev, params, true);
+		mt7925_mcu_uni_tx_ba(dev, params, vif, true);
 		break;
 	case IEEE80211_AMPDU_TX_STOP_FLUSH:
 	case IEEE80211_AMPDU_TX_STOP_FLUSH_CONT:
 		mtxq->aggr = false;
 		clear_bit(tid, &msta->deflink.wcid.ampdu_state);
-		mt7925_mcu_uni_tx_ba(dev, params, false);
+		mt7925_mcu_uni_tx_ba(dev, params, vif, false);
 		break;
 	case IEEE80211_AMPDU_TX_START:
 		set_bit(tid, &msta->deflink.wcid.ampdu_state);
@@ -1396,7 +1396,7 @@ mt7925_ampdu_action(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	case IEEE80211_AMPDU_TX_STOP_CONT:
 		mtxq->aggr = false;
 		clear_bit(tid, &msta->deflink.wcid.ampdu_state);
-		mt7925_mcu_uni_tx_ba(dev, params, false);
+		mt7925_mcu_uni_tx_ba(dev, params, vif, false);
 		ieee80211_stop_tx_ba_cb_irqsafe(vif, sta->addr, tid);
 		break;
 	}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index c720d21c1727..b6f7e4a94f57 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -651,32 +651,69 @@ mt7925_mcu_sta_ba(struct mt76_dev *dev, struct mt76_vif_link *mvif,
 				     MCU_UNI_CMD(STA_REC_UPDATE), true);
 }
 
-/** starec & wtbl **/
 int mt7925_mcu_uni_tx_ba(struct mt792x_dev *dev,
 			 struct ieee80211_ampdu_params *params,
-			 bool enable)
+			 struct ieee80211_vif *vif, bool enable)
 {
-	struct mt792x_sta *msta = (struct mt792x_sta *)params->sta->drv_priv;
-	struct mt792x_vif *mvif = msta->vif;
+	struct ieee80211_sta *sta = params->sta;
+	struct mt792x_sta *msta = (struct mt792x_sta *)sta->drv_priv;
+	struct ieee80211_link_sta *link_sta;
+	unsigned int link_id;
+
+	for_each_sta_active_link(vif, sta, link_sta, link_id) {
+		struct mt792x_link_sta *mlink;
+		struct mt792x_bss_conf *mconf;
+		int ret;
+
+		mlink = mt792x_sta_to_link(msta, link_id);
+		if (!mlink)
+			return -EINVAL;
 
-	if (enable && !params->amsdu)
-		msta->deflink.wcid.amsdu = false;
+		mconf = mt792x_vif_to_link(msta->vif, link_id);
+		if (!mconf)
+			return -EINVAL;
+
+		if (enable && !params->amsdu)
+			mlink->wcid.amsdu = false;
 
-	return mt7925_mcu_sta_ba(&dev->mt76, &mvif->bss_conf.mt76, params,
-				 &msta->deflink.wcid,
-				 enable, true);
+		ret = mt7925_mcu_sta_ba(&dev->mt76, &mconf->mt76, params,
+					&mlink->wcid, enable, true);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
 }
 
 int mt7925_mcu_uni_rx_ba(struct mt792x_dev *dev,
 			 struct ieee80211_ampdu_params *params,
-			 bool enable)
+			 struct ieee80211_vif *vif, bool enable)
 {
-	struct mt792x_sta *msta = (struct mt792x_sta *)params->sta->drv_priv;
-	struct mt792x_vif *mvif = msta->vif;
+	struct ieee80211_sta *sta = params->sta;
+	struct mt792x_sta *msta = (struct mt792x_sta *)sta->drv_priv;
+	struct ieee80211_link_sta *link_sta;
+	unsigned int link_id;
+
+	for_each_sta_active_link(vif, sta, link_sta, link_id) {
+		struct mt792x_link_sta *mlink;
+		struct mt792x_bss_conf *mconf;
+		int ret;
+
+		mlink = mt792x_sta_to_link(msta, link_id);
+		if (!mlink)
+			return -EINVAL;
 
-	return mt7925_mcu_sta_ba(&dev->mt76, &mvif->bss_conf.mt76, params,
-				 &msta->deflink.wcid,
-				 enable, false);
+		mconf = mt792x_vif_to_link(msta->vif, link_id);
+		if (!mconf)
+			return -EINVAL;
+
+		ret = mt7925_mcu_sta_ba(&dev->mt76, &mconf->mt76, params,
+					&mlink->wcid, enable, false);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
 }
 
 static int mt7925_mcu_read_eeprom(struct mt792x_dev *dev, u32 offset, u8 *val)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h b/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h
index 46b480f7d813..01d033fb1433 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h
@@ -293,10 +293,10 @@ int mt7925_mcu_set_beacon_filter(struct mt792x_dev *dev,
 				 bool enable);
 int mt7925_mcu_uni_tx_ba(struct mt792x_dev *dev,
 			 struct ieee80211_ampdu_params *params,
-			 bool enable);
+			 struct ieee80211_vif *vif, bool enable);
 int mt7925_mcu_uni_rx_ba(struct mt792x_dev *dev,
 			 struct ieee80211_ampdu_params *params,
-			 bool enable);
+			 struct ieee80211_vif *vif, bool enable);
 void mt7925_mlo_pm_work(struct work_struct *work);
 void mt7925_scan_work(struct work_struct *work);
 void mt7925_roc_work(struct work_struct *work);
-- 
2.43.0


