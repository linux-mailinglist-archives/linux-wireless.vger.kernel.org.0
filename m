Return-Path: <linux-wireless+bounces-4774-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A56EB87C467
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Mar 2024 21:47:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43CA31F21B1B
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Mar 2024 20:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFDE374E21;
	Thu, 14 Mar 2024 20:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="hbN5Jayv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608EC2A1C7
	for <linux-wireless@vger.kernel.org>; Thu, 14 Mar 2024 20:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710449229; cv=none; b=MVl6c9SEmWBXWH2nb4kCaqUVaV1DTrlQ0pTHy+auI4sNn7l3m+/YTrijo7ORauEs3vg6uB5ONZpPOuAAeQjlb5EFoGEGeFM14fZOCKT38kwR6MM+yTD5rE7A+Cr5xL7ZA7KmaKqK3WeGes2BTn3RD0iEZzUDWTxq0624YeVUKPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710449229; c=relaxed/simple;
	bh=Tp1fVA3sFmtR1JIL8+mC5TfRTixUYOmXYlkrJl00F8c=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GOePKGNac8C4J7XU0Bbl3Yv2wf4BP6YCaSlziLXikgxLfnFDK3JEbUxq4DyGugjJbusWkKiQED8jEWJkQwK8pB9mU5EuoStn9sixX5rcfj726Nbbf4FEHx6zJiSnxHwDkoBvLdJHgk6tuqJ/qCtNn4t5V9rkz5SM9XInGfuPEfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=hbN5Jayv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42EKbxi6026706;
	Thu, 14 Mar 2024 20:47:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=J11yLVa
	nw9AsT+IdmoZD3RXT5E5BVJ3Hl9qF1D1DjJ0=; b=hbN5JayvtXn15u3K+4eqXqi
	AsFuGMkq+egsEc8UHcQvfLXXqaAwmjQAZUPqTAV/Z3JDBwV5izjuBGOUe+FtrOH7
	wy7/sk9BbXgapM/orOxDWmACo5NFJidJDXl5/ZQXaWC5k1s+dSI6sbroAkmnicEU
	BdVNPApD5IvW6hMtUgoeGItCWYROtjZBxHmcfUBC50H2d+kC6IOLpb+XVSpbQ0nA
	2Xp2x7hTkBCueFeeY3+74fSmTPDIs5QUJEX9C4lLu611SX1ob4dN2hfrXaxqHYbo
	mcIEPURLl+zP6aFvidzkQPv5feWnBkld8WuHhyhtTfUuYjjjsMYEzWP0JyhjNiQ=
	=
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wv0kjs5en-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Mar 2024 20:47:04 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42EKl4pI026934
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Mar 2024 20:47:04 GMT
Received: from alokad-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 14 Mar 2024 13:47:03 -0700
From: Aloka Dixit <quic_alokad@quicinc.com>
To: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
CC: Aloka Dixit <quic_alokad@quicinc.com>
Subject: [PATCH] wifi: ath12k: use correct flag field for 320 MHz
Date: Thu, 14 Mar 2024 13:46:51 -0700
Message-ID: <20240314204651.11075-1-quic_alokad@quicinc.com>
X-Mailer: git-send-email 2.39.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: FcPtWVSrntODpv_PTbW5ea83fn_FbPiE
X-Proofpoint-ORIG-GUID: FcPtWVSrntODpv_PTbW5ea83fn_FbPiE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-14_13,2024-03-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 mlxscore=0 spamscore=0 bulkscore=0 impostorscore=0
 phishscore=0 mlxlogscore=818 malwarescore=0 priorityscore=1501
 suspectscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2402120000 definitions=main-2403140160

WMI_PEER_EXT_320MHZ (0x2) is defined as an extended flag, replace
peer_flags by peer_flags_ext while sending peer data.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Fixes: 6734cf9b4cc7 ("wifi: ath12k: peer assoc for 320 MHz")
Signed-off-by: Aloka Dixit <quic_alokad@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/wmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index 9d69a1769926..34de3d16efc0 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -1900,7 +1900,7 @@ static void ath12k_wmi_copy_peer_flags(struct wmi_peer_assoc_complete_cmd *cmd,
 		if (arg->bw_160)
 			cmd->peer_flags |= cpu_to_le32(WMI_PEER_160MHZ);
 		if (arg->bw_320)
-			cmd->peer_flags |= cpu_to_le32(WMI_PEER_EXT_320MHZ);
+			cmd->peer_flags_ext |= cpu_to_le32(WMI_PEER_EXT_320MHZ);
 
 		/* Typically if STBC is enabled for VHT it should be enabled
 		 * for HT as well

base-commit: a2a4cf3541db8066af7e6d4eb6e9e6445f6d9658
-- 
2.39.0


