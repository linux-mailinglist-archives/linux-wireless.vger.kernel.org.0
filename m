Return-Path: <linux-wireless+bounces-19393-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88339A434A1
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Feb 2025 06:36:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09BA3189CD94
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Feb 2025 05:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D24D4257423;
	Tue, 25 Feb 2025 05:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XCzWZ9Dp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3EA17E4
	for <linux-wireless@vger.kernel.org>; Tue, 25 Feb 2025 05:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740461704; cv=none; b=cVYHfbSFTg7I9+uZusi1aVmf85XbNdJF7/jQP06MpD9mUcunPAgMHrM4hrCnB9JpcKUQRQUf40AGTUo/jsifLMZsXLBFWcfSRXvttZYpQLkHXI5jpdGMmQy5+KAHK5U5hXjt0jaW9SPuQryO/RkPL34t6iUdzBssCyWDa597O3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740461704; c=relaxed/simple;
	bh=m0ENAYkK9uSzSQgO0nychnr6WiQxO2uAemDG45GIDpA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Sne9qBlpYXylfD8yF2WdmPfZNdMH8VNmErJsuAbg3awkNT1+jXed1OL79JWtMqhKXFE6N5L2Alf6XTICC4lNtXjf5dpcIJqUKISPKKL6pEGBVkavQck5lKs4j3SV3zJalhapmYSHaYFaBYh33xDpVmsFBCr07lxKjRoPAk7MZKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XCzWZ9Dp; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-220f4dd756eso107622515ad.3
        for <linux-wireless@vger.kernel.org>; Mon, 24 Feb 2025 21:35:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740461702; x=1741066502; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AYmnWqCfl4BTw5dpDwtuCHljGqr5uXG7tQyflbiZ1TI=;
        b=XCzWZ9DpJfpUhieCl8OvFY+EfDWk/cJL0RAhHrDsUD6/YRxTBeZuxaGFvf3jE+6Y5R
         7wWgYtsEeo1msxdc01+ZFx3K9u5RsWKaVV0Qt3jdT5BVYVfGca8uKJaDZ+qF/d5Sq02x
         feJLwKbPfzUOnJ1XkYpIkoXfn7QB0kQ3fEkx+VfPlLWJfIzkcX7Ncz1sT92/3fEtzH9N
         3F171KxK+622g0DovPjnksnVGQVaHSZac0pwrXnoKHi1HMnWkPcD0X6X6MKyYX5WTmoZ
         PNYq4DfaFMTwlh7xzyxmwDME80ibQ10X/X0yyIfYOcL1UINGP1gf6WwX0/iTV4fR+gsJ
         aMRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740461702; x=1741066502;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AYmnWqCfl4BTw5dpDwtuCHljGqr5uXG7tQyflbiZ1TI=;
        b=cyJ16hKOPee9biZ85yWH5ucfBjGGWudS3klO278F8Z3GC89gU5E/xKtoSbVee8Vftv
         n9Omiq+ycO3ZMi3wJfynaUrEVenFZey05mmhLo+GkhWiv8PbfNIJ62qm4UVgt8eNBncE
         7Eu/eiIlWIimQD+aPrvslqAJiJPWYY94J5+nYUlNYiz9K8vBBsJQTYElH1az/lOmgc1D
         gZKe8yPU6Hl5VUVZhR0bKzTr+hROzgFvv+oZt3aW5+8Ph3Za/8ESw615VKWpDegu9RSG
         PV7BhExl9ZsZCMgrdJYk6C8Xc0KPFamjJ45F25PpYkNcdy8qh2owBr/BSBY2/7g8OjXo
         Jf9w==
X-Gm-Message-State: AOJu0Yx5TPyvedRmbwyV+ftrzjPtMsjDAm5MtzpgA8HtzNHWSZ4owROJ
	OGFkUYheTab80oTO+3zmZ511LzNh3RFMis0vFEuMyv4cxgpA1xIj5qypw61uUA==
