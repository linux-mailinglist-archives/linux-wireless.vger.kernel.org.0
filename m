Return-Path: <linux-wireless+bounces-9960-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36217926AA1
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2024 23:44:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D203F1F20F29
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2024 21:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CEED194C95;
	Wed,  3 Jul 2024 21:43:33 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87DA4194C85
	for <linux-wireless@vger.kernel.org>; Wed,  3 Jul 2024 21:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720043012; cv=none; b=EMsP5iLnfupEBxTVF/oRSwyTdoDxNkYVBrDseWa/RWH4Md3gLaiNqP3sKCCsIPV51MMMUcQSJawu1GA2MTJxAmjPVfbenLjs0YohexF74O6nYSuSW5OQnbIcRyYrwAasraM+iUnyI5n6cT2AJsWUZtDDieT+eEZcVmuUbpS8i4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720043012; c=relaxed/simple;
	bh=MGxBKNhNKEAHOnOWdkVxlzJ5h9LGWEMpMkrlgwINVqs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RmjS61BYeA4EKE1pY/v5M00xFDC7EjJ6fsn3ylrbRqUa+bOf1UHdKyLjsXGWa1W1AkhZ7BTzuKR0Q3lVa+hfvm2Xr+VDA82l83r6s8948RHanEIXzW5+2sopny1k4/QzxwUmbqxV6/7ECYbB9NIMrcv1GDdL+9wjjWsr5d1vGYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-25cd49906aeso3993fac.2
        for <linux-wireless@vger.kernel.org>; Wed, 03 Jul 2024 14:43:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720043010; x=1720647810;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ffWOmyzGdQmn/1ElFIgBjJf1v30KLPcOBR1pd24Nq7I=;
        b=EWI0zp8DFJraTLK9UweeBF6Y3ewq7zSMe6NC/tfBZvVtCwz+v+1b/EnnS0pKKTJTV/
         2QYmIcRI8aqdRhRS5dp+hzaHliicxagIPdWiRGhwpZWeDEsfYWNOEqjK1t5faXYWvp+M
         lT0ykxWX2Y25qWiRFz5Hh5IJBMZ5+ExsRWQ9B+7m+y726fPsLDj81OcTczV72WgJoGR2
         7N4cP43ChPYsQRf42r39giEcPtVTT69Y/T/hC2jLZxf2gP2/CuC8/LNFDv4EZZYzL+QQ
         kVEU3sZGLClpMZhykVzLCXG8ZVMlPgEMtwP1zAT1sGBYVaRr+h8NXP6Xi0C89aHmmplp
         +GBw==
X-Forwarded-Encrypted: i=1; AJvYcCVk1/Tu+sxLZf+f/V6VgVsxgh0nREUEFBVfXDJmOVcWr7/ovlYOzG94JWVAdRcqVdXAJFl1hWsWQBa+qRCHtxd0wy7/2r1uCid1ofgnbpU=
X-Gm-Message-State: AOJu0YyQ6i2LN/kFpyphvMmWiw5aF00e3onuYGsJBsL50Gn2GLMaV/ng
	Bjid3FZ+kYI4bmwFTdHi0MGnnZkR9OukNUHtqwDZazHaKrzCAq5c
X-Google-Smtp-Source: AGHT+IEg9up3tNNH6BCf3a0LDbIZh3GhmduGK33TP3hQf2RrI2NvFjW6FtNxtHICn/l6idPmrPoZVw==
X-Received: by 2002:a05:6830:8c5:b0:6f9:7373:9421 with SMTP id 46e09a7af769-7020774aa24mr11940398a34.3.1720043010569;
        Wed, 03 Jul 2024 14:43:30 -0700 (PDT)
Received: from sean-ThinkPad-T450s.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-701f7b20953sm2111417a34.54.2024.07.03.14.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 14:43:29 -0700 (PDT)
From: sean.wang@kernel.org
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	mingyen.hsieh@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 20/29] wifi: mt76: mt7925: report link information in rx status
Date: Wed,  3 Jul 2024 14:42:25 -0700
Message-Id: <b3322836779900612adf2e4ffb409c62ac25c627.1720042294.git.sean.wang@kernel.org>
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

report link information in rx status

Co-developed-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Co-developed-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mac80211.c    | 5 +++++
 drivers/net/wireless/mediatek/mt76/mt76.h        | 1 +
 drivers/net/wireless/mediatek/mt76/mt7925/main.c | 2 ++
 3 files changed, 8 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index e8ba2e4e8484..bb291fe314fb 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -1125,6 +1125,11 @@ mt76_rx_convert(struct mt76_dev *dev, struct sk_buff *skb,
 	memcpy(status->chain_signal, mstat.chain_signal,
 	       sizeof(mstat.chain_signal));
 
+	if (mstat.wcid) {
+		status->link_valid = mstat.wcid->link_valid;
+		status->link_id = mstat.wcid->link_id;
+	}
+
 	*sta = wcid_to_sta(mstat.wcid);
 	*hw = mt76_phy_hw(dev, mstat.phy_idx);
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 01646538087a..c0e529d0b3ef 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -350,6 +350,7 @@ struct mt76_wcid {
 	u8 amsdu:1;
 	u8 phy_idx:2;
 	u8 link_id:4;
+	bool link_valid;
 
 	u8 rx_check_pn;
 	u8 rx_key_pn[IEEE80211_NUM_TIDS + 1][6];
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index 173934ec1e71..c3ce57d36168 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -809,6 +809,7 @@ static int mt7925_mac_link_sta_add(struct mt76_dev *mdev,
 	mlink->wcid.tx_info |= MT_WCID_TX_INFO_SET;
 	mlink->last_txs = jiffies;
 	mlink->wcid.link_id = link_sta->link_id;
+	mlink->wcid.link_valid = !!link_sta->sta->valid_links;
 
 	ret = mt76_connac_pm_wake(&dev->mphy, &dev->pm);
 	if (ret)
@@ -1865,6 +1866,7 @@ mt7925_change_vif_links(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		mconf->link_id = link_id;
 		mconf->vif = mvif;
 		mlink->wcid.link_id = link_id;
+		mlink->wcid.link_valid = !!vif->valid_links;
 	}
 
 	if (hweight16(mvif->valid_links) == 0)
-- 
2.25.1


