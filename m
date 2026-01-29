Return-Path: <linux-wireless+bounces-31310-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +G/kIV0ee2msBQIAu9opvQ
	(envelope-from <linux-wireless+bounces-31310-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jan 2026 09:46:21 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DE85ADAE3
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jan 2026 09:46:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 90DEF30058F9
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jan 2026 08:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 668C937C0F1;
	Thu, 29 Jan 2026 08:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="in+aMamY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346F537C11E
	for <linux-wireless@vger.kernel.org>; Thu, 29 Jan 2026 08:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769676379; cv=none; b=n4QGmTTvONKgIZdhlDTB8j6qmzHbPZKxmThe7MJcU8On+voDeOEAcrTxTc8eXY0r176EB+qUejGMFdSMTduVK/nZ7INTqe5WwDJYg69w7GMT0oaDB+b3bNZgZHShSY7+N5NPPgiQSCqCkqzr+KsUERlZI/CLtewI18MuQ+Tj8nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769676379; c=relaxed/simple;
	bh=vMdGwC/qf+2O0zngrxjCurOPxiTpRuxWh6CV3arQQd8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V06StF4jJYIV+RSEASTUQ1KcpHvDlhdLvRwWHKEFg7kw5yqKt133C9MGqMxoBa2T+hpFoFVR1qJYdTx4yryn0d+l3l4Zi/SRVggiMtJzE5yMbws0850taL4du5s64U1eyJFf0NkFTg0AlUNh17GhcaHsofifWSqnqfC3tHHjPuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zacbowling.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=in+aMamY; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zacbowling.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2b4520f6b32so1448949eec.0
        for <linux-wireless@vger.kernel.org>; Thu, 29 Jan 2026 00:46:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769676374; x=1770281174; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tng3+pOB53pLZW+pGJL9iXigR2ZikgpGjqvJUqlRZU4=;
        b=in+aMamYOb8ZZb9QCzCcopK5GsZBmq6GFBPLlte5YQ31EvLkv8eiQq9c6PUz7d5SIo
         8pjv3KQC15f1t7hddjF+1H8fxvgjNKf5ygL3fOrhMYv55/HjYDlubuq/7cnRJD8/mEr+
         dxGtJWYzFbkaPfXp3COZ/8ROa2o28UdS09PaNwaLlZdBhb4PZ6tiBwv5mIeOGzWpi/Gg
         3HmdMx8au24LamLsbUBxAw6t9wVqlGl5KzSayqRUaXR+a5vfA4XHSHsnfQ06/1dgzSC0
         bZmDh6xR09wSMYyDMHamkARuJiHAjuM616QXwaKUaBpFPCMDaHz5cL2otMId5eVCvTN0
         ILIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769676374; x=1770281174;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tng3+pOB53pLZW+pGJL9iXigR2ZikgpGjqvJUqlRZU4=;
        b=L+XbaWDXiLhj4+HW2cQI3bUwVn/I2gIiLlhCD9YOLa6RPMlhQKnvtmZFPjQ99D6o4R
         +wCdXi8CgcvN+h5xb0gETjufkHsgg8aZLudYx9/Y0aXJLieBugTkAdK2LX3wGnwxd7SN
         JhGQ1ikSG9iv+CHpMOlh03SYLTu74p2TVwzDcMsx4Jz/P33qXW+ouSXhjoywc9K0NyOP
         UR8x7tekeJ6HDmUi7nHWTqeWSvCHgTaC8t4Fi20yt+Tf3dyTJLi2UwnxuNkdqq2HbE69
         NYW0lPW7Es9FXyRivOhMomHCvRJ/jDi52vnUpIoQ8bkrPaRC1F83O7zrCCufM3Eqa/JC
         c4UQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6gPuU0jiVRKSBpWdlBthRWFJ+T+uC8ZeAk5JIiAr0O4caXr7Y1vpXBc41Fyh3vABmRtZB/0nBshtWumJ4vQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe1Mqun9IQeZyS/464oVDPNtUa3OLoAcJfm9l+B+rlkavvV0ot
	bDqDKeNiO5dLAbnwmWVFs73WhltAIZyf2IDY+4Nn4BMj6FgfVIHEZYwV
X-Gm-Gg: AZuq6aLfet8EDfNXLv65BRyTO0lR+YWCg6UbPdC5CiV8ovO4LtPlvhI1yEMNqPa2b77
	3PkXRoX25+yvZT4lT/7dip43YuziNnpRXbemRdZuoybtC/bAxwWOb5w+nNOJEK55oh0N5YplLgE
	SbtH+f5E/ckNlLkjEzocyOkls+GKwARnicP9iNdR4DY1Oekvq2UDaduj/2Q6yqLnS3nNPEfdr/X
	jyASXdEy1xbwBrtt6PJu6Gh7AXMFKKGKgPvgWijJnhaUhX4tf39Q/yz5/W59Ecqb7oFkTmtvaL0
	MF89LGSyqwezvVvTPFmX4MNAMVPzfhsKVvI4Lm9ARjaGp/3jGHzrBaFrgpbEfILEz2DkGV3D7F2
	f2jzJxZ8/cZZn6M26LKSTazWpM2VzXesSN+nSfj/JYKIpXO2PCNPQ+3xOVtqVb3mEjcLK4jgLYI
	PdTa9GOtWYZ4O+qiOJ5b9U4Ff8ue8lUBbZ7jDKq1SObgT6JSY7TcFxZaIl5P2iA+DEKWgAwNla
X-Received: by 2002:a05:693c:3017:b0:2b0:52cc:fe69 with SMTP id 5a478bee46e88-2b78d86845dmr4198171eec.5.1769676374355;
        Thu, 29 Jan 2026 00:46:14 -0800 (PST)
Received: from zcache.home.zacbowling.com ([2001:5a8:60d:bc9:4a3c:9f7c:8037:90c1])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b7a1abe92dsm5947583eec.17.2026.01.29.00.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 00:46:13 -0800 (PST)
Sender: Zac Bowling <zbowling@gmail.com>
From: Zac <zac@zacbowling.com>
To: nbd@nbd.name
Cc: deren.wu@mediatek.com,
	kvalo@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	linux@frame.work,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com,
	sean.wang@kernel.org,
	sean.wang@mediatek.com,
	zac@zacbowling.com,
	zbowling@gmail.com
Subject: [PATCH 2/6] wifi: mt76: mt7925: add NULL pointer protection for MLO state transitions
Date: Thu, 29 Jan 2026 00:46:11 -0800
Message-ID: <20260129084611.187744-1-zac@zacbowling.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260129081839.179709-1-zac@zacbowling.com>
References: <20260129081839.179709-1-zac@zacbowling.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31310-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[mediatek.com,kernel.org,vger.kernel.org,lists.infradead.org,frame.work,zacbowling.com,gmail.com];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[zacbowling.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[zac@zacbowling.com,linux-wireless@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.987];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_TWELVE(0.00)[13];
	DBL_BLOCKED_OPENRESOLVER(0.00)[zacbowling.com:mid,zacbowling.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2DE85ADAE3
X-Rspamd-Action: no action

Add NULL pointer checks for functions that return pointers to link-related
structures throughout the mt7925 driver. During MLO state transitions,
these functions can return NULL when link configuration is not synchronized.

Functions protected:
- mt792x_vif_to_bss_conf(): Returns link BSS configuration
- mt792x_vif_to_link(): Returns driver link state
- mt792x_sta_to_link(): Returns station link state

Key changes:

1. mt7925_set_link_key():
   - Check link_conf, mconf, mlink before use
   - During MLO roaming, allow key removal to succeed if link is already gone

2. mt7925_mac_link_sta_add():
   - Check mlink and mconf before WCID allocation
   - Check link_conf before BSS info update
   - Add proper WCID cleanup on error paths (err_wcid label)
   - Check MCU return values and propagate errors

3. mt7925_mac_link_sta_assoc():
   - Check mlink before use
   - Check link_conf and mconf before BSS info update

4. mt7925_mac_link_sta_remove():
   - Check mlink before use
   - Check link_conf and mconf before cleanup operations

Prevents crashes during:
- BSSID roaming transitions
- MLO setup and teardown
- Hardware reset operations

Fixes: c948b5da6bbe ("wifi: mt76: mt7925: add Mediatek Wi-Fi7 driver for mt7925 device")
Signed-off-by: Zac Bowling <zac@zacbowling.com>
---
 .../net/wireless/mediatek/mt76/mt7925/main.c  | 67 ++++++++++++++-----
 1 file changed, 52 insertions(+), 15 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index fad3b1505f67..1400633712b7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -612,6 +612,17 @@ static int mt7925_set_link_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 	link_sta = sta ? mt792x_sta_to_link_sta(vif, sta, link_id) : NULL;
 	mconf = mt792x_vif_to_link(mvif, link_id);
 	mlink = mt792x_sta_to_link(msta, link_id);
+
+	if (!link_conf || !mconf || !mlink) {
+		/* During MLO roaming, link state may be torn down before
+		 * mac80211 requests key removal. If removing a key and
+		 * the link is already gone, consider it successfully removed.
+		 */
+		if (cmd != SET_KEY)
+			return 0;
+		return -EINVAL;
+	}
+
 	wcid = &mlink->wcid;
 	wcid_keyidx = &wcid->hw_key_idx;
 
@@ -864,12 +875,17 @@ static int mt7925_mac_link_sta_add(struct mt76_dev *mdev,
 
 	msta = (struct mt792x_sta *)link_sta->sta->drv_priv;
 	mlink = mt792x_sta_to_link(msta, link_id);
+	if (!mlink)
+		return -EINVAL;
+
+	mconf = mt792x_vif_to_link(mvif, link_id);
+	if (!mconf)
+		return -EINVAL;
 
 	idx = mt76_wcid_alloc(dev->mt76.wcid_mask, MT792x_WTBL_STA - 1);
 	if (idx < 0)
 		return -ENOSPC;
 
-	mconf = mt792x_vif_to_link(mvif, link_id);
 	mt76_wcid_init(&mlink->wcid, 0);
 	mlink->wcid.sta = 1;
 	mlink->wcid.idx = idx;
@@ -888,21 +904,28 @@ static int mt7925_mac_link_sta_add(struct mt76_dev *mdev,
 
 	ret = mt76_connac_pm_wake(&dev->mphy, &dev->pm);
 	if (ret)
-		return ret;
+		goto err_wcid;
 
 	mt7925_mac_wtbl_update(dev, idx,
 			       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
 
 	link_conf = mt792x_vif_to_bss_conf(vif, link_id);
+	if (!link_conf) {
+		ret = -EINVAL;
+		goto err_wcid;
+	}
 
 	/* should update bss info before STA add */
 	if (vif->type == NL80211_IFTYPE_STATION && !link_sta->sta->tdls) {
 		if (ieee80211_vif_is_mld(vif))
-			mt7925_mcu_add_bss_info(&dev->phy, mconf->mt76.ctx,
-						link_conf, link_sta, link_sta != mlink->pri_link);
+			ret = mt7925_mcu_add_bss_info(&dev->phy, mconf->mt76.ctx,
+						      link_conf, link_sta,
+						      link_sta != mlink->pri_link);
 		else
-			mt7925_mcu_add_bss_info(&dev->phy, mconf->mt76.ctx,
-						link_conf, link_sta, false);
+			ret = mt7925_mcu_add_bss_info(&dev->phy, mconf->mt76.ctx,
+						      link_conf, link_sta, false);
+		if (ret)
+			goto err_wcid;
 	}
 
 	if (ieee80211_vif_is_mld(vif) &&
@@ -910,28 +933,35 @@ static int mt7925_mac_link_sta_add(struct mt76_dev *mdev,
 		ret = mt7925_mcu_sta_update(dev, link_sta, vif, true,
 					    MT76_STA_INFO_STATE_NONE);
 		if (ret)
-			return ret;
+			goto err_wcid;
 	} else if (ieee80211_vif_is_mld(vif) &&
 		   link_sta != mlink->pri_link) {
 		ret = mt7925_mcu_sta_update(dev, mlink->pri_link, vif,
 					    true, MT76_STA_INFO_STATE_ASSOC);
 		if (ret)
-			return ret;
+			goto err_wcid;
 
 		ret = mt7925_mcu_sta_update(dev, link_sta, vif, true,
 					    MT76_STA_INFO_STATE_ASSOC);
 		if (ret)
-			return ret;
+			goto err_wcid;
 	} else {
 		ret = mt7925_mcu_sta_update(dev, link_sta, vif, true,
 					    MT76_STA_INFO_STATE_NONE);
 		if (ret)
-			return ret;
+			goto err_wcid;
 	}
 
 	mt76_connac_power_save_sched(&dev->mphy, &dev->pm);
 
 	return 0;
+
+err_wcid:
+	rcu_assign_pointer(dev->mt76.wcid[idx], NULL);
+	mt76_wcid_cleanup(&dev->mt76, wcid);
+	mt76_wcid_mask_clear(dev->mt76.wcid_mask, idx);
+	mt76_connac_power_save_sched(&dev->mphy, &dev->pm);
+	return ret;
 }
 
 static int
@@ -1039,6 +1069,8 @@ static void mt7925_mac_link_sta_assoc(struct mt76_dev *mdev,
 
 	msta = (struct mt792x_sta *)link_sta->sta->drv_priv;
 	mlink = mt792x_sta_to_link(msta, link_sta->link_id);
+	if (!mlink)
+		return;
 
 	mt792x_mutex_acquire(dev);
 
@@ -1048,12 +1080,13 @@ static void mt7925_mac_link_sta_assoc(struct mt76_dev *mdev,
 		link_conf = mt792x_vif_to_bss_conf(vif, vif->bss_conf.link_id);
 	}
 
-	if (vif->type == NL80211_IFTYPE_STATION && !link_sta->sta->tdls) {
+	if (link_conf && vif->type == NL80211_IFTYPE_STATION && !link_sta->sta->tdls) {
 		struct mt792x_bss_conf *mconf;
 
 		mconf = mt792x_link_conf_to_mconf(link_conf);
-		mt7925_mcu_add_bss_info(&dev->phy, mconf->mt76.ctx,
-					link_conf, link_sta, true);
+		if (mconf)
+			mt7925_mcu_add_bss_info(&dev->phy, mconf->mt76.ctx,
+						link_conf, link_sta, true);
 	}
 
 	ewma_avg_signal_init(&mlink->avg_ack_signal);
@@ -1100,6 +1133,8 @@ static void mt7925_mac_link_sta_remove(struct mt76_dev *mdev,
 
 	msta = (struct mt792x_sta *)link_sta->sta->drv_priv;
 	mlink = mt792x_sta_to_link(msta, link_id);
+	if (!mlink)
+		return;
 
 	mt7925_roc_abort_sync(dev);
 
@@ -1113,10 +1148,12 @@ static void mt7925_mac_link_sta_remove(struct mt76_dev *mdev,
 
 	link_conf = mt792x_vif_to_bss_conf(vif, link_id);
 
-	if (vif->type == NL80211_IFTYPE_STATION && !link_sta->sta->tdls) {
+	if (link_conf && vif->type == NL80211_IFTYPE_STATION && !link_sta->sta->tdls) {
 		struct mt792x_bss_conf *mconf;
 
 		mconf = mt792x_link_conf_to_mconf(link_conf);
+		if (!mconf)
+			goto out;
 
 		if (ieee80211_vif_is_mld(vif))
 			mt792x_mac_link_bss_remove(dev, mconf, mlink);
@@ -1124,7 +1161,7 @@ static void mt7925_mac_link_sta_remove(struct mt76_dev *mdev,
 			mt7925_mcu_add_bss_info(&dev->phy, mconf->mt76.ctx, link_conf,
 						link_sta, false);
 	}
-
+out:
 	spin_lock_bh(&mdev->sta_poll_lock);
 	if (!list_empty(&mlink->wcid.poll_list))
 		list_del_init(&mlink->wcid.poll_list);
-- 
2.52.0


