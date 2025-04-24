Return-Path: <linux-wireless+bounces-21943-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98942A99D7D
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Apr 2025 02:58:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF43E446DA3
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Apr 2025 00:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A530D77111;
	Thu, 24 Apr 2025 00:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="WqUUdGdc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E457C7081F;
	Thu, 24 Apr 2025 00:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745456269; cv=none; b=oc7UImNB3lNnZCSfKGDU7ZwSiKEPbn8TRZj5ul4V0MGjHGnnezTMJTaEk5lTb/fAMYd5/ksMdZmt7fY9Nv9yzAMWv9yAeXJBu/CxK8OI2tKE25YBVP3K3eAT29dN+YFNLmWcD6cFIq/34Pku0MIBg43mOd1+h+LqMzJZ514mEBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745456269; c=relaxed/simple;
	bh=dC37s6TQKS9T6iuB7Tn8mVP/Yop62O4eI6mP2j3P/Z8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MMraaajgGQqina3bQeA1e389BdrukoonClIgX7Jxde8u83kN07SP56KDsKFsQGO43sQc5GW1zLNHrPeNbzvog2bYwSczoHNP4phYb09pPmsK9UH12/5QPPiB3u1BnufoIIPynXdXQWBKS0CcudDdl1Mgc4j/8OZP7Wpmr6kAU4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=WqUUdGdc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53O0F6hK013152;
	Thu, 24 Apr 2025 00:57:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Wp29iO7wYDz/sKhKncYba5qpme5gs7HJpcHcrRQPRyk=; b=WqUUdGdc42lm1039
	26ESQJRl48VMfOqToABwasFhMLrj3dqG571F3ApI5A8m3bTFIdRNCLGAICbt0wtv
	LvsMDpFEWEaaW/o9WXXkpOZqZcoQTjV0yNH07aOnLgjZAjrf+RCr/RN6EWrjoTNr
	agrQeE1WL+adwiPWFcu9zvd02vCMZUDcKbCS8iOMSkOrf3fEmlFVgevyvZbB9ORv
	w4AnMgfUg4B1amcM/18+IZUUEcMwh+VtEphpmcVxauJaS0Df9pPT1cqgqkPJW7Hc
	SkdxdTGZxLPws8oQ7KwfTp2QcLigCzSb2/gwiggDBtUHnMikSt7DoIGrazVmuFHR
	jGPiJA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 466jh2btdf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Apr 2025 00:57:35 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53O0vY8f014734
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Apr 2025 00:57:34 GMT
Received: from localhost.localdomain (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 23 Apr 2025 17:57:31 -0700
From: Miaoqing Pan <quic_miaoqing@quicinc.com>
To: <jjohnson@kernel.org>, <johannes@sipsolutions.net>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Miaoqing Pan
	<quic_miaoqing@quicinc.com>
Subject: [RESEND ath-next 2/2] wifi: ath12k: support usercase-specific firmware overrides
Date: Thu, 24 Apr 2025 08:57:03 +0800
Message-ID: <20250424005703.2479907-3-quic_miaoqing@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250424005703.2479907-1-quic_miaoqing@quicinc.com>
References: <20250424005703.2479907-1-quic_miaoqing@quicinc.com>
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
X-Proofpoint-GUID: kI0on8iXxEyAT-aZ7ZfJGUab5pCYphRQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI0MDAwMiBTYWx0ZWRfX8y1kurDzB6ty mwentqpDO4bhZBSYgHMomrzZsY6LTmyamN//MqryeT1IDtdypUKCEZJ8JjFuA8TIqe5NvqldBq1 cSf5DUnnvttkYJj2cdbK2yNabnQTAd1Xb6CuCz8qWnLGuYKCUCCbRZSKzMO0Kk/6fdghTi8iaBN
 VKvD7QkgME+ziuileCugm2CKYxd8yFAGbFgv3pRzHH3bfTcBOWYfE0Oksd1MjHFV+nE1yq9HQqO RXcQiCcSofoBdLRyx424yBVZRylxhwr1qCYE4STYxcWAZFMaDp6FrXDaH9zziDty2DV07jewDLu Nktvap5KTFIpwXISKq6zX6xt86IxNtFwlmyexwcsyDKS//WTl3hFrtAshS2b0P7yX4vr06yIoJE
 yu2Oz0wHio35JK48Jmgim3UxAUELguIbD6NUqtYptXsTI+pbQQ/jeNsiWbvijGzQuNhUbPUw
X-Authority-Analysis: v=2.4 cv=Tu/mhCXh c=1 sm=1 tr=0 ts=68098c7f cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=jX1nYg6MY8bSXAgjlsoA:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: kI0on8iXxEyAT-aZ7ZfJGUab5pCYphRQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.80.40
 definitions=2025-04-24_01,2025-04-22_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 spamscore=0 clxscore=1011 lowpriorityscore=0
 impostorscore=0 adultscore=0 phishscore=0 mlxlogscore=865 bulkscore=0
 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504240002

Introduce 'firmware-name' property to allow end-users and/or integrators to
decide which usecase-specific firmware to run on the WCN7850 platform. This
is necessary due to resource limitations such as memory capacity and CPU
capability, or performance and power optimization for different application
scenarios.

Currently, there are two firmwares, both files can be executed
interchangeably.
For example:

- ath12k/WCN7850/hw2.0/amss.bin,
  ath12k/WCN7850/hw2.0/m3.bin
  ath12k/WCN7850/hw2.0/board-2.bin

- ath12k/WCN7850/hw2.0/ncm825/amss.bin,
  ath12k/WCN7850/hw2.0/ncm825/m3.bin
  ath12k/WCN7850/hw2.0/board-2.bin

The former is the default firmware, suitable for most WiFi 7 STA functions.
The latter adds support for commercial-quality SAP and optimizes power
consumption for IoT applications. And both use the same BDF/regdb data
within the main board-2.bin.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Miaoqing Pan <quic_miaoqing@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.h | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 4b8f434e3e9a..cfe1ef156c34 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -17,6 +17,7 @@
 #include <linux/of_reserved_mem.h>
 #include <linux/panic_notifier.h>
 #include <linux/average.h>
+#include <linux/of.h>
 #include "qmi.h"
 #include "htc.h"
 #include "wmi.h"
@@ -1342,8 +1343,16 @@ static inline void ath12k_core_create_firmware_path(struct ath12k_base *ab,
 						    const char *filename,
 						    void *buf, size_t buf_len)
 {
-	snprintf(buf, buf_len, "%s/%s/%s", ATH12K_FW_DIR,
-		 ab->hw_params->fw.dir, filename);
+	const char *fw_name = NULL;
+
+	of_property_read_string(ab->dev->of_node, "firmware-name", &fw_name);
+
+	if (fw_name && strncmp(filename, "board", 5))
+		snprintf(buf, buf_len, "%s/%s/%s/%s", ATH12K_FW_DIR,
+			 ab->hw_params->fw.dir, fw_name, filename);
+	else
+		snprintf(buf, buf_len, "%s/%s/%s", ATH12K_FW_DIR,
+			 ab->hw_params->fw.dir, filename);
 }
 
 static inline const char *ath12k_bus_str(enum ath12k_bus bus)
-- 
2.25.1


