Return-Path: <linux-wireless+bounces-30870-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CC0A9D297FE
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jan 2026 02:06:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D9B8C3027265
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jan 2026 01:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0566320CA3;
	Fri, 16 Jan 2026 01:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PPJXptpw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15B7314D22
	for <linux-wireless@vger.kernel.org>; Fri, 16 Jan 2026 01:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768525549; cv=none; b=gETlbnK8yzG2KWJNG+qyrmbYw9bIafgUPdy8ozmheC8zC0HliMuhDnFkFIAKdoJYchq7zhRjFVnAEvSak8faLxVxX0fPPcHsQJq7bz5Zr523NPW/RzMV23eEPndxUvpdcz539lgJxFcHIGYftYZTqa8gK870zLRerZsiyi0hmJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768525549; c=relaxed/simple;
	bh=RL2egL+gt/RYZ+mDWmObhYGMsncwjLrPK8QRWukDVTM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dw6w6mECBpcJTEUKHNp23hn4XLKANjgkdyRW4JbfMoiZG8YEil/zeKGss7K/3rEUIV6RwTmXJWSKhi6E6YzNJBuSHOI9EtLpS+lZN6dO4I6+oY9bntmxctqP+hMFjiwhLTB9rRaCYqkf1cVVliW+3QDWghsKTz+ZqfHU5n68tX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zacbowling.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PPJXptpw; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zacbowling.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2ae287a8444so744583eec.0
        for <linux-wireless@vger.kernel.org>; Thu, 15 Jan 2026 17:05:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768525541; x=1769130341; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SmoSCGQL2mRlPPuo0uD512LAshqRjYzmZB3+T0TG3ug=;
        b=PPJXptpwWOI/pWfflSYTHtGDLMOQp+dr2qSkO3m/IhF2uORooGcJFeVVPJkG9bq3SL
         1EQZsiNHvoL1M2/4Whf8u+Z+54dRe0VKDQ14tCHWUqSjM9TXg2lFYVasl7Iu10KKiRwa
         SrgenHXxBzc331kg2e2q0DAAfFiU6AMut/ppoVolMns2aJ3Qstl4EgGi/eoaRsnPz2oe
         pgYkA/QCw31d8nvM6yxsMYfyAjY/m9O2fj0iJfvFDqYcuJZ+cMQOKUG3qHWD8GrqwOd3
         GVWEwAXmTZWiTDTXwCPzdz0YRtsS6vk8ZvXfOtV9YUeSqAnzUXgltMLdIY0UAcyxw45l
         D9nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768525541; x=1769130341;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SmoSCGQL2mRlPPuo0uD512LAshqRjYzmZB3+T0TG3ug=;
        b=V6Rj1jWoRf0JlKkZiXnr9tWIwVJgUL11teDqSH6A5WGzF1b6pSjS0I1gKZ8ZXHn7c4
         c97LN/DXIY8ZDXl2vT2z8X/P8bxD7LmMx37329/spcMDhVliBZ9XNZklTZewocv4OZPO
         qU8WkKB0XTcrP7M17ID6DCJvEVzojYB029ijBBkJQ+TL9aENZTtGGQooY05RQtlrmXN3
         n81NaKOhHqDvm8V70PMxz996js8NV2gQ+5aW0dbWJiHFroV2Gh4cBEXI67+NqZY2giV3
         qY9mXYxUGdN1PqOdvrZSiG4cscYQoqAkeLRFQVm2Bq8UvWxZzW3+uSKf/YtYqSPwdDJY
         eHmA==
X-Forwarded-Encrypted: i=1; AJvYcCXTqhey8EXvY/+E2ES9j/VAx9GSeIHu8ix9fl02hMBvQGIB9iVKp8ECIaO4FlAwre+yOqmaHkYdGBo70fDgIw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyARfINXdqNAL4SjNF7hxn53qxiv+MftNS3KbL/nF1RDdbMZmNt
	oWgcpUrBdsDj31M1Ldg/C2eYtqZ6kNLB+u/s3CZcjlFAv2b29nkts1GJ
X-Gm-Gg: AY/fxX7wWNZlca/XUziEewCFRAPJJ3eqZKHqnqmXqiJcnsFTQVJkXLA5B+gXgrnZAO/
	fxcaJDPXEMqRSH54fvmXsNlWFKbJLOMHUh489KyKVdDrSMX1khmVoOMxR/23r8CRF6DHKj0F4N9
	hOtL0JME8StXUdVbBmm8Z/RvBa2z6aX8XqElG4Yxc7L9cL4Ea8S6FoTL+MErFd5v8ce4gF4NWPf
	2+daaMlV6DZ1kN5gpfakE+wqznLUVE2uoUOmQ5xxgyTVZ9rn8mQQK7u79QtrKOAt7SbltkAkTXG
	RGi3dJHYEJ90651/a82uiqqZ3+awPV2aQJOqdD+416/PB8uaGNvQ7Z5lVK1d70u73l6NxxecuV1
	9PCw5ozZhKaBxp9/sQ+31SI4wjyXWedY81F/l7MfCqraZj5QYW1ywmXrTCBBEiG5UBsIoC4K97Z
	tbDPkoNkg08O8/HURGEn8lIoowoPG2som/wHu2WGvWJiK/15YyOdSb/Nc2x/icGQ==
X-Received: by 2002:a05:7300:5353:b0:2ab:f490:79f9 with SMTP id 5a478bee46e88-2b6b35a1060mr1657052eec.21.1768525540952;
        Thu, 15 Jan 2026 17:05:40 -0800 (PST)
Received: from zcache.home.zacbowling.com ([2001:5a8:60d:bc9:f1d2:502c:a6ff:5556])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b367cbc9sm1019884eec.32.2026.01.15.17.05.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 17:05:40 -0800 (PST)
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
Subject: [PATCH v4 12/21] wifi: mt76: mt7925: fix key removal failure during MLO roaming
Date: Thu, 15 Jan 2026 17:05:10 -0800
Message-ID: <20260116010519.37001-13-zac@zacbowling.com>
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

During MLO roaming, mac80211 may request key removal after the link state
has already been torn down. The current code returns -EINVAL when
link_conf, mconf, or mlink is NULL, causing 'failed to remove key from
hardware (-22)' errors in the kernel log.

This is a race condition where:
1. MLO link teardown begins, cleaning up driver state
2. mac80211 requests group key removal for the old link
3. mt792x_vif_to_bss_conf() or related functions return NULL
4. Driver returns -EINVAL, confusing upper layers

Observed kernel log errors during roaming:
  wlp192s0: failed to remove key (1, ff:ff:ff:ff:ff:ff) from hardware (-22)
  wlp192s0: failed to remove key (4, ff:ff:ff:ff:ff:ff) from hardware (-22)

And associated wpa_supplicant warnings:
  nl80211: kernel reports: link ID must for MLO group key

The fix: When removing a key (cmd != SET_KEY), if the link state is
already gone, return success (0) instead of error. The key is effectively
removed when the link was torn down.

Fixes: c948b5da6bbe ("wifi: mt76: mt7925: add Mediatek Wi-Fi7 driver for mt7925 chips")
Reported-by: Zac Bowling <zac@zacbowling.com>
Tested-by: Zac Bowling <zac@zacbowling.com>
Signed-off-by: Zac Bowling <zac@zacbowling.com>
---
 drivers/net/wireless/mediatek/mt76/mt7925/main.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index 852cf8ff84..7cf6faa1f6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -605,8 +605,15 @@ static int mt7925_set_link_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
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
2.52.0


