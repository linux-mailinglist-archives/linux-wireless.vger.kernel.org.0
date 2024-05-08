Return-Path: <linux-wireless+bounces-7356-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B6498C05AE
	for <lists+linux-wireless@lfdr.de>; Wed,  8 May 2024 22:29:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0776CB2305F
	for <lists+linux-wireless@lfdr.de>; Wed,  8 May 2024 20:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D12E81DFC5;
	Wed,  8 May 2024 20:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="hxZ6BBpI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67DDC84D39
	for <linux-wireless@vger.kernel.org>; Wed,  8 May 2024 20:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715200178; cv=none; b=CCOprMs1U0xit3LHgOJlGYshHgne1o7N8UnUUJ0PIhQUd1eeKjMt+UQfaByMyESlP7BuTVidksxNxWJxWNlopKy9L3Du8+5F3+W1wdgalHTzAIbjuGCJJovlbTNYPM/T0u786U38MXXs8bD6njbZUI3HpPQwsO4Trcby5supvqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715200178; c=relaxed/simple;
	bh=uD/FxsukXQSeWHJKZPVppa96Q4oKfYWPn3ZLHwF3BBM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mZpcJbqHHWnvo8VYszXWUImlnpFe8XkCdL8IkwjqfK/BAMnX2iRe/TDj4l1ILyBqrG8O+4IJxWA0uOgEUPSWEHQ3W7Mvhb0KAZXkhdVphlQSo453tqnbXLg5az+hIEAmIUCfBEGoWi1dNOrj1K1WXlvJBjom4Ne9FmxlMdC38pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=hxZ6BBpI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 448CXL6g006531;
	Wed, 8 May 2024 20:29:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=jNrDtn27oVxV5kFcxP+0iR2Qf2JJDbM9jTCpvNmplXA=; b=hx
	Z6BBpI5M/fxBRVFeNMTqgBLx+ho+Q2V6Jy6/ulHREFb+hUlbOwx8vEsmxnBkrTGZ
	XOWk3mFEf5ffCy6u4uqxzG7OCQMUqW1+ROgaQgvexyYVUB6cLOKZHaUQeP6ThmXj
	QlXJSDB4GrrwIdHMDiGDjtUpRu6/fhEYExvM6Xt2hHHpYRekLykyFFFnIt2CqGJb
	GMXMEzXE2gMMA/HKOTZaFqwoB7A5lWZyYY5JRyiy+xX8PpSM4/2u6zRgFywIAsnx
	cHHysSndU/6QO59LqM/qXIsfn/IpQ+wNok/Yo82LIJvPGT3fQh4D8UsJPvW+LAI0
	lwVhggKp1vaOx3AaxJww==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y09geh25p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 May 2024 20:29:29 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 448KTOZG002782
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 8 May 2024 20:29:24 GMT
Received: from alokad-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 8 May 2024 13:29:23 -0700
From: Aloka Dixit <quic_alokad@quicinc.com>
To: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
CC: Aloka Dixit <quic_alokad@quicinc.com>,
        Jeff Johnson
	<quic_jjohnson@quicinc.com>
Subject: [PATCH v2 3/9] wifi: ath12k: rename MBSSID fields in wmi_vdev_up_cmd
Date: Wed, 8 May 2024 13:29:06 -0700
Message-ID: <20240508202912.11902-4-quic_alokad@quicinc.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20240508202912.11902-1-quic_alokad@quicinc.com>
References: <20240508202912.11902-1-quic_alokad@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: GwqbT81GaRvVP4WD9MPAfem1wFddC8hF
X-Proofpoint-ORIG-GUID: GwqbT81GaRvVP4WD9MPAfem1wFddC8hF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-08_09,2024-05-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 phishscore=0 malwarescore=0
 mlxlogscore=785 impostorscore=0 clxscore=1015 adultscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405080151

Rename trans_bssid to tx_vdev_bssid to make it similar to vdev_bssid.

Rename profile_num to nontx_profile_cnt, and profile_idx to
nontx_profile_idx which make it clear that these configurations
correspond to nontransmitted MBSSID profiles.

These members are currently unused in the driver.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Signed-off-by: Aloka Dixit <quic_alokad@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/wmi.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
index 86a0ef09aa39..4051ed5a0b0a 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -2768,9 +2768,9 @@ struct wmi_vdev_up_cmd {
 	__le32 vdev_id;
 	__le32 vdev_assoc_id;
 	struct ath12k_wmi_mac_addr_params vdev_bssid;
-	struct ath12k_wmi_mac_addr_params trans_bssid;
-	__le32 profile_idx;
-	__le32 profile_num;
+	struct ath12k_wmi_mac_addr_params tx_vdev_bssid;
+	__le32 nontx_profile_idx;
+	__le32 nontx_profile_cnt;
 } __packed;
 
 struct wmi_vdev_stop_cmd {
-- 
2.39.0


