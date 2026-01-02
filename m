Return-Path: <linux-wireless+bounces-30302-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B67A6CEF44B
	for <lists+linux-wireless@lfdr.de>; Fri, 02 Jan 2026 21:06:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C52D13064C23
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Jan 2026 20:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E0D31AF3F;
	Fri,  2 Jan 2026 20:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZHmlUxRA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71CB031A7F1
	for <linux-wireless@vger.kernel.org>; Fri,  2 Jan 2026 20:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767384207; cv=none; b=E59d36TMPYM+WmbE7V+p7ZDJTRkDpSrPhAvRqwkUvSn/59FmdhL/38q+jPH3/4CKETDjT/U+P2VGenCtsvJ7Z8Ra/DjIEAHS+FQLqBFflsvY8PaqPAAeYjDztglJZOimVGYQ+crUashh1XINc+xD5C/fDr/7WTEb/OhpSr8BQ30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767384207; c=relaxed/simple;
	bh=VhXBQtf8JMYP7iEplORKsTD0c5nXGZLDz2jVneZ3Y78=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dklp2DzwadIyLvlaeqPwpvlMhwsdg5JXKE78czlV1SozNXeL5TDndXcqopaDoSTdvIt1JLpoVev9IxfdhaS6o0qwUatRmswz/ellpK6zc9knoHQ4sRaL36iv3wEHxWmcdFHOJGUYM4UZX3mHTfe2ecB+X3GdrCa9OdnJJtcGrns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZHmlUxRA; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-34c21417781so12996248a91.3
        for <linux-wireless@vger.kernel.org>; Fri, 02 Jan 2026 12:03:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767384205; x=1767989005; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CwXGmthbpTQEUqtRqROv4y4T1PCVhu/O0zEJC5A6YzE=;
        b=ZHmlUxRAEU68rlhG2BcHbunkpQBpRzITXnxqAkxH2Q+6EreZs70mO01fpLHbY4CMKS
         0dc0tqPwCDpt/tWgkyMKoJD/ZiLwu6u5Kr802QxE1f6I4wYsLOGfb7uiFUgh6Dy77CZ+
         Jp5Uvbyp220gtYZHRtjghX0JzJbAe/S8iB5hKyj+Yl9Tq7LQYLymb5VRK9N+h3h70i+n
         tph9vYYu36evq58tkj6TuiFT/2A0IIAs/EdetkixLnhoM2V6E76J/nyFU1kIEngAY4zW
         RahwktbHKjAaC1NCFKDHtsn5qgo4xQWZ4w6tH4ZEW1oE5In0RbXgos1z1a7nLf3JWUVl
         pbxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767384205; x=1767989005;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CwXGmthbpTQEUqtRqROv4y4T1PCVhu/O0zEJC5A6YzE=;
        b=cd1zGmHfRgi7aOJhINxJcw3d3v1AR9GTuzDvqvuQaHjNKNTrCgS4yMPIm6VSi+yBjZ
         TDdhn083agoyckFjmvI/RwVX02B8s4zBzrxIqzXcg8swCHX/yCJkL8BnJspCe2pjZrTE
         GA2T7Dr+wucOOPtvmtoPPk4ay2zwqfVl005ZPfwRQ7Ye3vXnRBT2g7oo3pa26p4+5LGO
         CsLABLRDtCbk46i8Dlh9V+WktTCf99qAwaALmBchQEqOkY7ZuiOssm+a8M4o8W/ENnhQ
         HhsQmqHj6j4IqRtxj4xExFhl59Xx81qdfe2yAG9ol+YtKS0cGosKNGj/1lYe8sjuD8qM
         e5zg==
X-Forwarded-Encrypted: i=1; AJvYcCWdTHXgFDj/rHlwdIjfrJ5d20rUXxWQ2JmlVY4TWA4GSDrOnQX91Ly7swTAguqtKgBSrTVgr+mpBDlMMWN9lQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzedvqBIuWohsQF6Po7mFajUIVrFVxtpFlJ06QPeWvp8YWJJ4gR
	/Ti4c/7uz5D5QiqhocMcuMfka2qeqODdAKMzNdmM0OBk7WnoL4WF209s
X-Gm-Gg: AY/fxX7PMTtITRqWqGuzP2qW5jVcQASWHvn7U8PRR0bvJPRK+EySEDUcg/SMznx63gg
	3/HgZnfHsNTEVKsqeafsnz+stIY7uXOJbhYRQWtDo3rp5oXhEPFaX+8biyoja1vO5mNgqhPZ/Bk
	wFjEFNehdnC6nXceefLdVDqopqtl0UdZWLswq0gaWYN67oXLcXPWEBYUV+b8uc0GdM/78nGheUV
	fxLB+3J2X6UCe2reRm5FIoF+NUZCg8lte9Y8lkQydASblkZqE1E24LgjSUOgaRcwW4TrtFzdHoy
	ENdgMp4SvxiHknlsdrQln2PMfz0/gHq7Ls8hd/2Kw11U1YcI9vlwkAxvUof8B1As+LjZIvkjcMb
	zW++zvmq0c3HTfpFYCCARRYu0HCTDBgDaUexlvww5snFQcks8UwpNM28Pll8u1nqpETZzHar0TG
	0MoI3Re3vp8Ta3gHjpsGTpuQEylxSRiNMQkLSLB+EOvOcJq0xkHYkc7hYRynqSFyk=
