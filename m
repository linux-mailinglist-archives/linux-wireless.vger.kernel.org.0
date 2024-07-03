Return-Path: <linux-wireless+bounces-9963-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD279926AA4
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2024 23:45:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AF3E1C21A20
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2024 21:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A70B01946D7;
	Wed,  3 Jul 2024 21:43:37 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371B11953AD
	for <linux-wireless@vger.kernel.org>; Wed,  3 Jul 2024 21:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720043017; cv=none; b=So0ISMEiCEEJ/jeVbMdzeszkTRy5zThWgq9ITOiEQEIShd2qtdHHLladVS2GAxIii7KgEp3BmzMZZgXIWMA8Si6sduR6vbMEg+lsUc2VxJFnKTASfoxkkRpD8K6s5Sf3H+5B83totZFLbVGngDx6x7Gz3nH+dQ+YYgJjG6Pb+V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720043017; c=relaxed/simple;
	bh=4PtZzdcoL+KyTVA5WplrfHYl6ZYgyYEk3N99uL7q0fI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A0khOPd1XccfHQ5j8+6pBO+lYbHszLLiUhvyWL3YCDf2oab10Ag9By8xIobiXlhmrYhr2EmaxfIVBb40HmfehO+Ce2OpGKvX3+eXhdP9nONR6ykUG9a0nlPYNzqxudVqVHq7gMVMBiafvnjY62meeYU+TXQlX3CADZtp9rOdzFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-701fa02e5c1so84615a34.2
        for <linux-wireless@vger.kernel.org>; Wed, 03 Jul 2024 14:43:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720043015; x=1720647815;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g37T4CjI6r9HOceV/Z2FL5pGlk5t0qMk/CEhDyaAnXw=;
        b=LQ9SE4IgUm+yzOq4g/AHjkQ/xRVrPYJF6nmdx/sveboez+A8UgAv7qGwvLTfCBKMQq
         kRuZN3a7QsiipX2fBB7Q+355PE4y0v/rQoQTM/bplIL+y6zdMWVsZeYtVTNN+V4UHvp/
         /D0G814q2C5K8cKQXtQFt4FhPk9s/Nb+C4CrGwbPczdRlgkXghRWD/cW/pPQeBrE3bGE
         4mJLAe28NgWOymfMIk50dOFKRSUCe4cr6hSXImdoafy+oGCkIYo2JyJGD9+zAn+5kdF3
         dhtFsiFA55kQLmmjjZ4PftG9UCxLIDqJ/GTBW4IvWjDV0/10hd4MYuLAbtlKoX5cL2ff
         VYfQ==
X-Forwarded-Encrypted: i=1; AJvYcCXxDI5HbRV+M0x1JOdLfkjTkBKUtHvCmdYoSksxcF1tfGc9y0mj62NRVHDIajMpn9762oWxrVagq2w/olHc2lJfdQdJUmTPMsG76XYZFwU=
X-Gm-Message-State: AOJu0Yz3zfyHkHHZJnR2lPwzNvRl0/Q6Jp9luJhRsO80A2w3eQwaRA+O
	u26eO3FhBASAzy1fRLf9LF/bz+F5fWnp/Eura7tlAA3ALRL3VaKC
X-Google-Smtp-Source: AGHT+IGZQAxkdXIk+I8F4X/wcmiceJqFKgT51xCUKYrAA7cmb2oD4iG5Df3wtgYhrthp3Cx1CY5XHA==
X-Received: by 2002:a9d:5c89:0:b0:700:ca11:1158 with SMTP id 46e09a7af769-702076766bcmr11947539a34.1.1720043015253;
        Wed, 03 Jul 2024 14:43:35 -0700 (PDT)
Received: from sean-ThinkPad-T450s.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-701f7b20953sm2111417a34.54.2024.07.03.14.43.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 14:43:34 -0700 (PDT)
From: sean.wang@kernel.org
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	mingyen.hsieh@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 23/29] wifi: mt76: mt7925: update mt7925_mcu_sta_mld_tlv for MLO
Date: Wed,  3 Jul 2024 14:42:28 -0700
Message-Id: <99eac993f7020488f0debf972e2fc71f4bca36a4.1720042294.git.sean.wang@kernel.org>
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

Update mt7925_mcu_sta_mld_tlv for the MLO-enabled firmware.

Co-developed-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Co-developed-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7925/mcu.c   | 29 ++++++++++++++-----
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index 3f0ceebed2f8..71f1fb9fbe2f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -1735,19 +1735,34 @@ static void
 mt7925_mcu_sta_mld_tlv(struct sk_buff *skb,
 		       struct ieee80211_vif *vif, struct ieee80211_sta *sta)
 {
-	struct mt76_wcid *wcid = (struct mt76_wcid *)sta->drv_priv;
+	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
+	struct mt792x_sta *msta = (struct mt792x_sta *)sta->drv_priv;
+	unsigned long valid = mvif->valid_links;
+	struct mt792x_bss_conf *mconf;
+	struct mt792x_link_sta *mlink;
 	struct sta_rec_mld *mld;
 	struct tlv *tlv;
+	int i, cnt = 0;
 
 	tlv = mt76_connac_mcu_add_tlv(skb, STA_REC_MLD, sizeof(*mld));
 	mld = (struct sta_rec_mld *)tlv;
-	memcpy(mld->mac_addr, vif->addr, ETH_ALEN);
-	mld->primary_id = cpu_to_le16(wcid->idx);
-	mld->wlan_id = cpu_to_le16(wcid->idx);
+	memcpy(mld->mac_addr, sta->addr, ETH_ALEN);
+	mld->primary_id = cpu_to_le16(msta->deflink.wcid.idx);
+	mld->wlan_id = cpu_to_le16(msta->deflink.wcid.idx);
+	mld->link_num = min_t(u8, hweight16(mvif->valid_links), 2);
 
-	/* TODO: 0 means deflink only, add secondary link(1) later */
-	mld->link_num = !!(hweight8(vif->active_links) > 1);
-	WARN_ON_ONCE(mld->link_num);
+	for_each_set_bit(i, &valid, IEEE80211_MLD_MAX_NUM_LINKS) {
+		if (cnt == mld->link_num)
+			break;
+
+		mconf = mt792x_vif_to_link(mvif, i);
+		mlink = mt792x_sta_to_link(msta, i);
+		mld->link[cnt].wlan_id = cpu_to_le16(mlink->wcid.idx);
+		mld->link[cnt++].bss_idx = cpu_to_le16(mconf->mt76.idx);
+
+		if (mlink != &msta->deflink)
+			mld->secondary_id = cpu_to_le16(mlink->wcid.idx);
+	}
 }
 
 static int
-- 
2.25.1


