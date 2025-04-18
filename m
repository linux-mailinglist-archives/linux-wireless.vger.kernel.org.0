Return-Path: <linux-wireless+bounces-21713-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4156AA9322D
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Apr 2025 08:40:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 026FC447E14
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Apr 2025 06:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B494269B08;
	Fri, 18 Apr 2025 06:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="T9VjrQ5l"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B099268FF8
	for <linux-wireless@vger.kernel.org>; Fri, 18 Apr 2025 06:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744958429; cv=none; b=KoM9PjL9l/rPfmsQ9MwoSuaEk9SA1bGvqxXgqqFRAOHhVgkjQ7uxmfq+x8NgS2SML2Xvs3e/8LauiAFB6IpeURX1g5SZG4Xnlq0p4P/OwnbaaxJ1NzbL6YQpGPx4wNzlAe7We/69b5EZZOfKaX2YfsUhEeaWMatLhiv4HnH/Tww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744958429; c=relaxed/simple;
	bh=zF/kYJe3/uRURJGNrqIJDdsF6MeMHcX44Bkwkc8S3ac=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=s3hYUyxhjBumYYsJPUMMYK/5XDTqpux/+OwJUi+nsb8IC/AwS+DgagYjmiVhMdFIfSKYmFN7ZYAaerFyV3yrP/uWbfEyyCwMrnjCOT+BLc00iA8Y70gUJqDL+BLY66lGEGVwYTD3VdYz1BKuq7KT1J58sM+3pj9n6G6y7KjrvMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=T9VjrQ5l; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53I2Opsa015703;
	Fri, 18 Apr 2025 06:40:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=oSvFrgXmoUZ6yZ/lnrkYok
	0/n3BW+BgueyQTjm6pGRA=; b=T9VjrQ5lRsOhXHdn/iZ1UNLpsWMzfb2nx3UwUz
	edhJ/g1WDhHHf+M0fQhO0sbe42DRZu0Iup0DVN1n4lCnyU71sWDN4zZN1DMJ63Kf
	DrZU3nMQE+vDdRSzI3iJMiH5dGM6ScnbrkAqwHweT6SzHMEEo8p9nkjIBz9/4ktA
	5fR3qmAeOrJTa5OtQVbkktjlVRaTERcHHGf8Qqq83eLr81N4JqGSFihr9mMhpYPO
	1GtZa9srAQ5uo4+Pw41osIgWnfMOzD2GEhvkwRWhhGM6Jr1576l7RHEWuSEmVTEt
	s+FO9W3YZvxVKRZA5HWJYlVI38ZAJla79wezQdhqKBLpiohA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45ydhqhdw7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Apr 2025 06:40:23 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53I6eMrA024860
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Apr 2025 06:40:22 GMT
Received: from lingbok-Birman-PHX.qca.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 17 Apr 2025 23:40:20 -0700
From: Lingbo Kong <quic_lingbok@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_lingbok@quicinc.com>
Subject: [PATCH ath-next v3] wifi: ath12k: Abort scan before removing link interface to prevent duplicate deletion
Date: Fri, 18 Apr 2025 14:40:08 +0800
Message-ID: <20250418064008.7172-1-quic_lingbok@quicinc.com>
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
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: V21cDWxniPq2NoDX3RXAqoHuQ8tMjKIE
X-Authority-Analysis: v=2.4 cv=C7DpyRP+ c=1 sm=1 tr=0 ts=6801f3d7 cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=yPCof4ZbAAAA:8 a=Xb9ag2Io4QILRE6B9DEA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: V21cDWxniPq2NoDX3RXAqoHuQ8tMjKIE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-18_02,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 priorityscore=1501 suspectscore=0 clxscore=1015 spamscore=0 bulkscore=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0 mlxscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504180047

Currently, when ath12k performs the remove link interface operation, if
there is an ongoing scan operation on the arvif, ath12k may execute the
remove link interface operation multiple times on the same arvif. This
occurs because, during the remove link operation, if a scan operation is
present on the arvif, ath12k may receive a WMI_SCAN_EVENT_COMPLETED event
from the firmware. Upon receiving this event, ath12k will continue to
execute the ath12k_scan_vdev_clean_work() function, performing the remove
link interface operation on the same arvif again.

To address this issue, before executing the remove link interface
operation, ath12k needs to check if there is an ongoing scan operation on
the current arvif. If such an operation exists, it should be aborted.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Lingbo Kong <quic_lingbok@quicinc.com>
Tested-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index d170bca72948..fca004e8564b 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -9846,6 +9846,11 @@ ath12k_mac_op_unassign_vif_chanctx(struct ieee80211_hw *hw,
 		reinit_completion(&ar->completed_11d_scan);
 		ar->state_11d = ATH12K_11D_PREPARING;
 	}
+
+	if (ar->scan.arvif == arvif && ar->scan.state == ATH12K_SCAN_RUNNING) {
+		ath12k_scan_abort(ar);
+		ar->scan.arvif = NULL;
+	}
 }
 
 static int

base-commit: 75f90ba47b2cda7de7a7bc1d099172516f6f96fa
-- 
2.34.1


