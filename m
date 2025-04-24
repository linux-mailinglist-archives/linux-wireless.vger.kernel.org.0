Return-Path: <linux-wireless+bounces-21952-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B9EA9A0A3
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Apr 2025 07:51:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C5657A1EA2
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Apr 2025 05:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3E5B3FE7;
	Thu, 24 Apr 2025 05:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Y8TbQjVV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382F82701B8
	for <linux-wireless@vger.kernel.org>; Thu, 24 Apr 2025 05:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745473890; cv=none; b=g6DlfC8v9ytG1nRgK9zRaEqHdcuo1MCgJBsmxaDuepJCQwbwjSes8VyXd8ulhxVtDSFr5kQydzMjT/DzZ0LmTmDHoLpAFn+tSIIS0MfR3exIigTMijYE8uhCVUXBLsaL11Fz5NcOIfbRYFgQvoqG7qvkNLEuPRjB9+6uEsrTNS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745473890; c=relaxed/simple;
	bh=5TJBFSlLRCTYGzTPj0Mre1gf/FWb+nE5UKCkcZCuins=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=k4lGeyA0P50Q7hZcYyinGQajNboOj7LYycjjYFzzvmnhVlharnQfG+VSlQqF57wGA+21vNDyedMVnWYI4tlNtWB1B5vJG3dYYU1g1OBOlKFBjLhU5NaYB19BQ5i3gK2th+2SjoC4vtsOFp91Ulu4cv0pWSVYLGOnJu1lGi+jYHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Y8TbQjVV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53O0F7FM010071;
	Thu, 24 Apr 2025 05:51:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=p0hqLDU/BqROalaZlrochM
	ujk91gL2X1X5u9oWdHQSw=; b=Y8TbQjVVgmc6+72/c9nAGxohTBEX1wf0Dst6WE
	7qURksxpAX5WZZgOsWBW8qpA5XsUAgxYN7647fAPOrcskqng5RpO9jUdqcebqFDB
	6AAShiu8fwa0fHm4XweG0ta2YePKSPlLtzc6bKdpTfaEP576q1QSRNAbVu6vb1hj
	gEhO5Ic2nUsU9oealgeJqCO1tU29BJ2ZWDgNPkysSvS3FTCDdkxPhvqK5wIPjvJI
	J1+B48jISmvzxS8xWmBYhduMgKL2k9kduXbRni8uZZCW1dTqU6i9Rx9dqBCa2u0B
	nGtfQLVbk/MkOgQ9EuvXs0JcWPlmn2vJFtb82eCNnYDgpR4Q==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 466jh0cdb4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Apr 2025 05:51:25 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53O5pPRb003708
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Apr 2025 05:51:25 GMT
Received: from hu-svardhin-blr.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 23 Apr 2025 22:51:23 -0700
From: Sowjanya vardhineni <quic_svardhin@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        P Praneesh
	<praneesh.p@oss.qualcomm.com>,
        Sowjanya vardhineni
	<quic_svardhin@quicinc.com>
Subject: [PATCH ath-next] wifi: ath12k: Fix invalid RSSI values in station dump
Date: Thu, 24 Apr 2025 11:21:04 +0530
Message-ID: <20250424055104.2503723-1-quic_svardhin@quicinc.com>
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
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Ia268lT2qeS5Qjg3CPqyRbnxacm5RcoC
X-Proofpoint-ORIG-GUID: Ia268lT2qeS5Qjg3CPqyRbnxacm5RcoC
X-Authority-Analysis: v=2.4 cv=Fv0F/3rq c=1 sm=1 tr=0 ts=6809d15d cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=1SAiWIxsnNecYTMwat8A:9
 a=+jEqtf1s3R9VXZ0wqowq2kgwd+I=:19 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI0MDAzNSBTYWx0ZWRfX104Z2oHxr7PH eg0DK75UilpWuKjL2j0+9MzNEKvogSTcke6ObAvFND4P3DaM6E5/v0sr5To9d7Hx4JFD7NPk1/d 838h7iyItoNiOWbHs44q9z7JvmhV7Z3Xbbkb0x+EEmZLkQl8sAcN9pSVqwsWULcLU3UBQTlliD1
 7rLh9ZHJIxF69qUmFR9Mq+zjnfyFCc3l3DCQDKDx2RPGoVQlP8Fp8AFpUJ4QyqhGRJ2+MXyX7h4 gD6kGBLCpu0Pp/XoC1m8Xty+Bw8exagz+/czucTDtEPZDTvCpiSZSRIetE6CnZnbIa1gNgOgfB+ sDZMLcCX/1XYPu1TMDJhhM3/lfH8V4pgNCSBD0HHri5Onb03UDrYTJeQq9GajN3sYAhQ+CwLyA/
 kYfcDwQxKPACvkIaU7vVoZ5ietj0r+EcvPap+JCcJaY0D7IA2nlWptCcUKj7rse3Fdl0IicY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.80.40
 definitions=2025-04-24_02,2025-04-22_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=788 priorityscore=1501 suspectscore=0
 adultscore=0 bulkscore=0 clxscore=1011 spamscore=0 lowpriorityscore=0
 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504240035

From: P Praneesh <praneesh.p@oss.qualcomm.com>

When processing a "station dump" command, the driver retrieves RSSI
values from the HAL_PHYRX_RSSI_LEGACY TLV received from the monitor
destination ring, and reports them to userspace. Currently, the RSSI
values reported are improper because the hardware has not been
configured to update them properly.

To fix this, enable the HTT_RX_FILTER_TLV_FLAGS_PPDU_START_USER_INFO in
the filter setup to ensure the correct RSSI values are returned in the
HAL_PHYRX_RSSI_LEGACY TLV, resulting in correct RSSI values being
reported to userspace.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00218-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
Signed-off-by: P Praneesh <praneesh.p@oss.qualcomm.com>
Signed-off-by: Sowjanya vardhineni <quic_svardhin@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index b19e30d95560..fa952f6ca4a3 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -229,7 +229,8 @@ ath12k_phymodes[NUM_NL80211_BANDS][ATH12K_CHAN_WIDTH_NUM] = {
 const struct htt_rx_ring_tlv_filter ath12k_mac_mon_status_filter_default = {
 	.rx_filter = HTT_RX_FILTER_TLV_FLAGS_MPDU_START |
 		     HTT_RX_FILTER_TLV_FLAGS_PPDU_END |
-		     HTT_RX_FILTER_TLV_FLAGS_PPDU_END_STATUS_DONE,
+		     HTT_RX_FILTER_TLV_FLAGS_PPDU_END_STATUS_DONE |
+		     HTT_RX_FILTER_TLV_FLAGS_PPDU_START_USER_INFO,
 	.pkt_filter_flags0 = HTT_RX_FP_MGMT_FILTER_FLAGS0,
 	.pkt_filter_flags1 = HTT_RX_FP_MGMT_FILTER_FLAGS1,
 	.pkt_filter_flags2 = HTT_RX_FP_CTRL_FILTER_FLASG2,

base-commit: 12b93f7c6d101d22e0ea3bf4a240699746c79117
-- 
2.34.1


