Return-Path: <linux-wireless+bounces-10034-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 057E49291DF
	for <lists+linux-wireless@lfdr.de>; Sat,  6 Jul 2024 10:29:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1849D282E8F
	for <lists+linux-wireless@lfdr.de>; Sat,  6 Jul 2024 08:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42DA64655F;
	Sat,  6 Jul 2024 08:28:50 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D370A60EC4
	for <linux-wireless@vger.kernel.org>; Sat,  6 Jul 2024 08:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720254530; cv=none; b=lIzONpN5Wwngm7wgJEvLbkyeTRivf5p3tP37MlExG58E4efTmjttV0lkr61I8mhaXxVH8t4RfxyvY0NrGYk/6ujFEl+ayDUMapXXJUTlQ6gvBPwhRh7fd4ItlMROU6yJQi5dPNifmNG6Qt23p9bf58QTFus9PpCY8rcZmpurjhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720254530; c=relaxed/simple;
	bh=WNioRFiguZybx4g7hgSMOKliBwrKLTL+IN6sptCdWUA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Jq3vWeOaH/lTin1BFA9kesCiznj2HvpPECYb4M6TV2iuHkOif+RWkRxn4iGXlHajn+25+S8/dzZZ59xU0u4ot7PfwtJio6cNkzRzbwyaLbe2v8OCXFnwzgolvZ3ctW9VOcmybl+Ib8MU7h+pIvlM6O+reG3wbJoDgaGWSgoUA3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5c229104335so56211eaf.3
        for <linux-wireless@vger.kernel.org>; Sat, 06 Jul 2024 01:28:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720254528; x=1720859328;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OxHeMh4wlCaNsBAEaEhqWJP5pfcIdTUVwY854lC9UJQ=;
        b=u5zKmGq9esKnbf03a32OEjMM8zxNS8Gxqs8N+JgpTuybL0BupA0483Y5MRflWMSwUj
         9EeqBQpZUld12QFuJJyZvVWW9/w3F+dCiP2BFc4uWojX11ewpUWJMFAHYnsPFx8qICSd
         NkHT11/lmXUJQvzoxvyjqsP6d4N1G+xVZc6eDpiojvFCby/96p8rF21xHCfb2SexUNIk
         a+Bvlfj3qniknholSnwF/XeXXEYuAKfNZ5Ztley8ddtmjYqla/28zii2WVfmzS/8bs/C
         5GxuW1VNYBXkvGmPbWD37/1P7IG4D2LJMDA8LgMmaSRlt7BdWhw/JU+8JAMGeLDXE78N
         v8/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVDaQ85K+fE3P/z84YlsG7BunGcPjLAmUfAsvD8zKSyQentuhMjdvyBMvc6c/5sYnRMU0EbdXiTLDL7uqZovmcGChohoIgnENjta58CLgw=
X-Gm-Message-State: AOJu0Yyxz+m5F3+ImR4Pw88ED048JgKZNgHXpNokASQ8mhWfOwwxdFN+
	LN5CTUdAh12jdQSQoRY7qvmTND3lNlrJmbcWj8gJS0J1MVF3I8SE
X-Google-Smtp-Source: AGHT+IE97gP4q0ZkWnwJvWnniBVGYpKbvU3SGVfqlg+6uBeR4gYRI0sjUfKWO+BbR90ANYfMGNFWyg==
X-Received: by 2002:a05:6871:5229:b0:25e:dce:491b with SMTP id 586e51a60fabf-25e2b8b79abmr6843594fac.1.1720254527757;
        Sat, 06 Jul 2024 01:28:47 -0700 (PDT)
Received: from sean-ThinkPad-T450s.attlocal.net ([2600:1702:5083:7610:1e13:57ab:ecc5:1fd4])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-25e71070ba1sm10744fac.34.2024.07.06.01.28.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jul 2024 01:28:46 -0700 (PDT)
From: sean.wang@kernel.org
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	mingyen.hsieh@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v2 15/37] wifi: mt76: mt7925: add link handling in mt7925_mcu_set_beacon_filter
Date: Sat,  6 Jul 2024 01:27:55 -0700
Message-Id: <b814718a40ad5df6100e63d15c87ba95a318bc22.1720248331.git.sean.wang@kernel.org>
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

add link handling in mt7925_mcu_set_beacon_filter

Co-developed-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Co-developed-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7925/mcu.c   | 23 ++++++++++++++-----
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index 43c20fdb747c..9a4dfe53da17 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -1818,21 +1818,32 @@ int mt7925_mcu_set_beacon_filter(struct mt792x_dev *dev,
 {
 #define MT7925_FIF_BIT_CLR		BIT(1)
 #define MT7925_FIF_BIT_SET		BIT(0)
+	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
+	unsigned long valid = ieee80211_vif_is_mld(vif) ?
+				      mvif->valid_links : BIT(0);
+	struct ieee80211_bss_conf *bss_conf;
 	int err = 0;
+	int i;
 
 	if (enable) {
-		err = mt7925_mcu_uni_bss_bcnft(dev, &vif->bss_conf, true);
-		if (err)
-			return err;
+		for_each_set_bit(i, &valid, IEEE80211_MLD_MAX_NUM_LINKS) {
+			bss_conf = mt792x_vif_to_bss_conf(vif, i);
+			err = mt7925_mcu_uni_bss_bcnft(dev, bss_conf, true);
+			if (err < 0)
+				return err;
+		}
 
 		return mt7925_mcu_set_rxfilter(dev, 0,
 					       MT7925_FIF_BIT_SET,
 					       MT_WF_RFCR_DROP_OTHER_BEACON);
 	}
 
-	err = mt7925_mcu_set_bss_pm(dev, &vif->bss_conf, false);
-	if (err)
-		return err;
+	for_each_set_bit(i, &valid, IEEE80211_MLD_MAX_NUM_LINKS) {
+		bss_conf = mt792x_vif_to_bss_conf(vif, i);
+		err = mt7925_mcu_set_bss_pm(dev, bss_conf, false);
+		if (err)
+			return err;
+	}
 
 	return mt7925_mcu_set_rxfilter(dev, 0,
 				       MT7925_FIF_BIT_CLR,
-- 
2.25.1


