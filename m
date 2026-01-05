Return-Path: <linux-wireless+bounces-30337-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3124ECF1809
	for <lists+linux-wireless@lfdr.de>; Mon, 05 Jan 2026 01:32:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 57BAF3026BDF
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Jan 2026 00:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59360253340;
	Mon,  5 Jan 2026 00:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hqNhR+im"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5113242D95
	for <linux-wireless@vger.kernel.org>; Mon,  5 Jan 2026 00:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767572831; cv=none; b=L396jEB0K1c25H02YnBod+ByoGzdGvfJ4u7QGp7io0W1RZIiu1R7vhv/C8vEjpE2EqCPvybJpFtg1Kaf1StOuFGZQZG+8J2NgQjKdphX/Ix8w8M5+eSwMKFzKP5/W/P8Bih1O+U3OwZTBphd2T18H7cwvUkIBAK0GxqEHIfQP8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767572831; c=relaxed/simple;
	bh=57kIhmtqG6TNbumDiVzXkiPoxDHeC0x5cwZSL+KieZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=psaPf2AQ4BA4mTeWFVVSUrRzPwSyd4UEZIeSspzpVYOT3Tj82k18zrMo/7a3SEfpFqfqGOvzr7AJZaUbAa4BuyOpYDiSoEJiAWZP77xkxA32OZT6VNBqzV3uPKGcjAax0ZG8/hnatsS36va9r12B0O5cVAjpogcwp0mpDP1+RvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hqNhR+im; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c026e074373so12981224a12.1
        for <linux-wireless@vger.kernel.org>; Sun, 04 Jan 2026 16:27:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767572826; x=1768177626; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2UazWknOwH04QsneRRrwVbzYeSZapNaz/xF6C2obac4=;
        b=hqNhR+imXVjygG6o4GtUuLcQ7bInuo0/DzJXuMHS54fMQ6Q1xf37X6NeNw65WGsBee
         PniUk0iKZGFI8K1KdkaHDbpwtUJVt7z1V1IsWGxI3y9QYa8Zxp3hks/szACFcPLWkTE6
         tt4mwJAgD3ntAVGjyBr9so5JPRiQGADx/9zJzWk4bc335o4CtLGQoSK0W9WsqmhySWCV
         aCke8Aw6weDkWS+xsnxaqjRaJ99wCKWGzVBnkuAE8D8Oqe7Cv9b2YJlMU1HlW73MsPfK
         KeKUWHRWQqPSCfwcJSZ0CE6mQ38r+K3IR4gWfcqiuJTqHmPT22sY6tOyATFt1kWFvfd7
         2zZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767572826; x=1768177626;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2UazWknOwH04QsneRRrwVbzYeSZapNaz/xF6C2obac4=;
        b=YaIVNznBib3TH8FB3KSinbNCkfb+z+ztAIr4v/GNrUdcUdntVq04tkZQq8urhISbHk
         vPhhlA3Tg45gzkqfX4ArCIY95rSUBOSSq3ykEEEt67QmwPM0lRnS4QqZm9Sdcq2Jccnz
         yFlkbsR2oiObFRvczRtkR1LnPpg8I8hDTsDineXXG3S2ss7okFDQKSe/D9FBI9Q1W2//
         gw17knY4DzbzyobgUZaXg5FjBs7SAcYYSXJqcZZ4k9U/r8Oq12X+uh92A4pHr2j0KT8A
         b+E1iNh5VWvKBK2zr/wWthohUZhSL5C4LIy9Rwq5aJeIP6z+als5JrTLXTACxuI72jq1
         wx4g==
X-Forwarded-Encrypted: i=1; AJvYcCXDNn3V6VweHrEaU2+5FTPq89PNBNUsNfQRUtNTOyzlyiSFRpWC2jlQJkD3myPS21aJLWs9O8IOUV+yuuLCFg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzQMVlp9+IRez0XWrCGvg2RddS4WliDwqmHwKX62UQvwT2FpiZF
	hcGPqjGnoQQBlkYnxg5cX83NgkIhSFJCrTXgztej9qGBL/MKH51+EJh/
X-Gm-Gg: AY/fxX4136p9U4bKZ1NEQ+zWw1QoOLT4LGhNshJgGvNYXPX/iwnBsVE1DNHtXVCNig3
	lxKykW0QPBLGZ1T6cunklpGaC9ttAks+m5z4PGAAoK39WWqZEAJcja/wu+lpa2iz0KfnXY/6YPM
	OMNVfhYSvYykOMSbxjGGJWzRsABg50wyzqYQ2ri5GOdxZOAQeVkGjT/FwRwJq3oLfW+UoUP2iOp
	SFbDmL9SL2d4HcEVHR1wioOdAxPgh3vUVGpkw7/w4I3vDhwERnPDtNUnqqJlrm6Hfk9qqAI94P7
	HF/GQRQVVCxFquw1iBqmiucGeANjQYNLjho6mMI61bWAfQeW+kU/rXvciQNM1a8HY7lbF2AOYgK
	6TGJQd2PUB6S0qeDx4EFcrbf6Q/cULCV8kjStcvYkJO6OmR1BL1q44pQ9o3uwahPV9op9wCp1wI
	LzrM+T3yZUdTQX4F9XVqgjsvvui9zsYYsvIKuUdztJkHFlI/dxX5xJLQ9z7spCL4Y=
