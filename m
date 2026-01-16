Return-Path: <linux-wireless+bounces-30862-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 453ADD2981F
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jan 2026 02:08:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6E26530CB20D
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jan 2026 01:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCCC83148DD;
	Fri, 16 Jan 2026 01:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hGX/3jcZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB718314A6F
	for <linux-wireless@vger.kernel.org>; Fri, 16 Jan 2026 01:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768525536; cv=none; b=OlvVrvv+9VJFubCo9iq65O0RUCWYrNNXvTFj/yfs8dJula88gi1HGsLtBDuTw0PiLVDosTjqHADdvPRaQljQyqt2LLx8N6o7kBLISzkSpV0Td8PxjUG0wSyaD0gNLz8+IlDnnBB//ozqil9sgRhnu1aF6nlF1tzRCidP25G0dww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768525536; c=relaxed/simple;
	bh=V1e/me2QjmgrVoKQRsR3lYUkkFbtVoc5MRb6S8g/ccs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u0J+riIuM6pqAw5ggxdvBE0cBvd6AtB7W5i4mDVvm2VG9BnkHo42drISFqiqgzZYCTLPlWPB2Thbb5I/kd7mSRfVMBm6m8mB0u0TD8s0z3dHwlJqg4XwxYaQZ+mJairkkGBGLMmwztKbISmhS8yiqJyKK37xlbbdUOa2Gw7HhtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zacbowling.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hGX/3jcZ; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zacbowling.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2b4520f6b32so2126386eec.0
        for <linux-wireless@vger.kernel.org>; Thu, 15 Jan 2026 17:05:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768525531; x=1769130331; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mSp+N+GShRL+uxhqPaPfFr1j/zGqGJL8NPvnP5M25W4=;
        b=hGX/3jcZ98VeZo2TDvzi7Jh28Cn9H0222SeYf8J8UdDr8p3x31ldsAMEVwRh0ohiBf
         iWhWp33wV8zRPW/RWDAqUf1ZITPhcssPsKGxKyC7yy2Q5K2snycnWF2fauoxwRdCBCIN
         pIh8Zr5oolaQhXqCNoedQs4jxWDfTqwsfWkpUI1IqeCNQKpXTqmZLPMg+cjXr4HuDaEA
         6X+iBdEChWyAAEh2TxWV8KbWyYPoRqabXCTclOtAjtkpKttyuQ8nypJ+S9gT8QGimUWr
         BP2PvhtTWVpD0Jeh6Qthw4lEbPjq/vYxgcn/UUbFJoXvHyA5pisGcqUsKVbD3U5dCvtL
         9Acg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768525531; x=1769130331;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mSp+N+GShRL+uxhqPaPfFr1j/zGqGJL8NPvnP5M25W4=;
        b=r4UwyXrFgZ31JPqMaV575n5j0xBKpq0hQm0FBVmKJJvsOMxbnDt14xfdZryJiWD2Pf
         ASwAIr6du5ywsxIszV2ogKS5zRXbg0p1nZ0qGOBAEvY+CAYxyDZGW4hQ1HmIi8JFqY2H
         WB29c79s667FEdSOumvNsxlr0jTcGsLilCCJN/4ycqvr6OIeWPqkNV0sh3jzYJuu5ER/
         zBrbRrMZWETprijtOvErEWjKyJEbZtZIJYy2zk9eUY4RTazVUhIhiYfeSrs8IaQM4+ZU
         Me9SqWrzl9bimLL450PZ6O1c3YOXVob4PF0ryq3yLkjsIjUJotEAjOArv2G282CNyXUy
         2cxw==
X-Forwarded-Encrypted: i=1; AJvYcCWA6rRwC9lAoYXdy7QQtoqnzGkk2kHq48ceXG0j7WKhQp1htXGV9+GI5u82BFXIDlFCd2p8YPcYnMHe6x7ATw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzMybhGTfqiGHjDXZhL/otMTukRej+Qp4OnWdMEvwCkUOE0e6kt
	pu6mAL5bhOUb/jW8B68qTsPJAE/ZXqEAPRmBCWI7uaMdS8lMi5jeLKHu
