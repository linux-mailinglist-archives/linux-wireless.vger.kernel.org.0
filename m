Return-Path: <linux-wireless+bounces-21617-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6692BA9126A
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Apr 2025 06:57:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73E13441FC3
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Apr 2025 04:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D901DBB19;
	Thu, 17 Apr 2025 04:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="e1IZjLHj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7511A1A287E
	for <linux-wireless@vger.kernel.org>; Thu, 17 Apr 2025 04:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744865856; cv=none; b=lmX7J3/hRpgkS54nV/hOzWLARslmBmpHZOMX0wwkW6ZOhlxRkvsx5s5joVdhsqUppztM5y81SBNlKNln4TieSLlC7sfewrtaE/XyYJvKXWgNfld01Zr0fVpGRrl1zGw6n6QORDOXq2EeB6UCTxeGv1UgAYi8ry4U73yg1Gywv4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744865856; c=relaxed/simple;
	bh=WeD42rGgo3GJCdTpumKXwzpcd/3ZvNo5q4yyP2mzWZ0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OaBognlqByTbFkii/kn85ChyXXLWgv2v5AADbOKX/d1wqpHfE+kIbflvBkDfiCmiqbdwvMsP0Juh/aOBHNSTjxraH+rww9bKhVIgWODLui/zQijXEfD4IC/N9hmZqwoczXAlfb4XACzd+resSxz9oN2U3sggoTJbs5eOa5yDXCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=e1IZjLHj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53GMAoQT020755;
	Thu, 17 Apr 2025 04:57:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KP2qdl9EEZIc7isxL8BESvagtCuONIO4FtHV7HmtSQ4=; b=e1IZjLHjENMmj3py
	6WMVAzHTB7gQQ73RqhkZUryRG8ai5J4lQS6P7WdMH8KhpU/2djrWlt9dyBp1dtpc
	svfUWYdEm3BOOuH3g99pa6xSL2j3Wj4PuHrNUKqMwjwFKJubEd72E54BTgW72dAp
	u8fZkfskt1GYoQcgHCGyjRNGkHaM0pTztOiz2g/hM3sAuta/9Gz3uFlEW9jPfGa+
	FjCDinIqcaLgiVUam9Te0c8nzwqAn2GVM63Jc0lt1fTs29DVzN/jyehjwX9aZ54e
	WsQ7Eher6QVgUKE008TmWLROV2jGuFSj7eGh0RBx4acT7FLChO5uXElz890tSXpj
	224h6Q==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45yhbpwfrh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Apr 2025 04:57:31 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53H4vV9o029891
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Apr 2025 04:57:31 GMT
Received: from hu-sarishar-blr.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 16 Apr 2025 21:57:29 -0700
From: Sarika Sharma <quic_sarishar@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Sarika Sharma
	<quic_sarishar@quicinc.com>
Subject: [PATCH ath-next v5 1/6] wifi: ath12k: enable wiphy flag for MLO station statistics support
Date: Thu, 17 Apr 2025 10:27:04 +0530
Message-ID: <20250417045709.770219-2-quic_sarishar@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250417045709.770219-1-quic_sarishar@quicinc.com>
References: <20250417045709.770219-1-quic_sarishar@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: M93O-jU91VywRlPXh1_KDsfgKlbEHqIH
X-Proofpoint-GUID: M93O-jU91VywRlPXh1_KDsfgKlbEHqIH
X-Authority-Analysis: v=2.4 cv=I+plRMgg c=1 sm=1 tr=0 ts=68008a3b cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=aaRn59fMbiCMzwTV-5YA:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-17_01,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 phishscore=0 adultscore=0 priorityscore=1501 mlxscore=0 lowpriorityscore=0
 bulkscore=0 mlxlogscore=979 clxscore=1015 impostorscore=0 malwarescore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504170036

Set the WIPHY_FLAG_SUPPORTS_MLO_STA_PER_LINK_STATS flag during
hw_register() call to inform upper layer that the driver supports
the per-link station statistics.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1

Signed-off-by: Sarika Sharma <quic_sarishar@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index f09abe81cc77..10d4a2166915 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -11461,6 +11461,8 @@ static int ath12k_mac_hw_register(struct ath12k_hw *ah)
 	 */
 	wiphy->flags |= WIPHY_FLAG_DISABLE_WEXT;
 
+	wiphy->flags |= WIPHY_FLAG_SUPPORTS_MLO_STA_PER_LINK_STATS;
+
 	/* Copy over MLO related capabilities received from
 	 * WMI_SERVICE_READY_EXT2_EVENT if single_chip_mlo_supp is set.
 	 */
-- 
2.34.1


