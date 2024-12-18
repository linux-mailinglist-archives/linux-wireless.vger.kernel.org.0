Return-Path: <linux-wireless+bounces-16520-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85A859F5D8D
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Dec 2024 04:43:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B388716AB62
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Dec 2024 03:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67AE3154439;
	Wed, 18 Dec 2024 03:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="RopgrvsM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC45214D2B9;
	Wed, 18 Dec 2024 03:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734493318; cv=none; b=EgaTKG+qC5WB2h+Ho2NwIvvS7WQDdrUN+TyIurCZ+YZtjxtJo1MLgKM3PMuiWx9jkjJLXoQA8LsVY4GhcXDaYaR90dlDrwBy7IxxIV4R7xArMltUw50rSBA5kdqMoTmie+Jnf/pjypAzZ+HRKmLWhIuU9UvkvQF2MLe7PI3JW3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734493318; c=relaxed/simple;
	bh=GeanyNLedxUdgQJo+zcXNKMhpGT48rlJCpzICiVeIlM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=BlxCazbmhK8l36Zt3I7mPHnqW4A+CyltQ9P/V84Qbt0zQJSL7OoZxNWuZTo2AUknpMFCndRQXDwGrzqJoPoIYFLIurN4ykXSWt3HwgBdGDZRQ07Mmml8RS2T6tUiUgc3ThYbXBUiN9BobcVbJ9UflvGCiMAVSF8LHRX99C+HzJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=RopgrvsM; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BHMnr2e007301;
	Wed, 18 Dec 2024 03:41:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0uNLeXfEXwkgpomkNVtWKWJxDsQbDffCqgrwI3O9nzQ=; b=RopgrvsMb6PplYEq
	WZfYlUQtXRK8C9GF9pv67p9k2x/EeqAcvdKti8fwYJ8LsQQFb9NlC8WXX39KM0iD
	CJXRwLv3X8xPE059HWEwjmHjk7URTbrJf8xEfeWCfS+ziTGj9It0JOc89oki67K7
	s4Ngb+aCTrVGqT63rrzdsvOGwy04kL2dd9A+q5vjF0nV5WQ637sGPMHKH+52ahLP
	PazT5dt9Q+Swp3NmM38xqQFnjQhTNnJ4mO/t4ODUSHPjIdIOEDo6OCqJ51GDqeEK
	2GjCa0IXBCbZDM9JCa55Zc09fvK15dWfv0/+ND6RODCAu6B+RLIOpjdzFdrgdwJ3
	9lecTw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43kjeegh29-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Dec 2024 03:41:53 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BI3fqE8021678
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Dec 2024 03:41:52 GMT
Received: from hu-adisi-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 17 Dec 2024 19:41:50 -0800
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
Date: Wed, 18 Dec 2024 09:11:34 +0530
Subject: [PATCH 3/3] wifi: ath12k: handle radar detection with MLO
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241218-ath12k_mlo_dfs-v1-3-058e783bcfc7@quicinc.com>
References: <20241218-ath12k_mlo_dfs-v1-0-058e783bcfc7@quicinc.com>
In-Reply-To: <20241218-ath12k_mlo_dfs-v1-0-058e783bcfc7@quicinc.com>
To: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <ath12k@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Aditya Kumar Singh <quic_adisi@quicinc.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: v4hmDlUiJByqYg0MTveyt0Sbk9nk6tna
X-Proofpoint-ORIG-GUID: v4hmDlUiJByqYg0MTveyt0Sbk9nk6tna
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 bulkscore=0 mlxlogscore=999 spamscore=0 suspectscore=0 adultscore=0
 malwarescore=0 phishscore=0 impostorscore=0 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412180026

ieee80211_radar_detected() expects the driver to pass a channel context
configuration during MLO. This is used to identify exactly which link
detected the radar.

Add support to pass this to mac80211. Since the link arvif is not known in
the WMI event, introduce a helper iterator API,
ath12k_mac_get_any_chanctx_conf_iter(), to get the channel context
configuration.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1

Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 11 +++++++++++
 drivers/net/wireless/ath/ath12k/mac.h |  8 ++++++++
 drivers/net/wireless/ath/ath12k/wmi.c | 12 +++++++++++-
 3 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 77518546259248c356556b07ae0ae1df428d01dd..4a4da9e9897a5b51b797ff12cd0022667fe96b67 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -751,6 +751,17 @@ static struct ath12k *ath12k_get_ar_by_vif(struct ieee80211_hw *hw,
 	return NULL;
 }
 
