Return-Path: <linux-wireless+bounces-10503-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7664E93C0A2
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jul 2024 13:17:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28DB51F22021
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jul 2024 11:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741B7197531;
	Thu, 25 Jul 2024 11:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YkvAInGd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD76E176224
	for <linux-wireless@vger.kernel.org>; Thu, 25 Jul 2024 11:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721906270; cv=none; b=GM+8n1atheliiBYAWXids+kfJiTN76F0gb8RMrdZH7PhCJ0k+j4IO227Vw7ZCOPnFxUcjiFTJ8A/VV99XM8+DN/0UmKRlYdqKhKe/O6LsurS/Gt9Xy+s4ANEbL7aKrNzV+LeRsvs8kGRUeV5hBW7hWAHed5WMOy1C1B9sduNRqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721906270; c=relaxed/simple;
	bh=IlWRHGkj1xvFgb07sdbHpMJWyMcjPpoyZdRVjVGKWMo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DocH9D6G0Yr5rAQGHzUixi2GxFf+AXvpn5vuStONBzUBM7YPeyIoGmcE8JvAhwM5ey7bd6mU67pTp5fLNITIjvLnswGqzsTyrtqrUOwRBa0fLsrJubjNdKwLu7CtGJLzMrX8PvvUPVCkwJEATBP9V0MebYbFrEl6Yu2zTtayGCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YkvAInGd; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-52efa9500e0so29854e87.3
        for <linux-wireless@vger.kernel.org>; Thu, 25 Jul 2024 04:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721906267; x=1722511067; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QziBxkYKt+VIzFlhjGx7Rv3QhuQxX28nbND8txDa1Ss=;
        b=YkvAInGdgBoGlnfaRxCC/G2jGR3xDPfTw/BWiPkgGiSwl1seS4mozCNTvkALmVU5dL
         iKUM6szAJ9lHZTjaWuVw3Cg7Hapt4Z6XveDZ5EYAiABFt1K5BjGSbZBdbHbS9Lt0QRQJ
         mVCFjYRWplzRsaR3PjUW67KnAPy6YtaZuDpa3IZ2ta2SdZ6wMKNlYOxlJGcXkgG9lW8L
         O2XAkmZVY4FO58OARCvBKAln8a9kpHcckl1R+Y8tb3VnkLSxYe82fUr8JBCDgX0qtH7y
         q5BGi4p/dzeGF2+4KFzrBkNFZ0dVXkoNCgQgYhiGZcKKFaehwOV95xhVSPVOLhQ4WMqh
         yLLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721906267; x=1722511067;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QziBxkYKt+VIzFlhjGx7Rv3QhuQxX28nbND8txDa1Ss=;
        b=ErYfcFeFz6fEAwoG0OWCSl8jnrz95RYbq4hzJ5bo3Azu1kSJ3ap2a64DRMLv4t3uIk
         Pk7VCMRwezdNaFJMbdD3wdvWcvqOs73FzhWjG9EM/TrgzfeS3D96QSCtWISnN1Oa46DH
         H0dVjD0+Hy4OA0l13r0cuCwwAspolJc3UgIXJu3Q4I7zVQ9QAHsJ8BL4pZGN+lKve5Qt
         VvEcOrR5R0BfBIz44wwD4Y21x2YAWo7xAAlVuQtS85Gw26j1oCPP2stDYLAD1XeERzJF
         +MrYgEpj/hdQqykD/2LIj4D/C2XJ1Q/OrctZRdoZGDeakVs8XYZRmL81QwlKRWR782bB
         wuEA==
X-Gm-Message-State: AOJu0YyOT1CvEyzsmliQ/dbD/n8r3TkdVnOQXrNDkHC9+PEjd0JRqrTH
	45VoZyVOF0fPBSmWzoDH94qpfYWj/LRv6muKe3O72Fn174GaCuUvnEE3MORX5E0=
X-Google-Smtp-Source: AGHT+IEMWh5/541DghZ9txi029jWKevnd195xCLfp8eTtPOm9BByriQgcqCrS365PJcwLetFLj9qMw==
X-Received: by 2002:a05:6512:3f0d:b0:52c:8596:5976 with SMTP id 2adb3069b0e04-52fd6092e60mr1404646e87.55.1721906266544;
        Thu, 25 Jul 2024 04:17:46 -0700 (PDT)
Received: from localhost.localdomain ([2a00:1fa0:c425:ef2b:660f:471e:2957:2cff])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52fd5c0866dsm190532e87.121.2024.07.25.04.17.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 04:17:46 -0700 (PDT)
From: Dmitry Kandybka <d.kandybka@gmail.com>
To: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Cc: linux-wireless@vger.kernel.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] wifi: ath9k: fix possible integer overflow in ath9k_get_et_stats()
Date: Thu, 25 Jul 2024 14:17:43 +0300
Message-ID: <20240725111743.14422-1-d.kandybka@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In 'ath9k_get_et_stats()', promote TX stats counters to 'u64'
to avoid possible integer overflow. Compile tested only.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Dmitry Kandybka <d.kandybka@gmail.com>
---
 drivers/net/wireless/ath/ath9k/debug.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/debug.c b/drivers/net/wireless/ath/ath9k/debug.c
index d84e3ee7b5d9..886a102e5b02 100644
--- a/drivers/net/wireless/ath/ath9k/debug.c
+++ b/drivers/net/wireless/ath/ath9k/debug.c
@@ -1325,11 +1325,11 @@ void ath9k_get_et_stats(struct ieee80211_hw *hw,
 	struct ath_softc *sc = hw->priv;
 	int i = 0;
 
-	data[i++] = (sc->debug.stats.txstats[PR_QNUM(IEEE80211_AC_BE)].tx_pkts_all +
+	data[i++] = ((u64)sc->debug.stats.txstats[PR_QNUM(IEEE80211_AC_BE)].tx_pkts_all +
 		     sc->debug.stats.txstats[PR_QNUM(IEEE80211_AC_BK)].tx_pkts_all +
 		     sc->debug.stats.txstats[PR_QNUM(IEEE80211_AC_VI)].tx_pkts_all +
 		     sc->debug.stats.txstats[PR_QNUM(IEEE80211_AC_VO)].tx_pkts_all);
-	data[i++] = (sc->debug.stats.txstats[PR_QNUM(IEEE80211_AC_BE)].tx_bytes_all +
+	data[i++] = ((u64)sc->debug.stats.txstats[PR_QNUM(IEEE80211_AC_BE)].tx_bytes_all +
 		     sc->debug.stats.txstats[PR_QNUM(IEEE80211_AC_BK)].tx_bytes_all +
 		     sc->debug.stats.txstats[PR_QNUM(IEEE80211_AC_VI)].tx_bytes_all +
 		     sc->debug.stats.txstats[PR_QNUM(IEEE80211_AC_VO)].tx_bytes_all);
-- 
2.43.5


