Return-Path: <linux-wireless+bounces-19785-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E45A8A4F226
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Mar 2025 01:09:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9799A3A8B8D
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Mar 2025 00:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0D1D647;
	Wed,  5 Mar 2025 00:09:12 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A0917579;
	Wed,  5 Mar 2025 00:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741133352; cv=none; b=UDuTPPZBY8TzZMgOtnKkC9PhkucyhLnl7TJgvHxTFRWTEjzGeeZ1sNn6bi1gdgsrjF2qB6Z8ZUfk344K2qZw/QdtZwyfdyM603zt5FPPA4qxaxBiGYHRjYWghhyXECpz/VzuELhq1crbbMna0E/pjiaTsky/b6v8JSu3eOpfHdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741133352; c=relaxed/simple;
	bh=aCAvlnEbLYWd4QFgD/f4U/CRsrS+c13uacOWLmt1zkE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QV/fHSdDUa57WaaqufpZzMad2+4kqtV4pU49xyLUnTjw92nJ0c0E5U9yDHxaT5Y42lKZMhh1bQ8kbIP0Uao9CWNsqin1ZUA+4w3htCQyqmQtfgp/0C+07gSOSiBchzkLGFb5QUKkFivm8iynbVgYOVHi0dxY5TitM9Jwd4LTJMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3f6740963b4so1268839b6e.3;
        Tue, 04 Mar 2025 16:09:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741133349; x=1741738149;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5KmCyNELJJemcnmUYppjmKqqpaAMRTnfnaa6QXbepoU=;
        b=Z7pp9WamAE2egF0uLwz+seSQ2Aqno85oHQRr+fe7TA5M12EN9sqfJsjcLtmtECqD8f
         LqAOlKYxsvMCUpCsduDSknfJiSMuBTOfZy89khsTFK0PWoGsOU9AHuLKrQAQ+0pDAuFD
         340wJeYSN334mKdGQXDQ4aSDxDr95IrrPxYLS2VL0luHjexdQ5OF+G6fzuuwb+pYN/rf
         FYARy99kOalLFFd4OinqEqZZGvfWjhFyWqX25rY1SEpgaMFjbNWvqW+bA/CznK09h/iw
         luw7EWhgX4JDmy9xXL3C2mcwh0c9DxzoFGAk6AaHH5CGJT4uBNIWkvfH5AzOYRCaS+6A
         QKaw==
X-Forwarded-Encrypted: i=1; AJvYcCU+621aojM4msx/X4dSyvXMOWWTpMMIJy189VMVcgwfHmVaA1uvRUV05g1bg4SwlOsmcqaoVxfU@vger.kernel.org, AJvYcCVQzHx9MqqKNJHmdv0qTvidZsAY36NwHT0OQ4e7qyCc/aJioa/PxosMYtkK0p8tjE8BCq6buzyfaG2s37jyfw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzGm0NkNpGJ/RTQ46ZV0jX/H7e88iPv8oOeLTNOzVSOWgZ8ESB2
	4Gx+fOctyMg4AhQk8CSe3I+RB4Ysp2kCtZSDu8+4E9Dfx0tcDgUNHwFlMIAH
X-Gm-Gg: ASbGncsRzIXio8TW2gAUkiXaarLljk5NMYB+zkT2dFzuKySh0tD5wk1OSa+GBqBZ8pK
	j5epde3YDe8iRIXKo0Gfq65g90u0G36j33nrOEQsK2XJ/CH1V/2NXryROIn5uLnxs5ko/WoDmyC
	7tBA9vks4eXTYC8OgOf6BFRkf06ORb4yMO3BjXuE4XSEfh2BDrXkMDdkK3t3MGPU4reVTLZUH1B
	tdBGLHTk/hLc1K89kyvUcoIOkfpKU7aMmjiLNRKEz46ZiIzeRtq+HajPPpLa4Uydalvdyh8aBBg
	0+7hFvvCAHuST5oRxtgut/JCZxVKym/rjRRhBPvvl1J68E+iDGXr+1Il6WeKUQ==
X-Google-Smtp-Source: AGHT+IHWNG2Yylm4c0/Jpo3YYVB+/tZtr02EkH0F6DG8CID8z8g+0y3pM7nC7o413CB1rGVMvbBteA==
X-Received: by 2002:a05:6808:1825:b0:3f6:786c:cb9a with SMTP id 5614622812f47-3f6831f35e0mr485321b6e.37.1741133349420;
        Tue, 04 Mar 2025 16:09:09 -0800 (PST)
Received: from sean-ThinkPad-T450s.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3f67ee8f479sm299985b6e.40.2025.03.04.16.09.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 16:09:07 -0800 (PST)
From: sean.wang@kernel.org
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	mingyen.hsieh@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	stable@vger.kernel.org,
	Caleb Jorden <cjorden@gmail.com>
Subject: [PATCH v5 4/6] wifi: mt76: mt7925: adjust rm BSS flow to prevent next connection failure
Date: Tue,  4 Mar 2025 16:08:49 -0800
Message-Id: <20250305000851.493671-4-sean.wang@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250305000851.493671-1-sean.wang@kernel.org>
References: <20250305000851.493671-1-sean.wang@kernel.org>
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
Co-developed-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Tested-by: Caleb Jorden <cjorden@gmail.com>
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
---
v2:
  1) generate the patch based on the latest mt76 tree
  2) update the commit message
v3:
  1) fixed the merge conflict
v4:
  1)  add tested-by tag
v5:
  1) fixed mt7925/main.c:1245:28: warning: unused variable "mvif" [-Wunused-variable]
  2) update co-developed-by tag
  3) rebase to wireless.git
---
 .../net/wireless/mediatek/mt76/mt7925/main.c  | 44 +++++++++++++++----
 1 file changed, 35 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index 604f771af68e..a7464839318e 100644
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
@@ -1242,14 +1272,10 @@ void mt7925_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 
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


