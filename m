Return-Path: <linux-wireless+bounces-11124-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD56494BB77
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Aug 2024 12:41:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE7881C22B42
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Aug 2024 10:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D91A18C927;
	Thu,  8 Aug 2024 10:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b="ozr9FmFo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C3A18A926
	for <linux-wireless@vger.kernel.org>; Thu,  8 Aug 2024 10:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723113523; cv=none; b=HwtBw7stZxTm5B0UwCo0BcXiL+gvN+QsmHOUJmIn4c6jCSCB90br8ryfhZeDoOS6T3BOmyYioUV7fIcz+Q82d/OlfLYpSmokoXmWCTKohKRFJ++eJq4LfWxvOXUO0FwRV1BzX/Jn1ID0yf2+gB/t+bkMQSOU5hcJIpi1MuFt7Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723113523; c=relaxed/simple;
	bh=7lRTUOJd9l7+Yc4Tmvmx1lk56C9iy999COlHtT4vctE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RgEJbXmANdjCUqBdmTZ0vNxQNvygRWnp40YLdSj4dKoCIUJxGVjJjK+AbpcH1beC3JT9zM6syvWqKarlAfHWHAS49nyVRbBcE6tSY9OSlqmYWGCSISlv0Ka7uBN4zKq9DpfrycoPR2m5rmTN+fVQlBRiuoK1pVa5th4bwxkXn+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b=ozr9FmFo; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
From: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
	t=1723113507; bh=7lRTUOJd9l7+Yc4Tmvmx1lk56C9iy999COlHtT4vctE=;
	h=From:To:Cc:Subject:Date:From;
	b=ozr9FmFol2Trfhe++O7KAKCF5deT2Z+fTo9EhBejcSgZWM5pBeOjajcdLCp/ih2Jf
	 1cv0GPWKlz8+0lCApAT1scu6B6wDVSu4ePc62QkOEer8MOn4f+FwFjrQnHxcqrdsKf
	 E+lJNFOTu0sMO2EOA5gNDm/RXtLSgjQWIMECTMigNOGLAez2DYmZtPqpuDa+S0NH3Z
	 20GdyX8dUezMgO2nmHqwoYrk4jq4qsynrTf5WGTPO87wwILaAlJcOzwn6zonGymlsS
	 xwv1TpCUqXcu+Nm5+JPos4iafvVwNRNnjFHAOlDXsnJrA/V8+n5ftXKpjg0lbLIKsu
	 +XfYt4QbLknrQ==
To: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Cc: linux-wireless@vger.kernel.org,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Subject: [PATCH] Revert "wifi: ath9k: use devm for request_irq()"
Date: Thu,  8 Aug 2024 12:37:57 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <20240808103758.11696-1-toke@toke.dk>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Toke Høiland-Jørgensen <toke@redhat.com>

This reverts commit 92da4ce847bc5d942ddfdb102dba92f4e2797a59.

Felix pointed out that moving to devm for request_irq() can lead to a use after
free, and that avoiding that means having explicit frees that makes the devm
thing pretty pointless. So let's just revert the patch.

Link: https://lore.kernel.org/r/201f06b6-14f5-41bb-8897-49665cf14b66@nbd.name
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 drivers/net/wireless/ath/ath9k/ahb.c | 7 +++++--
 drivers/net/wireless/ath/ath9k/pci.c | 9 ++++++---
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/ahb.c b/drivers/net/wireless/ath/ath9k/ahb.c
index 29f67ded8fe2..1a6697b6e3b4 100644
--- a/drivers/net/wireless/ath/ath9k/ahb.c
+++ b/drivers/net/wireless/ath/ath9k/ahb.c
@@ -118,7 +118,7 @@ static int ath_ahb_probe(struct platform_device *pdev)
 	sc->mem = mem;
 	sc->irq = irq;
 
-	ret = devm_request_irq(&pdev->dev, irq, ath_isr, IRQF_SHARED, "ath9k", sc);
+	ret = request_irq(irq, ath_isr, IRQF_SHARED, "ath9k", sc);
 	if (ret) {
 		dev_err(&pdev->dev, "request_irq failed\n");
 		goto err_free_hw;
@@ -127,7 +127,7 @@ static int ath_ahb_probe(struct platform_device *pdev)
 	ret = ath9k_init_device(id->driver_data, sc, &ath_ahb_bus_ops);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to initialize device\n");
-		goto err_free_hw;
+		goto err_irq;
 	}
 
 	ah = sc->sc_ah;
@@ -137,6 +137,8 @@ static int ath_ahb_probe(struct platform_device *pdev)
 
 	return 0;
 
+ err_irq:
+	free_irq(irq, sc);
  err_free_hw:
 	ieee80211_free_hw(hw);
 	return ret;
@@ -150,6 +152,7 @@ static void ath_ahb_remove(struct platform_device *pdev)
 		struct ath_softc *sc = hw->priv;
 
 		ath9k_deinit_device(sc);
+		free_irq(sc->irq, sc);
 		ieee80211_free_hw(sc->hw);
 	}
 }
diff --git a/drivers/net/wireless/ath/ath9k/pci.c b/drivers/net/wireless/ath/ath9k/pci.c
index ccf73886199a..1ff53520f0a3 100644
--- a/drivers/net/wireless/ath/ath9k/pci.c
+++ b/drivers/net/wireless/ath/ath9k/pci.c
@@ -965,9 +965,9 @@ static int ath_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	}
 
 	if (!msi_enabled)
-		ret = devm_request_irq(&pdev->dev, pdev->irq, ath_isr, IRQF_SHARED, "ath9k", sc);
+		ret = request_irq(pdev->irq, ath_isr, IRQF_SHARED, "ath9k", sc);
 	else
-		ret = devm_request_irq(&pdev->dev, pdev->irq, ath_isr, 0, "ath9k", sc);
+		ret = request_irq(pdev->irq, ath_isr, 0, "ath9k", sc);
 
 	if (ret) {
 		dev_err(&pdev->dev, "request_irq failed\n");
@@ -979,7 +979,7 @@ static int ath_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	ret = ath9k_init_device(id->device, sc, &ath_pci_bus_ops);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to initialize device\n");
-		goto err_irq;
+		goto err_init;
 	}
 
 	sc->sc_ah->msi_enabled = msi_enabled;
@@ -991,6 +991,8 @@ static int ath_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	return 0;
 
+err_init:
+	free_irq(sc->irq, sc);
 err_irq:
 	ieee80211_free_hw(hw);
 	return ret;
@@ -1004,6 +1006,7 @@ static void ath_pci_remove(struct pci_dev *pdev)
 	if (!is_ath9k_unloaded)
 		sc->sc_ah->ah_flags |= AH_UNPLUGGED;
 	ath9k_deinit_device(sc);
+	free_irq(sc->irq, sc);
 	ieee80211_free_hw(sc->hw);
 }
 
-- 
2.46.0


