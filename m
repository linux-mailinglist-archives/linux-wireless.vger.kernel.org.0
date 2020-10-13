Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C18A228CA50
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Oct 2020 10:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391059AbgJMId6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 13 Oct 2020 04:33:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:54774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390540AbgJMId5 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 13 Oct 2020 04:33:57 -0400
Received: from lore-desk.redhat.com (unknown [176.207.245.61])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 441F62078A;
        Tue, 13 Oct 2020 08:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602578037;
        bh=9uKA5fhOJfrOsA093NN9QS4Zj4Q16an7LAYMpUaWVfU=;
        h=From:To:Cc:Subject:Date:From;
        b=T8sGfZUzm4QqbbuaWd7CHkajOuvC23cwJ92uw9+ahGtEBXBDkhWbnL+iHI/e3pPcY
         cbc7d4x1F1YVnN1yVdOqQyae7C5KQShVDrAwd7sA5mNdYYYKC7TOZUuj0HaA5df3UX
         HDxLpRK4wYhtQyCae57WfMkloHyKTYx3T9tbbwPs=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org
Subject: [PATCH] mt76: fix memory leak if device probing fails
Date:   Tue, 13 Oct 2020 10:33:49 +0200
Message-Id: <0b8f3c1109b359a688a25f45d57eac2678defc5e.1602577950.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Run mt76_free_device instead of ieee80211_free_hw if device probing
fails in order to remove the already allocated mt76 workqueue

Fixes: a86f1d01f5ce5 ("mt76: move mt76 workqueue in common code")
Fixes: f1d962369d568 ("mt76: mt7915: implement HE per-rate tx power support")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7603/pci.c  | 3 ++-
 drivers/net/wireless/mediatek/mt76/mt7615/mmio.c | 3 ++-
 drivers/net/wireless/mediatek/mt76/mt76x0/pci.c  | 3 ++-
 drivers/net/wireless/mediatek/mt76/mt76x2/pci.c  | 3 ++-
 drivers/net/wireless/mediatek/mt76/mt7915/pci.c  | 5 +++--
 5 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/pci.c b/drivers/net/wireless/mediatek/mt76/mt7603/pci.c
index a5845da3547a..06fa28f645f2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/pci.c
@@ -57,7 +57,8 @@ mt76pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	return 0;
 error:
-	ieee80211_free_hw(mt76_hw(dev));
+	mt76_free_device(&dev->mt76);
+
 	return ret;
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mmio.c b/drivers/net/wireless/mediatek/mt76/mt7615/mmio.c
index b108324aa816..a7f92fa0488f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mmio.c
@@ -240,7 +240,8 @@ int mt7615_mmio_probe(struct device *pdev, void __iomem *mem_base,
 
 	return 0;
 error:
-	ieee80211_free_hw(mt76_hw(dev));
+	mt76_free_device(&dev->mt76);
+
 	return ret;
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x0/pci.c b/drivers/net/wireless/mediatek/mt76/mt76x0/pci.c
index dda11c704aba..b87d8e136cb9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x0/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x0/pci.c
@@ -194,7 +194,8 @@ mt76x0e_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	return 0;
 
 error:
-	ieee80211_free_hw(mt76_hw(dev));
+	mt76_free_device(&dev->mt76);
+
 	return ret;
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/pci.c b/drivers/net/wireless/mediatek/mt76/mt76x2/pci.c
index 4d50dad29ddf..ecaf85b483ac 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/pci.c
@@ -90,7 +90,8 @@ mt76x2e_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	return 0;
 
 error:
-	ieee80211_free_hw(mt76_hw(dev));
+	mt76_free_device(&dev->mt76);
+
 	return ret;
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/pci.c b/drivers/net/wireless/mediatek/mt76/mt7915/pci.c
index fe62b4d853e4..3ac5bbb94d29 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/pci.c
@@ -140,7 +140,7 @@ static int mt7915_pci_probe(struct pci_dev *pdev,
 	dev = container_of(mdev, struct mt7915_dev, mt76);
 	ret = mt7915_alloc_device(pdev, dev);
 	if (ret)
-		return ret;
+		goto error;
 
 	mt76_mmio_init(&dev->mt76, pcim_iomap_table(pdev)[0]);
 	mdev->rev = (mt7915_l1_rr(dev, MT_HW_CHIPID) << 16) |
@@ -163,7 +163,8 @@ static int mt7915_pci_probe(struct pci_dev *pdev,
 
 	return 0;
 error:
-	ieee80211_free_hw(mt76_hw(dev));
+	mt76_free_device(&dev->mt76);
+
 	return ret;
 }
 
-- 
2.26.2

