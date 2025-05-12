Return-Path: <linux-wireless+bounces-22863-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18AF8AB3029
	for <lists+linux-wireless@lfdr.de>; Mon, 12 May 2025 08:59:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8938A3A702B
	for <lists+linux-wireless@lfdr.de>; Mon, 12 May 2025 06:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC991B0434;
	Mon, 12 May 2025 06:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="GWnK2/Rj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C529259C
	for <linux-wireless@vger.kernel.org>; Mon, 12 May 2025 06:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747033185; cv=none; b=soT7ngF7nDen+IDclR54FGVoN1vZhH31veMpj69X8n5vLDYRo+K5W0vEBAtSStaqYKWUtDh1N1GbFbGjT3LUL9DQ8sddepH1ZTA/c8mZ1Cyy/+lOQ7KE5qKd2kx1k3Z4fav5rsDXKG9yYtN21Z8rAOTfqrTim0Ppl1iaKeFU7ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747033185; c=relaxed/simple;
	bh=Y/rrfysoxeDcgCjH5v5FkYyVONXs7biMZBfreP+0/X8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MQxnfePql7mK4bQ7+mHoQ7kqUcipP0AsIV5UI2gKizQRAFStI8Ul7wOwdaqA1Ud5tc7VuqTODOA8J4a7WQRnbG0fgzcQ41EJqwYqABLEL9/ndXyGPXy4e1vHlb3lPXnYBz75ANKME0fmVoFF5F2anekbCaoaJdZyNzvA1PtCVbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=GWnK2/Rj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54C06cjH031462;
	Mon, 12 May 2025 06:59:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=N6EFIMFrkjfiGZ4uCgxNtU
	2JG99itvrATn2wS6zRAws=; b=GWnK2/RjMDZWaU3ZBZ2lnDqvcuDnP8vbBH8noF
	h1VcNFke0s8As9R7ZUcryd5pSfh246LuoTT7sjcuD0CPLCRN4/lYllxEmh7s2QUF
	bSQ/wahC8kFkoG+VbzbTls0FHeolpE0J9k+SeFODKkJHqfgrqrSY4jSrtjs7i4sp
	EO1ANqcYyybu/h7ogkdVW5m2TA9IbDh1jTs0RhFNdENmoJFKu1uskC77MgvXj0r+
	kgobZKFkGg45LaM8u1hjcR4hSCCyvc8ZxcqA2fDuI/LrX+Ltht530WCByCU1h0As
	QjPp+OA72Lq2H2d79ryzatv24M1U13jCdSnaOfOz3XM0v8xw==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46hvghbk5b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 May 2025 06:59:39 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 54C6xcan003811
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 May 2025 06:59:38 GMT
Received: from hu-vignc-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sun, 11 May 2025 23:59:37 -0700
From: Vignesh C <quic_vignc@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Vignesh C <quic_vignc@quicinc.com>
Subject: [PATCH ath-next] wifi: ath12k: Fix scan initiation failure handling
Date: Mon, 12 May 2025 12:28:49 +0530
Message-ID: <20250512065849.2833232-1-quic_vignc@quicinc.com>
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
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: gNe3UMECcwwwmk4dEAz0qMjv9UdfzM2G
X-Proofpoint-ORIG-GUID: gNe3UMECcwwwmk4dEAz0qMjv9UdfzM2G
X-Authority-Analysis: v=2.4 cv=AMDybF65 c=1 sm=1 tr=0 ts=68219c5b cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=dt9VzEwgFbYA:10 a=COk6AnOGAAAA:8 a=VIDGliHIJPvldr3RAkwA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEyMDA3MiBTYWx0ZWRfX8eQ8Alu3Em3T
 tJXK+QhHDFMh4v0XzEkxFCetbXpMhjz6UJwBpqP4bR3zl8v/nqm5CiHfPLCdq6MOEPs/2YwZzdT
 KKijDZM2KNU/3DGSaBwI6ED0LXj9ViuKM4YTZuJ3rTMQyf3Xjlp6LWq74FL5v+b9izX1/OX33ZA
 HKIjCRoJ52gikZCSAr4GXPb4uL5ITvb8vb61tI5xJGzPs7gMzZKp97bVOYvMQSz67pYgx9fPAfX
 J+arhLcW84CLJ9xobxFF0VayNAdVS8vUP7zrJvHSwPHfCNBRQk0OCETBcSzbLTYPkbgup8oTdLC
 uo2zUXMnCwF8vFXBYMCJCQ3pXML3fqWjubp9xQ6KPlu0+Y2VO/fCFWHj3PfJazfJ9CdZGTAbpku
 G05zQU/zAztDFyEzFBYPTdv6WW5fV/iNIaHCq6oC7ecyZh5AdRVmlRLzh6n0QcwNq0tcx6si
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-12_02,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 spamscore=0 priorityscore=1501 adultscore=0 impostorscore=0
 phishscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 mlxscore=0
 mlxlogscore=999 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505120072

During a code review, it is observed that in the scenario
where scan initiation fails, the current code schedules the
ar->scan.timeout workqueue which is not necessary.

In the scan initiation failure scenario, exit the code instead
of scheduling the ar->scan.timeout workqueue.

Compile tested only.

Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
Signed-off-by: Vignesh C <quic_vignc@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 4dae941c9615..0cf2b3d06c3b 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -4647,6 +4647,7 @@ static int ath12k_mac_op_hw_scan(struct ieee80211_hw *hw,
 		spin_lock_bh(&ar->data_lock);
 		ar->scan.state = ATH12K_SCAN_IDLE;
 		spin_unlock_bh(&ar->data_lock);
+		goto exit;
 	}
 
 	ath12k_dbg(ar->ab, ATH12K_DBG_MAC, "mac scan started");

base-commit: 3a64d6def8733e75909abcfab983efae92dc4102
-- 
2.34.1


