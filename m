Return-Path: <linux-wireless+bounces-28127-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 54DFFBF4BC6
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Oct 2025 08:48:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 21AEF4E21DD
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Oct 2025 06:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F7420102B;
	Tue, 21 Oct 2025 06:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ChHmYlDq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF9C1FC8
	for <linux-wireless@vger.kernel.org>; Tue, 21 Oct 2025 06:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761029310; cv=none; b=mXPv3V+QQRIdRT9lQUB61arpSK1McaMIE87yDe6cz9l/XEHex0/5PH48W/7hTDKytnl1HwPop8+zBdAz9/YXZIO9IKPjRL9BVjKrTRxqNgCaHMW3FP9iEra2uRnkJAVUxE3PLir2nLEu6+yzovI9i5NSuANHLhuo5PdIKSAnQqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761029310; c=relaxed/simple;
	bh=JSO+AKJWjEEKCVNsCJnoj67/t3YElKkAqv3N30ifxHY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F0+0YasGdeikqLVg1hWZKHtUXulsCidWCf/HACP1UHg6HSq6Py/+zGVk2q7G5d3bJNjE9rz06PnLAdX8HdCRngFtLoJICesF72K++7SAfkqr35r/I/wodOteOON6VDKADLFM0RioG9lA4XhAdfSLIhjIt6TrZSk7uOrrRT6TAqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ChHmYlDq; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59L5s7Ln025686;
	Tue, 21 Oct 2025 06:48:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=iRfXu2QO7xv7UAVXNzAFO1Bv8Lgcl
	05baFC6HoYHlEU=; b=ChHmYlDqv7EQNVJY1/pNgATZgU023AronjmV6R+U+XlaP
	EUUsNj70dT1AMffCqy/V68WBF9VznhDJPyosRDw0RN7WKbEmyEi80nnMiB+Rpn4n
	8x3PZwXlsWIQelOMRXCcUCXF/+XkfUlWaMxW5+dD+CLT3WnSzoIml8p7r9wKcyaj
	jotsYGDvH/LGV9R56ErKp/5yy1bTyX1NWeO1cbCX+v/azI0hmGq3RjF9d3SigklW
	55FkfLwWBoCK/+HQM7cj9gSh9mYqcMkqHGPcYhmTPQcwTThYkBegcEs6TyA88Q4E
	dhgpziSUnedUPCnJkReCG6o4s5q85PW4kcPGb3ukA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49v2wav3ba-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Oct 2025 06:48:16 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59L5NDHG032449;
	Tue, 21 Oct 2025 06:48:15 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49v1bcj8tm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Oct 2025 06:48:15 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 59L6mF4O027956;
	Tue, 21 Oct 2025 06:48:15 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 49v1bcj8t9-1;
	Tue, 21 Oct 2025 06:48:15 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: sean.wang@mediatek.com, nbd@nbd.name, lorenzo@kernel.org,
        ryder.lee@mediatek.com, shayne.chen@mediatek.com,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
Cc: alok.a.tiwari@oracle.com, linux-arm-kernel@lists.infradead.org
Subject: [PATCH next] wifi: mt76: mt7996: fix typos in comments
Date: Mon, 20 Oct 2025 23:48:09 -0700
Message-ID: <20251021064812.1778297-1-alok.a.tiwari@oracle.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_07,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 mlxscore=0 adultscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510210052
X-Proofpoint-ORIG-GUID: pw4Ju7zReEZLduDqRzBrtA87ytdM1skJ
X-Authority-Analysis: v=2.4 cv=Pf3yRyhd c=1 sm=1 tr=0 ts=68f72cb0 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=gaQq3JutJcUdmgZVJE0A:9 cc=ntf awl=host:13624
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX3vWivK0Td3SJ
 B/teuvlGdOp9qzX+pjD+OrpkkBlTngwvk936L8qfR+7T6b18qx7sgXhvWU+NSmey/NIWheS43IS
 LPNfz7xuR/YJDT5bwGpG6gBXveE7+EdLvgtpzj5sYAyN9VdYiB3dUpBLg0QR2cFIm0QyAb4aywM
 v0BfQ0yyNXjbEuUkO5ELzVay0bEOQh33NnamJ6I3eszl6T3+wJpP4fXo7+s11kxuobvamafyAnR
 a6EuS2wbawOHA6ZtUSNmceEindtKSsWhdnANAl8wM9nqlWHmMosorRFYU7y799r23FIXdIh2MSP
 /v7PFiZjiFe2yjQqKgC1BcIsM06FMJJIhyCrCbtIixcSvAXKNJc6OjE2tWM7LCWLrhaOiFvOrMo
 tS6pjOl4wBfZ62bWUMV9mtwc9/RCayf7LWEdZjTJ6R83m5D3aHE=
X-Proofpoint-GUID: pw4Ju7zReEZLduDqRzBrtA87ytdM1skJ

Fix two minor comment typos in the mt7996 driver:
- "Tx/Tx" -> "Rx/Tx"
- "tnterrupt" -> "interrupt"

Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
---
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7996/pci.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index 59744e5593b6..c87b03adda69 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -2551,7 +2551,7 @@ void mt7996_mac_reset_work(struct work_struct *work)
 	mt76_wr(dev, MT_MCU_INT_EVENT, MT_MCU_INT_EVENT_RESET_DONE);
 	mt7996_wait_reset_state(dev, MT_MCU_CMD_NORMAL_STATE);
 
-	/* enable DMA Tx/Tx and interrupt */
+	/* enable DMA Rx/Tx and interrupt */
 	mt7996_dma_start(dev, false, false);
 
 	if (!is_mt7996(&dev->mt76) && dev->mt76.hwrro_mode == MT76_HWRRO_V3)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/pci.c b/drivers/net/wireless/mediatek/mt76/mt7996/pci.c
index 3f49bbbba3b9..c3fdaa7550be 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/pci.c
@@ -158,7 +158,7 @@ static int mt7996_pci_probe(struct pci_dev *pdev,
 		goto free_wed_or_irq_vector;
 
 	mt76_wr(dev, MT_INT_MASK_CSR, 0);
-	/* master switch of PCIe tnterrupt enable */
+	/* master switch of PCIe interrupt enable */
 	mt76_wr(dev, MT_PCIE_MAC_INT_ENABLE, 0xff);
 
 	if (hif2) {
-- 
2.50.1


