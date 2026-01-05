Return-Path: <linux-wireless+bounces-30335-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 49470CF17DF
	for <lists+linux-wireless@lfdr.de>; Mon, 05 Jan 2026 01:29:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4E4E3301C08B
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Jan 2026 00:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39EE924DFF3;
	Mon,  5 Jan 2026 00:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KohLd1BW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA051A3166
	for <linux-wireless@vger.kernel.org>; Mon,  5 Jan 2026 00:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767572830; cv=none; b=CUJA2izuxUOxOacohiO2ti8Pbj6FONPekgfZaZRoA8l90OjN5IuaDyexitRGSM1iNw3S7E+6jhyx8AfZHHmGlSWutiDHFgnUP0WhxPQFvWgmfuQR6VFOihHLNl0FbgXYxrnI+aS/HcRIyL1ifr3AaUixbb69eW5JAkVhWid2Nz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767572830; c=relaxed/simple;
	bh=Mn6R5G7/0GZb7sQn1kV9FKhJoDRPHViL8xHRuPLA7ic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R7bihbvALZb2icNQWr0lVet0dYFj99hbnCj0KPF+/uz6/pLw4rfz8kViYWQ03OnS+7B2IQO1gw8S784PlkVo+ZYxwVvDQ/FNwHjRbBbm5u2A4jSdto28p9MLPZd8DrVNzu7HPNVF9mWR1Jz6lejBa/48AbBsbme7WeySC+hN2G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KohLd1BW; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-bd1ce1b35e7so9401824a12.0
        for <linux-wireless@vger.kernel.org>; Sun, 04 Jan 2026 16:27:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767572825; x=1768177625; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j8HRHCajxeLrhtL1S291ZrvpdmCzir8N7qq8yDbrsMI=;
        b=KohLd1BWq8iHBoGztlipypYMP2gMmh+KRL4m61bDLPm5MFHRGPZ7CJmbTN/g8LfcAA
         fyzJFotxBmSy7jcfp04pAI1DxlKtW1uykoDjlKUgq/YZThHdkV1eWEVF2Ne+w7OA4w4E
         QmC3n9VG/vgELNC36p086pzNi2g4ZRFcqpMLdkGnM/fNk7qhs0wK06LyneqmG0G0vERV
         4fjevZvEarfdKHBQjd17Bkq6tI+L6Hzowa1h1YzFRL/c21Dn0752ApeiKN7dDOmqStmg
         EhRrseM4WTT4cADF7BFKGLVriy2mtuxNDppO36sf9KC+TvT06L1jvA8mHiSdlVWtlX3i
         bXxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767572825; x=1768177625;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=j8HRHCajxeLrhtL1S291ZrvpdmCzir8N7qq8yDbrsMI=;
        b=i20znhW41Wsls+c1x5owC0AJPTk/lmab3h+V6Xcy+ktOBNylJJkBNtyCp7/ctoGH6Q
         vxnIrbHsWY52Y4ZwFULf5bRy1RX0RetUc8rAS2iVjMy7HFrXdzlpf+vBYiVP2NwDB7BR
         SwqM0pqaDYoK0tHVC6KeT1W9jlKYgvUWuFaLl2kJ2H1VWSrRtnZJARfKQKjTkjPxZK/x
         +rQAtzkNbHdvOqHGKYWiEwy2kREjwb2NJ1XhQXtYjlepEcCkTGqqWSH7bnLszYSop2pe
         KmgCMnZGplByxSr0no0Mwt/UEeYKo33bns4hslKWm+mc1rr0WwVWZDCNH/9EmCCE2gpg
         4osw==
X-Forwarded-Encrypted: i=1; AJvYcCXYYO/5NZlvY/b0HyZpiXhbvcA4b23cOrZSJZu7Ra1EQle3jAr/Zrg0gPqQNfYP9f1Ny1imGMzBcP7Z545IVQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwFTbS3aRIO7eOMwJIRVHpV+9soMiTpvaxXQTSmXt9UdQGLrL0V
	X2BVI0m/h/eUQj5WoamQxq8Nn6eZtVp+IYRcpr1CEmNt/zqYAooigim9
X-Gm-Gg: AY/fxX7ez2Re1Q8noEK0Jzx1Z7rECrYHwemPYrPh5t9PLeBVOi5PuAwJOsl+xdcYf9/
	3aMdSGJYBkr2LHF6/UvrWq6qhQUeQ+CA2dPy2rGjQFiLv/zgBcAOtdxNTbuwUl6pz0ru5qkWa3a
	gRY7WwPIAanZ4akatHjCfKCDK7XKkmW96xhRep7U8ZRu/wvJ6BXqnHbpv5vBfa7qKtu885clvjo
	pSXD0/05SwDDeHGfjJU8uf9DVoaNZNnWgmNg3LQVjC9+/5t0hIOghAIfkxqpi6je46XNgw9uObd
	os3AOkSRO7boXPC7cZRE5MWkTEcT5DZslSKgGwPvyDpGxG5yqUfsdg1XHJivItxJUdYLXCIj73p
	Cr3vggaquvexmmiW/ewiz4wJCl69l+B62i3+e1+UdKY9s74eJVQ3CZbjKqgNpnOd/FpJt5C6p/A
	e5bUQjhmHZdzyEv95Bu7aZi6ER2GEQ1fsX0LaHHhKj1EduQ5SzCOTiBZpvEvyg8Lg=
