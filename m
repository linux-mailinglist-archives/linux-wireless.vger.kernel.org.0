Return-Path: <linux-wireless+bounces-21243-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF90A7F4A2
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Apr 2025 08:09:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 529DA3B3E79
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Apr 2025 06:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09148262801;
	Tue,  8 Apr 2025 06:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XUJZrGbd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA262620E8
	for <linux-wireless@vger.kernel.org>; Tue,  8 Apr 2025 06:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744092420; cv=none; b=a1jd8CmAXtWmeqgV5DHRxvsiKquhKPHqRuIpK9VEKL3kA3x+5a/5xGfxXsvP1PO8gZ7RyIRMXKQWRvu3Yeb5fyw8i21n2dh+7qhTD86cHpAtsoVd4j07rwRn+qcxpeTN8qAmOLBnIhXxTVkx3O3xkedN4rIpfh+job3JWqRLzXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744092420; c=relaxed/simple;
	bh=IS9JUQNEXbcjFsJwqQld8Af4tR93LGAzSpGELVi0uxI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f70DvsZdbrbv5dFHqllMQQ/Bg7J/BEfeTneY9LsDxL8Djf2Q3fZT8XXX5iNjUlgVhsquXsVN9WXAEN5kBbtdIefO0F0tVAi2P56nz2tMsp8wq/1g7FEinMSmRlEGlDrc38jX9yeDzQkI5Y6N4piH6t5Z95rwhqmZJ2qi+OpNxcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XUJZrGbd; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5382GfxF015965
	for <linux-wireless@vger.kernel.org>; Tue, 8 Apr 2025 06:06:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	o6ANBOqm+FiRypMhdH8047TO8EdqBvFBZWgckBGsDFA=; b=XUJZrGbdeos3HrnX
	XrSgA6xaIKcv8ySusU8gbY0+zXeDveJO2b9sXbJU018QHJ+cDDAgNFgch7zyNMS7
	9xPdNm4nXdYfTs2OQBBCyBXkjmxAQQZzL3L1LEzFFdN22gZHFkQGURQjBpFh3ABz
	+3NcMKr+09MgPIvklf2tG7R8vc1fl5aRhLK9cIa5XHq7dnncL0hMWHlgioEqPiRX
	Hen8MGQRvGswMrspM1yLuzEAey8OgehF8Ec+tKjnQRP7DFFgUllVYskxvlenQorS
	1eqiMITKcJh+JOvLsl1BIe7Q2tR55jxtaHzAFkTlh73IeW46cgdUxIx1JZCPA73c
	uMIwJA==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twftekpx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 08 Apr 2025 06:06:58 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-739071bdf2eso3792278b3a.2
        for <linux-wireless@vger.kernel.org>; Mon, 07 Apr 2025 23:06:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744092418; x=1744697218;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o6ANBOqm+FiRypMhdH8047TO8EdqBvFBZWgckBGsDFA=;
        b=oLnD5cMnXWCEE0DGrh4IgOeDKQBWynMg1kQF67GQSLzva9MrmGb8PBN0sFwLiwFidr
         H2BQQDOPx1yy5J2BP0punnH4Sj54urLpS6WLvUWPpDML+8mp3Gxmu8Ub20eTHzI8bW/u
         4E6ssKbTIHGBycpznWqbohaOT3+X0+9K8G6Ei7EMbgRTEMz6btC9agsgfmE+O3wm0cnt
         0/GVsMJq41wPauk9Zxm3XgSwiAeWHuIaod4bOIsRXnGsEoYeLxETJsEfvx4gGBUoBe85
         qj0BHp5xGWTcmehlRHaE9UIYY/u/Vcco2uuV0SUSkJyxcptfgv7jchN71ehM8A2dq6R5
         7UOw==
X-Forwarded-Encrypted: i=1; AJvYcCUtoQ+CTUEZ6gHPD7DRfCIs1K5SqWZ0QNTaCFHkoCE9L878FgzIUQPe1/I15FS4iu5cKBJOT1WgF4jGyPkQNA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzUDRYLWNNwfbaruwbBNgSkODtNC35Zmkk6ZqUfPhUp1mM3H2Ai
	WLSQCw6wOs2VZiv9J5NLAB2pKGOIGOdf19L63GdZmh8CFDj23yaOR+etnbH2+/vnMfppoTiBG9i
	kjmKN9Klgw8eM3giryAJWZxRYMqXerM91qyXBamroVCu0CyoQsyzPsEU8e0tjEUkJTw==
