Return-Path: <linux-wireless+bounces-10041-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B49AE9291E6
	for <lists+linux-wireless@lfdr.de>; Sat,  6 Jul 2024 10:29:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71A8E282F47
	for <lists+linux-wireless@lfdr.de>; Sat,  6 Jul 2024 08:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B355449650;
	Sat,  6 Jul 2024 08:29:01 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B5673459
	for <linux-wireless@vger.kernel.org>; Sat,  6 Jul 2024 08:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720254541; cv=none; b=TM7TNgFSAiLoPnJsinPHAV3DQZSydetsA/6nsbGsFAa5JpXWMYyjHBwbtOFSHDIdv6NdEy4hSF2ZCbXMg6w16vKcu3/PYu/UHOkKrcWgOx5QxMcTVzdQcsN1kcPrIccp2W0BAW/E9/vmAeIb6fPJ3C78V8wjv6LRpSmXH1AOcCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720254541; c=relaxed/simple;
	bh=xThHTRVEbOJnPiz5nklxXvOhwARdRWfy32sdoGtDwSE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=vDf0sHFggXwCL2OU4leWAFbnJipseDj4agFZgsebGnZ7Rh0ZySsBMOOAdUUJzSD2JjowddtIqdcv/ABEddwl9TPsHzSoQYKurie4VGPnQ+GFIKWtrOYdb/4HbJesFFMhWIoAHbxLorWqIFVF0ST3d/EeXcfqMr2cVXNtzyMTCQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3d56754a4ceso322079b6e.1
        for <linux-wireless@vger.kernel.org>; Sat, 06 Jul 2024 01:29:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720254539; x=1720859339;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L17xDYgVdAfPX0dyJlUo8j3jUMWLwVqA5L7fwy5iAF4=;
        b=iyFA8w7FjTg8l1/7jvzI0AxsgkHsoiMZ7NKgzkyNT3WWcdh1RBsdxizVmDDTu1MgcU
         mnKvkv4VhIzg3yayBMJwsPBsg10griMyYg+1BDaADCVdWQHp/ElAQtwUMfWaQqfZoYdC
         7GTYCeNHiimlRf94r0BbNeDmVBVhVwDe/FnHx1HMEg88ULeJDAitmQ6gxJcErDvH9RM0
         6xplEv/t2FDjNJggGOPQ4d6gP6lX+m95v/N25dMr2Q+P/L4YXJqa4J8pmUHrEY2u/zuH
         4DOgAi9aiTbeplfTaAZkIedSzYrcZHLVLpOwDPjhB8xgIhyxeBTl2BiPNMW5dheI8SPt
         CGwA==
X-Forwarded-Encrypted: i=1; AJvYcCWJzimbH4o3xJ3MqJHGpdIemKPtRThIBL4pYrTLtg7Dg6V4yMXCCvnptufr4FPcnu9oof65GMDUAPYJQdi1vAn63/xdh4C7SazMSt59kDQ=
X-Gm-Message-State: AOJu0YzBkzKdaMMAaYMLpjs8anYPKjc8VRe2xzLTZhiixMw15yrt+Rcl
	bhNHXw376LoYIWB/Tfbv6RcciU4OcFGCg43van9e95Dgriq6K3wI
X-Google-Smtp-Source: AGHT+IGcPB4DMUSotfZxfYkuA3vtERCQ08CkirXCvIo6j47xA/pJmbNAaY+olGcoE1et+KNb9FBa9g==
X-Received: by 2002:a05:6871:24ca:b0:254:ecbd:1815 with SMTP id 586e51a60fabf-25e2bffce48mr6346814fac.5.1720254539381;
        Sat, 06 Jul 2024 01:28:59 -0700 (PDT)
Received: from sean-ThinkPad-T450s.attlocal.net ([2600:1702:5083:7610:1e13:57ab:ecc5:1fd4])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-25e71070ba1sm10744fac.34.2024.07.06.01.28.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jul 2024 01:28:58 -0700 (PDT)
From: sean.wang@kernel.org
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	mingyen.hsieh@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v2 22/37] wifi: mt76: mt7925: update rate index according to link id
Date: Sat,  6 Jul 2024 01:28:02 -0700
Message-Id: <e0bbc0932edbd9225fe7b7736693c137cf433a52.1720248331.git.sean.wang@kernel.org>
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

Update rate index according to link id.

Co-developed-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Co-developed-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7925/main.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index 54479c2fc167..e1af5b4179b0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -1801,9 +1801,12 @@ static void mt7925_link_info_changed(struct ieee80211_hw *hw,
 				     struct ieee80211_bss_conf *info,
 				     u64 changed)
 {
-	struct mt76_vif *mvif = (struct mt76_vif *)vif->drv_priv;
+	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
 	struct mt792x_phy *phy = mt792x_hw_phy(hw);
 	struct mt792x_dev *dev = mt792x_hw_dev(hw);
+	struct mt792x_bss_conf *mconf;
+
+	mconf = mt792x_vif_to_link(mvif, info->link_id);
 
 	mt792x_mutex_acquire(dev);
 
@@ -1817,16 +1820,16 @@ static void mt7925_link_info_changed(struct ieee80211_hw *hw,
 	}
 
 	if (changed & BSS_CHANGED_MCAST_RATE)
-		mvif->mcast_rates_idx =
+		mconf->mt76.mcast_rates_idx =
 				mt7925_get_rates_table(hw, vif, false, true);
 
 	if (changed & BSS_CHANGED_BASIC_RATES)
-		mvif->basic_rates_idx =
+		mconf->mt76.basic_rates_idx =
 				mt7925_get_rates_table(hw, vif, false, false);
 
 	if (changed & (BSS_CHANGED_BEACON |
 		       BSS_CHANGED_BEACON_ENABLED)) {
-		mvif->beacon_rates_idx =
+		mconf->mt76.beacon_rates_idx =
 				mt7925_get_rates_table(hw, vif, true, false);
 
 		mt7925_mcu_uni_add_beacon_offload(dev, hw, vif,
-- 
2.25.1


