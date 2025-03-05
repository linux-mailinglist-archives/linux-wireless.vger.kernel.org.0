Return-Path: <linux-wireless+bounces-19783-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91041A4F220
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Mar 2025 01:09:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27B85188D8AD
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Mar 2025 00:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A70D1A32;
	Wed,  5 Mar 2025 00:09:03 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF58B674;
	Wed,  5 Mar 2025 00:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741133343; cv=none; b=AVPD+cNyupIVtLqnfboNR2WF5rSTKnfK9FLnxxb+T3h9d7tNZiXixcssm1bG/8LEPoSF+PnbozZ/sGHUvGkJf1ysV6m57nwH3P8a6ZVHxuMQGqCj0R+Zqzk6LQ14mTCjnaR0fjdFiFceiBSPo1PXuqQUQ7oFQ1y1Yykf4udoxy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741133343; c=relaxed/simple;
	bh=5KlE+q1q0A4dDAFDD/mVAp/fZNJiv3UdlT6xCi39NjA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KDZKl3h90VE1gYUff+KRP2Xd1QRYofUxeC5gxr3JbFM9I9sRXTVXFK+CzmNO9z3m24s7m3lh5BeBIz8HyFhnkDML7tyPiKAfy+3ocXONRx/JkDDlh1WtQf+eoM9oHgpU5o9XxVmlG+x+5fHmdWM4Eq9EcS6nHw3ZDIKpVWHc9hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3f3f149c334so4310069b6e.1;
        Tue, 04 Mar 2025 16:09:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741133341; x=1741738141;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K29PyePUpk5WVq4lLAdCQNE/othRM+FfI7C3wd/RqYg=;
        b=cvph70eJXhseq9zwsBV6EY/Qvk6/7wfh6s7agU2fi/Gvps078G3VrkCpFLhA3Iqwxm
         i3JF5DYNmO3utH035wlRgS1Qtjq9hK4/0IoILdaVW39P8WJ/c+G0jbMNn4dp3ilb12xh
         us9XQXnDe/RBF9LfKISsl/VEMEXRhmN1aNfT/VTMGG+ERuoT590Dm2iZOPTCcSw3M/Sm
         Iew6ZgGAKL1XdkMD84lxdv1LD5StCsxfICcEP+lPmt5mASb30+SNjuPZKTZ8e5+YlYk7
         0O97LxwwqDPurPg83cf0GgMspVunHZn4rfArZt5Smq/ZXO5Cd7HJHVbS7Gymmr59KXow
         q9OQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNK8N9m5yI+ACWwtXHSBx94rTirRjZp3iFnYf6wH67QGUarifvOR5eRYgjpVn8WSLewVH8xJpS@vger.kernel.org, AJvYcCXTrhmP7q9ydD4dVZbjtJ5uuiE88o89w5JZSvE+VVOpVzpEGbLIgb0/9WBti3LrItotXpjY3Q+s4sD4oX5rXw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/7jzSSu7CvYFmiwo3JNFK4u3DkhxdOnmkWOGPSx64z4AHo1Ki
	WcZUAjAQq+vM5h7FkT7xm5NSIgmq3Ebs924nRhVHsmeKo07QI4tX
X-Gm-Gg: ASbGncsqtxZcEemWd0WhMYQ4RFDG4W7mqISdxT917WthX56bIW/qPTkl8WVrMVIvVmT
	vkEt54a+SMfbPH335rtrtiBqHCsGHX4lGUTqav4/CMM049V+jEuYOmvfjaT5WqfYSuVy95AJ06i
	8tzcI+2VxI+0HQfvcZKBw9z6Yo2bbLGoN31AnoseqRuZKzw7lrrTZPfBmuVqS19ID/lSPB11Q+J
	JCNBDpHTmJ3SL9KPu2JPh3H6C+vkr4dqZbzVjGgk84Ayco4VO8G2wLYg+iPRFApznwiCF6NwlAF
	3F8bxto23YrWCfN/7ox7HiP82n/y7lpukpgIOk8/iTbnV5d2sMEs1mw+4WuqfQ==
X-Google-Smtp-Source: AGHT+IHk5Z4MAR+2LKqaAWAqGAhbyH341r43aDMKsumqMh5/HkJ+xA7G/KuX0nkkLzZMwaGtSmpJ0w==
X-Received: by 2002:a05:6808:3584:b0:3f6:684f:2f24 with SMTP id 5614622812f47-3f68315d0afmr458666b6e.16.1741133340971;
        Tue, 04 Mar 2025 16:09:00 -0800 (PST)
Received: from sean-ThinkPad-T450s.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3f67ee8f479sm299985b6e.40.2025.03.04.16.08.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 16:08:59 -0800 (PST)
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
Subject: [PATCH v5 2/6] wifi: mt76: mt7925: fix the wrong link_idx when has p2p_device
Date: Tue,  4 Mar 2025 16:08:47 -0800
Message-Id: <20250305000851.493671-2-sean.wang@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250305000851.493671-1-sean.wang@kernel.org>
References: <20250305000851.493671-1-sean.wang@kernel.org>
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
Co-developed-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Tested-by: Caleb Jorden <cjorden@gmail.com>
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
---
v2:
  1) generate the patch based on the latest mt76 tree
  2) update the commit message
v3:
  1) fixed the merge conflict
v4:
  1) added tested-by tag
  2) removed unrelated files
v5:
  1) update co-developed-by tag
  2) rebase to wireless.git
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


