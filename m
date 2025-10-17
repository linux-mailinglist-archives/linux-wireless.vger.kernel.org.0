Return-Path: <linux-wireless+bounces-28008-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 40EC0BE6442
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Oct 2025 06:09:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0227A4E96D1
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Oct 2025 04:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F21D30F7EB;
	Fri, 17 Oct 2025 04:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PNZ7fYCZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F8B30F536
	for <linux-wireless@vger.kernel.org>; Fri, 17 Oct 2025 04:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760674101; cv=none; b=j7qJ30acyrWE0qx+WvYhewQuLnbfy8EaoadjitSp7Yy1eihMyCJony/8ez5olwxrD+ORlTDxZ//IOO3weFi4saCgPJOSa6kCJ4nUeb8F5tdJ5BChGg9Qlwbb7ce6d7EUYp3po8GIwpaKFs1q3MakHuCa1L9yrAJn/jyVv/LnfGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760674101; c=relaxed/simple;
	bh=sG8S76iua8wQxnfu5QaKX0Y54Ntq78nz2q5CLpehoEc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G0Qc4e4lFUrp3uZUeE8+z0DRSRiQ4sQDp1fnuD7jaEIaA9nj8ORU/Moi02GIxrC8Dkf6u9NTY98selYd8xut9PwEAo7pGItJ9EE/97YWDJapn4iUFbwApASjG7di8D4J9FQtWqoSCw5cxod88/nyUkbls746eGrOUM5Wv9T2FDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PNZ7fYCZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59GKLfgC020545
	for <linux-wireless@vger.kernel.org>; Fri, 17 Oct 2025 04:08:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4vOd1s0xzTmHuz/VFeRFh8thGs7i2iDojrILESN1HW4=; b=PNZ7fYCZUyFWvIxC
	G+9AwbYhG9fNjJFSTCkmYOyOxxWjniebFiC+APR6v3mtRJa3UddeKu5ufax3Kv/j
	ycuAOgOm53445tUY84FH+pSVMsWSMYgXiN36MhOzcuUgxUexII19ya4eAhKJF1WU
	0yBoW8PvYCo/ZM8FKs8hAHhqfw3mWEDn1xxRTIHdRDrcQis2j9gm/QqGKloUyrWx
	n9M4otOxgTXoUh+fDQg1ueTe406MevikMw8a4Lokg7C2tIQf5U7lvQy9Sggz7cYo
	GJC4dTsJFJdCWzBug62BuCG5xHsMUpIs4CReULPbqk/7KsHow8+f2r1t5cxzTXjj
	iwJ1RA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49sua8sfps-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 17 Oct 2025 04:08:18 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-277f0ea6fbaso19888135ad.0
        for <linux-wireless@vger.kernel.org>; Thu, 16 Oct 2025 21:08:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760674097; x=1761278897;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4vOd1s0xzTmHuz/VFeRFh8thGs7i2iDojrILESN1HW4=;
        b=uk+B2hqNiQEVk7tNBthmhpC0V4I8ksJEWmydubejBhGWkkk9EURa6WA1hGdWnM8cRt
         43j8A+Y2Ot5h0B199JaP2judiztLTgOp2/SEqNW0LjW7ZUvKmPnqunbVTp/mf1Y/Ik3p
         PEh0CwX4TO2YONzU1HqtAUy+qqf7Mn4X14NSrHYExfJq+8j4WXsX2C42OK4Nt6xZ/vVQ
         vtqBjMPi4RGMXjkYAVKHNBxRHORJ4gj+JQfnDd0xN2e6Xx5BWAcMkRMgahteX3xA8MHD
         8d8YB8wP/YVo5ralmC63OKNeNjtQebYEqkd131v97EQ6qkvkCYa2xMrQIOI3JnFcpu7c
         qAxA==
X-Gm-Message-State: AOJu0Yz2FnJqc/Ko6w6uWfFBD0fyifWwS6MJD62om3ru9UCYkZixGInY
	0ajrSDI3hEwyd4aGeffyf8eO8vKun5Qdg9TkqysdDHtwvv0Wj/qs45/9sQsi0s091i8m3Xhir+G
	qILNaz5mUncgGumqWty2kSo2/Ukt88qQamVZ4eIzjmdtyN7nBQH6v2clOTPm0uC7S7g+YlA==
