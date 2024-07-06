Return-Path: <linux-wireless+bounces-10042-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF29E9291E7
	for <lists+linux-wireless@lfdr.de>; Sat,  6 Jul 2024 10:30:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A99C283CAA
	for <lists+linux-wireless@lfdr.de>; Sat,  6 Jul 2024 08:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9431B4F5EA;
	Sat,  6 Jul 2024 08:29:03 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2668849654
	for <linux-wireless@vger.kernel.org>; Sat,  6 Jul 2024 08:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720254543; cv=none; b=iue1Gzj5kwQDImqq/s0FpSZlRycWRdcHvEBpHnkUtRQEZCxllnLje9mD2bZYM+hY5kdbpjE97X34MSwlATTjsU3wegNi32YtVlNworJbfKXEIuGKfSBOQ1rt1AbpndA7wBwXTkgfRulCu1HTEdx1RtgHUMgooCiPKc9aiWBhFeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720254543; c=relaxed/simple;
	bh=+zH8HYZ3fjCuW/cPVSnM+Kp2V5mGM8HUO+6kliFtsac=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZZOWo2hmrB8+95nAdr1ZtXas9Keg+Y3WU4waWuaD0QhdCnqH0Qcj+YVLmFt+0mdXiTk7g5AI6bCJzDbqVjgj8RZBw0wEIcHQiwINipPuAELc9EiMIL95UeDHJ4k0kbIfxVsLV+Nz/9Hg/OAReLlyIhy5fdmXG0PfiETewgo9uTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-25cb5ee9d2dso294081fac.1
        for <linux-wireless@vger.kernel.org>; Sat, 06 Jul 2024 01:29:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720254541; x=1720859341;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l6JgbGlLloDOsdCpCL/NF0E12c2AZhS/thZxd2FKNmc=;
        b=oVj74Y0C60DodWJ81RcXkbsWiJ8/0sLFLcN/kQJc39JaEpMWYV27fhiqETc/+iZbY4
         0I97bscykwgnjEKwEcZ0lQohtZkmmVsH9HSK3qfPC+bCKO0EasZDKESUYvt5sbC4VVfY
         7eaNaXaBTzxBlByt2SvlNfnjpQyR7U/RVvQemTUBo+ZLhooPfUWkvXvcUDBtUZ+eo+ye
         d1rWwA7QC+CEYunE4w9EKhezkjCsY9CH8FuBfejE91kq0rac0lLIs6RGJbQRIe1Fn5wL
         xfF9Sm8tdKWdFJQjdr1Umnw4b+9IkJeHF2cV7FZuHLC23yxR3NyvSkD5+CUOLbfKEIvu
         fmMA==
X-Forwarded-Encrypted: i=1; AJvYcCVmxlYz/FfdOGz0hqa8kb0rsjzHaV++q8E10g/hmEnOrHBD7lB+p/1t/s1bvSssUvgzzbmiEHdiLjJrLKRXZbVT26xZTeOqLyNn+uqU9Uw=
X-Gm-Message-State: AOJu0YyfEXqvw5rqIEcIFjbcIuaoVSEVPsxHlU2JYTjbQQ5IioMmdwGf
	k/NpsqdYyfP/J+sRtvo0poFxgCTIaATLcB2e4YGBbdkF0J36aXn+
X-Google-Smtp-Source: AGHT+IEfuTTj9gDVp9lM/598TllXNNPv45c5rNz254+YfkdsEpTbczD8iLScDxGA1PCnoOpkitpzCw==
X-Received: by 2002:a05:6871:54a:b0:25d:f237:e108 with SMTP id 586e51a60fabf-25e2b5a1bfcmr6904185fac.0.1720254541141;
        Sat, 06 Jul 2024 01:29:01 -0700 (PDT)
Received: from sean-ThinkPad-T450s.attlocal.net ([2600:1702:5083:7610:1e13:57ab:ecc5:1fd4])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-25e71070ba1sm10744fac.34.2024.07.06.01.28.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jul 2024 01:28:59 -0700 (PDT)
From: sean.wang@kernel.org
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	mingyen.hsieh@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v2 23/37] wifi: mt76: mt7925: report link information in rx status
Date: Sat,  6 Jul 2024 01:28:03 -0700
Message-Id: <c7cdc17d94375a76802a5c4a825ea3e51cdb53af.1720248331.git.sean.wang@kernel.org>
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
index daf1e43e304e..e1d30326f5af 100644
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
index e1af5b4179b0..1a6a0b56a23e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -811,6 +811,7 @@ static int mt7925_mac_link_sta_add(struct mt76_dev *mdev,
 	mlink->wcid.tx_info |= MT_WCID_TX_INFO_SET;
 	mlink->last_txs = jiffies;
 	mlink->wcid.link_id = link_sta->link_id;
+	mlink->wcid.link_valid = !!link_sta->sta->valid_links;
 
 	ret = mt76_connac_pm_wake(&dev->mphy, &dev->pm);
 	if (ret)
@@ -1898,6 +1899,7 @@ mt7925_change_vif_links(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		mconf->link_id = link_id;
 		mconf->vif = mvif;
 		mlink->wcid.link_id = link_id;
+		mlink->wcid.link_valid = !!vif->valid_links;
 	}
 
 	if (hweight16(mvif->valid_links) == 0)
-- 
2.25.1


