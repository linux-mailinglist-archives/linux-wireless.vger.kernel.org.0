Return-Path: <linux-wireless+bounces-21766-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB151A94B05
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Apr 2025 04:35:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8070E188C985
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Apr 2025 02:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF1152561AC;
	Mon, 21 Apr 2025 02:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GWFHhld4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03FEA2905
	for <linux-wireless@vger.kernel.org>; Mon, 21 Apr 2025 02:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745202937; cv=none; b=GzaNF2qsEd+ZfAeNNwKtcpzuO14tkcnkRhpFUYj7XlBjV4r3c5CSWoEpzaevKbIN4SinldjP+WUHGQP8y3Pkrd3einmSm4LGIWzSVXt1IGgDui7K2bzRu6o7ZpPYStbVD2sX2I1o8CjMKeCy+GS3ZsrCfsNx7Z3j+IjxSgWMvxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745202937; c=relaxed/simple;
	bh=i2ceF+3S0whrl10qJsbwrEGI9dG+K8SvIekB33JFEuE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jKMlN/X5EZVr9ocNwdan+BRkiSelTUk+0/OU8qLreMI9oBUrk62gBBWj0gBZSHuPbsgZSLdwDUEBzsm/OH2WDhvsTnQDfWoihaLIUmPlzbzylPpTj24ap0x/4GbnPhPZT/qOqIRWshz16Gz7rPHu3FdoxvineqNLe854a/jUdEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GWFHhld4; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53KMpUwV021308
	for <linux-wireless@vger.kernel.org>; Mon, 21 Apr 2025 02:35:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=orF1MVpJ3be
	9RzJ7K3Owwnxk1u4lAzoPL/V0kF7zq+8=; b=GWFHhld4ckstcftnjhhe7gvn0Oz
	M4vFGGC+o3ZIsuRCedxbpAgB/j2MHIzZO5KbCLt7BV+Xfar9aTomgPsQ7UbxkTKo
	uSVkMm1QbVvQOYIQr1KzYFZMuQAqMHYJgZ6TarXE2mt76HZxXbYYwaC29M0C52pm
	Z7973B9Q8TAn7c91v7l9NqrewkdufurbUL68WflzlCqXAs31mK8ZFRZcymP6EW2v
	ScskfwZvePwEINghXf3hAs7Ekr2/iN72x/tHNTIxtedZK5mr6CT3HRt+quWBQSJL
	Tvaq3Nr04PNrWFj90ndD4DjvYaWzRHjB88MgzeQC89nvEsx0L46hWPVPscg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 464426jqvg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 21 Apr 2025 02:35:34 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-22403329f9eso27619565ad.3
        for <linux-wireless@vger.kernel.org>; Sun, 20 Apr 2025 19:35:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745202929; x=1745807729;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=orF1MVpJ3be9RzJ7K3Owwnxk1u4lAzoPL/V0kF7zq+8=;
        b=HibdDP8fTsoBKOZDldWo+0G/6+GvRZAzmUmfFT/hqfA9kBDAcORbGuy3feqkpL4BpU
         SqEXUF8byr30+sR1PoIefj2Doh7HjQ3F4sAi1ocwuuDZb8vXgI92FxcNi0b4CtV913Lv
         b1jT/bICGA7nV0iPjW7YIAOIDVPMjn8owIK+xpWn0fAup3RB4BIiTSyAHyvg/0cwruU3
         6dxYamFx1gjFyOrINUvBhOTDJxhmMkv9W2X5FaGWwn6kG2qOQzp6oGEcTMP0DrgXe1v/
         irkuDQW4UzfSPPvjaFfhIZ0bACsm9+fRTLET+3/3XKC3ANd4uXufpocGjepjT94KJDld
         gyzA==
X-Gm-Message-State: AOJu0YwVrNR5aYKFraKA1zk1pLWd6ttoBi2CzKpo1AEMZuQ/3nwH8cQP
	TTc5P4ypGMbRbgsiqGWDR3QJmgLcCN61dc0Vpx8X3n2wgMr/udLtYP6T4rg5Hsu+7rrs4vNldyw
	RQuEuP9SNk17vLaXIKyINeFFcAApV3uQYQcywpRDIJMES3BxlmiAN5hbF7xz4ZnxVaGW4aewDY/
	5l
X-Gm-Gg: ASbGncuUkX6e2dvq4noVTmGyS7B4Frrt/TXbLFZropJlHM8/PN59M4Fe8tUYsJeo/rP
	bGyI3Yrtw5/DWlfEnheGZr+zli5EjDnSeaVSteG3diR3sTo9UmZRGyZmuaWlX8PTlAJ+CBEHGr1
	KWgNSveECamNuptA+8QOkghhEU7DAaO3+j4SL+lMwt4wctqCur55MZAdYrjnpiA1jNuI0MAj97T
	EeN4cH9vl5ShgL0+EydcgS1RcO3o8k4Ae8vwSPP3jymt5Cc6Cod5HcHsvv+kxgHGZyj7uWc1M6D
	Ms+FIKQVSyvoZBbx4dYg7PqJ+6wVtYNsC9+bK+4/x1FhahnS304qFyPhhfiBtvnEkFPylC6j66B
	EXiO8x4C8/wc=
