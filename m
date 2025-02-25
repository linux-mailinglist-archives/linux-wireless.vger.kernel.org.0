Return-Path: <linux-wireless+bounces-19391-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E73EAA4348F
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Feb 2025 06:35:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EFF5189CEE5
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Feb 2025 05:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7C9E2561DE;
	Tue, 25 Feb 2025 05:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x3Ko8wH5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558092561C9
	for <linux-wireless@vger.kernel.org>; Tue, 25 Feb 2025 05:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740461699; cv=none; b=E/jOMq0AYk6+HpBAj+cmMUP0t/Ncyf6JFo5H56yx3Q2+5Ujku9LfEzAiYFHOB5tPImZj3bBa0dG0S6kewqRCMalV/BBWbU73FCLqsaMKdvzBKE6uI7B6UkHHTgVh36ujgvP+pu5nnGOtstqLPql+UGF+4n1dV4QH1eNttAqFXsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740461699; c=relaxed/simple;
	bh=LdVk8C3dYDmty4gxkSuuGDDu8zkpk1p5J4v3VnCRaC8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FltPnofc+0noUg0TFZiEYARbcYMQiQyY5nGgdvbpFKwKTIxCAgZVicy+V9hFFlI+lABXwImDJyPhZ8W/jOCyxy3eNTTcgy33OGf8IkRE/KtXwWzIY8l2WbPXLv5nQZtEqpaNRkh50nYxJd91W5gnvn4oHfZ13gRPXzTyuQYTqrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=x3Ko8wH5; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2212a930001so28602935ad.0
        for <linux-wireless@vger.kernel.org>; Mon, 24 Feb 2025 21:34:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740461697; x=1741066497; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Alp/86Yl8dv5OV9OIvJcS/PHlfX7ulpzzZhhzjQV/Tg=;
        b=x3Ko8wH5y0SutybJLEXTKcO6rncamISSQugXgiyYV8h1OhRXzX04W1KSZedh6vrDDX
         vFYQ7akej4z3CMCMzKdy/JZ3vFzn74sm+itk/OuUnhnVTRSm5FW/kgjE9r1P4qlO7slJ
         nROorqbMhqGGMQhoHIAFyt69aojvB7/nLHgPefsx4kMCaDGV0hUpPG03d+8Xesllh8A0
         JnRLsdTrSWrOtAZcdK5CG8+RA3DGxfmJkEajy3ngjHTIJ5tlqJ+S988BKXc+zqgDJe1M
         +xTm8KHRZasiC4fpJ09YtS/CKire6fSv/n1uhSjnAW67ukdhmTVL1KcwT4y3L4i6ykUb
         O/kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740461697; x=1741066497;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Alp/86Yl8dv5OV9OIvJcS/PHlfX7ulpzzZhhzjQV/Tg=;
        b=txbY9LIcLYDbPHVlGJLvZwW9qrminrKVRMz6n560ninpjrfwbBY9FW/NcqWD63FO6Y
         DQ91mSnpPPI9ugTI6qXpyRI+DcHqMaDQMBCtCiA/CzTXzRjAsalLQ6tnl1gHIRmnMvjL
         W6klLdoDWHHbFOnKIOAZNbbye7tM99Xnk+OUmYM8+iVDQT8Pg23YGi0CgcZnHX5QMhx3
         VQ/1NQCyVssFLacX0qP9HP74D1CvVQ3AL+UjcH6q6WjRRoJJ5MVTVHTtQyBGFmmfXui2
         vVY5smNC0IszGqQE0Y7L0Mt3nD44OWgl5Dc+UE3IpPU5Hm0eJ2E7iCoIJXmTbsuAuvIE
         Gt4Q==
X-Gm-Message-State: AOJu0Yxv/G9apNcfu2iBRpBKwptR9TDc3bZBmCVzHKV6t2HIhIKSCtMR
	g4QKb3HDOFEi2TLp/2zlxLDyTe2NLVmx/b+Ycn++mOLkPCMUhdxM+wb3/LOhjwSUMaW7ejcvH3w
	=
