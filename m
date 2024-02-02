Return-Path: <linux-wireless+bounces-2979-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C5D88465ED
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Feb 2024 03:36:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A26A628357A
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Feb 2024 02:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94F81BE59;
	Fri,  2 Feb 2024 02:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="m9DnQpUg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934EDBE5C
	for <linux-wireless@vger.kernel.org>; Fri,  2 Feb 2024 02:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706841381; cv=none; b=DBu4Mc3kuHJMMBimbo9fhGxuJQQjaUeTsIAIS+xOwfj7bV/1BR/zWSmBN9GDZgJ0MKC2rKhB1Fy158no3V/5uwFhm3s1BXio3pjXef2wyT+YiSGNPNs8qMykMb/oYct3WNBXF9vZhs4HFc6k9ID8SmPGZGOyj46ysvHq118X0ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706841381; c=relaxed/simple;
	bh=ZwDnTA+yALwLJdCTOYRgr354U16FcTT1KB1S6bvJqXs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kfzsxeaet1Wv+SirR8D5g/70auYoX0M8kkLTqHBnmb7p+PCvdKv4oP6kmPtpyYXgi+FEE3FZoFK1VfjmphRuyL6mOOMBZ63+g+HegLKsLHnVtkzBhLa6JKqrLnyxPurlcRJms2TpfxS6hy01+my1wVQYoYVaN8LvG1V42qtcEx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=m9DnQpUg; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4122IJB2027530;
	Fri, 2 Feb 2024 02:36:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=ALH7s/K
	Pki3oSi9AzApjxN2Bp7leFa3xByFm5jAbAxw=; b=m9DnQpUg86QJFUCRWaF1A7J
	kpvzewCoOk3XL1ViUnysLato6zlFhSVB/kNCF6gLBf5etg46V40DFH2iX4E7SKOv
	0m/XDSoC8ZqTYnoMXviOrhFVixblHJTH+xm6DOQEzakp7vR0VvsXBvk4iK74x9SF
	XakB4t3BBJl8QJTGa9yctpjOLLAqXatbi32lZfsEyTS7k7Ejh6lyrXaJuGEZn7VJ
	ATzj7UECWq9p8pyKj+oFmQHI6MjbJ+wjCf0OL1VZboQKmTCBTi8Ow9abjvXPtXVg
	EhxxygWwfwt81A7R87kMFUQc2KVE8/nozu17PkCzVD63Cm8n8PQ6WCN9zW0UBEA=
	=
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w0pu4g32c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Feb 2024 02:36:15 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4122aEdE002431
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 2 Feb 2024 02:36:14 GMT
Received: from bqiang-SFF.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 1 Feb 2024 18:36:12 -0800
From: Baochen Qiang <quic_bqiang@quicinc.com>
To: <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_bqiang@quicinc.com>
Subject: [PATCH] wifi: ath11k: initialize rx_mcs_80 and rx_mcs_160 before use
Date: Fri, 2 Feb 2024 10:35:47 +0800
Message-ID: <20240202023547.11141-1-quic_bqiang@quicinc.com>
X-Mailer: git-send-email 2.25.1
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
X-Proofpoint-GUID: AyjsI91anBgS2Z4B_6rNeInZbOz41g7v
X-Proofpoint-ORIG-GUID: AyjsI91anBgS2Z4B_6rNeInZbOz41g7v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-01_10,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 mlxscore=0 malwarescore=0 phishscore=0 lowpriorityscore=0
 mlxlogscore=680 clxscore=1015 bulkscore=0 spamscore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402020016

Currently in ath11k_peer_assoc_h_he() rx_mcs_80 and rx_mcs_160
are used to calculate max_nss, see
	if (support_160)
		max_nss = min(rx_mcs_80, rx_mcs_160);
	else
		max_nss = rx_mcs_80;

Kernel test robot complains on uninitialized symbols:
drivers/net/wireless/ath/ath11k/mac.c:2321 ath11k_peer_assoc_h_he() error: uninitialized symbol 'rx_mcs_80'.
drivers/net/wireless/ath/ath11k/mac.c:2321 ath11k_peer_assoc_h_he() error: uninitialized symbol 'rx_mcs_160'.
drivers/net/wireless/ath/ath11k/mac.c:2323 ath11k_peer_assoc_h_he() error: uninitialized symbol 'rx_mcs_80'.

This is because there are some code paths that never set them, so
the assignment of max_nss can come from uninitialized variables.
This could result in some unknown issues since a wrong peer_nss
might be passed to firmware.

Change to initialize them to an invalid value at the beginning. This
makes sense because even max_nss gets an invalid value, due to either
or both of them being invalid, we can get an valid peer_nss with
following guard:
	arg->peer_nss = min(sta->deflink.rx_nss, max_nss)

Tested-on: WCN6855 hw2.1 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.23

Fixes: 3db26ecf7114 ("ath11k: calculate the correct NSS of peer for HE capabilities")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202401311243.NyXwWZxP-lkp@intel.com/
Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/mac.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index bbf4d1f4d310..299f4f3d7659 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -2294,6 +2294,8 @@ static void ath11k_peer_assoc_h_he(struct ath11k *ar,
 	mcs_160_map = le16_to_cpu(he_cap->he_mcs_nss_supp.rx_mcs_160);
 	mcs_80_map = le16_to_cpu(he_cap->he_mcs_nss_supp.rx_mcs_80);
 
+	/* Initialize rx_mcs_160 to 9 which is an invalid value */
+	rx_mcs_160 = 9;
 	if (support_160) {
 		for (i = 7; i >= 0; i--) {
 			u8 mcs_160 = (mcs_160_map >> (2 * i)) & 3;
@@ -2305,6 +2307,8 @@ static void ath11k_peer_assoc_h_he(struct ath11k *ar,
 		}
 	}
 
+	/* Initialize rx_mcs_80 to 9 which is an invalid value */
+	rx_mcs_80 = 9;
 	for (i = 7; i >= 0; i--) {
 		u8 mcs_80 = (mcs_80_map >> (2 * i)) & 3;
 

base-commit: d4d13947306ab3c98c84389d9397563b550b71b8
-- 
2.25.1


