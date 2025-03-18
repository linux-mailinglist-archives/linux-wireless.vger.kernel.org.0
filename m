Return-Path: <linux-wireless+bounces-20517-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A548A67E43
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Mar 2025 21:51:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9D8388561C
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Mar 2025 20:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65FC5212B09;
	Tue, 18 Mar 2025 20:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DzXR9YcF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDC71E834F
	for <linux-wireless@vger.kernel.org>; Tue, 18 Mar 2025 20:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742331059; cv=none; b=hy84VlsiO2HVZhUuQPZMyk0Ee38NWtHL+HwFXTGVzaNlWbySSQu+1cMSFia6Eo6uFQXevKAfeAVDJG+IQ0R4dedmx8GB2/A4ro18+41O2wfVLIwyoZhErYT4JP2Fw0mGquxELsBv0eeJTFY6p9B6S+b+Cb2gV+chv/06vUGV+fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742331059; c=relaxed/simple;
	bh=xDd5pymcW0i1Wd8xe3YzO/vkoXoHglAxgaQ/uxX/1Rk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZY7QZS7C+kdgH9QAAQcEcbSWAY6ndrFGoGD4Cd4DrYTArNngQ7l6P58Yhh7OJKS15GS7UY6mqcbkrWqET3vAGzy2mYv/HWl+XQl63cvqsECpv1+Ole0Aj2Ex0RGxlzfS0qmEb2cOf+80u3SevQaNdypXLSCfFYMM1q+m2dtc1zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DzXR9YcF; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43cf58eea0fso20316865e9.0
        for <linux-wireless@vger.kernel.org>; Tue, 18 Mar 2025 13:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742331056; x=1742935856; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3UohDItqJbHSrPJP72i3dlPHwcSi2GhbxMj73jX1M+o=;
        b=DzXR9YcF9jDmDiSRjebMBqNTc9Xr4qGrqF5CYRW1n39NGtk5k6pl/QY3jgEeg5WD4G
         b9TOVIPM6yD/nNAOepDwlmfsehP6R1tA6/HlX797tTNmUvgC/H3WNFR2RDARc6KrsERo
         II8SbketJEAPX4LW26on7dAUSKE3N+vH0ZEtv0ewbk+Qyu7B6J5k9imUqoRsYAmTWql2
         dXcrZta8lY6/z1ucY3Uhb4E/ukieXbgqR3MmK0LmFcZN7Am7Em0CRlopc6CyMDf7W83U
         DTedvMybYy+hmpnaNaFODno6X6C371jyXxJ6EnsO97K+W2NrX6D9hPWbyAvLnxfZE+sD
         HRCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742331056; x=1742935856;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3UohDItqJbHSrPJP72i3dlPHwcSi2GhbxMj73jX1M+o=;
        b=WcMavEzibyrcaarfwjOOjW+1NE3YlHo/1Lz+PG8hm/BG1lLbX+5TLNP2HIB/Au2XHQ
         76/+gBpfg25o6zvH4zfHuODG+nRyaPfKoQ2Td6Bxs5V16FqxnjLfyQHCvKhpPQirHARy
         W4SeG6D6lh8W/jdyvCJMvCAgQVSx3lzgIiAIRGZ/lzLiKMD9hAFyAF9gc9JFa/8WUCz5
         HBG2cAY5XPCgkytu8UxRvfYN6uNBDLTSrClk4ITog3S8M/ocTKS/OusY32XqybVybyV9
         CWHbpWkiN2eLDf0gSnMadW5E0QZKcvBwDGTuZhSXfrbhuNEfsVqfAWisXHNHZ+c/WMPA
         mjXw==
X-Forwarded-Encrypted: i=1; AJvYcCUazIAcKq5FOAWQWzJySiW7W0D71pejMNCuT1Z464YATFaKaaIgDY0P9pFHGOOLWzeUm8VieYCBaQRANCBxzA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp5ZPP4nJtJHAAJky03L4030P0iObT04/yYtALm6E3jB4HjF7O
	seb4qNn1cjRkTJAjAnVeS7mHLE6GMZdEKNpe12PUQIo+Jwy6Mtt7zv5aPJ5J8hk=