X-Gm-Gg: ASbGncs730SkKxx32X8WMFkaXmnMTdOe5MpRCCk40IcMEhgVHJyd0u16fnUH4tN4QtS
	w5jhDVrjGD1k1gJ4eutjlIgGHe8kfgI7Djvvl1QO5NR30K4gZ+zQQZCI53SGtg2GHWBHE6Qum3V
	voRtVdny10ObN+Es2aoO2EOzKdcGgtgMfPLj6K9tQBQjeWmkqEXbTXC17YbKCQz13VBZljsqBsB
	6Mt+38yNDC69Xh4vS+tOLd5Ek0UIC+YZMddsG6OZy0LGkU9J0wwMqB07ylaFvjkyGifzEDmAzMU
	BGpDl/4Zlq8UbPoOlJx60cIorTc4CdL4enPJHgiv99IXwnZOJHWOFg==
X-Google-Smtp-Source: AGHT+IHmuD1aWu/v1EBbeaPKC/rVSjBidCILD+wsg56kWI0wnKQ941LQEdS/f9KRvfrcz7v3nfAKMw==
X-Received: by 2002:a05:6a20:a103:b0:1ee:dcd3:80e6 with SMTP id adf61e73a8af0-1eef517dd67mr30705278637.0.1740461697436;
        Mon, 24 Feb 2025 21:34:57 -0800 (PST)
Received: from localhost.localdomain ([36.255.17.214])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7347a7f9af3sm582101b3a.110.2025.02.24.21.34.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 21:34:56 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: jjohnson@kernel.org
Cc: linux-wireless@vger.kernel.org,
	ath12k@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	ath11k@lists.infradead.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Baochen Qiang <quic_bqiang@quicinc.com>
Subject: [PATCH v2 1/3] wifi: ath11k: Clear affinity hint before calling ath11k_pcic_free_irq() in error path
Date: Tue, 25 Feb 2025 11:04:45 +0530
Message-Id: <20250225053447.16824-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250225053447.16824-1-manivannan.sadhasivam@linaro.org>
References: <20250225053447.16824-1-manivannan.sadhasivam@linaro.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If a shared IRQ is used by the driver due to platform limitation, then the
IRQ affinity hint is set right after the allocation of IRQ vectors in
ath11k_pci_alloc_msi(). This does no harm unless one of the functions
requesting the IRQ fails and attempt to free the IRQ. This results in the
below warning:

WARNING: CPU: 7 PID: 349 at kernel/irq/manage.c:1929 free_irq+0x278/0x29c
Call trace:
 free_irq+0x278/0x29c
 ath11k_pcic_free_irq+0x70/0x10c [ath11k]
 ath11k_pci_probe+0x800/0x820 [ath11k_pci]
 local_pci_probe+0x40/0xbc

The warning is due to not clearing the affinity hint before freeing the
IRQs.

So to fix this issue, clear the IRQ affinity hint before calling
ath11k_pcic_free_irq() in the error path. The affinity will be cleared once
again further down the error path due to code organization, but that does
no harm.

Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-05266-QCAHSTSWPLZ_V2_TO_X86-1

Cc: Baochen Qiang <quic_bqiang@quicinc.com>
Fixes: 39564b475ac5 ("wifi: ath11k: fix boot failure with one MSI vector")
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/net/wireless/ath/ath11k/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless/ath/ath11k/pci.c
index b93f04973ad7..eaac9eabcc70 100644
--- a/drivers/net/wireless/ath/ath11k/pci.c
+++ b/drivers/net/wireless/ath/ath11k/pci.c
@@ -939,6 +939,8 @@ static int ath11k_pci_probe(struct pci_dev *pdev,
 	return 0;
 
 err_free_irq:
+	/* __free_irq() expects the caller to have cleared the affinity hint */
+	ath11k_pci_set_irq_affinity_hint(ab_pci, NULL);
 	ath11k_pcic_free_irq(ab);
 
 err_ce_free:
-- 
2.25.1


