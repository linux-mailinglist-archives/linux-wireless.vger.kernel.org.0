Return-Path: <linux-wireless+bounces-6971-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D74138B52E7
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Apr 2024 10:15:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9265E281081
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Apr 2024 08:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B20C6156CF;
	Mon, 29 Apr 2024 08:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="R1pesYzq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C38171C1
	for <linux-wireless@vger.kernel.org>; Mon, 29 Apr 2024 08:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714378552; cv=none; b=rP9Pmnbacf2KNm9wLHCftGNiWd/LbkeqJnof1Nh5NqJnZoIaYa4HLhgcUFnsDMpl4K+0eOU5J4i7grJhMDip9y68q3ubrzUPHKPnMMejJ1vsQx8hzfLAYYyC1nFSi0l3yupR66lGRuS7n3B0X64WuxcqnfTbc4oE02kGB7ZlmIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714378552; c=relaxed/simple;
	bh=+KPoyP9hA6sGt4ASizQkrVrFLf7PwXtz7Kw56F3ZRA8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=djNejD+zMh3pq0U6NKzu5zU1exozjXwhToNYIdIGsQCvB1KrzfBqZ/KNKuJAZ0cOFTqAIbhpaMb3nf/l8zdMQupuO2XzD0unHR7TPbNZe6TN9kioYyDCbLd9LueXfoTGMyJO2/L+uMiK/WrnrZRx0jPU/DIxSvBpXlHTMozRWfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=R1pesYzq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43T5tnTZ002468;
	Mon, 29 Apr 2024 08:15:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=cZy8WHNz+U8iVqZk4edckW0X50EEgV5UPLQbTdH0uPg=; b=R1
	pesYzqSdoOS5FRAMfLf33asRDBvAXT3zqD/0ZAM+RKDJAzWRMqd2DRzNL1BD0VwP
	XPwbfhyJmr56UPy0fsvVxX6rD6N9BWH7s5DfiJC4K8VWRlN+sWhNla+L8Iyt6/Fx
	g/HmLoNTs70LSO0TKuChm1eEDBHF54tzPH70nxUAHd/nLJM6BmFmNoIRmNcEc1sz
	OpBkOf2ZorUj9dmw6upDUU5T4CtrugSxqsQZdrzkdMhbpvIx0TA0hz61ndGD391L
	8tblLGQiAxncs6YNnfJlsi7GW61Ui3Rl/ZNAaP1RSX0vNFhrqAeeSpF5CDX2Va7B
	pLFQgPOpEHtHoAVDtTIA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xrq2k39fp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Apr 2024 08:15:48 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43T8FlKb028829
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Apr 2024 08:15:47 GMT
Received: from kangyang.ap.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 29 Apr 2024 01:15:45 -0700
From: kangyang <quic_kangyang@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_kangyang@quicinc.com>
Subject: [PATCH 1/5] wifi: ath12k: remove unused variable monitor_flags
Date: Mon, 29 Apr 2024 16:15:21 +0800
Message-ID: <20240429081525.983-2-quic_kangyang@quicinc.com>
X-Mailer: git-send-email 2.34.1.windows.1
In-Reply-To: <20240429081525.983-1-quic_kangyang@quicinc.com>
References: <20240429081525.983-1-quic_kangyang@quicinc.com>
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
X-Proofpoint-ORIG-GUID: JT1TxCx8zCmKQ3xx0Du_Jv4VeKvX7a-u
X-Proofpoint-GUID: JT1TxCx8zCmKQ3xx0Du_Jv4VeKvX7a-u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-29_05,2024-04-26_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 impostorscore=0 adultscore=0 malwarescore=0 mlxscore=0 priorityscore=1501
 suspectscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404290050

From: Kang Yang <quic_kangyang@quicinc.com>

monitor_flags is defined in struct ath12k. Although it is changed in
some places, but it is not actually used.

So remove related code.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.h |  5 -----
 drivers/net/wireless/ath/ath12k/mac.c  | 10 +---------
 2 files changed, 1 insertion(+), 14 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 47dde4401210..db139152e372 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -212,10 +212,6 @@ enum ath12k_dev_flags {
 	ATH12K_FLAG_EXT_IRQ_ENABLED,
 };
 
-enum ath12k_monitor_flags {
-	ATH12K_FLAG_MONITOR_ENABLED,
-};
-
 struct ath12k_tx_conf {
 	bool changed;
 	u16 ac;
@@ -533,7 +529,6 @@ struct ath12k {
 
 	unsigned long dev_flags;
 	unsigned int filter_flags;
-	unsigned long monitor_flags;
 	u32 min_tx_power;
 	u32 max_tx_power;
 	u32 txpower_limit_2g;
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 56b1f8b6844e..3e9a7dec7eba 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -6492,7 +6492,6 @@ static int ath12k_mac_vdev_delete(struct ath12k *ar, struct ieee80211_vif *vif)
 
 	/* Recalc txpower for remaining vdev */
 	ath12k_mac_txpower_recalc(ar);
-	clear_bit(ATH12K_FLAG_MONITOR_ENABLED, &ar->monitor_flags);
 
 	/* TODO: recal traffic pause state based on the available vdevs */
 	arvif->is_created = false;
@@ -6563,15 +6562,9 @@ static void ath12k_mac_configure_filter(struct ath12k *ar,
 	reset_flag = !(ar->filter_flags & FIF_BCN_PRBRESP_PROMISC);
 
 	ret = ath12k_dp_tx_htt_monitor_mode_ring_config(ar, reset_flag);
-	if (!ret) {
-		if (!reset_flag)
-			set_bit(ATH12K_FLAG_MONITOR_ENABLED, &ar->monitor_flags);
-		else
-			clear_bit(ATH12K_FLAG_MONITOR_ENABLED, &ar->monitor_flags);
-	} else {
+	if (ret)
 		ath12k_warn(ar->ab,
 			    "fail to set monitor filter: %d\n", ret);
-	}
 
 	ath12k_dbg(ar->ab, ATH12K_DBG_MAC,
 		   "total_flags:0x%x, reset_flag:%d\n",
@@ -8832,7 +8825,6 @@ static void ath12k_mac_setup(struct ath12k *ar)
 
 	INIT_WORK(&ar->wmi_mgmt_tx_work, ath12k_mgmt_over_wmi_tx_work);
 	skb_queue_head_init(&ar->wmi_mgmt_tx_queue);
-	clear_bit(ATH12K_FLAG_MONITOR_ENABLED, &ar->monitor_flags);
 }
 
 int ath12k_mac_register(struct ath12k_base *ab)
-- 
2.34.1


