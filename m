Return-Path: <linux-wireless+bounces-11855-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1FDD95D224
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Aug 2024 17:56:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52DB3283E83
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Aug 2024 15:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C57B118BC10;
	Fri, 23 Aug 2024 15:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JbGnkPte"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4328318BBBB
	for <linux-wireless@vger.kernel.org>; Fri, 23 Aug 2024 15:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724428518; cv=none; b=m/hPfZx3scZ1LgQOGFDEkZ4rRnH3118L3OFYf4YxSynMN2rMu+rkyi1jrtCh0IL4JStmjxJhpVxmP5HkU5kAo/0+DswgtLMn69j2mwm28OnPkAni+BeXZepYR3hYAOxvLj8KbpSQZDFX2SxXQ/n+0U6SECGOuUNB8zVhRdiszoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724428518; c=relaxed/simple;
	bh=I2OaP2G9ZSUZb5B1yFwzmWeX6kKkcvOPS4FPAh5q6eA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OcgO4HJFp+i9ghPr0QdhrwsoedwG04MeRZ4em+Yoll7LjsyLQX1hibXlSLHTQgpsEh21nFHTvTkZGqplVWohl+by5OCd/QyKXpObInNhM+ZWIebSToj1MMz3Tk2fWG7oj3IFFEvxDE/+/xE5lAy8mcleqRc9+FRXYD834FnyKFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JbGnkPte; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20231aa8908so18694545ad.0
        for <linux-wireless@vger.kernel.org>; Fri, 23 Aug 2024 08:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724428516; x=1725033316; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z6OlRtyM144d7+hDbDg/Ar+tRLxHvv6vXiCYuDqqU2U=;
        b=JbGnkPteAEQrYJX4bDnXAdGh0kF4bQqOdV/rSoz2NipOgo/Kq8cPvYgi8YB5cm2pIX
         nj9IMzaOEwqi/2zTu5ma3L9oIlBgxGbAd8GCusD+zG/s2NIaBfKVAJl0GQEGKig5GoWV
         VAVjLtRymVJ6l+9MU26mdIFxTQhO9dJPiXr1oAM+hTcVFKniIfLqCHbj+AlKA3t0VBuf
         oymosoViVjefimOs+3RCkxKwi3MDk+mtI1n0uN5Wkf8n3HTK0yzgb/FV2jTUEsTP76xF
         jR8ir7xT0PgzMrma+7Tzp+r3khrpSJcXJq+lgVvFdKB226WFavdHrENEPNFQummPLnB5
         2N5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724428516; x=1725033316;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z6OlRtyM144d7+hDbDg/Ar+tRLxHvv6vXiCYuDqqU2U=;
        b=NKZhMudkHXJn1RNXqkS2kfZFh4ZLZKpDiFFQIM2iUud3NrMDLMvpkuDW7SQki7q87b
         hz3UOVvZtQ5Mz1mc4kgI5Cpy2mmJaJDQfk2h27z1IKj1V3rGJFKGYdIIbrECvTAwa5Sw
         pV06idOz/1AE7XqhxGjxD7Uez1LOSrzbtqP3/pBgcmSilZp1j9SJrpf6l6PZkOiNlRek
         Vv74ecXbO/XkcFOTgW381FkFDpy+n5NxU0KB7LVuhnKrPmD5YvBrd9j51UwN8qX89wta
         5WvLkJhO3MXY9Y9VyG7dcKP432Rre3XSQei8tJJYjOpqdHsqfcmSalIEnSkW280uWw+z
         k0qA==
X-Gm-Message-State: AOJu0YwfmY8bEqbty85XYIFY3kujpbSzqOhwjDfAvwXfjnTXoklJcRxY
	1mEt56++tQhYi8LdoMeT7qtB0Uz3VC+jTeRdFdnfYe8mmLUMJfViGesrSIBhjQ==
X-Google-Smtp-Source: AGHT+IHU9XYQVlwdi75xAtVt2K4NPPU34/rpoSBNw0HOQIYbBIP/tEV3woHJzuCA/9MOnobrbzXezA==
X-Received: by 2002:a17:903:244b:b0:203:a0c6:91e5 with SMTP id d9443c01a7336-203a0c691femr20981215ad.51.1724428516533;
        Fri, 23 Aug 2024 08:55:16 -0700 (PDT)
