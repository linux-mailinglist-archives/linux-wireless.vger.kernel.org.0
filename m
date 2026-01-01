Return-Path: <linux-wireless+bounces-30261-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 61D4CCECD9D
	for <lists+linux-wireless@lfdr.de>; Thu, 01 Jan 2026 07:26:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B0A51302EF68
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Jan 2026 06:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB0F222A817;
	Thu,  1 Jan 2026 06:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dgmWqzn/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1597721CC62
	for <linux-wireless@vger.kernel.org>; Thu,  1 Jan 2026 06:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767248730; cv=none; b=VIWZFGhD6KuLFhYqbHwFz0snxrtloo228CAUWgAvtSoUBI3bLyzrcUjg9yz75n536bqzmySjWD/CmR6em5wM8Rk7Wv3hs97kbNQRozrsENre+jueDDZ0T4xP9sHAVsDZM8bj6ckrrGHzyvvhPWn1HiearqUBCqBaxjURoZIW9tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767248730; c=relaxed/simple;
	bh=wcmb1FEOOBYPubFb7fxU72z0oELyD36jEenfQJlFRws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X008Sj0XxyiIrhTTjXvlchNxag0K2/aL5kLU01E/YUzqywVx7DRyTCTuic59DbItUCGHc81UHkKtNw4UGGz7Dc5k8/fnUdOgsavI46HTIuNXiQd5crEERohIPSiBfyV4RDnZCl+e/8EetjJyFffl8iqzqVUQg+w5r+OGprRqIlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dgmWqzn/; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c3e921afad1so455892a12.1
        for <linux-wireless@vger.kernel.org>; Wed, 31 Dec 2025 22:25:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767248728; x=1767853528; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eSmHMTLFLYMPOGJAvXcJayrP61cSU9U9a7LGizFttZk=;
        b=dgmWqzn/mRrIFOOYPkaBblv58QjWkVrOHog4F7sKFC1Re3T1yLFC876Zbt+k4LULJt
         nK0dn/4Tfthv7+25UmSCp7L4RK79LgDNXwh+74i/gu6Gx9O+eOoPXxS3569u20EC3zsm
         6BhUnNHTgpAfj317G7gUG55VCYvEs/AWoIjc6R161/jBmCHUn+n5D5xMZNfoR9FYrw/+
         DE4HNMQobVixmJ4txpSHlj2SO5iokFVAjDMh125c7NfWL13jfNrp2vXVVXkwOwFqElGI
         rtrRv/GLd9Wy0OuIpmpVghQ8JycFK6SirrHA+KTks8pg7vn5yyIX2lcsBO4RT8KtfXc5
         +yUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767248728; x=1767853528;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eSmHMTLFLYMPOGJAvXcJayrP61cSU9U9a7LGizFttZk=;
        b=GhGWJmlywRe4qhTGbHb/a2sdAOn5rQloCYSR6C0EUmxFbRFlNOIQ7+q+1vWwQSvIVu
         WK+6OGcwTXQD8RB+kMuqgnp3bnWvOPpPs98AH9qwdV4kqzLFnX09RGfQ8QS+GLsegZEv
         ukmZltsBaafiiqGpAY7lz5fiqmAGKuC+SPbEhziYoqPEO6aQ6fDE1zwyADDSHonKXGOt
         ktJzsnn6HVY+BIOjrDc101U/SyIWpzJv/mgljgIUrDEkFGZswV+2r7xokRZJBN97EaP0
         Jj1L3/B/UmRc2hyONWJcEIKXeQmeaXOdM5L/WjDyo7c6MXvSDRcdSvyFyQlZfg2Fd3LU
         W6fg==
X-Gm-Message-State: AOJu0YzzK3STgFcAWgiif+CNsuNGdUG6rp1BYrzqPc94Nhwd2jgFtBkN
	nlZIxNUM6GOb/Y2f/gsEdCUfKODRAHGccQZb2HctHR2uUe0YBy9o8T5DMhQr6ZY0
