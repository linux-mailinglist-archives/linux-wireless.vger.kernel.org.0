Return-Path: <linux-wireless+bounces-20579-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 741E4A69956
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Mar 2025 20:31:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 243FE427A75
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Mar 2025 19:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7FF9214A6E;
	Wed, 19 Mar 2025 19:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e1ptRnVT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2439F2144DD
	for <linux-wireless@vger.kernel.org>; Wed, 19 Mar 2025 19:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742412630; cv=none; b=Fth9IPTEKNDXoFegh8gs/qb2M/Z/m65cYN6I3RkPIt22T1LmqLmFCuegQTSL3dbpWbgFZ/sp6fSxIxYiu6dORlrleIr7UOkRKkNeYs/WaYVpprNbrXfpMuSQz/kqJ57aYU5X9oFMpsL1Mo65qaD/QaHuwGAN797WOE3bPnzxvp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742412630; c=relaxed/simple;
	bh=m69mJmkHztyd3kZCniS8CqusbWUX0pRjrXk6yy532Rk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g4vGWp+ROQV4CTE6e0TyU0eUbiLmyZNQZNNvafAMREmPNBUoTNAfm16+Y69vqnIo3dSRDaArz6KV/vPn0qJnjoMEwU8MUEL0Yrq0YeMDEN/AfdX8mVskIF7pDQH+kYKBIL+wPEnRUuQU/Ogh6b+t626Byf9uobjJwRDPjmOtpxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e1ptRnVT; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5e614da8615so36051a12.1
        for <linux-wireless@vger.kernel.org>; Wed, 19 Mar 2025 12:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742412627; x=1743017427; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WJUDGJNqcDhh60aAon4S1DVglX5V9cg8n8/ATItcc+I=;
        b=e1ptRnVT7qMXSCGgQcAQ6LFrsKk3ZR6PJr6ZOz32gQIXkHjPlahsT4YFpFUbyddwrK
         DBlgtQ8kCuNA7+rPTdUvMwusB7pTOJSOSQ0EnvfzQjnBGNM8PcM3rmz6LNMB78pdLjib
         5N8bIcs3ghRb6t0J94WUGt/gplxNU82u5G9LM+nCMYnD2gOdSyLycZQAVSAlILH6NYwq
         md5YY2Xrv+s8crDDnWG3ffRA3OgRSHlP4StMejSwLzVq8JswvJprZ/jmpk2D7kRehVsu
         6q9ucTehBIt71zrYrx1iofAppq7muk3fJ0F01SLHzhMp99ykwjnwABWFlV6OGZeiR3ec
         RbpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742412627; x=1743017427;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WJUDGJNqcDhh60aAon4S1DVglX5V9cg8n8/ATItcc+I=;
        b=Pkv3mV0uXmpF67WksDmpkOBISFFfK5YuL55rd37cjFpQBkOEWEPfvKoXYL86ymPWld
         8HdL0BZRDC21wn/NKc2GDViFfPTIsblWAJzAE7ozNBZfRcpW7Zj3vlaMI8bdX77Heo0v
         8OzYDDlQyp5bDZCv67A8+lSDTpFum74siDpe4ob85QxKE59PE/dtnDmYddenjxwbRi9a
         hWGynZ6VcY5Na4hO3/pu2dphRM3AelcIoPORXUfSFzGcL/L7hX5yNQWvjBANvy2AU/vO
         ksN7eF1+DrlO37zf3vj2/6QUGMOb3N3TY/diqFkrTKhZJYOhEflZ7eWFBuZ1kPTi0j7l
         0Z+w==
X-Gm-Message-State: AOJu0Yx0SJE7gTKwAr2fKl26Zu310NMbTwFv4KEg6JMFFJVrTa1fTn7z
	JSHbM5C8AJY2xxsU+XxO0j2IRjn+F1mlYtJunZhnPisZsz/K6afHH0VeTw==
