Return-Path: <linux-wireless+bounces-30301-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D4D23CEF445
	for <lists+linux-wireless@lfdr.de>; Fri, 02 Jan 2026 21:05:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EE12D305967E
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Jan 2026 20:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A04E31AAA8;
	Fri,  2 Jan 2026 20:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F721D7cn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EEA82EDD63
	for <linux-wireless@vger.kernel.org>; Fri,  2 Jan 2026 20:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767384206; cv=none; b=dkBrRJzOQ4LFn3fjCvdPRnzBzYMs7hlq/GtkJA6oHDEr9jdBQD75UabapZ0I28cG4m7RxKVkdr2bGmBL8eO7NuZnYlyZKDlxSTYDkC8bZ8tMccdsDyhCRfzhrd10mt1eoDZC64IE9Qm2zXszqIJGX+efHA4qXh2GM7Aw41WVx5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767384206; c=relaxed/simple;
	bh=cw8rk6kKEQyjbIA4Ch6Mou0UKqG7YDgnKyApEftbNtE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sio27eGYSP41PFa9pLmnBFuaOc73KHhLm43pBuoJdftewBGlmgUfkjmIHX5wUwfMmJwMhj4aozLi5t/pjwuGLUrwFqGxTwk8d44KOvDk7lpCKeXJnqqY54KI7ZFGqFoKEmf1/WDTVBJ5Dq9l48lfWz5ykW6ncAMJgQBMAoFZRuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F721D7cn; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7b8eff36e3bso19414945b3a.2
        for <linux-wireless@vger.kernel.org>; Fri, 02 Jan 2026 12:03:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767384203; x=1767989003; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rOTwbgpeLN5pXgDisgz/s6pvtJgX11/afdNTzS5QM/M=;
        b=F721D7cnp2CZPH5DjF6tic0P4cEIg8jvZ9G0vveMCNmhjKisw01i+pbK/8F7HL1pcV
         BLlJauWJTnbV09zxQ7ggWsNq6ynQ92YMkef7D4/vxbKXe+N00Q52zKsr7cHqe6+blhDA
         c11wgIsKHAaZKtRgfSF8LkRMuneuc6993wxbaRGUExRPHl/cZHhOUouK+wYL0E2oa+eT
         dNFuSm8//g+g5tEyzoB5CQnkQwJ+HZwZangk4HBXitWPKJ9Oqk2xQnG+C1nDWKWb3Kpj
         yfmAJexQ2nE2T9GcHygkbvmzXjfOKW6Gz3PqWF8RYkcXbSpY+OZ0OXEUv+s97adFENF3
         eXcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767384203; x=1767989003;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rOTwbgpeLN5pXgDisgz/s6pvtJgX11/afdNTzS5QM/M=;
        b=Wm1DOCcb9at2NvSJ9A0gPsswSOhLSPnZHclDBpShuy+jd8lkiddg5107PzMmGgDN/+
         PnjfSIBRyllm6XrihKg1APUE6pHluoF/3EgRInN7ZWrCbncj7JflLJJ2ySkmXB8FG31X
         vPBy0W0MmiSIq07Xoi9NDeVW+hONUOtM3RG217cCHRC7xORgbuYnBh55TP/64mvv9Ej6
         yeE3cvKTQ4fbnidw681I7krGRZ+AqdZrwjUrlYF4amY5729EESH97NQRKfbQw3SLouKi
         vFLFCzG27R0Q7l0cvk9LiID2TmUkLjZ51CBkEeRs29S83pFC3R0seGwG1zaLaqJ7dYzR
         camw==
X-Forwarded-Encrypted: i=1; AJvYcCXPj6Vf5J+07CR4Has3ALH2iLfzXixUH5XYIv3/nPiP4TXk/yGeAxdU4oMKGYlVY20mYGggonUJFO5m1G8NxA==@vger.kernel.org
X-Gm-Message-State: AOJu0YznBrb1RFanNEGZEp4/gpF2yoKpfLQZC0l8D+wzqpBHM2ICi1Kq
	WZj0ROWyjttfr6AyKxR6y/Mlk9CEu9/+MPRZF6avtVI5P+8IVhOyuryF
X-Gm-Gg: AY/fxX7kQfpz7pFNNvytfTcK6HDpwSly357NrlmnJLmvm9wAyr6pj0r47rspGrJPY8G
	7yrODUjMNJPhwxX+RPtOmm+jhOudN6DMroUppRnUg9ORdCpFzd+/TZMkpLt8kFoH7RhVqS+UP0F
	g8AFPkj3UvMHzNLIVrrOPYEYEAXo/PSN7YjZ98n4Kub4io/IXDzH3QeUBv5bj5iuSETmzUjMQQ5
	asGr6lhs+Whxzf3+9CZ+bpHmlQFkkZCiTSkIEVq+aaKjPqE/aG0I9N+1T+eo/1lN9NMCyGCYxfL
	Z8EV8i1u4I2JPpHhJLOfGZiZx5yEiXPzfXPvwazN96d/vHHFlKblQ56DkDgTsWAtoyWV6y0zZgB
	/kUNf3VhzZQFqbIOg2aQ/UD/FSoM6AzptK4lW06HHEv4Fg+g1hvEyWyrKKcJdDfXHlpqOu/v+Eo
	WGmEvj3F4twc5zFlAoGGAfFItlQB+RMHswnQcJOu108cERMYWMAqN1dmf4CMHZ3nA=
X-Google-Smtp-Source: AGHT+IF84sKN8CnkJa4viQsaxDmj4nFuQ05LM/gZRcXeDb11Nou8i1NdOUdfSg4R18Yx3AAJrxHd9w==
X-Received: by 2002:a05:7022:699d:b0:11f:3483:bba6 with SMTP id a92af1059eb24-121722b2861mr39252551c88.13.1767384203373;
        Fri, 02 Jan 2026 12:03:23 -0800 (PST)
Received: from zubuntu.bengal-mercat.ts.net ([2001:5a8:60d:bc9:9ebf:dff:fe00:f8f2])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1217253bfe2sm120203795c88.10.2026.01.02.12.03.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 12:03:22 -0800 (PST)
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
Subject: [PATCH] wifi: mt76: mt7925: add mutex protection in resume path
Date: Fri,  2 Jan 2026 12:03:14 -0800
Message-ID: <20260102200315.290015-6-zbowling@gmail.com>
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

Add mutex protection around mt7925_mcu_set_deep_sleep() and
mt7925_regd_update() calls in the resume path to prevent
potential race conditions during resume operations.

These MCU operations require serialization, and the resume
path was the only call site missing mutex protection.

Found by static analysis (sparse/coccinelle).
---
 drivers/net/wireless/mediatek/mt76/mt7925/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/pci.c b/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
index ca868619e1b7..b6c90c5f7e91 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
@@ -583,10 +583,12 @@ static int _mt7925_pci_resume(struct device *device, bool restore)
 	}
 
 	/* restore previous ds setting */
+	mt792x_mutex_acquire(dev);
 	if (!pm->ds_enable)
 		mt7925_mcu_set_deep_sleep(dev, false);
 
 	mt7925_regd_update(dev);
+	mt792x_mutex_release(dev);
 failed:
 	pm->suspended = false;
 
-- 
2.51.0


