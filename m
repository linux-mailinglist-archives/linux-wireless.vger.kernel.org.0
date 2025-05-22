Return-Path: <linux-wireless+bounces-23262-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31F4CAC01C4
	for <lists+linux-wireless@lfdr.de>; Thu, 22 May 2025 03:35:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 712E9A24898
	for <lists+linux-wireless@lfdr.de>; Thu, 22 May 2025 01:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4841245C14;
	Thu, 22 May 2025 01:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="l5gzgfnA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC81142AB4
	for <linux-wireless@vger.kernel.org>; Thu, 22 May 2025 01:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747877723; cv=none; b=eSk7TxRifQhg/89LkA+LcDNqIfxWu07+s2zaR1kwzc1KLAe/IXpHYBirzRthfYqn4+NdXiLRXYUZNMJh3IYFUsQzlxSq1Rd4R6CevIgc3fmn/whXTJ/BjMz4lLkob7sIgLxxatRidjIDDyRQkVVacOyAB7STYXf4TdziiE8qSTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747877723; c=relaxed/simple;
	bh=BHu2XS8Lf9dBTW7KUh/kM30+gqkNIrKSXMPHJWMCmHk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DqzGd2NUDdaRZGfb/MA1DWuMIjJDogZaJx6gwrBAumZCyhIxNE0BP11Iyulp+qx4XAK857G0NBEh7ChcMY8FgT7OdzXpmXpmsu8LiGsLp9p7vYx3HJbH4cqlOnQGDdyll+oYscY9RWCUC4CEfEJ7HCjO0Ywtgv+xNOy3pEkoLQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=l5gzgfnA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54LI2O4b031724
	for <linux-wireless@vger.kernel.org>; Thu, 22 May 2025 01:35:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=0H/cVOIUNpw
	OrSLOFwCw7lBPYVeMWU0kmPUgQl1LAeQ=; b=l5gzgfnANzrKADxGGtEb8waxTgo
	GysetOkI9QJ82PDIrqKKw2P5NgS2FYwdB2DP6uMk+DoYFZsDowkiF3wcBffg3mZi
	jIedsCfAdOHhnuh5T7NIJJ977ZKJyDhFlWI3I2SdtEJF62KrllE2C+/V/PJIZmT9
	xxVt0M+kfMKDaqGHCpskZvh8pVdji+1Hlkqj2Hsnmobtc3mkR/FlD/ycAQwG/mSZ
	+2L4pDg7Dj8B1T1ULGE+oP9EAp3LUXyh3LsH3I2HaluMGpv7wW30jJ1xJ+LiPYof
	mCDb2hlReqKySPvwhV2eo0KElPHDk2gyhiCZOzP4cb17tvU13vDejEBvCGg==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46s8c23721-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 22 May 2025 01:35:18 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b16b35ea570so7208378a12.0
        for <linux-wireless@vger.kernel.org>; Wed, 21 May 2025 18:35:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747877718; x=1748482518;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0H/cVOIUNpwOrSLOFwCw7lBPYVeMWU0kmPUgQl1LAeQ=;
        b=wzk2mXcpC9GL8RWI4f9isG1DP6ZRFIxrUbl8Hw3JPXEtQOqkTpsNXqTvkHAMts+B7U
         kxOWn3BAg3Ipg09GbdJyMQDHHGbVqm1u1IcCEbHLgrXFEaYkswCEsiaj/U5lFEF+vymQ
         jFZy+qmQ3kKiYW9eZAN+dmzfSwMPrhbhJxIVjP3261YNdOtyYHmVEO0/q/ezIMv6CfXG
         APWdu8mYNLZSG7AOHkHBOKKXinMpWShxyz1czGoAOXdbwsQde96caq7rkAhPugyPdlfQ
         mtkwaS48Kc5CKFpcERJFZCwfQRqlzuNUJyj2vsxvM3SAm8w4ShaXSHyExvtA1mSSTQV2
         g4OA==
X-Forwarded-Encrypted: i=1; AJvYcCUl4DEoj88ggdKoSGeqq6Xsyx57G7ZNqdMtVuT4cywEY852ApcozBc4rG0Hf9P+5WQOHhj6NAV6lW3CgOhXnQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxbynqrBYA/8fIhKnZGzuTS35CHBpuJr3odiyZQR2xZZzC/E4qQ
	9heHx7c5Wc3PHrBKrjKmEyG/XU7BSVF6IqCcX5HHISMoZmua0FWRuew9On/ncpfWbyidA2lOpsQ
	cmRF2AUszU2hXOclYSm2CaiQjM5lrgHzkiE803LY8qAWH2Snb++1a58AiO/zhZuT2KyRvCQ==
X-Gm-Gg: ASbGncuvxgsXumxhY61mA7mZ23j+b/3gWapX07vvwFegagYCCryoNRZxurKt77fzHJl
	iNLuxPm5NLTnEUpqMjGGuM39FhxeGx+YjXU5hd1lfoZDWNoehi55Tzj362Yw6/Eu06xNm01Nrx9
	MKCcNkX7t/jveHSubJeE2oUZjh45WuPLFvy99UmQlboH9ocrIX5P909CChMuIeF+klqD4OXrHEl
	4AiXq0+zy0wqdGu/keDC7fnzAxX3Lw7+XL0FvRv0NnOMxN2C2/O0YQhQ+7PJQ8D7ryj3t1HDj0e
	SfOPeAJznEioD2nRQaPFDqfWRfZxo6XRz+1TCxxmB0DIo5hfbsfLa/cyWYBDAefV8nEiy1I=
