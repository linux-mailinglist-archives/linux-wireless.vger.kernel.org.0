Return-Path: <linux-wireless+bounces-21859-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD840A97E37
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Apr 2025 07:42:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1970616E798
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Apr 2025 05:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ED2D266592;
	Wed, 23 Apr 2025 05:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="NAkGE6mO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9997A265CCA
	for <linux-wireless@vger.kernel.org>; Wed, 23 Apr 2025 05:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745386942; cv=none; b=p/YYmwsNgkoFhQEDkQatk4/9+6HgEGlyWG14sK9WzY+EP4UxiOTjgGpfN2UesVxXy0+j9YbDQ8m1ticaIuZug55dO5MjgUPYGzB4ZjjNLXMt4VxzFC0r80fOJ5q/CtebvFPu2ITRGEsf4+rDg2JOizwnxxxt7whz1BYoM8PLZ6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745386942; c=relaxed/simple;
	bh=dC37s6TQKS9T6iuB7Tn8mVP/Yop62O4eI6mP2j3P/Z8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eDbiDOFGDVEmvLQMduwaMlq6ZW3d4Tct5Ti8ZlD5LPLH33dqgSiuLzRl/lsGFvvO65COVAFHKPOKQ6AyueWcAwK+5bWhOAeOnp7W/5p31RJGLEEScdj6BYR6fa6fiQbswlh9FFL3JMRvHbFYdhEPmcbCey0ulEXlFRI1tWNICwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=NAkGE6mO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53N0iAit013403;
	Wed, 23 Apr 2025 05:42:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Wp29iO7wYDz/sKhKncYba5qpme5gs7HJpcHcrRQPRyk=; b=NAkGE6mOhFsbDGQA
	ZBo9s8KUw4RilkkS/18iNkCHmJjtxZ5YTME2gk8HchMcfgEpLPBfaK1iT+xYPi8o
	lFOC5CGkfk2Xdddbg88wNS2LAAGdT4C1OVERjzTw4ft0QGezDvxhSFP91r8757t+
	fW/VftZ9IS/Z9w4gXwjzngWI5u1tdcnppIb6PuhUYRyDy0T1621+C/+H/fyGsDet
	e1E6+Y7m5FpmEanfbQJbW8OqFCK4pJ53BVGE3tIi74dgisOASx/AihatLzSzhUbV
	V6mG4fOUmImOzHBrpt5zjPsasBRGnVv2QAmk9xqQ8qi7vpMSmb+kwC7itXEhupOp
	FtMPqg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 466jh38ygp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Apr 2025 05:42:18 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53N5gHe3000525
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Apr 2025 05:42:17 GMT
Received: from localhost.localdomain (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 22 Apr 2025 22:42:16 -0700
From: Miaoqing Pan <quic_miaoqing@quicinc.com>
To: <jeff.johnson@oss.qualcomm.com>
CC: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        "Miaoqing
 Pan" <quic_miaoqing@quicinc.com>
Subject: [ath-next 2/2] wifi: ath12k: support usercase-specific firmware overrides
Date: Wed, 23 Apr 2025 13:41:52 +0800
Message-ID: <20250423054152.2471568-3-quic_miaoqing@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250423054152.2471568-1-quic_miaoqing@quicinc.com>
References: <20250423054152.2471568-1-quic_miaoqing@quicinc.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDIzMDAzNiBTYWx0ZWRfXyyBnx0g7OXUc 3jHHrQcb/hwos0VYAFfambECwkyxlCDUgWidaa20d1Y5AjTEQXWSBJcTqqY1ekbwwnhCqkh6v5y GMmPzntpoPwZ4VXvAVVMbjbaYwGUP5fCUsQqIVKCYvHUDDQ05v0GNXtjQTsaiAZNhJg8HNJENou
 ANxeBZpDHpfcVUjzfzD8uX5Na9/Z3MbF28ccU4jfnZ4reFqyI/adna4LnErj4k5Inhavj0Vv/IL vmAvDXzhAUi9rxhCCqOwnmjAdZiIh4kYQlj/ns4eP0RJyuvmf506GbfaA1RcoXObsNguPa7aKr5 WMB3ZP6qTXBQWpy0hhDO5owZdwm8wGht+1/ja6ymXvOPGTzukpUJLpx4Jew3teizVNL9kq5eOtS
 0aXNl+ZmEPcqkNn8BB4E9tp5siQiLHv61sOtcOnh9jaT2MA+lf0Ps6S4J86WFpenCFXbIegh
X-Authority-Analysis: v=2.4 cv=bs1MBFai c=1 sm=1 tr=0 ts=68087dba cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=jX1nYg6MY8bSXAgjlsoA:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: Q_xyy2CDW0Ok7DFg2UC16Vvc6vZChLFx
X-Proofpoint-GUID: Q_xyy2CDW0Ok7DFg2UC16Vvc6vZChLFx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-23_02,2025-04-22_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 suspectscore=0 mlxlogscore=796 mlxscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 impostorscore=0 malwarescore=0
 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504230036

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


