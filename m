Return-Path: <linux-wireless+bounces-6219-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D7508A262A
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Apr 2024 08:07:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 033A828780A
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Apr 2024 06:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55E423AC16;
	Fri, 12 Apr 2024 06:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="MX6YAscy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E9C3399F
	for <linux-wireless@vger.kernel.org>; Fri, 12 Apr 2024 06:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712902010; cv=none; b=REHNkjv1IbjXH3Okr6hTQIPZuAHCcPYiyiTMh4cHTmMooubiQESlr9vRqEB7Q4UEh/AXv6BLa5mvSU/zQL9s3VwTBEtDepYZmAAQ3Gerd7SSPcaPgqcil0DOVg8kbW1cQR16VCbnccESHHI0HxTgkpt0O1yDyftdnxIFwEUm0Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712902010; c=relaxed/simple;
	bh=L4Rn5/XgvRVKZg6u2sfDax0FBWQMnW9M1puRM7ZjYW8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VBt7JCvUJGtfgH2Pc+EY5ys1/KC42q7TC2qABMtqX0KM9eR77LCTok679cWMXP1OM0Z7/cxTYEgofN72wjou7EkWc1b+sy542qONVjGbj3v+2+Wzz/jZYmwEQgy4UEB6wCTjRHxLwPXknOL+hbP9p3961LnXk4WV6YMaKal6cao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=MX6YAscy; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43C65roZ020307;
	Fri, 12 Apr 2024 06:06:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=gfinA+RjmJYLiSYf80MMLc8RUHdGXfGNjQXUk4Uhj2E=; b=MX
	6YAscyWrNV/RBsPryrT541d+ISyLx9KzW92evztwGU6GdsvhR3e1LUz9YfRwi43A
	HUqEGAMU6ZA+wFu9AXFbtbF2Cs8Wk25fkTXHgE41fcRU8kz9/gM+81ThJlmRWx37
	QGAfwWDqLe5EiF/I5xm72BwE7BToF8aaoIKPt2m/DlTq9xLTscggyys2U4u6ldaS
	BExZ7eqWzr7m0EjMXRrUyhTYozt+LR7f6WwDoe9dLI2kFA57DyBcu8/zuQTALArj
	veVMDH9j/d3743AUOSXXOXuVbOJlR5wUzH+5HPzdIZ6QTiDgST3rH9vLgLwtgUjw
	7QLnaVbyaQRvv723asSQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xesjbrnea-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Apr 2024 06:06:45 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43C66iBX007189
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Apr 2024 06:06:44 GMT
Received: from bqiang-SFF.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 11 Apr 2024 23:06:43 -0700
From: Baochen Qiang <quic_bqiang@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_bqiang@quicinc.com>
Subject: [PATCH 06/10] wifi: ath12k: flush all packets before suspend
Date: Fri, 12 Apr 2024 14:06:16 +0800
Message-ID: <20240412060620.27519-7-quic_bqiang@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240412060620.27519-1-quic_bqiang@quicinc.com>
References: <20240412060620.27519-1-quic_bqiang@quicinc.com>
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
X-Proofpoint-ORIG-GUID: UXbAuaG1nRJ-i5GvzHDECuJppor5B4rw
X-Proofpoint-GUID: UXbAuaG1nRJ-i5GvzHDECuJppor5B4rw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-12_02,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 clxscore=1015 phishscore=0 mlxscore=0 impostorscore=0
 bulkscore=0 adultscore=0 spamscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404120042

In order to send out all packets before going to suspend, current code
adds a 500ms delay as a workaround. It is a rough estimate and may not
work.