X-Received: by 2002:a17:90b:48c3:b0:30e:8c5d:8e4 with SMTP id 98e67ed59e1d1-30e8c5d0945mr40642079a91.16.1747877717691;
        Wed, 21 May 2025 18:35:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGbuUE9/ZskXFCWiI6dbO621KmEQBhp02PqxKIAGf7sPxeTpyZYhpy777m3MSdwOFa0Q247xg==
X-Received: by 2002:a17:90b:48c3:b0:30e:8c5d:8e4 with SMTP id 98e67ed59e1d1-30e8c5d0945mr40642040a91.16.1747877717338;
        Wed, 21 May 2025 18:35:17 -0700 (PDT)
Received: from Z2-SFF-G9-MQ.ap.qualcomm.com (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30f365d45b2sm4341488a91.26.2025.05.21.18.35.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 May 2025 18:35:17 -0700 (PDT)
From: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
To: jjohnson@kernel.org, johannes@sipsolutions.net, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org
Cc: ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
Subject: [PATCH ath-next 2/2] wifi: ath11k: support usercase-specific firmware overrides
Date: Thu, 22 May 2025 09:34:44 +0800
Message-Id: <20250522013444.1301330-3-miaoqing.pan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250522013444.1301330-1-miaoqing.pan@oss.qualcomm.com>
References: <20250522013444.1301330-1-miaoqing.pan@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIyMDAxMyBTYWx0ZWRfX7EkLfx9Q8cSP
 NsblQ3/Uytj/Tr66MJIWKJRwUcUBI8IOioBBWSi7ih5G2gjxZfFJEj80KWBAiMG4WYHfCo3vyS+
 WFmZ6wNKM+SzTO2LMLY+spDo9+gAQW2o61Tu6EWq8XJjnzWDtXafSJ4OEJzhFOxjfxoqkyUtloT
 7uffpOqXN2bPAk0d5Sw+DQlefoq5r6YehW1xiu9YkR4SRG1X4dgc6AJ1n91Z8ubbmdxhCURDrEd
 21e7B5XexTBh0bQYeFJQXLW4DOOVWIbe70TEzVMJtssPfjrwyE9P0UcyqE7qfscSKaakgz3dCoK
 t/EqLZbHCK8YklM3rscX4sAe8faN3i5MKDbCzgCpr5Rk7jBEWp0MQBdxtRztVulQsMf44zFohjC
 FfHdEz3iE9cgpiaa+jhKT/U8KUyBQk2HYBM1tQNuuTViFT3EI3e5olMlXCISg2tNJgQmsSlj
X-Authority-Analysis: v=2.4 cv=RIuzH5i+ c=1 sm=1 tr=0 ts=682e7f56 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=dt9VzEwgFbYA:10 a=EUspDBNiAAAA:8 a=jX1nYg6MY8bSXAgjlsoA:9
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-ORIG-GUID: sjguKPrEoM0wCYuAY4Uy9igOeFDSmWFc
X-Proofpoint-GUID: sjguKPrEoM0wCYuAY4Uy9igOeFDSmWFc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-22_01,2025-05-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 phishscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 mlxlogscore=807 spamscore=0 lowpriorityscore=0 mlxscore=0 priorityscore=1501
 adultscore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505220013

Introduce 'firmware-name' property to allow end-users and/or integrators to
decide which usecase-specific firmware to run on the WCN6855. This is
necessary due to resource limitations such as memory capacity and CPU
capability, or performance and power optimization for different application
scenarios.

Currently, there are two firmwares, both files can be executed
interchangeably.
For example:

- ath11k/WCN6855/hw2.0/amss.bin,
  ath11k/WCN6855/hw2.0/m3.bin
  ath11k/WCN6855/hw2.0/board-2.bin

- ath11k/WCN6855/hw2.0/nfa765/amss.bin,
  ath11k/WCN6855/hw2.0/nfa765/m3.bin
  ath11k/WCN6855/hw2.0/board-2.bin

The former is the default firmware, suitable for most WiFi 6 STA functions.
The latter adds support for commercial-quality SAP and optimizes power
consumption for IoT applications. And both use the same BDF/regdb data
within the main board-2.bin.

Tested-on: WCN6855 hw2.1 PCI WLAN.HSP.1.1-04479-QCAHSPSWPL_V1_V2_SILICONZ_IOE-1

Signed-off-by: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath11k/core.h | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index 339d4fca1ed5..67b3b6d898fa 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -17,6 +17,7 @@
 #include <linux/average.h>
 #include <linux/firmware.h>
 #include <linux/suspend.h>
+#include <linux/of.h>
 
 #include "qmi.h"
 #include "htc.h"
@@ -1320,8 +1321,16 @@ static inline void ath11k_core_create_firmware_path(struct ath11k_base *ab,
 						    const char *filename,
 						    void *buf, size_t buf_len)
 {
-	snprintf(buf, buf_len, "%s/%s/%s", ATH11K_FW_DIR,
-		 ab->hw_params.fw.dir, filename);
+	const char *fw_name = NULL;
+
+	of_property_read_string(ab->dev->of_node, "firmware-name", &fw_name);
+
+	if (fw_name && strncmp(filename, "board", 5))
+		snprintf(buf, buf_len, "%s/%s/%s/%s", ATH11K_FW_DIR,
+			 ab->hw_params.fw.dir, fw_name, filename);
+	else
+		snprintf(buf, buf_len, "%s/%s/%s", ATH11K_FW_DIR,
+			 ab->hw_params.fw.dir, filename);
 }
 
 static inline const char *ath11k_bus_str(enum ath11k_bus bus)
-- 
2.34.1


