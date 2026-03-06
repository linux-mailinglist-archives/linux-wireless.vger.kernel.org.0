Return-Path: <linux-wireless+bounces-32674-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MB9sIaRiq2mmcgEAu9opvQ
	(envelope-from <linux-wireless+bounces-32674-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 07 Mar 2026 00:26:28 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE3E228A8F
	for <lists+linux-wireless@lfdr.de>; Sat, 07 Mar 2026 00:26:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BC360312D40B
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Mar 2026 23:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17D662ECE91;
	Fri,  6 Mar 2026 23:23:38 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7507371D03
	for <linux-wireless@vger.kernel.org>; Fri,  6 Mar 2026 23:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772839418; cv=none; b=OWOCOn6zJEBvL6wsE1C488qDTFS4R3TAm7G4jzpj0ucI5INAlN6U5rfKEcNqk2LP2yipg5ptEEVUgpq12bA/TD2cBufG70osMQbQrOxcVYshTuHpsGKDdQrM9rVt65kwP/NIjr+0dNlMB3pcbkkZGHCEI5Pe+5AHGj0vOZ/10YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772839418; c=relaxed/simple;
	bh=dIgHoBXKMOYRgAJ09Y01y7R1090GC4tQbwO1Y2wqza4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p5uYkUmOBu6SIGNvC0ce+LeeFhXgixjBNB4hv/m43picmfBqgmoLddgDvHKl334sL8OR52+CR9sRGrBdF4Hw64TdIhxubtV53vZvB45tt5egwptWDyv5FxHccUCGbEVNoAlUiHvx3PvWDkNqTHFiFFtCu8qes9wp4jS61Y5o4xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-4152698e745so1843817fac.1
        for <linux-wireless@vger.kernel.org>; Fri, 06 Mar 2026 15:23:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772839416; x=1773444216;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=D6tzslYz/qBkYRLW0SjS8m12VVJZ7BWeZC0ivqU2SZY=;
        b=VX8a6MTd8nke5ERazqDg5x8Ad64hOI46LGBfQeXlwo49vxLomSnWiYen65lrCxAze7
         hbE9rTxLuTjr9Jul+YVwa9xU/W3FKAnxtTAqIBsh2H9Nn5vr4DUhajcraTn7h2VxxSla
         7WrRmu2Ja5o9YxukgXOYwdas7G/A84gGlcGPy4Qgol85BW4IeVqEqefJVnV7gxYPZJfS
         TfdeA7gfUjcEXZoT85gB4B2RO4QaQ3fZt2/HS8HcKZbYiKWRTt2AtClGPYkRGBvrP+Sy
         pVAA9WyTg+CKu4I66AhO1k7V7HphisXF6tACFofK+dXfrbyU0MiSI1b+11Db84YC2Qzy
         UpQA==
X-Gm-Message-State: AOJu0YyrPeuA0DzEzc2DUV76vQxxA+Q4bHDQfuUtV9M2Xiax9XuquhJZ
	KkaKiMa9BN7XgPrkARyiXyYTXmzVsecrw64tKMyQz7j22Lsicqfx6aCI
X-Gm-Gg: ATEYQzzaqC2+lN2hYP72avM9yX3W1JKvVMhLOsMIuK+h5r9EIVmRmwnTiFFOx8gCSqN
	ofldNbL7Lqkg8TUeF3SbHFRY2yPghb6hUJfKSFo6OqGcFhxwq4QgVWe+xU9/clyKx9kVllwuxDk
	krvsK2o48yO0+xVki5+sxQNmonsiYxvhCkx4UH025LTgE+WsD68M79f4tIhb/ZYwVmB5Bv+X4nw
	1LS4mGZ1bWEPXe4r+IA63+Mt/E097zbE8YMfX+GpDuzHGZq+6faz2jz4y9I+mH6HW1uZrZDlgnE
	jQPff732SE57Mu9Pit/YIQm9CzZAfyffXrBukgmNsCgKMrxXYXXCrtU7rW8nvVCXfFIpFjGoZrN
	MwrjbCpgmW6wK/sNUdpAoiHb8atwwhJ/6g3dLfxSLqGQiVZvOXUVt0dWNDC4lbDLZWRSWEmnQIV
	6Nx8OsO0qk29JgUZ0qr+TnA2m0rrs7TbxKSwdwL19aRuDZyk4=
X-Received: by 2002:a05:6870:700b:b0:3e8:9e7b:4ea4 with SMTP id 586e51a60fabf-416e3e8493dmr2297605fac.6.1772839415748;
        Fri, 06 Mar 2026 15:23:35 -0800 (PST)
Received: from sean-HP-EliteBook-830-G6.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-416e65b1c82sm2572344fac.5.2026.03.06.15.23.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 15:23:35 -0800 (PST)
From: Sean Wang <sean.wang@kernel.org>
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH 09/19] wifi: mt76: mt7925: pass mlink to wtbl_update_hdr_trans()
Date: Fri,  6 Mar 2026 17:22:28 -0600
Message-ID: <20260306232238.2039675-10-sean.wang@kernel.org>
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
X-Rspamd-Queue-Id: DFE3E228A8F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-32674-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FROM_NEQ_ENVFROM(0.00)[sean.wang@kernel.org,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.382];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mediatek.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: Sean Wang <sean.wang@mediatek.com>

