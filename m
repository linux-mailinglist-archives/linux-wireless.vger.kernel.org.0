Return-Path: <linux-wireless+bounces-30418-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id EBBB8CFBD07
	for <lists+linux-wireless@lfdr.de>; Wed, 07 Jan 2026 04:12:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6DA613003491
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Jan 2026 03:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 492852475E3;
	Wed,  7 Jan 2026 03:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ljGQPApH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DACEB23A98E
	for <linux-wireless@vger.kernel.org>; Wed,  7 Jan 2026 03:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767755540; cv=none; b=dnCVO4dqB/IfKY4DCsG0EGaiNbvkP9/+zICxZc0TSsz+bCLBFyTcZv7z16L71C6De0lMNvEv9+17ZPPIeIU+ZikJa4R9z0KMMFmM0yQX2PpDWVc7+MOK+wYgxyW6sglNDYQI9l0k7Say5PdDOozbCjgcM9NjiEYHBkdaELYc8Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767755540; c=relaxed/simple;
	bh=pue1JbfJKqT5NQsgKiMs2ClJElauQ8IOT7H8qUwm5qQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DPRHUXv38qgoP4Sp+VqWBpMnUqruQHfKfiuIJtNJTDw7Z00uNh6x7E3WONJmcI3XZguvZhqkowo5HAR9AzwAdX5UPCBUxSAZChbKvUY46F8gJe1GZpN6AxExd3SRx8WoVnXvWbbmc3SHCvCA3UIrXhEbIFH/qeA3fzYnvvk8sWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ljGQPApH; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7b89c1ce9easo1378230b3a.2
        for <linux-wireless@vger.kernel.org>; Tue, 06 Jan 2026 19:12:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767755538; x=1768360338; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eS3mm9TFiqA9aqtmBqpeaAq7lK8C/XA9Rvpi07fwrf4=;
        b=ljGQPApHAWh4f0FC1giaTprwyVDJ65JMefqZkBBfwqwGi8xoaequ7S81kA/Um+riy6
         1YUTSwVvZ467Mm0PAMExwQkLdPGdyTm9Wrhy9yAr9IYmTujqp/OXNcR5iIAMcs9ipHjA
         2bmROopkfJHakdKe9z5G1PadQ4qqwHy9H5orRRGPSS7MsvYy7LOuF5MzZ10IoRebFDCa
         0LXPEaf5it11WdVPReCWkZuZApLB6bs/LFEmj3RI/GFzk6HVuAswJUP6GowjtfX9hoY3
         yXZ1bOIlKQ8yJio4fL6d/SYaVBGTEZXqpIjZNWYQxKHgdXNTo24bLq0TX2xCqf3b7aTb
         K+JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767755538; x=1768360338;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eS3mm9TFiqA9aqtmBqpeaAq7lK8C/XA9Rvpi07fwrf4=;
        b=evWxh7i0by99ho18JLGWBqc008jzdoeANXzgi3eFM3w+k6epZCzr3mJMm2Jke6gPu1
         Pt0RnXPo4DlhifcgXPtF4SnwiZwP+iDisAfYXYJypXP9FtU/+2++jGa8JsLaU+nnhuW1
         aPDCZ2k0LZjQz3pdR1CpfZ0V54iuA+xwhaJh/V/M2iTC3teImYozrqs3xxn61Lo8FPwq
         tuvLaPNvVix2YSPQ+Zlfn8fVpb+cGduEuuFQ5nEe6io/9Et2COhgosFcu3JlkSFDZMsK
         f8PRwfuF+U7H4htcuDfhz1QEQgCMMdRFjsRbixZji97Ium09p0iveQrRrfoIqdwmQGIr
         8GaA==
X-Gm-Message-State: AOJu0YxwA8U69MWz4mNQv/4QixiwZx65ed45oAtPNjY+hB+AAJNfn/Lk
	m0nvzUCBw1LekPkrX5F24soFjxP9HF4EDeovWvxechkbw7HxVwb/wGhh
X-Gm-Gg: AY/fxX45nS/veo4+5GFPWpq+P8zJy+fN2OFAWFPC7F7/o0hHmtnSFKrrjLLTpH4Ic4g
	uWce9KcRucnFUX2/TwGSLvGFxlLVQlnJZC5Jb3ZOwhYgcpvQUMECRM7XJQp7ajOjASrCxgwFjQc
	IA7iGhaaKTOCTtp2D9uz9ZEAmCW1namjIoYP1YfTHj7i6EjqOuwD/nhi8ylB/8ZDQbnXAv337dU
	F5JygG9aNJ1PvburXYmu0ok0TuGrvLupeLAUXBSHbhICPi5A5JLg5t1FrEMDO3i5ozY5wyXDNSY
	GenW9YUl9hHpR6YQxmpS3a8aXxag23cwhHuHQcS+j0ZNOthno3T+QHg6YkdvLh2Ed7eV3kckT6Y
	meoTaGO5lFx3gb0gc1oEjm9MtZ7xMtwwN0iMKALs71BwgknAqijF7GQOwSvuUUU84v1EwQW4=
X-Google-Smtp-Source: AGHT+IFnXOuZn5Ma9/Slp7HtIk7jPXLf0GqKmrRkenlnn7BXzVsf01GShHxvcViQrniCnzXu5/L35A==
X-Received: by 2002:a05:6a00:800a:b0:7b8:8d43:fcd2 with SMTP id d2e1a72fcca58-81b7d752872mr1144595b3a.14.1767755538122;
        Tue, 06 Jan 2026 19:12:18 -0800 (PST)
Received: from oslab.. ([2402:f000:4:1006:809:0:a77:18ea])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-819c52f8952sm3361086b3a.39.2026.01.06.19.12.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 19:12:17 -0800 (PST)
From: Tuo Li <islituo@gmail.com>
To: toke@toke.dk
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tuo Li <islituo@gmail.com>
Subject: [PATCH] wifi: ath9k: add a defensive NULL check to prevent null-pointer dereference in ath9k_beacon_remove_slot()
Date: Wed,  7 Jan 2026 11:12:03 +0800
Message-ID: <20260107031203.170628-1-islituo@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In this function, bf is guarded by an if statement, indicating that it may
be NULL:

  if (bf && bf->bf_mpdu) {...}

If bf is NULL, calling list_add_tail() may result in a null-pointer
dereference:

  list_add_tail(&bf->list, &sc->beacon.bbuf);

Therefore, add a defensive NULL check before invoking list_add_tail() to
prevent this issue.

Signed-off-by: Tuo Li <islituo@gmail.com>
---
 drivers/net/wireless/ath/ath9k/beacon.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath9k/beacon.c b/drivers/net/wireless/ath/ath9k/beacon.c
index 4a27e3753c03..e39e2738ba1a 100644
--- a/drivers/net/wireless/ath/ath9k/beacon.c
+++ b/drivers/net/wireless/ath/ath9k/beacon.c
@@ -236,7 +236,8 @@ void ath9k_beacon_remove_slot(struct ath_softc *sc, struct ieee80211_vif *vif)
 
 	avp->av_bcbuf = NULL;
 	sc->beacon.bslot[avp->av_bslot] = NULL;
-	list_add_tail(&bf->list, &sc->beacon.bbuf);
+	if (bf)
+		list_add_tail(&bf->list, &sc->beacon.bbuf);
 
 	tasklet_enable(&sc->bcon_tasklet);
 }
-- 
2.43.0


