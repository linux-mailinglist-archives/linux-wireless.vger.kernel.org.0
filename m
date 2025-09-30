Return-Path: <linux-wireless+bounces-27747-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A31CBACFAF
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Sep 2025 15:10:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14AA219284EA
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Sep 2025 13:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E463285418;
	Tue, 30 Sep 2025 13:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="FJxqgH6u"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA12303CAE
	for <linux-wireless@vger.kernel.org>; Tue, 30 Sep 2025 13:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759237834; cv=none; b=R9VYHGt2R9tkrVo9jjay7+qTOckdRdwPUypXARRchQbMhY4A6wn6iKtZBCnjzJ63U6F3nbjnkXM1dAqMRfo7QL9SoUw9toBOCnfnEt4Pz5KnTTwPmzv4HQBQ/8Om2it2OlPX7QvxotpiwzIYdzbGA4mhDDjABfVL7tQ5UFFcb64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759237834; c=relaxed/simple;
	bh=KKz4FhMcvWlAjCJ+XM2pe+3w4lA2HL5rzRD3VM8upSw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bvFSrp+SqH9WEwUFydbUyt0gcZUWI2Qbfbgi9VqU+OGzsvAKPK2+Mzmg71Mp2RZXN/flqPoKB9JKzZi+BxLLgNhBnZURw7WpwBLg56fMI/9Burh/QYk157HbA1P63/90KotvGCjfqWM3rVArHTMoadbpxpF9y7fI8PEfsh5kigQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=FJxqgH6u; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58UBrqf1001100;
	Tue, 30 Sep 2025 13:10:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pcmSzn5+8ARC4blfpMyN0WkbTAajQYMCN2XEAGrqdKI=; b=FJxqgH6uZKww4HUg
	sRSVrUYMVDky4Z0bJi1MkSqWOK+LN/kI3hagOvaSY9qqEA6N6WhCNj5z/2hP5mct
	/GlZakZ4Ey18U7byX2V7Is1Dak3AU1NI3cAPrO0f47nRE5sHRpB1m8UHcZmMmYSO
	EIB6E/hHrKEFW2fj4p0YNOIbrbUKd1Wcnc+AopdLEV3vYIdm1saS51saUo8eTwqy
	M5jCer01QK06h9V/xlFvnVzzyUj0YoYSqCrIPDyBCoAtzi/9hjmEmMwRctiJqPKP
	ZW4qtfMsBGulaHL90MDmHP+13lkQlcGbxs7SqNvTJVwTl8W4HCw4uv8ZBHWCF2s2
	w/mhcw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49fppr4fu5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Sep 2025 13:10:27 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 58UDAQYA031893
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Sep 2025 13:10:26 GMT
Received: from hu-rdeuri-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Tue, 30 Sep 2025 06:10:24 -0700
From: Ripan Deuri <quic_rdeuri@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH ath12k-ng v4 4/6] wifi: ath12k: Add framework for hardware specific ieee80211_ops registration
Date: Tue, 30 Sep 2025 18:40:03 +0530
Message-ID: <20250930131005.2884253-5-quic_rdeuri@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250930131005.2884253-1-quic_rdeuri@quicinc.com>
References: <20250930131005.2884253-1-quic_rdeuri@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI5MDA4MiBTYWx0ZWRfX4brNC2vhcOFB
 WaY0kMMgq7LnArkjB9Rf6SFAGgKACb9SMp9HT8AtMlmzMl4VP/1IvtcthTUNLblYOSZTYksi42o
 tdAmlryyF5nx7MMTWl+BEULWt9hlS2mKJdxp6Geyq9SSxGYrtPlEDki9HfXAInUME52G4f00Mdt
 KqQu9sxmDNyFJdAlH1JAgkP/f/eX0F24fG9t3iXm4IRJrPedR/ljUeMiMR1l27LQSORGvbogl8H
 WsorOvx0VkWp6/UfVHPbsiF4g1HH55EKvkesWRQJQhJOOold7TWN8c2IkkM0Wj7Vn43bnUre7Oe
 i3CGucpJG3ea+95uLOy7sQ98wXA3ztwdGYfF4wpMDDkxt79X06PqOjx9ANrQ7d+g8/hXCSQ/+1y
 CnkWYaOEUAwjHx4+/FIG++LL5w/CIw==
X-Proofpoint-ORIG-GUID: y3xgnrULNpcHhLnFsj3Z8OOzcugbMBE3
X-Authority-Analysis: v=2.4 cv=GLoF0+NK c=1 sm=1 tr=0 ts=68dbd6c3 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=wTcbH1xZeotpbmmP5xMA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: y3xgnrULNpcHhLnFsj3Z8OOzcugbMBE3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-30_02,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 suspectscore=0
 impostorscore=0 spamscore=0 bulkscore=0 clxscore=1015 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2509290082

Introduce a framework to register the ieee80211_ops table based on the
underlying hardware architecture. This is necessary to support
architecture-specific implementations of ieee80211_ops such as .tx, which
will be introduced in upcoming patches.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Ripan Deuri <quic_rdeuri@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.h        |   5 +
 drivers/net/wireless/ath/ath12k/debugfs.c     |   3 +-
 drivers/net/wireless/ath/ath12k/debugfs_sta.c |   3 +-
 drivers/net/wireless/ath/ath12k/mac.c         | 308 +++++++++---------
 drivers/net/wireless/ath/ath12k/mac.h         | 128 +++++++-
 drivers/net/wireless/ath/ath12k/testmode.c    |   3 +-
 drivers/net/wireless/ath/ath12k/wifi7/hw.c    |  62 ++++
 drivers/net/wireless/ath/ath12k/wow.c         |   5 +-
 8 files changed, 350 insertions(+), 167 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 40bd1df1cda5..ff99d5ae6226 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -1242,6 +1242,11 @@ struct ath12k_base {
 	const struct ath12k_mem_profile_based_param *profile_param;
 	enum ath12k_qmi_mem_mode target_mem_mode;
 
+	/* FIXME: Define this field in a ag equivalent object available
+	 * during the initial phase of probe later.
+	 */
+	const struct ieee80211_ops *ath12k_ops;
+
 	/* must be last */
 	u8 drv_priv[] __aligned(sizeof(void *));
 };
diff --git a/drivers/net/wireless/ath/ath12k/debugfs.c b/drivers/net/wireless/ath/ath12k/debugfs.c
index 16601a8c3644..44c2402d70ca 100644
--- a/drivers/net/wireless/ath/ath12k/debugfs.c
+++ b/drivers/net/wireless/ath/ath12k/debugfs.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
 #include "core.h"
@@ -1020,6 +1020,7 @@ void ath12k_debugfs_op_vif_add(struct ieee80211_hw *hw,
 	debugfs_create_file("link_stats", 0400, vif->debugfs_dir, ahvif,
 			    &ath12k_fops_link_stats);
 }
+EXPORT_SYMBOL(ath12k_debugfs_op_vif_add);
 
 static ssize_t ath12k_debugfs_dump_device_dp_stats(struct file *file,
 						   char __user *user_buf,
diff --git a/drivers/net/wireless/ath/ath12k/debugfs_sta.c b/drivers/net/wireless/ath/ath12k/debugfs_sta.c
index 5bd2bf4c9dac..e6665fd521db 100644
--- a/drivers/net/wireless/ath/ath12k/debugfs_sta.c
+++ b/drivers/net/wireless/ath/ath12k/debugfs_sta.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
- * Copyright (c) 2024-2025 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
 #include <linux/vmalloc.h>
@@ -335,3 +335,4 @@ void ath12k_debugfs_link_sta_op_add(struct ieee80211_hw *hw,
 				    &fops_reset_rx_stats);
 	}
 }
