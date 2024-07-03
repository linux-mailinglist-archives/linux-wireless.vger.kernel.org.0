Return-Path: <linux-wireless+bounces-9961-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E2DD0926AA2
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2024 23:44:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82B9BB262B7
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2024 21:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D87B19413B;
	Wed,  3 Jul 2024 21:43:34 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05762194C94
	for <linux-wireless@vger.kernel.org>; Wed,  3 Jul 2024 21:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720043014; cv=none; b=Vsui/wB7tL0RhO0bva39X6yDoo94hEceb4Ggcc4agGYGzGsqLlRo1dTA5ksk0NyVKobn90F+lC0juWq0rRcVZWsqSKMTs78+LgFdCTu6AV3SBrrbCiehis62oKBFIHTd+e+W+x2/94sIPqZvI3Ai7axRPYyjy5RUqQfe/m9c3i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720043014; c=relaxed/simple;
	bh=f6Pfr5Vq6FUAVKa61YJT/hYqrClzFJDo1bmm3YyysQ8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CbEOyZOMlV7WPdoRpcdrrkpXwKwrSGH8AT4coCG4boiPzelxyBPUNUlYjj9nwnBOPZkmvTN747iZrsgCEzuQSqPCXG2OrzHS8C/OhO5InVsu7qZCC22VKAWFh09pvGJlWWjRwwjhUzzDVgVPJRQf4PuIbM/7ov6Mcu6QgqM09DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-70204bcd5eeso80654a34.2
        for <linux-wireless@vger.kernel.org>; Wed, 03 Jul 2024 14:43:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720043012; x=1720647812;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RxSmN3RyGqtOMcnaemjIRPhc3UORadWI0djDIJjxFRQ=;
        b=HlgL5PR5N9tc/piQySqYh95swPu0OV6cBZDIUm3M4VYCO38DFkVtnMWLFcaQTN6fWp
         1pAfoVtLv/YPFjZ0cLw1+PxrtMmOQ8QpYhoa8e4EYagHkxFSwqo4zc8BSNIRGMEBNe0q
         XtTrdn3pWHrxbgMqxR84F4d/89WXh9YouUMRYQGNteRcytF/E2BXbSGmggfNH66TydRT
         JgI9a7jO7NBwHOyAqZY7xFpgQmUnjOT+t5I8lKohVKLPeOBFDhbu11FJRaPG1/CVOt9A
         5J5vWhlpfkqc1kKXyqvkeqYWBGsdGxtDtEAe1qnp0/YcvlMxl8J8b7lUAksg0nuBBQIX
         eqIg==
X-Forwarded-Encrypted: i=1; AJvYcCXqQT7momwHUALetBmf3C30HNCBIjPCIzHKb7biR6Dj6f1dGwjRSYv1du+C7eEqHInEXfjhqoFUnXRg223w6WoQA9MvqRxV9BW/7Q4CjDE=
X-Gm-Message-State: AOJu0YygmhBm+2X4d0LWHWq8hOTmkqvrvUZF7t/4B60sFeDsysbXKLE8
	1gSAHzn9tzgy5xkzef+xg8XmQKt5K92phOsHf2Bx2cqSQT5w8fcO4vdB5Dyv
X-Google-Smtp-Source: AGHT+IF/LGon8YWCTWFG30B8KA0KF181GSiy3MGe5Zpy91+M/CxwYtnXKl8o1WBcM0358pYIOT8lnw==
X-Received: by 2002:a9d:7e8a:0:b0:700:e0e8:5e2 with SMTP id 46e09a7af769-70207560e89mr12825062a34.0.1720043012083;
        Wed, 03 Jul 2024 14:43:32 -0700 (PDT)
Received: from sean-ThinkPad-T450s.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-701f7b20953sm2111417a34.54.2024.07.03.14.43.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 14:43:31 -0700 (PDT)
From: sean.wang@kernel.org
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	mingyen.hsieh@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 21/29] wifi: mt76: add def_wcid to struct mt76_wcid
Date: Wed,  3 Jul 2024 14:42:26 -0700
Message-Id: <c453d6b0045ce09fded4e255dc4673defa0dc2ec.1720042294.git.sean.wang@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1720042294.git.sean.wang@kernel.org>
References: <cover.1720042294.git.sean.wang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Wang <sean.wang@mediatek.com>

add def_wcid to struct mt76_wcid to allow per-link wcid to retrieve the
struct ieee80211_sta structure.

Co-developed-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Co-developed-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt76.h        | 5 +++++
 drivers/net/wireless/mediatek/mt76/mt7925/main.c | 2 ++
 2 files changed, 7 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index c0e529d0b3ef..f8431b889c78 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -368,6 +368,8 @@ struct mt76_wcid {
 	struct mt76_sta_stats stats;
 
 	struct list_head poll_list;
+
+	struct mt76_wcid *def_wcid;
 };
 
 struct mt76_txq {
@@ -1258,6 +1260,9 @@ wcid_to_sta(struct mt76_wcid *wcid)
 	if (!wcid || !wcid->sta)
 		return NULL;
 
+	if (wcid->def_wcid)
+		ptr = wcid->def_wcid;
+
 	return container_of(ptr, struct ieee80211_sta, drv_priv);
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index c3ce57d36168..339888086076 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -894,6 +894,7 @@ mt7925_mac_sta_add_links(struct mt792x_dev *dev, struct ieee80211_vif *vif,
 		rcu_assign_pointer(msta->link[link_id], mlink);
 		mlink->sta = msta;
 		mlink->pri_link = &sta->deflink;
+		mlink->wcid.def_wcid = &msta->deflink.wcid;
 
 		link_sta = mt792x_sta_to_link_sta(vif, sta, link_id);
 		mt7925_mac_link_sta_add(&dev->mt76, vif, link_sta);
@@ -1867,6 +1868,7 @@ mt7925_change_vif_links(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		mconf->vif = mvif;
 		mlink->wcid.link_id = link_id;
 		mlink->wcid.link_valid = !!vif->valid_links;
+		mlink->wcid.def_wcid = &mvif->sta.deflink.wcid;
 	}
 
 	if (hweight16(mvif->valid_links) == 0)
-- 
2.25.1


