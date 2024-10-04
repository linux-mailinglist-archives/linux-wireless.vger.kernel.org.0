Return-Path: <linux-wireless+bounces-13494-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E3BA98FF28
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Oct 2024 10:59:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 350821F21FFF
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Oct 2024 08:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9203013D2BE;
	Fri,  4 Oct 2024 08:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="lfPIP5wF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8CF136345
	for <linux-wireless@vger.kernel.org>; Fri,  4 Oct 2024 08:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728032378; cv=none; b=QuTiTfET0s+PfDK+Q9/jLyAIctJFKupEeKLkpnYCkvu6Sf/VAHpWpLebPmqmK4vs9Ro+wDQDX8L9AYfVBrl/52GnLOcMdEnDDfGssl04rjmzj5dUV6jJfKqE7670Wlxj91rHA4VB6HHnE4JNzHa3rZqxxjUy1BKsElD2WjX37JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728032378; c=relaxed/simple;
	bh=WfWho1qWVuPyzmdyxkoLLNbum/OF3ZWcYZuRNU7YgU0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HxaYSg6jMNlfxuSdnNOX7bq/lIQ7z9dEHF9iV1fz/zKzRXtVxJCBeHqywWAomvVRjvbZRHEhy/cQfQJM1dd49E0gLtHjciYPrjJckiMBpQCf47tvu/YN4+eSiIhFjorzJ1aPbkhDiJYyqthx4oNHKvNYep8N7LMI+GP5X8CdVeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=lfPIP5wF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 493I02sM025933;
	Fri, 4 Oct 2024 08:59:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=mApHoNudVFaAphI8voke7E
	EkvC5/0ZzYJu85IhqZRV8=; b=lfPIP5wFa+E0YMKMxHlewsrwOKFBPai6jlgOZb
	plltCEl6oUXVg/TGRmy2X+/eLdWg8wug3YEphwefEl3iLKvtrFgCDhLK1aFjfquF
	HIFS5SEPM9RrmjLF8PoOsidUdECM9j+qd2YIHwVK1/G0ukR2nsxY0u+xoWswunw5
	m7VaAq2Z7iqTXkvlx8Do8T7wMTkK0+OYEylygDTpcyNxsbhXkBeBnztpsQz1Db1L
	1b8mSEhs60czYqFoeOvxYOkEk4eXJcrSoX6Dtc2HB53vw3U5bEtYx/l0fioNmScW
	AmR9jYtfCU+lQ0nZGB8+Y3HRbek9mnZNiVMMbruEK7Mr+8cA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42205khjb5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Oct 2024 08:59:34 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4948xXDB017262
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 4 Oct 2024 08:59:33 GMT
Received: from hu-rdevanat-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 4 Oct 2024 01:59:31 -0700
From: Roopni Devanathan <quic_rdevanat@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Roopni Devanathan
	<quic_rdevanat@quicinc.com>
Subject: [PATCH v2] wifi: ath12k: Modify print_array_to_buf() to support arrays with 1-based semantics
Date: Fri, 4 Oct 2024 14:29:15 +0530
Message-ID: <20241004085915.1788951-1-quic_rdevanat@quicinc.com>
X-Mailer: git-send-email 2.34.1
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
X-Proofpoint-ORIG-GUID: 7GJ8PisdgOLiNW3QZQoERCwgtpOQ4C8N
X-Proofpoint-GUID: 7GJ8PisdgOLiNW3QZQoERCwgtpOQ4C8N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 adultscore=0 lowpriorityscore=0 mlxscore=0 priorityscore=1501 phishscore=0
 bulkscore=0 impostorscore=0 malwarescore=0 suspectscore=0 mlxlogscore=957
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410040065

The API print_array_to_buf() currently supports printing
arrays with 0 indexing. In some cases, a few arrays need
to be printed with 1-based indexing, i.e., array should be
printed, starting with 1.

Add a new version of print_array_to_buf(), named
print_array_to_buf_index(), which implements the functionality
of print_array_to_index(), but with an extra variable, pointing
to the index starting with which the array should be printed.
Modify print_array_to_buf() to call
print_array_to_buf_index() with 0 as the starting index.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Signed-off-by: Roopni Devanathan <quic_rdevanat@quicinc.com>
---
 .../net/wireless/ath/ath12k/debugfs_htt_stats.c    | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
index f1b7e74aefe4..ec7add76ec85 100644
--- a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
+++ b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
@@ -12,8 +12,8 @@
 #include "dp_rx.h"
 
 static u32
-print_array_to_buf(u8 *buf, u32 offset, const char *header,
-		   const __le32 *array, u32 array_len, const char *footer)
+print_array_to_buf_index(u8 *buf, u32 offset, const char *header, u32 stats_index,
+			 const __le32 *array, u32 array_len, const char *footer)
 {
 	int index = 0;
 	u8 i;
@@ -26,7 +26,7 @@ print_array_to_buf(u8 *buf, u32 offset, const char *header,
 	for (i = 0; i < array_len; i++) {
 		index += scnprintf(buf + offset + index,
 				   (ATH12K_HTT_STATS_BUF_SIZE - offset) - index,
-				   " %u:%u,", i, le32_to_cpu(array[i]));
+				   " %u:%u,", stats_index++, le32_to_cpu(array[i]));
 	}
 	/* To overwrite the last trailing comma */
 	index--;
@@ -40,6 +40,14 @@ print_array_to_buf(u8 *buf, u32 offset, const char *header,
 	return index;
 }
 
+static u32
+print_array_to_buf(u8 *buf, u32 offset, const char *header,
+		   const __le32 *array, u32 array_len, const char *footer)
+{
+	return print_array_to_buf_index(buf, offset, header, 0, array, array_len,
+					footer);
+}
+
 static void
 htt_print_tx_pdev_stats_cmn_tlv(const void *tag_buf, u16 tag_len,
 				struct debug_htt_stats_req *stats_req)

base-commit: 8ed36fe71fd60c851540839b105fd1fddc870c61
-- 
2.25.1