+EXPORT_SYMBOL(ath12k_debugfs_link_sta_op_add);
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 449e6a2a9041..0f93fbeafa8c 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -1435,10 +1435,11 @@ int ath12k_mac_vdev_stop(struct ath12k_link_vif *arvif)
 	return ret;
 }
 
-static int ath12k_mac_op_config(struct ieee80211_hw *hw, int radio_idx, u32 changed)
+int ath12k_mac_op_config(struct ieee80211_hw *hw, int radio_idx, u32 changed)
 {
 	return 0;
 }
+EXPORT_SYMBOL(ath12k_mac_op_config);
 
 static int ath12k_mac_setup_bcn_p2p_ie(struct ath12k_link_vif *arvif,
 				       struct sk_buff *bcn)
@@ -3982,7 +3983,7 @@ static void ath12k_mac_unassign_link_vif(struct ath12k_link_vif *arvif)
 		memset(arvif, 0, sizeof(*arvif));
 }
 
-static int
+int
 ath12k_mac_op_change_vif_links(struct ieee80211_hw *hw,
 			       struct ieee80211_vif *vif,
 			       u16 old_links, u16 new_links,
@@ -4031,6 +4032,7 @@ ath12k_mac_op_change_vif_links(struct ieee80211_hw *hw,
 
 	return 0;
 }
+EXPORT_SYMBOL(ath12k_mac_op_change_vif_links);
 
 static int ath12k_mac_fils_discovery(struct ath12k_link_vif *arvif,
 				     struct ieee80211_bss_conf *info)
@@ -4079,9 +4081,9 @@ static int ath12k_mac_fils_discovery(struct ath12k_link_vif *arvif,
 	return ret;
 }
 
-static void ath12k_mac_op_vif_cfg_changed(struct ieee80211_hw *hw,
-					  struct ieee80211_vif *vif,
-					  u64 changed)
+void ath12k_mac_op_vif_cfg_changed(struct ieee80211_hw *hw,
+				   struct ieee80211_vif *vif,
+				   u64 changed)
 {
 	struct ath12k_vif *ahvif = ath12k_vif_to_ahvif(vif);
 	unsigned long links = ahvif->links_map;
@@ -4149,6 +4151,7 @@ static void ath12k_mac_op_vif_cfg_changed(struct ieee80211_hw *hw,
 		}
 	}
 }
+EXPORT_SYMBOL(ath12k_mac_op_vif_cfg_changed);
 
 static void ath12k_mac_vif_setup_ps(struct ath12k_link_vif *arvif)
 {
@@ -4553,10 +4556,10 @@ static void ath12k_ahvif_put_link_cache(struct ath12k_vif *ahvif, u8 link_id)
 	ahvif->cache[link_id] = NULL;
 }
 
