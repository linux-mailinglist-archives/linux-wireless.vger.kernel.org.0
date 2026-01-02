Return-Path: <linux-wireless+bounces-30297-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A09ACEF424
	for <lists+linux-wireless@lfdr.de>; Fri, 02 Jan 2026 21:03:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 14287301B2DA
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Jan 2026 20:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39B55313E2F;
	Fri,  2 Jan 2026 20:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I/8hBGlU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7EC2D3750
	for <linux-wireless@vger.kernel.org>; Fri,  2 Jan 2026 20:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767384201; cv=none; b=EaiFp8HiXSozCR+2ulEImZJKTnJcVGouruLhrl9hdSpmOAeviHg072MrxXDcKUSxJmLhv1S5kFGuLrTgM6ds8rE5EQyaWEziit2/otzgzomQrZuWfOMSkY5wLoSlPr1coTVTIt0Qz4V1AsnC76FaC9ABeKnxDE28wG5gqc5I6kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767384201; c=relaxed/simple;
	bh=FlZ9dbxtFOdp2Pe3NxrvOn8O6tksHkebEl7xpZY28cQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pAk8CriC4oSwTgbrg3LYWB+51TmkTerXf4oLbK+1oL2rdgM2SEj7NVmRzqUDDcrOgJZH2A8wlxqiDVSmQZU2unebXYNwSrVdOsT/zyBKAPhxzpT4NX1j1rRBdemTVOt0UbAosz0Gk3qirvWpWyKQ2y4RgL0IMS2cBx68eYbdNZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I/8hBGlU; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2a07f8dd9cdso127428085ad.1
        for <linux-wireless@vger.kernel.org>; Fri, 02 Jan 2026 12:03:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767384199; x=1767988999; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rJB8TW11tb7vqsvvuXY9YlttNtwZmLNOXyK32XgfdCE=;
        b=I/8hBGlULVO/TSV2lRVcep4YyqOzsi/u02dVD9WLde6X2xVMn9ChD0KgJot+P6Yize
         pOdLMWSWkoNut6TRJYxM/Od5KR87EbEOjRxad+wu0pRe+WAYcKfX/q4jCEu5IY2Jpw4y
         13fJ75klFJP9dZwyRQH/UPplxNnjEAX8tpZXyyW2OYuFz+R4HTTpC+7x+mY37/PlKkRH
         qsV7OkKSVspO6bzTz4dwvmEiR47M2iS20VG7fT1w1ubFoRTw8f28KRre0TG/qWHrORza
         PAsE58YBU9NTMEOdXKpxvA3RFTIchMq36ml/ogXMolJpvnV09pygdILf+h4cXJ4VBLDb
         kv8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767384199; x=1767988999;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rJB8TW11tb7vqsvvuXY9YlttNtwZmLNOXyK32XgfdCE=;
        b=dtsSgE3zbR1BljrnLDMb3jxAZzYCaQHhU7Ko0ptZI1Dic4HhmhtYitZP8mnOyAQy0F
         Xwh84YpGyP7535cX3GZHnBTC3JT/AjdG0zdE++EVIiXRDTZwEraCggFOtSWjEFwxO01g
         CaJjFE0ptvELmVrrwJtr0NHD+GYwrQpyWmw9L0PYVckA9VTK1L8zx0VbIRggIPg791bF
         GFqHYtI7JFZaelC+mbkPlBK6uy0IE1Wcy/Vmj5wkrmFqDt0ryRAvkjLRUQz/1RbXLi9p
         Bh+K4Pk5Fwz29/6z7P0bsQ8H4rTxavLSYTPZTJrzrCdQ/nw5QtEbOVy4exSODiQ6JdeN
         eKlw==
X-Forwarded-Encrypted: i=1; AJvYcCWimuA/7/83Y+5lmAKkxHjbvrQp6Q36ykYPdD4aPhmThItE9hc84Wrk9Y9/+t21TM62bO7VEL9svVzKGvPYJg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxyBAcJQRFB7ojsAyOL6Bt9l8U3POpOw1uKqb3jb44LQMgkB5US
	bHzgZTgfHzTZZI7TNp8E2eWvmXoMqG30tIXaxNNLgJl5JyuYWSJebhg/