X-Gm-Gg: AY/fxX7xEmnxrq8iMEk05MhWOKJBFiFK4jZaHpccDRQp8GqqwNktOQJVUaH8l5hh21g
	N5BewDSJMukrtmSlXAt+/SH/s9ljBc087X8YWgO7pY+osaPELWp8NdM590KKTsdPNyPVBzYbj3v
	/9q0wZFdeFnEGt518t7yrh9pFZhH+qbh7E8i0ZLjoA/3IY6Oz2YEj9DUYXfJMp7O18DXdmjJeg4
	0eP1dhBVFvB7b5ZuW6EC+jvLxb2BiBCDGbeWhKtJgqzWwIjFEzoJZesy6bpRWzbhn0RdTWqYGHM
	vzpFpexd5l5ZNdfOiYEVsmXlbHydLbEZGC/gUX+DZHfgRmc5Xi7r3xYR6lS+YT0k4nD47V48KMg
	pKX1m4cQgOZolq+VAdtPCvMfbxotdWAGA1ZSwMwAiqCHJET03uFRU6WqKCJjAZGNLurL1UyMDzH
	z1dRi3S6Cy9i4xUmYI9WfcOdyaIgNNnNn8JLgn+S+unSDsSOJvoxvQTee9g+RY/A==
X-Google-Smtp-Source: AGHT+IFh5Ad9Hf+dAEhjt2TJYJtae2RoTDAfQaXTCyF1NBh3Q++Urs2DK2jMl3q8CvHI8h3zssad6Q==
X-Received: by 2002:a05:7023:907:b0:119:e55a:9c06 with SMTP id a92af1059eb24-121722e89ddmr39548902c88.34.1767248727941;
        Wed, 31 Dec 2025 22:25:27 -0800 (PST)
Received: from zubuntu.home.zacbowling.com ([2001:5a8:60d:bc9:9ebf:dff:fe00:f8f2])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121724cfdd0sm144361662c88.4.2025.12.31.22.25.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Dec 2025 22:25:27 -0800 (PST)
From: Zac Bowling <zbowling@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kvalo@kernel.org,
	lorenzo@kernel.org,
	nbd@nbd.name,
	sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	ryder.lee@mediatek.com
Subject: [PATCH] wifi: mt76: mt7925: add error handling for BSS info MCU command in sta_add
Date: Wed, 31 Dec 2025 22:25:24 -0800
Message-ID: <20260101062525.186192-2-zbowling@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260101062525.186192-1-zbowling@gmail.com>
References: <CAOFcj8Sad3pLohFfRdj5jzK3Zs3FAjFVBuzH=80i_m1YqSbpfA@mail.gmail.com>
 <20260101062525.186192-1-zbowling@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zac Bowling <zac@zacbowling.com>

Check return value of mt7925_mcu_add_bss_info() in mt7925_mac_link_sta_add()
and propagate errors to the caller.

BSS info must be set up before adding a station record. If this MCU
command fails, continuing with station add would leave the firmware in
an inconsistent state with a station but no BSS configuration.

Reported-by: Zac Bowling <zac@zacbowling.com>
Signed-off-by: Zac Bowling <zac@zacbowling.com>
---
 drivers/net/wireless/mediatek/mt76/mt7925/main.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index d966e5ab50ff..a7e1e673c4bc 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -899,11 +899,14 @@ static int mt7925_mac_link_sta_add(struct mt76_dev *mdev,
 	/* should update bss info before STA add */
 	if (vif->type == NL80211_IFTYPE_STATION && !link_sta->sta->tdls) {
 		if (ieee80211_vif_is_mld(vif))
-			mt7925_mcu_add_bss_info(&dev->phy, mconf->mt76.ctx,
-						link_conf, link_sta, link_sta != mlink->pri_link);
+			ret = mt7925_mcu_add_bss_info(&dev->phy, mconf->mt76.ctx,
+						      link_conf, link_sta,
+						      link_sta != mlink->pri_link);
 		else
-			mt7925_mcu_add_bss_info(&dev->phy, mconf->mt76.ctx,
-						link_conf, link_sta, false);
+			ret = mt7925_mcu_add_bss_info(&dev->phy, mconf->mt76.ctx,
+						      link_conf, link_sta, false);
+		if (ret)
+			return ret;
 	}
 
 	if (ieee80211_vif_is_mld(vif) &&
-- 
2.51.0


