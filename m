Return-Path: <linux-wireless+bounces-32679-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sHpwIwpiq2mmcgEAu9opvQ
	(envelope-from <linux-wireless+bounces-32679-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 07 Mar 2026 00:23:54 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4588E228A1B
	for <lists+linux-wireless@lfdr.de>; Sat, 07 Mar 2026 00:23:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 260B0303EBA7
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Mar 2026 23:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAC3F35E950;
	Fri,  6 Mar 2026 23:23:47 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945C2371D03
	for <linux-wireless@vger.kernel.org>; Fri,  6 Mar 2026 23:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772839427; cv=none; b=M2n+kgyjy4ObR7MwZV8jX0r1eMW/LyzXLi/aqCw26fdUc1btX1ieCk1o95OhBYnytawBZAz1acsoDBqoNvOG6z3arxT1POeLk0WIaTpsAmpj+2OgoRn5y9VbnSjNYESl/ItVlA9zee0LgUCnQ0NE6EhoDzNA9bp0hHs/LxW2tjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772839427; c=relaxed/simple;
	bh=YHCWpgNve71TNbiUt0nnTXYYpmmPsQnutgnhu9F/Dbs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sZRIQnI0dMjZwu3K2W/owhDz9zbTE7ScKCvXBJlYUFZNgyHHYuf3xgcK1BVunpOwGlJDQrmbhDqTxzqz7xXU/XHP07B7L40/FSZ63sYKMOXp5WEaPE7BNeLjq0HtNkfuOeIIamPEelNhuLCLzxBu/ZomtHaylGSt907nni7XkFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-40427db1300so3388705fac.0
        for <linux-wireless@vger.kernel.org>; Fri, 06 Mar 2026 15:23:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772839425; x=1773444225;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WYDpqZoQ+vNHkq329w7Lb717GNTwWDi5eHmjmn69HQs=;
        b=X/6RH0YcmREMKdvDvxG98cBGatzJPfcFn1pqyrOKEwQ7eeuwrqX4A1oFk0lSIp8soK
         1KnFhUaUz7nj/cJkmbn57fdrgIFNhsxgiP5mCtMCMl0ZmjGpqL0N3LBQzjeoPSsSf1df
         qtNpVFOGMUJ7dM5v2cVCpTOMmOjflCp3FmoWoeJxtSIFgM96peCF0hx9zz1zv4rhVgk4
         EMryeVNfgvg6tvVG2R46fL+xvb7IMcPbpGhvTNH+e+qqeumfaTWcpaEd73vkHf++suvn
         JsP7lKsN6RZAs8milnwfcFt/JI/iCPcnA4gFdGQmjs/huJfoMPF8cwUCkWrjUbvkz7Iw
         G9Cw==
X-Gm-Message-State: AOJu0Ywd2hpB9sHImUJXG0EgiETPqBRjgPqJILbEWrsfkzjaT44iyWAZ
	hKwKKRe7LeEZNsg+bn29/Q436p00rV2/BqZ7EccPyb06CY/egimbOfNw
X-Gm-Gg: ATEYQzz89ti1PBeZPNEXxJ4NCvbycNMtOC6s8Bq3/nmZbGOlOgdd3x0VUAmjzJMv9Pb
	Aeku1OAjlX0BSABosR0I/XoJlHF1Ywbn4S4Cw9r+GyEVLWz6bJlKqCeeuan8TouVOLQ+HombVPb
	a1KmevmMp2L+a9SP60gA11FYiHKd3YQb/xhB7vY5H5TX7bNHRHcZbZfS7W83TXIEJ/HrRYwbGXh
	bz19m7BT/lJlqachEnZdpUTFu/eUEx3WMQ5ZJf99TlsGDjzog0aTNhHMXxiDjwGaQhQDNobbuNh
	3snKhPfJbevwC1gvXofTY4DyZbFqqN/NzyBWo2VcFjumzI72REDJWpMoEqGseOMiVn/m8i68oqh
	TI3KUjRM2DxhYDTlOZ9sxKjX5W9DyDq4NgUMnVqESDO7pZtSke7xqBwLuIJaZ6+VH+Vzd4cha2D
	igjsqwOxuzhcO9Lby4MmaItFlCOShzwzs2ofH15NytbFR6A7EYtFT5FYjxkw==
X-Received: by 2002:a05:6871:e41b:b0:40a:5795:152f with SMTP id 586e51a60fabf-416e3f309b8mr2489946fac.4.1772839425579;
        Fri, 06 Mar 2026 15:23:45 -0800 (PST)
Received: from sean-HP-EliteBook-830-G6.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-416e65b1c82sm2572344fac.5.2026.03.06.15.23.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 15:23:45 -0800 (PST)
From: Sean Wang <sean.wang@kernel.org>
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH 14/19] wifi: mt76: mt7925: unwind WCID setup on link STA add failure
Date: Fri,  6 Mar 2026 17:22:33 -0600
Message-ID: <20260306232238.2039675-15-sean.wang@kernel.org>
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
X-Rspamd-Queue-Id: 4588E228A1B
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
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-32679-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FROM_NEQ_ENVFROM(0.00)[sean.wang@kernel.org,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.405];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mediatek.com:email]
X-Rspamd-Action: no action

From: Sean Wang <sean.wang@mediatek.com>

Undo the published WCID state when mt7925_mac_link_sta_add() fails after
WCID setup.

