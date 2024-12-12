Return-Path: <linux-wireless+bounces-16277-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD7239EDCD8
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Dec 2024 01:51:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23DC4168ABA
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Dec 2024 00:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB80C1E531;
	Thu, 12 Dec 2024 00:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="KdjMv0hP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2128A225D7
	for <linux-wireless@vger.kernel.org>; Thu, 12 Dec 2024 00:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733964575; cv=none; b=DLfHhfz+VGfb14ZRiDsjjeXD7BJwBacdFY093hPWWhtq8QIAp7dgJmvOOePXnEMdoflrwTRazmeNC5qPVp7YU4w0fWeQqG6a8SrUfHpL46JVA+W1P3pXQI4PEtYC2ym7A63hZ2UdtBiU6MLsayCtm7RoL0aBtHpb1LPHQGXTDIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733964575; c=relaxed/simple;
	bh=jr1hU5wx+cCULTdUrNNttLMV3YVicrhs11PROr2lt2w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EQOEx4/a/A9TbNEdEL/Y4TE6jCtmkTio3J6XaC3J6hRGOVsZjx1fol6Tn/eaZoQDWb0V4ZQ12ywjjTMI0rAH7UM4gnltXQdW9dA7fsR8vflhJIpi78uHxj5h3sgLfjr6gFPiBp2amvwc0oPdcCbm8PemddTsBSt0tu1qWA5ttWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=KdjMv0hP; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BBHDDpW010709;
	Thu, 12 Dec 2024 00:49:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	g4bubB7HxTfp2qVzUUWbwlPS9OLKYPj1IaPi0pZsMzc=; b=KdjMv0hPNuJ05mta
	mWIcWXPLMn4iJzrutUl6zwgzrnW7Aw35T4XFBtW2ajtSYveWK9fL/a+RXMDo2sf8
	qqxS8OLSh1jQ37LRo6nndSiwundADDgCzOilSf70DQUkQ6sR9CC08OG11iO+cCNs
	SYIJxc7BHtxU1eWiQHV9nGcZR1FAECfh7oapQcvV/5wu3opqy7K1o43u18zKTL7p
	SAsg6W8ef6C54Sw+BUVhFEtB+kY3AhtuHtIorKO0vpJ1Mfxb6B4068GpYZ8mi4fh
	qqsvBx01H6tXhZQHC9nAnrxFcY97C2iy5bNmCadEkrcovtsw2I1ks3H4XfIjFs5H
	sdP8/g==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43f1xd3e2w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Dec 2024 00:49:30 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BC0nTDM007030
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Dec 2024 00:49:30 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 11 Dec 2024 16:49:28 -0800
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
Subject: [PATCH 4/4] wifi: ath12k: Fix uninitialized variable access in ath12k_mac_allocate() function
Date: Thu, 12 Dec 2024 06:19:06 +0530
Message-ID: <20241212004906.3087425-5-quic_periyasa@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241212004906.3087425-1-quic_periyasa@quicinc.com>
References: <20241212004906.3087425-1-quic_periyasa@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: I87xiaYzMLbomnasFc2kOTq9dVZVG5nL
X-Proofpoint-GUID: I87xiaYzMLbomnasFc2kOTq9dVZVG5nL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 priorityscore=1501 mlxscore=0 clxscore=1015 bulkscore=0 adultscore=0
 suspectscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412120004

Currently, the uninitialized variable 'ab' is accessed in the
ath12k_mac_allocate() function. Initialize 'ab' with the first radio device
present in the hardware abstraction handle (ah). Additionally, move the
default setting procedure from the pdev mapping iteration to the total
radio calculating iteration for better code readability. Perform the
maximum radio validation check for total_radio to ensure that both num_hw
and radio_per_hw are validated indirectly, as these variables are derived
from total_radio. This also fixes the below Smatch static checker warning.

Smatch warning:
ath12k_mac_allocate() error: uninitialized symbol 'ab'

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1

Fixes: a343d97f27f5 ("wifi: ath12k: move struct ath12k_hw from per device to group")
Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 5cdc1c38b049..98b2f853d243 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -10962,8 +10962,20 @@ int ath12k_mac_allocate(struct ath12k_hw_group *ag)
 	u8 radio_per_hw;
 
 	total_radio = 0;
-	for (i = 0; i < ag->num_devices; i++)
-		total_radio += ag->ab[i]->num_radios;
+	for (i = 0; i < ag->num_devices; i++) {
+		ab = ag->ab[i];
+		if (!ab)
+			continue;
+
+		ath12k_mac_set_device_defaults(ab);
+		total_radio += ab->num_radios;
+	}
+
+	if (!total_radio)
+		return -EINVAL;
+
+	if (WARN_ON(total_radio > ATH12K_GROUP_MAX_RADIO))
+		return -ENOSPC;
 
 	/* All pdev get combined and register as single wiphy based on
 	 * hardware group which participate in multi-link operation else
@@ -10976,14 +10988,16 @@ int ath12k_mac_allocate(struct ath12k_hw_group *ag)
 
 	num_hw = total_radio / radio_per_hw;
 
-	if (WARN_ON(num_hw >= ATH12K_GROUP_MAX_RADIO))
-		return -ENOSPC;
-
 	ag->num_hw = 0;
 	device_id = 0;
 	mac_id = 0;
 	for (i = 0; i < num_hw; i++) {
 		for (j = 0; j < radio_per_hw; j++) {
+			if (device_id >= ag->num_devices || !ag->ab[device_id]) {
+				ret = -ENOSPC;
+				goto err;
+			}
+
 			ab = ag->ab[device_id];
 			pdev_map[j].ab = ab;
 			pdev_map[j].pdev_idx = mac_id;
@@ -10995,10 +11009,11 @@ int ath12k_mac_allocate(struct ath12k_hw_group *ag)
 			if (mac_id >= ab->num_radios) {
 				mac_id = 0;
 				device_id++;
-				ath12k_mac_set_device_defaults(ab);
 			}
 		}
 
+		ab = pdev_map->ab;
+
 		ah = ath12k_mac_hw_allocate(ag, pdev_map, radio_per_hw);
 		if (!ah) {
 			ath12k_warn(ab, "failed to allocate mac80211 hw device for hw_idx %d\n",
-- 
2.34.1


