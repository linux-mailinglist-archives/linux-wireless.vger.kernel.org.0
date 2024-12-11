Return-Path: <linux-wireless+bounces-16214-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 910449EC16A
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Dec 2024 02:20:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20267169097
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Dec 2024 01:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B80313BBC9;
	Wed, 11 Dec 2024 01:20:00 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1E522098
	for <linux-wireless@vger.kernel.org>; Wed, 11 Dec 2024 01:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733880000; cv=none; b=RRsnI2LgR742pixj0uInYDTrGEVwGNkOquP7Q71L2Kxn5ygaCAWNpwLUb8CuMSfVbmlVDS192mfpFFRbqShxojRvi8SbwoLHur9EpszAqlQNKfLhN/74XodlneyEDNvtBf/g2ez7sOUOOBhCmG6g2ww8LKoB3aO0/HzRXpwrziA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733880000; c=relaxed/simple;
	bh=tKxK8ku2yAnUtRd0m+X8zKnILJlXjJaoAvpA9novS2M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i340nq/nmc2H6ZTxDZXv4Yt/Ut+JTiZG4OOUTTwoDqnsHWnk6vY7+AIgcWY4+s076R8OUs/M86i1R9sIn9POWumEwao8kEee/NpN0UuOhhcuQju/U259pRoDZ4LPSMD2NLIQALL4qMG2G7EndinlimAfXfRZRAWi2ZIdnE0Aptk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-29e2a50586dso3245710fac.0
        for <linux-wireless@vger.kernel.org>; Tue, 10 Dec 2024 17:19:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733879998; x=1734484798;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yk49pXqoMYWny8tmzY5u5tahMKAPgzxyn6k/GluClh0=;
        b=LvrHCqmUyflEI/PNoUQCK5c7HDBrjVg5SkllPJbghWFQmgrAsnlcU01zBX7trwt79V
         sG4+pvVFRyI3GOUDybVWfijABvNAtGdL/aMddlHVELR+DFqRplgSJidWURn2rDCZwxu7
         2cYno9dmOst1pcVsHPQ0Rqq73h4drFauVE1oPO9bXfR7jLJ3frXVQVoc/Rj9U7PeDmYx
         1/GovMSi4vPjBwFnDp6edKrKysGiEoq8cs6pLzfZEPkFeHguiU+iOXJ2wA++gRK0vKbV
         WDoLHfb+0PyDo1bmo2cc8jtJRcLyO1fYHaFk48NQ2f7wrw78DmU711v6Zrw8Ix2kh32o
         swpw==
X-Forwarded-Encrypted: i=1; AJvYcCXE5XxE9hnOwn20k9zOfhmAIgcQ57U4kG0UXlg/uOGUQHyGoBRkTXFSSGCIktTJCx9ZehC+2JLlXKKOFaN+ow==@vger.kernel.org
X-Gm-Message-State: AOJu0YyzdPGAxEgbFErwOl2kqwmTX/xdAVBwo/fubQPwycSkSON3JPHy
	cBQwV0BJdCUWW+lbsAqmTv5bIsh+DOo0VAVTgyvRPpbziaIC8ZgV
X-Gm-Gg: ASbGncuFvB1ZQlViHmqQfHo5dFn+bBmW7XnbEw1ksY9rlCD3qslkdPPab/PgDroCFdV
	HWbwhpM71F/D5KThqan6LY72roNSNZWa/4Q8eyc2mnDZfo1Iq3rQRpAMyz74kVGoVXvNO9R8ckR
	4ZKvnPB8aED5mTIQWFEz7a5OhncKaLMfCLY4E38a9RlLL/f1fklsVCL2cMho5BNSQoH6F63Qabs
	iTMcILLa+Nb94KbBgK9a5EfPobcrnWSnCjOFJ1gvIVxoux8g/umAlVRKLfg4qiErrer/kU=
X-Google-Smtp-Source: AGHT+IGqPCatQj/2c2jZ6uQhg94tt5NOTEosEEskQiKERWxs5QGjzv/Q6ATe/f81GUUeNedQJy5aqg==
X-Received: by 2002:a05:6870:7b49:b0:29f:8a1b:f76a with SMTP id 586e51a60fabf-2a012d9cdb7mr583515fac.28.1733879998456;
        Tue, 10 Dec 2024 17:19:58 -0800 (PST)
Received: from sean-ThinkPad-T450s.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-29f93552d34sm2705701fac.24.2024.12.10.17.19.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 17:19:57 -0800 (PST)
From: sean.wang@kernel.org
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	mingyen.hsieh@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 06/17] wifi: mt76: mt7925: fix wrong parameter for related cmd of chan info
Date: Tue, 10 Dec 2024 17:19:15 -0800
Message-Id: <20241211011926.5002-6-sean.wang@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241211011926.5002-1-sean.wang@kernel.org>
References: <20241211011926.5002-1-sean.wang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>

Fix incorrect parameters for the related channel information command.

Fixes: 86c051f2c418 ("wifi: mt76: mt7925: enabling MLO when the firmware supports it")
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7925/mcu.c   | 23 +++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index 83f237d49c26..f6aa052ca802 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -1200,6 +1200,8 @@ int mt7925_mcu_set_mlo_roc(struct mt792x_bss_conf *mconf, u16 sel_links,
 		req.roc[i].bw_from_ap = CMD_CBW_20MHZ;
 		req.roc[i].center_chan = center_ch;
 		req.roc[i].center_chan_from_ap = center_ch;
+		req.roc[i].center_chan2 = 0;
+		req.roc[i].center_chan2_from_ap = 0;
 
 		/* STR : 0xfe indicates BAND_ALL with enabling DBDC
 		 * EMLSR : 0xff indicates (BAND_AUTO) without DBDC
@@ -2177,11 +2179,27 @@ void mt7925_mcu_bss_rlm_tlv(struct sk_buff *skb, struct mt76_phy *phy,
 	req = (struct bss_rlm_tlv *)tlv;
 	req->control_channel = chandef->chan->hw_value;
 	req->center_chan = ieee80211_frequency_to_channel(freq1);
-	req->center_chan2 = ieee80211_frequency_to_channel(freq2);
+	req->center_chan2 = 0;
 	req->tx_streams = hweight8(phy->antenna_mask);
 	req->ht_op_info = 4; /* set HT 40M allowed */
 	req->rx_streams = hweight8(phy->antenna_mask);
-	req->band = band;
+	req->center_chan2 = 0;
+	req->sco = 0;
+	req->band = 1;
+
+	switch (band) {
+	case NL80211_BAND_2GHZ:
+		req->band = 1;
+		break;
+	case NL80211_BAND_5GHZ:
+		req->band = 2;
+		break;
+	case NL80211_BAND_6GHZ:
+		req->band = 3;
+		break;
+	default:
+		break;
+	}
 
 	switch (chandef->width) {
 	case NL80211_CHAN_WIDTH_40:
@@ -2192,6 +2210,7 @@ void mt7925_mcu_bss_rlm_tlv(struct sk_buff *skb, struct mt76_phy *phy,
 		break;
 	case NL80211_CHAN_WIDTH_80P80:
 		req->bw = CMD_CBW_8080MHZ;
+		req->center_chan2 = ieee80211_frequency_to_channel(freq2);
 		break;
 	case NL80211_CHAN_WIDTH_160:
 		req->bw = CMD_CBW_160MHZ;
-- 
2.25.1