+void ath12k_mac_get_any_chanctx_conf_iter(struct ieee80211_hw *hw,
+					  struct ieee80211_chanctx_conf *conf,
+					  void *data)
+{
+	struct ath12k_mac_get_any_chanctx_conf_arg *arg = data;
+	struct ath12k *ctx_ar = ath12k_get_ar_by_ctx(hw, conf);
+
+	if (ctx_ar == arg->ar)
+		arg->chanctx_conf = conf;
+}
+
 static struct ath12k_link_vif *ath12k_mac_get_vif_up(struct ath12k *ar)
 {
 	struct ath12k_link_vif *arvif;
diff --git a/drivers/net/wireless/ath/ath12k/mac.h b/drivers/net/wireless/ath/ath12k/mac.h
index 81cfb950e6cddfcf31747e46c7a9a805b94f55dd..3594729b63974e942b91eed0ebdfcabcb6a3c3a1 100644
--- a/drivers/net/wireless/ath/ath12k/mac.h
+++ b/drivers/net/wireless/ath/ath12k/mac.h
@@ -59,6 +59,11 @@ enum ath12k_supported_bw {
 	ATH12K_BW_320   = 4,
 };
 
+struct ath12k_mac_get_any_chanctx_conf_arg {
+	struct ath12k *ar;
+	struct ieee80211_chanctx_conf *chanctx_conf;
+};
+
 extern const struct htt_rx_ring_tlv_filter ath12k_mac_mon_status_filter_default;
 
 void ath12k_mac_destroy(struct ath12k_hw_group *ag);
@@ -100,5 +105,8 @@ int ath12k_mac_mlo_setup(struct ath12k_hw_group *ag);
 int ath12k_mac_mlo_ready(struct ath12k_hw_group *ag);
 void ath12k_mac_mlo_teardown(struct ath12k_hw_group *ag);
 int ath12k_mac_vdev_stop(struct ath12k_link_vif *arvif);
+void ath12k_mac_get_any_chanctx_conf_iter(struct ieee80211_hw *hw,
+					  struct ieee80211_chanctx_conf *conf,
+					  void *data);
 
 #endif
diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index d0ae7f142c11ab4720bf95c0c95990ff40bd2815..9a96c4d70e6007d3701af63278b23dd1a79cc4b1 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -6935,6 +6935,7 @@ static void
 ath12k_wmi_pdev_dfs_radar_detected_event(struct ath12k_base *ab, struct sk_buff *skb)
 {
 	const void **tb;
+	struct ath12k_mac_get_any_chanctx_conf_arg arg;
 	const struct ath12k_wmi_pdev_radar_event *ev;
 	struct ath12k *ar;
 	int ret;
@@ -6970,13 +6971,22 @@ ath12k_wmi_pdev_dfs_radar_detected_event(struct ath12k_base *ab, struct sk_buff
 		goto exit;
 	}
 
+	arg.ar = ar;
+	arg.chanctx_conf = NULL;
+	ieee80211_iter_chan_contexts_atomic(ath12k_ar_to_hw(ar),
+					    ath12k_mac_get_any_chanctx_conf_iter, &arg);
+	if (!arg.chanctx_conf) {
+		ath12k_warn(ab, "failed to find valid chanctx_conf in radar detected event\n");
+		goto exit;
+	}
+
 	ath12k_dbg(ar->ab, ATH12K_DBG_REG, "DFS Radar Detected in pdev %d\n",
 		   ev->pdev_id);
 
 	if (ar->dfs_block_radar_events)
 		ath12k_info(ab, "DFS Radar detected, but ignored as requested\n");
 	else
-		ieee80211_radar_detected(ath12k_ar_to_hw(ar), NULL);
+		ieee80211_radar_detected(ath12k_ar_to_hw(ar), arg.chanctx_conf);
 
 exit:
 	rcu_read_unlock();

-- 
2.34.1


