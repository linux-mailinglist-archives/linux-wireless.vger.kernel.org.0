Return-Path: <linux-wireless+bounces-21245-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CED1A7F4AB
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Apr 2025 08:10:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4675E3B4268
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Apr 2025 06:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AD4A263C9B;
	Tue,  8 Apr 2025 06:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fL38UVB7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE72263C72
	for <linux-wireless@vger.kernel.org>; Tue,  8 Apr 2025 06:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744092428; cv=none; b=tzNdWKzV9oborGHiBSpdFKcxQrPFuz+ud5kSsWkKMMC7jigEb+HwmWtNtEX1nm4GBf1HlDHc93AywUwZJWVyVbizNmYFkH+Y3kKMJeLWARi3p2VxDpllczp6ynVahpxXfdwdS+Oo5OldCQ7oBKVYWe8lm04I/lP/ktpqVTeg2Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744092428; c=relaxed/simple;
	bh=ilPjgkafgyzznZHuUen0W6iN7bRy3vMa4VsRmnlzJtA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R0nVpBel/Y/MwcMxvWdHxepgtpYF8BBSvskFPmIl7oSZymtz9tCRNXFy8b7NZWsBXyjYkLdlzAc9nOylOmxoXaUOH57sod7pSApidpmJZ5cM8lR91WCBddHceMp/O+1Cwyw6zyfqdzamF+9XnHdG1ccWVmJekPoY5bJODYGVY94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fL38UVB7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5382GOvO019568
	for <linux-wireless@vger.kernel.org>; Tue, 8 Apr 2025 06:07:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8QQxTRGzAWSkjPcsxs8V36ycVB81HcrD4UeC7M77KZM=; b=fL38UVB7bNHdaEQj
	Wc1QFOcTKceTSt3/ZbS+K6nF5hC8r9LKlPSpPblwk7C/6VOxLcPA6SagD/by5hqJ
	C1LgeC6qrI7POL7IGnmMJIVGZfRKnRPr4z2uR6rO7cOgeE6val6/4B0HqDLI8rYE
	fWtXBPcngG4dBKeWIc4UKCNcHOl7UWYFbUe5rYXjlVDFKNPutm1a/UvOUrpdAED3
	dssyJ/VeB+oFs+kkdeWMvfRsy66TRslVuKf5pBt3Z1/1FbZSXlqa+QMSDDlwkWgW
	KIwFKxCly0Ewb8N5j8VSf/CZCO95KT4cVejRwS6OqfPG1qOt0QPwciyyxMRP4pzU
	SVOmaQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twg3emv6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 08 Apr 2025 06:07:05 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-af8e645a1d1so3116148a12.3
        for <linux-wireless@vger.kernel.org>; Mon, 07 Apr 2025 23:07:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744092424; x=1744697224;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8QQxTRGzAWSkjPcsxs8V36ycVB81HcrD4UeC7M77KZM=;
        b=RtVC1+/S99L/ygcol9OwgsxWoLG79tStlU3CgdTniZsCQLy4yLm0dms3bO7H8AI7o+
         k0nGDpvC8jGu6quSqLmi8gDmM9rORtV18C6moPNjAb3ClEyPRg+Us65SxNSNntn7iSQk
         I05XX6OedTwSdKieFwg+f7pTg2Nfhwdr6KGN571Jlp0IuNxpE8wftJ0RWjldXi7PrdgQ
         x3R8IM1WPH/h9CL7vT1SEGj40xfWHSj7y05XtbtKyCb62pZHZ0sFz8UAyzPSFCUpel9v
         UbbfoqgAVhnbpvd/YsrUXZDrLXPZ7LuuTParIt6Vg7oj2o5DMh3IWiBP3QX00LyBc1Q3
         X9qw==
X-Forwarded-Encrypted: i=1; AJvYcCVuMxsnC/MPo2/lRhR/pIsObzfpej/Ut4fVm/1ipeFi0tJuksed9bf8CU6xl5erINMLkK2zDAZwWBQ967Kifw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyDRrmTw4bPmfM632SkY9yoN8judhFJg27nCbcLvV6g+xlx5oQO
	3t56mcihoq/Hm5toXzU5I0/6ieuCH7KeRQrPk7uncW0inFNH3U6qSK+if5byeCp1R/6PxuRYAtB
	PcGOR/UPIj4kSPdGgyquOaA2E8x1Udrq7AcioO0sRrDsmlWKniJWzhRzVGKK7jJSVTA==