X-Gm-Gg: ASbGncvjsu0+KNys87tafCIyZQ5UFjPkXg5iETySdueJXIlYCM+bZJUmZvHSkbJ0931
	eVu1l36a2Uc/YLA54gHDyulGGrzfKZfRwjfYNVnL+v2p5q8Psq7kN/JVku/FqoyyHq9+uUx45l+
	Kz7fbzLADc3cdvdtyzQ1BG8qZWfhTPA25JSofMdDtwm9NgRaCuo6TmIMAWj7YujIdXk1dmUza2O
	O8VMhR1tSy89qz29fd3lnnm6w71xKTioEWQgNgORW9B2EIUfPeVUBVuiqcu6Wn3hnYgn4Y17Q6E
	PX5Cy/8KRTtflIcssrv8N/UyjwLjTOJXYNOiGwjE0OedFpTY2R0IBKt3QkM=
X-Google-Smtp-Source: AGHT+IEMGi6XLwyG661+0/YviXfVdYcrgXqlOdZMjARlupJXDIehoNdeJwTWQOa9f4YxNoViNwD+pQ==
X-Received: by 2002:a05:6000:1785:b0:391:c78:8895 with SMTP id ffacd0b85a97d-39973b32028mr143871f8f.50.1742331055842;
        Tue, 18 Mar 2025 13:50:55 -0700 (PDT)
Received: from toyger.powerhub ([2a0a:ef40:1d11:ab01:97b:e453:3907:27d2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d1fe05e8dsm143198645e9.9.2025.03.18.13.50.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 13:50:55 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: Jeff Johnson <jjohnson@kernel.org>,
	Johannes Berg <johannes@sipsolutions.net>,
	Kalle Valo <kvalo@kernel.org>,
	Rakesh Pillai <quic_pillair@quicinc.com>,
	Surabhi Vishnoi <quic_svishnoi@quicinc.com>
Cc: phone-devel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	Caleb Connolly <caleb.connolly@linaro.org>,
	ath10k@lists.infradead.org,
	linux-wireless@vger.kernel.org
Subject: [PATCH] ath10k: snoc: fix unbalanced IRQ enable in crash recovery
Date: Tue, 18 Mar 2025 20:50:27 +0000
Message-ID: <20250318205043.1043148-1-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In ath10k_snoc_hif_stop() we skip disabling the IRQs in the crash
recovery flow, but we still unconditionally call enable again in
ath10k_snoc_hif_start().

We can't check the ATH10K_FLAG_CRASH_FLUSH bit since it is cleared
before hif_start() is called, so instead check the
ATH10K_SNOC_FLAG_RECOVERY flag and skip enabling the IRQs during crash
recovery.

This fixes unbalanced IRQ enable splats that happen after recovering from
a crash.

Fixes: 0e622f67e041 ("ath10k: add support for WCN3990 firmware crash recovery")
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/net/wireless/ath/ath10k/snoc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath10k/snoc.c b/drivers/net/wireless/ath/ath10k/snoc.c
index de96c3939ea6..01e26f259fdf 100644
--- a/drivers/net/wireless/ath/ath10k/snoc.c
+++ b/drivers/net/wireless/ath/ath10k/snoc.c
@@ -936,9 +936,11 @@ static int ath10k_snoc_hif_start(struct ath10k *ar)
 	bitmap_clear(ar_snoc->pending_ce_irqs, 0, CE_COUNT_MAX);
 
 	dev_set_threaded(ar->napi_dev, true);
 	ath10k_core_napi_enable(ar);
-	ath10k_snoc_irq_enable(ar);
+	/* IRQs are left enabled when we restart due to a firmware crash */
+	if (!test_bit(ATH10K_SNOC_FLAG_RECOVERY, &ar_snoc->flags))
+		ath10k_snoc_irq_enable(ar);
 	ath10k_snoc_rx_post(ar);
 
 	clear_bit(ATH10K_SNOC_FLAG_RECOVERY, &ar_snoc->flags);
 
-- 
2.48.1


