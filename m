Return-Path: <linux-wireless+bounces-19442-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 438C5A4518D
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Feb 2025 01:36:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 540AA1793E8
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Feb 2025 00:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6142647F4A;
	Wed, 26 Feb 2025 00:36:28 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C831B14EC73;
	Wed, 26 Feb 2025 00:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740530188; cv=none; b=ADu8CV2KfYrKFZlu29RcLceb+FZxiE4MFzFbNef4TYei8zjtIzfXf8VwTDESQaGwlC5SMLA/W/tvvBnVfiAgUfS41m2OpKrWc9RiEUOMoHL+ClgHFUegMcybhJTxaU6oj8Jr4B5gT5eyt3WWjJt6uo5MijT+/bRL2q1Q0fVLlbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740530188; c=relaxed/simple;
	bh=fpXtFABxjZap4t2HBqcwkLiPcos1gj0SbuBWXh633Tg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mxrZQSJCjkSA7RSiYGSh7ThSFHi2H3PJviLVaX8YB+FLVDR8LxUQjNu0DabSXG1jDOdDpZTeHvZUvHuhQX3txLK4xGA268Sw6kUI0c+Z0qs6fcuBmYMp7OPPHzg6XA6FH6kA4D5jnpzh/bPmrGPIfPmc1jZN5a7FHRoBDm308t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-727250dbf60so185062a34.0;
        Tue, 25 Feb 2025 16:36:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740530186; x=1741134986;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ayoJc34UIWYK6NpCJGDdzAahc3IY6eGe3fENEO1SMvY=;
        b=G/vyfW3NkHgWqMw2i68z+5Oex+fFxHLnXfHTsi2ZL44dfwBIRZwWJ9xKXOhMvdKLf/
         Znmw4PaJRyN2oox3t+WOEg2SbNEwP0UoJ21EbsbXYRcd8CNs0Zxb4PZWn50iIqFrRt1I
         9jHJf2wwU9h2iNbyaeZjekovIrx9gboTymHYb2lzmqF1yFRfAWrskL3MQTI7XWAASo5Z
         s+B0LN9MmHJoVZKHrL1nOWNVz+YX7OYE0jq6QzSimH5SRBc0i8OcTwNRazMWDXEV148Q
         9gLOdOPTz+ll+3ge5XLkUwSd1x19Hxpxuu1Qe7FLMfYiOI2PcPxcu8qMq6GRnHSs7VKP
         IlXw==
X-Forwarded-Encrypted: i=1; AJvYcCV8PrWaZACSCeiYWCnhGE4OKuVlazkwpfZ0JfZ3eoD+oMJJ3iAjWumq8OT6XicTMLI9wldY9rwf@vger.kernel.org, AJvYcCVV8dD+HvSzfEJyn9+N8Hbz2mMKIWRKe6NwUfus/bSucHBs8ImZMnUamOBflC5A1uNNWDAOVRlpvSfds7Nbzg==@vger.kernel.org
X-Gm-Message-State: AOJu0YygoJkuTaMl3vjR8EIy1eL+vctRJ8sN+lzGvu7YpCVLeV/o4vmB
	8HjkTpmvz7IXtiPQTo+5SMgqo2YhUFSyRfqLxL70aLlfmG3tKW4j
X-Gm-Gg: ASbGncs47qSFHaR+yQZNdS/sIdhbsyssqfLgH7fQPrR8Vm//WQVq3y1YnFy/x0ackIB
	/w8tyEBmuKqZFOAh2tMh5aqkITzLiUtkA5rt4kX0KObFKQUWRvYUaF68fmNhlQhHDrrYv3uEjCz
	WebZ6PuzDQHXvVhqw6t0Y+5pWx/bpFicNpOIThWZjtt6zf86IKsXYsaDWmtBfBdEmdARhjE3CtX
	5qWiWM6tj+mMqI0ZzrvTilDlIFqX/Vb3k3EAX9e+CpsfVobaJ+rQDVMu2+cQBWbgh97dsfPYlBz
	AZBZoPjsDVmtHSbZo6dCPJaGd+ApFy3F9ZdJgGvrAgU=
X-Google-Smtp-Source: AGHT+IF9Q3Wtccm0vIiquLaIV2JCZFN8QqcgomXkW2A+AmAXU11HEtu0EQ8MdBNN82ZRLpq9VKc3cg==
X-Received: by 2002:a05:6830:4858:b0:728:a42c:a503 with SMTP id 46e09a7af769-728a42ca9a5mr1149633a34.14.1740530185762;
        Tue, 25 Feb 2025 16:36:25 -0800 (PST)
