Return-Path: <linux-wireless+bounces-16762-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 288A29FBC63
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Dec 2024 11:33:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28E2B16EA0D
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Dec 2024 10:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E81C218FDD8;
	Tue, 24 Dec 2024 10:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="LuTG9ujy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687691C3050
	for <linux-wireless@vger.kernel.org>; Tue, 24 Dec 2024 10:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735035649; cv=none; b=KGRDCjxQeCHpe0/9Mv4ucuMuTRBC6Nu0lqnY/oo2h+onoKdtPSwDiVUmoN0Xfn/DlXCwWWxH12DC0FEfURwhP9LCQp2qSxTSuVAEi3ZwJ9PtJCwKgGSSjyE2xJXQ2tzhatWruOpHr4fNre951XqOt35jFVLz5gVm2WhgdeuKRDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735035649; c=relaxed/simple;
	bh=y69vdJ8OGrXaZ2HLHKDVC1GPjgY6QUDVcbRm6tzzLbI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FJZJANEujKUb6AIu/52SeqmuG99coljEQeo0BCHEXj0gVqNwUiQdZwOiINNdvJdluoQGrpYbv5+sLtI8p96TgpJLRVtH74Y6QjDWmmTwrAJ2pUq/X/cFuR2s6qUFMP37YOzCefX9lnTcAuENjeo0qxlQ3lS+SyRNX0k4E9SKm+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=LuTG9ujy; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BO5lQ9n006721;
	Tue, 24 Dec 2024 10:20:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GBoEoPRzZCgn6Jh554hVeibLw5a/e9ohh6rolbzAQCQ=; b=LuTG9ujynvKQZnDG
	/xlpC50b4QVheFqdfc3ojtwZ3BoTmSsVCdwNCFatQC1snbldEi6Z9vL1i5OfQs1E
	ItL71iX0MnL9w8S8zmBSjabEiKG/oLr0/XmgBYKH6E7cvcERI+TmRUn/kcA1GeFd
	dkUdoF311RTzN2/EngdKbs5DxS4By5aLAXEg/FnLyhyaDpl+0bKpmoNKvdDB1d5t
	Cn+9dMiCcIcfH5dqwYz0UEqq5z7Sz/T8gW43rQODuBEkKw6dE0ouQcN7/fbbVMJQ
	GFp53OL+gnnIOdgiScJxgwNSdhMzWtsVpsGU6L1VOVr2wc6TYLQnaewILk+bUawB
	ZZe/qQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43qq4b1951-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Dec 2024 10:20:46 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BOAKkxe010604
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Dec 2024 10:20:46 GMT
Received: from hu-rdevanat-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 24 Dec 2024 02:20:44 -0800
From: Roopni Devanathan <quic_rdevanat@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Roopni Devanathan
	<quic_rdevanat@quicinc.com>
Subject: [PATCH v2 4/6] wifi: ath12k: Add API to print s8 arrays in HTT stats
Date: Tue, 24 Dec 2024 15:50:11 +0530
Message-ID: <20241224102013.1530055-5-quic_rdevanat@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241224102013.1530055-1-quic_rdevanat@quicinc.com>
References: <20241224102013.1530055-1-quic_rdevanat@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: LbC-F6Gnk-DdWDMiPctqMcsWrCaSdsqc
X-Proofpoint-GUID: LbC-F6Gnk-DdWDMiPctqMcsWrCaSdsqc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 phishscore=0 mlxscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 mlxlogscore=807
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412240087

Currently, print_array_to_buf() is used to print arrays to HTT
stats buffer. This function supports printing only arrays with
32-bit unsigned integers. Add print_array_to_buf_s8(), which
implements print_array_to_buf()'s functionality to all the
arrays with 8-bit signed integers.

Sample output:
rx_ul_mumimo_target_rssi: user_0  =  0:-128, 1:-128, 2:-128, 3:-128
rx_ul_mumimo_target_rssi: user_1  =  0:-128, 1:-128, 2:-128, 3:-128
rx_ul_mumimo_target_rssi: user_2  =  0:-128, 1:-128, 2:-128, 3:-128

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4

Signed-off-by: Roopni Devanathan <quic_rdevanat@quicinc.com>
---
 .../wireless/ath/ath12k/debugfs_htt_stats.c   | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
index 7ddf862d2007..37a78d6c8df8 100644
--- a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
+++ b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
@@ -48,6 +48,34 @@ print_array_to_buf(u8 *buf, u32 offset, const char *header,
 					footer);
 }
 
+static u32
+print_array_to_buf_s8(u8 *buf, u32 offset, const char *header, u32 stats_index,
+		      const s8 *array, u32 array_len, const char *footer)
+{
+	u32 buf_len = ATH12K_HTT_STATS_BUF_SIZE;
+	int index = 0;
+	u8 i;
+
+	if (header)
+		index += scnprintf(buf + offset, buf_len - offset, "%s = ", header);
+
+	for (i = 0; i < array_len; i++) {
+		index += scnprintf(buf + offset + index, (buf_len - offset) - index,
+				   " %u:%d,", stats_index++, array[i]);
+	}
+
+	index--;
+	if ((offset + index) < buf_len)
+		buf[offset + index] = '\0';
+
+	if (footer) {
+		index += scnprintf(buf + offset + index, (buf_len - offset) - index,
+				   "%s", footer);
+	}
+
+	return index;
+}
+
 static const char *ath12k_htt_ax_tx_rx_ru_size_to_str(u8 ru_size)
 {
 	switch (ru_size) {
-- 
2.25.1


