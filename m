Return-Path: <linux-wireless+bounces-10033-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DDF89291DE
	for <lists+linux-wireless@lfdr.de>; Sat,  6 Jul 2024 10:29:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5ED25B21C1B
	for <lists+linux-wireless@lfdr.de>; Sat,  6 Jul 2024 08:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71282433AB;
	Sat,  6 Jul 2024 08:28:48 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D7F58ABF
	for <linux-wireless@vger.kernel.org>; Sat,  6 Jul 2024 08:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720254528; cv=none; b=exHRs+SV9XjF0usRFGh7OmTWAVMmq0Q2q+82/8VosWGjQGu0LoknsQ6wPZ0gSGyZaQtJaPg5G0b36fx5mCCu2FAWOvnAtxjhQlTfxrLUd365Dr9IC8+9s7+DX4Kp+zAU0VpW8UTA6VEp3Z4w182KZsFRGVJ+fcg6asN1aElG30s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720254528; c=relaxed/simple;
	bh=eq8lseYdfo8/3xQV0ypXYjf21lKFXph4VAg7yv5By5Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uA0l6CXUKdcQ/Y9iXAWOF5DPMkCrgr7bRmT19DfKgskKNDrD6fDUaVaNGHr0omA7VH59bt81o0qR0FUaNeIQyXYB6uIGE7QfOvVxnry8TdQCrx9aYGSVaunE3GexSF9Lqr0q8DwrynQ9LQ1VrNcrTKXwWWBiVrSM9z0PG0IwtIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-25e19ad0050so386961fac.0
        for <linux-wireless@vger.kernel.org>; Sat, 06 Jul 2024 01:28:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720254526; x=1720859326;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZfyFCkyFCvgSR1kwXfpvvrzkz9hGipNgrPtLfbnBC/k=;
        b=qTTrmri/Iqug5rQwo45GDL27LpnEC9ZZUoCjr0YrgTjo2fmN5SbLfbbsrtkStNX46Q
         Y+AsocqoU2dc3QTMygfFHI0h369dc7mdHNPNfPNCR3gmlbjNAUBhJQ3esqadqVCEraq/
         RT7bl9fRGe6ESAIYKh2p9dxlNx55ReD3tinqtpo8erKnxX3HKAIgYX7tTOnHvsW4/81H
         1wlk4ta7ZBs26daxIgVCo0LC1zckCUqBg4/YxiVxK3kJMLMN1mLjIId1tUzIApRM5GG5
         Ga0pFwBSgaO/SB+W4lgABi5k622J8AtCuiQTYHxysscgiulCPGY6NjiAEbWmQoqbhj89
         NvsA==
X-Forwarded-Encrypted: i=1; AJvYcCUFJMn3h9TCX6JmvKSknDX9+0Qw7wATMlzTPmpQVz/MCy+68nTMlIXPR81IiUNedntxY0M65iBvIYS7MYv+4g1EIllno6+GM8lvVBmVDuw=
X-Gm-Message-State: AOJu0YxRF7vrc241/QOTPPUry9vpqOUE10RFb5D/7ij8e2kjetuHOQgI
	4002wk+wIyBU5Qgk8NNk4gCELtd9q8aWreQWFEQHUii0iMlLquCu
X-Google-Smtp-Source: AGHT+IGjXRH5F+dHX9ZUzRhbiIaHxUXVqCoRgBDTO6Urq55bjKtulj+29cunN0oxXn0STaCgcU/MpA==
X-Received: by 2002:a05:6871:24d7:b0:24f:e599:9168 with SMTP id 586e51a60fabf-25e2b8d0139mr7038119fac.1.1720254526030;
        Sat, 06 Jul 2024 01:28:46 -0700 (PDT)
Received: from sean-ThinkPad-T450s.attlocal.net ([2600:1702:5083:7610:1e13:57ab:ecc5:1fd4])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-25e71070ba1sm10744fac.34.2024.07.06.01.28.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jul 2024 01:28:44 -0700 (PDT)
From: sean.wang@kernel.org
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	mingyen.hsieh@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v2 14/37] wifi: mt76: mt7925: add link handling in the BSS_CHANGED_PS handler
Date: Sat,  6 Jul 2024 01:27:54 -0700
Message-Id: <542ca29261af0cac007d2cb821ed36284d51c679.1720248331.git.sean.wang@kernel.org>
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
index 957e6bcaf9c1..938909ab8d1c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -1637,6 +1637,7 @@ static void mt7925_vif_cfg_changed(struct ieee80211_hw *hw,
 				   struct ieee80211_vif *vif,
 				   u64 changed)
 {
+	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
 	struct mt792x_dev *dev = mt792x_hw_dev(hw);
 
 	mt792x_mutex_acquire(dev);
@@ -1653,8 +1654,17 @@ static void mt7925_vif_cfg_changed(struct ieee80211_hw *hw,
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


