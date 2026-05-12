Return-Path: <linux-wireless+bounces-36308-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qNjoGP3PAmoUxgEAu9opvQ
	(envelope-from <linux-wireless+bounces-36308-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 09:00:13 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0292A51B684
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 09:00:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7BEBA3050210
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 06:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E70334753A;
	Tue, 12 May 2026 06:53:11 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865B62DF126;
	Tue, 12 May 2026 06:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778568789; cv=none; b=N5pgCxUzHop2dx5wAYq8PnE9Om1VfIbR4/KyaDbVXCQ1bx0JdvBC2/zmB3jM87rO4TP/BT84sZUeLpxx4cWha9/Kijv7GBOawyh1lCtFmePd+DSZJWcMvMjKLwGme8w0mRk9ArgGXsXVyOx2oZZ6EsQB/Jh8+xAX7opUStaiRvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778568789; c=relaxed/simple;
	bh=dqpM75It1kqgtWQDMjIaDR75RehsfPxRvfaCAVv6Nvc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HEBfbT4BGVhhXE4pqlFi9MI6jvlZqM9JBVR89InKgpBT3KDVPu6W8BX4Q7hZnjDxCDR8yWJJ1UnrlEYB0CGOpwlX1YcPRSZnow4Tn/8GcXP6bO3IYFD7N63fdOLbh4R1CwhraCjsP2S+ZQ+gWW3I2m9O/5NlUcvFMNapcxFxWBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 32580b504dcf11f1aa26b74ffac11d73-20260512
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:22094f62-b49f-44b5-855e-a324c3fa6105,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:e7bac3a,CLOUDID:adbd089e3606ad659845e091c64c7deb,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850|898,TC:nil,Content:0|15|50,EDM:-
	3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,A
	V:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 32580b504dcf11f1aa26b74ffac11d73-20260512
X-User: zenghongling@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <zenghongling@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1101105870; Tue, 12 May 2026 14:52:52 +0800
From: Hongling Zeng <zenghongling@kylinos.cn>
To: nbd@nbd.name,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com,
	shayne.chen@mediatek.com,
	sean.wang@mediatek.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	xiong.huang@mediatek.com,
	madhurkumar004@gmail.com
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhongling0719@126.com,
	Hongling Zeng <zenghongling@kylinos.cn>
Subject: [PATCH] wifi: mt76: mt7921: fix resource leak in probe error path
Date: Tue, 12 May 2026 14:52:45 +0800
Message-Id: <20260512065245.46496-1-zenghongling@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0292A51B684
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36308-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[kylinos.cn];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_TO(0.00)[nbd.name,kernel.org,mediatek.com,gmail.com,collabora.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zenghongling@kylinos.cn,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,126.com,kylinos.cn];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_SPAM(0.00)[0.183];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:email,kylinos.cn:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

When pcim_iomap_region() or devm_kmemdup() fail, the code returns
directly without cleaning up previously allocated resources:
  - mt76_device allocated by mt76_alloc_device()
  - pci irq vectors allocated by pci_alloc_irq_vectors()
Fix this by jumping to the existing error cleanup path instead of
returning directly.

Fixes: ee5bb35d2b83 ("wifi: mt76: mt7921: switch to pcim_iomap_region")
Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
---
 drivers/net/wireless/mediatek/mt76/mt7921/pci.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
index 7a790ddf43bb..4bb436465a3d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
@@ -344,8 +344,10 @@ static int mt7921_pci_probe(struct pci_dev *pdev,
 	pci_set_drvdata(pdev, mdev);
 
 	regs =  pcim_iomap_region(pdev, 0, pci_name(pdev));
-	if (IS_ERR(regs))
-		return PTR_ERR(regs);
+	if (IS_ERR(regs)) {
+		ret = PTR_ERR(regs);
+		goto err_free_dev;
+	}
 
 	dev = container_of(mdev, struct mt792x_dev, mt76);
 	dev->fw_features = features;
@@ -359,8 +361,10 @@ static int mt7921_pci_probe(struct pci_dev *pdev,
 		/* MT7902 needs a mutable copy because wm2_complete_mask differs */
 		map = devm_kmemdup(&pdev->dev, &irq_map,
 				   sizeof(irq_map), GFP_KERNEL);
-		if (!map)
-			return -ENOMEM;
+		if (!map) {
+			ret = -ENOMEM;
+			goto err_free_dev;
+		}
 
 		map->rx.wm2_complete_mask = 0;
 		dev->irq_map = map;
-- 
2.25.1


