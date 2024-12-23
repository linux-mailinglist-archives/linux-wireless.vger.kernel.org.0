Return-Path: <linux-wireless+bounces-16720-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 958329FAA28
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Dec 2024 07:03:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E84B5167051
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Dec 2024 06:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44AF8174EF0;
	Mon, 23 Dec 2024 06:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="iYrb0QFk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40A818C03B
	for <linux-wireless@vger.kernel.org>; Mon, 23 Dec 2024 06:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734933727; cv=none; b=IZtYEaGsFCtK2Clz9omRLZUxxW0Ni11Wgv+5FKVnPFKJ+yfrSZSJgsCsbYuRI28UGAJ41cDyRi5o60PRSXNSpfVwo6YPAACGIpLrNpcG0FfN2XLxurTIqlKucUNzD/rXu39mt4TgQd7GxNZwZC6zTDr855+iJiU/p9pC7FQi1Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734933727; c=relaxed/simple;
	bh=C25h9oe0goiosXJlJzlBi2ih+yWZYRr0cCtfxEzcB70=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hs1yhUipYwFMS3P0wtjDbJF5tIXhMUaXaZ0hn4mlyzAegC1as3laT9yINii6qhX4MdvWscmnN63JPE7KCKED2+19zYj6zgspUjlHsoNMR7ylzIBErlWD/wDSTGchfcIoPImkK6riHLYPJer45ozsUU6x5lakBGEW2SWWnXOx7Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=iYrb0QFk; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BN2ruWn024937;
	Mon, 23 Dec 2024 06:02:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	u3ZiofJ2dnGX7tvQTk3m4WNnc2CRugeREMSa4Wb6MGc=; b=iYrb0QFkd22XJuVJ
	60qajXCsglXiuArMuOqCwJC1t9s0fBU74h9QSJIZfS3KgFV/zqRtd0gZi4OeF136
	bacxkiivyBGrw5ZMLmiFkOUmNzDOq9EmhwNQ6008xJTmTgCaUht+uRy2r+MFI6tE
	UkC2oNdJZpuPcjvKk2dgx6fWCODDMscwtWZUWpx67PXLc+J7YyRQnxxqo+A2SgTl
	RD9t+kYJrQlCJB4pLkssv7q/x6+b1UGTpSqCBmE1lAq6Ko1zDZPKFG0zj4fUAtdb
	Yn3JPvGKBCc3opLbMNTqnb34HJuUHmOVWXnf2QKKK9n5f5EaspQSEbZVXSj4NH6l
	rWnDJg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43pyft0k0b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Dec 2024 06:02:03 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BN623xw030470
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Dec 2024 06:02:03 GMT
Received: from hu-ppranees-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sun, 22 Dec 2024 22:02:01 -0800
From: P Praneesh <quic_ppranees@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, P Praneesh <quic_ppranees@quicinc.com>
Subject: [PATCH v2 08/14] wifi: ath12k: Add drop descriptor handling for monitor ring
Date: Mon, 23 Dec 2024 11:31:26 +0530
Message-ID: <20241223060132.3506372-9-quic_ppranees@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241223060132.3506372-1-quic_ppranees@quicinc.com>
References: <20241223060132.3506372-1-quic_ppranees@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Z-_OiZqIGvEYoSZPnfs5DKCnztfaH-4t
X-Proofpoint-GUID: Z-_OiZqIGvEYoSZPnfs5DKCnztfaH-4t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 suspectscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 mlxscore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412230051

When monitor block in Hardware experiences internal backpressure, a ring
entry with the EMPTY_DESC reason is received in the monitor destination
ring descriptor. The cookie field for this corresponding entry is invalid.
Currently driver attempts to process this cookie resulting in invalid
buf_id warning logs flooding the console. To fix this, skip processing the
destination descriptor when the EMPTY_DESCRIPTOR bit is set to true in ring
descriptor, thereby avoiding the processing of junk cookies.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: P Praneesh <quic_ppranees@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/dp_mon.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.c b/drivers/net/wireless/ath/ath12k/dp_mon.c
index 236456b02198..bf43ef2b6b39 100644
--- a/drivers/net/wireless/ath/ath12k/dp_mon.c
+++ b/drivers/net/wireless/ath/ath12k/dp_mon.c
@@ -2347,6 +2347,14 @@ int ath12k_dp_mon_srng_process(struct ath12k *ar, int *budget,
 		if (unlikely(!mon_dst_desc))
 			break;
 
+		/* In case of empty descriptor, the cookie in the ring descriptor
+		 * is invalid. Therefore, this entry is skipped, and ring processing
+		 * continues.
+		 */
+		info0 = le32_to_cpu(mon_dst_desc->info0);
+		if (u32_get_bits(info0, HAL_MON_DEST_INFO0_EMPTY_DESC))
+			goto move_next;
+
 		cookie = le32_to_cpu(mon_dst_desc->cookie);
 		buf_id = u32_get_bits(cookie, DP_RXDMA_BUF_COOKIE_BUF_ID);
 
-- 
2.34.1


