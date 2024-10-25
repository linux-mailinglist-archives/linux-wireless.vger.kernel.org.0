Return-Path: <linux-wireless+bounces-14519-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FBCE9AFF7B
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Oct 2024 12:05:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3FDB286182
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Oct 2024 10:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F831D54EA;
	Fri, 25 Oct 2024 10:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="S2FoNakt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789C81DDC00;
	Fri, 25 Oct 2024 10:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729850687; cv=none; b=cWGhbFEV2V4V5aLLgtnmP3heuj4g0Sw9CK2u57UU8esfO1RC7Zt1Rkqb3fem544luG/0b8yYvNxKzRPQ0kE8rECMvPpi5yNDO5P7usUoyZ8ZIWtdVjc5qDjcWVG6OIYp2tGNQRxGGeGRbHl3evOxaDgKCD7/aK2VrHbBOouILzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729850687; c=relaxed/simple;
	bh=WapFNe2mPWIX5k7PW3XnSZ+V+Rh5Tj59T5UWo3ELKmQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ARHNtcHD8L0ABHS7WWurdP+Vwlfn82y5dJ0+DNuS2DwCVyuKJEFz16UCl9OJOAIurbezLma/j2AmnzeUSqx8098T/k9E/VoYp0OXGKxSPZFDd/q3Pu8VNec6ZKy4UtxFOZ7Fel0duiOBYpLc7BJQJAjrOK1YyFPkh1rnFSGNpVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=S2FoNakt; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49OLSdmL007412;
	Fri, 25 Oct 2024 10:04:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ftJMyhYOYzFX2IvZKhEKNE7fc5eSoz9ZcEcYI9pTEG0=; b=S2FoNakthXp6lHZs
	rUBoD74pc9BmyV371QmkmHA48dfNJ4ktWLlPn1dE6LY1VvFJOdHOhuMgWt8AtG2W
	0J8wKoAOy6wmDWZTfvW0FAkeLlCHPb9sYOU4D27Jkb210acwN55BcmefzUy4pVsv
	1QejpjojGzdT4vXlB293H1ScJSGkwJ2DynSSN6i54hTDwZ2wSMIFjJ4qlHgFcxRf
	1ir9vxWfglTvui601TRYV7Gxp/57sKeC7jcw1TawXen88kwBKm8pRFXalVrazchs
	aXEUFtcKYTc0nycYG2Axi7OvjyPlVwQpaFpFimhlbKAPJjYceFa9u+4VR+8GiCPd
	jwQcIQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42fk52ke7r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Oct 2024 10:04:39 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49PA4bLv012797
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Oct 2024 10:04:37 GMT
Received: from Z2-SFF-G9-MQ.ap.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 25 Oct 2024 03:04:34 -0700
From: Miaoqing Pan <quic_miaoqing@quicinc.com>
To: <kvalo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>
CC: <quic_jjohnson@quicinc.com>, <ath11k@lists.infradead.org>,
        <linux-wireless@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <dmitry.baryshkov@linaro.org>, <krzk@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Miaoqing Pan
	<quic_miaoqing@quicinc.com>
Subject: [PATCH v3 2/2] wifi: ath11k: support board-specific firmware overrides
Date: Fri, 25 Oct 2024 18:04:19 +0800
Message-ID: <20241025100419.2128604-3-quic_miaoqing@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241025100419.2128604-1-quic_miaoqing@quicinc.com>
References: <20241025100419.2128604-1-quic_miaoqing@quicinc.com>
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
X-Proofpoint-GUID: jSbFs4zIT_GHYeHWTw9h9a8MlizfZTJ3
X-Proofpoint-ORIG-GUID: jSbFs4zIT_GHYeHWTw9h9a8MlizfZTJ3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 lowpriorityscore=0 malwarescore=0 impostorscore=0 phishscore=0
 adultscore=0 mlxlogscore=983 priorityscore=1501 spamscore=0 bulkscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410250077

QCA6698AQ IP core is the same as WCN6855 hw2.1, but it has different RF,
IPA, thermal, RAM size and etc, so new firmware files used. This change
allows board DT files to override the subdir of the firmware directory
used to lookup the amss.bin and m3.bin.

For example:

- ath11k/WCN6855/hw2.1/amss.bin,
  ath11k/WCN6855/hw2.1/m3.bin: main firmware files, used by default

- ath11k/WCN6855/hw2.1/qca6698aq/amss.bin,
  ath11k/WCN6855/hw2.1/qca6698aq/m3.bin

Tested-on: QCA6698AQ hw2.1 PCI WLAN.HSP.1.1-04479-QCAHSPSWPL_V1_V2_SILICONZ_IOE-1

Signed-off-by: Miaoqing Pan <quic_miaoqing@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/core.h | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index 09c37e19a168..664eb244a989 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -16,6 +16,7 @@
 #include <linux/rhashtable.h>
 #include <linux/average.h>
 #include <linux/firmware.h>
+#include <linux/of.h>
 
 #include "qmi.h"
 #include "htc.h"
@@ -1299,8 +1300,16 @@ static inline void ath11k_core_create_firmware_path(struct ath11k_base *ab,
 						    const char *filename,
 						    void *buf, size_t buf_len)
 {
-	snprintf(buf, buf_len, "%s/%s/%s", ATH11K_FW_DIR,
-		 ab->hw_params.fw.dir, filename);
+	const char *fw_name = NULL;
+
+	of_property_read_string(ab->dev->of_node, "firmware-name", &fw_name);
+
+	if (fw_name)
+		snprintf(buf, buf_len, "%s/%s/%s/%s", ATH11K_FW_DIR,
+			 ab->hw_params.fw.dir, fw_name, filename);
+	else
+		snprintf(buf, buf_len, "%s/%s/%s", ATH11K_FW_DIR,
+			 ab->hw_params.fw.dir, filename);
 }
 
 static inline const char *ath11k_bus_str(enum ath11k_bus bus)
-- 
2.25.1


