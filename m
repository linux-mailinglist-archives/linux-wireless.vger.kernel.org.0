Return-Path: <linux-wireless+bounces-2761-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB07D841ACF
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jan 2024 05:04:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 749EE288DDC
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jan 2024 04:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A22F381CC;
	Tue, 30 Jan 2024 04:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="J7GgQfmZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2CB381BA
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jan 2024 04:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706587420; cv=none; b=PGXsntCLizngCxl32U/oq+DQQ2gUDyEpft3ghS6XfqYlVp2KpQZE5dGCkcqnApoZ6uxYjMorzOsDK/4C9shbipOMZw7Mg81yP3Rf2N/4zFlf7YrP/FbAIM2jUP3QkJNUd9Fg5eBYDqCvwD1qdpQ3kosnjs8kEI/xnrfpJA23Qi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706587420; c=relaxed/simple;
	bh=SX6XJNGMelP6uJz71LWfGNs/AEei9Xi6KtFeb7gi1aw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JYEUPm/MVl3Mt0mNtBnS4BKo72/PQ8nffpI0bvkZj6Di81kkxkDHtRGTDSr1PfDbCMLV2q9JW3j8A3rLNJo2dCudpnnaahsGaa+3YxWQOo0tgERmvizYK41ubUMrh4a39Ohrem4SdhYNLzx1k3JRUaSa8qBnxIWjgkDQ+x3FmUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=J7GgQfmZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40U1bnu2004357;
	Tue, 30 Jan 2024 04:03:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=1fm6DHmAEvW9CkPhIWGvnj2GaJqiMRWONWNSxMICurM=; b=J7
	GgQfmZIzY7KalxwA9YWy+br3ZKXmtT1KoQ9bD4LtCB05JGXCeUeLNpdxhBW8YJET
	8maGG1JXBbH2jGAW1pnD/Ga0m1yhtyuCGqzZPFASBdn9Bj16GURKZeTmjzqaq9c+
	MYLUsi2Q//5YacPzOcwbwcIQbbrySHzjnpg8Wanxyspf5hK/re31Iz/nbpI/EZDG
	+UVarNuMhd9YBFzE/D+bw4rEOyGNn6JRH7GQ312EXuh31cRwZUg0H2rXMStQKI0R
	yWm8/zE/YBTAtELLvm4HiqN5vjhYlrRQJGbOtVPPDhC5ihzscp4mhSx9dlqwuT66
	/deJd6gs7yV/OUIaBseA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vxdwf9g5m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jan 2024 04:03:36 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40U43aOb022624
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jan 2024 04:03:36 GMT
Received: from yk-E5440.qca.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 29 Jan 2024 20:03:34 -0800
From: Kang Yang <quic_kangyang@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_kangyang@quicinc.com>
Subject: [PATCH v6 07/11] wifi: ath12k: change WLAN_SCAN_PARAMS_MAX_IE_LEN from 256 to 512
Date: Tue, 30 Jan 2024 12:02:59 +0800
Message-ID: <20240130040303.370590-8-quic_kangyang@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240130040303.370590-1-quic_kangyang@quicinc.com>
References: <20240130040303.370590-1-quic_kangyang@quicinc.com>
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
X-Proofpoint-GUID: FNyf0dkESW27UYmOOBANqMcenq4jCj3V
X-Proofpoint-ORIG-GUID: FNyf0dkESW27UYmOOBANqMcenq4jCj3V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-29_15,2024-01-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 bulkscore=0 malwarescore=0 clxscore=1015 spamscore=0 impostorscore=0
 phishscore=0 mlxlogscore=999 priorityscore=1501 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401300026

Mac80211 needs more space for P2P scan ie in P2P mode, 256 is not
enough, resize it to 512.

Also delete the duplicate macro definitions in wmi.h.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
---

v6: no change.
v5: no change.
v4: no change.
v3: no change.
v2: add Tested-on tag of QCN9274.

---
 drivers/net/wireless/ath/ath12k/wmi.h | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
index 6fb8c1a787a5..74b0ee9f86bf 100644
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
@@ -3149,7 +3145,7 @@ struct ath12k_wmi_element_info_arg {
 
 #define WLAN_SCAN_PARAMS_MAX_SSID    16
 #define WLAN_SCAN_PARAMS_MAX_BSSID   4
-#define WLAN_SCAN_PARAMS_MAX_IE_LEN  256
+#define WLAN_SCAN_PARAMS_MAX_IE_LEN  512
 
 /* Values lower than this may be refused by some firmware revisions with a scan
  * completion with a timedout reason.
-- 
2.34.1