X-Gm-Gg: AY/fxX5tSKrPGQTL2gmjmTni1Oy6IlFoiQ5UKlITB6m5OuOAY9X4XVLTpiaNRChZH9R
	2i23Zk1g9KKr19Tpbe68WGcPIB/3n90N5u3El0YirXfdwLHS0Cxmy/057L1FygME2DDc9gPfgG1
	4ui79A1TOdOdnOJauauw4efPIe2mDvovKaIYedvoPo+nkO04vQAMRvslu0koTp56IbFdJBRHAkw
	+j/ZvExYEI1qks1oMPaIbg5z45nIWJkqyByJjSemeEZc4G1YOOjjR+PWQM6tKCeOg4CEgqIREum
	kfkCR6wMzeU1YdcKANuk1M9ehuNfo+qJ/Ye0dqwaFcgcCAiRfr+CvIrbO2Z46CKJYytiwSuNc24
	EaJvjIunvabzOjJDbkPqKhpwcR1f0Chs+lp1KuLcKIlp2GS9LNyfIxAe0QCX3FQnCvr+KY7G10A
	sO2gO3OcqImq4R5u9VftZ9VlGP0SByEf4redgzA3xm3rSuU6NSma8tRlj1qmR72A==
X-Received: by 2002:a05:7300:549:b0:2b0:5306:1773 with SMTP id 5a478bee46e88-2b6b3ecb06dmr1089037eec.1.1768525530659;
        Thu, 15 Jan 2026 17:05:30 -0800 (PST)
Received: from zcache.home.zacbowling.com ([2001:5a8:60d:bc9:f1d2:502c:a6ff:5556])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b367cbc9sm1019884eec.32.2026.01.15.17.05.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 17:05:30 -0800 (PST)
Sender: Zac Bowling <zbowling@gmail.com>
From: Zac <zac@zacbowling.com>
To: sean.wang@kernel.org
Cc: deren.wu@mediatek.com,
	kvalo@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	lorenzo@kernel.org,
	nbd@nbd.name,
	linux@frame.work,
	ryder.lee@mediatek.com,
	sean.wang@mediatek.com,
	Zac Bowling <zbowling@gmail.com>,
	Zac Bowling <zac@zacbowling.com>
Subject: [PATCH v4 05/21] wifi: mt76: mt7925: add NULL checks for link_conf and mlink in main.c
Date: Thu, 15 Jan 2026 17:05:03 -0800
Message-ID: <20260116010519.37001-6-zac@zacbowling.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260116010519.37001-1-zac@zacbowling.com>
References: <CAGp9LzpuyXRDa=TxqY+Xd5ZhDVvNayWbpMGDD1T0g7apkn7P0A@mail.gmail.com>
 <20260116010519.37001-1-zac@zacbowling.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zac Bowling <zbowling@gmail.com>

Add NULL pointer checks throughout main.c for functions that call
mt792x_vif_to_bss_conf(), mt792x_vif_to_link(), and mt792x_sta_to_link()
without verifying the return value before dereferencing.

Functions fixed:
- mt7925_set_key(): Check link_conf, mconf, and mlink before use
- mt7925_mac_link_sta_add(): Check link_conf before BSS info update
- mt7925_mac_link_sta_assoc(): Check mlink and link_conf before use
- mt7925_mac_link_sta_remove(): Check mlink and link_conf, add goto
  label for proper cleanup path
- mt7925_change_vif_links(): Check link_conf before adding BSS

These functions can receive NULL when the link configuration in mac80211
is not yet synchronized with the driver's link tracking during MLO
operations or state transitions.

Without these checks, the driver crashes during station add/remove/
association operations with NULL pointer dereference:

  BUG: kernel NULL pointer dereference, address: 0000000000000010
  Call Trace:
   mt7925_mac_link_sta_add+0x...
   ...