X-Gm-Gg: ASbGnctIrygt3u57zxp8gDydbvVb8Mr8CpqBsHIVz01+OHTXiRLDXLYiZ/NOO7Wd28Z
	2Lt+nr8NZ/1C+7VtD8aV/jx9pFEiS0tDgU/CJkflhQTwl5bVOqart7gox8UTkSPaZtNTjns9WTi
	80lyEE9nts08hnCt+hINo+tHwYJ8nhgDhPvjoNrh4xvP9pBKXDXHXHVhnJ8iHSj49A/IImzrEb+
	7Apf7XLWKLjDz8ZhBZl1llgGg5nn9BepvkMRcPXA+vpQWnFEWg9uMVceDz6inrAGdJGXvXsBxtl
	AeDFsWST4ZEG9WEDD0K01QpslMZ4GJ0GaBfKaKkLNp9eMD4vawV97kNtzKv3ddCzNuVM0j7lXwy
	s+Xbq2qj13YyJxE2R7Jk1PRsYAAPnFDTRhsUJLkSQ9gcgT0gD9i3HSqwR7Ild
X-Google-Smtp-Source: AGHT+IHoeVcX6xJAYf1DH/M4pmq0vXf5fS0aXfpk3+1F18GaAdjaMZDLECJPF9lO2kbeyThcS+EtaQ==
X-Received: by 2002:a05:6402:1e8a:b0:5db:e88c:914f with SMTP id 4fb4d7f45d1cf-5eb99846eeamr841834a12.4.1742412627140;
        Wed, 19 Mar 2025 12:30:27 -0700 (PDT)
Received: from hp.NAT.swidnica_mmp.vectranet.pl (178235177162.dynamic-4-waw-k-1-1-0.vectranet.pl. [178.235.177.162])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e816afdfe6sm9773297a12.76.2025.03.19.12.30.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 12:30:26 -0700 (PDT)
From: Janusz Dziedzic <janusz.dziedzic@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: jeff.johnson@oss.qualcomm.com,
	Janusz Dziedzic <janusz.dziedzic@gmail.com>
Subject: [PATCH ath-next 2/3] wifi: ath11k: setup survey rx and bss_rx
Date: Wed, 19 Mar 2025 20:29:45 +0100
Message-ID: <20250319192946.1087196-2-janusz.dziedzic@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250319192946.1087196-1-janusz.dziedzic@gmail.com>
References: <20250319192946.1087196-1-janusz.dziedzic@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fill survey rx and bss_rx times correctly.

Signed-off-by: Janusz Dziedzic <janusz.dziedzic@gmail.com>
---
 drivers/net/wireless/ath/ath11k/wmi.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index d7f852bebf4a..18fb2e756c37 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -8011,16 +8011,18 @@ ath11k_pdev_bss_chan_info_event(struct ath11k_base *ab, struct sk_buff *skb)
 
 	survey = &ar->survey[idx];
 
-	survey->noise     = bss_ch_info_ev.noise_floor;
-	survey->time      = div_u64(total, cc_freq_hz);
+	survey->noise = bss_ch_info_ev.noise_floor;
+	survey->time = div_u64(total, cc_freq_hz);
 	survey->time_busy = div_u64(busy, cc_freq_hz);
-	survey->time_rx   = div_u64(rx_bss, cc_freq_hz);
-	survey->time_tx   = div_u64(tx, cc_freq_hz);
-	survey->filled   |= (SURVEY_INFO_NOISE_DBM |
-			     SURVEY_INFO_TIME |
-			     SURVEY_INFO_TIME_BUSY |
-			     SURVEY_INFO_TIME_RX |
-			     SURVEY_INFO_TIME_TX);
+	survey->time_rx = div_u64(rx, cc_freq_hz);
+	survey->time_tx = div_u64(tx, cc_freq_hz);
+	survey->time_bss_rx = div_u64(rx_bss, cc_freq_hz);
+	survey->filled |= (SURVEY_INFO_NOISE_DBM |
+			   SURVEY_INFO_TIME |
+			   SURVEY_INFO_TIME_BUSY |
+			   SURVEY_INFO_TIME_RX |
+			   SURVEY_INFO_TIME_TX |
+			   SURVEY_INFO_TIME_BSS_RX);
 exit:
 	spin_unlock_bh(&ar->data_lock);
 	complete(&ar->bss_survey_done);
-- 
2.43.0


