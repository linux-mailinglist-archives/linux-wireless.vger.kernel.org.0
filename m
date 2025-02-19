Return-Path: <linux-wireless+bounces-19138-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FD6FA3C6BF
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Feb 2025 18:52:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E213179CE7
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Feb 2025 17:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13C651AF0D3;
	Wed, 19 Feb 2025 17:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=easyb-ch.20230601.gappssmtp.com header.i=@easyb-ch.20230601.gappssmtp.com header.b="rah0spJ/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FAA71F2B8B
	for <linux-wireless@vger.kernel.org>; Wed, 19 Feb 2025 17:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739987556; cv=none; b=iIRbKyvgQePZONKyFdetSyDuIpXbCvw/FVDDPplCn8fVvs/HL+vKYeA9mkzqZX5VBor/IVQ5I82w1bfRRDK+qLCzzQeesbm9tdjaiPqQIV4MoqdMrzUDe97O5MqIS9N/3lm8LoTUMD12/rgnhJx3ZWgYQo9mjxoanlvmfQOfnTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739987556; c=relaxed/simple;
	bh=21LQJXb7mkkqAMmzdeLQdjPVir5g5c8UFmI4NMMD3xs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s+mBP5c4FCQRAikEj8V3FTJB+9bjSrlDxS7rZ2xwTy/Hwy4TbyuT4GkVdkesVterouMLh70hgwDEBx9q5jX7fievkSKIuA85tK5f11Ok6Ph9HTYualkbHXKafYpUgsOd8T7oYKAXU7f6uUU8Ai7zPgCUwnftVdudHIee9NaBfw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=easyb.ch; spf=none smtp.mailfrom=easyb.ch; dkim=pass (2048-bit key) header.d=easyb-ch.20230601.gappssmtp.com header.i=@easyb-ch.20230601.gappssmtp.com header.b=rah0spJ/; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=easyb.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=easyb.ch
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4399deda4bfso277085e9.0
        for <linux-wireless@vger.kernel.org>; Wed, 19 Feb 2025 09:52:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=easyb-ch.20230601.gappssmtp.com; s=20230601; t=1739987552; x=1740592352; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IOEYmTmZqRga/omCDeyKG84sTaAdnXOAPAKOv0yeLag=;
        b=rah0spJ/PXQ7xbMUxyhRBQjBjaLGBROxtVtf/aOKFpWKUTsuOFsioMBed1NmALFxAZ
         N4ib6hJTrlbrFA9wYJRYkngn4pW/86U7BlYM/FgYlL0wH7IF7UMlDuBOjvJY5sqfn901
         L5L5BX9DLrRSWDX3QUnF9V1vtBsv4+BrdCMqST38/1K7TWpV6zOqMF2FRH7otE/Amt+K
         kwzNoSZrFnpdjm+kOy7jeqhBd3zE3PaMRbCAa93dgz0fNF8EPxujgEofWGie1R2d0Ilh
         8LM2+Ln16p/d6QPe8tI9TbgW6l7XOJ7AblqwhvEx8KyCQthzYybhT3DF6RAyIPgiV0q5
         raEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739987552; x=1740592352;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IOEYmTmZqRga/omCDeyKG84sTaAdnXOAPAKOv0yeLag=;
        b=sxdH78CzP76WM0z3poY+Yrxvk2QDd0txEsmQQbiL9Lu+yBFPlI+VT9FXrSeM4EiWl2
         h9MtillFtl2IKWu1KJWZ96L5hO1yQi8J2H+W9cOKxyv3YLVySfQ2kenqRangS8jlPmIP
         pVT+Cx69tu3TxAc8lcqTcNwm4NjPYzLM5xTIXkMF0XY8He/LFmDQXfrTQBpObX/vBw5g
         s7dRLApQs1NX0NvMfOJ7GNkaG2WrZDppo1EfRL4UAfdKmstUmWHscb4q4gZLLM4W8hTg
         WT1WWGKRW3z369iUQ16WtNvH48OncUqj0VBD89fsqe00Unxew6Pl/CDtyzuJHbMd4IAs
         Z+WQ==