Found through static analysis and triggered during BSSID roaming on
systems with multiple access points.

Reported-by: Zac Bowling <zac@zacbowling.com>
Fixes: c948b5da6bbe ("wifi: mt76: mt7925: add Mediatek Wi-Fi7 driver for mt7925 chips")
Signed-off-by: Zac Bowling <zac@zacbowling.com>
---
 .../net/wireless/mediatek/mt76/mt7925/main.c  | 27 ++++++++++++++++---
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index 9f17b21aef..7d3322461b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -604,6 +604,10 @@ static int mt7925_set_link_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 	link_sta = sta ? mt792x_sta_to_link_sta(vif, sta, link_id) : NULL;
 	mconf = mt792x_vif_to_link(mvif, link_id);
 	mlink = mt792x_sta_to_link(msta, link_id);
+
+	if (!link_conf || !mconf || !mlink)
+		return -EINVAL;
+
 	wcid = &mlink->wcid;
 	wcid_keyidx = &wcid->hw_key_idx;
 
@@ -889,6 +893,8 @@ static int mt7925_mac_link_sta_add(struct mt76_dev *mdev,
 			       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
 
 	link_conf = mt792x_vif_to_bss_conf(vif, link_id);
+	if (!link_conf)
+		return -EINVAL;
 
 	/* should update bss info before STA add */
 	if (vif->type == NL80211_IFTYPE_STATION && !link_sta->sta->tdls) {
@@ -1034,6 +1040,8 @@ static void mt7925_mac_link_sta_assoc(struct mt76_dev *mdev,
 
 	msta = (struct mt792x_sta *)link_sta->sta->drv_priv;
 	mlink = mt792x_sta_to_link(msta, link_sta->link_id);
+	if (!mlink)
+		return;
 
 	mt792x_mutex_acquire(dev);
 
@@ -1043,12 +1051,13 @@ static void mt7925_mac_link_sta_assoc(struct mt76_dev *mdev,
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
@@ -1095,6 +1104,8 @@ static void mt7925_mac_link_sta_remove(struct mt76_dev *mdev,
 
 	msta = (struct mt792x_sta *)link_sta->sta->drv_priv;
 	mlink = mt792x_sta_to_link(msta, link_id);
+	if (!mlink)
+		return;
 
 	mt7925_roc_abort_sync(dev);
 
@@ -1108,10 +1119,12 @@ static void mt7925_mac_link_sta_remove(struct mt76_dev *mdev,
 
 	link_conf = mt792x_vif_to_bss_conf(vif, link_id);
 
-	if (vif->type == NL80211_IFTYPE_STATION && !link_sta->sta->tdls) {
+	if (link_conf && vif->type == NL80211_IFTYPE_STATION && !link_sta->sta->tdls) {
 		struct mt792x_bss_conf *mconf;
 
 		mconf = mt792x_link_conf_to_mconf(link_conf);
+		if (!mconf)
+			goto out;
 
 		if (ieee80211_vif_is_mld(vif))
 			mt792x_mac_link_bss_remove(dev, mconf, mlink);
@@ -1119,6 +1132,7 @@ static void mt7925_mac_link_sta_remove(struct mt76_dev *mdev,
 			mt7925_mcu_add_bss_info(&dev->phy, mconf->mt76.ctx, link_conf,
 						link_sta, false);
 	}
+out:
 
 	spin_lock_bh(&mdev->sta_poll_lock);
 	if (!list_empty(&mlink->wcid.poll_list))
@@ -2031,6 +2045,11 @@ mt7925_change_vif_links(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		mlink = mlinks[link_id];
 		link_conf = mt792x_vif_to_bss_conf(vif, link_id);
 
+		if (!link_conf) {
+			err = -EINVAL;
+			goto free;
+		}
+
 		rcu_assign_pointer(mvif->link_conf[link_id], mconf);
 		rcu_assign_pointer(mvif->sta.link[link_id], mlink);
 
-- 
2.52.0


