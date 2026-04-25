Return-Path: <linux-wireless+bounces-35306-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sJYGJj8b7WnefQAAu9opvQ
	(envelope-from <linux-wireless+bounces-35306-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Apr 2026 21:51:27 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D9BB46791A
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Apr 2026 21:51:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CDEE6300E17B
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Apr 2026 19:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FC14303C83;
	Sat, 25 Apr 2026 19:51:22 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB53309EFC
	for <linux-wireless@vger.kernel.org>; Sat, 25 Apr 2026 19:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777146682; cv=none; b=PkRQXcJx/7Yz9AsHreYyV3SYJ/6/KQ1j2RaNsBhxuTt0pdlYXQp+xUbLPIxRwM7Y69uwXkojBl1aOFGPs+097hVW/eON01o44WcTWvHMlTb9bQvhpoARhXsMiy1yo6efSLCsMDudEihyZDv5PCNfvGRSQsI1dhbb7ZGIZi9e6f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777146682; c=relaxed/simple;
	bh=LX5Mcz5GGYBCYfpheEJsaCYC7bhdMqvnWk7vmtITpDw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a6lwsLmKJEaxQYYzaXZbUlcuyxdsMVDyuqb8UKddwuISM0wUOLNzdNFYczvcwrd4TGcgY3yi33BkKrV/9h2GmVrXXvQei3iLQNjbqavLsHT+UkZjRpshLhdAYDAIYj/iGZKrdBPXmKuvtIPzG0CKOFoVWpWmhHihfQzD4L1YUyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7dbcb467f2bso8198342a34.3
        for <linux-wireless@vger.kernel.org>; Sat, 25 Apr 2026 12:51:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777146680; x=1777751480;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YTztHk/94U1DhMDW7lcOWTq/ciqorsxjY2G0pZWTPC8=;
        b=Du7kSw8TeYq5MVfcCVhUVGKx+YRAYxqMNQB1zqaABYbzPsbm/YsgWT8GjJw0wkUSy3
         xsxn2qLZDklKRobQnRBA1cBa1Fms+LWTEa9zHr3p3Tw9LSRef9WMA4Nl0f5EAWF+U7D0
         m6zFc3aEzIf2Ltrna8ov9QekssP/1vRqpE5in7fEtHkTGxp+5He471xlaJRF+YT7D2gR
         9ysB8bxk1Fu4+seonXVycvtLI7G3AwGe5Ecb7Uk3nTyvJcogNFoqZ/oR/UDqXsK6hbRZ
         euNjG1MwRYh3YICz4YzZxzlwEIcBd6u6mzImwwNyF4G9PXcWfNvYzLtULCeEKnaRi/t7
         WMjQ==
X-Gm-Message-State: AOJu0Yxjp78aEEW+KYPVmtLRGmZqZnONIbAo4vJhLEt3509S6sVHDqy6
	cBmi5yxNPFgnB2BcW5LwCy36q2R8TLfh2kwzLvqUvmzUjJZtdMyMmuTK
X-Gm-Gg: AeBDietyJ0+gruj0cfqfuv+rPeAGLo68XeoLk3RMGH3PEuRzxEIx/299FGRORVOMC4q
	/O/kGKAX4p1+gvY2DSTAdeI6USfpffVA6nl64+XqJrrCxLM0w7QAZpYWkJ8Al0s2hoKnaJ6tEkH
	WlD/j2Vv5MP9PxagVdMfjAC2wITHq8LJS+jpWjENYjJNn3YkEY3aoMYVsx4YiSK5Hyvyzdr/Yhx
	91A7oRcmRHHq5fKJvDlDisJNI7MrTO7ottCgc8CuRWoIN0WxuENtzLxqsdIM/QkIFGVUc9Rixil
	z/ycGGTh6z+InWxikdwKY6eYO1gNZth3zOGqM4tt+GoVUvs4z1dNIk0DdAjzzYHKsbCSz6Gz8W5
	Ah/fBCe6onNnZkz91o6/mOVId0tPhTwajE25nTSBSlF1HufvnZwLk2nkkOdHDVrxXm2fVYHQ+ja
	x5eYNRXDbqw5mwMLi9OfES+KWyi8diYdK5cU3pXyCtiBHEkCdyQb7+NnFU/OIZflyozoqghlecq
	RUsMWPMSsnC
X-Received: by 2002:a05:6830:264a:b0:7d9:ad90:5670 with SMTP id 46e09a7af769-7dc9518c0f3mr25019360a34.18.1777146680311;
        Sat, 25 Apr 2026 12:51:20 -0700 (PDT)
Received: from sean-HP-EliteBook-830-G6.attlocal.net ([2600:1702:5083:7610:2e29:c3c3:de27:ce76])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dcd164d2c3sm13987624a34.24.2026.04.25.12.51.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Apr 2026 12:51:19 -0700 (PDT)
From: Sean Wang <sean.wang@kernel.org>
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Javier Tia <floss@jetm.me>,
	Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH v5 09/21] wifi: mt76: mt7925: disable ASPM and runtime PM for MT7927
