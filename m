Return-Path: <linux-wireless+bounces-2318-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6B4C836243
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jan 2024 12:43:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 264161C26CB2
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jan 2024 11:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3BC23D966;
	Mon, 22 Jan 2024 11:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="c7Zic3Km"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049D93D54F
	for <linux-wireless@vger.kernel.org>; Mon, 22 Jan 2024 11:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705923577; cv=none; b=iKLEu2MOsllXp3hgJWlqJ+tzOjAyC2ftG/EEKn/nWKzPc3kb/xKv1FLgtdIY/e0lSBz8SgCLpEgpfK0vjylIC/fNmY7DDAc1lzP6QgL7bnqzZ0VmtHJwgcaOXDw7AHKX35gtmTZY6sqPqCmgecTCVbLhrV13YdSK2q85uuy5vE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705923577; c=relaxed/simple;
	bh=9Jgn6eWm4y01GoskfWLgsnO1iZgfMrAAoaSwg9M1wQ0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pgAQS3MLU5yroOHbCzapblPZYkMWhDHMQGl31dMmLiP52OtxbAe8g79qr59221vAbKWwoF9sc+5w+hCFyebatMc54J8McVx+jTgOGeoYiec0g/HzQIy7LnE8q0BBt5bhgBNsVYfzRj1NlLuHdBr45boQj4Z8fBTnBkNnVEBmLM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=c7Zic3Km; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40MBHutd011392;
	Mon, 22 Jan 2024 11:39:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=bLMbXqIBFzF79RkeYAm6rAhM4kvyQLCj9ljygdEh0PU=; b=c7
	Zic3KmKuC4593wQdKQ6gkD3JqMbKCWqQbPsVAIHg5YG5HGO+NgxSUT4kQu2lHDeR
	je1+4PUsuQdhC+0iWRafvcKiTZr8l6Zm2q9UWuDXkSL9FeDHICzTr5QKx+t62qNc
	oe210s5RVRqNZX0A+2q4q3kBg3fUk/CozkFHrfzyn7/t6fPUz7bBdqYXxQP+SGqE
	UtvNtCaTh0rvJ0w3t+1r06AmKPVRjgr0o8MW510M2gIjCXrm1YsyIR4nCNV8dUIM
	EDSNYQEfgQqgE+ZgiHS9BrGpkil6wrgpgF9HnIR+Fa5sJ3PZnobsKxQFn2UkC3L6
	JFLHZ/ms23ygZGgjw0Hg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vsn0wrccn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jan 2024 11:39:32 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40MBdVVk025379
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jan 2024 11:39:31 GMT
Received: from yk-E5440.qca.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 22 Jan 2024 03:39:30 -0800
From: Kang Yang <quic_kangyang@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_kangyang@quicinc.com>
Subject: [PATCH v3 05/10] wifi: ath12k: change WLAN_SCAN_PARAMS_MAX_IE_LEN from 256 to 512
Date: Mon, 22 Jan 2024 19:38:59 +0800
Message-ID: <20240122113904.8938-6-quic_kangyang@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240122113904.8938-1-quic_kangyang@quicinc.com>
References: <20240122113904.8938-1-quic_kangyang@quicinc.com>
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
X-Proofpoint-ORIG-GUID: sFl11mV9xL-9IwqVWo2NPO1oMYPQtg_H
X-Proofpoint-GUID: sFl11mV9xL-9IwqVWo2NPO1oMYPQtg_H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-22_02,2024-01-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 phishscore=0 mlxscore=0 lowpriorityscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 clxscore=1015 suspectscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401220083

Mac80211 needs more space for P2P scan ie in P2P mode, 256 is not
enough, resize it to 512.

Also delete the duplicate macro definitions in wmi.h.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
---

v3: no change.
v2: add Tested-on tag of QCN9274.

--
 drivers/net/wireless/ath/ath12k/wmi.h | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
index 0b8203bb5381..0efed12dd7ab 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -168,10 +168,6 @@ struct wmi_tlv {
 #define WLAN_SCAN_MAX_HINT_BSSID         10
 #define MAX_RNR_BSS                    5
 
-#define WLAN_SCAN_PARAMS_MAX_SSID    16
-#define WLAN_SCAN_PARAMS_MAX_BSSID   4
-#define WLAN_SCAN_PARAMS_MAX_IE_LEN  256
-
 #define WMI_APPEND_TO_EXISTING_CHAN_LIST_FLAG 1
 
 #define WMI_BA_MODE_BUFFER_SIZE_256  3
@@ -3146,7 +3142,7 @@ struct ath12k_wmi_element_info_arg {
 
 #define WLAN_SCAN_PARAMS_MAX_SSID    16
 #define WLAN_SCAN_PARAMS_MAX_BSSID   4
-#define WLAN_SCAN_PARAMS_MAX_IE_LEN  256
+#define WLAN_SCAN_PARAMS_MAX_IE_LEN  512
 
 /* Values lower than this may be refused by some firmware revisions with a scan
  * completion with a timedout reason.
-- 
2.34.1


