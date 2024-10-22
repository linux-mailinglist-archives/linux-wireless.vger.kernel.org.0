Return-Path: <linux-wireless+bounces-14317-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21FBF9AA0DF
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Oct 2024 13:09:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D57A7283A6C
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Oct 2024 11:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 888F419AD97;
	Tue, 22 Oct 2024 11:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="eErBuOir"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01BD7199FD7
	for <linux-wireless@vger.kernel.org>; Tue, 22 Oct 2024 11:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729595347; cv=none; b=PrY/xKxcOHFu0O4AiBtVNXWIwZ1C4gYryzhUOi1v7DDbmqw94PUD8LakFWy3HZ2ku4SKucOzZmB8vSkaf0BxBX0djH07Y/98SJPUw2fI5yLK5AbGx/OxsQ7E9667g1D21SMJQD5xfY5Fd66nnye47YoFINRTfFtzy0dB+jb4EZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729595347; c=relaxed/simple;
	bh=j1f7u0y7JB17LtcsFnmjYjvUJccRY6S9HzRGN/nEGQU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DE0mw5RBPWPghoSYv+Z3X2bWsDHosJqIJAdMUzJ5POuA5PY4a7WTdIhGgE8OmvVFOkJsryGEzCQU3nKpGoL6o5SZGMNxBsM9cZ/F1vxiqmyO+ug9mdnW3FIQW3d5XzLSN72uvo1EsKyHYzb4AzYhfcJqqVyRURBb41uervjLXrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=eErBuOir; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49M9PQhK001964;
	Tue, 22 Oct 2024 11:09:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/1OzFmM0W2Fi2k6tJSAyAt0OUQK6MpIKE2QVwiQeEJc=; b=eErBuOir6H3CzBke
	rjP6KnNUOuxB/t8VEE3HO7urC+B4Ygha1Ys2lS91sw/hTePCykC+rkdmj1DdFe6a
	Hw8NcldFxpFmVlPv3US1jZayp1d7HRshsQ9U/CMyP/WbnNUYv6rzjmQdyVvANlZO
	bD/eyxiViUXyMCcebI08oD0AIIArOgtpQwuDA8uzXWZuDwi/4YzaB3scEdCkkShM
	m43lrtpXhu842QE227mg+vwm+VotaC5QQEjZkp+Nk1IwtcM/Aib75wh+Y5ZF7BBP
	W8sa2Xz604IPypmDTQWnSsHadJ0/oRYtcGCxYso8wRHfCtuTpMFfQhqQaidcQegT
	XNdUyA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42c6rj7xvy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Oct 2024 11:09:02 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49MB91XQ007690
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Oct 2024 11:09:01 GMT
Received: from kangyang.ap.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 22 Oct 2024 04:09:00 -0700
From: Kang Yang <quic_kangyang@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_kangyang@quicinc.com>
Subject: [PATCH v6 6/8] wifi: ath12k: delete NSS and TX power setting for monitor vdev
Date: Tue, 22 Oct 2024 19:08:29 +0800
Message-ID: <20241022110831.974-7-quic_kangyang@quicinc.com>
X-Mailer: git-send-email 2.34.1.windows.1
In-Reply-To: <20241022110831.974-1-quic_kangyang@quicinc.com>
References: <20241022110831.974-1-quic_kangyang@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: U7zTABjLuAvYld-wCr51NcdcIECWMiEF
X-Proofpoint-ORIG-GUID: U7zTABjLuAvYld-wCr51NcdcIECWMiEF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 bulkscore=0 malwarescore=0 mlxscore=0 spamscore=0
 impostorscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 mlxlogscore=677 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2409260000 definitions=main-2410220071

ath12k_mac_monitor_vdev_create() will set NSS and TX power to
firmware for monitor vdev.

But firmware doesn't need them for monitor mode.

So delete them as a cleanup.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index e65b536d4a2a..a1c5d36985d0 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -1147,7 +1147,6 @@ static int ath12k_mac_monitor_vdev_create(struct ath12k *ar)
 	struct ath12k_wmi_vdev_create_arg arg = {};
 	int bit, ret;
 	u8 tmp_addr[6];
-	u16 nss;
 
 	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
 
@@ -1187,19 +1186,6 @@ static int ath12k_mac_monitor_vdev_create(struct ath12k *ar)
 		return ret;
 	}
 
-	nss = hweight32(ar->cfg_tx_chainmask) ? : 1;
-	ret = ath12k_wmi_vdev_set_param_cmd(ar, ar->monitor_vdev_id,
-					    WMI_VDEV_PARAM_NSS, nss);
-	if (ret) {
-		ath12k_warn(ar->ab, "failed to set vdev %d chainmask 0x%x, nss %d :%d\n",
-			    ar->monitor_vdev_id, ar->cfg_tx_chainmask, nss, ret);
-		return ret;
-	}
-
-	ret = ath12k_mac_txpower_recalc(ar);
-	if (ret)
-		return ret;
-
 	ar->allocated_vdev_map |= 1LL << ar->monitor_vdev_id;
 	ar->ab->free_vdev_map &= ~(1LL << ar->monitor_vdev_id);
 	ar->num_created_vdevs++;
-- 
2.34.1


