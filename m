Return-Path: <linux-wireless+bounces-27952-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F0AE3BD234E
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Oct 2025 11:08:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F2F594E1476
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Oct 2025 09:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ED9F2DF139;
	Mon, 13 Oct 2025 09:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aeQpyleO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD22D220F2A
	for <linux-wireless@vger.kernel.org>; Mon, 13 Oct 2025 09:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760346533; cv=none; b=NvEqvM1riljkvPdjm46ft9zguktEIFJvVMD9rYEsa2IqBBYRbzsLZjDkxnazJMDODdZGfiKmW+jTm/1lBh+i0pWDxzu+iu8FDPHjvjvCqVuicldppQTwAVNoWdsc8cRB7WCuMgmTl1TVK2czmgVasU3wjtnTJH8bclFSuniC4+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760346533; c=relaxed/simple;
	bh=8qncjzfcSLSfXP6mFCXjgHM0X64xkEpHhJWoSinNKvs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MMS8Mr5o5D6kjsDCW5AVxU8BxzootZ7SzzicTCi5CsAJSMlRhCxpnEd59fF+rlVFIsbimlOOx8ZwxOyOD6SmJy1eBLEo3xDsDGC1FZrpOhqKHQE2EUI7qohPoH4rBC9zFdiDa+JVCkOnqGTm2Ittw4wycRms5hXa0Wjx7s9Fbns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=aeQpyleO; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59D7u8p1030844;
	Mon, 13 Oct 2025 09:08:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=aDdSxgXuG/KYYt4kVs0ZMvJZZGdyU
	y6t+twUF1JMoqo=; b=aeQpyleOjIuq0nBljQlNguz8bXCWfvqDIpGf1l6w5C78D
	D5hpmFDQUwG0O6ivbfwUNvbDPSVOs4G0JtABeGirrJalGQ/JISru4vth2zg9Ijm6
	jBQ+1rNep7YU19m9zshQSOtaJPv20HUTh78HpHQJaB2vbjtFwvJIVSRFHo/2NxDJ
	odKzHiINRopKZ1brJLbxMfOhve2k4vEc9LBPU5yJPEVpus82scg/uhhfOYvCmiAf
	dNe+e3OvfNJ7J+IOO3/0Ja7acp+c/p6Vkyls95lxHQzokN+uhXEI6GOZkANYyzI5
	yrEJvzH1diCTeEL8I/kHxbO4xExbdB0BRpjQpXwyQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49qf47hudx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Oct 2025 09:08:42 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59D6njVn017202;
	Mon, 13 Oct 2025 09:08:42 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49qdp799ce-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Oct 2025 09:08:42 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 59D98euF033499;
	Mon, 13 Oct 2025 09:08:40 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 49qdp7993g-1;
	Mon, 13 Oct 2025 09:08:40 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: sean.wang@mediatek.com, chui-hao.chiu@mediatek.com, Bo.Jiao@mediatek.com,
        howard-yh.hsu@mediatek.com, meichia.chiu@mediatek.com,
        Money.Wang@mediatek.com, StanleyYP.Wang@mediatek.com, nbd@nbd.name,
        lorenzo@kernel.org, ryder.lee@mediatek.com, shayne.chen@mediatek.com,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
Cc: alok.a.tiwari@oracle.com, linux-arm-kernel@lists.infradead.org
Subject: [PATCH] wifi: mt76: mt7996: fix FCS error flag check in RX descriptor
Date: Mon, 13 Oct 2025 02:08:24 -0700
Message-ID: <20251013090826.753992-1-alok.a.tiwari@oracle.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-13_03,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 suspectscore=0 spamscore=0 mlxlogscore=870 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510020000
 definitions=main-2510130044
X-Authority-Analysis: v=2.4 cv=SK9PlevH c=1 sm=1 tr=0 ts=68ecc19a b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=x6icFKpwvdMA:10 a=yPCof4ZbAAAA:8 a=DCrMf5CXL9jqBmdGqfsA:9
X-Proofpoint-GUID: K1p-Oqcd0XEeZFZfYH1FfP-hQzFzUDcB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxNiBTYWx0ZWRfX0HYwiB32KN9M
 otEXwPebu83zXI1XrjxQ5VA85uhc7+YtYnK/s7v0wlgF8cT5Y1s9AQ37npZPmrlHgB6u5PFJ0Md
 QsY8QbdHhjapDsutMBQMr7kS6FxXhOnN8zqJXlziFJvLRkPF7Qzz8gRj6A+g+VeJxcmn92+s9HM
 MFIzqncDZzZ2F3ey5vL+iO2fcMqNYRJVNCrbm3R6Iov4h35qm+R6yTsEkAQK9ygSqFy0aANw5CV
 pBdnKlhz54QhEqInP9Iw4xZo+PumUQ3I7wj1P0Xy/AxZ0LJ4JqanPtJW12G9bEx7H6hHHSBOVpt
 LBpuuXys3b+iL4wV7ZO/Dfx2UlLwsolJc14rwLjSeL5vQQ3b4rRL8JGLvHzqZoX9oXsCnDLaAQB
 R5QJT49QPMRi38YPaEhjGUODaqu6gA==
X-Proofpoint-ORIG-GUID: K1p-Oqcd0XEeZFZfYH1FfP-hQzFzUDcB

The mt7996 driver currently checks the MT_RXD3_NORMAL_FCS_ERR bit in
rxd1 whereas other Connac3-based drivers(mt7925) correctly check this
bit in rxd3.

Since the MT_RXD3_NORMAL_FCS_ERR bit is defined in the fourth RX
descriptor word (rxd3), update mt7996 to use the proper descriptor
field. This change aligns mt7996 with mt7925 and the rest of the
Connac3 family.

Fixes: 98686cd21624 ("wifi: mt76: mt7996: add driver for MediaTek Wi-Fi 7 (802.11be) devices")
Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
---
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index 9501def3e0e3..59744e5593b6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -527,7 +527,7 @@ mt7996_mac_fill_rx(struct mt7996_dev *dev, enum mt76_rxq_id q,
 	    !(csum_status & (BIT(0) | BIT(2) | BIT(3))))
 		skb->ip_summed = CHECKSUM_UNNECESSARY;
 
-	if (rxd1 & MT_RXD3_NORMAL_FCS_ERR)
+	if (rxd3 & MT_RXD3_NORMAL_FCS_ERR)
 		status->flag |= RX_FLAG_FAILED_FCS_CRC;
 
 	if (rxd1 & MT_RXD1_NORMAL_TKIP_MIC_ERR)
-- 
2.50.1