X-Gm-Gg: ASbGncstFcfXGYnIQzI4ZCWKGiiMqGrozPbYiklaOEWtRayxo5KeGr9PlCaBRGfVpSh
	lb5gR3KuVvtdoh8mC2jPJWWkavv/Z1PjupXkgLPmGnHUVp+6soGdvAmkftGE0od7h/LnLGyCLYA
	nYvYIqSDTTDXqpNTGDR8pLKQYbprDDfVCqeTCfZonVGHYzKqJmutEJgOSxd3UybxDl69Ffo9vv0
	KM5DnNqc5aBK7pG/sTSzckujE83zWOa71mN2k2sLOwI6mUdbg+ywc9QbqNFe9NUfZVt6nqrd9Rf
	1+8B/fYkZyqZ0SwQEoP22hYVp0/3RwFH9DtV+ICVZEF1Qasep/D9w6cYG3T588BVmFMiCZDSTsU
	Xjf3hztKzLTaMMDnT4MGZb3OvlqU3ZcnpL1CGHZ/iFwmM+kK/yCp07H3QVVbYWj2A41taDdFEpk
	LvjdH7u5GNAbUK1zZ968Kvvaw=
X-Received: by 2002:a17:903:244f:b0:261:e1c0:1c44 with SMTP id d9443c01a7336-290cc2f83a5mr28436095ad.40.1760674097419;
        Thu, 16 Oct 2025 21:08:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGiN7L2yUjdFr/LpdDmY+/QiQ3okGiPKE7r38tveBTIAwYhGCdTLa2YZJcf7W5up77l+rmgIQ==
X-Received: by 2002:a17:903:244f:b0:261:e1c0:1c44 with SMTP id d9443c01a7336-290cc2f83a5mr28435885ad.40.1760674096991;
        Thu, 16 Oct 2025 21:08:16 -0700 (PDT)
Received: from hu-adisi-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29099a7afcbsm47635345ad.76.2025.10.16.21.08.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 21:08:16 -0700 (PDT)
From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Date: Fri, 17 Oct 2025 09:38:00 +0530
Subject: [PATCH ath-next 4/4] wifi: ath11k: advertise
 NL80211_FEATURE_TX_POWER_INSERTION
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251017-add_tx_power_insertion_support-v1-4-f08feacfca93@oss.qualcomm.com>
References: <20251017-add_tx_power_insertion_support-v1-0-f08feacfca93@oss.qualcomm.com>
In-Reply-To: <20251017-add_tx_power_insertion_support-v1-0-f08feacfca93@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: KXovY1tYQGbHEYCOMXT2Ym3ZV8lmRk9J
X-Authority-Analysis: v=2.4 cv=e5MLiKp/ c=1 sm=1 tr=0 ts=68f1c132 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=Q_Yd3DzVMxYqS39AGnIA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE0MDEzNCBTYWx0ZWRfX3Qbkz54DfnAm
 QzGZb2InTvC1arJWDE4qW/ML7bEMYgJVDrA24tnRTcbZOh0dol1PgQ/tmhod2ycLbnP5DXQympc
 qBr7wCW6yR79IEQub2WCC4litXE2hctVC/sRG/9xdY6OiHukx3HOg6/x4A86ZFXSCbViIRqeipC
 NaV200eguWEyJvU31ytnwEZmfFINccEwexjr1M6jpsOH5uYG0T8ZCcJLnEp9IXWUX2+aVzLnmov
 VLHZCXrllEebWVj1dN/UYxu7sdc9fpi+hIJZxv1I9FROw9MB+VA1zTaRnpHguv+UqSoucR9CtTS
 dml6P9P4GqHPb5rdgOXPD2L1B3ERfAIEznH/siDRrLe7XCZxY3mT/+78d3dBBzKX7o0FE0Hl7C1
 hZWLG7DI9WSc5Lw2Rf63zw+74jZGwA==
X-Proofpoint-ORIG-GUID: KXovY1tYQGbHEYCOMXT2Ym3ZV8lmRk9J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-17_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 spamscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510140134

Now that driver is capable of inserting Tx power, advertise the support
for the same to upper layers.

Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.9.0.1-02146-QCAHKSWPL_SILICONZ-1

Signed-off-by: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath11k/mac.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 773ea1d4b358..23b02e505099 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -10543,6 +10543,8 @@ static int __ath11k_mac_register(struct ath11k *ar)
 	ar->hw->wiphy->features |= NL80211_FEATURE_AP_MODE_CHAN_WIDTH_CHANGE |
 				   NL80211_FEATURE_AP_SCAN;
 
+	ar->hw->wiphy->features |= NL80211_FEATURE_TX_POWER_INSERTION;
+
 	ar->max_num_stations = TARGET_NUM_STATIONS(ab);
 	ar->max_num_peers = TARGET_NUM_PEERS_PDEV(ab);
 

-- 
2.34.1


