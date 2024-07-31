Return-Path: <linux-wireless+bounces-10769-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7F6F94377E
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jul 2024 23:02:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93BA9280C51
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jul 2024 21:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10AAD4E1B3;
	Wed, 31 Jul 2024 21:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OCmuGiLe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861263F9C5
	for <linux-wireless@vger.kernel.org>; Wed, 31 Jul 2024 21:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722459767; cv=none; b=LLpso8e1K9WiJDZPcxgFw19kr7UAu6pFLVEV1roris0pw4Pn4VoMPufgzQRr4v0+oW9rRA9gZRCrFNvOeFDLWG9cBQ3BOYY/NUdX4tXsgLdm1iHV6B9xvzKfETggRxZLEsRkRa59JM8LjW91DAUF6UWeteFqe3NLphWvhGcnwe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722459767; c=relaxed/simple;
	bh=T84zz7u3spsa0jJ8t/rS2WduxXTrgD+H+0aY8OmWVv8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=FG8eQF3rEP7pdl/s38769KmMGsefVdjaYhbXTr+PXE8NtdRpjebXRTs7/RZYGdF7EDSvJmZgZEoR+WTtLdEFrTLrLM5/+Uh9CGyM8jVLarFnsqkbwuea3/kSAy5HPBWvoq5A7JBkyRd7HY472w6mV+ZTTNcC5NFam0NPwZZ9Jgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OCmuGiLe; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1fda7fa60a9so56817795ad.3
        for <linux-wireless@vger.kernel.org>; Wed, 31 Jul 2024 14:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722459764; x=1723064564; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=0K6Ww4nQPCA2tncEYOxWiMvMPOmVlPiiZSVURh/7NcQ=;
        b=OCmuGiLemPhANmZkcCMm9Ell1TaXIecBoZCWyykMuLJyYW9wLS2k4gvhIQMTpYR+oN
         1z6nl+P7uZrv2V/6TxdsDt9Y9AOA1XxwSJ1yIzwtd87bmWglvpmJqAm+WnzUKU7AsTVU
         ZIMNB6Gytbh1r1SS9BwEN8puCvayc1Wh0AnDGRkajssWDLQ9b+pWYDoVjWJagw3jPCW4
         /9b5lz6+covdHDZPVjh6maUjWRTLTvJFx3R96nuSV5YiD3Rg4No1ZsAwLbyq4OFgbhVr
         zkz9xMtUWSWAOm2vo7UZmiLy9rXgp8k4qb3xs8R8OGFAkv6xXOD4tlEOvyGohxu+YRni
         BFdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722459764; x=1723064564;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0K6Ww4nQPCA2tncEYOxWiMvMPOmVlPiiZSVURh/7NcQ=;
        b=ssagfuhKhTPlpfHm/feyl5BMIrGTQHT2nl+iGF71AXUhiASAJQ0PQX5UC9rv7Ylyn1
         ZxynwhSPtEuFe57vl9F2fQeb56/d3fXBI26qfSqcUyrn0ceYifZK2N9vpPBEUxHru8Z0
         JSPaeLtZ5m2YE6bYVGhEkZJZz3w1coyb8xAO74PMd8NXrCPyEZketDe390w87jlQ9oHH
         zIrsRRdlz+RPrMsWjP1SEkaaA1SV8YgLwc99eGCvpKDVwauY/9tyeBqJ4k+B2GWeVwum
         I/xCMI9VDLHrCZHqAAoFmrPsk50rQ2JVYridfB3naJeoDYD9gp5VDuV5fnTCJX0nyHtZ
         u3eA==
X-Gm-Message-State: AOJu0YzJ/PThpWEysEGW11NIeqgYAn1DqAGMAIljvQDYSjaP61WxIYwS
	qK0TLHeULRIVofaydPxyni6rd1eJLQqL14hDnc6Naedv/4TMlapalPcv/A==
