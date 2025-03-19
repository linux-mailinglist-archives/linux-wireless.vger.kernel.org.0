Return-Path: <linux-wireless+bounces-20580-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B724DA69961
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Mar 2025 20:31:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA9983BC81B
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Mar 2025 19:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72DBE214A7A;
	Wed, 19 Mar 2025 19:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e1JhjLCH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10F42147F8
	for <linux-wireless@vger.kernel.org>; Wed, 19 Mar 2025 19:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742412631; cv=none; b=EXm/XVqhlHU6V6YZ/8QcdYLrHgtfw6f2MFOdjCigAtbwCupMaLMDKXgvEDmqLR9mvMpI+f3wSGx0zHL1E786b2nRRZNrWN+zLH5H56OfkB2pQLrCE7RtTIfIiBjkdyxczH6luk+PD1w9DrViRItROvJIRN1ikzYKA1eUfD4k0WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742412631; c=relaxed/simple;
	bh=GK2svvcRNo2aNpIZaMEBxarLdP1yo984ShpgCvbHChs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SoczX3zsxvonk1wWgCWu1ohzhmHuc8R8xJS5wxtIOM/qETMYIZsnrgpCgTOtaksZfbAvQ3rOyeZSotb5oq/gTcGvVyGtT3IlNz9IDOdYef28lHTX24OuO69eItCl3FwTcDdOZr3Z8U6dqgc/LrkG+49c4evwTw0kpoOgocA7BOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e1JhjLCH; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5e6c18e2c7dso39255a12.3
        for <linux-wireless@vger.kernel.org>; Wed, 19 Mar 2025 12:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742412628; x=1743017428; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4pvc7uzYIpCutJg+m9PYlOXCNt6WBZYuZXJ8UTaoPwQ=;
        b=e1JhjLCH2hL5gNc1xDUvDmF2S8LYigE5usuSiJLE8dBeHiuwG5vRUC5WalbhcKKk2T
         OPhIcH/VeZEBhsjaIppXn3gcjqUhLTi44u3YFbFT+VBjAho7lQqSlLjx779n4zxoMqFA
         8EXoWZTRj4GH1rT137X0D20cYtgN6+ZGHXhlPVb4MqJRMyzHrRhlHXzC0nQLd8j8SNQu
         TTUR1JaSVOXDLsBC9GsA5T/vi7Ur+oUMjc2CAzq2L/Mu711SXf+Dv0l9OIWnP0B/Ziv+
         xhQvaTc8NudxslY4+oqODzRSE9V/vlZNdF8ewTQNAtGHRS0LlOJ6SKiYquYri1vlPjPe
         5Y/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742412628; x=1743017428;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4pvc7uzYIpCutJg+m9PYlOXCNt6WBZYuZXJ8UTaoPwQ=;
        b=U5+zpyICoCI29l7ftoDNPy+R6eeCb1rD+1nTEb9MeZS+yHuxb1kpQhbGH9K1B+ORx5
         6LxwIQqSCDrlB9+7FePhlYYZh4UB4PdFsowI5cmrs/b8L1hkpFMkkovkFXC+sohlM+gl
         y7whBAwEogkwLAszFhzTO9sX+sxwpe/WKzqsz082IkkICAtypU0SY0pCXhJVLUIqCcDL
         XYpvyNX7fcio5w3cFPBR8Jvcwb8SFXWw53JNsHz7kT/oLmn38KswIvt6c5m+KpMkveLJ
         5dZsuCdP8mceisqMSHzpArTfQiaa33sDmOXUeg/m8jZfbZrs8eiLRm24CI42ia6UYWLo
         s9hg==
X-Gm-Message-State: AOJu0Yx3avLt2mTalWnqWHj0cPBPCJcIFb98D3S6EgI9HgEJ5+R1b/pR
	v7zzuq/bOR0Xzl5Q/DC2qnW42fTObfMsKRrjwD1Y/58i6MRcLB4XRhn/cg==
X-Gm-Gg: ASbGncsP615oczxUVe77ybjthNk6P03wKTb5L6YlQxOuiyuqxHGbahihZ10dUVtp2sT
	l9/Uf1KMTtyo8ObO4YQtjBruqQiHGV/v2BgPigse3mIegqftCq7glrIRybRa3shqK+oS/jSIL8c
	7Cd/ZpdnlkEGL7MmCcdQqpDCAVyFfekBPkQ97RQ8PE5NWPhHgXJO1xlOcO9q9UMz0KwXpnsYo7Z
	RzIBV3akbudWb85FhANKmcTKG6dzXzXr9xijCBs9Hx8JctguK5ooTJW7Vt64DbO4DorFKEVFOF2
	EfpGlSrbdfOu8+lsIKoDYtrM6a97MNfMVIPyYGytPdwmBKcs5KRC87NiJYpAB9BiJQqVTp430Mg
	xoRDGs858xkkxf4k7BfCBx/e7Bzu9LaaBzPL2Cp4WQqzdLtmUUnuwc/vyaz89
X-Google-Smtp-Source: AGHT+IHzjS4parba08Hr7NccrlFdbWByH/CC/7a9qr5zUG2JrsUGnRfYjfn26BgYcwK9Ucoq42KZCA==
X-Received: by 2002:a05:6402:278d:b0:5eb:4e69:2578 with SMTP id 4fb4d7f45d1cf-5eb80d19437mr4384583a12.13.1742412627765;
        Wed, 19 Mar 2025 12:30:27 -0700 (PDT)
Received: from hp.NAT.swidnica_mmp.vectranet.pl (178235177162.dynamic-4-waw-k-1-1-0.vectranet.pl. [178.235.177.162])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e816afdfe6sm9773297a12.76.2025.03.19.12.30.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 12:30:27 -0700 (PDT)
From: Janusz Dziedzic <janusz.dziedzic@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: jeff.johnson@oss.qualcomm.com,
	Janusz Dziedzic <janusz.dziedzic@gmail.com>
Subject: [PATCH ath-next 3/3] wifi: ath12k: setup survey rx and bss_rx
Date: Wed, 19 Mar 2025 20:29:46 +0100
Message-ID: <20250319192946.1087196-3-janusz.dziedzic@gmail.com>
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
 drivers/net/wireless/ath/ath12k/wmi.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index 04dd307ebfc4..9c829f2ee3e6 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -6773,16 +6773,18 @@ ath12k_pdev_bss_chan_info_event(struct ath12k_base *ab, struct sk_buff *skb)
 
 	survey = &ar->survey[idx];
 
-	survey->noise     = le32_to_cpu(bss_ch_info_ev.noise_floor);
-	survey->time      = div_u64(total, cc_freq_hz);
+	survey->noise = le32_to_cpu(bss_ch_info_ev.noise_floor);
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


