Return-Path: <linux-wireless+bounces-21364-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B05FA8351E
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Apr 2025 02:41:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0ACA0189DC66
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Apr 2025 00:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F8524D599;
	Thu, 10 Apr 2025 00:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lf593xk/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B911BF37;
	Thu, 10 Apr 2025 00:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744245696; cv=none; b=ixv04ZVVjTZVA61+PhBQBzUd4Rx0wmPnCQ0quzhcWYTfSvUn+OhC2LG4ICkx5LUBy30CRagtgU1sxSvNSNBD2gnHdseMsm0hrcpxcH0WGMVhTi4xpIx7YwfpCtXlqn0L73NOSCeg9twuinB/j23vvwX5n7kISzgBrKu8+gAsn/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744245696; c=relaxed/simple;
	bh=ZhlTPlODw+FG19rNTQh6W/2wCDNsuHRcvGPrD5Xm4KM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EL5Tkslzilo6IS3YOqJrRY7VzKq+XN6HA5vSvGozybEjklr83kfqAdCh2wdwYDDWUFZln5/jjr6roK1UguFsjdSrXt2/iONXRxHtMfMvXGJATcJu1hpMCoemt7is8ZU4nQakB5hkGHKwRS4KhUnH/1QBjkHNVmZoim1woveT92c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lf593xk/; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6ff37565232so2664327b3.3;
        Wed, 09 Apr 2025 17:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744245693; x=1744850493; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0C7QiXDinqCyUiPx9L8qA3LvMwM/UCtv09wdS4FSGh4=;
        b=lf593xk/X/6KVH9wxv5tWLXWNIyDLw5JbB9ecU1blm8NQbsKQMcXQFkKPWGeLXCEso
         fBdtoN3agYqpYR0dlWyVEU+mTke2LAwRgMp99cStkNkikkeMxDssmLlOAgukMlKj73Qw
         2/BmFdThEV/NqoGmuj/66aab2eHbKUSweAPil7pooNlsfEYQEOSZiy9aLUoeNIqTSDza
         z81yf7qDawLefbUDwDP1W4RbzXQ0/kMf7FBe/GQ956D4bPiIf3wxoN68a2rywoMR9W6L
         5E5uUPCPoBQss9o6Nb7V0TMQKlnjT9GyfnUdys9NYm7CoRkFNmGaH7cvygr5kp/EtK5p
         A67g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744245693; x=1744850493;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0C7QiXDinqCyUiPx9L8qA3LvMwM/UCtv09wdS4FSGh4=;
        b=idnZvDmVEvDz74Qa+cz49vKNLo7QEnh5PPgIBXr/Tr1PXCTrl29WUq5OoT13YyepIQ
         hFmB0swKtbL3MNtgIbagf8VDWsWAMBucABuPombB5oUrubywI/9WhHe02eFuMoMCwZrL
         eDpE+qyYuAdE+0uRz9LjDd+TSVJWHl75ahAoXbXlUIhcn+mJxevEy5AyiPtZJJUSHPNr
         2jGpUpUpo34vygpzCnxfJMBIqv8C0tHuoRsB56JtOt90QuP/3hP+QbvFU0CJuFcxrS2H
         zPDtM2HLHaGnjyblb06lZBfCqDWc6+i/0L6Nd2HZZXg2+7QKylanUSx3tsPALBLO2YBc
         nE2g==
X-Forwarded-Encrypted: i=1; AJvYcCXVqD4Ae3BV9UzFrpcpVYGNMmw+ZyWN4LfVQsHV/N8mV54R548taeckX6ssWbgQQ6C9mwX7Azo9BrqBI90=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvfPzYWuL8DHQbiJmf6XrRucIpUXrkL+EY43ddLEny9cw+0jdk
	mtDnPgHqAMmpI6DNVtaB/EjX20NtYE4HCXdjjHbRpL+T7rZCb7Xg6w/JNQ==
X-Gm-Gg: ASbGnct0uFVN22skthSCy/X41qMHKT75tN2M6eHi3IDJnoLn+7//a3NE5pa+OCYn5/t
	O74Xa7ZYqnKzs5RRDqPnVxPyiXd52Czrg59ewBsHkvIFYTs7etF4hpv/5Uh/IFFPLw7NzaN0Lw1
	t9wZs52l2nEobAFz86NiYn7QpKGEzRyLg4K8L6pIJQK0cHPSR7KjjYI5Q5EY6t2p2XHbK9al+zA
	WtPQXOwHtw3EImjdPjyyHXqZr3/9rERaOXQR/pn6hyYAyiZweFfFZ7gyAYTlJXWNrq9iZ5wIkXq
	sCCh0T/3MH40H5dH
