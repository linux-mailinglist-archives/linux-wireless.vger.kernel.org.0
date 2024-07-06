Return-Path: <linux-wireless+bounces-10038-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A6B99291E3
	for <lists+linux-wireless@lfdr.de>; Sat,  6 Jul 2024 10:29:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06715283959
	for <lists+linux-wireless@lfdr.de>; Sat,  6 Jul 2024 08:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A508046556;
	Sat,  6 Jul 2024 08:28:56 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376146BFB0
	for <linux-wireless@vger.kernel.org>; Sat,  6 Jul 2024 08:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720254536; cv=none; b=pb6pu3EZwWJaiIYYD0312Lq6B/wGnlotXaxK3RIMuig+NMrnQTY0t8nSfquOpXqzpR9ideSJtqOcI9ubzNk0xSlkJlLfh+4zCoIwYo4dim8cOOx8BTJjuRI/vRrsq1Yg9Ag9ZYy8gZLc4hKKFzBOz+1M0LOmsxHqU4gGSh4cd1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720254536; c=relaxed/simple;
	bh=qRyhWPbkhTQbLWJlcFCLAhTsZCUkq/Cci7ttciZIH3o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dctvBLcyXkYtVEP7I2t2+fj9cbWn025vCHvbnFaOQwLJU1wqC35gsYD1i22v/lOETW0LhjT39XN5a6hSWYJFYZm+kBXJ/YETYsSc4O0voLONGB6nB6rSC0WVfLUFWCK261KSFJmVr4s22OQHi3I9hDk9aSHSOYqEbvxVh+jnUO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3d92563bea4so14970b6e.3
        for <linux-wireless@vger.kernel.org>; Sat, 06 Jul 2024 01:28:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720254534; x=1720859334;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3S6mlsXmirTjv2z8akgtbzv3cHrQXWXD1zrwfiohz18=;
        b=Bm7UHqye2DjJB3aDN7vJ628iq9NlPSb1Mjopv37dUhtdlzmU1j/VmQYEHPEOH0qIOy
         hMIwiTvvBTYIZehKE9ws78s37SBCcr74/r98uYo3usGR/TahgeCvnW0AOb6svCziH4Nd
         twqaA6X+BznVERf0p4D9fPyqdKqTa3dji4cb1eWn9GXX6kTcHeo6Ezmq/Iq0Q++DZ7CC
         Qng6+LZShvBYUWxZdFwhk2l7SfyByztjLPRIMBFJcy7CdE9QA0QeveTI9eKLxLKTzu4Q
         A3qDmT7/eS2KB2xiDcs/zICHZzjFNX52jOaT/sSWJmtkh1TigESZS/UW3WdUa1x7rymJ
         R+gw==
X-Forwarded-Encrypted: i=1; AJvYcCXwjCZXNBmFNjJH2JTgG6Ag7hFDMiRoC74qc6m/U7Nw477dTGF3Xr83t6Y28VrfcqKEqQ59LQRoqF/bqwD5xMZ1rlhD1a1gyW0gJKZU2wU=
X-Gm-Message-State: AOJu0YyZ+FhoibzzZHMfo2lsH8GyvPeYnJQ6VweW0KoW3qQctSoHO93C
	8NlvovAujUQzj3eH2DaKWEvT8+BD0ZBcSvUZ9LaF7FRtcFK+W6AA
X-Google-Smtp-Source: AGHT+IHh2/AbUPDMj3Hmw3iHC21ScZt1IRJwxGj917xgQkf9TrsovD+xoY+j5YDE28M1gNQs9IHFbA==
X-Received: by 2002:a05:6870:eca3:b0:25e:c0b:82c5 with SMTP id 586e51a60fabf-25e2bf101admr6656159fac.3.1720254534322;
        Sat, 06 Jul 2024 01:28:54 -0700 (PDT)
Received: from sean-ThinkPad-T450s.attlocal.net ([2600:1702:5083:7610:1e13:57ab:ecc5:1fd4])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-25e71070ba1sm10744fac.34.2024.07.06.01.28.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jul 2024 01:28:53 -0700 (PDT)
From: sean.wang@kernel.org
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	mingyen.hsieh@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v2 19/37] wifi: mt76: mt7925: add link handling in mt7925_vif_connect_iter
Date: Sat,  6 Jul 2024 01:27:59 -0700
Message-Id: <c8d66043a4d31801249d53dd23f695c28a97a933.1720248331.git.sean.wang@kernel.org>
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

add link handling in mt7925_vif_connect_iter

Co-developed-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Co-developed-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7925/mac.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mac.c b/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
index 0cb9031e9fdd..cf36750cf709 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
@@ -1267,15 +1267,23 @@ mt7925_vif_connect_iter(void *priv, u8 *mac,
 			struct ieee80211_vif *vif)
 {
 	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
+	unsigned long valid = ieee80211_vif_is_mld(vif) ?
+			      mvif->valid_links : BIT(0);
 	struct mt792x_dev *dev = mvif->phy->dev;
 	struct ieee80211_hw *hw = mt76_hw(dev);
+	struct ieee80211_bss_conf *bss_conf;
+	int i;
 
 	if (vif->type == NL80211_IFTYPE_STATION)
 		ieee80211_disconnect(vif, true);
 
-	mt76_connac_mcu_uni_add_dev(&dev->mphy, &vif->bss_conf,
-				    &mvif->sta.deflink.wcid, true);
-	mt7925_mcu_set_tx(dev, &vif->bss_conf);
+	for_each_set_bit(i, &valid, IEEE80211_MLD_MAX_NUM_LINKS) {
+		bss_conf = mt792x_vif_to_bss_conf(vif, i);
+
+		mt76_connac_mcu_uni_add_dev(&dev->mphy, bss_conf,
+					    &mvif->sta.deflink.wcid, true);
+		mt7925_mcu_set_tx(dev, bss_conf);
+	}
 
 	if (vif->type == NL80211_IFTYPE_AP) {
 		mt76_connac_mcu_uni_add_bss(dev->phy.mt76, vif, &mvif->sta.deflink.wcid,
-- 
2.25.1


