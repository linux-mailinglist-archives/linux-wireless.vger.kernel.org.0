Return-Path: <linux-wireless+bounces-25694-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 429C7B0B986
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Jul 2025 02:20:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6772A174FEF
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Jul 2025 00:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA22F7A13A;
	Mon, 21 Jul 2025 00:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mX9EChBP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351676F06A
	for <linux-wireless@vger.kernel.org>; Mon, 21 Jul 2025 00:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753057220; cv=none; b=Igh6003mXRRyO1qxYluDTdarKfBBkaubs66U8bJcXM1nRqSvUU1qdXaIOHky3P0oSwU960QzSxEcy8U93MH3HezWai5Q8iCpK2dOp43f+6DJqOrvMHoTj9mUbeYQqa323sMH3JNlY/nlyNzjxQnaFMcrtBCicf0CrIYhjlRXSmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753057220; c=relaxed/simple;
	bh=BSh4qDJLmujs5nU39uUszbNvVWSXxmvzkD7laJ+HSNU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oBcnCjjf4UYQMj7KEWUrjnGHpLgHKRXbuWKCisxRJ1uMEnRbkaWi5kySbHUGHpSte8duygzgM/rwunOMoVD533Q8ymgzKfkWMmOSOQqCVnS9kvJ7Q0LJqeb6MWYoHnyz+xKB+DnrxQdxZ/cSTxxeYxoyPXOy36iGztBflppK3hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mX9EChBP; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-74801bc6dc5so3622175b3a.1
        for <linux-wireless@vger.kernel.org>; Sun, 20 Jul 2025 17:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753057218; x=1753662018; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kz6iK4y7rMGjgRpe7+E3ASwwwOelrLt3Jf6kfxH3buo=;
        b=mX9EChBPmn8gGwGKPvlEYoUn8FD7oDZdnRm7VmzQEy3U0ThWEHVo/8rFWQ9KJ6jQDB
         Tuf3FQN8XQ8VEYogVGf8KkzkpFVHDKF1SS7OaFuF18BXtMSOxoMcAziG2edKN4jaPH+4
         +C7OCBZUN3BKVzJcS5fcwuVKljEg45KNlLS+xnJGImzSnnJkirlLT311Y1vTqkTn35Yx
         +h98nNcCeRJP3T3pC1a406baAHY8yzgWJHG8mU+zU/+ep6b9nP9qF4mx5LcFqpWTjHaL
         OKuRKfsdHs/7JIbpSZh0aU4HNaWjmk2kNTZnfNUvHNWxQbGacNsohIJFp1WiI/qgioOf
         3U5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753057218; x=1753662018;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kz6iK4y7rMGjgRpe7+E3ASwwwOelrLt3Jf6kfxH3buo=;
        b=lMw6+yKprBDa6nrOzlYRzme+wdfR9OfETsfEBk3vUxLAQcvA8iaT0+kksneq9ez+ZV
         nVsvRwR1kjODokYa2R/j82IpSGi/gyQwI6nRid+DkWXCWx2UD3jQAXoVBrTbe96qHfdT
         AKdCcX2fmNl2dp3Cd4rd/rOyAfFMAMTV8tffYYFHHLfJ61H+kbJ3PS2Yu4lyulKdjf79
         dEWWrp6bteL4HZyN0c1Cn48xm9JzLHyNG0yXVRt1Aoz8fgCcFfmvgvWSoQqxP9Ix+JAJ
         D2iP1K1q4qkHnxYATD3QoYlKKIxUY9lPZQE/m5i0hFNnP0NqTTG7GZStggVDjnipf8ek
         o3yw==
X-Gm-Message-State: AOJu0YwOcYZ7jV3FpuClf5kf/LLzJQ1dlUrrNO6hv0cT0E4JTv6Op6eZ
	8NhunGB433vU/n/RAD7gT05b85Dd9mXHGodfe3ol/GFmHNXmVr23ElpbtobwXr3L
X-Gm-Gg: ASbGncvvNY6RrppIYcSWGKnEpf9lXr0T00hqgtxO4cDJcY5MrhwPIkKhqZNempLEJiJ
	K2S5bJ8APsH3LOecNM+s097owu9XTACZnm1t0W1tcnvRUaKSnKR4RF6ONIHrUjZlDhIC2deojm5
	LRzTyOlHW3RNBNcVUL7v44o7RzBFa6b06Efgf4de3/WZp9OESN+q5GoWKDqkaqASImjf2Lp1i7z
	PCD0fOvPmM2myXFwl9SEpkxAPdl+89X/8tMHlooZ92279WgQLxGPQ6S+8nlxgipCbcKiFd/8Hkk
	OH7A0rFs5v1z6FO3e07qVYun0cnkmdFdFHNxN7O+wmZSUHpraAldvnPZ8QTYtVPXMLxeK+k1Hrr
	UCS5F/lKKBhdnrYpxvQxQHL8nJl14yWoDOhYP1lli4VKj396BOUTstWmz+GHITcwD4DKM9YuG66
	4=
