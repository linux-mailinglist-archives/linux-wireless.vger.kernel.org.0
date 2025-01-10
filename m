Return-Path: <linux-wireless+bounces-17277-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E04E4A0862B
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jan 2025 05:26:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC0247A2262
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jan 2025 04:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A099205E35;
	Fri, 10 Jan 2025 04:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="GU+a4U9C"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C1B1E32C5
	for <linux-wireless@vger.kernel.org>; Fri, 10 Jan 2025 04:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736483165; cv=none; b=V6EPIWmk64fY1IPpmDmidaYovpssZP60a7u3W34D2PPtbq930A2AlMBnzj4RdsN7qhcgjdqMMLlGYl/l487woYVW4QbDd/3gpssAhnZsmiXbsmHklqFyROY5rFC+JqPNfchTPhqcwTugaGGBa6ymocwGZKo1eVWn1M+hpRS6ICU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736483165; c=relaxed/simple;
	bh=HfPcIyw/R8RqLH53BqGALZn9JN+wvIdSTchRnyyjvuY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X3dnYaQNx4wsB+4ezO7nBbpRJV2WgF2yXhIvnVRDCRvUMFMHrxV1lm5OhSsxdHVwjAbHI9URU7xd2DWbRajx+aWquGu2kpsrFPZfHK3ufVzDIp82ozeOJuTcvVeiSuFUGSbcYhM6NkUF3hvHUG7Ija/PvALVmbFCP+NqQmR/H9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=GU+a4U9C; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 509HItus012233;
	Fri, 10 Jan 2025 04:25:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fADG9n2TNBBTpZ+OMHAaVomwc1MUgWg3dEIiNgaCLZc=; b=GU+a4U9CRjx/OD+n
	ETo41PI7lN0HYdTHApNO74cnRlaUzT8oiSMemYigyQBDerXkYkE4tuQj/VxDAB6C
	yofEz2hHGwQkkz0OEB9e5RDKQlHtHOFxO/Yh1bzXGcuFH3hHUa0I4Rd9+dep9rvW
	uKdUD6aKAbeTtKVEdMsBgyqgHjB/kZUPEzZlqgJCIaveEeRA+n3mL5UqEiolmLyS
	nR+f0LGxmzmf7D67mCS+nAYT5Xwl/GW5QoTjcYIrOWxDohQRofppifob3e3rlcCy
	TIlVSRLNs5YknYkqAn6cEcSjpNQsveIw0dl7agGhAeUIbMQR4IsdUQ3CRmo3FSKT
	0wArgg==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 442jra98ws-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jan 2025 04:25:50 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50A4PnTv004748
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jan 2025 04:25:49 GMT
Received: from hu-sarishar-blr.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 9 Jan 2025 20:25:48 -0800
From: Sarika Sharma <quic_sarishar@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Sarika Sharma
	<quic_sarishar@quicinc.com>
Subject: [PATCH RFC 7/7] wifi: ath12k: correctly fetch arsta for MLO
Date: Fri, 10 Jan 2025 09:54:49 +0530
Message-ID: <20250110042449.1158789-8-quic_sarishar@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250110042449.1158789-1-quic_sarishar@quicinc.com>
References: <20250110042449.1158789-1-quic_sarishar@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: zyYeKhJXLMXQFN1X6HdO77yoUK_zbLje
X-Proofpoint-ORIG-GUID: zyYeKhJXLMXQFN1X6HdO77yoUK_zbLje
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 impostorscore=0
 phishscore=0 mlxscore=0 bulkscore=0 spamscore=0 clxscore=1015
 mlxlogscore=515 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2501100034

Currently in ath12k_mac_op_link_sta_statistics(), link sinfo structure
is filled from arsta structure and arsta is fetched from ahsta->deflink.
For both non-ML and multi-link operation (MLO), deflink is used. While
this is correct for non-ML, but the corresponding link_id should be
used for MLO.

Therefore, add support for MLO by taking the link_id from the
link_sinfo structure, fetching arsta from ahsta->link[link_id], and
filling the link_sinfo structure if valid_links.

NOTE:
 - Currently ath12k changes are only included as an reference to other
   drivers.

Signed-off-by: Sarika Sharma <quic_sarishar@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index ebde8a604eec..1bafda3c83aa 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -9902,11 +9902,18 @@ static void ath12k_mac_op_link_sta_statistics(struct ieee80211_hw *hw,
 					      struct link_station_info *link_sinfo)
 {
 	struct ath12k_sta *ahsta = ath12k_sta_to_ahsta(sta);
+	int link_id = link_sinfo->link_id;
 	struct ath12k_link_sta *arsta;
 
 	lockdep_assert_wiphy(hw->wiphy);
 
-	arsta = &ahsta->deflink;
+	if (link_id < 0)
+		arsta = &ahsta->deflink;
+	else
+		arsta = wiphy_dereference(hw->wiphy, ahsta->link[link_id]);
+
+	if (!arsta)
+		return;
 
 	link_sinfo->rx_duration = arsta->rx_duration;
 	link_sinfo->filled |= BIT_ULL(NL80211_STA_INFO_RX_DURATION);
-- 
2.34.1


