Return-Path: <linux-wireless+bounces-20568-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5972BA693B1
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Mar 2025 16:38:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81A94176DFA
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Mar 2025 15:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 233741D61A5;
	Wed, 19 Mar 2025 15:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mIYwz1HN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D821C9EAA
	for <linux-wireless@vger.kernel.org>; Wed, 19 Mar 2025 15:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742398574; cv=none; b=g86S2+pfW9fcFTQuu3NZaKfXG0ZWoCf8KZUJqWZMJRx/MB9WCfliS8f7A7GcDaf3DrBP9NsrZRFg2TMzWQ55vzO+ipDwK/EoUYJ9zWPB97h7IzKMR0QStml9LqTlTuQ/OsjUM2gDndzNwuVL3E+7EY3BbLy7UsI/Z/MNEWdNF+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742398574; c=relaxed/simple;
	bh=RG5b4hcycInrOdoORwEpXnephZP9+RHsiEXEZ4OhRAk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jRhkElIrPKsmCNQiD7Fn/FDtmXPUWRcfSCFw+H+NQfU0A3wVIhELRvj7Az4jYYoNuibsB9uLMmRICDQTjpfIBhYG4sESxxIbu/zPzmJtvVmHHDGFXIqmXyfCipgQsUdSNoWX7iQgZ/JF4uqA38uYXCM6v5zuyUidHAhXotXvrJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=mIYwz1HN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52JE0G3H026883;
	Wed, 19 Mar 2025 15:36:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=IbJUqCrOtTE1H52rHCAR+x
	OMv5pxdfwFfKPA7tA/bOI=; b=mIYwz1HNXxIIvERGzWGPy2SMP89FJBif595oGE
	j5MzPtUEX19xlWGyhoW+eKA7TfalfhWH7bR/1KTo2JUC/NYHmvI1TQpREVZbgskw
	UjDbyVcT/9OYqon169uJ2bopd0+YBJUbbbiUUt2DGv7k4JwPcsDM1tYA+kB5o/qy
	koAhE1Bmh5OEgdKqxE77C4bRXTxM4l/xzwTacbyywBTGt0filUO/w1crh2DUyoCU
	whI8dOio5AcCtciRWxmwqcn7Y45Uxm/OtBOUgsRyXf+0XONBo6U1yh0VjgUQix3F
	NfzGglgl76ZWONOEUQGCHIGxiUMBnCJcNpzywPZy2TbpKLdw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45f91t41km-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Mar 2025 15:36:05 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52JFa5KW000643
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Mar 2025 15:36:05 GMT
Received: from hu-rdevanat-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 19 Mar 2025 08:36:03 -0700
From: Roopni Devanathan <quic_rdevanat@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Pradeep Kumar Chitrapu
	<quic_pradeepc@quicinc.com>,
        Roopni Devanathan <quic_rdevanat@quicinc.com>
Subject: [PATCH ath-next v2] wifi: ath12k: Fix incorrect rates sent to firmware
Date: Wed, 19 Mar 2025 21:05:47 +0530
Message-ID: <20250319153547.771843-1-quic_rdevanat@quicinc.com>
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
X-Proofpoint-GUID: JYr85vcb3L0QA-8pA6KlN2MMfI0dXyDT
X-Authority-Analysis: v=2.4 cv=Xrz6OUF9 c=1 sm=1 tr=0 ts=67dae465 cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=Vs1iUdzkB0EA:10 a=COk6AnOGAAAA:8 a=z6_oMQ1SobYYos8x1-0A:9 a=v6Fpk0e4ntcIGe5OSANj:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: JYr85vcb3L0QA-8pA6KlN2MMfI0dXyDT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-19_06,2025-03-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 impostorscore=0 mlxlogscore=999 clxscore=1015 mlxscore=0
 priorityscore=1501 phishscore=0 suspectscore=0 adultscore=0 spamscore=0
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503190105

From: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>

Before firmware assert, if there is a station interface in the device
which is not associated with an AP, the basic rates are set to zero.
Following this, during firmware recovery, when basic rates are zero,
ath12k driver is sending invalid rate codes, which are negative values,
to firmware. This results in firmware assert.

Fix this by checking if rate codes are valid, before sending them
to the firmware.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1

Signed-off-by: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
Signed-off-by: Roopni Devanathan <quic_rdevanat@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 9fda97667d4e..661167acaa69 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -3450,7 +3450,9 @@ static void ath12k_recalculate_mgmt_rate(struct ath12k *ar,
 	}
 
 	sband = hw->wiphy->bands[def->chan->band];
-	basic_rate_idx = ffs(bss_conf->basic_rates) - 1;
+	basic_rate_idx = __ffs(bss_conf->basic_rates);
+	if (basic_rate_idx)
+		basic_rate_idx -= 1;
 	bitrate = sband->bitrates[basic_rate_idx].bitrate;
 
 	hw_rate_code = ath12k_mac_get_rate_hw_value(bitrate);
@@ -3983,10 +3985,13 @@ static void ath12k_mac_bss_info_changed(struct ath12k *ar,
 		band = def.chan->band;
 		mcast_rate = info->mcast_rate[band];
 
-		if (mcast_rate > 0)
+		if (mcast_rate > 0) {
 			rateidx = mcast_rate - 1;
-		else
-			rateidx = ffs(info->basic_rates) - 1;
+		} else {
+			rateidx = __ffs(info->basic_rates);
+			if (rateidx)
+				rateidx -= 1;
+		}
 
 		if (ar->pdev->cap.supported_bands & WMI_HOST_WLAN_5G_CAP)
 			rateidx += ATH12K_MAC_FIRST_OFDM_RATE_IDX;

base-commit: b6f473c96421b8b451a8df8ccb620bcd71d4b3f4
-- 
2.34.1


