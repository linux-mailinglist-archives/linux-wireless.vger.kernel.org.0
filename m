Return-Path: <linux-wireless+bounces-10032-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9574F9291DD
	for <lists+linux-wireless@lfdr.de>; Sat,  6 Jul 2024 10:29:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 514AD283524
	for <lists+linux-wireless@lfdr.de>; Sat,  6 Jul 2024 08:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5FFB42AB9;
	Sat,  6 Jul 2024 08:28:46 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46AC155888
	for <linux-wireless@vger.kernel.org>; Sat,  6 Jul 2024 08:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720254526; cv=none; b=jqAj6HwTmzuqgOJuLVpWWdOLOZ0KJNznYjMS9ZhLgeTkNFHHso+nUpHv1cYbX1yXv1W+GPaybf3/qGnDkStR2KCBW6ZeQpHw6WZ+HvF3EsDh1YnplAK+GCN9EvLEfGqnNRImTMuuCchY4qIiwF+tldBbPctmJEdmZOEGJp5lAhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720254526; c=relaxed/simple;
	bh=rlBnCp+t0EhmhW4nIfCZEb5xnd9M3BB0MHmXdHZ3mto=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Sq1e7DUGltiBRaDFoQZqDpvxvG/pAv4fReWmXSblIx0vwctXwcbZnsG9fAaKxatngPojCCvgi39Mlz+MUtBJAhLEVkaZdLws3MjvbyZY9jGBIDQSF5eX2X2TA2A9xMMFnGMZVLZ/e1iKDblLRW2fz8t2aXky6XcJqskm2SWZ9Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-254925e6472so364168fac.0
        for <linux-wireless@vger.kernel.org>; Sat, 06 Jul 2024 01:28:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720254524; x=1720859324;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AtLrHZs5XXJ5T1iBD9wtN1TtAgoimSM4Q0D5cGIf2QM=;
        b=SOGHwScMEg33JHCdBkAg30/EwfRtugCsmPBPstggDpD2p6Q1ILirhMFVmDn/F6lt0G
         QyywdnOlDwzZruQP+3gd/ZlMO9jJ9EDIGoPofAgqkX4rxywOt7MNSUQYBJCfELC/VoKD
         xZRbdrqoyBlMv712n2LPzTFzn9zDKrBwKQgwDo07bWFRAghQFgTwRZeIQBWMkczezQSw
         VKsdziItkfepo8iH5LtT3yAkrlYWJd4V1ONRUq4MXQB3Z7GjNGNhq9WsI5R2VoLeNDWB
         E6zeBCdyj6VuFZWqsyJV1UldqTUIRjHSbvsVWEsdFwC6DieMFSClV1aepUjPTxWT8LAv
         TEPA==
X-Forwarded-Encrypted: i=1; AJvYcCVCgqnhKUZIx8NplFaM0tZ530b/vLo+5MveHVSVm6HjHTqCi175WOoDsOCpMQyiMpB/nMh1I3tYXPCvcR+j9gCSiG1qINVXfiye4yrmBLQ=
X-Gm-Message-State: AOJu0YyQghGy5w2ymgfS9FcC+NFuTIlZIjI11nsmS+DfJGkWp6H443/p
	y7lBzywZt0Y2RIUhz3O9gxNwgKTnjqCaN4VIBmnklzlSEW/I94b76Qqe/wxG
X-Google-Smtp-Source: AGHT+IEXHNQhlSzAY8Tlzy3RmC8HaFoPtI9qwVs2TRhuyiPg31fh7q5+Usbvf2qGax22+0W9aOY6zw==
X-Received: by 2002:a05:6871:24d9:b0:254:affe:5a08 with SMTP id 586e51a60fabf-25e2ba1b287mr6406885fac.2.1720254524275;
        Sat, 06 Jul 2024 01:28:44 -0700 (PDT)
Received: from sean-ThinkPad-T450s.attlocal.net ([2600:1702:5083:7610:1e13:57ab:ecc5:1fd4])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-25e71070ba1sm10744fac.34.2024.07.06.01.28.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jul 2024 01:28:43 -0700 (PDT)
From: sean.wang@kernel.org
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	mingyen.hsieh@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v2 13/37] wifi: mt76: mt7925: add link handling to mt7925_change_chanctx
Date: Sat,  6 Jul 2024 01:27:53 -0700
Message-Id: <49f2a2f8230979a4e123bc1dab70a8496875cc6c.1720248331.git.sean.wang@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1720248331.git.sean.wang@kernel.org>
References: <cover.1720248331.git.sean.wang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Wang <sean.wang@mediatek.com>

add link handling to mt7925_change_chanctx

Co-developed-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Co-developed-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7925/main.c  | 22 +++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index a2cf05fdfc3a..957e6bcaf9c1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -1571,13 +1571,15 @@ mt7925_change_chanctx(struct ieee80211_hw *hw,
 {
 	struct mt792x_chanctx *mctx = (struct mt792x_chanctx *)ctx->drv_priv;
 	struct mt792x_phy *phy = mt792x_hw_phy(hw);
+	struct mt792x_bss_conf *mconf;
 	struct ieee80211_vif *vif;
 	struct mt792x_vif *mvif;
 
 	if (!mctx->bss_conf)
 		return;
 
-	mvif = container_of(mctx->bss_conf, struct mt792x_vif, bss_conf);
+	mconf = mctx->bss_conf;
+	mvif = mconf->vif;
 	vif = container_of((void *)mvif, struct ieee80211_vif, drv_priv);
 
 	mt792x_mutex_acquire(phy->dev);
@@ -1585,8 +1587,24 @@ mt7925_change_chanctx(struct ieee80211_hw *hw,
 		mt7925_mcu_set_sniffer(mvif->phy->dev, vif, true);
 		mt7925_mcu_config_sniffer(mvif, ctx);
 	} else {
-		mt7925_mcu_set_chctx(mvif->phy->mt76, &mvif->bss_conf.mt76, ctx);
+		if (ieee80211_vif_is_mld(vif)) {
+			unsigned long valid = mvif->valid_links;
+			u8 i;
+
+			for_each_set_bit(i, &valid, IEEE80211_MLD_MAX_NUM_LINKS) {
+				mconf = mt792x_vif_to_link(mvif, i);
+				if (mconf && mconf->mt76.ctx == ctx)
+					break;
+			}
+
+		} else {
+			mconf = &mvif->bss_conf;
+		}
+
+		if (mconf)
+			mt7925_mcu_set_chctx(mvif->phy->mt76, &mconf->mt76, ctx);
 	}
+
 	mt792x_mutex_release(phy->dev);
 }
 
-- 
2.25.1


