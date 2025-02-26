Return-Path: <linux-wireless+bounces-19454-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29AB0A45377
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Feb 2025 03:57:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CDC61775D3
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Feb 2025 02:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3408021C183;
	Wed, 26 Feb 2025 02:56:58 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B022AE7F;
	Wed, 26 Feb 2025 02:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740538618; cv=none; b=mlMpLPCQCNTg30yMEKyNWy2U/u80b2V4ucX3051LH/1rEr7w97y+J9+4Fux1OznA/l/7qBUly5pZ3jvlSksIYNPC4E7tkYcD2FFqHJvD7hCH76c+kqLttf4MpfjPBOUEKZioW4lEkiyuYoPv+dgUzACJ+2816CEbuEpwYiQ0ThU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740538618; c=relaxed/simple;
	bh=3KH/fDA0ez5xh/in3CQyjrV/0wNYSTW1hZjSjGjkkV0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lOP9bkIf4fF+cQjg8AZ8ICGiWzJgmRhT6OZJLwrrY55fGgheNlNjX75QjNmuSbL9NIpnPl0SHJ0upPngSJDklRydyfYo8CclDqKIxdUVPUi5yt2y8WvkhNQL/DM9NBz7yxvDrP9ccRwxyH8V7OzEfABGaHvBYKWd9CzNnwXXa1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-72737740673so2789632a34.3;
        Tue, 25 Feb 2025 18:56:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740538616; x=1741143416;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ijn9Zs6TtjyptoPH/X9sgnzFhdzKOSXw5uRjIenFZHg=;
        b=qIa641CcikFPHLB2o96cTd8rby0eoTde8TtVqfY5c9VhQkCG4zjVa/gSvPlWKacTZO
         ugqmfloCUIESsEwZNheskhQfmsX193XjfVRiRuKxhP+mszCfenv87l89sWtmazj1zbeD
         1i4aij5b6Tt2wc7wyVEv0OcNWTc79SEGEg4Ax9pb/dMJH07FwFmqC7Z50kTS7d/rJljy
         9YPmenHKiq7IjN6Ydjgsz5SqnNB60RUqmh+u9syhDQQgo2WbIP/bLzy+iz75yihwx/mm
         Snf5gMZGUZDcx5sAds9QtFnyoQ6IoNRQbtP6CXgQeZLKuvD9COIzTp0pGlK8nvO3nLau
         MkCw==
X-Forwarded-Encrypted: i=1; AJvYcCWezsS5e7U5bG0kBVFwENNSl15QrCg3jdDOO0d3rXC7+UYbpuj+n0FBs7NyvyzHtpbMDLkeD1xI@vger.kernel.org, AJvYcCXWEJBj6RNoEIZTbjmm65D1eNbCNvuukdUD0NwmqQ29N2peoQzAG+URPOF18uhbOQ8iV9AtOaBbQJIWZsJtcw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzRxd7ISC5JnHzeIGeAONTWctiYE9nubQrTnGmbDjp4dWSsSWd7
	UwlBiaDCXBHMTqFYFs783e9BT5/oC3yAsjx3O38IWquN3qq97Nkc
X-Gm-Gg: ASbGncut3i4sXW2GFWAf8dYI2IRSad4T6m+Y+hfNm2VQsequY6EK2Z31Deh1LftIB8u
	wfINUp25gsbLrZ513dX4Eiq3+tdmF5ueSl8m3b6HD5AtFdNkf7QOMhOPed2BeHjZxQfXTevaUmk
	Fco0lKef4svHjamds1qt4+pi0dCyKxuiKTnaI6MrpxLZezuwRjMrpwKN3z04wKVcsCyfCJVrWFE
	g41kCI/917GkL69kcm+4RJ311SLAljHx89ONi3vbad3h1ofcGwpYntwmH1SVGlT+JlF3dtG/wcr
	FS0625TyO9A/z0qvP5hpwgwkBxI9KC5iSOKfQZYY6sU=
X-Google-Smtp-Source: AGHT+IH/v3xoOO5kFnmYW8uOZZ7ilJPTZbKGNYJW6EP3vASjM841Y2AYzpuzLLNxk+lzIh/mqbbErQ==
X-Received: by 2002:a05:6830:412a:b0:727:2ff3:e046 with SMTP id 46e09a7af769-728a521c06dmr1013357a34.22.1740538615741;
        Tue, 25 Feb 2025 18:56:55 -0800 (PST)
Received: from sean-ThinkPad-T450s.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2c1113f0135sm676360fac.27.2025.02.25.18.56.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 18:56:54 -0800 (PST)
From: sean.wang@kernel.org
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	mingyen.hsieh@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	stable@vger.kernel.org,
	Caleb Jorden <cjorden@gmail.com>
Subject: [PATCH v4 2/6] wifi: mt76: mt7925: fix the wrong link_idx when has p2p_device
Date: Tue, 25 Feb 2025 18:56:43 -0800
Message-Id: <20250226025647.102904-2-sean.wang@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250226025647.102904-1-sean.wang@kernel.org>
References: <20250226025647.102904-1-sean.wang@kernel.org>
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
Cc: stable@vger.kernel.org
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Tested-by: Caleb Jorden <cjorden@gmail.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
v2:
  1) generate the patch based on the latest mt76 tree
  2) update the commit message
v3:
  1) fixed the merge conflict
v4:
  1) added tested-by tag
  2) removed unrelated files
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
index 8dba17c8697c..4f35c2f16d0d 100644
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


