Return-Path: <linux-wireless+bounces-7497-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7539B8C2E78
	for <lists+linux-wireless@lfdr.de>; Sat, 11 May 2024 03:37:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C13B283926
	for <lists+linux-wireless@lfdr.de>; Sat, 11 May 2024 01:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C36CDD2F0;
	Sat, 11 May 2024 01:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="m6omZQYd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4F1101D5
	for <linux-wireless@vger.kernel.org>; Sat, 11 May 2024 01:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715391428; cv=none; b=dXIfpBhIp7RA70J+X9wqY4xPZfy+FtGPbvxdHyA1a0DHs+NOOCJmEJPtJkDIc3CDNC61+6xAefg+o8TF9DBFSx0OOXvXTa+3NZ/sNWN/odiUC0fovLvj19FNmUvtunaogZZuR3Mjujj+Bh+sez1gMchMAff2kwgeMXjbBdYWIeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715391428; c=relaxed/simple;
	bh=dXHTSPWrtP6SuNT4S+HI2E0SfWTv8v6eTbVvWGxWuvU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e2RwssTPlSfyDCPgBi4oSVRtNVUPIDbwdc8JW+wbb2Ad+7jhLV4t+ARc5x8NUJjmQQJg8Yph8MeCycL9obXBiVnB9UBJUEULePg4Hh2X+2CB0ZJ/SmFUTzHzJPUCJ0uomyWy5D9deneolgyhTeTI1y9DUZPYflNFR0ivGrxeTNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=m6omZQYd; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44AE15dx009431;
	Sat, 11 May 2024 01:37:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=VDFn2CTwYPhigcYBfpqAw5WTtT7muA0SFFCOYK3kUhY=; b=m6
	omZQYdS8LRQ5hbTnWPWUcqg3sGXXXZn3IcVWkhVKiXC1QEWZEZs+tE0buw7A5OYG
	YALqYC4QJetvjHNMwnqLKHc1Uq6F/WibsjEP9uX40+/ouxasL1JUWMCBMSSZ1Xjm
	BQIBy/sq91E9EgbcFzpyK/RAl2VFqbjdyuOffPAnZHNHv06QVX1b2mjacWUoIF8x
	YbD9YVWT+xMgfBLyjewdhhbTA3bIFG4ZqYfJAnWBrGJ+wC6nCHzAioizqNPPzSi3
	ZMUda6yzA7Be0LeJJEyjgy3oBCMANPKn0cCQGKiNYhRzMcEP2ceXf3Xi1cIYLLZA
	zspzl8oBs32W7xI9x19A==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y16w2asps-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 11 May 2024 01:37:04 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44B1b3qT010687
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 11 May 2024 01:37:03 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 10 May 2024 18:37:01 -0700
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
Subject: [PATCH 2/2] wifi: ath12k: use correct MAX_RADIOS
Date: Sat, 11 May 2024 07:06:44 +0530
Message-ID: <20240511013644.3103905-3-quic_periyasa@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240511013644.3103905-1-quic_periyasa@quicinc.com>
References: <20240511013644.3103905-1-quic_periyasa@quicinc.com>
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
X-Proofpoint-GUID: SYq-ErkQtdXcLO2E9nwLTHXbU7Jgk52i
X-Proofpoint-ORIG-GUID: SYq-ErkQtdXcLO2E9nwLTHXbU7Jgk52i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-10_18,2024-05-10_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 impostorscore=0 priorityscore=1501 malwarescore=0 phishscore=0
 adultscore=0 suspectscore=0 spamscore=0 clxscore=1015 mlxlogscore=920
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405110010

The current value of the MAX_RADIOS define is 3. However, this value is
incorrect as the maximum number of radios supported by all devices does
not exceed 2. Therefore, the MAX_RADIOS define should be modified to 2.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/wmi.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
index 496866673aea..27bec3800bff 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -4770,7 +4770,7 @@ struct wmi_probe_tmpl_cmd {
 	__le32 buf_len;
 } __packed;
 
-#define MAX_RADIOS 3
+#define MAX_RADIOS 2
 
 #define WMI_SERVICE_READY_TIMEOUT_HZ (5 * HZ)
 #define WMI_SEND_TIMEOUT_HZ (3 * HZ)
-- 
2.34.1