-static void ath12k_mac_op_link_info_changed(struct ieee80211_hw *hw,
-					    struct ieee80211_vif *vif,
-					    struct ieee80211_bss_conf *info,
-					    u64 changed)
+void ath12k_mac_op_link_info_changed(struct ieee80211_hw *hw,
+				     struct ieee80211_vif *vif,
+				     struct ieee80211_bss_conf *info,
+				     u64 changed)
 {
 	struct ath12k *ar;
 	struct ath12k_vif *ahvif = ath12k_vif_to_ahvif(vif);
@@ -4586,6 +4589,7 @@ static void ath12k_mac_op_link_info_changed(struct ieee80211_hw *hw,
 
 	ath12k_mac_bss_info_changed(ar, arvif, info, changed);
 }
+EXPORT_SYMBOL(ath12k_mac_op_link_info_changed);
 
 static struct ath12k*
 ath12k_mac_select_scan_device(struct ieee80211_hw *hw,
@@ -4889,10 +4893,10 @@ int ath12k_mac_get_fw_stats(struct ath12k *ar,
 	return 0;
 }
 
-static int ath12k_mac_op_get_txpower(struct ieee80211_hw *hw,
-				     struct ieee80211_vif *vif,
-				     unsigned int link_id,
-				     int *dbm)
+int ath12k_mac_op_get_txpower(struct ieee80211_hw *hw,
+			      struct ieee80211_vif *vif,
+			      unsigned int link_id,
+			      int *dbm)
 {
 	struct ath12k_vif *ahvif = ath12k_vif_to_ahvif(vif);
 	struct ath12k_fw_stats_req_params params = {};
@@ -4965,6 +4969,7 @@ static int ath12k_mac_op_get_txpower(struct ieee80211_hw *hw,
 		   *dbm);
 	return 0;
 }
+EXPORT_SYMBOL(ath12k_mac_op_get_txpower);
 
 static u8
 ath12k_mac_find_link_id_by_ar(struct ath12k_vif *ahvif, struct ath12k *ar)
@@ -5175,9 +5180,9 @@ static int ath12k_mac_initiate_hw_scan(struct ieee80211_hw *hw,
 	return ret;
 }
 
-static int ath12k_mac_op_hw_scan(struct ieee80211_hw *hw,
-				 struct ieee80211_vif *vif,
-				 struct ieee80211_scan_request *hw_req)
+int ath12k_mac_op_hw_scan(struct ieee80211_hw *hw,
+			  struct ieee80211_vif *vif,
+			  struct ieee80211_scan_request *hw_req)
 {
 	struct ath12k_vif *ahvif = ath12k_vif_to_ahvif(vif);
 	struct ieee80211_channel **chan_list, *chan;
@@ -5255,9 +5260,10 @@ static int ath12k_mac_op_hw_scan(struct ieee80211_hw *hw,
 	kfree(chan_list);
 	return ret;
 }
+EXPORT_SYMBOL(ath12k_mac_op_hw_scan);
 
-static void ath12k_mac_op_cancel_hw_scan(struct ieee80211_hw *hw,
-					 struct ieee80211_vif *vif)
+void ath12k_mac_op_cancel_hw_scan(struct ieee80211_hw *hw,
+				  struct ieee80211_vif *vif)
 {
 	struct ath12k_vif *ahvif = ath12k_vif_to_ahvif(vif);
 	unsigned long link_id, links_map = ahvif->links_map;
@@ -5278,6 +5284,7 @@ static void ath12k_mac_op_cancel_hw_scan(struct ieee80211_hw *hw,
 		cancel_delayed_work_sync(&ar->scan.timeout);
 	}
 }
+EXPORT_SYMBOL(ath12k_mac_op_cancel_hw_scan);
 
 static int ath12k_install_key(struct ath12k_link_vif *arvif,
 			      struct ieee80211_key_conf *key,
@@ -5615,9 +5622,9 @@ static int ath12k_mac_update_key_cache(struct ath12k_vif_cache *cache,
 	return 0;
 }
 
-static int ath12k_mac_op_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
-				 struct ieee80211_vif *vif, struct ieee80211_sta *sta,
-				 struct ieee80211_key_conf *key)
+int ath12k_mac_op_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
+			  struct ieee80211_vif *vif, struct ieee80211_sta *sta,
+			  struct ieee80211_key_conf *key)
 {
 	struct ath12k_vif *ahvif = ath12k_vif_to_ahvif(vif);
 	struct ath12k_link_vif *arvif;
@@ -5704,6 +5711,7 @@ static int ath12k_mac_op_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 
 	return 0;
 }
+EXPORT_SYMBOL(ath12k_mac_op_set_key);
 
 static int
 ath12k_mac_bitrate_mask_num_vht_rates(struct ath12k *ar,
@@ -6948,11 +6956,11 @@ static int ath12k_mac_select_links(struct ath12k_base *ab,
 	return 0;
 }
 
-static int ath12k_mac_op_sta_state(struct ieee80211_hw *hw,
-				   struct ieee80211_vif *vif,
-				   struct ieee80211_sta *sta,
-				   enum ieee80211_sta_state old_state,
-				   enum ieee80211_sta_state new_state)
+int ath12k_mac_op_sta_state(struct ieee80211_hw *hw,
+			    struct ieee80211_vif *vif,
+			    struct ieee80211_sta *sta,
+			    enum ieee80211_sta_state old_state,
+			    enum ieee80211_sta_state new_state)
 {
 	struct ath12k_vif *ahvif = ath12k_vif_to_ahvif(vif);
 	struct ath12k_sta *ahsta = ath12k_sta_to_ahsta(sta);
@@ -7110,10 +7118,11 @@ static int ath12k_mac_op_sta_state(struct ieee80211_hw *hw,
 
 	return ret;
 }
+EXPORT_SYMBOL(ath12k_mac_op_sta_state);
 
-static int ath12k_mac_op_sta_set_txpwr(struct ieee80211_hw *hw,
-				       struct ieee80211_vif *vif,
-				       struct ieee80211_sta *sta)
+int ath12k_mac_op_sta_set_txpwr(struct ieee80211_hw *hw,
+				struct ieee80211_vif *vif,
+				struct ieee80211_sta *sta)
 {
 	struct ath12k_sta *ahsta = ath12k_sta_to_ahsta(sta);
 	struct ath12k *ar;
@@ -7160,11 +7169,12 @@ static int ath12k_mac_op_sta_set_txpwr(struct ieee80211_hw *hw,
 out:
 	return ret;
 }
+EXPORT_SYMBOL(ath12k_mac_op_sta_set_txpwr);
 
-static void ath12k_mac_op_link_sta_rc_update(struct ieee80211_hw *hw,
-					     struct ieee80211_vif *vif,
-					     struct ieee80211_link_sta *link_sta,
-					     u32 changed)
+void ath12k_mac_op_link_sta_rc_update(struct ieee80211_hw *hw,
+				      struct ieee80211_vif *vif,
+				      struct ieee80211_link_sta *link_sta,
+				      u32 changed)
 {
 	struct ieee80211_sta *sta = link_sta->sta;
 	struct ath12k *ar;
@@ -7268,6 +7278,7 @@ static void ath12k_mac_op_link_sta_rc_update(struct ieee80211_hw *hw,
 
 	rcu_read_unlock();
 }
+EXPORT_SYMBOL(ath12k_mac_op_link_sta_rc_update);
 
 static struct ath12k_link_sta *ath12k_mac_alloc_assign_link_sta(struct ath12k_hw *ah,
 								struct ath12k_sta *ahsta,
@@ -7299,10 +7310,10 @@ static struct ath12k_link_sta *ath12k_mac_alloc_assign_link_sta(struct ath12k_hw
 	return arsta;
 }
 
-static int ath12k_mac_op_change_sta_links(struct ieee80211_hw *hw,
-					  struct ieee80211_vif *vif,
-					  struct ieee80211_sta *sta,
-					  u16 old_links, u16 new_links)
+int ath12k_mac_op_change_sta_links(struct ieee80211_hw *hw,
+				   struct ieee80211_vif *vif,
+				   struct ieee80211_sta *sta,
+				   u16 old_links, u16 new_links)
 {
 	struct ath12k_vif *ahvif = ath12k_vif_to_ahvif(vif);
 	struct ath12k_sta *ahsta = ath12k_sta_to_ahsta(sta);
@@ -7363,15 +7374,17 @@ static int ath12k_mac_op_change_sta_links(struct ieee80211_hw *hw,
 
 	return 0;
 }
+EXPORT_SYMBOL(ath12k_mac_op_change_sta_links);
 
-static bool ath12k_mac_op_can_activate_links(struct ieee80211_hw *hw,
-					     struct ieee80211_vif *vif,
-					     u16 active_links)
+bool ath12k_mac_op_can_activate_links(struct ieee80211_hw *hw,
+				      struct ieee80211_vif *vif,
+				      u16 active_links)
 {
 	/* TODO: Handle recovery case */
 
 	return true;
 }
+EXPORT_SYMBOL(ath12k_mac_op_can_activate_links);
 
 static int ath12k_conf_tx_uapsd(struct ath12k_link_vif *arvif,
 				u16 ac, bool enable)
@@ -7483,10 +7496,10 @@ static int ath12k_mac_conf_tx(struct ath12k_link_vif *arvif, u16 ac,
 	return ret;
 }
 
-static int ath12k_mac_op_conf_tx(struct ieee80211_hw *hw,
-				 struct ieee80211_vif *vif,
-				 unsigned int link_id, u16 ac,
-				 const struct ieee80211_tx_queue_params *params)
+int ath12k_mac_op_conf_tx(struct ieee80211_hw *hw,
+			  struct ieee80211_vif *vif,
+			  unsigned int link_id, u16 ac,
+			  const struct ieee80211_tx_queue_params *params)
 {
 	struct ath12k_vif *ahvif = ath12k_vif_to_ahvif(vif);
 	struct ath12k_link_vif *arvif;
@@ -7515,6 +7528,7 @@ static int ath12k_mac_op_conf_tx(struct ieee80211_hw *hw,
 
 	return ret;
 }
+EXPORT_SYMBOL(ath12k_mac_op_conf_tx);
 
 static struct ieee80211_sta_ht_cap
 ath12k_create_ht_cap(struct ath12k *ar, u32 ar_ht_cap, u32 rate_cap_rx_chainmask)
@@ -8803,9 +8817,9 @@ static u8 ath12k_mac_get_tx_link(struct ieee80211_sta *sta, struct ieee80211_vif
 }
 
 /* Note: called under rcu_read_lock() */
-static void ath12k_mac_op_tx(struct ieee80211_hw *hw,
-			     struct ieee80211_tx_control *control,
-			     struct sk_buff *skb)
+void ath12k_mac_op_tx(struct ieee80211_hw *hw,
+		      struct ieee80211_tx_control *control,
+		      struct sk_buff *skb)
 {
 	struct ath12k_skb_cb *skb_cb = ATH12K_SKB_CB(skb);
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
@@ -8985,6 +8999,7 @@ static void ath12k_mac_op_tx(struct ieee80211_hw *hw,
 		ieee80211_free_txskb(ar->ah->hw, skb);
 	}
 }
+EXPORT_SYMBOL(ath12k_mac_op_tx);
 
 void ath12k_mac_drain_tx(struct ath12k *ar)
 {
@@ -9159,7 +9174,7 @@ static void ath12k_drain_tx(struct ath12k_hw *ah)
 		ath12k_mac_drain_tx(ar);
 }
 
-static int ath12k_mac_op_start(struct ieee80211_hw *hw)
+int ath12k_mac_op_start(struct ieee80211_hw *hw)
 {
 	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
 	struct ath12k *ar;
@@ -9212,6 +9227,7 @@ static int ath12k_mac_op_start(struct ieee80211_hw *hw)
 
 	return ret;
 }
+EXPORT_SYMBOL(ath12k_mac_op_start);
 
 int ath12k_mac_rfkill_config(struct ath12k *ar)
 {
@@ -9318,7 +9334,7 @@ static void ath12k_mac_stop(struct ath12k *ar)
 	atomic_set(&ar->num_pending_mgmt_tx, 0);
 }
 
-static void ath12k_mac_op_stop(struct ieee80211_hw *hw, bool suspend)
+void ath12k_mac_op_stop(struct ieee80211_hw *hw, bool suspend)
 {
 	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
 	struct ath12k *ar;
@@ -9337,6 +9353,7 @@ static void ath12k_mac_op_stop(struct ieee80211_hw *hw, bool suspend)
 
 	mutex_unlock(&ah->hw_mutex);
 }
+EXPORT_SYMBOL(ath12k_mac_op_stop);
 
 static u8
 ath12k_mac_get_vdev_stats_id(struct ath12k_link_vif *arvif)
@@ -9501,8 +9518,8 @@ static void ath12k_mac_update_vif_offload(struct ath12k_link_vif *arvif)
 	}
 }
 
-static void ath12k_mac_op_update_vif_offload(struct ieee80211_hw *hw,
-					     struct ieee80211_vif *vif)
+void ath12k_mac_op_update_vif_offload(struct ieee80211_hw *hw,
+				      struct ieee80211_vif *vif)
 {
 	struct ath12k_vif *ahvif = ath12k_vif_to_ahvif(vif);
 	struct ath12k_link_vif *arvif;
@@ -9526,6 +9543,7 @@ static void ath12k_mac_op_update_vif_offload(struct ieee80211_hw *hw,
 
 	ath12k_mac_update_vif_offload(&ahvif->deflink);
 }
+EXPORT_SYMBOL(ath12k_mac_op_update_vif_offload);
 
 static bool ath12k_mac_vif_ap_active_any(struct ath12k_base *ab)
 {
@@ -10080,8 +10098,8 @@ static struct ath12k *ath12k_mac_assign_vif_to_vdev(struct ieee80211_hw *hw,
 	return arvif->ar;
 }
 
-static int ath12k_mac_op_add_interface(struct ieee80211_hw *hw,
-				       struct ieee80211_vif *vif)
+int ath12k_mac_op_add_interface(struct ieee80211_hw *hw,
+				struct ieee80211_vif *vif)
 {
 	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
 	struct ath12k_vif *ahvif = ath12k_vif_to_ahvif(vif);
@@ -10128,6 +10146,7 @@ static int ath12k_mac_op_add_interface(struct ieee80211_hw *hw,
 	 */
 	return 0;
 }
+EXPORT_SYMBOL(ath12k_mac_op_add_interface);
 
 static void ath12k_mac_vif_unref(struct ath12k_dp *dp, struct ieee80211_vif *vif)
 {
@@ -10216,8 +10235,8 @@ static int ath12k_mac_vdev_delete(struct ath12k *ar, struct ath12k_link_vif *arv
 	return ret;
 }
 
-static void ath12k_mac_op_remove_interface(struct ieee80211_hw *hw,
-					   struct ieee80211_vif *vif)
+void ath12k_mac_op_remove_interface(struct ieee80211_hw *hw,
+				    struct ieee80211_vif *vif)
 {
 	struct ath12k_vif *ahvif = ath12k_vif_to_ahvif(vif);
 	struct ath12k_link_vif *arvif;
@@ -10264,6 +10283,7 @@ static void ath12k_mac_op_remove_interface(struct ieee80211_hw *hw,
 		ath12k_mac_unassign_link_vif(arvif);
 	}
 }
+EXPORT_SYMBOL(ath12k_mac_op_remove_interface);
 
 /* FIXME: Has to be verified. */
 #define SUPPORTED_FILTERS			\
@@ -10275,10 +10295,10 @@ static void ath12k_mac_op_remove_interface(struct ieee80211_hw *hw,
 	FIF_PROBE_REQ |				\
 	FIF_FCSFAIL)
 
-static void ath12k_mac_op_configure_filter(struct ieee80211_hw *hw,
-					   unsigned int changed_flags,
-					   unsigned int *total_flags,
-					   u64 multicast)
+void ath12k_mac_op_configure_filter(struct ieee80211_hw *hw,
+				    unsigned int changed_flags,
+				    unsigned int *total_flags,
+				    u64 multicast)
 {
 	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
 	struct ath12k *ar;
@@ -10290,9 +10310,10 @@ static void ath12k_mac_op_configure_filter(struct ieee80211_hw *hw,
 	*total_flags &= SUPPORTED_FILTERS;
 	ar->filter_flags = *total_flags;
 }
+EXPORT_SYMBOL(ath12k_mac_op_configure_filter);
 
-static int ath12k_mac_op_get_antenna(struct ieee80211_hw *hw, int radio_idx,
-				     u32 *tx_ant, u32 *rx_ant)
+int ath12k_mac_op_get_antenna(struct ieee80211_hw *hw, int radio_idx,
+			      u32 *tx_ant, u32 *rx_ant)
 {
 	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
 	int antennas_rx = 0, antennas_tx = 0;
@@ -10311,9 +10332,10 @@ static int ath12k_mac_op_get_antenna(struct ieee80211_hw *hw, int radio_idx,
 
 	return 0;
 }
+EXPORT_SYMBOL(ath12k_mac_op_get_antenna);
 
-static int ath12k_mac_op_set_antenna(struct ieee80211_hw *hw, int radio_idx,
-				     u32 tx_ant, u32 rx_ant)
+int ath12k_mac_op_set_antenna(struct ieee80211_hw *hw, int radio_idx,
+			      u32 tx_ant, u32 rx_ant)
 {
 	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
 	struct ath12k *ar;
@@ -10330,6 +10352,7 @@ static int ath12k_mac_op_set_antenna(struct ieee80211_hw *hw, int radio_idx,
 
 	return ret;
 }
+EXPORT_SYMBOL(ath12k_mac_op_set_antenna);
 
 static int ath12k_mac_ampdu_action(struct ieee80211_hw *hw,
 				   struct ieee80211_vif *vif,
@@ -10371,9 +10394,9 @@ static int ath12k_mac_ampdu_action(struct ieee80211_hw *hw,
 	return ret;
 }
 
-static int ath12k_mac_op_ampdu_action(struct ieee80211_hw *hw,
-				      struct ieee80211_vif *vif,
-				      struct ieee80211_ampdu_params *params)
+int ath12k_mac_op_ampdu_action(struct ieee80211_hw *hw,
+			       struct ieee80211_vif *vif,
+			       struct ieee80211_ampdu_params *params)
 {
 	struct ieee80211_sta *sta = params->sta;
 	struct ath12k_sta *ahsta = ath12k_sta_to_ahsta(sta);
@@ -10394,9 +10417,10 @@ static int ath12k_mac_op_ampdu_action(struct ieee80211_hw *hw,
 
 	return 0;
 }
+EXPORT_SYMBOL(ath12k_mac_op_ampdu_action);
 
-static int ath12k_mac_op_add_chanctx(struct ieee80211_hw *hw,
-				     struct ieee80211_chanctx_conf *ctx)
+int ath12k_mac_op_add_chanctx(struct ieee80211_hw *hw,
+			      struct ieee80211_chanctx_conf *ctx)
 {
 	struct ath12k *ar;
 	struct ath12k_base *ab;
@@ -10423,9 +10447,10 @@ static int ath12k_mac_op_add_chanctx(struct ieee80211_hw *hw,
 
 	return 0;
 }
+EXPORT_SYMBOL(ath12k_mac_op_add_chanctx);
 
-static void ath12k_mac_op_remove_chanctx(struct ieee80211_hw *hw,
-					 struct ieee80211_chanctx_conf *ctx)
+void ath12k_mac_op_remove_chanctx(struct ieee80211_hw *hw,
+				  struct ieee80211_chanctx_conf *ctx)
 {
 	struct ath12k *ar;
 	struct ath12k_base *ab;
@@ -10450,6 +10475,7 @@ static void ath12k_mac_op_remove_chanctx(struct ieee80211_hw *hw,
 	spin_unlock_bh(&ar->data_lock);
 	ar->chan_tx_pwr = ATH12K_PDEV_TX_POWER_INVALID;
 }
+EXPORT_SYMBOL(ath12k_mac_op_remove_chanctx);
 
 static enum wmi_phy_mode
 ath12k_mac_check_down_grade_phy_mode(struct ath12k *ar,
@@ -10996,9 +11022,9 @@ ath12k_mac_update_active_vif_chan(struct ath12k *ar,
 	kfree(arg.vifs);
 }
 
-static void ath12k_mac_op_change_chanctx(struct ieee80211_hw *hw,
-					 struct ieee80211_chanctx_conf *ctx,
-					 u32 changed)
+void ath12k_mac_op_change_chanctx(struct ieee80211_hw *hw,
+				  struct ieee80211_chanctx_conf *ctx,
+				  u32 changed)
 {
 	struct ath12k *ar;
 	struct ath12k_base *ab;
@@ -11028,6 +11054,7 @@ static void ath12k_mac_op_change_chanctx(struct ieee80211_hw *hw,
 
 	/* TODO: Recalc radar detection */
 }
+EXPORT_SYMBOL(ath12k_mac_op_change_chanctx);
 
 static int ath12k_start_vdev_delay(struct ath12k *ar,
 				   struct ath12k_link_vif *arvif)
@@ -11465,7 +11492,7 @@ static void ath12k_mac_parse_tx_pwr_env(struct ath12k *ar,
 	}
 }
 
-static int
+int
 ath12k_mac_op_assign_vif_chanctx(struct ieee80211_hw *hw,
 				 struct ieee80211_vif *vif,
 				 struct ieee80211_bss_conf *link_conf,
@@ -11550,8 +11577,9 @@ ath12k_mac_op_assign_vif_chanctx(struct ieee80211_hw *hw,
 out:
 	return ret;
 }
+EXPORT_SYMBOL(ath12k_mac_op_assign_vif_chanctx);
 
-static void
+void
 ath12k_mac_op_unassign_vif_chanctx(struct ieee80211_hw *hw,
 				   struct ieee80211_vif *vif,
 				   struct ieee80211_bss_conf *link_conf,
@@ -11618,8 +11646,9 @@ ath12k_mac_op_unassign_vif_chanctx(struct ieee80211_hw *hw,
 		ar->scan.arvif = NULL;
 	}
 }
+EXPORT_SYMBOL(ath12k_mac_op_unassign_vif_chanctx);
 
-static int
+int
 ath12k_mac_op_switch_vif_chanctx(struct ieee80211_hw *hw,
 				 struct ieee80211_vif_chanctx_switch *vifs,
 				 int n_vifs,
@@ -11644,6 +11673,7 @@ ath12k_mac_op_switch_vif_chanctx(struct ieee80211_hw *hw,
 
 	return 0;
 }
+EXPORT_SYMBOL(ath12k_mac_op_switch_vif_chanctx);
 
 static int
 ath12k_set_vdev_param_to_all_vifs(struct ath12k *ar, int param, u32 value)
@@ -11672,8 +11702,8 @@ ath12k_set_vdev_param_to_all_vifs(struct ath12k *ar, int param, u32 value)
 /* mac80211 stores device specific RTS/Fragmentation threshold value,
  * this is set interface specific to firmware from ath12k driver
  */
-static int ath12k_mac_op_set_rts_threshold(struct ieee80211_hw *hw,
-					   int radio_idx, u32 value)
+int ath12k_mac_op_set_rts_threshold(struct ieee80211_hw *hw,
+				    int radio_idx, u32 value)
 {
 	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
 	struct ath12k *ar;
@@ -11697,9 +11727,10 @@ static int ath12k_mac_op_set_rts_threshold(struct ieee80211_hw *hw,
 
 	return ret;
 }
+EXPORT_SYMBOL(ath12k_mac_op_set_rts_threshold);
 
-static int ath12k_mac_op_set_frag_threshold(struct ieee80211_hw *hw,
-					    int radio_idx, u32 value)
+int ath12k_mac_op_set_frag_threshold(struct ieee80211_hw *hw,
+				     int radio_idx, u32 value)
 {
 	/* Even though there's a WMI vdev param for fragmentation threshold no
 	 * known firmware actually implements it. Moreover it is not possible to
@@ -11716,6 +11747,7 @@ static int ath12k_mac_op_set_frag_threshold(struct ieee80211_hw *hw,
 
 	return -EOPNOTSUPP;
 }
+EXPORT_SYMBOL(ath12k_mac_op_set_frag_threshold);
 
 static int ath12k_mac_flush(struct ath12k *ar)
 {
@@ -11753,8 +11785,8 @@ int ath12k_mac_wait_tx_complete(struct ath12k *ar)
 	return ath12k_mac_flush(ar);
 }
 
-static void ath12k_mac_op_flush(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
-				u32 queues, bool drop)
+void ath12k_mac_op_flush(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+			 u32 queues, bool drop)
 {
 	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
 	struct ath12k_link_vif *arvif;
@@ -11789,6 +11821,7 @@ static void ath12k_mac_op_flush(struct ieee80211_hw *hw, struct ieee80211_vif *v
 		ath12k_mac_flush(arvif->ar);
 	}
 }
+EXPORT_SYMBOL(ath12k_mac_op_flush);
 
 static int
 ath12k_mac_bitrate_mask_num_ht_rates(struct ath12k *ar,
@@ -12272,7 +12305,7 @@ ath12k_mac_validate_fixed_rate_settings(struct ath12k *ar, enum nl80211_band ban
 	return ret;
 }
 
-static int
+int
 ath12k_mac_op_set_bitrate_mask(struct ieee80211_hw *hw,
 			       struct ieee80211_vif *vif,
 			       const struct cfg80211_bitrate_mask *mask)
@@ -12428,8 +12461,9 @@ ath12k_mac_op_set_bitrate_mask(struct ieee80211_hw *hw,
 out:
 	return ret;
 }
+EXPORT_SYMBOL(ath12k_mac_op_set_bitrate_mask);
 
-static void
+void
 ath12k_mac_op_reconfig_complete(struct ieee80211_hw *hw,
 				enum ieee80211_reconfig_type reconfig_type)
 {
@@ -12510,6 +12544,7 @@ ath12k_mac_op_reconfig_complete(struct ieee80211_hw *hw,
 		}
 	}
 }
+EXPORT_SYMBOL(ath12k_mac_op_reconfig_complete);
 
 static void
 ath12k_mac_update_bss_chan_survey(struct ath12k *ar,
@@ -12543,8 +12578,8 @@ ath12k_mac_update_bss_chan_survey(struct ath12k *ar,
 		ath12k_warn(ar->ab, "bss channel survey timed out\n");
 }
 
-static int ath12k_mac_op_get_survey(struct ieee80211_hw *hw, int idx,
-				    struct survey_info *survey)
+int ath12k_mac_op_get_survey(struct ieee80211_hw *hw, int idx,
+			     struct survey_info *survey)
 {
 	struct ath12k *ar;
 	struct ieee80211_supported_band *sband;
@@ -12598,11 +12633,12 @@ static int ath12k_mac_op_get_survey(struct ieee80211_hw *hw, int idx,
 
 	return 0;
 }
+EXPORT_SYMBOL(ath12k_mac_op_get_survey);
 
-static void ath12k_mac_op_sta_statistics(struct ieee80211_hw *hw,
-					 struct ieee80211_vif *vif,
-					 struct ieee80211_sta *sta,
-					 struct station_info *sinfo)
+void ath12k_mac_op_sta_statistics(struct ieee80211_hw *hw,
+				  struct ieee80211_vif *vif,
+				  struct ieee80211_sta *sta,
+				  struct station_info *sinfo)
 {
 	struct ath12k_sta *ahsta = ath12k_sta_to_ahsta(sta);
 	struct ath12k_fw_stats_req_params params = {};
@@ -12677,11 +12713,12 @@ static void ath12k_mac_op_sta_statistics(struct ieee80211_hw *hw,
 	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_RETRIES);
 	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_FAILED);
 }
+EXPORT_SYMBOL(ath12k_mac_op_sta_statistics);
 
-static void ath12k_mac_op_link_sta_statistics(struct ieee80211_hw *hw,
-					      struct ieee80211_vif *vif,
-					      struct ieee80211_link_sta *link_sta,
-					      struct link_station_info *link_sinfo)
+void ath12k_mac_op_link_sta_statistics(struct ieee80211_hw *hw,
+				       struct ieee80211_vif *vif,
+				       struct ieee80211_link_sta *link_sta,
+				       struct link_station_info *link_sinfo)
 {
 	struct ath12k_sta *ahsta = ath12k_sta_to_ahsta(link_sta->sta);
 	struct ath12k_fw_stats_req_params params = {};
@@ -12759,9 +12796,10 @@ static void ath12k_mac_op_link_sta_statistics(struct ieee80211_hw *hw,
 	link_sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_RETRIES);
 	link_sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_FAILED);
 }
+EXPORT_SYMBOL(ath12k_mac_op_link_sta_statistics);
 
-static int ath12k_mac_op_cancel_remain_on_channel(struct ieee80211_hw *hw,
-						  struct ieee80211_vif *vif)
+int ath12k_mac_op_cancel_remain_on_channel(struct ieee80211_hw *hw,
+					   struct ieee80211_vif *vif)
 {
 	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
 	struct ath12k *ar;
@@ -12781,12 +12819,13 @@ static int ath12k_mac_op_cancel_remain_on_channel(struct ieee80211_hw *hw,
 
 	return 0;
 }
+EXPORT_SYMBOL(ath12k_mac_op_cancel_remain_on_channel);
 
-static int ath12k_mac_op_remain_on_channel(struct ieee80211_hw *hw,
-					   struct ieee80211_vif *vif,
-					   struct ieee80211_channel *chan,
-					   int duration,
-					   enum ieee80211_roc_type type)
+int ath12k_mac_op_remain_on_channel(struct ieee80211_hw *hw,
+				    struct ieee80211_vif *vif,
+				    struct ieee80211_channel *chan,
+				    int duration,
+				    enum ieee80211_roc_type type)
 {
 	struct ath12k_vif *ahvif = ath12k_vif_to_ahvif(vif);
 	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
@@ -12920,10 +12959,11 @@ static int ath12k_mac_op_remain_on_channel(struct ieee80211_hw *hw,
 
 	return 0;
 }
+EXPORT_SYMBOL(ath12k_mac_op_remain_on_channel);
 
-static void ath12k_mac_op_set_rekey_data(struct ieee80211_hw *hw,
-					 struct ieee80211_vif *vif,
-					 struct cfg80211_gtk_rekey_data *data)
+void ath12k_mac_op_set_rekey_data(struct ieee80211_hw *hw,
+				  struct ieee80211_vif *vif,
+				  struct cfg80211_gtk_rekey_data *data)
 {
 	struct ath12k_vif *ahvif = ath12k_vif_to_ahvif(vif);
 	struct ath12k_rekey_data *rekey_data;
@@ -12956,63 +12996,7 @@ static void ath12k_mac_op_set_rekey_data(struct ieee80211_hw *hw,
 	ath12k_dbg_dump(ar->ab, ATH12K_DBG_MAC, "replay ctr", NULL,
 			&rekey_data->replay_ctr, sizeof(rekey_data->replay_ctr));
 }
-
-static const struct ieee80211_ops ath12k_ops = {
-	.tx				= ath12k_mac_op_tx,
-	.wake_tx_queue			= ieee80211_handle_wake_tx_queue,
-	.start                          = ath12k_mac_op_start,
-	.stop                           = ath12k_mac_op_stop,
-	.reconfig_complete              = ath12k_mac_op_reconfig_complete,
-	.add_interface                  = ath12k_mac_op_add_interface,
-	.remove_interface		= ath12k_mac_op_remove_interface,
-	.update_vif_offload		= ath12k_mac_op_update_vif_offload,
-	.config                         = ath12k_mac_op_config,
-	.link_info_changed              = ath12k_mac_op_link_info_changed,
-	.vif_cfg_changed		= ath12k_mac_op_vif_cfg_changed,
-	.change_vif_links               = ath12k_mac_op_change_vif_links,
-	.configure_filter		= ath12k_mac_op_configure_filter,
-	.hw_scan                        = ath12k_mac_op_hw_scan,
-	.cancel_hw_scan                 = ath12k_mac_op_cancel_hw_scan,
-	.set_key                        = ath12k_mac_op_set_key,
-	.set_rekey_data	                = ath12k_mac_op_set_rekey_data,
-	.sta_state                      = ath12k_mac_op_sta_state,
-	.sta_set_txpwr			= ath12k_mac_op_sta_set_txpwr,
-	.link_sta_rc_update		= ath12k_mac_op_link_sta_rc_update,
-	.conf_tx                        = ath12k_mac_op_conf_tx,
-	.set_antenna			= ath12k_mac_op_set_antenna,
-	.get_antenna			= ath12k_mac_op_get_antenna,
-	.ampdu_action			= ath12k_mac_op_ampdu_action,
-	.add_chanctx			= ath12k_mac_op_add_chanctx,
-	.remove_chanctx			= ath12k_mac_op_remove_chanctx,
-	.change_chanctx			= ath12k_mac_op_change_chanctx,
-	.assign_vif_chanctx		= ath12k_mac_op_assign_vif_chanctx,
-	.unassign_vif_chanctx		= ath12k_mac_op_unassign_vif_chanctx,
-	.switch_vif_chanctx		= ath12k_mac_op_switch_vif_chanctx,
-	.get_txpower			= ath12k_mac_op_get_txpower,
-	.set_rts_threshold		= ath12k_mac_op_set_rts_threshold,
-	.set_frag_threshold		= ath12k_mac_op_set_frag_threshold,
-	.set_bitrate_mask		= ath12k_mac_op_set_bitrate_mask,
-	.get_survey			= ath12k_mac_op_get_survey,
-	.flush				= ath12k_mac_op_flush,
-	.sta_statistics			= ath12k_mac_op_sta_statistics,
-	.link_sta_statistics		= ath12k_mac_op_link_sta_statistics,
-	.remain_on_channel              = ath12k_mac_op_remain_on_channel,
-	.cancel_remain_on_channel       = ath12k_mac_op_cancel_remain_on_channel,
-	.change_sta_links               = ath12k_mac_op_change_sta_links,
-	.can_activate_links             = ath12k_mac_op_can_activate_links,
-#ifdef CONFIG_PM
-	.suspend			= ath12k_wow_op_suspend,
-	.resume				= ath12k_wow_op_resume,
-	.set_wakeup			= ath12k_wow_op_set_wakeup,
-#endif
-#ifdef CONFIG_ATH12K_DEBUGFS
-	.vif_add_debugfs                = ath12k_debugfs_op_vif_add,
-#endif
-	CFG80211_TESTMODE_CMD(ath12k_tm_cmd)
-#ifdef CONFIG_ATH12K_DEBUGFS
-	.link_sta_add_debugfs           = ath12k_debugfs_link_sta_op_add,
-#endif
-};
+EXPORT_SYMBOL(ath12k_mac_op_set_rekey_data);
 
 void ath12k_mac_update_freq_range(struct ath12k *ar,
 				  u32 freq_low, u32 freq_high)
@@ -14226,7 +14210,7 @@ static struct ath12k_hw *ath12k_mac_hw_allocate(struct ath12k_hw_group *ag,
 	u8 pdev_idx;
 
 	hw = ieee80211_alloc_hw(struct_size(ah, radio, num_pdev_map),
-				&ath12k_ops);
+				pdev_map->ab->ath12k_ops);
 	if (!hw)
 		return NULL;
 
diff --git a/drivers/net/wireless/ath/ath12k/mac.h b/drivers/net/wireless/ath/ath12k/mac.h
index 18c79d4002cb..ea6934e8d17c 100644
--- a/drivers/net/wireless/ath/ath12k/mac.h
+++ b/drivers/net/wireless/ath/ath12k/mac.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
 #ifndef ATH12K_MAC_H
@@ -193,4 +193,130 @@ void ath12k_mac_update_freq_range(struct ath12k *ar,
 void ath12k_mac_fill_reg_tpc_info(struct ath12k *ar,
 				  struct ath12k_link_vif *arvif,
 				  struct ieee80211_chanctx_conf *ctx);
+void ath12k_mac_op_tx(struct ieee80211_hw *hw,
+		      struct ieee80211_tx_control *control,
+		      struct sk_buff *skb);
+int ath12k_mac_op_start(struct ieee80211_hw *hw);
+void ath12k_mac_op_stop(struct ieee80211_hw *hw, bool suspend);
+void
+ath12k_mac_op_reconfig_complete(struct ieee80211_hw *hw,
+				enum ieee80211_reconfig_type reconfig_type);
+int ath12k_mac_op_add_interface(struct ieee80211_hw *hw,
+				struct ieee80211_vif *vif);
+void ath12k_mac_op_remove_interface(struct ieee80211_hw *hw,
+				    struct ieee80211_vif *vif);
+void ath12k_mac_op_update_vif_offload(struct ieee80211_hw *hw,
+				      struct ieee80211_vif *vif);
+int ath12k_mac_op_config(struct ieee80211_hw *hw, int radio_idx, u32 changed);
+void ath12k_mac_op_link_info_changed(struct ieee80211_hw *hw,
+				     struct ieee80211_vif *vif,
+				     struct ieee80211_bss_conf *info,
+				     u64 changed);
+void ath12k_mac_op_vif_cfg_changed(struct ieee80211_hw *hw,
+				   struct ieee80211_vif *vif,
+				   u64 changed);
+int
+ath12k_mac_op_change_vif_links
+			(struct ieee80211_hw *hw,
+			 struct ieee80211_vif *vif,
+			 u16 old_links, u16 new_links,
+			 struct ieee80211_bss_conf *ol[IEEE80211_MLD_MAX_NUM_LINKS]);
+void ath12k_mac_op_configure_filter(struct ieee80211_hw *hw,
+				    unsigned int changed_flags,
+				    unsigned int *total_flags,
+				    u64 multicast);
+int ath12k_mac_op_hw_scan(struct ieee80211_hw *hw,
+			  struct ieee80211_vif *vif,
+			  struct ieee80211_scan_request *hw_req);
+void ath12k_mac_op_cancel_hw_scan(struct ieee80211_hw *hw,
+				  struct ieee80211_vif *vif);
+int ath12k_mac_op_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
+			  struct ieee80211_vif *vif, struct ieee80211_sta *sta,
+			  struct ieee80211_key_conf *key);
+void ath12k_mac_op_set_rekey_data(struct ieee80211_hw *hw,
+				  struct ieee80211_vif *vif,
+				  struct cfg80211_gtk_rekey_data *data);
+int ath12k_mac_op_sta_state(struct ieee80211_hw *hw,
+			    struct ieee80211_vif *vif,
+			    struct ieee80211_sta *sta,
+			    enum ieee80211_sta_state old_state,
+			    enum ieee80211_sta_state new_state);
+int ath12k_mac_op_sta_set_txpwr(struct ieee80211_hw *hw,
+				struct ieee80211_vif *vif,
+				struct ieee80211_sta *sta);
+void ath12k_mac_op_link_sta_rc_update(struct ieee80211_hw *hw,
+				      struct ieee80211_vif *vif,
+				      struct ieee80211_link_sta *link_sta,
+				      u32 changed);
+int ath12k_mac_op_conf_tx(struct ieee80211_hw *hw,
+			  struct ieee80211_vif *vif,
+			  unsigned int link_id, u16 ac,
+			  const struct ieee80211_tx_queue_params *params);
+int ath12k_mac_op_set_antenna(struct ieee80211_hw *hw, int radio_idx,
+			      u32 tx_ant, u32 rx_ant);
+int ath12k_mac_op_get_antenna(struct ieee80211_hw *hw, int radio_idx,
+			      u32 *tx_ant, u32 *rx_ant);
+int ath12k_mac_op_ampdu_action(struct ieee80211_hw *hw,
+			       struct ieee80211_vif *vif,
+			       struct ieee80211_ampdu_params *params);
+int ath12k_mac_op_add_chanctx(struct ieee80211_hw *hw,
+			      struct ieee80211_chanctx_conf *ctx);
+void ath12k_mac_op_remove_chanctx(struct ieee80211_hw *hw,
+				  struct ieee80211_chanctx_conf *ctx);
+void ath12k_mac_op_change_chanctx(struct ieee80211_hw *hw,
+				  struct ieee80211_chanctx_conf *ctx,
+				  u32 changed);
+int
+ath12k_mac_op_assign_vif_chanctx(struct ieee80211_hw *hw,
+				 struct ieee80211_vif *vif,
+				 struct ieee80211_bss_conf *link_conf,
+				 struct ieee80211_chanctx_conf *ctx);
+void
+ath12k_mac_op_unassign_vif_chanctx(struct ieee80211_hw *hw,
+				   struct ieee80211_vif *vif,
+				   struct ieee80211_bss_conf *link_conf,
+				   struct ieee80211_chanctx_conf *ctx);
+int
+ath12k_mac_op_switch_vif_chanctx(struct ieee80211_hw *hw,
+				 struct ieee80211_vif_chanctx_switch *vifs,
+				 int n_vifs,
+				 enum ieee80211_chanctx_switch_mode mode);
+int ath12k_mac_op_set_rts_threshold(struct ieee80211_hw *hw,
+				    int radio_idx, u32 value);
+int ath12k_mac_op_set_frag_threshold(struct ieee80211_hw *hw,
+				     int radio_idx, u32 value);
+int
+ath12k_mac_op_set_bitrate_mask(struct ieee80211_hw *hw,
+			       struct ieee80211_vif *vif,
+			       const struct cfg80211_bitrate_mask *mask);
+int ath12k_mac_op_get_survey(struct ieee80211_hw *hw, int idx,
+			     struct survey_info *survey);
+void ath12k_mac_op_flush(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+			 u32 queues, bool drop);
+void ath12k_mac_op_sta_statistics(struct ieee80211_hw *hw,
+				  struct ieee80211_vif *vif,
+				  struct ieee80211_sta *sta,
+				  struct station_info *sinfo);
+void ath12k_mac_op_link_sta_statistics(struct ieee80211_hw *hw,
+				       struct ieee80211_vif *vif,
+				       struct ieee80211_link_sta *link_sta,
+				       struct link_station_info *link_sinfo);
+int ath12k_mac_op_remain_on_channel(struct ieee80211_hw *hw,
+				    struct ieee80211_vif *vif,
+				    struct ieee80211_channel *chan,
+				    int duration,
+				    enum ieee80211_roc_type type);
+int ath12k_mac_op_cancel_remain_on_channel(struct ieee80211_hw *hw,
+					   struct ieee80211_vif *vif);
+int ath12k_mac_op_change_sta_links(struct ieee80211_hw *hw,
+				   struct ieee80211_vif *vif,
+				   struct ieee80211_sta *sta,
+				   u16 old_links, u16 new_links);
+bool ath12k_mac_op_can_activate_links(struct ieee80211_hw *hw,
+				      struct ieee80211_vif *vif,
+				      u16 active_links);
+int ath12k_mac_op_get_txpower(struct ieee80211_hw *hw,
+			      struct ieee80211_vif *vif,
+			      unsigned int link_id,
+			      int *dbm);
 #endif
diff --git a/drivers/net/wireless/ath/ath12k/testmode.c b/drivers/net/wireless/ath/ath12k/testmode.c
index fb6af7ccf71f..05a65970c862 100644
--- a/drivers/net/wireless/ath/ath12k/testmode.c
+++ b/drivers/net/wireless/ath/ath12k/testmode.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
 #include "testmode.h"
@@ -393,3 +393,4 @@ int ath12k_tm_cmd(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		return -EOPNOTSUPP;
 	}
 }
+EXPORT_SYMBOL(ath12k_tm_cmd);
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hw.c b/drivers/net/wireless/ath/ath12k/wifi7/hw.c
index 909f7311619c..1acf6ffaea08 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hw.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hw.c
@@ -19,6 +19,10 @@
 #include "dp_rx.h"
 #include "../peer.h"
 #include "wmi.h"
+#include "../wow.h"
+#include "../debugfs.h"
+#include "../debugfs_sta.h"
+#include "../testmode.h"
 
 static const guid_t wcn7850_uuid = GUID_INIT(0xf634f534, 0x6147, 0x11ec,
 					     0x90, 0xd6, 0x02, 0x42,
@@ -1042,6 +1046,63 @@ static const struct ath12k_hw_params ath12k_wifi7_hw_params[] = {
 	},
 };
 
+static const struct ieee80211_ops ath12k_ops_wifi7 = {
+	.tx				= ath12k_mac_op_tx,
+	.wake_tx_queue			= ieee80211_handle_wake_tx_queue,
+	.start                          = ath12k_mac_op_start,
+	.stop                           = ath12k_mac_op_stop,
+	.reconfig_complete              = ath12k_mac_op_reconfig_complete,
+	.add_interface                  = ath12k_mac_op_add_interface,
+	.remove_interface		= ath12k_mac_op_remove_interface,
+	.update_vif_offload		= ath12k_mac_op_update_vif_offload,
+	.config                         = ath12k_mac_op_config,
+	.link_info_changed              = ath12k_mac_op_link_info_changed,
+	.vif_cfg_changed		= ath12k_mac_op_vif_cfg_changed,
+	.change_vif_links               = ath12k_mac_op_change_vif_links,
+	.configure_filter		= ath12k_mac_op_configure_filter,
+	.hw_scan                        = ath12k_mac_op_hw_scan,
+	.cancel_hw_scan                 = ath12k_mac_op_cancel_hw_scan,
+	.set_key                        = ath12k_mac_op_set_key,
+	.set_rekey_data	                = ath12k_mac_op_set_rekey_data,
+	.sta_state                      = ath12k_mac_op_sta_state,
+	.sta_set_txpwr			= ath12k_mac_op_sta_set_txpwr,
+	.link_sta_rc_update		= ath12k_mac_op_link_sta_rc_update,
+	.conf_tx                        = ath12k_mac_op_conf_tx,
+	.set_antenna			= ath12k_mac_op_set_antenna,
+	.get_antenna			= ath12k_mac_op_get_antenna,
+	.ampdu_action			= ath12k_mac_op_ampdu_action,
+	.add_chanctx			= ath12k_mac_op_add_chanctx,
+	.remove_chanctx			= ath12k_mac_op_remove_chanctx,
+	.change_chanctx			= ath12k_mac_op_change_chanctx,
+	.assign_vif_chanctx		= ath12k_mac_op_assign_vif_chanctx,
+	.unassign_vif_chanctx		= ath12k_mac_op_unassign_vif_chanctx,
+	.switch_vif_chanctx		= ath12k_mac_op_switch_vif_chanctx,
+	.get_txpower			= ath12k_mac_op_get_txpower,
+	.set_rts_threshold		= ath12k_mac_op_set_rts_threshold,
+	.set_frag_threshold		= ath12k_mac_op_set_frag_threshold,
+	.set_bitrate_mask		= ath12k_mac_op_set_bitrate_mask,
+	.get_survey			= ath12k_mac_op_get_survey,
+	.flush				= ath12k_mac_op_flush,
+	.sta_statistics			= ath12k_mac_op_sta_statistics,
+	.link_sta_statistics		= ath12k_mac_op_link_sta_statistics,
+	.remain_on_channel              = ath12k_mac_op_remain_on_channel,
+	.cancel_remain_on_channel       = ath12k_mac_op_cancel_remain_on_channel,
+	.change_sta_links               = ath12k_mac_op_change_sta_links,
+	.can_activate_links             = ath12k_mac_op_can_activate_links,
+#ifdef CONFIG_PM
+	.suspend			= ath12k_wow_op_suspend,
+	.resume				= ath12k_wow_op_resume,
+	.set_wakeup			= ath12k_wow_op_set_wakeup,
+#endif
+#ifdef CONFIG_ATH12K_DEBUGFS
+	.vif_add_debugfs                = ath12k_debugfs_op_vif_add,
+#endif
+	CFG80211_TESTMODE_CMD(ath12k_tm_cmd)
+#ifdef CONFIG_ATH12K_DEBUGFS
+	.link_sta_add_debugfs           = ath12k_debugfs_link_sta_op_add,
+#endif
+};
+
 int ath12k_wifi7_hw_init(struct ath12k_base *ab)
 {
 	const struct ath12k_hw_params *hw_params = NULL;
@@ -1061,6 +1122,7 @@ int ath12k_wifi7_hw_init(struct ath12k_base *ab)
 	}
 
 	ab->hw_params = hw_params;
+	ab->ath12k_ops = &ath12k_ops_wifi7;
 
 	ath12k_info(ab, "Wi-Fi 7 Hardware name: %s\n", ab->hw_params->name);
 
diff --git a/drivers/net/wireless/ath/ath12k/wow.c b/drivers/net/wireless/ath/ath12k/wow.c
index dce9bd0bcaef..b1af8613b810 100644
--- a/drivers/net/wireless/ath/ath12k/wow.c
+++ b/drivers/net/wireless/ath/ath12k/wow.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2020 The Linux Foundation. All rights reserved.
- * Copyright (c) 2022-2025 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
 #include <linux/delay.h>
@@ -918,6 +918,7 @@ int ath12k_wow_op_suspend(struct ieee80211_hw *hw,
 exit:
 	return ret ? 1 : 0;
 }
+EXPORT_SYMBOL(ath12k_wow_op_suspend);
 
 void ath12k_wow_op_set_wakeup(struct ieee80211_hw *hw, bool enabled)
 {
@@ -928,6 +929,7 @@ void ath12k_wow_op_set_wakeup(struct ieee80211_hw *hw, bool enabled)
 
 	device_set_wakeup_enable(ar->ab->dev, enabled);
 }
+EXPORT_SYMBOL(ath12k_wow_op_set_wakeup);
 
 int ath12k_wow_op_resume(struct ieee80211_hw *hw)
 {
@@ -1000,6 +1002,7 @@ int ath12k_wow_op_resume(struct ieee80211_hw *hw)
 
 	return ret;
 }
+EXPORT_SYMBOL(ath12k_wow_op_resume);
 
 int ath12k_wow_init(struct ath12k *ar)
 {
-- 
2.34.1