Fix this by checking packet counters, if counters become zero, then all
packets are sent out or dropped.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.c | 20 +++++++++++++-----
 drivers/net/wireless/ath/ath12k/mac.c  | 28 ++++++++++++++++++++------
 drivers/net/wireless/ath/ath12k/mac.h  |  1 +
 3 files changed, 38 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index 28663cf4db30..dfec390b66c6 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -44,15 +44,25 @@ static int ath12k_core_rfkill_config(struct ath12k_base *ab)
 
 int ath12k_core_suspend(struct ath12k_base *ab)
 {
-	int ret;
+	struct ath12k *ar;
+	int ret, i;
 
 	if (!ab->hw_params->supports_suspend)
 		return -EOPNOTSUPP;
 
-	/* TODO: there can frames in queues so for now add delay as a hack.
-	 * Need to implement to handle and remove this delay.
-	 */
-	msleep(500);
+	rcu_read_lock();
+	for (i = 0; i < ab->num_radios; i++) {
+		ar = ath12k_mac_get_ar_by_pdev_id(ab, i);
+		if (!ar)
+			continue;
+		ret = ath12k_mac_wait_tx_complete(ar);
+		if (ret) {
+			ath12k_warn(ab, "failed to wait tx complete: %d\n", ret);
+			rcu_read_unlock();
+			return ret;
+		}
+	}
+	rcu_read_unlock();
 
 	ret = ath12k_dp_rx_pktlog_stop(ab, true);
 	if (ret) {
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index f15dcd75157d..69c5fd9d2612 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -7356,22 +7356,38 @@ static int ath12k_mac_op_set_frag_threshold(struct ieee80211_hw *hw, u32 value)
 	return -EOPNOTSUPP;
 }
 
-static void ath12k_mac_flush(struct ath12k *ar)
+static int ath12k_mac_flush(struct ath12k *ar)
 {
 	long time_left;
+	int ret = 0;
 
 	time_left = wait_event_timeout(ar->dp.tx_empty_waitq,
 				       (atomic_read(&ar->dp.num_tx_pending) == 0),
 				       ATH12K_FLUSH_TIMEOUT);
-	if (time_left == 0)
-		ath12k_warn(ar->ab, "failed to flush transmit queue %ld\n", time_left);
+	if (time_left == 0) {
+		ath12k_warn(ar->ab,
+			    "failed to flush transmit queue, data pkts pending %d\n",
+			    atomic_read(&ar->dp.num_tx_pending));
+		ret = -ETIMEDOUT;
+	}
 
 	time_left = wait_event_timeout(ar->txmgmt_empty_waitq,
 				       (atomic_read(&ar->num_pending_mgmt_tx) == 0),
 				       ATH12K_FLUSH_TIMEOUT);
-	if (time_left == 0)
-		ath12k_warn(ar->ab, "failed to flush mgmt transmit queue %ld\n",
-			    time_left);
+	if (time_left == 0) {
+		ath12k_warn(ar->ab,
+			    "failed to flush mgmt transmit queue, mgmt pkts pending %d\n",
+			    atomic_read(&ar->num_pending_mgmt_tx));
+		ret = -ETIMEDOUT;
+	}
+
+	return ret;
+}
+
+int ath12k_mac_wait_tx_complete(struct ath12k *ar)
+{
+	ath12k_mac_drain_tx(ar);
+	return ath12k_mac_flush(ar);
 }
 
 static void ath12k_mac_op_flush(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
diff --git a/drivers/net/wireless/ath/ath12k/mac.h b/drivers/net/wireless/ath/ath12k/mac.h
index 3f5e1be0dff9..f826822d30c8 100644
--- a/drivers/net/wireless/ath/ath12k/mac.h
+++ b/drivers/net/wireless/ath/ath12k/mac.h
@@ -78,4 +78,5 @@ enum ath12k_supported_bw ath12k_mac_mac80211_bw_to_ath12k_bw(enum rate_info_bw b
 enum hal_encrypt_type ath12k_dp_tx_get_encrypt_type(u32 cipher);
 int ath12k_mac_rfkill_enable_radio(struct ath12k *ar, bool enable);
 int ath12k_mac_rfkill_config(struct ath12k *ar);
+int ath12k_mac_wait_tx_complete(struct ath12k *ar);
 #endif
-- 
2.25.1