X-Gm-Message-State: AOJu0YxRX2FgahAU4rUMKYPWuZJpVXyQdNrM7fqTRyycx+8HDc1iG16m
	LVa+Ywa9ttJ9uwwTMOff2+3Bjgfu5fkXWj+RjId5pd5N71PvClRhKOr99/Lnw+SKAFYo8/ZFbz6
	UDuk=
X-Gm-Gg: ASbGncsjUVuJ1jsU01dBhcottcOjhgRjGBzv+EWeJWz9X8bbCgzXqZm3WSqusyg6whA
	V8569D68yN+hCa0ABhrESNDvZoyhbuYe5BcL6cpbGtDKHi8deGbufJZT93QLammC46QNASsyQ9b
	hj8onNF7ZJ43W/ftx+52BvzwonmZ9Z6LtncMezxtQpJjJP98YHTJ/vTi1sids5P9pq7rPTznKBL
	SL0gaef2Rter7v9eXH0GJzBX9bQmMGDJFsgJn5t/q6A/iLA8m0n+1EKuWPZU5aqWNbOgKhOjR88
	c9ND2M1wyYbL
X-Google-Smtp-Source: AGHT+IHJVbxlGTB5O+8hMVf5n2s2kbHakXXQSbPrnyVL3/0tHsv3QrbSwLgv23ZYhU6I2Kl8m1iumw==
X-Received: by 2002:a05:600c:4f86:b0:439:9a40:aa16 with SMTP id 5b1f17b1804b1-4399a40ac91mr44892895e9.16.1739987551917;
        Wed, 19 Feb 2025 09:52:31 -0800 (PST)
Received: from fraxinus.easyland ([2001:1620:4675:0:25b:f7ee:9a39:7e51])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43983264ef8sm99269695e9.4.2025.02.19.09.52.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 09:52:31 -0800 (PST)
From: Ezra Buehler <ezra@easyb.ch>
To: linux-wireless@vger.kernel.org
Cc: Jes Sorensen <Jes.Sorensen@gmail.com>,
	Kalle Valo <kvalo@kernel.org>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Martin Kaistra <martin.kaistra@linutronix.de>,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Reto Schneider <reto.schneider@husqvarnagroup.com>,
	Ezra Buehler <ezra.buehler@husqvarnagroup.com>
Subject: [PATCH v1 1/3] wifi: rtl8xxxu: Use macid in rtl8xxxu_update_rate_mask()
Date: Wed, 19 Feb 2025 18:52:26 +0100
Message-ID: <20250219175228.850583-2-ezra@easyb.ch>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250219175228.850583-1-ezra@easyb.ch>
References: <20250219175228.850583-1-ezra@easyb.ch>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ezra Buehler <ezra.buehler@husqvarnagroup.com>

This is needed in order for AP mode to work correctly on gen1 devices
like the RTL8192CU.

For more information, see the corresponding change for gen2 devices,
commit 769f326322e7 ("wifi: rtl8xxxu: Add parameter macid to
update_rate_mask").

Signed-off-by: Ezra Buehler <ezra.buehler@husqvarnagroup.com>
---
 drivers/net/wireless/realtek/rtl8xxxu/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/core.c b/drivers/net/wireless/realtek/rtl8xxxu/core.c
index 569856ca677f..cbd9efd22e3f 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/core.c
@@ -4606,7 +4606,7 @@ void rtl8xxxu_update_rate_mask(struct rtl8xxxu_priv *priv,
 	h2c.ramask.mask_lo = cpu_to_le16(ramask & 0xffff);
 	h2c.ramask.mask_hi = cpu_to_le16(ramask >> 16);
 
-	h2c.ramask.arg = 0x80;
+	h2c.ramask.arg = macid | 0x80;
 	if (sgi)
 		h2c.ramask.arg |= 0x20;
 
-- 
2.43.0


