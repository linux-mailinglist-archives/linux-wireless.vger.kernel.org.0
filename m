Return-Path: <linux-wireless+bounces-17464-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B76CBA0FE75
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jan 2025 03:07:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C37CE188924E
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jan 2025 02:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BA00230269;
	Tue, 14 Jan 2025 02:07:24 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C5E3595A
	for <linux-wireless@vger.kernel.org>; Tue, 14 Jan 2025 02:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736820444; cv=none; b=FaJQPiu6hNNWU489wlwngukgbfY9EXdhF3HdKevdFQd4L3dy1eY3+hBP/gs7Dtf8nID5tTr0Jn7SpDSkE/C4YyEeaJ2k9nzJ4zupGRgRPSYr6LWu64tGFZ7Clhxgzs3FBWBAWjGZTPRD9K7u/cTd8qUUgR6r7lpb24fo2EJq2R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736820444; c=relaxed/simple;
	bh=TerTb66Xzt9NyRBG/CthhfVJrp8N9Maabg7tHY2QzKU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iW1D+2KoAUlIfiKVWThEpPEqEhxCrtUd5i34yXRHgL1FKBYsbpfTZ/Q0GtfcXeVXCILX8uQ/feMOw3ot1/P5vkHwbzFTsEc9ZvszhFjDNicDgDoHIOKA77H7AhRtV7+7uP6ZjUEJ4aMUTfXytrwifLTsSIGozh/y5trPznRFIPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-71e1e051e50so1334722a34.0
        for <linux-wireless@vger.kernel.org>; Mon, 13 Jan 2025 18:07:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736820441; x=1737425241;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YtFuvbzeBTNVOBWO3ySJleq1Z7QhqifLZ+UmNMZ8jrQ=;
        b=mKRdGKBW98ob8DiBzF9ArF0D1sQIPu631UGy+Xs467y2KMCICejwbcBcI5cVQ3l7W1
         RVRfZiSLKNqSOmSXHAsgXoTSBoPs0utpFI0wxVnHnbAXoPdPPtTkrdvz8YGjK789drCR
         YoMw6Z7VrYZy1SMyOeNumAtBQgmn7HgaXL2fpAvTSYiLG7uWabkAMt5jy9iUPZsunGIs
         Fhz3XqV80eiAD09PdWo6WU3J/VehYh/9tGln+4219adx6tgEgSQgM/SMVs3pqzyOWUYQ
         8ybnJEkUEcaE/CbGs4Es4MDcgxHriGWMGmejJXV3h8S+s4E7JfVLXFUQBV8ngh1ubrVP
         C4PA==
X-Forwarded-Encrypted: i=1; AJvYcCXGwvJutxg6TTYGWJ0Jj/1m/+fPOu7T5kdz47SZizBmC6pbAEfpFLE+ZgudnnzscgjZBfUt/G6Nkz1+x4NeRw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwnoQ6hGNu0Y3dTO3A5cik/fhRJByOdPsBAwfLwmtyyTq+ZCt5D
	+2tiVbQqv+9fQ8Ppl+Un5qyTf2m2AuHYvjYqNdbMw0MSeLkuMZnX
X-Gm-Gg: ASbGncsbSgJpL1ID1e7Ft/GLyiNuqgVxYfs82VaZzY+El6Mha2HmO3DQEDjcBfqhK6X
	5+wYt3FeEjVz2WyN+UOnUHZ60/SxOHnQQyR+OI34UQ3AhHFbVZw2ATFSoZ8wagtpcizqs8OgOop
	cClJiUt2HxCHGvmRAEz6T7lOAC8IA1nH5wJxaJTCZYIUp7Ll0pmftwnG2PBLx3UZNyOS0lfVy8R
	AawdzOuP6Fc0JteH2FT6/iKTN7Yu3kcdiqLV0XxAlWNACpEKzOXirLYSw8WIHU7EEUBsveMIw==
X-Google-Smtp-Source: AGHT+IHd5Kld9d0+YVuyqDqLcd2oa2ia62Q6ta0zrOvMzrIgUFpRMWwtfoHQSwdMtTatTt9OkenVdA==
X-Received: by 2002:a05:6830:61c2:b0:71d:5f22:aff5 with SMTP id 46e09a7af769-721e2e23192mr15792855a34.10.1736820441541;
        Mon, 13 Jan 2025 18:07:21 -0800 (PST)
