Return-Path: <linux-wireless+bounces-17181-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CA54A05096
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Jan 2025 03:25:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8873D7A15F9
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Jan 2025 02:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4BCF186E54;
	Wed,  8 Jan 2025 02:25:29 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F26B183CB0
	for <linux-wireless@vger.kernel.org>; Wed,  8 Jan 2025 02:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736303129; cv=none; b=PQfdxpWB3tXHcKMCKcdi2558TJNbTgasY50zZTp0Td/LlRM3pybdsXjC6VxllLWbu50jmA66yKJHb5RvvYDpfxLyaSGfgBHLkOvhkIejvvXmqhSHqgtZGmr109MnSSkwIAkH6eRr0hQ8imE7l60faoNlmhoPpvIlfGbuBh3dsIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736303129; c=relaxed/simple;
	bh=jQ03YfZAry7lW/sU3FE6/IKz5I4+xG0gsL50TyuxTxM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RRWgg3oz0VkTx4ok0LpI41pAirZ9AKxviz7DC9t5++MRuIG7Hn/85udVeb1MfX+I9veBoHQMEvAqA5IxLmjFxV3L7jUPvWfgPayKG02frPdYSbtv1RRBVIjeLX5QuzZvae29pj+X6g6tir54QVoPmF8Phxz0EqFsgEY+K8k56IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5f6ab7e0bd6so3285547eaf.0
        for <linux-wireless@vger.kernel.org>; Tue, 07 Jan 2025 18:25:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736303126; x=1736907926;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5KdsPIydIRIbKmfDENt47w2PJVUxUaEb2n4hB8nXzq8=;
        b=p7hjwZjB6sWlbDey7fAl0jZk7c2whI9ekid0D+P8R+MSCjNy65eVO/ipLgIu1KUaRX
         m58Z6y5Tnz+Zx2UIDU1N1yoOd4V41lLuQ+CvSyhGILUi/+1RAzcWypoQmUvY0bqbAA/7
         Ddc5/Tz7F8eVUHqnwD4IAvB9lSpWbfViJ4baFIRtQZnBeBd5HCHP9H+WXFoAWEUyIs1x
         eTl+b9JSo3PP2RZGhrgfc+WACU7odmnqZopDrj3VceYftvlN1hgV6YjdThJvGCPthUsr
         fVUYA6eQM5KZtwYutDbjtBfERCihDpotmsoN9gpbSRU6luC21mEDpz3fiuA/j0F2lYQt
         7fUg==
X-Forwarded-Encrypted: i=1; AJvYcCVTMZfqvL4RjyLnh282kP0iHkPthtegPHEbOFh09g1/hdARHxkqlr/k+F36zk4KMeeywd5UV/FobboiRunkMw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/o0xFnhMajnt822Xh3rKZD1eHXef6qeiiQmIx8wFczOTMVuP9
	mXAfr9wdidBrizNYJt0Ql5ClnoSZ9a7HWfz4BCPi0Vxl6/HpOGMDsT+NUGSr
X-Gm-Gg: ASbGncskVj8Z+DOWFSCy8w+hB/8xW8NeuxSwHQlK+6eOd5WWZVYp0jAYcr73vJoxpNQ
	hyOGDg5iaX9v4lRL8NRy2EiYaHXrYCdwwQmsn5cPD8EjW3kO5MN5eN8k2tbLhjPZCLW8pHlkOU6
	NcsEBpcVh0Q6HoPLOx6VExf+++G0nzlAiYqYDuooPuh6WgvcVgyR7twtr67Wo0g1YTykLGC3zrz
	L4451R1f+Yp/q7xK78KxMb0y9WURVbpR3OmHXc7IOfgbGTGluQF9n3mfDESATfJoTbZ6e/EWA==
X-Google-Smtp-Source: AGHT+IGs582Bl+Jd+5X8M124/0pd+re+wzXpkBHMXYifN5VHFiYiOQ31GhLfhoJ5EGcBMXMot1q0Fw==
X-Received: by 2002:a05:6870:2007:b0:29e:5297:a2a7 with SMTP id 586e51a60fabf-2aa068d657fmr703235fac.30.1736303126104;
        Tue, 07 Jan 2025 18:25:26 -0800 (PST)
Received: from sean-ThinkPad-T450s.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2a7d77f6340sm13072862fac.48.2025.01.07.18.25.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 18:25:24 -0800 (PST)
From: sean.wang@kernel.org
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	mingyen.hsieh@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 4/6] wifi: mt76: mt7925: adjust rm BSS flow to prevent next connection failure
Date: Tue,  7 Jan 2025 18:25:07 -0800
Message-Id: <20250108022509.217803-4-sean.wang@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250108022509.217803-1-sean.wang@kernel.org>
References: <20250108022509.217803-1-sean.wang@kernel.org>
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
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7925/main.c  | 45 +++++++++++++++----
 1 file changed, 36 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index 35dede041248..4714c07cfbfe 100644
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
@@ -1213,6 +1243,7 @@ void mt7925_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 {
 	struct mt792x_dev *dev = container_of(mdev, struct mt792x_dev, mt76);
 	struct mt792x_sta *msta = (struct mt792x_sta *)sta->drv_priv;
+	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
 	struct {
 		struct {
 			u8 omac_idx;
@@ -1243,14 +1274,10 @@ void mt7925_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 
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


