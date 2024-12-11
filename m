Return-Path: <linux-wireless+bounces-16211-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E806B9EC167
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Dec 2024 02:19:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E249E168FE0
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Dec 2024 01:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1189F9EC;
	Wed, 11 Dec 2024 01:19:48 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54FD82451D0
	for <linux-wireless@vger.kernel.org>; Wed, 11 Dec 2024 01:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733879988; cv=none; b=Bc7A6eTRo2ziTmVuK128xS6UPbcDVzVt1tthnmtMlJZu6fjLGKC+8TTVtK50HMKUJbGpwHkrzCXDikrd0sDHI/jqakKpk0DUsSMOWiiCxl3GCRWlRb82i/WdXZrsQRN5x663i2X3x6FiJafegelRkkEb3qDQxEzyRkuKm2fbpNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733879988; c=relaxed/simple;
	bh=EahyOeYmU0V11l+tXXPofBU8uIQw4S2EASu0iAyOUxo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BVUIMwSkXm+Xc5umsBRL5z0dgMC7dP4tRj0EOjofo1Ugeq3xm8CQzh8sERAslsLawxNbvdKs/5sF3JOs1TD8bbHqrVFpOp97cYCYgAeMJ6ZEkTBQkkL74kf1n8SwZIjIloJrUbMaTAiqKrPdb6epK+tiRFesXRMIqhUhwltesEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-29737adb604so3134111fac.1
        for <linux-wireless@vger.kernel.org>; Tue, 10 Dec 2024 17:19:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733879986; x=1734484786;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hEOr7ZXlRapM92LTTZWIPUw2bm7p3TbC4/klzbIn6U4=;
        b=L3SnzRBAyZcXuKNJbpkOFIdY+v3+nVaaI8v3wenK/PyvHcX0DvRtepv9tNiHP55dM9
         iHhNHnTL/cCnGl+hypPuiKSviaDfuGaHd/Z8xHApKiZx4FUB1I7ECyPIBPybEdzEah8y
         ra2gSIzGtGaaceDFsKYsXukN+xfUxni92gfgTcwv8cq5PWJNlHPzHSR1FYLLBrZcuyiV
         rB4ETp1IXsQEykF39dkv7nsrO7FLOY8o3eCdB5PE1uHTSxrK3kyM6fepxZmbDuQ5+VTU
         JG+Ur7vaXlpS2UHPVNvrGdFrnbejl7FhjhL0dXg3UuW5CyNfcVpUdCUFimc596aMDfpf
         jpGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWIN1iANQCxWcER6xjqRbybYEoBcEA6GZe+oJW9MXvIO/KF9JQMrABkpz3V2Rp/lta6Jt0EpKp2uSjRFR5SNg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyBvGewNcHPMnVtAvTR68w2fWCiIWmq1RCkbaleJvdyiSi188X3
	rtYXukn/QaH77UDAx/eTkVTmmYbnDasyr6awulIRjTYNn30eXCMUSNeZv+2q62I=
X-Gm-Gg: ASbGncuVQiJ/fWmRJDtcnylA262X8yjqqKQRElOSk6kS7xySRvrxE0bzbXnz7dAuJkW
	PYcFHbl+ntCms3sV98nVisuopVLp4KJCHGRnVkVIdpqTuQRyFrb/Egw8Bo2cAdBtZo0vqWTOwIz
	6IeTDH68wxt/ydimM+r68A7RSLbKzZNwPEjzBNkII8ZS32akd5625eNJG5hS4hhQPz0TchJcXWP
	eyKkO5iWtx+icbI6LzGnfeonHInZdb6CMoZNqhZm3xpEpb1yAERoWSJBCi9StD79qRrjGI=
X-Google-Smtp-Source: AGHT+IHyTyMIudqQQAHm8Avp4jqbQUHuxB2LXIFJRrOoiknpoI5ToKmsSgg7GyvDzpOHcwl3dttvug==
X-Received: by 2002:a05:6870:2887:b0:29e:569a:f90d with SMTP id 586e51a60fabf-2a012f3f948mr555637fac.32.1733879986473;
        Tue, 10 Dec 2024 17:19:46 -0800 (PST)
