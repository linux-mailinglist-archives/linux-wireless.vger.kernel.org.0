Return-Path: <linux-wireless+bounces-20578-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 059A5A6995F
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Mar 2025 20:31:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C1448A2849
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Mar 2025 19:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E10A213E78;
	Wed, 19 Mar 2025 19:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EMdXeWKC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55FD62144B0
	for <linux-wireless@vger.kernel.org>; Wed, 19 Mar 2025 19:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742412630; cv=none; b=jC09lsI+DlYnfhNQUImtkJiFjXnXEpNO28lRNvPiSgiI5d+UmDfr8K+SrB7TtvIgTXhwAqX3H2O2r5ichLNCh1TfxLib/JZCDZnQVuoxDvRFHWr0JGr+hEWYPG494TdsXxdSk0jDTBeMm7MPRsJobFVlVKn7YpRXGmHLw7BRZrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742412630; c=relaxed/simple;
	bh=qSFtU4mNrmiYxY3sQ4koVcR+RKXgnZa0PS5FgL0Baig=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rFf45jJJT53gyx/a3bJ1BTYirwToKw2GFIfOMDDHxaBJ6Kk3EvAqKTJ+t9Rx2YYeJBg3Y8oyevLs6/LBJA544HEBQorJcT6rsajhKeKdZqWasJX4qpfAyNYtkMu7DK7eUeOMoH2yb9qA/+8pmsjoi0DLDGPTcSi0wGnY4pa7PQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EMdXeWKC; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5e686d39ba2so47035a12.2
        for <linux-wireless@vger.kernel.org>; Wed, 19 Mar 2025 12:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742412627; x=1743017427; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sei0lEG+ise7OEi5skmIvU6dZ79Ckpfvlz5UP8xO/dg=;
        b=EMdXeWKCwCoFul1JuACSBeSzLU/vaeeTTl9gKk9YZX2doiDx4OAlP0sNmcmdpO9Rvz
         BfQJ8unhXIBLIojUfgzs7R3kXwfvAjdHsQiJ98xX1fg0tgWYNigvznmRk0izYjmLu2aH
         LelI+op61kKXzhrwSqxrEeB6vuZZfUbLsBF4l+gWXY/bItd1eOAGwzJfaizjs+EXAMsk
         7CgxwpJTHhL+qtrrMQSezCy3A293b1M0CTRZpLRi5ba+V7ZORlwxGU6eSRuxDgQ60R27
         DhRBmIGdHtWZS2P0oIUKwxBwqSZRKZIqcLmkmnIZAmsMSd0ft+CK8GZu6n1S12KERc0t
         unJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742412627; x=1743017427;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sei0lEG+ise7OEi5skmIvU6dZ79Ckpfvlz5UP8xO/dg=;
        b=qG5ia39KDC3ZuVVpM9L5ONzO75yRgQGzHXdJzuJl30b2sMAwrb/UuQ3mMygJHciNKG
         lUAAypRjcFFOAPO87nc8hQCKEkQSdC8Mgil3mBsli5uAQq9tlUwQpPzioWaz066u0GcJ
         Vxy4zG9Hfowo6hugvCPXB3NyWoFkDSEtithZ80wT2DDIqXcNR+y/mCN4LP/+0EZLlNrJ
         LtxE/Xt1LDJ3dT9AFJGp9hLaMDut/ixP5qAvemV8rFK58qG2hUoZlUHf6ZjKWmouLsOn
         +7nXm6IHp4tjMRcGvldw6mpfUHGtACitWEp1plSwsN6atUpgzIyTvX2qgFk8Q+WzVLVg
         KIYw==
X-Gm-Message-State: AOJu0Yx6z0/G/p0pmXdyucfB7mBrywy1aBSwgCZ3s4asAGh/t4fx4aDT
	+9A+Q9NbsZQq2SstbLY4FweSBIkK4bDW/WZUQDkp1RQVy34ptpLthfuX/A==
X-Gm-Gg: ASbGncs2Wf7z5mzx+IbmR5K5keRj3OLqUAHyO1TZRWkZwqruSskOAkIauYYy9/qoqaI
	I63bnPRxW1edtNZ3jxSxwHy/RGSG7Mn7qb0hTo0Azr9AMr+8/g6OnOHRansPZJARpXIvSCiz7AL
	6i8hZywhCmhm+nmCG2+sAKyu81pNnhHoRxy71BhHnDlk5GMaOVrn1T9iHEjFGE+v6bBAGS90BZE
	LMegHbehgsYzsQmvhA5hyQEN2H6sJkcjTdGu6+bfMSoZd1ydP9WrjrWofMKFt4TsI5HTBZmibpN
	kLwvYXq6Fkpo1Cs9W3I8EYOx6YlgBrMzoCFOEhr4VbMEtHN8tLywByyr3fbRjoXryw1SpxCPtIa
	u9USPoZCGzEdpjcu/G9HkqbF5Ep/EWGl6txFwdK3THV3guy2Mq03enEsq+mXe
X-Google-Smtp-Source: AGHT+IE+c4ojdUn18W9dhyzJ/7BCYtEFgKi6TAjG4es30XAwS0RFRooxmIworAywrTt2VtYykTmang==
X-Received: by 2002:a05:6402:4313:b0:5eb:1c9f:9811 with SMTP id 4fb4d7f45d1cf-5eb80f93da1mr4320363a12.27.1742412626368;
        Wed, 19 Mar 2025 12:30:26 -0700 (PDT)
Received: from hp.NAT.swidnica_mmp.vectranet.pl (178235177162.dynamic-4-waw-k-1-1-0.vectranet.pl. [178.235.177.162])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e816afdfe6sm9773297a12.76.2025.03.19.12.30.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 12:30:25 -0700 (PDT)
From: Janusz Dziedzic <janusz.dziedzic@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: jeff.johnson@oss.qualcomm.com,
	Janusz Dziedzic <janusz.dziedzic@gmail.com>
Subject: [PATCH ath-next 1/3] wifi: ath10k: setup survey rx and bss_rx
Date: Wed, 19 Mar 2025 20:29:44 +0100
Message-ID: <20250319192946.1087196-1-janusz.dziedzic@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fill survey rx and bss_rx time.

Signed-off-by: Janusz Dziedzic <janusz.dziedzic@gmail.com>
---
 drivers/net/wireless/ath/ath10k/wmi.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/wmi.c b/drivers/net/wireless/ath/ath10k/wmi.c
index 5e061f7525a6..154bbf0324bf 100644
--- a/drivers/net/wireless/ath/ath10k/wmi.c
+++ b/drivers/net/wireless/ath/ath10k/wmi.c
@@ -5834,16 +5834,18 @@ static int ath10k_wmi_event_pdev_bss_chan_info(struct ath10k *ar,
 
 	survey = &ar->survey[idx];
 
-	survey->noise     = noise_floor;
-	survey->time      = div_u64(total, cc_freq_hz);
+	survey->noise = noise_floor;
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