Drop the mt792x_sta_to_link() lookup in mt7925_mcu_wtbl_update_hdr_trans()
and pass the resolved mlink from the caller instead. The link context is
already known at the call site, making the lookup redundant.

This keeps the helper lookup-free and makes link ownership explicit.

No functional change intended.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7925/main.c   | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c    | 8 ++------
 drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h | 1 +
 3 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index ddff6c5ab876..f5dd91dacca5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -1598,7 +1598,7 @@ static void mt7925_sta_set_decap_offload(struct ieee80211_hw *hw,
 		if (!mlink->wcid.sta)
 			continue;
 
-		mt7925_mcu_wtbl_update_hdr_trans(dev, vif, sta, i);
+		mt7925_mcu_wtbl_update_hdr_trans(dev, vif, sta, mlink, i);
 	}
 
 	mt792x_mutex_release(dev);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index 03515b891643..0b096838bca6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -1097,18 +1097,14 @@ mt7925_mcu_sta_hdr_trans_tlv(struct sk_buff *skb,
 int mt7925_mcu_wtbl_update_hdr_trans(struct mt792x_dev *dev,
 				     struct ieee80211_vif *vif,
 				     struct ieee80211_sta *sta,
+				     struct mt792x_link_sta *mlink,
 				     int link_id)
 {
-	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
 	struct ieee80211_link_sta *link_sta = sta ? &sta->deflink : NULL;
-	struct mt792x_link_sta *mlink;
+	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
 	struct mt792x_bss_conf *mconf;
-	struct mt792x_sta *msta;
 	struct sk_buff *skb;
 
-	msta = sta ? (struct mt792x_sta *)sta->drv_priv : &mvif->sta;
-
-	mlink = mt792x_sta_to_link(msta, link_id);
 	link_sta = mt792x_sta_to_link_sta(vif, sta, link_id);
 	mconf = mt792x_vif_to_link(mvif, link_id);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h b/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h
index 95f29dae4d9d..e28972f0615b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h
@@ -371,6 +371,7 @@ int mt7925_mcu_set_rts_thresh(struct mt792x_phy *phy, u32 val);
 int mt7925_mcu_wtbl_update_hdr_trans(struct mt792x_dev *dev,
 				     struct ieee80211_vif *vif,
 				     struct ieee80211_sta *sta,
+				     struct mt792x_link_sta *mlink,
 				     int link_id);
 int mt7925_mcu_wf_rf_pin_ctrl(struct mt792x_phy *phy);
 
-- 
2.43.0


