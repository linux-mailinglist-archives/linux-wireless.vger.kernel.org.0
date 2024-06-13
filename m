Return-Path: <linux-wireless+bounces-8930-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E80AE90624E
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2024 05:04:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E426C1C212B0
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2024 03:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A6D412D76B;
	Thu, 13 Jun 2024 03:03:31 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2538C12D1F4
	for <linux-wireless@vger.kernel.org>; Thu, 13 Jun 2024 03:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718247811; cv=none; b=h0q86vOLH2V/wxAAwOc8Y87ksNb42f/uK9YT8Gwz/t8j17KDCYEp5utj7QbeDa/t6FsUTvzUuh+v1pBYDphzaNI4Z8+qC29hwwL501ULdUYu+8LqIYnxvjmtnloACH2Q8HhArdgwyX+73LuLI0J9+IXHW++b4QoF9+YuiJBxnm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718247811; c=relaxed/simple;
	bh=tqCCHQ1yus6v/4nNyCgMRddX6uhCS5xX0G14EQ/5/xQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aqPcqyZtgV7nuQCapoP87JezmetzE8qagjN/1lcN8q4HoWo/abcNpODoaKeY3pm8t1AkmNi0Bc5IeMuwMFFur3JMr2p2GYm2aj5HdoFrz21pxzHH0X7V0gKRheuxjNjgrQJClDcDG/scNbLKnyfhVGFLUYZoc8B0BSfiQIRxyzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5bad97708efso31441eaf.1
        for <linux-wireless@vger.kernel.org>; Wed, 12 Jun 2024 20:03:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718247809; x=1718852609;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v5C4HXZ5Qn+NC0fHMwJmteg0sATZeShS/Ir1vuk6irI=;
        b=oa3jLzrNUU3opLr3m6YgFXfYf/WBgxPjQNSTccKPjvoQrixUhTtb83Cr9RfxgT+36V
         Pdeu2su2ih+vrp0+7pj8OJn5lU54mway4Cff9Z8xaLOc6R6GZr/i0qRZ+YPx3Im80b/s
         7RXU4pB4iu9iaCdAhTOeWaDxkCButBG+IdCQ5U1IHyhymAStyqNJoXwWhSkfJsCGoFYn
         yuTUT/YwxB8KcjN+pKeZWgiaiW1P6lNSkJo4ywEd7VxdE7W6pFECAloaRg9T4PkdvMRO
         0jP5hO3Uzd4OSauAlGftkyKxafeJGZd2Y+7JsIUX3TcnlCsXszVx9efvh88Xp/dLMY2e
         ojtQ==
X-Forwarded-Encrypted: i=1; AJvYcCW17FQ6pK4ZDKlLFZN/SYKEV9fHn6Q1CvzO/UE653d/EH0AixuDoRFfmgGwCV+yv8w/ZRWCZl51PTGvTQ8V56eY4esQAubdK82dZc2qg+g=
X-Gm-Message-State: AOJu0YwTY+2O1d/jLUGhv/hIwPGUlKkzDNbddcbj41ukhiBj9Ed54m+T
	BdjrqNTEKBQ3TUMxuiMSpQkOf7/OeHc+7hV+kc0rplukpjMIQms7
X-Google-Smtp-Source: AGHT+IEe4P0VHMNgBu8piViehq/J0PqaKqHtNs+BhhWQq35+u9yyXiLnME99TrmCwao0gjU3BjWkig==
X-Received: by 2002:a4a:a5ca:0:b0:5ba:e11d:a2ae with SMTP id 006d021491bc7-5bb3b9f4ef7mr3671748eaf.1.1718247809367;
        Wed, 12 Jun 2024 20:03:29 -0700 (PDT)
Received: from sean-ThinkPad-T450s.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5bd629263c5sm67685eaf.46.2024.06.12.20.03.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 20:03:28 -0700 (PDT)
From: sean.wang@kernel.org
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	mingyen.hsieh@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 20/47] wifi: mt76: mt7925: extend mt7925_mcu_uni_bss_bcnft for per-link BSS
Date: Wed, 12 Jun 2024 20:02:14 -0700
Message-Id: <20240613030241.5771-21-sean.wang@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240613030241.5771-1-sean.wang@kernel.org>
References: <20240613030241.5771-1-sean.wang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Wang <sean.wang@mediatek.com>

Extend mt7925_mcu_uni_bss_bcnft with per-link BSS configuration.

The patch we created is a prerequisite to enable the MLO function in the
driver. It is purely a refactoring patch so the functionality should
remain unchanged.

Co-developed-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index a40ad1578212..8950df09a025 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -1281,10 +1281,10 @@ int mt7925_mcu_uni_bss_ps(struct mt792x_dev *dev, struct ieee80211_vif *vif)
 }
 
 static int
-mt7925_mcu_uni_bss_bcnft(struct mt792x_dev *dev, struct ieee80211_vif *vif,
-			 bool enable)
+mt7925_mcu_uni_bss_bcnft(struct mt792x_dev *dev,
+			 struct ieee80211_bss_conf *link_conf, bool enable)
 {
-	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
+	struct mt792x_bss_conf *mconf = mt792x_link_conf_to_mconf(link_conf);
 	struct {
 		struct {
 			u8 bss_idx;
@@ -1301,17 +1301,17 @@ mt7925_mcu_uni_bss_bcnft(struct mt792x_dev *dev, struct ieee80211_vif *vif,
 		} __packed bcnft;
 	} __packed bcnft_req = {
 		.hdr = {
-			.bss_idx = mvif->bss_conf.mt76.idx,
+			.bss_idx = mconf->mt76.idx,
 		},
 		.bcnft = {
 			.tag = cpu_to_le16(UNI_BSS_INFO_BCNFT),
 			.len = cpu_to_le16(sizeof(struct bcnft_tlv)),
-			.bcn_interval = cpu_to_le16(vif->bss_conf.beacon_int),
-			.dtim_period = vif->bss_conf.dtim_period,
+			.bcn_interval = cpu_to_le16(link_conf->beacon_int),
+			.dtim_period = link_conf->dtim_period,
 		},
 	};
 
-	if (vif->type != NL80211_IFTYPE_STATION)
+	if (link_conf->vif->type != NL80211_IFTYPE_STATION)
 		return 0;
 
 	return mt76_mcu_send_msg(&dev->mt76, MCU_UNI_CMD(BSS_INFO_UPDATE),
@@ -1685,7 +1685,7 @@ int mt7925_mcu_set_beacon_filter(struct mt792x_dev *dev,
 	int err = 0;
 
 	if (enable) {
-		err = mt7925_mcu_uni_bss_bcnft(dev, vif, true);
+		err = mt7925_mcu_uni_bss_bcnft(dev, &vif->bss_conf, true);
 		if (err)
 			return err;
 
-- 
2.34.1


