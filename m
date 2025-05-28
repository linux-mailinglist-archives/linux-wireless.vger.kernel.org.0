Return-Path: <linux-wireless+bounces-23464-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C5A9AC6268
	for <lists+linux-wireless@lfdr.de>; Wed, 28 May 2025 08:55:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06BE31BA1E8D
	for <lists+linux-wireless@lfdr.de>; Wed, 28 May 2025 06:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D9051F8AC5;
	Wed, 28 May 2025 06:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Qi97K6Im"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F67206F23
	for <linux-wireless@vger.kernel.org>; Wed, 28 May 2025 06:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748415319; cv=none; b=t0+EDcthBnU3K4Sd2hHx7+65BwHPAnxT+1R4Ob6F+2KkxktsdvLey4mZYfXby/B6s+EWjPJpRU2cxADWzoVr6jGG2BBP6VKnz8lwuHtTS0nexdFOdVQJXkZwqIZS+UECeCAwiz1DX50A2DetBf22EDswZqmn1QpnpoE5MgE3roc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748415319; c=relaxed/simple;
	bh=KApm7B2lU6A0X4XyJobCSbS/ALi/O7hpGFyTN7IgQlM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KntFN/f+MlXD9NJKI9jGC/70AeAiZ76uVr3U+OWxjbG7YBkvqCewSBzKYfyIQNnqxKK1hjWDKry8U6I0IPdYqLh+wvsOjZua+P7HcvrYL1a+pE5mFybBV+uAOlqjGRPI4/u/Vjptva6GHO++rTXIdalpm0boZbjUY6EWvwENT0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Qi97K6Im; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2346765d5b0so27860055ad.2
        for <linux-wireless@vger.kernel.org>; Tue, 27 May 2025 23:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1748415316; x=1749020116; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6C+2QOW7/ZJEC4rlOPPzFqqXSyx5rUQG+Wyj+dRbRCg=;
        b=Qi97K6ImNTX8dDNEXUO0hcJ3ZkHZr94CcWPnXhpZztw3Po2w1Qzt74TqE+Q8HmhutI
         JK9tfWVLxgC6A961NIZ0xr8ZoDmb2nj5LGlLqBnoievnkEAlMLK4ObLqW4YD6xt82Zjx
         Fs4EaMVFJ+izZXUave0K1AK6xpyJR4lojAFrQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748415316; x=1749020116;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6C+2QOW7/ZJEC4rlOPPzFqqXSyx5rUQG+Wyj+dRbRCg=;
        b=TVXvwKs+u2xQPaBBmErUj6Yj5vHzV+eUJm0NYYYsY6bqzNcNBwpY9PYXqP9hYYhXiQ
         tmXxqo9djluLSVssMs6Vf0ZAtZySWE8pZEU01WLjuis3xwRHAhZCrmCCSNFeOkj//4dQ
         ZUscQAYlaA/+3KLkim6q3wCeXLH0yP4LvrTCJa4G1iVJrDuXPS4TPF/oqPfOWZ1jnU5U
         CgiyFTg7xnBZgXfAaLTpDyXPcNyhBKtFlHqBHjQd3ZqRflxmJm5OWh9c+OZI5nK4niLL
         XhMnkL2a7s7unAx874igF9Euasd/KRQaZeL7Ujb7yVfFxvRRgnSmmDdIDOLClrCtQD80
         Gwtg==
X-Gm-Message-State: AOJu0YyNPkdtmV1YrxaOHXcPMTcksrf7cjAX0tFfqMKZEo5mSK8SNiMy
	8KvjBmhNHSiV8i1uTML8tg+aKvo80IhvYKXJUIMV8hxTQx2nk8qAVQtqM9LzuVXM4A==
X-Gm-Gg: ASbGncvDN0cnATfLABZII+uOwkZ93xspUFWlPrKKQay7YmhKlOv2jnHfVNODTvnqz1M
	IyPCe92zfE2AVE+0z3497QTUoW4zRkifjTvuYiuvUz33TxwBINPD+OiE5pptt+xnxVvCG8xa3Jd
	J9pGePYUTc/RgY2dQCcSZ5+QwrId6rsHwyvxOjjK63UrohGz1m1fPqQAFjkktrNwkRTAfqnpwh3
	Mh4e/JyXIeqjd4LUUr0q7RY5E8gXJd7uc0X30kgZtKmoKmBmUtUa/jZApJJFeFMUlZkIkej7PPF
	9htg3xPGocfMuBMr7CUe8PNzWQfTBa04wFDTHM8q6gbfVso7yGVVhq4LEeDWRxssjMeWARzjFBc
	=
X-Google-Smtp-Source: AGHT+IE/QtR9qQUd+B8NC0qRL0iwl3NZ+QPWzLqIvwbbP5nfveyy0JEebh4jUyokCIMZHNZo9wpIvg==
X-Received: by 2002:a17:903:244a:b0:223:f9a4:3f9c with SMTP id d9443c01a7336-23414f3343cmr230103605ad.9.1748415315890;
        Tue, 27 May 2025 23:55:15 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:88fd:67f2:b90d:8b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-311e3da5c37sm670902a91.24.2025.05.27.23.55.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 23:55:15 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org,
	ath11k@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH] wifi: ath11k: mark reset srng lists as initialized
Date: Wed, 28 May 2025 15:54:27 +0900
Message-ID: <20250528065510.2790649-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.49.0.1238.gf8c92423fb-goog
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ath11k_hal_srng_deinit() frees rdp and wrp which are used
by srng lists.  Mark srng lists as not-initialized.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/net/wireless/ath/ath11k/hal.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/hal.c b/drivers/net/wireless/ath/ath11k/hal.c
index 8cb1505a5a0c..cab11a35f911 100644
--- a/drivers/net/wireless/ath/ath11k/hal.c
+++ b/drivers/net/wireless/ath/ath11k/hal.c
@@ -1346,6 +1346,10 @@ EXPORT_SYMBOL(ath11k_hal_srng_init);
 void ath11k_hal_srng_deinit(struct ath11k_base *ab)
 {
 	struct ath11k_hal *hal = &ab->hal;
+	int i;
+
+	for (i = 0; i < HAL_SRNG_RING_ID_MAX; i++)
+		ab->hal.srng_list[i].initialized = 0;
 
 	ath11k_hal_unregister_srng_key(ab);
 	ath11k_hal_free_cont_rdp(ab);
-- 
2.49.0.1238.gf8c92423fb-goog