Received: from sean-ThinkPad-T450s.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-29f93552d34sm2705701fac.24.2024.12.10.17.19.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 17:19:45 -0800 (PST)
From: sean.wang@kernel.org
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	mingyen.hsieh@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 03/17] wifi: mt76: mt7925: Fix incorrect WCID assignment for MLO
Date: Tue, 10 Dec 2024 17:19:12 -0800
Message-Id: <20241211011926.5002-3-sean.wang@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241211011926.5002-1-sean.wang@kernel.org>
References: <20241211011926.5002-1-sean.wang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>

For MLO, each link must have a corresponding WCID.

Fixes: 86c051f2c418 ("wifi: mt76: mt7925: enabling MLO when the firmware supports it")
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7925/mac.c   |  2 +-
 .../net/wireless/mediatek/mt76/mt7925/main.c  | 19 ++++++++++---------
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mac.c b/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
index ddd406969061..a095fb31e391 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
@@ -49,7 +49,7 @@ static void mt7925_mac_sta_poll(struct mt792x_dev *dev)
 			break;
 		mlink = list_first_entry(&sta_poll_list,
 					 struct mt792x_link_sta, wcid.poll_list);
-		msta = container_of(mlink, struct mt792x_sta, deflink);
+		msta = mlink->sta;
 		spin_lock_bh(&dev->mt76.sta_poll_lock);
 		list_del_init(&mlink->wcid.poll_list);
 		spin_unlock_bh(&dev->mt76.sta_poll_lock);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index 22a9437236c0..6823187f406b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -837,6 +837,7 @@ static int mt7925_mac_link_sta_add(struct mt76_dev *mdev,
 	u8 link_id = link_sta->link_id;
 	struct mt792x_link_sta *mlink;
 	struct mt792x_sta *msta;
+	struct mt76_wcid *wcid;
 	int ret, idx;
 
 	msta = (struct mt792x_sta *)link_sta->sta->drv_priv;
@@ -855,6 +856,15 @@ static int mt7925_mac_link_sta_add(struct mt76_dev *mdev,
 	mlink->last_txs = jiffies;
 	mlink->wcid.link_id = link_sta->link_id;
 	mlink->wcid.link_valid = !!link_sta->sta->valid_links;
+	mlink->sta = msta;
+
+	wcid = &mlink->wcid;
+	ewma_signal_init(&wcid->rssi);
+	rcu_assign_pointer(dev->mt76.wcid[wcid->idx], wcid);
+	mt76_wcid_init(wcid);
+	ewma_avg_signal_init(&mlink->avg_ack_signal);
+	memset(mlink->airtime_ac, 0,
+	       sizeof(msta->deflink.airtime_ac));
 
 	ret = mt76_connac_pm_wake(&dev->mphy, &dev->pm);
 	if (ret)
@@ -904,7 +914,6 @@ mt7925_mac_sta_add_links(struct mt792x_dev *dev, struct ieee80211_vif *vif,
 			 struct ieee80211_sta *sta, unsigned long new_links)
 {
 	struct mt792x_sta *msta = (struct mt792x_sta *)sta->drv_priv;
-	struct mt76_wcid *wcid;
 	unsigned int link_id;
 	int err = 0;
 
@@ -921,14 +930,6 @@ mt7925_mac_sta_add_links(struct mt792x_dev *dev, struct ieee80211_vif *vif,
 				err = -ENOMEM;
 				break;
 			}
-
-			wcid = &mlink->wcid;
-			ewma_signal_init(&wcid->rssi);
-			rcu_assign_pointer(dev->mt76.wcid[wcid->idx], wcid);
-			mt76_wcid_init(wcid);
-			ewma_avg_signal_init(&mlink->avg_ack_signal);
-			memset(mlink->airtime_ac, 0,
-			       sizeof(msta->deflink.airtime_ac));
 		}
 
 		msta->valid_links |= BIT(link_id);
-- 
2.25.1