X-Google-Smtp-Source: AGHT+IHo0J1leWdPLu3WQhod7DNS+GZTgRh6fGvRRczAieCCr4pVXf1vgQz9pV4AVAq0GzwSrDdpEg==
X-Received: by 2002:a05:7022:428b:b0:11b:f056:a19b with SMTP id a92af1059eb24-121722ab37dmr45418431c88.18.1767572825820;
        Sun, 04 Jan 2026 16:27:05 -0800 (PST)
Received: from zubuntu.bengal-mercat.ts.net ([2001:5a8:60d:bc9:9ebf:dff:fe00:f8f2])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121724de268sm133378109c88.8.2026.01.04.16.27.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jan 2026 16:27:05 -0800 (PST)
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
Subject: [PATCH 14/17] wifi: mt76: mt7925: add NULL checks for MLO link pointers in MCU functions
Date: Sun,  4 Jan 2026 16:26:35 -0800
Message-ID: <20260105002638.668723-15-zbowling@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260105002638.668723-1-zbowling@gmail.com>
References: <20260102200524.290779-1-zbowling@gmail.com>
 <20260105002638.668723-1-zbowling@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Several MCU functions dereference pointers returned by mt792x_sta_to_link()
and mt792x_vif_to_link() without checking for NULL. During MLO state
transitions, these functions can return NULL when link state is being
set up or torn down, causing kernel NULL pointer dereferences.

Add NULL checks in the following functions:

- mt7925_mcu_sta_hdr_trans_tlv(): Check mlink before dereferencing wcid
- mt7925_mcu_wtbl_update_hdr_trans(): Check mlink and mconf before use
- mt7925_mcu_sta_amsdu_tlv(): Check mlink before setting amsdu flag
- mt7925_mcu_sta_mld_tlv(): Check mconf and mlink in link iteration loop
- mt7925_mcu_sta_update(): Initialize mlink to NULL and check both
  link_sta and mlink in the ternary condition

These race conditions can occur during:
- MLO link setup/teardown
- Station add/remove operations
- Firmware command generation during state transitions

Found through static analysis (clang-tidy) and pattern matching similar
to fixes in mt7996 and ath12k drivers for MLO link state handling.

Fixes: c948b5da6bbe ("wifi: mt76: mt7925: add Mediatek Wi-Fi7 driver for mt7925 chips")
Signed-off-by: Zac Bowling <zac@zacbowling.com>
---
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index 8080fea30d23..6f7fc1b9a440 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -1087,6 +1087,8 @@ mt7925_mcu_sta_hdr_trans_tlv(struct sk_buff *skb,
 		struct mt792x_link_sta *mlink;
 
 		mlink = mt792x_sta_to_link(msta, link_sta->link_id);
+		if (!mlink)
+			return;
 		wcid = &mlink->wcid;
 	} else {
 		wcid = &mvif->sta.deflink.wcid;
@@ -1120,6 +1122,9 @@ int mt7925_mcu_wtbl_update_hdr_trans(struct mt792x_dev *dev,
 	link_sta = mt792x_sta_to_link_sta(vif, sta, link_id);
 	mconf = mt792x_vif_to_link(mvif, link_id);
 
+	if (!mlink || !mconf)
+		return -EINVAL;
+
 	skb = __mt76_connac_mcu_alloc_sta_req(&dev->mt76, &mconf->mt76,
 					      &mlink->wcid,
 					      MT7925_STA_UPDATE_MAX_SIZE);
@@ -1751,6 +1756,8 @@ mt7925_mcu_sta_amsdu_tlv(struct sk_buff *skb,
 	amsdu->amsdu_en = true;
 
 	mlink = mt792x_sta_to_link(msta, link_sta->link_id);
+	if (!mlink)
+		return;
 	mlink->wcid.amsdu = true;
 
 	switch (link_sta->agg.max_amsdu_len) {
@@ -1953,6 +1960,9 @@ mt7925_mcu_sta_mld_tlv(struct sk_buff *skb,
 
 		mconf = mt792x_vif_to_link(mvif, i);
 		mlink = mt792x_sta_to_link(msta, i);
+		if (!mconf || !mlink)
+			continue;
+
 		mld->link[cnt].wlan_id = cpu_to_le16(mlink->wcid.idx);
 		mld->link[cnt++].bss_idx = mconf->mt76.idx;
 
@@ -2045,7 +2055,7 @@ int mt7925_mcu_sta_update(struct mt792x_dev *dev,
 		.rcpi = to_rcpi(rssi),
 	};
 	struct mt792x_sta *msta;
-	struct mt792x_link_sta *mlink;
+	struct mt792x_link_sta *mlink = NULL;
 
 	lockdep_assert_held(&dev->mt76.mutex);
 
@@ -2053,7 +2063,7 @@ int mt7925_mcu_sta_update(struct mt792x_dev *dev,
 		msta = (struct mt792x_sta *)link_sta->sta->drv_priv;
 		mlink = mt792x_sta_to_link(msta, link_sta->link_id);
 	}
-	info.wcid = link_sta ? &mlink->wcid : &mvif->sta.deflink.wcid;
+	info.wcid = (link_sta && mlink) ? &mlink->wcid : &mvif->sta.deflink.wcid;
 	info.newly = state != MT76_STA_INFO_STATE_ASSOC;
 
 	return mt7925_mcu_sta_cmd(&dev->mphy, &info);
-- 
2.51.0