Received: from sean-ThinkPad-T450s.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5f882755172sm3915340eaf.27.2025.01.13.18.07.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 18:07:20 -0800 (PST)
From: sean.wang@kernel.org
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	mingyen.hsieh@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v2 2/6] wifi: mt76: mt7925: fix the wrong link_idx when has p2p_device
Date: Mon, 13 Jan 2025 18:07:08 -0800
Message-Id: <20250114020712.704254-2-sean.wang@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250114020712.704254-1-sean.wang@kernel.org>
References: <20250114020712.704254-1-sean.wang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>

When the p2p device and MLO station concurrent, the p2p device
will occupy the wrong link_idx when the MLO secondary link is added.

Fixes: e38a82d25b08 ("wifi: mt76: connac: Extend mt76_connac_mcu_uni_add_dev for MLO")
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
v2: generate the patch based on the latest mt76 tree
---
 drivers/net/wireless/mediatek/mt76/mt76.h          |  1 +
 .../net/wireless/mediatek/mt76/mt76_connac_mcu.c   |  4 ++--
 drivers/net/wireless/mediatek/mt76/mt7925/main.c   | 14 ++++++++++----
 3 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 132148f7b107..05651efb549e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -769,6 +769,7 @@ struct mt76_testmode_data {
 
 struct mt76_vif_link {
 	u8 idx;
+	u8 link_idx;
 	u8 omac_idx;
 	u8 band_idx;
 	u8 wmm_idx;
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index f30cf9e71610..d0e49d68c5db 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -1168,7 +1168,7 @@ int mt76_connac_mcu_uni_add_dev(struct mt76_phy *phy,
 			.tag = cpu_to_le16(DEV_INFO_ACTIVE),
 			.len = cpu_to_le16(sizeof(struct req_tlv)),
 			.active = enable,
-			.link_idx = mvif->idx,
+			.link_idx = mvif->link_idx,
 		},
 	};
 	struct {
@@ -1191,7 +1191,7 @@ int mt76_connac_mcu_uni_add_dev(struct mt76_phy *phy,
 			.bmc_tx_wlan_idx = cpu_to_le16(wcid->idx),
 			.sta_idx = cpu_to_le16(wcid->idx),
 			.conn_state = 1,
-			.link_idx = mvif->idx,
+			.link_idx = mvif->link_idx,
 		},
 	};
 	int err, idx, cmd, len;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index 2082e3904d76..502b76a40ca8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -360,10 +360,15 @@ static int mt7925_mac_link_bss_add(struct mt792x_dev *dev,
 	struct mt76_txq *mtxq;
 	int idx, ret = 0;
 
-	mconf->mt76.idx = __ffs64(~dev->mt76.vif_mask);
-	if (mconf->mt76.idx >= MT792x_MAX_INTERFACES) {
-		ret = -ENOSPC;
-		goto out;
+	if (vif->type == NL80211_IFTYPE_P2P_DEVICE) {
+		mconf->mt76.idx = MT792x_MAX_INTERFACES;
+	} else {
+		mconf->mt76.idx = __ffs64(~dev->mt76.vif_mask);
+
+		if (mconf->mt76.idx >= MT792x_MAX_INTERFACES) {
+			ret = -ENOSPC;
+			goto out;
+		}
 	}
 
 	mconf->mt76.omac_idx = ieee80211_vif_is_mld(vif) ?
@@ -371,6 +376,7 @@ static int mt7925_mac_link_bss_add(struct mt792x_dev *dev,
 	mconf->mt76.band_idx = 0xff;
 	mconf->mt76.wmm_idx = ieee80211_vif_is_mld(vif) ?
 			      0 : mconf->mt76.idx % MT76_CONNAC_MAX_WMM_SETS;
+	mconf->mt76.link_idx = hweight16(mvif->valid_links);
 
 	if (mvif->phy->mt76->chandef.chan->band != NL80211_BAND_2GHZ)
 		mconf->mt76.basic_rates_idx = MT792x_BASIC_RATES_TBL + 4;
-- 
2.25.1