X-Google-Smtp-Source: AGHT+IFy5BC0jYnRqCzM2oEXDa5hI2fZBIgLbvA8WdF0Xomp/w+WevhNrm78cM5ToL+Sa5txM1Y5Eg==
X-Received: by 2002:a17:902:e752:b0:1fd:8c25:4145 with SMTP id d9443c01a7336-1ff4ce76936mr7759305ad.17.1722459764513;
        Wed, 31 Jul 2024 14:02:44 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7ca8fd5sm124508615ad.64.2024.07.31.14.02.43
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 14:02:44 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-wireless@vger.kernel.org
Subject: [PATCH] net: ath9k: use devm for request_irq
Date: Wed, 31 Jul 2024 14:02:40 -0700
Message-ID: <20240731210243.7467-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Avoids having to manually call free_irq. Simplifies code slightly.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/wireless/ath/ath9k/ahb.c | 7 ++-----
 drivers/net/wireless/ath/ath9k/pci.c | 9 +++------
 2 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/ahb.c b/drivers/net/wireless/ath/ath9k/ahb.c
index 1a6697b6e3b4..29f67ded8fe2 100644
--- a/drivers/net/wireless/ath/ath9k/ahb.c
+++ b/drivers/net/wireless/ath/ath9k/ahb.c
@@ -118,7 +118,7 @@ static int ath_ahb_probe(struct platform_device *pdev)
 	sc->mem = mem;
 	sc->irq = irq;
 
-	ret = request_irq(irq, ath_isr, IRQF_SHARED, "ath9k", sc);
+	ret = devm_request_irq(&pdev->dev, irq, ath_isr, IRQF_SHARED, "ath9k", sc);
 	if (ret) {
 		dev_err(&pdev->dev, "request_irq failed\n");
 		goto err_free_hw;
@@ -127,7 +127,7 @@ static int ath_ahb_probe(struct platform_device *pdev)
 	ret = ath9k_init_device(id->driver_data, sc, &ath_ahb_bus_ops);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to initialize device\n");
-		goto err_irq;
+		goto err_free_hw;
 	}
 
 	ah = sc->sc_ah;
@@ -137,8 +137,6 @@ static int ath_ahb_probe(struct platform_device *pdev)
 
 	return 0;
 
- err_irq:
-	free_irq(irq, sc);
  err_free_hw:
 	ieee80211_free_hw(hw);
 	return ret;
@@ -152,7 +150,6 @@ static void ath_ahb_remove(struct platform_device *pdev)
 		struct ath_softc *sc = hw->priv;
 
 		ath9k_deinit_device(sc);
-		free_irq(sc->irq, sc);
 		ieee80211_free_hw(sc->hw);
 	}
 }
diff --git a/drivers/net/wireless/ath/ath9k/pci.c b/drivers/net/wireless/ath/ath9k/pci.c
index 1ff53520f0a3..ccf73886199a 100644
--- a/drivers/net/wireless/ath/ath9k/pci.c
+++ b/drivers/net/wireless/ath/ath9k/pci.c
@@ -965,9 +965,9 @@ static int ath_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	}
 
 	if (!msi_enabled)
-		ret = request_irq(pdev->irq, ath_isr, IRQF_SHARED, "ath9k", sc);
+		ret = devm_request_irq(&pdev->dev, pdev->irq, ath_isr, IRQF_SHARED, "ath9k", sc);
 	else
-		ret = request_irq(pdev->irq, ath_isr, 0, "ath9k", sc);
+		ret = devm_request_irq(&pdev->dev, pdev->irq, ath_isr, 0, "ath9k", sc);
 
 	if (ret) {
 		dev_err(&pdev->dev, "request_irq failed\n");
@@ -979,7 +979,7 @@ static int ath_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	ret = ath9k_init_device(id->device, sc, &ath_pci_bus_ops);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to initialize device\n");
-		goto err_init;
+		goto err_irq;
 	}
 
 	sc->sc_ah->msi_enabled = msi_enabled;
@@ -991,8 +991,6 @@ static int ath_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	return 0;
 
-err_init:
-	free_irq(sc->irq, sc);
 err_irq:
 	ieee80211_free_hw(hw);
 	return ret;
@@ -1006,7 +1004,6 @@ static void ath_pci_remove(struct pci_dev *pdev)
 	if (!is_ath9k_unloaded)
 		sc->sc_ah->ah_flags |= AH_UNPLUGGED;
 	ath9k_deinit_device(sc);
-	free_irq(sc->irq, sc);
 	ieee80211_free_hw(sc->hw);
 }
 
-- 
2.45.2


