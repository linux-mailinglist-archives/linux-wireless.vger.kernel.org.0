Return-Path: <linux-wireless+bounces-8959-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E8D390637B
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2024 07:36:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B15A3284852
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2024 05:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2029135A72;
	Thu, 13 Jun 2024 05:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="joTdBBJa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343911304BA
	for <linux-wireless@vger.kernel.org>; Thu, 13 Jun 2024 05:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718256957; cv=none; b=OTIyC2A28aan5SMD2+DMx1Otk26VjaDEhUrc2EnDLkRHV5jXV2gCqQ51wPbusQ3H0rbCVW6dPeY2RTahHj+Amyvbytmr2Nef5WrKpn5UlI9hzXlFQpLKpGlQNdpl3fnFuRqmcmiadNH01tBv2ncsDNtl8SZmmpPDqQvcx+zMiEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718256957; c=relaxed/simple;
	bh=dL8kPnoxMzCa//HP4ni33K0ZDgI8bV1AK0cN/wBWDdw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NG5hMz6Rfv8MyLdZhG8axLA6mh0gcGbS9+WyiZdexLjBzcerlkZpnL4L/BSlpsTi/NtFK194QAduPaYk63bYZMTsDOGupCW7vjuMAhsxV9LmiMYP1S+iBPy1bqzvXG0doyUt1oCnOZYJJXBsil8uC5kagqIi2JhdYu+BgHpfi30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=joTdBBJa; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45CKnjnQ018001;
	Thu, 13 Jun 2024 05:35:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=0ARywWXlr+hi/PMlESMsXt
	M7Cj6u2PTVthGubEjJkGw=; b=joTdBBJaSXHU2APyB19pZ0DqX7wOdiUfsejv83
	NMA/68RLMkdhccbXw98uXZvKOxO+DkxweTjwA5dhjbT3iyATF/okLnoGPGmbpoUt
	1ShUVdqvBAQ07H+LT25YKV5F36sIeqKsjmDAoDPp4YrVWRTJrpnGSzDDuCptrBiF
	gKFHyRnXQdTABSPKuIywSizWUP2fmj/d06F+PQgRGMSl9x/plSvXXwjHImqV4LgH
	I46TYH3P57m76KcsMlWYfDZiEWlFTDSYC3cP35t10/NJJq+2sWWEXj9KnbezUP+U
	A2OwRBwNwTyT1x7dqtY88XaJpkTfVGIpqDwhcD3YJTmHNfSg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yqe93hmap-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Jun 2024 05:35:49 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45D5Znc9015729
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Jun 2024 05:35:49 GMT
Received: from hu-ajithc-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 12 Jun 2024 22:35:47 -0700
From: Ajith C <quic_ajithc@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Ajith C <quic_ajithc@quicinc.com>
Subject: [PATCH] wifi: ath12k: fix firmware crash due to invalid peer nss
Date: Thu, 13 Jun 2024 11:05:28 +0530
Message-ID: <20240613053528.2541645-1-quic_ajithc@quicinc.com>
X-Mailer: git-send-email 2.34.1
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
X-Proofpoint-GUID: BfRG3V3qm2e-6iNOky76yamqxoOQRNU0
X-Proofpoint-ORIG-GUID: BfRG3V3qm2e-6iNOky76yamqxoOQRNU0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-12_12,2024-06-13_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999
 impostorscore=0 priorityscore=1501 mlxscore=0 bulkscore=0 adultscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406130037

Currently, if the access point receives an association
request containing an Extended HE Capabilities Information
Element with an invalid MCS-NSS, it triggers a firmware
crash.

This issue arises when EHT-PHY capabilities shows support
for a bandwidth and MCS-NSS set for that particular
bandwidth is filled by zeros and due to this, driver obtains
peer_nss as 0 and sending this value to firmware causes
crash.

Address this issue by implementing a validation step for
the peer_nss value before passing it to the firmware. If
the value is greater than zero, proceed with forwarding
it to the firmware. However, if the value is invalid,
reject the association request to prevent potential
firmware crashes.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Signed-off-by: Ajith C <quic_ajithc@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 784964ae03ec..198aa5a88a6e 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -4087,6 +4087,11 @@ static int ath12k_station_assoc(struct ath12k *ar,
 
 	ath12k_peer_assoc_prepare(ar, vif, sta, &peer_arg, reassoc);
 
+	if (peer_arg.peer_nss < 1) {
+		ath12k_warn(ar->ab,
+			    "invalid peer NSS %d\n", peer_arg.peer_nss);
+		return -EINVAL;
+	}
 	ret = ath12k_wmi_send_peer_assoc_cmd(ar, &peer_arg);
 	if (ret) {
 		ath12k_warn(ar->ab, "failed to run peer assoc for STA %pM vdev %i: %d\n",
-- 
2.25.1


