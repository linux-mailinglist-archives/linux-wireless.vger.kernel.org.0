Return-Path: <linux-wireless+bounces-27977-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BBC8BDCE2A
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Oct 2025 09:19:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7F6594E9088
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Oct 2025 07:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A49F73191BA;
	Wed, 15 Oct 2025 07:16:20 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE79626560B;
	Wed, 15 Oct 2025 07:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760512580; cv=none; b=rv7cf1avSXSrw+pFG2iPeSV72+0KMxzlb7SRFHuz10rkYkuL8cAqBdV8ilV54Z4eLzhi1AoZmBiO4rGWGwtvqddps3NbNLpq0j9pevE2o6/K3veASyF6r0CB85oGC06aPHfaN8HvZITvQrClDjuVF4xGei0H0PxpSBaGJYnMyO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760512580; c=relaxed/simple;
	bh=WHXyXlFtTs0SB7NFWm71xtytwP0fISozo3+fE+yjRH8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JdA9iu5aC1Xf6sWf5VuUwZLdS3zIDlsBzniyJ0Ero1azRWAu3qOEuvjfKpy9UXVYS/GUgPGP0REKd4PgXpT4WO+whpjfLS5fuWnqafmEKxf346i+Kh/oSDe7HWQoRkifQbws5NLHwbQjonGzNniom6NbLnq53oRuLlRbxQ6bCuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: d4924468a99611f0a38c85956e01ac42-20251015
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:cf5af701-aa01-4452-9393-6bd62fe65be5,IP:0,UR
	L:0,TC:0,Content:-5,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:20
X-CID-META: VersionHash:a9d874c,CLOUDID:e5e50e506e81255d17d8e4df42aaa770,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850,TC:nil,Content:0|50,EDM:5,IP:nil
	,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:
	1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: d4924468a99611f0a38c85956e01ac42-20251015
X-User: liqiang01@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <liqiang01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 397002641; Wed, 15 Oct 2025 15:16:12 +0800
From: Li Qiang <liqiang01@kylinos.cn>
To: arend.vanspriel@broadcom.com,
	linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com
Cc: linux-kernel@vger.kernel.org,
	Li Qiang <liqiang01@kylinos.cn>
Subject: [PATCH] wifi: brcmfmac: Add null pointer check to brcmf_acpi_probe
Date: Wed, 15 Oct 2025 15:16:07 +0800
Message-Id: <20251015071607.96415-1-liqiang01@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

devm_kasprintf() returns a pointer to dynamically allocated memory
which can be NULL upon failure.

Fixes: 0f485805d008a ("wifi: brcmfmac: acpi: Add support for fetching Apple ACPI properties")
Signed-off-by: Li Qiang <liqiang01@kylinos.cn>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/acpi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/acpi.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/acpi.c
index c4a54861bfb4..f8f6433bdf69 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/acpi.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/acpi.c
@@ -25,6 +25,8 @@ void brcmf_acpi_probe(struct device *dev, enum brcmf_bus_type bus_type,
 		settings->board_type = devm_kasprintf(dev, GFP_KERNEL,
 						      "apple,%s",
 						      o->string.pointer);
+		if (!settings->board_type)
+			return;
 	} else {
 		brcmf_dbg(INFO, "No ACPI module-instance\n");
 		return;
-- 
2.25.1


