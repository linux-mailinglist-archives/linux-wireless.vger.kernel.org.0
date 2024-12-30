Return-Path: <linux-wireless+bounces-16919-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED4CE9FEA69
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Dec 2024 20:42:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB485161E3D
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Dec 2024 19:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E227D198E7B;
	Mon, 30 Dec 2024 19:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="Z97bWBYN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044DE199948
	for <linux-wireless@vger.kernel.org>; Mon, 30 Dec 2024 19:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735587734; cv=none; b=SUAAYCBBP3JrzBMsINH7YFx4gcp7fSL+0IdhcmZu19BuNunQN9yzjY2oNNlbPD0tWndsTej0DtwcPrXVfihcXxnICTWmYa095u1cOpz/0vkygEg9PXD+jO6MuTgQN/1IqON4NGqfKtjj6a3u4htWRu+uisSJMbwGkKicL36eN40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735587734; c=relaxed/simple;
	bh=NRNR2WIulWgduH6oGAUWLnQZ0jNlinGCTFOnM/6gsCo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rw6vFTVS1fLc8/LnsZAuti1aeFgqnpEJFv33CHPMh2wHJtEtBZNmsz7Sn28M48e5i44TZULwTPDnRnVG6PQXpreJrGLG9auMbh21GWUpxvLHuEkx2u1NMwtKCN7DrnSWBJQ/TQWs2Muh7kMTlgLX9G4AG/nOVSCxBguc0btNq/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=Z97bWBYN; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=iDAAUn/siem5nM/CSjqTtCJcwHPylgU8TPBYNDc2ViE=; b=Z97bWBYNGfJUn2GCSx+RA2YwM2
	c7rxiuGJjxdEybncFKoSaC5KZx4EXG9X5dfRn6QJ5NcbwkLy/dDeXI+/co4C5h73OV8HjFKg8fUqk
	RV3mAxMYirzTj/UG76bVjkM89eQBy3hr3OggtfqYe4lAvLIwsWDBmptZ7jWNRLXAluV4=;
Received: from p4ff13c5f.dip0.t-ipconnect.de ([79.241.60.95] helo=Maecks.lan)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1tSLeV-00GKzc-0h
	for linux-wireless@vger.kernel.org;
	Mon, 30 Dec 2024 20:42:11 +0100
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Subject: [PATCH 11/14] wifi: mt76: mt7915: firmware restart on devices with a second pcie link
Date: Mon, 30 Dec 2024 20:41:59 +0100
Message-ID: <20241230194202.95065-11-nbd@nbd.name>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241230194202.95065-1-nbd@nbd.name>
References: <20241230194202.95065-1-nbd@nbd.name>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It seems that the firmware checks the register used for detecting matching
PCIe links in order to figure out if a secondary PCIe link is enabled.
Write the register again just before starting the firmware on hw reset,
in order to fix an issue that left the second band unusable after restart.

Fixes: 9093cfff72e3 ("mt76: mt7915: add support for using a secondary PCIe link for gen1")
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c    | 2 ++
 drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h | 1 +
 drivers/net/wireless/mediatek/mt76/mt7915/pci.c    | 1 +
 3 files changed, 4 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 1b9dcdec142b..9b9158fdd4d9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -1388,6 +1388,8 @@ mt7915_mac_restart(struct mt7915_dev *dev)
 	if (dev_is_pci(mdev->dev)) {
 		mt76_wr(dev, MT_PCIE_MAC_INT_ENABLE, 0xff);
 		if (dev->hif2) {
+			mt76_wr(dev, MT_PCIE_RECOG_ID,
+				dev->hif2->index | MT_PCIE_RECOG_ID_SEM);
 			if (is_mt7915(mdev))
 				mt76_wr(dev, MT_PCIE1_MAC_INT_ENABLE, 0xff);
 			else
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index ac0b1f0eb27c..5fe872ef2e93 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -191,6 +191,7 @@ struct mt7915_hif {
 	struct device *dev;
 	void __iomem *regs;
 	int irq;
+	u32 index;
 };
 
 struct mt7915_phy {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/pci.c b/drivers/net/wireless/mediatek/mt76/mt7915/pci.c
index 39132894e8ea..07b0a5766eab 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/pci.c
@@ -42,6 +42,7 @@ static struct mt7915_hif *mt7915_pci_get_hif2(u32 idx)
 			continue;
 
 		get_device(hif->dev);
+		hif->index = idx;
 		goto out;
 	}
 	hif = NULL;
-- 
2.47.1