X-Google-Smtp-Source: AGHT+IEY0zZXsw28HdBCqO5suui0ZQArzOaey4A7hNOTjMt9GTJKdAkyGN3WU76yNJIYmYwh3R5SvA==
X-Received: by 2002:a05:7022:f00b:b0:11a:126f:ee78 with SMTP id a92af1059eb24-121722fd228mr49567544c88.34.1767572824695;
        Sun, 04 Jan 2026 16:27:04 -0800 (PST)
Received: from zubuntu.bengal-mercat.ts.net ([2001:5a8:60d:bc9:9ebf:dff:fe00:f8f2])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121724de268sm133378109c88.8.2026.01.04.16.27.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jan 2026 16:27:04 -0800 (PST)
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
Subject: [PATCH 13/17] wifi: mt76: mt7925: fix kernel warning in MLO ROC setup
Date: Sun,  4 Jan 2026 16:26:34 -0800
Message-ID: <20260105002638.668723-14-zbowling@gmail.com>
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

mt7925_mcu_set_mlo_roc() uses WARN_ON_ONCE() to check if link_conf or
channel is NULL. However, during MLO AP setup, it's normal for the
channel to not be configured yet when this function is called. The
WARN_ON_ONCE triggers a kernel warning/oops that makes the system
appear to have crashed, even though it's just a timing issue.

Example kernel oops during AP setup:
  WARNING: CPU: 0 PID: 12345 at drivers/net/wireless/mediatek/mt76/mt7925/mcu.c:1345
  Call Trace:
   mt7925_mcu_set_mlo_roc+0x...
   mt7925_remain_on_channel+0x...

Replace WARN_ON_ONCE with regular NULL checks and return -ENOLINK to
indicate the link is not fully configured yet. This allows the upper
layers to retry when the link is ready, without spamming the kernel
log with warnings.

Also add a check for mconf in the first loop to match the pattern
used in the second loop, preventing potential NULL dereference.

This fixes kernel oops reported during MLO AP setup on OpenWrt with
MT7925E hardware and similar issues on standard Linux distributions.

Fixes: c5d11e4a9fa8 ("wifi: mt76: mt7925: add mt7925_change_vif_links")
Link: https://github.com/openwrt/mt76/issues/1014
Signed-off-by: Zac Bowling <zac@zacbowling.com>
---
 .../net/wireless/mediatek/mt76/mt7925/mcu.c   | 20 +++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index 958ff9da9f01..8080fea30d23 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -1337,15 +1337,23 @@ int mt7925_mcu_set_mlo_roc(struct mt792x_bss_conf *mconf, u16 sel_links,
 	for (i = 0; i < ARRAY_SIZE(links); i++) {
 		links[i].id = i ? __ffs(~BIT(mconf->link_id) & sel_links) :
 				 mconf->link_id;
+
 		link_conf = mt792x_vif_to_bss_conf(vif, links[i].id);
-		if (WARN_ON_ONCE(!link_conf))
-			return -EPERM;
+		if (!link_conf)
+			return -ENOLINK;
 
 		links[i].chan = link_conf->chanreq.oper.chan;
-		if (WARN_ON_ONCE(!links[i].chan))
-			return -EPERM;
+		if (!links[i].chan)
+			/* Channel not configured yet - this can happen during
+			 * MLO AP setup when links are being added sequentially.
+			 * Return -ENOLINK to indicate link not ready.
+			 */
+			return -ENOLINK;
 
 		links[i].mconf = mt792x_vif_to_link(mvif, links[i].id);
+		if (!links[i].mconf)
+			return -ENOLINK;
+
 		links[i].tag = links[i].id == mconf->link_id ?
 			       UNI_ROC_ACQUIRE : UNI_ROC_SUB_LINK;
 
@@ -1359,8 +1367,8 @@ int mt7925_mcu_set_mlo_roc(struct mt792x_bss_conf *mconf, u16 sel_links,
 		type = MT7925_ROC_REQ_JOIN;
 
 	for (i = 0; i < ARRAY_SIZE(links) && i < hweight16(vif->active_links); i++) {
-		if (WARN_ON_ONCE(!links[i].mconf || !links[i].chan))
-			continue;
+		if (!links[i].mconf || !links[i].chan)
+			return -ENOLINK;
 
 		chan = links[i].chan;
 		center_ch = ieee80211_frequency_to_channel(chan->center_freq);
-- 
2.51.0