Date: Sat, 25 Apr 2026 14:49:59 -0500
Message-ID: <20260425195011.790265-10-sean.wang@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260425195011.790265-1-sean.wang@kernel.org>
References: <20260425195011.790265-1-sean.wang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2D9BB46791A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35306-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sean.wang@kernel.org,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	FROM_HAS_DN(0.00)[]

From: Javier Tia <floss@jetm.me>

Disable PCIe ASPM unconditionally for MT7927. The CONNINFRA power
domain and WFDMA register access are unreliable with PCIe L1 active,
causing throughput to drop from 1+ Gbps to ~200 Mbps.

Disable runtime PM and deep sleep for MT7927. The combo chip shares
a CONNINFRA power domain between WiFi (PCIe) and BT (USB).
SET_OWN/CLR_OWN transitions on the LPCTL register crash the BT
firmware, requiring a full power cycle to recover. PM enablement will
be addressed in a follow-up once safe power state transitions are
determined.

Reviewed-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Javier Tia <floss@jetm.me>
---
 drivers/net/wireless/mediatek/mt76/mt7925/init.c | 3 ++-
 drivers/net/wireless/mediatek/mt76/mt7925/pci.c  | 6 ++++--
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/init.c b/drivers/net/wireless/mediatek/mt76/mt7925/init.c
index c0c5cb9aff75..a8c2ca7c0efc 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/init.c
@@ -232,7 +232,8 @@ int mt7925_register_device(struct mt792x_dev *dev)
 	dev->pm.idle_timeout = MT792x_PM_TIMEOUT;
 	dev->pm.stats.last_wake_event = jiffies;
 	dev->pm.stats.last_doze_event = jiffies;
-	if (!mt76_is_usb(&dev->mt76)) {
+	/* MT7927: runtime PM crashes BT firmware on the shared CONNINFRA domain */
+	if (!mt76_is_usb(&dev->mt76) && !is_mt7927(&dev->mt76)) {
 		dev->pm.enable_user = true;
 		dev->pm.enable = true;
 		dev->pm.ds_enable_user = true;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/pci.c b/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
index 604c0e9ae7ba..1f05c212be02 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
@@ -350,7 +350,10 @@ static int mt7925_pci_probe(struct pci_dev *pdev,
 	if (ret)
 		goto err_free_pci_vec;
 
-	if (mt7925_disable_aspm)
+	is_mt7927_hw = (pdev->device == 0x6639 || pdev->device == 0x7927);
+
+	/* MT7927: ASPM L1 causes unreliable WFDMA register access */
+	if (mt7925_disable_aspm || is_mt7927_hw)
 		mt76_pci_disable_aspm(pdev);
 
 	ops = mt792x_get_mac80211_ops(&pdev->dev, &mt7925_ops,
@@ -371,7 +374,6 @@ static int mt7925_pci_probe(struct pci_dev *pdev,
 	dev = container_of(mdev, struct mt792x_dev, mt76);
 	dev->fw_features = features;
 	dev->hif_ops = &mt7925_pcie_ops;
-	is_mt7927_hw = (pdev->device == 0x6639 || pdev->device == 0x7927);
 	dev->irq_map = is_mt7927_hw ? &mt7927_irq_map : &irq_map;
 	mt76_mmio_init(&dev->mt76, pcim_iomap_table(pdev)[0]);
 	tasklet_init(&mdev->irq_tasklet, mt792x_irq_tasklet, (unsigned long)dev);
-- 
2.43.0