X-Google-Smtp-Source: AGHT+IEBFiRpk3tXcCSdEJAIXxnRuntBhjLrtigBi1jmdYN+CSOMYNr9ssWAxIHni5cRm5/uhZ8kAA==
X-Received: by 2002:a05:690c:d8f:b0:6f9:7a3c:1fe with SMTP id 00721157ae682-7054a13e752mr13549207b3.23.1744245693172;
        Wed, 09 Apr 2025 17:41:33 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7053e13c1casm5334797b3.59.2025.04.09.17.41.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 17:41:32 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next] wifi: ath9k: use devm for irq and ioremap resource
Date: Wed,  9 Apr 2025 17:41:30 -0700
Message-ID: <20250410004130.49620-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Avoids having to manually free. Both of these get called and removed in
probe only and are safe to convert.

devm_platform_ioremap_resource is different as it also calls
devm_request_memory_region, which requires non overlapping memory
regions. Luckily, that seems to be the case.

Tested on a TP-Link Archer C7v2.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/wireless/ath/ath9k/ahb.c | 22 ++++++----------------
 drivers/net/wireless/ath/ath9k/pci.c |  9 +++------
 2 files changed, 9 insertions(+), 22 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/ahb.c b/drivers/net/wireless/ath/ath9k/ahb.c
index d4805e02b927..636a487bf9b4 100644
--- a/drivers/net/wireless/ath/ath9k/ahb.c
+++ b/drivers/net/wireless/ath/ath9k/ahb.c
@@ -74,7 +74,6 @@ static int ath_ahb_probe(struct platform_device *pdev)
 	void __iomem *mem;
 	struct ath_softc *sc;
 	struct ieee80211_hw *hw;
-	struct resource *res;
 	const struct platform_device_id *id = platform_get_device_id(pdev);
 	int irq;
 	int ret = 0;
@@ -86,16 +85,10 @@ static int ath_ahb_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (res == NULL) {
-		dev_err(&pdev->dev, "no memory resource found\n");
-		return -ENXIO;
-	}
-
-	mem = devm_ioremap(&pdev->dev, res->start, resource_size(res));
-	if (mem == NULL) {
+	mem = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(mem)) {
 		dev_err(&pdev->dev, "ioremap failed\n");
-		return -ENOMEM;
+		return PTR_ERR(mem);
 	}
 
 	irq = platform_get_irq(pdev, 0);
@@ -118,16 +111,16 @@ static int ath_ahb_probe(struct platform_device *pdev)
 	sc->mem = mem;
 	sc->irq = irq;
 
-	ret = request_irq(irq, ath_isr, IRQF_SHARED, "ath9k", sc);
+	ret = devm_request_irq(&pdev->dev, irq, ath_isr, IRQF_SHARED, "ath9k", sc);
 	if (ret) {
 		dev_err(&pdev->dev, "request_irq failed\n");
-		goto err_free_hw;
+		return ret;
 	}
 
 	ret = ath9k_init_device(id->driver_data, sc, &ath_ahb_bus_ops);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to initialize device\n");
-		goto err_irq;
+		goto err_free_hw;
 	}
 
 	ah = sc->sc_ah;
@@ -137,8 +130,6 @@ static int ath_ahb_probe(struct platform_device *pdev)
 
 	return 0;
 
- err_irq:
-	free_irq(irq, sc);
  err_free_hw:
 	ieee80211_free_hw(hw);
 	return ret;
@@ -152,7 +143,6 @@ static void ath_ahb_remove(struct platform_device *pdev)
 		struct ath_softc *sc = hw->priv;
 
 		ath9k_deinit_device(sc);
-		free_irq(sc->irq, sc);
 		ieee80211_free_hw(sc->hw);
 	}
 }
diff --git a/drivers/net/wireless/ath/ath9k/pci.c b/drivers/net/wireless/ath/ath9k/pci.c
index 27d4034c814e..48c7cae11e37 100644
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
2.49.0


