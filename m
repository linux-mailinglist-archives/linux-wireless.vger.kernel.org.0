Return-Path: <linux-wireless+bounces-9953-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D6A8926A97
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2024 23:43:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DE331C21819
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2024 21:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D32EF1922D9;
	Wed,  3 Jul 2024 21:43:19 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663CD194A61
	for <linux-wireless@vger.kernel.org>; Wed,  3 Jul 2024 21:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720042999; cv=none; b=CziAA1BZYzBVHav07i22ui1dmtpffW+CO5SsLQsSueEUxaTcqMkermOFMqwSIsNg6VMeaPKjl9wGSgV2bJZNGBuBg8H/h6d5UFSV0wfrjDQN46HVbVceNNoWstBx1lzy3aP+vRySvchgv+PuV6fj05qqoSDHD7BKVL55lv4V5qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720042999; c=relaxed/simple;
	bh=s3ixwMsyp7a2FAgbTEkcDhadNGLmDjJPv+VJNxcNjec=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cOUCbqi49urS3twqM861AxHMOSCIddGFDbbsKgdsgn2sDnwzU8DyFCHk7F5BccUKH7Tyq0wiesnNUxluI+4cn6YCyglNU06kBKV2V9ZleUHCyYVDFBDkYQrP5PChnEYEsZjAHtv5TaSYGCWR8j2AdWmyeFnT9SnG2QgjEdpNBtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-25e19ad0050so9218fac.0
        for <linux-wireless@vger.kernel.org>; Wed, 03 Jul 2024 14:43:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720042997; x=1720647797;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sDQgeUMdcNQThv6Pb9X0Ecyn9jvt1k59yxEbX8sQC7Q=;
        b=Gnko0Ktx/uZlMqLaKbf8ZUSpvnIwaq+c0yt6OGcR/zMmoPKzW3lLh4b5zCslXiF7U7
         yPV2Yngx7/ysYxcU0pXBRXAohUVTN2+GPNvm2zhcNiVZZLG3rjP4wQCfQ6RrQFFkF5Qd
         HPL277eOs4FUAqtx099BkJsGHqBucacAaJ7aW5MxT/gKxRmi3oQEXP33vXGPN8RL0lRE
         BwQ5CAiY3ktO7hZMap7M3Bnga26h1PG4+mVEMuPWg4NmXzk1ieiW1Rsq+GxpuLh0siKq
         /MgZV5IyFg5jpnHW4isqWm7CW83FA1OAfcRJfkjSMsxGI8mJjGYEyrjdd0SR144modGo
         l46g==
X-Forwarded-Encrypted: i=1; AJvYcCVxj3zJKVS7SRPuSFI8/rJwDtCUq7N4ooXYNeYURf0/m6msQUEcb2SbUhNkD23wHsXfVvzb2MM2OaFucCCTHiEGGmLIeHpkx21r3w4TseI=
X-Gm-Message-State: AOJu0Yx/62RHBhq2SR2gS9Flf9uPU13v4oWBx03mEF+Kv2XOePcONyHF
	Y7RXgj3XQ8LGr2OkzNcxauaSR0DiVoaRiKF56UC9yS5l7IQyR8Cp
X-Google-Smtp-Source: AGHT+IGyQO7IDv06Wu4jz/B8hpscCKFXRufWrE7Xm5ZF0rOGZnIDhXYzyXWDJbvg8U06ruakry8ojw==
X-Received: by 2002:a05:6870:8192:b0:24f:e599:9168 with SMTP id 586e51a60fabf-25db33732ffmr13537211fac.1.1720042997561;
        Wed, 03 Jul 2024 14:43:17 -0700 (PDT)
Received: from sean-ThinkPad-T450s.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-701f7b20953sm2111417a34.54.2024.07.03.14.43.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 14:43:15 -0700 (PDT)
From: sean.wang@kernel.org
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	mingyen.hsieh@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 13/29] wifi: mt76: mt7925: add link handling to mt7925_change_chanctx
Date: Wed,  3 Jul 2024 14:42:18 -0700
Message-Id: <88c5887954b04849adb0597d9a1ced7e976af897.1720042294.git.sean.wang@kernel.org>
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

add link handling to mt7925_change_chanctx

Co-developed-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Co-developed-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7925/main.c   | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index f85f7ea01f67..69849146610e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -1571,6 +1571,7 @@ mt7925_change_chanctx(struct ieee80211_hw *hw,
 {
 	struct mt792x_chanctx *mctx = (struct mt792x_chanctx *)ctx->drv_priv;
 	struct mt792x_phy *phy = mt792x_hw_phy(hw);
+	struct mt792x_bss_conf *mconf;
 	struct ieee80211_vif *vif;
 	struct mt792x_vif *mvif;
 
@@ -1585,7 +1586,22 @@ mt7925_change_chanctx(struct ieee80211_hw *hw,
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
 	mt792x_mutex_release(phy->dev);
 }
-- 
2.25.1


