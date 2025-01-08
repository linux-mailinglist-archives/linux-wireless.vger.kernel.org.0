Return-Path: <linux-wireless+bounces-17179-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 144B9A05094
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Jan 2025 03:25:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44D897A1634
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Jan 2025 02:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAEBE1632D9;
	Wed,  8 Jan 2025 02:25:21 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11BD315FD13
	for <linux-wireless@vger.kernel.org>; Wed,  8 Jan 2025 02:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736303121; cv=none; b=acMpFADp0wCtqy1eqgtN3Np8BC3u5DYc9Oz8pHOt5lIGu9OzpZQaIaQCR/kkRB+J/gAKAi7VcoLVq14iZCvgaLWRcdo8q2OU9vG+hAW5iltK9SSD95C56Cn08ZzKhP8dwXmWP8LjTlFrWulcoPIbcymcMX2ekKrgyjx6/DB5VK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736303121; c=relaxed/simple;
	bh=h215dTe9o1S+cb0jeevWHj//dg5y8VUwboCEN1SVWh8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BE2muoM/H1NhmU/xIEH0iTOJZu5SOLuLUmjnqC0YGt7htDGfO2SQmzjtLaVEM2BDh2/C7CSx0Qc849XabkYqYrZfk0E4uLxR4jOD/vVnHYDoaWQiPEV7ApfCvIsb1Y0KURrnoo9a2PKPR7hhvps5bHeiURKINlapwlH4GLMtWsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-29f7b5fbc9aso4785587fac.3
        for <linux-wireless@vger.kernel.org>; Tue, 07 Jan 2025 18:25:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736303118; x=1736907918;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5poZd8Omf8mHChDNYxqQRYDNiHz9Uqz2gbs5vpo4Wko=;
        b=RbY71BRN2k0/w70MZvYNaSa8zNIYMrMTARbr3mmXjjAPsQBKW/OpYsbMcz9yaS5Rjy
         qvWS+4KX8Ty+qGSxOew/xK/czPG35gMNddWorLlKhq0BiLTXX1Rd6LquSBOPzwrqQ+hy
         CFSF3cBiWV2NKGJPAPNynI3lL0c3ifPrD2X5aaV9xok2ZLoffu5+PZpiddN3GmzGvZFW
         CEwB3JvIoqG3YKAJfX/d3g1cqfBi9QjUNTML26XkT2XVx/gzBmPkzsKXfn4Lc/zO4Zg8
         6TfZ6oShIBdOYaaxpKFv8/OiNK6bImYFIOxuYnAmSjFLqCNO2yrxQ6lAkxBhMrBXDO7K
         0ZTQ==
X-Forwarded-Encrypted: i=1; AJvYcCXOOwMdFjlxNzxPgBbkpQb6rFs/KUmkJwJkwZdWz+Np0pe+etmwVMQ30dvoA7NLOSqqeXB5NvHwzsERh4oddw==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh1ID083j0xnEDXmyDKiJx3OczZT17NTE1N8xqK6F9Uzl03F1C
	EjkQFl0NhxRBHHddKr6Uao7DDps1wPZAkx/V9wWYRbY3KxBKOvss
X-Gm-Gg: ASbGncvMO9sGqTkF4agLdW+4M0vPW/1MM+dWPu1sTt9NE8bdwQG9PEo7OEt8HOTRrkE
	uBelV9TB7ezmCmH/XM6kaSv7hwhpx5xEBaqeoLRx/QmiXrYK1mZzJ+oYG61mQfLPjGgRKU4mA9S
	KElgdrBFNIg8pGhckhXkg4EvN9QSwpD0hna8d1iubVaibTI+LBEnL0oZlZdm2WL/QXfRRpqiLuK
	5KTQgOWTEhqR4LlEKzCA2vRUt9b/aGkAucnkESBfKX5yb5AnV8u42v6RtGxEXm0NkcXTb0TZg==
X-Google-Smtp-Source: AGHT+IG1BSmYd4o29NQKBDCMXyMov8UepAnYwvWRgzA22SOmjxDtFJ2VtJgIvbRKdY+vAbn4xOmQhA==
X-Received: by 2002:a05:6871:800f:b0:29e:3701:47c3 with SMTP id 586e51a60fabf-2aa069c550fmr609205fac.42.1736303118142;
        Tue, 07 Jan 2025 18:25:18 -0800 (PST)
Received: from sean-ThinkPad-T450s.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2a7d77f6340sm13072862fac.48.2025.01.07.18.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 18:25:16 -0800 (PST)
From: sean.wang@kernel.org
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	mingyen.hsieh@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 2/6] wifi: mt76: mt7925: fix the wrong link_idx when has p2p_device
Date: Tue,  7 Jan 2025 18:25:05 -0800
Message-Id: <20250108022509.217803-2-sean.wang@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250108022509.217803-1-sean.wang@kernel.org>
References: <20250108022509.217803-1-sean.wang@kernel.org>
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
 drivers/net/wireless/mediatek/mt76/mt76.h          |  1 +
 .../net/wireless/mediatek/mt76/mt76_connac_mcu.c   |  4 ++--
 drivers/net/wireless/mediatek/mt76/mt7925/main.c   | 14 ++++++++++----
 3 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 34b6b094b8eb..a131d671ed56 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -756,6 +756,7 @@ struct mt76_testmode_data {
 
 struct mt76_vif {
 	u8 idx;
+	u8 link_idx;
 	u8 omac_idx;
 	u8 band_idx;
 	u8 wmm_idx;
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index 4171710d645c..f95ae7a2eb0e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -1164,7 +1164,7 @@ int mt76_connac_mcu_uni_add_dev(struct mt76_phy *phy,
 			.tag = cpu_to_le16(DEV_INFO_ACTIVE),
 			.len = cpu_to_le16(sizeof(struct req_tlv)),
 			.active = enable,
-			.link_idx = mvif->idx,
+			.link_idx = mvif->link_idx,
 		},
 	};
 	struct {
@@ -1187,7 +1187,7 @@ int mt76_connac_mcu_uni_add_dev(struct mt76_phy *phy,
 			.bmc_tx_wlan_idx = cpu_to_le16(wcid->idx),
 			.sta_idx = cpu_to_le16(wcid->idx),
 			.conn_state = 1,
-			.link_idx = mvif->idx,
+			.link_idx = mvif->link_idx,
 		},
 	};
 	int err, idx, cmd, len;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index 0904d8f109b3..6c8a9ebfbe5b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -356,10 +356,15 @@ static int mt7925_mac_link_bss_add(struct mt792x_dev *dev,
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
@@ -367,6 +372,7 @@ static int mt7925_mac_link_bss_add(struct mt792x_dev *dev,
 	mconf->mt76.band_idx = 0xff;
 	mconf->mt76.wmm_idx = ieee80211_vif_is_mld(vif) ?
 			      0 : mconf->mt76.idx % MT76_CONNAC_MAX_WMM_SETS;
+	mconf->mt76.link_idx = hweight16(mvif->valid_links);
 
 	if (mvif->phy->mt76->chandef.chan->band != NL80211_BAND_2GHZ)
 		mconf->mt76.basic_rates_idx = MT792x_BASIC_RATES_TBL + 4;
-- 
2.25.1