X-Received: by 2002:a17:902:c944:b0:221:7e36:b13e with SMTP id d9443c01a7336-22c5357e7a5mr160362145ad.12.1745202929031;
        Sun, 20 Apr 2025 19:35:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG4MvvIu8esok8nWOcLznbF+CtoOIC4TSGQumWfQQfJuHZWBGl+D+5PWzzoY1QA9tyt1v/Shg==
X-Received: by 2002:a17:902:c944:b0:221:7e36:b13e with SMTP id d9443c01a7336-22c5357e7a5mr160361915ad.12.1745202928598;
        Sun, 20 Apr 2025 19:35:28 -0700 (PDT)
Received: from kangyang.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c50eb4287sm54631685ad.130.2025.04.20.19.35.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Apr 2025 19:35:28 -0700 (PDT)
From: Kang Yang <kang.yang@oss.qualcomm.com>
To: ath12k@lists.infradead.org, kang.yang@oss.qualcomm.com
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH ath-next 06/13] wifi: ath12k: add monitor mode handler by monitor status ring interrupt
Date: Mon, 21 Apr 2025 10:34:37 +0800
Message-Id: <20250421023444.1778-7-kang.yang@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1.windows.1
In-Reply-To: <20250421023444.1778-1-kang.yang@oss.qualcomm.com>
References: <20250421023444.1778-1-kang.yang@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: -oOVrRtbQ7WqagxD4HAW8udlcfcWCpEF
X-Proofpoint-GUID: -oOVrRtbQ7WqagxD4HAW8udlcfcWCpEF
X-Authority-Analysis: v=2.4 cv=IP8CChvG c=1 sm=1 tr=0 ts=6805aef6 cx=c_pps a=IZJwPbhc+fLeJZngyXXI0A==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=21B3b2Y6f7DkZEkmencA:9 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-21_01,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=828 spamscore=0
 mlxscore=0 malwarescore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 adultscore=0
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504210018

Monitor status ring interrupt is configured in previous patch. So add
handler function __ath12k_dp_mon_process_ring() for monitor mode.

Will implement detail processing in patch 7 and 10.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1

Signed-off-by: Kang Yang <kang.yang@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/dp.c     |  6 +++++-
 drivers/net/wireless/ath/ath12k/dp_mon.c | 12 ++++++++++++
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp.c b/drivers/net/wireless/ath/ath12k/dp.c
index 5eec14a7b1ea..b835c76d6d66 100644
--- a/drivers/net/wireless/ath/ath12k/dp.c
+++ b/drivers/net/wireless/ath/ath12k/dp.c
@@ -933,7 +933,11 @@ int ath12k_dp_service_srng(struct ath12k_base *ab,
 				int id = i * ab->hw_params->num_rxdma_per_pdev + j;
 
 				if (ring_mask & BIT(id)) {
-					/* TODO: add monitor mode function */
+					work_done =
+					ath12k_dp_mon_process_ring(ab, id, napi, budget,
+								   0);
+					budget -= work_done;
+					tot_work_done += work_done;
 					if (budget <= 0)
 						goto done;
 				}
diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.c b/drivers/net/wireless/ath/ath12k/dp_mon.c
index 28fb9d4aa673..0f7d0d517372 100644
--- a/drivers/net/wireless/ath/ath12k/dp_mon.c
+++ b/drivers/net/wireless/ath/ath12k/dp_mon.c
@@ -3727,6 +3727,14 @@ int ath12k_dp_mon_srng_process(struct ath12k *ar, int *budget,
 	return num_buffs_reaped;
 }
 
+static int
+__ath12k_dp_mon_process_ring(struct ath12k *ar, int mac_id,
+			     struct napi_struct *napi, int *budget)
+{
+	/* TODO:Implement monitor mode for WCN7850 here. */
+	return 0;
+}
+
 int ath12k_dp_mon_process_ring(struct ath12k_base *ab, int mac_id,
 			       struct napi_struct *napi, int budget,
 			       enum dp_monitor_mode monitor_mode)
@@ -3737,6 +3745,10 @@ int ath12k_dp_mon_process_ring(struct ath12k_base *ab, int mac_id,
 	if (ab->hw_params->rxdma1_enable) {
 		if (monitor_mode == ATH12K_DP_RX_MONITOR_MODE)
 			num_buffs_reaped = ath12k_dp_mon_srng_process(ar, &budget, napi);
+	} else {
+		if (ar->monitor_started)
+			num_buffs_reaped =
+				__ath12k_dp_mon_process_ring(ar, mac_id, napi, &budget);
 	}
 
 	return num_buffs_reaped;
-- 
2.34.1