Received: from sean-ThinkPad-T450s.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7289dedfcd8sm507149a34.16.2025.02.25.16.36.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 16:36:25 -0800 (PST)
From: sean.wang@kernel.org
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	mingyen.hsieh@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	stable@vger.kernel.org
Subject: [PATCH v3 4/6] wifi: mt76: mt7925: adjust rm BSS flow to prevent next connection failure
Date: Tue, 25 Feb 2025 16:35:54 -0800
Message-Id: <20250226003556.82644-4-sean.wang@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250226003556.82644-1-sean.wang@kernel.org>
References: <20250226003556.82644-1-sean.wang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>

Removing BSS without removing STAREC first will cause firmware
abnormal and next connection fail.

Fixes: f8797298565e ("wifi: mt76: mt7925: Cleanup MLO settings post-disconnection")
Cc: stable@vger.kernel.org
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
v2, v3: generate the patch based on the latest mt76 tree
---
 .../net/wireless/mediatek/mt76/mt7925/main.c  | 45 +++++++++++++++----
 1 file changed, 36 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index 604f771af68e..4a9f393b45ba 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -1155,7 +1155,12 @@ static void mt7925_mac_link_sta_remove(struct mt76_dev *mdev,
 		struct mt792x_bss_conf *mconf;
 
 		mconf = mt792x_link_conf_to_mconf(link_conf);
-		mt792x_mac_link_bss_remove(dev, mconf, mlink);
+
+		if (ieee80211_vif_is_mld(vif))
+			mt792x_mac_link_bss_remove(dev, mconf, mlink);
+		else
+			mt7925_mcu_add_bss_info(&dev->phy, mconf->mt76.ctx, link_conf,
+						link_sta, false);
 	}
 
 	spin_lock_bh(&mdev->sta_poll_lock);
@@ -1175,6 +1180,31 @@ mt7925_mac_sta_remove_links(struct mt792x_dev *dev, struct ieee80211_vif *vif,
 	struct mt76_wcid *wcid;
 	unsigned int link_id;
 
+	/* clean up bss before starec */
+	for_each_set_bit(link_id, &old_links, IEEE80211_MLD_MAX_NUM_LINKS) {
+		struct ieee80211_link_sta *link_sta;
+		struct ieee80211_bss_conf *link_conf;
+		struct mt792x_bss_conf *mconf;
+		struct mt792x_link_sta *mlink;
+
+		link_sta = mt792x_sta_to_link_sta(vif, sta, link_id);
+		if (!link_sta)
+			continue;
+
+		mlink = mt792x_sta_to_link(msta, link_id);
+		if (!mlink)
+			continue;
+
+		link_conf = mt792x_vif_to_bss_conf(vif, link_id);
+		if (!link_conf)
+			continue;
+
+		mconf = mt792x_link_conf_to_mconf(link_conf);
+
+		mt7925_mcu_add_bss_info(&dev->phy, mconf->mt76.ctx, link_conf,
+					link_sta, false);
+	}
+
 	for_each_set_bit(link_id, &old_links, IEEE80211_MLD_MAX_NUM_LINKS) {
 		struct ieee80211_link_sta *link_sta;
 		struct mt792x_link_sta *mlink;
@@ -1212,6 +1242,7 @@ void mt7925_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 {
 	struct mt792x_dev *dev = container_of(mdev, struct mt792x_dev, mt76);
 	struct mt792x_sta *msta = (struct mt792x_sta *)sta->drv_priv;
+	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
 	struct {
 		struct {
 			u8 omac_idx;
@@ -1242,14 +1273,10 @@ void mt7925_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 
 	mt7925_mac_sta_remove_links(dev, vif, sta, rem);
 
-	if (ieee80211_vif_is_mld(vif)) {
-		mt7925_mcu_set_dbdc(&dev->mphy, false);
-
-		/* recovery omac address for the legacy interface */
-		memcpy(dev_req.tlv.omac_addr, vif->addr, ETH_ALEN);
-		mt76_mcu_send_msg(mdev, MCU_UNI_CMD(DEV_INFO_UPDATE),
-				  &dev_req, sizeof(dev_req), true);
-	}
+	/* recovery omac address for the legacy interface */
+	memcpy(dev_req.tlv.omac_addr, vif->addr, ETH_ALEN);
+	mt76_mcu_send_msg(mdev, MCU_UNI_CMD(DEV_INFO_UPDATE),
+			  &dev_req, sizeof(dev_req), true);
 
 	if (vif->type == NL80211_IFTYPE_STATION) {
 		struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
-- 
2.25.1


