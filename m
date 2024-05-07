Return-Path: <linux-wireless+bounces-7266-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE1918BDA71
	for <lists+linux-wireless@lfdr.de>; Tue,  7 May 2024 07:00:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB46DB25997
	for <lists+linux-wireless@lfdr.de>; Tue,  7 May 2024 05:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EA226A8C1;
	Tue,  7 May 2024 04:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="jn1oqI9I"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4ED17CF33
	for <linux-wireless@vger.kernel.org>; Tue,  7 May 2024 04:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715057868; cv=none; b=FexPp1jQoHzMJFlsmc5/kkGKljOXHmSXlZlGgO2EylWr74ErPpfHAEODbbv0C9zR08Saikc1QwjWsh7Tr33yVoCy2538ojxigYLUJw18ON81XDuSFCrRehtZ7LvHz0KvhvIpXx6tKQJZ5LTDrVtSz7abnZb/Cu1plSCMd0SGAso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715057868; c=relaxed/simple;
	bh=Z7MCuUVg/N9CtaFTTOFZVGy9sO3a2ZI+XYywsXx/H0Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QWQWN/1SjyVADgiylMO2LMj8wkKLZpVvpnBlJeOSV3hhMW/uI0E4Za6woI6PB5xD2IOp2nyX9lHS+LuapN6WUcGb8UjDIjhzK7stgTL+AFkROzxfoY4PKygSl16dQjRPw1VCnE3Pqe3tak3CC1tZefB359uv8D7G5ho5YEo/ldQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=jn1oqI9I; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4474TwUp017216;
	Tue, 7 May 2024 04:57:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=qcppdkim1; bh=4v6AGBl
	zBUsb2583+c8yEcosQ2QkwG19GKVzZSugUzc=; b=jn1oqI9IJyQFBWqL0hK0FCb
	p+mUj1BT2Hj2kUvweIxJj1CXKROmneysXlp9NgVBEdEumFo7DdoRkCLiyZo/ZcZa
	TE4zpQiOycnWtyhEHcmzsJU00mYAX0wRUdlLuLM1dFcyxeH8G1dVIt4tMk8D533q
	NWf/HtSlTa0eABHxG2kURMyilmJZMuuWmRHOZo2WV9dejzT/wmQpQZcjCdhDVNu0
	d7EFcOYsOprKmtujPP2P3S0Jj6ea5mL9AHiWAtb3heZ9IyiXGapAX1UevhFbx7SY
	5UJx3nTgwVmud8viasHwEILpZPD5wQyAONEevqEaQBb9UJb6NbpU0Fk8zJOX91Q=
	=
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xy1vw9a4p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 May 2024 04:57:43 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 4474veip004180;
	Tue, 7 May 2024 04:57:40 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 3xwe3kn526-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 May 2024 04:57:39 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4474vduW004168;
	Tue, 7 May 2024 04:57:39 GMT
Received: from hu-devc-blr-u22-a.qualcomm.com (hu-hprem-blr.qualcomm.com [10.190.108.75])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 4474vdsx004167
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 May 2024 04:57:39 +0000
Received: by hu-devc-blr-u22-a.qualcomm.com (Postfix, from userid 4146166)
	id F336D4114D; Tue,  7 May 2024 10:27:38 +0530 (+0530)
From: Harshitha Prem <quic_hprem@quicinc.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        Harshitha Prem <quic_hprem@quicinc.com>
Subject: [PATCH v4 5/8] wifi: ath12k: move ATH12K_FLAG_REGISTERED flag set to mac_register api
Date: Tue,  7 May 2024 10:26:59 +0530
Message-Id: <20240507045702.2858954-6-quic_hprem@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240507045702.2858954-1-quic_hprem@quicinc.com>
References: <20240507045702.2858954-1-quic_hprem@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: t_vU-6IfPumf0e6pWGmMbjRZSrUmSrqR
X-Proofpoint-GUID: t_vU-6IfPumf0e6pWGmMbjRZSrUmSrqR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-07_02,2024-05-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 malwarescore=0 adultscore=0 clxscore=1015 priorityscore=1501
 mlxlogscore=999 impostorscore=0 mlxscore=0 spamscore=0 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2405070033

From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>

When hardware device group abstraction is introduced, in future, a group
abstraction is registered to mac80211 rather than a particular device.
Hence, setting ATH12K_FLAG_REGISTERED in QMI firmware ready event might not
be ideal.

Add changes to move set/unset of ATH12K_FLAG_REGISTERED flag inside
ath12k_mac_register() and ath12k_mac_unregister() respectively.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Signed-off-by: Harshitha Prem <quic_hprem@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 2 ++
 drivers/net/wireless/ath/ath12k/qmi.c | 4 +---
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 2e0bd7cfc7bf..ada4569fbff4 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -8893,6 +8893,7 @@ int ath12k_mac_register(struct ath12k_base *ab)
 			goto err;
 	}
 
+	set_bit(ATH12K_FLAG_REGISTERED, &ab->dev_flags);
 	return 0;
 
 err:
@@ -8912,6 +8913,7 @@ void ath12k_mac_unregister(struct ath12k_base *ab)
 	struct ath12k_hw *ah;
 	int i;
 
+	clear_bit(ATH12K_FLAG_REGISTERED, &ab->dev_flags);
 	for (i = ath12k_get_num_hw(ab) - 1; i >= 0; i--) {
 		ah = ath12k_ab_to_ah(ab, i);
 		if (!ah)
diff --git a/drivers/net/wireless/ath/ath12k/qmi.c b/drivers/net/wireless/ath/ath12k/qmi.c
index 19a03cf8c391..b3a8459ab4e5 100644
--- a/drivers/net/wireless/ath/ath12k/qmi.c
+++ b/drivers/net/wireless/ath/ath12k/qmi.c
@@ -3333,11 +3333,9 @@ static void ath12k_qmi_driver_event_work(struct work_struct *work)
 				  &ab->dev_flags);
 			clear_bit(ATH12K_FLAG_RECOVERY, &ab->dev_flags);
 			ret = ath12k_core_qmi_firmware_ready(ab);
-			if (!ret) {
+			if (!ret)
 				set_bit(ATH12K_FLAG_QMI_FW_READY_COMPLETE,
 					&ab->dev_flags);
-				set_bit(ATH12K_FLAG_REGISTERED, &ab->dev_flags);
-			}
 
 			break;
 		default:
-- 
2.34.1