X-Google-Smtp-Source: AGHT+IHfQ0EUJNKRxWZhn6f856hoCSgKLC9lNEg38AN9Z+vYGpx0qP4NV5PR+ZsSqbb0q3+ezZqPQw==
X-Received: by 2002:a05:6a00:4991:b0:742:b928:59cb with SMTP id d2e1a72fcca58-75969abdfb9mr9625504b3a.7.1753057218179;
        Sun, 20 Jul 2025 17:20:18 -0700 (PDT)
Received: from localhost.localdomain (syn-172-119-055-184.res.spectrum.com. [172.119.55.184])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759cb76d53fsm4661058b3a.105.2025.07.20.17.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Jul 2025 17:20:17 -0700 (PDT)
From: tnguy3333 <tnguy3333@gmail.com>
To: linux-wireless@vger.kernel.org,
	nbd@nbd.name,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com
Cc: shayne.chen@mediatek.com,
	sean.wang@mediatek.com,
	tnguy3333 <tnguy3333@gmail.com>
Subject: [PATCH 4/5] set fw download mode like mt7921
Date: Sun, 20 Jul 2025 17:19:04 -0700
Message-Id: <20250721001905.11614-5-tnguy3333@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250721001905.11614-1-tnguy3333@gmail.com>
References: <20250721001905.11614-1-tnguy3333@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ensure the proper download mode and encrypt flag is set so firmware can download, fixes "failed to start WM firmware" error

Signed-off-by: tnguy3333 <tnguy3333@gmail.com>
---
 drivers/net/wireless/mediatek/mt76/mt76_connac.h     | 5 +++++
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c | 3 ++-
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h | 2 +-
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac.h b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
index 192dcc374..792517426 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
@@ -172,6 +172,11 @@ struct mt76_connac_tx_free {
 
 extern const struct wiphy_wowlan_support mt76_connac_wowlan_support;
 
+static inline bool is_mt7902(struct mt76_dev *dev)
+{
+	return mt76_chip(dev) == 0x7902;
+}
+
 static inline bool is_mt7925(struct mt76_dev *dev)
 {
 	return mt76_chip(dev) == 0x7925;
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index 16db0f208..ee127b74e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -65,6 +65,7 @@ int mt76_connac_mcu_init_download(struct mt76_dev *dev, u32 addr, u32 len,
 	int cmd;
 
 	if ((!is_connac_v1(dev) && addr == MCU_PATCH_ADDRESS) ||
+	    (is_mt7902(dev) && addr == 0x900000) ||
 	    (is_mt7921(dev) && addr == 0x900000) ||
 	    (is_mt7925(dev) && (addr == 0x900000 || addr == 0xe0002800)) ||
 	    (is_mt799x(dev) && addr == 0x900000))
@@ -3047,7 +3048,7 @@ static u32 mt76_connac2_get_data_mode(struct mt76_dev *dev, u32 info)
 {
 	u32 mode = DL_MODE_NEED_RSP;
 
-	if ((!is_mt7921(dev) && !is_mt7925(dev)) || info == PATCH_SEC_NOT_SUPPORT)
+	if ((!is_mt7921(dev) && !is_mt7925(dev) && !is_mt7902(dev)) || info == PATCH_SEC_NOT_SUPPORT)
 		return mode;
 
 	switch (FIELD_GET(PATCH_SEC_ENC_TYPE_MASK, info)) {
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index 27daf4195..eebdfaca3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -1863,7 +1863,7 @@ mt76_connac_mcu_gen_dl_mode(struct mt76_dev *dev, u8 feature_set, bool is_wa)
 
 	ret |= feature_set & FW_FEATURE_SET_ENCRYPT ?
 	       DL_MODE_ENCRYPT | DL_MODE_RESET_SEC_IV : 0;
-	if (is_mt7921(dev) || is_mt7925(dev))
+	if (is_mt7921(dev) || is_mt7925(dev) || is_mt7902(dev))
 		ret |= feature_set & FW_FEATURE_ENCRY_MODE ?
 		       DL_CONFIG_ENCRY_MODE_SEL : 0;
 	ret |= FIELD_PREP(DL_MODE_KEY_IDX,
-- 
2.39.5


