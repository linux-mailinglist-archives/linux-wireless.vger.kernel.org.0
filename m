Return-Path: <linux-wireless+bounces-15907-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00EEF9E4B9B
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Dec 2024 02:08:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42E8B2862D7
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Dec 2024 01:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B27B14286;
	Thu,  5 Dec 2024 01:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="aeXLmnaL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED7417579
	for <linux-wireless@vger.kernel.org>; Thu,  5 Dec 2024 01:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733360900; cv=none; b=Gn/KS5foNXBsxOTV0agLIwWlx/YcZK0tNTBJKUJnNfeQFmyQS0AdPNwLMhO3EBoO90EmFiZaKct+Sp635OSMhgg/OXLHaUoL1+WUwa36ejgb0vF3fGStV5jDJWlbvCKEkBKUNCW0OlRwwbgaY5D8e02inBGD/fgfYQ1k7kOg5tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733360900; c=relaxed/simple;
	bh=0w9pjqkfVkDlrBCHj6wY7GhX3YG3zbijUJegYWT/Fio=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f8i2Z+y0GGBZwng2J0si13UZE1AsjE5kdUaMYn34y6dkLT/eGmN9vaDF5VKxT35ydpr88PIPm4hsPBvRTt8jbnIq+4KmE/K5KedbJz5aFwHr/d9/SEpbCgkajbC2AAdnBsEmSQL1X3i5wtoz0VQsMwcYjZU6+u7O3jORZTBdL+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=aeXLmnaL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B4EDIpm010103;
	Thu, 5 Dec 2024 01:08:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZY2SL0nlM7GQhiF6oAu27DtxhPCwu2BzNtkmI3Jgjzs=; b=aeXLmnaLxQ1RVItY
	upHe01rvjbwF+ii2dGr8MHzdxe7W6c4sYIfPw6xGl/eMF1kJu72bTPhXHsL/xYvE
	yhxZ07SP3JUrXv6nqISetBpl/a8NlGj+j27NH74mQhdBZn9pb8Lw86bXyNEf53o+
	6JHhyLCrZZZFfi34OydjrX/NRD+0Tq4ykxpfEEpoQWOYDj6i2k+qY5iReie8yD1Z
	qKFx2av8KuaEjQbXK9dUzvSrAkfF69yO3wKP5dyOtuuMB5ot+Cglr6iSb/DijtDA
	5LrBFnrpDBJlwk6FB+Hd+hqfEdbhskZvCjUpFjqdGHW9hO5ioUI3wH8x61ZxktYC
	ySebKQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43a4by4mwj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Dec 2024 01:08:13 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4B518C9B001111
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 5 Dec 2024 01:08:12 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 4 Dec 2024 17:08:10 -0800
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
Subject: [PATCH v2 1/8] wifi: ath12k: Add documentation HTT_H2T_MSG_TYPE_RX_RING_SELECTION_CFG
Date: Thu, 5 Dec 2024 06:37:47 +0530
Message-ID: <20241205010754.2846603-2-quic_periyasa@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241205010754.2846603-1-quic_periyasa@quicinc.com>
References: <20241205010754.2846603-1-quic_periyasa@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: _XpzpFcdx5T8oj9hSYHjsGhOWgLcawEt
X-Proofpoint-ORIG-GUID: _XpzpFcdx5T8oj9hSYHjsGhOWgLcawEt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 impostorscore=0 suspectscore=0 adultscore=0 phishscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412050006

Add missing field documentation for HTT_H2T_MSG_TYPE_RX_RING_SELECTION_CFG
command with indentation alignment.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/dp.h | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp.h b/drivers/net/wireless/ath/ath12k/dp.h
index a120b7a8477d..4ec50962a2da 100644
--- a/drivers/net/wireless/ath/ath12k/dp.h
+++ b/drivers/net/wireless/ath/ath12k/dp.h
@@ -695,9 +695,9 @@ enum htt_stats_internal_ppdu_frametype {
  *
  *    The message would appear as follows:
  *
- *    |31       26|25|24|23            16|15             8|7             0|
- *    |-----------------+----------------+----------------+---------------|
- *    |   rsvd1   |PS|SS|     ring_id    |     pdev_id    |    msg_type   |
+ *    |31   29|28|27|26|25|24|23       16|15             8|7             0|
+ *    |-------+--+--+--+--+--+-----------+----------------+---------------|
+ *    | rsvd1 |ED|DT|OV|PS|SS|  ring_id  |     pdev_id    |    msg_type   |
  *    |-------------------------------------------------------------------|
  *    |              rsvd2               |           ring_buffer_size     |
  *    |-------------------------------------------------------------------|
@@ -724,7 +724,13 @@ enum htt_stats_internal_ppdu_frametype {
  *                    More details can be got from enum htt_srng_ring_id
  *          b'24    - status_swap: 1 is to swap status TLV
  *          b'25    - pkt_swap:  1 is to swap packet TLV
- *          b'26:31 - rsvd1:  reserved for future use
+ *          b'26    - rx_offset_valid (OV): flag to indicate rx offsets
+ *		      configuration fields are valid
+ *          b'27    - drop_thresh_valid (DT): flag to indicate if the
+ *		      rx_drop_threshold field is valid
+ *          b'28    - rx_mon_global_en: Enable/Disable global register
+ *		      configuration in Rx monitor module.
+ *          b'29:31 - rsvd1:  reserved for future use
  * dword1 - b'0:16  - ring_buffer_size: size of buffers referenced by rx ring,
  *                    in byte units.
  *                    Valid only for HW_TO_SW_RING and SW_TO_HW_RING
-- 
2.34.1