Received: from localhost.localdomain ([120.60.50.97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2038556649bsm29824005ad.49.2024.08.23.08.55.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 08:55:16 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: kvalo@kernel.org,
	jjohnson@kernel.org
Cc: linux-wireless@vger.kernel.org,
	ath12k@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 2/3] wifi: ath12k: Set IRQ affinity hint after requesting all shared IRQs
Date: Fri, 23 Aug 2024 21:25:01 +0530
Message-Id: <20240823155502.57333-3-manivannan.sadhasivam@linaro.org>
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

If a shared IRQ is used by the driver due to platform limitation, then the
IRQ affinity hint is set right after the allocation of IRQ vectors in
ath11k_pci_alloc_msi(). This does no harm unless one of the functions
requesting the IRQ fails and attempt to free the IRQ.

This may end up with a warning from the IRQ core that is expecting the
affinity hint to be cleared before freeing the IRQ:

kernel/irq/manage.c:

	/* make sure affinity_hint is cleaned up */
	if (WARN_ON_ONCE(desc->affinity_hint))
		desc->affinity_hint = NULL;

So to fix this, let's set the IRQ affinity hint after requesting all the
shared IRQ. This will make sure that the affinity hint gets cleared in the
error path before freeing the IRQ.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/net/wireless/ath/ath12k/pci.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/pci.c b/drivers/net/wireless/ath/ath12k/pci.c
index 9e0b9e329bda..f265c1b8ce4e 100644
--- a/drivers/net/wireless/ath/ath12k/pci.c
+++ b/drivers/net/wireless/ath/ath12k/pci.c
@@ -1446,16 +1446,10 @@ static int ath12k_pci_probe(struct pci_dev *pdev,
 	if (ret)
 		goto err_pci_msi_free;
 
-	ret = ath12k_pci_set_irq_affinity_hint(ab_pci, cpumask_of(0));
-	if (ret) {
-		ath12k_err(ab, "failed to set irq affinity %d\n", ret);
-		goto err_pci_msi_free;
-	}
-
 	ret = ath12k_mhi_register(ab_pci);
 	if (ret) {
 		ath12k_err(ab, "failed to register mhi: %d\n", ret);
-		goto err_irq_affinity_cleanup;
+		goto err_pci_msi_free;
 	}
 
 	ret = ath12k_hal_srng_init(ab);
@@ -1476,6 +1470,12 @@ static int ath12k_pci_probe(struct pci_dev *pdev,
 		goto err_ce_free;
 	}
 
+	ret = ath12k_pci_set_irq_affinity_hint(ab_pci, cpumask_of(0));
+	if (ret) {
+		ath12k_err(ab, "failed to set irq affinity %d\n", ret);
+		goto err_free_irq;
+	}
+
 	/* kernel may allocate a dummy vector before request_irq and
 	 * then allocate a real vector when request_irq is called.
 	 * So get msi_data here again to avoid spurious interrupt
@@ -1484,16 +1484,19 @@ static int ath12k_pci_probe(struct pci_dev *pdev,
 	ret = ath12k_pci_config_msi_data(ab_pci);
 	if (ret) {
 		ath12k_err(ab, "failed to config msi_data: %d\n", ret);
-		goto err_free_irq;
+		goto err_irq_affinity_cleanup;
 	}
 
 	ret = ath12k_core_init(ab);
 	if (ret) {
 		ath12k_err(ab, "failed to init core: %d\n", ret);
-		goto err_free_irq;
+		goto err_irq_affinity_cleanup;
 	}
 	return 0;
 
+err_irq_affinity_cleanup:
+	ath12k_pci_set_irq_affinity_hint(ab_pci, NULL);
+
 err_free_irq:
 	ath12k_pci_free_irq(ab);
 
@@ -1509,9 +1512,6 @@ static int ath12k_pci_probe(struct pci_dev *pdev,
 err_pci_msi_free:
 	ath12k_pci_msi_free(ab_pci);
 
-err_irq_affinity_cleanup:
-	ath12k_pci_set_irq_affinity_hint(ab_pci, NULL);
-
 err_pci_free_region:
 	ath12k_pci_free_region(ab_pci);
 
-- 
2.25.1