The add path can fail after dev->mt76.wcid[] is published, so the error
path must clear the partial host-side WCID state to avoid leaving stale
entries behind.

No functional change intended.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7925/main.c  | 53 +++++++++++++------
 1 file changed, 38 insertions(+), 15 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index 584d989fb4e8..dbde91727cd0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -862,8 +862,10 @@ static int mt7925_mac_link_sta_add(struct mt76_dev *mdev,
 	struct ieee80211_bss_conf *link_conf;
 	struct mt792x_bss_conf *mconf;
 	u8 link_id = link_sta->link_id;
+	bool wcid_published = false;
 	struct mt792x_sta *msta;
 	struct mt76_wcid *wcid;
+	bool pm_woken = false;
 	int ret, idx;
 
 	msta = (struct mt792x_sta *)link_sta->sta->drv_priv;
@@ -888,6 +890,7 @@ static int mt7925_mac_link_sta_add(struct mt76_dev *mdev,
 	wcid = &mlink->wcid;
 	ewma_signal_init(&wcid->rssi);
 	rcu_assign_pointer(dev->mt76.wcid[wcid->idx], wcid);
+	wcid_published = true;
 	mt76_wcid_init(wcid, 0);
 	ewma_avg_signal_init(&mlink->avg_ack_signal);
 	memset(mlink->airtime_ac, 0,
@@ -895,7 +898,8 @@ static int mt7925_mac_link_sta_add(struct mt76_dev *mdev,
 
 	ret = mt76_connac_pm_wake(&dev->mphy, &dev->pm);
 	if (ret)
-		return ret;
+		goto out_wcid;
+	pm_woken = true;
 
 	mt7925_mac_wtbl_update(dev, idx,
 			       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
@@ -909,15 +913,19 @@ static int mt7925_mac_link_sta_add(struct mt76_dev *mdev,
 		mlink_bc = mt792x_sta_to_link(&mvif->sta, mconf->link_id);
 
 		if (ieee80211_vif_is_mld(vif)) {
-			mt7925_mcu_add_bss_info_sta(&dev->phy, mconf->mt76.ctx,
-						    link_conf, link_sta,
-						    mlink_bc->wcid.idx, mlink->wcid.idx,
-						    link_sta != mlink->pri_link);
+			ret = mt7925_mcu_add_bss_info_sta(&dev->phy, mconf->mt76.ctx,
+							  link_conf, link_sta,
+							  mlink_bc->wcid.idx, mlink->wcid.idx,
+							  link_sta != mlink->pri_link);
+			if (ret)
+				goto out_pm;
 		} else {
-			mt7925_mcu_add_bss_info_sta(&dev->phy, mconf->mt76.ctx,
-						    link_conf, link_sta,
-						    mlink_bc->wcid.idx, mlink->wcid.idx,
-						    false);
+			ret = mt7925_mcu_add_bss_info_sta(&dev->phy, mconf->mt76.ctx,
+							  link_conf, link_sta,
+							  mlink_bc->wcid.idx, mlink->wcid.idx,
+							  false);
+			if (ret)
+				goto out_pm;
 		}
 	}
 
@@ -927,7 +935,7 @@ static int mt7925_mac_link_sta_add(struct mt76_dev *mdev,
 					    mlink, true,
 					    MT76_STA_INFO_STATE_NONE);
 		if (ret)
-			return ret;
+			goto out_pm;
 	} else if (ieee80211_vif_is_mld(vif) &&
 		   link_sta != mlink->pri_link) {
 		struct mt792x_link_sta *pri_mlink;
@@ -940,31 +948,46 @@ static int mt7925_mac_link_sta_add(struct mt76_dev *mdev,
 			    container_of(pri_wcid, struct mt792x_link_sta, wcid) :
 			    NULL;
 
-		if (WARN_ON_ONCE(!pri_mlink))
-			return -EINVAL;
+		if (WARN_ON_ONCE(!pri_mlink)) {
+			ret = -EINVAL;
+			goto out_pm;
+		}
 
 		ret = mt7925_mcu_sta_update(dev, mlink->pri_link, vif,
 					    pri_mlink, true,
 					    MT76_STA_INFO_STATE_ASSOC);
 		if (ret)
-			return ret;
+			goto out_pm;
 
 		ret = mt7925_mcu_sta_update(dev, link_sta, vif,
 					    mlink, true,
 					    MT76_STA_INFO_STATE_ASSOC);
 		if (ret)
-			return ret;
+			goto out_pm;
 	} else {
 		ret = mt7925_mcu_sta_update(dev, link_sta, vif,
 					    mlink, true,
 					    MT76_STA_INFO_STATE_NONE);
 		if (ret)
-			return ret;
+			goto out_pm;
 	}
 
 	mt76_connac_power_save_sched(&dev->mphy, &dev->pm);
 
 	return 0;
+
+out_pm:
+	if (pm_woken)
+		mt76_connac_power_save_sched(&dev->mphy, &dev->pm);
+out_wcid:
+	if (wcid_published) {
+		u16 idx = wcid->idx;
+
+		rcu_assign_pointer(dev->mt76.wcid[idx], NULL);
+		mt76_wcid_cleanup(mdev, wcid);
+		mt76_wcid_mask_clear(mdev->wcid_mask, wcid->idx);
+	}
+	return ret;
 }
 
 static int
-- 
2.43.0


