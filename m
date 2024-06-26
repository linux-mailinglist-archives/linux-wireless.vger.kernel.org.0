Return-Path: <linux-wireless+bounces-9568-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FA93917646
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Jun 2024 04:43:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99E14B224E5
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Jun 2024 02:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4218128DDF;
	Wed, 26 Jun 2024 02:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="IHQFfkgx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEACD1BDEF;
	Wed, 26 Jun 2024 02:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719369809; cv=none; b=iGD/lWkKT62+nlkolnRLAL2vKZw1pbzJ9+F4pajMo7loHqWaU143BDjs/RcGUqa8NqGhyC5yjWV/QXp5uTEw0CCfFQE1auyvheqRApWzs1aqDgruuBxt74jLaNZ34WEk4ywn4jFlOndNvGM58UGs4hU71ft9+txswZhxiGotVLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719369809; c=relaxed/simple;
	bh=tENRBAG6a/mGJwoN6dM8cGDn5bpECFamtPDl9D/bn7o=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Nvkh4AtD0pL3X1grBsji6SzGcljrcX/L6E74NVVcCWi5eGuDbfciJ53q8I1qDjQzekQpelueKIqa76OyDjCJ7+ZY/qpBvSTQSVcYzKP9GAsuZPIPxTMHLIOG3tZlgqR2o5tUMP1iiFFRKkzukYOt+XSdF7OxS1CrE8rx2XFg0VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=IHQFfkgx; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45PGkooH020273;
	Wed, 26 Jun 2024 02:43:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=JZaL+Uz4Gft+NTwOiNV1nm
	xyKgDdx04JKJFeZgGRb2s=; b=IHQFfkgxTe9vm4fRLWyfE65oH8ep6f8G3sRaMp
	rOT8sW8CjNE2f+Qi4a0M8VuLP1VgpVe5T2lSYjGsNl0EBSr5+u/Vlhz7Vm164+qs
	pLxsOnM4T/PefiZS32c3ElhPkRNpKnuObrfBfpb5jnQBt2dsaGybsVUCZYDC+zhw
	rvtJOrzPRKE8+L83dZYBemXitd0TY1ghV0SyYmazdZdqvrJGNlZvAo3EjX6uLYtW
	VR5IKDrvbT43mNID6ZmJgMcqTi67zcrvBLUY9tnY62dCx3DxoUD0/ezbHKnCWTQz
	mjrhjLB0Ri7pu+Z3kmhRbBkh8TIw3vnKUlTU9BOBkupJ9ceg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ywp6yr5jg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Jun 2024 02:43:21 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45Q2hKlv025955
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Jun 2024 02:43:20 GMT
Received: from hu-ramess-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 25 Jun 2024 19:43:18 -0700
From: Rameshkumar Sundaram <quic_ramess@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Rameshkumar Sundaram
	<quic_ramess@quicinc.com>,
        <stable@vger.kernel.org>
Subject: [PATCH] wifi: ath12k: Allow driver initialization for WoW unsupported devices
Date: Wed, 26 Jun 2024 08:12:57 +0530
Message-ID: <20240626024257.709460-1-quic_ramess@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 6TvUo3_tAQEJWjqD_o3y_ja8Jvee9WZi
X-Proofpoint-ORIG-GUID: 6TvUo3_tAQEJWjqD_o3y_ja8Jvee9WZi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-26_01,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=826 bulkscore=0
 phishscore=0 adultscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 clxscore=1011 lowpriorityscore=0 spamscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406260020

Currently during driver initialization, mac registration is allowed
only for devices that advertise WMI_TLV_SERVICE_WOW, but QCN9274
doesn't support WoW and hence mac registration is aborted and driver
is de-initialized.

Allow mac registration to proceed without WoW Support for devices
that don't advertise WMI_TLV_SERVICE_WOW.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Cc: stable@vger.kernel.org
Fixes: 4a3c212eee0e ("wifi: ath12k: add basic WoW functionalities")
Signed-off-by: Rameshkumar Sundaram <quic_ramess@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/wow.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/wow.c b/drivers/net/wireless/ath/ath12k/wow.c
index 685e8e98d845..c5cba825a84a 100644
--- a/drivers/net/wireless/ath/ath12k/wow.c
+++ b/drivers/net/wireless/ath/ath12k/wow.c
@@ -1001,8 +1001,8 @@ int ath12k_wow_op_resume(struct ieee80211_hw *hw)
 
 int ath12k_wow_init(struct ath12k *ar)
 {
-	if (WARN_ON(!test_bit(WMI_TLV_SERVICE_WOW, ar->wmi->wmi_ab->svc_map)))
-		return -EINVAL;
+	if (!test_bit(WMI_TLV_SERVICE_WOW, ar->wmi->wmi_ab->svc_map))
+		return 0;
 
 	ar->wow.wowlan_support = ath12k_wowlan_support;
 

base-commit: dadc1101eabb54ace51aa6fc58c902bf43ac0ed7
-- 
2.25.1


