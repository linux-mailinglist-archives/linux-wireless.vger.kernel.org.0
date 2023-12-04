Return-Path: <linux-wireless+bounces-366-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 242EF802CE6
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Dec 2023 09:14:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC89BB20A52
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Dec 2023 08:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AEAA14007;
	Mon,  4 Dec 2023 08:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="V+OTzCVV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 235FABB
	for <linux-wireless@vger.kernel.org>; Mon,  4 Dec 2023 00:13:53 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B47P1XV023978;
	Mon, 4 Dec 2023 08:13:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=hZd0pokSC9R/TX4SnR08CG2FoNIhoKviEuvF1zuielI=;
 b=V+OTzCVVQ0vMFOhXgHXaTFtDL7gaNhZvCRu1JbCwsOGaaQf8amG5taOCfMvuiQKo51Kt
 fE1FnbZi8eNKELFccPkgbZI7xLzdkmrjbsWNJUTT1yNzPvqdXF2ujY1qTdA8TfhRauTj
 hJlWJp+Sk6RxTl4eqTgbu25mQ3V62GOeZsMvzEM9ez21ZhrGp3vRFAglp/7lDZnAvMBU
 K2hjsacw00xI8+L2s8JcnYtrxfubcJG8qZRP6xrY1X+cmRFHSQnh8MDsn6WMC+aizqqs
 y+elhlDLdKbd12AEYz1h7lW3KOthE9pYaezkrhp9Pn/IUrHA6bJCGWrU7/FIcnAbWci/ 9Q== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uqv673d1h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Dec 2023 08:13:49 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3B48Dm9Y026286
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 4 Dec 2023 08:13:49 GMT
Received: from bqiang-Celadon-RN.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 4 Dec 2023 00:13:47 -0800
From: Baochen Qiang <quic_bqiang@quicinc.com>
To: <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH v8 10/12] wifi: ath11k: add WMI_TLV_SERVICE_EXT_TPC_REG_SUPPORT service bit
Date: Mon, 4 Dec 2023 16:13:21 +0800
Message-ID: <20231204081323.5582-11-quic_bqiang@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231204081323.5582-1-quic_bqiang@quicinc.com>
References: <20231204081323.5582-1-quic_bqiang@quicinc.com>
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
X-Proofpoint-ORIG-GUID: 41PBm0e49B20fd-SqV7Pw4ryMqdPMxGZ
X-Proofpoint-GUID: 41PBm0e49B20fd-SqV7Pw4ryMqdPMxGZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-04_06,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 clxscore=1015 mlxscore=0 spamscore=0 suspectscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311060000 definitions=main-2312040061

From: Wen Gong <quic_wgong@quicinc.com>

Firmware advertises support for SERVICE_EXT_TPC_REG via a WMI service bit.
Add the definition of this service bit so that a subsequent patch can
check whether or not firmware supports this service.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.23

Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
---
v8:
 add s-o-b tag.
v7:
 no change.

 drivers/net/wireless/ath/ath11k/wmi.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/ath/ath11k/wmi.h b/drivers/net/wireless/ath/ath11k/wmi.h
index a9a7d81236cb..7e416e09aa5f 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.h
+++ b/drivers/net/wireless/ath/ath11k/wmi.h
@@ -2114,6 +2114,7 @@ enum wmi_tlv_service {
 	/* The second 128 bits */
 	WMI_MAX_EXT_SERVICE = 256,
 	WMI_TLV_SERVICE_SCAN_CONFIG_PER_CHANNEL = 265,
+	WMI_TLV_SERVICE_EXT_TPC_REG_SUPPORT = 280,
 	WMI_TLV_SERVICE_REG_CC_EXT_EVENT_SUPPORT = 281,
 	WMI_TLV_SERVICE_BIOS_SAR_SUPPORT = 326,
 	WMI_TLV_SERVICE_SUPPORT_11D_FOR_HOST_SCAN = 357,
-- 
2.25.1


