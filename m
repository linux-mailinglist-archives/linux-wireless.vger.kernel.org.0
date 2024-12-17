Return-Path: <linux-wireless+bounces-16460-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26F2F9F480D
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Dec 2024 10:53:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 152BF169897
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Dec 2024 09:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 045C71DFD91;
	Tue, 17 Dec 2024 09:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="FhEkD8B+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454348493
	for <linux-wireless@vger.kernel.org>; Tue, 17 Dec 2024 09:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734429176; cv=none; b=a1fTaHNZfXKHrRyvNl1JYJ5CA8SKpGNg8CdP6eseV7SvlWUVDqwgcxgXaDuk5OTNn/yUArxJPrXA2IRLN+AMpxHsT4wxlTgVaZsxxp4c4xLKTrSfDWnTDL4tzn+RxvAZ9SeTEhzSngT8zyr5Y5fmliuIUybPY0eJremJPJe/Sl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734429176; c=relaxed/simple;
	bh=QbuFvajpUU7aATCZ/YoO/wyU+DZSysQJyXVnhdHSSOk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LyRpDZ/pZkK62d2GK5RERc3BW+xCZsNRVsL6shVe8UKoSeagnuxfQsDdpI9WfS2Lp5CN7elKiGUnYs+UwZemU0ydPe4yBZ4UBWLhZ+Gj+Yb5tLM1ryqScjUEjHbk+tbW/pNuVWiMmtEtfoIKHVUMdEfSTwBVlPqESq/Uj6hoteE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=FhEkD8B+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BH57bZV016377;
	Tue, 17 Dec 2024 09:52:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	d5Ip1wOE346Jxu+0O183RbBM7WtgOj9IVfUryGQ9JDI=; b=FhEkD8B+PPoV1UHp
	mgLdUAdH04s89Uijb2pDSEvOfbQV4fBr4LPhmXzGaI8bIQBAG6GpvF8raJYZPJQ2
	1jwqI4g3+D7EBJ4P5wzNobZcGI66lJ3qIcrDbos5t/oC0CT2IQ9Wl1EJJw8gzAWi
	yF23ygAo3Z3CEpkQDJDN/HtikguAD74UxDADRFfgMpiRxnMXni8z0RaZkAtYYKiZ
	KaJcQGWRF+g3m7I5De73J/dHQjHx3aHe8Kb6aQc54IpcN/Py4tgNNj3nqMDMgHDn
	Cu7b6h1G2GoX8FCzVAnvJa1kzVeDl1tweVC8WrtRf0zAzIiLtJdROCAM2kXD2mXg
	8P9g2A==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43k2vngpna-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Dec 2024 09:52:53 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BH9qq6x022317
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Dec 2024 09:52:52 GMT
Received: from hu-rdevanat-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 17 Dec 2024 01:52:50 -0800
From: Roopni Devanathan <quic_rdevanat@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Roopni Devanathan
	<quic_rdevanat@quicinc.com>
Subject: [PATCH 4/6] wifi: ath12k: Add API to print s8 arrays in HTT stats
Date: Tue, 17 Dec 2024 15:22:14 +0530
Message-ID: <20241217095216.1543923-5-quic_rdevanat@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241217095216.1543923-1-quic_rdevanat@quicinc.com>
References: <20241217095216.1543923-1-quic_rdevanat@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: YbGdGBm8JORZj6uMhhXuBhLZ4o3s5XGy
X-Proofpoint-ORIG-GUID: YbGdGBm8JORZj6uMhhXuBhLZ4o3s5XGy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 mlxlogscore=763 impostorscore=0 mlxscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412170081

Currently, print_array_to_buf() is used to print arrays to HTT
stats buffer. This API supports printing only arrays with 32-bit
unsigned integers. Add API print_array_to_buf_s8(), which
implements print_array_to_buf()'s functionality to all the
arrays with 8-bit signed integers.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4

Signed-off-by: Roopni Devanathan <quic_rdevanat@quicinc.com>
---
 .../wireless/ath/ath12k/debugfs_htt_stats.c   | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
index 4569ff40e9d8..621676daf971 100644
--- a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
+++ b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
@@ -48,6 +48,34 @@ print_array_to_buf(u8 *buf, u32 offset, const char *header,
 					footer);
 }
 
+static u32
+print_array_to_buf_s8(u8 *buf, u32 offset, const char *header, u32 stats_index,
+		      const s8 *array, u32 array_len, const char *footer)
+{
+	int index = 0;
+	u8 i;
+
+	if (header) {
+		index += scnprintf(buf + offset,
+				   ATH12K_HTT_STATS_BUF_SIZE - offset,
+				   "%s = ", header);
+	}
+	for (i = 0; i < array_len; i++) {
+		index += scnprintf(buf + offset + index,
+				   (ATH12K_HTT_STATS_BUF_SIZE - offset) - index,
+				   " %u:%d,", stats_index++, array[i]);
+	}
+	index--;
+	*(buf + offset + index) = '\0';
+
+	if (footer) {
+		index += scnprintf(buf + offset + index,
+				   (ATH12K_HTT_STATS_BUF_SIZE - offset) - index,
+				   "%s", footer);
+	}
+	return index;
+}
+
 static const char *ath12k_htt_ax_tx_rx_ru_size_to_str(u8 ru_size)
 {
 	switch (ru_size) {
-- 
2.25.1


