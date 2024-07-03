Return-Path: <linux-wireless+bounces-9955-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D2F2926A99
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2024 23:44:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDFEDB25890
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2024 21:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B7BA19306C;
	Wed,  3 Jul 2024 21:43:23 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1894194A6F
	for <linux-wireless@vger.kernel.org>; Wed,  3 Jul 2024 21:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720043003; cv=none; b=Oqpvu04mJsz0Owjkffse5TFqty2X84Kgeic+jyEMK99zNynkhj/TV2w0DcE+GAtUfbxJLtGNxjJJzD6fJT5+KE2yhF3z6W/TAOUyFMEerzGGaEyvDSWUTVj67d5Cfz8dLSzoRd9P4TtBbX5yKM0UXN8jB9v1CfBGzMncBIkWp6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720043003; c=relaxed/simple;
	bh=EzlE5/SzFEcmDWIHzYqdvmSuQcohgHQ3wheoXk8/Q0o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dW64voi3l1DuSsifa+mX+zi+ZxJAvv7VuahaMbPOvV9+0J8iwdIBF8FY7+agqtGkET37LbeC6mXTJRiJH8l3kjASuQrCHdZRpaZD1wMEx85vDxwYQx6wgxg7r3eOy+wq3hnIfa7FMS+4XybXNB6TLgicH06gWcs6NlxjJUuLdWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-700ca24a8ebso117340a34.0
        for <linux-wireless@vger.kernel.org>; Wed, 03 Jul 2024 14:43:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720043001; x=1720647801;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=peHtFkucpkPBpD5rHx4xIXV2z8XQ+Jk1EN6IvhoGfSo=;
        b=iDd00a/XhacOA+XXvLYfTn1/szGTV6yM4r2DSYqCmxH0DrZ74wz1yAMudI2IvgnY8z
         mDXt/4Njix5HQn16K+1iAWacWSv1wYLJCWRozEdtZOwCd1lDNBiaP/RqaALbe773fpdC
         xBCxp2syaNdp/G/ej6I1oRFBDMMhUpPFvDmYisfbjHac9+PT7Z4H64+f0nsXpNx9iAxt
         lCzBH8HBKB0pEhXAuIK2/A2b5pxKOlZxkOvwGsRX5OiZheQOZEN4WKXqbSpFCRie5C4w
         6LmqEjhjx/5y+KAGAkELU9vdWfItszfG18eLE1SkH4zv7rhEMXZl3LWuh3vct2pOf1pm
         B2lQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvHzPRRYYGsHOHFLFGvV3wOoajgUyw7FYun1yGSXDLUrNFaRSSm+5UdUGuKpQ0gYIm9ua2WLEHnp7hsEZnOkQAQA/vll/cPCpnj7pka0g=
X-Gm-Message-State: AOJu0YxpOO+dFvNv2iKTqpdf7xRcRcDxHC/kL3x7ValUWuI8r22/lz3b
	2IFgvprN7g/aZ+3iyXddKv/i8iEAQIPZy+p6JAIXUzsaNkn4jRPX59LoOOPK
X-Google-Smtp-Source: AGHT+IEqzeo8RoR6l2yEjD7P2xm5c7YuPu83j3lo5/VHbBcEZ6c8yqDGnp7kWYGmbvaY1rl3PlnIew==
X-Received: by 2002:a05:6830:68cd:b0:700:d697:6ca7 with SMTP id 46e09a7af769-70207554355mr12585180a34.0.1720043000855;
        Wed, 03 Jul 2024 14:43:20 -0700 (PDT)
Received: from sean-ThinkPad-T450s.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-701f7b20953sm2111417a34.54.2024.07.03.14.43.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 14:43:19 -0700 (PDT)
From: sean.wang@kernel.org
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	mingyen.hsieh@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 15/29] wifi: mt76: mt7925: add link handling in mt7925_mcu_set_beacon_filter
Date: Wed,  3 Jul 2024 14:42:20 -0700
Message-Id: <c0f8c37379b48e481652739484b746a434548737.1720042294.git.sean.wang@kernel.org>
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

add link handling in mt7925_mcu_set_beacon_filter

Co-developed-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Co-developed-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index b62153671350..cf0377d26752 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -1814,11 +1814,20 @@ int mt7925_mcu_set_beacon_filter(struct mt792x_dev *dev,
 #define MT7925_FIF_BIT_CLR		BIT(1)
 #define MT7925_FIF_BIT_SET		BIT(0)
 	int err = 0;
+	int i;
 
 	if (enable) {
-		err = mt7925_mcu_uni_bss_bcnft(dev, &vif->bss_conf, true);
-		if (err)
-			return err;
+		struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
+		unsigned long valid = ieee80211_vif_is_mld(vif) ?
+				      mvif->valid_links : BIT(0);
+		struct ieee80211_bss_conf *bss_conf;
+
+		for_each_set_bit(i, &valid, IEEE80211_MLD_MAX_NUM_LINKS) {
+			bss_conf = mt792x_vif_to_bss_conf(vif, i);
+			err = mt7925_mcu_uni_bss_bcnft(dev, bss_conf, true);
+			if (err < 0)
+				return err;
+		}
 
 		return mt7925_mcu_set_rxfilter(dev, 0,
 					       MT7925_FIF_BIT_SET,
-- 
2.25.1