X-Gm-Gg: ASbGncsSq6zJ1fgdiWmh5MAgcn1JeSeBGuvKrev46abDukBg3kOLM3rP6zIGjYhv75t
	kEOBc6CIhVeSY1WNW9ttkB2DxQmhy7NjYOG1b/BcOM2ovkDsjufc/AGKKffGtr6AkRqsn6a5ULd
	2wfn4gd1Vp3FREQBOCT2inJyqo0UzeOjSBrjxb4rYI0greNj1h1m6W+d+vj1BucoigwgprgRjXc
	q+ON/H9kXLK4CxunWxqezdKEPZsHNSZbpdnQhaPzn9CHMGhXyOX6YjBP5pv1oRVGtCc3t9voH78
	AeBXOaLDsYud+LwVB/dHDf0/f2FHe+nOTKN6A75Bd7KtLBgzCOTxJK+fmxSjea2h5x0OyJe6e6x
	q5appzSl8F+ymo92Yz9c9uFtpzYpxaXc378EJOcSP
X-Received: by 2002:a05:6a00:2410:b0:730:7600:aeab with SMTP id d2e1a72fcca58-73b6aa78298mr13548265b3a.13.1744092417861;
        Mon, 07 Apr 2025 23:06:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGtwlsb6E3Suvk7p5xaMWgdWjGgmaVwWbrEHvBE+yrmvdnE1XhramEak+pBayohMqzjrBY9Qg==
X-Received: by 2002:a05:6a00:2410:b0:730:7600:aeab with SMTP id d2e1a72fcca58-73b6aa78298mr13548238b3a.13.1744092417396;
        Mon, 07 Apr 2025 23:06:57 -0700 (PDT)
Received: from hu-adisi-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af9bc35079fsm6863981a12.41.2025.04.07.23.06.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 23:06:57 -0700 (PDT)
From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Date: Tue, 08 Apr 2025 11:36:33 +0530
Subject: [PATCH ath-next v4 5/9] wifi: ath12k: fix firmware assert during
 reboot with hardware grouping
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250408-fix_reboot_issues_with_hw_grouping-v4-5-95e7bf048595@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=B5+50PtM c=1 sm=1 tr=0 ts=67f4bd02 cx=c_pps a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=fe55Uragd4x0HF6_gBkA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-GUID: Qcum12MeLcKqsGXWq7toBjxEY7qhAkMf
X-Proofpoint-ORIG-GUID: Qcum12MeLcKqsGXWq7toBjxEY7qhAkMf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-08_02,2025-04-07_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 bulkscore=0 phishscore=0 spamscore=0
 priorityscore=1501 adultscore=0 impostorscore=0 lowpriorityscore=0
 mlxscore=0 clxscore=1011 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504080042

At present, during PCI shutdown, the power down is only executed for a
single device. However, when operating in a group, all devices need to be
powered down simultaneously. Failure to do so will result in a firmware
assertion.

Hence, introduce a new ath12k_pci_hw_group_power_down() and call it during
power down. This will ensure that all partner devices are properly powered
down.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/pci.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/pci.c b/drivers/net/wireless/ath/ath12k/pci.c
index aae1989c686bda37c12544e72338bbfbc5f75042..8ee532dcc2652ef4b92bc4c4346af47b783a6708 100644
--- a/drivers/net/wireless/ath/ath12k/pci.c
+++ b/drivers/net/wireless/ath/ath12k/pci.c
@@ -1757,13 +1757,34 @@ static void ath12k_pci_remove(struct pci_dev *pdev)
 	ath12k_core_free(ab);
 }
 
+static void ath12k_pci_hw_group_power_down(struct ath12k_hw_group *ag)
+{
+	struct ath12k_base *ab;
+	int i;
+
+	if (!ag)
+		return;
+
+	mutex_lock(&ag->mutex);
+
+	for (i = 0; i < ag->num_devices; i++) {
+		ab = ag->ab[i];
+		if (!ab)
+			continue;
+
+		ath12k_pci_power_down(ab, false);
+	}
+
+	mutex_unlock(&ag->mutex);
+}
+
 static void ath12k_pci_shutdown(struct pci_dev *pdev)
 {
 	struct ath12k_base *ab = pci_get_drvdata(pdev);
 	struct ath12k_pci *ab_pci = ath12k_pci_priv(ab);
 
 	ath12k_pci_set_irq_affinity_hint(ab_pci, NULL);
-	ath12k_pci_power_down(ab, false);
+	ath12k_pci_hw_group_power_down(ab->ag);
 }
 
 static __maybe_unused int ath12k_pci_pm_suspend(struct device *dev)

-- 
2.34.1


