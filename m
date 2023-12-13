Return-Path: <linux-wireless+bounces-749-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C04811A7A
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Dec 2023 18:07:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15EFF1C20878
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Dec 2023 17:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D43153E27;
	Wed, 13 Dec 2023 17:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="QNHU137F"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84F45D5;
	Wed, 13 Dec 2023 09:07:22 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BDEProJ014122;
	Wed, 13 Dec 2023 17:06:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=PVs569z7GQ+S0q9ENe/rbTBDIe3xisffzxkzom1tBbY
	=; b=QNHU137FI02cDbUWlPk1y02EeZTgAKdSaZiAsDu9OnljTtfzcyPIRo8u71c
	L/7Qq37bKOgAreuHi7SSAibiUPh+/erVlpIk7aRSbqhlmZjcP9i15jsz+xPfGj91
	FCgNAAz25Pne+owZy0drynCwcDoIbo/QDe0NJohwRAOQ/TSvS/+evvJXbFLAnnWn
	mZBUCI3DKHvB1HAP1KQGLpEPck4SVhXqb+ga8MsIMKuVBDBq3ro+miUiMctWg3Zf
	KgytTzhNBPAmbO0miFvkmVLUtbdfv63TtIduBT+5u2DC+Xo2H+VY1l24jo159UFT
	zLnz6PLkrEhS8+I0GfiyqdEbmbA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uyec5rdh1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Dec 2023 17:06:41 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BDH6f7u031584
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Dec 2023 17:06:41 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 13 Dec
 2023 09:06:40 -0800
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Wed, 13 Dec 2023 09:06:39 -0800
Subject: [PATCH 1/6] wifi: ath10k: use flexible array in struct
 wmi_host_mem_chunks
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20231213-wmi_host_mem_chunks_flexarray-v1-1-92922d92fa2c@quicinc.com>
References: <20231213-wmi_host_mem_chunks_flexarray-v1-0-92922d92fa2c@quicinc.com>
In-Reply-To: <20231213-wmi_host_mem_chunks_flexarray-v1-0-92922d92fa2c@quicinc.com>
To: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <quic_jjohnson@quicinc.com>
CC: Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva"
	<gustavo@embeddedor.com>,
        <ath10k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
X-Mailer: b4 0.12.3
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: YXQsauI6ShGcqDV2UZSF2RjNJnKJTJlJ
X-Proofpoint-GUID: YXQsauI6ShGcqDV2UZSF2RjNJnKJTJlJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 suspectscore=0
 mlxlogscore=894 impostorscore=0 adultscore=0 phishscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312130122

Currently struct wmi_host_mem_chunks defines:
	struct host_memory_chunk items[1];

Per the guidance in [1] this should be a flexible array. However there
is a documented requirement:
	some fw revisions require at least 1 chunk regardless of count

To satisfy this requirement, follow the guidance from [2] and wrap the
array in a union which contains both the flexible array and a single
instance of the underlying struct. Since the footprint of the struct
is unchanged, no additional driver changes are required.

No functional changes, compile tested only.

[1] https://docs.kernel.org/process/deprecated.html#zero-length-and-one-element-arrays
[2] https://lore.kernel.org/linux-wireless/202308301529.AC90A9EF98@keescook/

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/net/wireless/ath/ath10k/wmi.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath10k/wmi.h b/drivers/net/wireless/ath/ath10k/wmi.h
index 9146df98fcee..833ce0251a2c 100644
--- a/drivers/net/wireless/ath/ath10k/wmi.h
+++ b/drivers/net/wireless/ath/ath10k/wmi.h
@@ -3069,7 +3069,10 @@ struct host_memory_chunk {
 struct wmi_host_mem_chunks {
 	__le32 count;
 	/* some fw revisions require at least 1 chunk regardless of count */
-	struct host_memory_chunk items[1];
+	union {
+		struct host_memory_chunk item;
+		DECLARE_FLEX_ARRAY(struct host_memory_chunk, items);
+	};
 } __packed;
 
 struct wmi_init_cmd {

-- 
2.42.0


