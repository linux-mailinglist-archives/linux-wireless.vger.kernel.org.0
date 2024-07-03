Return-Path: <linux-wireless+bounces-9954-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29715926A98
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2024 23:44:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2931B257E9
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2024 21:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DACE19309C;
	Wed,  3 Jul 2024 21:43:21 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20FF1194A63
	for <linux-wireless@vger.kernel.org>; Wed,  3 Jul 2024 21:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720043001; cv=none; b=eL65hxTkZzQwmI6Zd1oqaR/VWfq+93uVW/Nkdts7Td0eLKZs8IXgJg5w5VJyBZiL40QQvJsgRu7OLAMEdEjhTBiCXzQB5ZpWXpoe14OdTjUI6ipwEKG47Gaxa55rF99Dl+VI1NzZ9dhfFGQjOcS54TSFnyIrOrpaEftPlUki+Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720043001; c=relaxed/simple;
	bh=R/ZvWBthPSPIFunjOS+rSuUHq015y5tp/QrhkrxwleE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OLpjI9Nw/vD5BUdG7He25qApdFKzD03i8oF7trX1tyLAzNFyabvlWVxjZpkGTkN24nUpeUzLl2huskC8EUqog4g4NWlSbbpnu9c7f2l5TROx6RtTr8oY7cjlJ0Ug5g38Fxt1Cytmqo2TjsuFTXhIJiIVDAE3FnUBTvDdFoMs/vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-25dff23459cso3559fac.3
        for <linux-wireless@vger.kernel.org>; Wed, 03 Jul 2024 14:43:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720042999; x=1720647799;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4B3iA/wt292iPzlQ3NlN/3BkJe4Kss6jwJQvuDphHUk=;
        b=KJAYBqsZQw2tig5YvCGC1juo/d4WyYHfcx8JekZseHyXC1eLeKOfleOgKpWJBdfcAc
         /pbq/V43u9SuYKma8uxZ282gTwzwJGgV8KhVvaxmsELGtYbhHf8hLUJHhMFs5HIRqTkZ
         Tc+rSP4g1CYOadadOe/T2Sf468bVGAh1z6Q87Q7wkwmsiCWMuYa0mI+PuD5Ld9LM7Zzu
         6h1ghD8q7Cq5Te+3zpOmYDcsJUuPatmU0/YVqVlAiY5PHurSAIbFucXsvlk7nqU9B5q/
         IOytn1v9RSP7frMpWM9eHx64FSZpZ4UA/lv6KOCfL/1QBEgL7b7uahzK5K2MBNz6LGm0
         wJ3A==
X-Forwarded-Encrypted: i=1; AJvYcCUMEpPjpMxGMR/zzXE1VKnRH6g/yXiGYLYSIKDpDeflNjX3cv0JdqO9TGZvAufIL/JCcGAeyhC7RxXWBDL7jF8262GOn9fSL/J3k9y1X+4=
X-Gm-Message-State: AOJu0YzonZv3jMDyOXTJKx/LcG3ZWH3fQ1/wVFAqo8zs/Xkmt+RTVwjV
	nczTHpERrc3DXAH3nTeLs3NO4wdj6Aws81201stUXBGgDGW3peB5
X-Google-Smtp-Source: AGHT+IGagnQr9R2SqTk/ttCi+flx1eUf6vzlrnRL8I6wKE/xqEuIlzcLpsgBjl1PvNgCgA3Equ378w==
X-Received: by 2002:a05:6870:55d4:b0:25e:dce:491b with SMTP id 586e51a60fabf-25e0dce4b4amr2524158fac.1.1720042999249;
        Wed, 03 Jul 2024 14:43:19 -0700 (PDT)
Received: from sean-ThinkPad-T450s.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-701f7b20953sm2111417a34.54.2024.07.03.14.43.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 14:43:18 -0700 (PDT)
From: sean.wang@kernel.org
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	mingyen.hsieh@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 14/29] wifi: mt76: mt7925: add link handling in the BSS_CHANGED_PS handler
Date: Wed,  3 Jul 2024 14:42:19 -0700
Message-Id: <4e072a7ac17d2f7c97569ba724b74434ac414db3.1720042294.git.sean.wang@kernel.org>
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

Added link handling in the BSS_CHANGED_PS handler.

Co-developed-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Co-developed-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7925/main.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index 69849146610e..46ce23c7ec27 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -1635,6 +1635,7 @@ static void mt7925_vif_cfg_changed(struct ieee80211_hw *hw,
 				   struct ieee80211_vif *vif,
 				   u64 changed)
 {
+	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
 	struct mt792x_dev *dev = mt792x_hw_dev(hw);
 
 	mt792x_mutex_acquire(dev);
@@ -1651,8 +1652,17 @@ static void mt7925_vif_cfg_changed(struct ieee80211_hw *hw,
 		mt7925_mcu_update_arp_filter(&dev->mt76, &mvif->bss_conf.mt76);
 	}
 
-	if (changed & BSS_CHANGED_PS)
-		mt7925_mcu_uni_bss_ps(dev, &vif->bss_conf);
+	if (changed & BSS_CHANGED_PS) {
+		unsigned long valid = ieee80211_vif_is_mld(vif) ?
+					      mvif->valid_links : BIT(0);
+		struct ieee80211_bss_conf *bss_conf;
+		int i;
+
+		for_each_set_bit(i, &valid, IEEE80211_MLD_MAX_NUM_LINKS) {
+			bss_conf = mt792x_vif_to_bss_conf(vif, i);
+			mt7925_mcu_uni_bss_ps(dev, bss_conf);
+		}
+	}
 
 	mt792x_mutex_release(dev);
 }
-- 
2.25.1


