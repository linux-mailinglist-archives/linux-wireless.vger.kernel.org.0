Return-Path: <linux-wireless+bounces-30868-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AB8FDD29846
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jan 2026 02:10:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6E84A310DC5B
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jan 2026 01:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A5EC31BC95;
	Fri, 16 Jan 2026 01:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uz2aKADe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60BB315793
	for <linux-wireless@vger.kernel.org>; Fri, 16 Jan 2026 01:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768525547; cv=none; b=nb012t6x1uIrKZ/ZmFweWerBGRg5OpDCovN4QQIg/Q2PQK5V9Ij9vyAIkkWbu67pbAnZumCKkRBA8jeh6epUijE79emVc8168QmuftUI1/iceYXCjiNy9WfBesC6uMWAuw75L3mC0Qg4lSu9KHqYYfK2CTz/Mv9DSkaQvd3pXng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768525547; c=relaxed/simple;
	bh=THp17qwz/s7EuMJZ0CTg83KqAMU4k3KM+VZ16LR1b8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NUX6ohHZOMkt07o8mY4xF2vTL2QqIDrLUlU6yeZlq+LuNOhHAFsai/OjvkxHNe0jUtm5+ccGy7osEl4aGIBbBZJUADzR78zhof7HY6stW3diMIaq/y6cR2PO/KtLJD6yXRMNR79/afeQ2jNVBTBN/+1IDeOT+4PpmbLnYeJygB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zacbowling.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uz2aKADe; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zacbowling.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2ae38f81be1so2100459eec.0
        for <linux-wireless@vger.kernel.org>; Thu, 15 Jan 2026 17:05:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768525543; x=1769130343; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JxAIadq5UWGlyJvy2LxwAuNLP4e79ezvRvh2d89gw+s=;
        b=Uz2aKADeHtxbbg/eqh+megtI7cZm0ZofdtV9+eWnHla/X7B5c536TId2yAetKIBqqp
         uGdZnDMfMjZfpfqk/TN4idWv03NXRz8lQSQkRY0nxvKBZFTfOEgC/5Cwn5JxiOYJ2p4/
         bNwi/GCH3DyDawlBm/EZZom2St/1ze5sbJnxsriOtHdXkPkkqnco8BBegm4WM5gRwz6k
         aZA/KibnLjrcvfD1TBxyQ/rTNS7MKaUDcyf0Sh+kVqyUT9CMV4xyBe8L1A/ah7zowqDZ
         uQQRa/X2+QroK/w1A33ovTrvnMrEIWp96r7e1TSIocdVPiC+fDZWVtbE/E6pxPfL1u2B
         XsMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768525543; x=1769130343;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JxAIadq5UWGlyJvy2LxwAuNLP4e79ezvRvh2d89gw+s=;
        b=d/0ykJOX8MBr5BfS5ejkE1dJqgeCxI4GLQQ2Z4pbz7SCmc9ARwONr02oRv4iZIg9+D
         8VzUhd2vqqpm03EGPY0pM7Fpg4vtjwrpPNT/tCH9ulqrSG+oRoYdoAq7YrOJ7TPbqmfO
         W93dQRvzMgsv4IizWQXX/hqcsL2j1xpWxmJUkK+wE8xSERQsVN8+DrkADD1gS2I0PIM3
         HrZlaorezF1pPuOuCScrSSWZhYqI7V4TboWaAMhcCRSIJIyCb3gyf/A6tbEP6Q3QtEPP
         GrcEwTmONBf1BDI3dIZWsfU+pXWzl79aPl+xj95yqwmQHqqZbRQefg6kTeubAlSZyWPD
         m00w==
X-Forwarded-Encrypted: i=1; AJvYcCUOwiKdiRS6Z/D30yl+tnyBnpyqZ/znqM7NkA3nzE0YMHa1LTnfocd2ZeCCPCY34YcvOeovUBl5X4NV1esw2w==@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ5ODU4cel5vbruiO2ZdrypBvrdW+sJYzuNIk/JfclPcAwRZVN
	+ka6jSfyJ0EbzjQ+BKoAf1MCR1lSD9APMoBbxbZxZUov6Lg8lNsFCL42
X-Gm-Gg: AY/fxX6Noj4G8t0ulWTsnLWHodNL8H9EvRrdnW2lS4ln07RJ7LNIGfjnB6Rz23E8irv
	JJsJSYbAxNtpYhVGCg/JSTbronUF45fO9f3YeO3m8jhpM8jbFT7o1xisNDvhn7b4grReoIE5kyJ
	qS+VXTxqJZTGSZPrwFVd7x4wA916YRItbTJl3cnNdJPi6gqBQzDGQkeJ5DE0wAaCWSxXUL9KsYl
	zWx3ZQUqnttJLIROCVnJ2KKGMUH0W4z/iGAvgV2BdSaSZta1D6lKVluZw7cE/jWsIlLGuAbDqWC
	rwiplJd9nVEYj3zJQ/EtGBe6R2X5/jfOJ1JPRGTCx44HeoY0lhYrxaSyNGUnzV+r3pNOlZfZMPc
	MBUGvgVqELtMurTi2j4jZSnEoZyz31tX9wnlMnV3xGToVDzwCEDs67hKnIVH+d4rlBOHcAInqd1
	WK8LUFb4HO2R4s8TKhZ02gkPd2yxECavqVu+fFHz1UzweSQYqqLjiACBlIbYI49Q==
X-Received: by 2002:a05:7300:6d1f:b0:2ae:5cb2:cc11 with SMTP id 5a478bee46e88-2b6b46d33b4mr1489936eec.6.1768525542657;
        Thu, 15 Jan 2026 17:05:42 -0800 (PST)
Received: from zcache.home.zacbowling.com ([2001:5a8:60d:bc9:f1d2:502c:a6ff:5556])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b367cbc9sm1019884eec.32.2026.01.15.17.05.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 17:05:41 -0800 (PST)
Sender: Zac Bowling <zbowling@gmail.com>
From: Zac <zac@zacbowling.com>
To: sean.wang@kernel.org
Cc: deren.wu@mediatek.com,
	kvalo@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	lorenzo@kernel.org,
	nbd@nbd.name,
	linux@frame.work,
	ryder.lee@mediatek.com,
	sean.wang@mediatek.com,
	Zac Bowling <zbowling@gmail.com>,
	Zac Bowling <zac@zacbowling.com>
Subject: [PATCH v4 13/21] wifi: mt76: mt7925: fix kernel warning in MLO ROC setup
Date: Thu, 15 Jan 2026 17:05:11 -0800
Message-ID: <20260116010519.37001-14-zac@zacbowling.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260116010519.37001-1-zac@zacbowling.com>
References: <CAGp9LzpuyXRDa=TxqY+Xd5ZhDVvNayWbpMGDD1T0g7apkn7P0A@mail.gmail.com>
 <20260116010519.37001-1-zac@zacbowling.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zac Bowling <zbowling@gmail.com>

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
index 958ff9da9f..8080fea30d 100644
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
2.52.0


