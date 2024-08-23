Return-Path: <linux-wireless+bounces-11856-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AFEA495D225
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Aug 2024 17:56:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3151C1F216A5
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Aug 2024 15:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E5AC18C346;
	Fri, 23 Aug 2024 15:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jD9ZOmVP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E1118BC2E
	for <linux-wireless@vger.kernel.org>; Fri, 23 Aug 2024 15:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724428521; cv=none; b=ir+KSuu8HGFZtszh3ynShuhB0XpB/Mm60B9RGnzT9sdOQZf1Cs8OdhmigTjOawXXAcE15PIQ2eeT7N6mCUtq+73UCxjKhSvqCx0N3csMQlMLTWqOu9EGVko0DThivuwJ2zzD+my3wFkpBd1OEyOhc/OJ+VmxcbQ0yg71IolqJj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724428521; c=relaxed/simple;
	bh=GIdg1XXy8Jro+0pgnDnKjFDZ8YdtGulgcZyNmxPxD1E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u8Q/esF2rnKsTMypXIRKqcqiqiwbE/42uv7xwxPmxWBJ8aiYOXFA7hbOI1j3Do0HY8paRoxSuG6yIX0/6oFtwj2un1t1O9HSBrFlFjIUgiG2WrCXgC3ECRkls5lGt2Z2Lt091Htadd3uLdLOGiA4ZVKQfAnX+tfy0ClAq7maPl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jD9ZOmVP; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1fee6435a34so15878285ad.0
        for <linux-wireless@vger.kernel.org>; Fri, 23 Aug 2024 08:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724428519; x=1725033319; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oxYL4taGoTZve5PyKphI9oILj7NZymoSkWXTcdSeKf8=;
        b=jD9ZOmVPQcNqzChc5kSqHkGByVJUI5fBTjtZPvNCgP3DEonjOqzOfyU+V0AnhvKBFj
         PRb3K/+MrsbOzHF83M82xDKuc/FAczHIf156AZwpnQ0gTJ1iZgqLztmMl/P/Z7kOOYBN
         LiRePjcT1od71mnG6YNnfeauOhmWPraihyiEoAOg2x5pJrPHji05SuJvUFSNEpbRIn/x
         aRXRwNqPxkUAp4pr93M5XFCO/lh+W0sRiZfjpFsrZWgUiC/nV0J2qtIKmLBLWmvS9wiS
         2qVWdHsdkQUX4HdApiiMqT1MQmG4GGFKcI5f2UN5lclUrdMk5x+Blaj5VQGOiPrsxQ6A
         +89w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724428519; x=1725033319;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oxYL4taGoTZve5PyKphI9oILj7NZymoSkWXTcdSeKf8=;
        b=SEfBRNGvWyW4+r/wFX0GZu4x2mAr4cbDgWv3P/o7gqArgewUh8Xxjq2rNJZtS2jYCf
         lL28CVcIW6HNGww16O7Rx37pp3ZrqsqHoHutn8pgRNRWHO7dKPISzm0F40jKlpyxrHC1
         ve41L7XwVoLm0LBUrGhpgxPE6S79oZJ9VHpbe5CIw/iRXt/+/BRuXNZT4Lpb3VoFZKHU
         3WYSgla/DLnpRuZDMgGOrNRXovBJipGILI4g9/QLZK3qTaFKBiObGP2ZjyOz2fNy1hUj
         kJghntg0f15xcRkPE++CK25UV40XKKdoTE6pPmZBukVm8zdU9TjXZr8WznjF/w+ZdVH8
         NB0g==
X-Gm-Message-State: AOJu0YyvIRuFGSrej1sHHI+zY8G9oHPAwztuaxd0GOBTf8IEMgSyxkmh
	F8SzMyMDYCzBSCMTi4xww+OabOgokJXxN/iZJvAsDC8lmfT6yxvfKDnU+fmEOQ==
X-Google-Smtp-Source: AGHT+IG0hQCLMJ/jPI8GZvyX9YfaXQ63wg4NOQ3fxNxn6CdaQOyARVZhocSoJ0b7r/Slu5xTXGW1Bw==
X-Received: by 2002:a17:903:40c6:b0:201:d659:4c29 with SMTP id d9443c01a7336-2039e46ce0emr26667785ad.21.1724428519003;
        Fri, 23 Aug 2024 08:55:19 -0700 (PDT)
Received: from localhost.localdomain ([120.60.50.97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2038556649bsm29824005ad.49.2024.08.23.08.55.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 08:55:18 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: kvalo@kernel.org,
	jjohnson@kernel.org
Cc: linux-wireless@vger.kernel.org,
	ath12k@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 3/3] wifi: ath11k/ath12k: Replace irq_set_affinity_hint() with irq_set_affinity_and_hint()
Date: Fri, 23 Aug 2024 21:25:02 +0530
Message-Id: <20240823155502.57333-4-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240823155502.57333-1-manivannan.sadhasivam@linaro.org>
References: <20240823155502.57333-1-manivannan.sadhasivam@linaro.org>
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
index 0c22e18e65c7..03aa371f0187 100644
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
index f265c1b8ce4e..c3fb2886f24b 100644
--- a/drivers/net/wireless/ath/ath12k/pci.c
+++ b/drivers/net/wireless/ath/ath12k/pci.c
@@ -644,7 +644,7 @@ static int ath12k_pci_set_irq_affinity_hint(struct ath12k_pci *ab_pci,
 	if (test_bit(ATH12K_PCI_FLAG_MULTI_MSI_VECTORS, &ab_pci->flags))
 		return 0;
 
-	return irq_set_affinity_hint(ab_pci->pdev->irq, m);
+	return irq_set_affinity_and_hint(ab_pci->pdev->irq, m);
 }
 
 static int ath12k_pci_config_irq(struct ath12k_base *ab)
-- 
2.25.1