X-Gm-Gg: ASbGncseTqXbdAo4ax1LpZrMzdr+PEfPMlQnZqxZzPUf2MVdXddCYRTyZYuMZJ7UcC4
	KzS1usXP1fItCGb6QrcCmekZVvbXJYTXNSUd21cA+tnZI9vXB6Ra0zJA1j1yq29roSSU0Sb7W02
	BfFKYjlbXzq6LZt541Jn1KnmYZZ/dWjk3PiO29bRQWpNws1t4mCtutl9uiRpek1tqXYGv/+QMw7
	T6SlVrep0+pmhipjoRFCaPYowlcbHG1EBmJ9gZ25oDXZvXMD9QyRFYjnwX84c6CkrSi/jEVkNr+
	+baWKIdZPLx5b+Yh0Sd9mszF3QoxTG1ZFOf6ztJSDhxBKXSbNo3NlA==
X-Google-Smtp-Source: AGHT+IEHljzwJD36eza1aeKcaU2dWlFSTtvnEQrg+fmzOtR5w21SUg7QvbAbtZaZAXH1YQPPhdGwlg==
X-Received: by 2002:a05:6a00:2e9c:b0:730:8526:5db4 with SMTP id d2e1a72fcca58-734790f8cfemr3218117b3a.13.1740461702511;
        Mon, 24 Feb 2025 21:35:02 -0800 (PST)
Received: from localhost.localdomain ([36.255.17.214])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7347a7f9af3sm582101b3a.110.2025.02.24.21.35.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 21:35:02 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: jjohnson@kernel.org
Cc: linux-wireless@vger.kernel.org,
	ath12k@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	ath11k@lists.infradead.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 3/3] wifi: ath11k/ath12k: Replace irq_set_affinity_hint() with irq_set_affinity_and_hint()
Date: Tue, 25 Feb 2025 11:04:47 +0530
Message-Id: <20250225053447.16824-4-manivannan.sadhasivam@linaro.org>
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

irq_set_affinity_hint() API is deprecated now, so let's use the recommended
equivalent irq_set_affinity_and_hint().

Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-05266-QCAHSTSWPLZ_V2_TO_X86-1

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/net/wireless/ath/ath11k/pci.c | 2 +-
 drivers/net/wireless/ath/ath12k/pci.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless/ath/ath11k/pci.c
index eaac9eabcc70..be2791cd79d5 100644
--- a/drivers/net/wireless/ath/ath11k/pci.c
+++ b/drivers/net/wireless/ath/ath11k/pci.c
@@ -735,7 +735,7 @@ static int ath11k_pci_set_irq_affinity_hint(struct ath11k_pci *ab_pci,
 	if (test_bit(ATH11K_FLAG_MULTI_MSI_VECTORS, &ab_pci->ab->dev_flags))
 		return 0;
 
-	return irq_set_affinity_hint(ab_pci->pdev->irq, m);
+	return irq_set_affinity_and_hint(ab_pci->pdev->irq, m);
 }
 
 static int ath11k_pci_probe(struct pci_dev *pdev,
diff --git a/drivers/net/wireless/ath/ath12k/pci.c b/drivers/net/wireless/ath/ath12k/pci.c
index 2851f6944b86..9883cb2de548 100644
--- a/drivers/net/wireless/ath/ath12k/pci.c
+++ b/drivers/net/wireless/ath/ath12k/pci.c
@@ -646,7 +646,7 @@ static int ath12k_pci_set_irq_affinity_hint(struct ath12k_pci *ab_pci,
 	if (test_bit(ATH12K_PCI_FLAG_MULTI_MSI_VECTORS, &ab_pci->flags))
 		return 0;
 
-	return irq_set_affinity_hint(ab_pci->pdev->irq, m);
+	return irq_set_affinity_and_hint(ab_pci->pdev->irq, m);
 }
 
 static int ath12k_pci_config_irq(struct ath12k_base *ab)
-- 
2.25.1


