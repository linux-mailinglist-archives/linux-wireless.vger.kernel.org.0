Return-Path: <linux-wireless+bounces-7630-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC968C4C5C
	for <lists+linux-wireless@lfdr.de>; Tue, 14 May 2024 08:34:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 080DAB20E6A
	for <lists+linux-wireless@lfdr.de>; Tue, 14 May 2024 06:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD7B0E541;
	Tue, 14 May 2024 06:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="cryRYZMX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C2910949
	for <linux-wireless@vger.kernel.org>; Tue, 14 May 2024 06:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715668486; cv=none; b=Q1kRJ9akV0/caLv6eo22ikjMqHEm07KYbUMLKJwzkwAMVHkibjvKrApsT/FCwHoOc17RT0eA8KhNubHndsLCK7qU8GrKPnvqdbrZPvSVpe6kXy+vy2s3KtO+M1sWsMrIcLWasmZwAPXUP+noR/9de+uygLTzNxw01nTTnU3SAR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715668486; c=relaxed/simple;
	bh=frZirzl7UpGIWUZBCcSfpoJEXbTos91PcH8qpjFC50o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IVJas/V0UR+wwT8iuVaCQ9FybZiXM+ISlZO35wjFFXN/xVLdzp42LojULIFxvn+JhUOzPaF4UyMxthYT5rZKkJ2cpfWQe2qux3KxRrQ2GBFPLS7y+nW5E2Qk0Vx6C3lbr9OXqm0SGnejg7GLsABFaxcImZE/Xx0F6D07bG4oweE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=cryRYZMX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44DJ9wuL005298;
	Tue, 14 May 2024 06:34:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=JD08dljXpGdNnYSrWwShIFk5TxQguWFPrERl/lM4j9A=; b=cr
	yRYZMX+SyD0NOeGBcUSa/glF5jLZFKh5DdJnwn+MPpnAcxvLwznEANxdeRyLH9S8
	3gA2s4/OCpOePLUKIshrnAF2xDqzCPlJq3/e1O+VxI2WRzm/TiId5dnrTdHDH59R
	zamjccWf21uJilXyvaOYiaKQ1l/7LcuuIdYPXN1q6L/NMJtDQleiMyYq7a5CkyjE
	qgKZdQM7hd7bNO63V6RVNsnCanyNbywP1oNurk8+ql9ZrB5/1XhAjvvreMOrYeue
	hbT1RMLaaGcdEIFutEXxGQZsTVMujAf1ngTbE+1HYGbVd/3O4aYKOVbvZxNXzD/S
	yp6rYE6456IDM8bTRceQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y21uhdamd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 May 2024 06:34:39 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44E6Yd2Y013651
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 May 2024 06:34:39 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 13 May 2024 23:34:37 -0700
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
Subject: [PATCH v2 2/2] wifi: ath12k: use correct MAX_RADIOS
Date: Tue, 14 May 2024 12:04:12 +0530
Message-ID: <20240514063412.3483723-3-quic_periyasa@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240514063412.3483723-1-quic_periyasa@quicinc.com>
References: <20240514063412.3483723-1-quic_periyasa@quicinc.com>
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
X-Proofpoint-ORIG-GUID: J09dl7X07-yF5lioKL81uTqNL6GZQlzS
X-Proofpoint-GUID: J09dl7X07-yF5lioKL81uTqNL6GZQlzS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-14_02,2024-05-10_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 spamscore=0 mlxlogscore=999 impostorscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405140044

The current value of the MAX_RADIOS definition is 3. This is incorrect
because no device supports more than 2 radios.

An incorrect MAX_RADIOS value can lead to:
 - unnecessary memory allocation for pdev related entities.
 - invalid pdev id validation.
 - Misconceptions for code readers.

Therefore, modify the MAX_RADIOS definition as 2.

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