X-Gm-Gg: AY/fxX4y71sDVtTOPU4mzuiyOd38LivbCaqVqrQIECBFKQQMtEcVzjmRnIvYuwvnqB2
	goQDZ+ZqB1wyqA5eHku93UClqa1Cntq+eglDfK/dWhYLrvPMmjw6FnE2+1zgGOulM/CmwPIQzau
	il5A5G8RCsOflDd8odLQv769+dbK/fEl6FubUqVuQ8TVHI/QZDE6sZX+q1+nEuFaKwGpJDWTOEY
	bvsMrlkyTUAUY248jxaU3y56UBrAysnbXPgIT1/8DekJWhQwcbzBKflvsK6pROj75X37ZUT+CW5
	jexpLE4h7rFWpOGdryKvgZLS/stsC86+Wz1qY/GufIdMMKqjQ2vKNCaF2BGoItHsrIeS5dPjEjp
	hzT7nqauvFqrNMuhySvoVy6BsojJAW5aCD+9y+bWWHGVBt2oiOGilBEtSmI6DhkNEhjBM0Q7N8y
	iqjaUK1KpV5U55qWxd/ohcQD92nEdNuHflqViDoHnTInCi58Un8nOib/R9NxfSU4nZcGkz+yhNd
	w==
X-Google-Smtp-Source: AGHT+IHLa5NwfXi5dnqqkLy7rzURooInQ8xuzAG/o59NC1Gor95N1PBHwsWeLY58bDJyMi9BmZDSsA==
X-Received: by 2002:a05:7022:42a7:b0:121:a060:6d80 with SMTP id a92af1059eb24-121a06075f9mr28800733c88.25.1767384198678;
        Fri, 02 Jan 2026 12:03:18 -0800 (PST)
Received: from zubuntu.bengal-mercat.ts.net ([2001:5a8:60d:bc9:9ebf:dff:fe00:f8f2])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1217253bfe2sm120203795c88.10.2026.01.02.12.03.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 12:03:17 -0800 (PST)
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
Subject: [PATCH] wifi: mt76: mt7925: fix key removal failure during MLO roaming
Date: Fri,  2 Jan 2026 12:03:10 -0800
Message-ID: <20260102200315.290015-2-zbowling@gmail.com>
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

During MLO roaming, mac80211 may request key removal after the link state
has already been torn down. The current code returns -EINVAL when
link_conf, mconf, or mlink is NULL, causing 'failed to remove key from
hardware (-22)' errors in the kernel log.

This is a race condition where:
1. MLO link teardown begins, cleaning up driver state
2. mac80211 requests group key removal for the old link
3. mt792x_vif_to_bss_conf() or related functions return NULL
4. Driver returns -EINVAL, confusing upper layers

The fix: When removing a key (cmd != SET_KEY), if the link state is
already gone, return success (0) instead of error. The key is effectively
removed when the link was torn down.

This prevents the following errors during roaming:
  wlp192s0: failed to remove key (1, ff:ff:ff:ff:ff:ff) from hardware (-22)
  wlp192s0: failed to remove key (4, ff:ff:ff:ff:ff:ff) from hardware (-22)

And the associated wpa_supplicant warnings:
  nl80211: kernel reports: link ID must for MLO group key

Reported-by: Zac Bowling <zac@zacbowling.com>
Tested-by: Zac Bowling <zac@zacbowling.com>
Signed-off-by: Zac Bowling <zac@zacbowling.com>
---
 drivers/net/wireless/mediatek/mt76/mt7925/main.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index 13156333431d..11c0197c7426 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -597,8 +597,15 @@ static int mt7925_set_link_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 	mconf = mt792x_vif_to_link(mvif, link_id);
 	mlink = mt792x_sta_to_link(msta, link_id);
 
-	if (!link_conf || !mconf || !mlink)
+	if (!link_conf || !mconf || !mlink) {
+		/* During MLO roaming, link state may be torn down before
+		 * mac80211 requests key removal. If removing a key and
+		 * the link is already gone, consider it successfully removed.
+		 */
+		if (cmd != SET_KEY)
+			return 0;
 		return -EINVAL;
+	}
 
 	wcid = &mlink->wcid;
 	wcid_keyidx = &wcid->hw_key_idx;
-- 
2.51.0