X-Gm-Gg: ASbGncsrPz9AnF8vr6abkXu//2apHgRQElgGKVqmEz3ceGB8Q2gBXT35x+7oaZ/Bx/S
	gx+dLLt+Jad3gtta1vvbXzV62gKyO3xGb3qZyx0xi3592qZArLG4eTIc3vbe2ldwLb8ro6JbSEY
	6SRaN7PNBBxK4oUv0+sevrpL6b4SOmNbXecvsCfhbnWhFXAftNuFjhVsrHVqQIrSj7Xwly6fw/B
	Qwy5v5SoZvRbKV9Pmb6xMl31gOgjXfeBoOixYpS7pl8VJAQ5qeZAzXGsuRlfa4A/dM0KonCXLxh
	u2VPt9JHfEyUQGWRrxVz3xW/vXDSXJwlIMGsHHGtId8ZZY0Uv3M1VY3yBBs3kwt1V7taNfQUs1M
	EPxbkWmeyvV60vWElRra2GLRVKSFNYO1/rwUxFu31
X-Received: by 2002:a05:6a21:9106:b0:1f5:7873:304f with SMTP id adf61e73a8af0-201047308d3mr23586256637.37.1744092423917;
        Mon, 07 Apr 2025 23:07:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGehgwvENWYFAh7L0VL6AOYJv5Q31lAnQj6VPBRBRWbyGqHgmJcLhq5+f5Nogv81PMUJMbnA==
X-Received: by 2002:a05:6a21:9106:b0:1f5:7873:304f with SMTP id adf61e73a8af0-201047308d3mr23586228637.37.1744092423532;
        Mon, 07 Apr 2025 23:07:03 -0700 (PDT)
Received: from hu-adisi-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af9bc35079fsm6863981a12.41.2025.04.07.23.07.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 23:07:03 -0700 (PDT)
From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Date: Tue, 08 Apr 2025 11:36:35 +0530
Subject: [PATCH ath-next v4 7/9] wifi: ath12k: handle ath12k_core_restart()
 with hardware grouping
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250408-fix_reboot_issues_with_hw_grouping-v4-7-95e7bf048595@oss.qualcomm.com>
References: <20250408-fix_reboot_issues_with_hw_grouping-v4-0-95e7bf048595@oss.qualcomm.com>
In-Reply-To: <20250408-fix_reboot_issues_with_hw_grouping-v4-0-95e7bf048595@oss.qualcomm.com>
To: Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson <jjohnson@kernel.org>,
        Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        Kalle Valo <kvalo@kernel.org>, Harshitha Prem <quic_hprem@quicinc.com>
Cc: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: 99uJ1CiX_-U4AN0EhalwMzPQLXY7EtO2
X-Proofpoint-ORIG-GUID: 99uJ1CiX_-U4AN0EhalwMzPQLXY7EtO2
X-Authority-Analysis: v=2.4 cv=I/9lRMgg c=1 sm=1 tr=0 ts=67f4bd09 cx=c_pps a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=J1AqtRd1v4e3_tdQaqEA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-08_02,2025-04-07_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 phishscore=0 suspectscore=0 mlxlogscore=999 lowpriorityscore=0 spamscore=0
 clxscore=1015 malwarescore=0 adultscore=0 priorityscore=1501
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504080042

Currently, when ath12k_core_restart() is called and the ab->is_reset flag
is set, it invokes ieee80211_restart_hw() for all hardware in the same
group. However, other hardware might still be in the recovery process,
making this call inappropriate with grouping into picture.

To address this, add a condition to check if the group is ready. If the
group is not ready, do not call ieee80211_restart_hw().

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/core.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index 0fb3e57cd254ede767528e47e1d9d183257e5b71..a1c9b8771e9c4c84548da2cb4054b0403aa8c759 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -1560,12 +1560,22 @@ static void ath12k_core_restart(struct work_struct *work)
 			ath12k_dbg(ab, ATH12K_DBG_BOOT, "reset success\n");
 		}
 
+		mutex_lock(&ag->mutex);
+
+		if (!ath12k_core_hw_group_start_ready(ag)) {
+			mutex_unlock(&ag->mutex);
+			goto exit_restart;
+		}
+
 		for (i = 0; i < ag->num_hw; i++) {
-			ah = ath12k_ag_to_ah(ab->ag, i);
+			ah = ath12k_ag_to_ah(ag, i);
 			ieee80211_restart_hw(ah->hw);
 		}
+
+		mutex_unlock(&ag->mutex);
 	}
 
+exit_restart:
 	complete(&ab->restart_completed);
 }
 

-- 
2.34.1