X-Google-Smtp-Source: AGHT+IH1/N1u2PuoX7Eh0VerFmshHlsErFvyeb9e1ESgN0ZCiAZGVIbekPGk8cfz8LdFjRq6JiFCzg==
X-Received: by 2002:a05:7022:987:b0:11b:ca88:c4f7 with SMTP id a92af1059eb24-12172309d60mr39471937c88.40.1767384204564;
        Fri, 02 Jan 2026 12:03:24 -0800 (PST)
Received: from zubuntu.bengal-mercat.ts.net ([2001:5a8:60d:bc9:9ebf:dff:fe00:f8f2])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1217253bfe2sm120203795c88.10.2026.01.02.12.03.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 12:03:23 -0800 (PST)
From: Zac Bowling <zbowling@gmail.com>
To: zbowling@gmail.com
Cc: deren.wu@mediatek.com,
	kvalo@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	lorenzo@kernel.org,
	nbd@nbd.name,
	ryder.lee@mediatek.com,
	sean.wang@mediatek.com
Subject: [PATCH] wifi: mt76: mt7925: add NULL checks and error handling for MCU calls
Date: Fri,  2 Jan 2026 12:03:15 -0800
Message-ID: <20260102200315.290015-7-zbowling@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260102200315.290015-1-zbowling@gmail.com>
References: <20260101062543.186499-1-zbowling@gmail.com>
 <20260102200315.290015-1-zbowling@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zac Bowling <zac@zacbowling.com>

Add NULL pointer checks for mt792x_sta_to_link() and mt792x_vif_to_link()
results in critical paths to prevent kernel crashes during MLO operations.

Add error logging for MCU return values in mt7925_regd_update() to help
diagnose regulatory domain update failures.

Found by static analysis review.
---
 drivers/net/wireless/mediatek/mt76/mt7925/init.c | 13 ++++++++++---
 drivers/net/wireless/mediatek/mt76/mt7925/main.c |  8 ++++++++
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/init.c b/drivers/net/wireless/mediatek/mt76/mt7925/init.c
index d7d5afe365ed..f800112ccaf7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/init.c
@@ -162,10 +162,17 @@ void mt7925_regd_update(struct mt792x_dev *dev)
 	if (!dev->regd_change)
 		return;
 
-	mt7925_mcu_set_clc(dev, mdev->alpha2, dev->country_ie_env);
+	if (mt7925_mcu_set_clc(dev, mdev->alpha2, dev->country_ie_env) < 0)
+		dev_warn(dev->mt76.dev, "Failed to set CLC\n");
+
 	mt7925_regd_channel_update(wiphy, dev);
-	mt7925_mcu_set_channel_domain(hw->priv);
-	mt7925_set_tx_sar_pwr(hw, NULL);
+
+	if (mt7925_mcu_set_channel_domain(hw->priv) < 0)
+		dev_warn(dev->mt76.dev, "Failed to set channel domain\n");
+
+	if (mt7925_set_tx_sar_pwr(hw, NULL) < 0)
+		dev_warn(dev->mt76.dev, "Failed to set TX SAR power\n");
+
 	dev->regd_change = false;
 }
 EXPORT_SYMBOL_GPL(mt7925_regd_update);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index 11c0197c7426..b6e3002faf41 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -863,12 +863,17 @@ static int mt7925_mac_link_sta_add(struct mt76_dev *mdev,
 
 	msta = (struct mt792x_sta *)link_sta->sta->drv_priv;
 	mlink = mt792x_sta_to_link(msta, link_id);
+	if (!mlink)
+		return -EINVAL;
 
 	idx = mt76_wcid_alloc(dev->mt76.wcid_mask, MT792x_WTBL_STA - 1);
 	if (idx < 0)
 		return -ENOSPC;
 
 	mconf = mt792x_vif_to_link(mvif, link_id);
+	if (!mconf)
+		return -EINVAL;
+
 	mt76_wcid_init(&mlink->wcid, 0);
 	mlink->wcid.sta = 1;
 	mlink->wcid.idx = idx;
@@ -1750,6 +1755,9 @@ mt7925_conf_tx(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		    [IEEE80211_AC_BK] = 1,
 	};
 
+	if (!mconf)
+		return -EINVAL;
+
 	/* firmware uses access class index */
 	mconf->queue_params[mq_to_aci[queue]] = *params;
 
-- 
2.51.0


