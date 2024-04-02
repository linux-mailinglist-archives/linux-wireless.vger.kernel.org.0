Return-Path: <linux-wireless+bounces-5772-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E5C895E6E
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Apr 2024 23:06:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4979AB21649
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Apr 2024 21:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D30F15E7F8;
	Tue,  2 Apr 2024 21:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="l7VH1v1D"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7729315E5AD
	for <linux-wireless@vger.kernel.org>; Tue,  2 Apr 2024 21:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712091959; cv=none; b=Qap6aVtCk7+pOhW51jpuMqNIxm5qXHB5bfeItKb9tF71paJ0aqyLTMjxpn/uoXKBqhKPYtfLr256MgPNm0+KjsL1q7zpZsVnKkN8KkjO3NFFX+0+tXShEshTeWe3J1ZnGBEmy2vH3BJjiX8EIDFlkyM3cLJPf2zIG3Zc09t7KjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712091959; c=relaxed/simple;
	bh=1BQ/RCXT921Y5VTirdA2lTU+hzKOPhdugt7085vGtjw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xb9QhOjxPLVSnTBmIWrktJBFeIMpv6MjoErVtqaA9QMmURg1d6LtbQbNZFiJ2Ysr9Kd6bfl3/FvnoBdsJCf//cD5xBqOCtJDPW+j/xsCc7y/oUCfKZ025UbLR7O91xVxL/cqSDLJVOsiuM4D3I7pM79vstOVUUR+DiYwQfUDTUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=l7VH1v1D; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 432KjD0W006382;
	Tue, 2 Apr 2024 21:05:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=VSQJSNdgR9mHGwVZR7iAlXKtcJiMV85s+w7E0lztNl8=; b=l7
	VH1v1DlUOlECXDVHQennvDkRPd66yXzb7Pm0lFVql3Oc+/vi7fiMrK614T9ZwviR
	4u+4FAHtY6ekvQJUot/1NRf3V+lW4dEYJiF4TmVRcXoTqRfq03fWIpPPIWHnxIcl
	27Q4w7mJi2hRy40HCTxAFWZmXM/Ff0U9BO/XekbATL1ZUoYkJwbeKr2EhUgy4e9z
	gMCm3bsUHVSc8BsV3BEC1mRI9hw+iLi0THWAZyJ/E+oakmoIaOZiORoKt7h2TVfo
	WrPOXeDsfyeg6VP5qzWlwREfFVy3iZBTguA1Mlh8J0WXFyPQFeE1egEOtUq1iOoN
	A9E/yupDkMzoP8Qf7iuQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x8ex7t0jq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Apr 2024 21:05:51 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 432L5okc031934
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 2 Apr 2024 21:05:50 GMT
Received: from alokad-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 2 Apr 2024 14:05:49 -0700
From: Aloka Dixit <quic_alokad@quicinc.com>
To: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
CC: Aloka Dixit <quic_alokad@quicinc.com>
Subject: [PATCH 4/9] wifi: ath12k: create a structure for WMI vdev up parameters
Date: Tue, 2 Apr 2024 14:05:33 -0700
Message-ID: <20240402210538.7308-5-quic_alokad@quicinc.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20240402210538.7308-1-quic_alokad@quicinc.com>
References: <20240402210538.7308-1-quic_alokad@quicinc.com>
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
X-Proofpoint-GUID: h8eAf0BQhUScaocZtSJ98zSHJORXs7M5
X-Proofpoint-ORIG-GUID: h8eAf0BQhUScaocZtSJ98zSHJORXs7M5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-02_14,2024-04-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 clxscore=1015 phishscore=0 bulkscore=0 suspectscore=0
 lowpriorityscore=0 spamscore=0 mlxscore=0 malwarescore=0 impostorscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2404020157

Host needs to send multiple BSSID configurations to firmware for
each vdev in ath12k_wmi_vdev_up() for AP mode. This function accepts
individual input parameters hence any new argument will require changes
to all callers. Most of these will use default value (0 or NULL).
Create a structure for the function arguments and include objects with
all members initialized to zero to minimize future changes.

Tested-on : QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Signed-off-by: Aloka Dixit <quic_alokad@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 30 ++++++++++++++++++++-------
 drivers/net/wireless/ath/ath12k/wmi.c | 10 ++++-----
 drivers/net/wireless/ath/ath12k/wmi.h |  9 ++++++--
 3 files changed, 35 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 0a23d0b20f0c..39d1660a78bc 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -810,9 +810,12 @@ static int ath12k_mac_vdev_setup_sync(struct ath12k *ar)
 
 static int ath12k_monitor_vdev_up(struct ath12k *ar, int vdev_id)
 {
+	struct ath12k_wmi_vdev_up_params params = {};
 	int ret;
 
-	ret = ath12k_wmi_vdev_up(ar, vdev_id, 0, ar->mac_addr);
+	params.vdev_id = vdev_id;
+	params.bssid = ar->mac_addr;
+	ret = ath12k_wmi_vdev_up(ar, &params);
 	if (ret) {
 		ath12k_warn(ar->ab, "failed to put up monitor vdev %i: %d\n",
 			    vdev_id, ret);
@@ -829,6 +832,7 @@ static int ath12k_mac_monitor_vdev_start(struct ath12k *ar, int vdev_id,
 {
 	struct ieee80211_channel *channel;
 	struct wmi_vdev_start_req_arg arg = {};
+	struct ath12k_wmi_vdev_up_params params = {};
 	int ret;
 
 	lockdep_assert_held(&ar->conf_mutex);
@@ -869,7 +873,9 @@ static int ath12k_mac_monitor_vdev_start(struct ath12k *ar, int vdev_id,
 		return ret;
 	}
 
-	ret = ath12k_wmi_vdev_up(ar, vdev_id, 0, ar->mac_addr);
+	params.vdev_id = vdev_id;
+	params.bssid = ar->mac_addr;
+	ret = ath12k_wmi_vdev_up(ar, &params);
 	if (ret) {
 		ath12k_warn(ar->ab, "failed to put up monitor vdev %i: %d\n",
 			    vdev_id, ret);
@@ -1305,6 +1311,7 @@ static int ath12k_mac_setup_bcn_tmpl(struct ath12k_vif *arvif)
 static void ath12k_control_beaconing(struct ath12k_vif *arvif,
 				     struct ieee80211_bss_conf *info)
 {
+	struct ath12k_wmi_vdev_up_params params = {};
 	struct ath12k *ar = arvif->ar;
 	int ret;
 
@@ -1332,8 +1339,10 @@ static void ath12k_control_beaconing(struct ath12k_vif *arvif,
 
 	ether_addr_copy(arvif->bssid, info->bssid);
 
-	ret = ath12k_wmi_vdev_up(arvif->ar, arvif->vdev_id, arvif->aid,
-				 arvif->bssid);
+	params.vdev_id = arvif->vdev_id;
+	params.aid = arvif->aid;
+	params.bssid = arvif->bssid;
+	ret = ath12k_wmi_vdev_up(arvif->ar, &params);
 	if (ret) {
 		ath12k_warn(ar->ab, "failed to bring up vdev %d: %i\n",
 			    arvif->vdev_id, ret);
@@ -2411,6 +2420,7 @@ static void ath12k_bss_assoc(struct ath12k *ar,
 			     struct ieee80211_bss_conf *bss_conf)
 {
 	struct ieee80211_vif *vif = arvif->vif;
+	struct ath12k_wmi_vdev_up_params params = {};
 	struct ath12k_wmi_peer_assoc_arg peer_arg;
 	struct ieee80211_sta *ap_sta;
 	struct ath12k_peer *peer;
@@ -2462,7 +2472,10 @@ static void ath12k_bss_assoc(struct ath12k *ar,
 	arvif->aid = vif->cfg.aid;
 	ether_addr_copy(arvif->bssid, bss_conf->bssid);
 
-	ret = ath12k_wmi_vdev_up(ar, arvif->vdev_id, arvif->aid, arvif->bssid);
+	params.vdev_id = arvif->vdev_id;
+	params.aid = arvif->aid;
+	params.bssid = arvif->bssid;
+	ret = ath12k_wmi_vdev_up(ar, &params);
 	if (ret) {
 		ath12k_warn(ar->ab, "failed to set vdev %d up: %d\n",
 			    arvif->vdev_id, ret);
@@ -6561,6 +6574,7 @@ ath12k_mac_update_vif_chan(struct ath12k *ar,
 			   struct ieee80211_vif_chanctx_switch *vifs,
 			   int n_vifs)
 {
+	struct ath12k_wmi_vdev_up_params params = {};
 	struct ath12k_base *ab = ar->ab;
 	struct ath12k_vif *arvif;
 	int ret;
@@ -6641,8 +6655,10 @@ ath12k_mac_update_vif_chan(struct ath12k *ar,
 			ath12k_warn(ab, "failed to update bcn tmpl during csa: %d\n",
 				    ret);
 
-		ret = ath12k_wmi_vdev_up(arvif->ar, arvif->vdev_id, arvif->aid,
-					 arvif->bssid);
+		params.vdev_id = arvif->vdev_id;
+		params.aid = arvif->aid;
+		params.bssid = arvif->bssid;
+		ret = ath12k_wmi_vdev_up(arvif->ar, &params);
 		if (ret) {
 			ath12k_warn(ab, "failed to bring vdev up %d: %d\n",
 				    arvif->vdev_id, ret);
diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index eb515456c65a..429263d5a8b7 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -1103,7 +1103,7 @@ int ath12k_wmi_vdev_start(struct ath12k *ar, struct wmi_vdev_start_req_arg *arg,
 	return ret;
 }
 
-int ath12k_wmi_vdev_up(struct ath12k *ar, u32 vdev_id, u32 aid, const u8 *bssid)
+int ath12k_wmi_vdev_up(struct ath12k *ar, struct ath12k_wmi_vdev_up_params *params)
 {
 	struct ath12k_wmi_pdev *wmi = ar->wmi;
 	struct wmi_vdev_up_cmd *cmd;
@@ -1118,14 +1118,14 @@ int ath12k_wmi_vdev_up(struct ath12k *ar, u32 vdev_id, u32 aid, const u8 *bssid)
 
 	cmd->tlv_header = ath12k_wmi_tlv_cmd_hdr(WMI_TAG_VDEV_UP_CMD,
 						 sizeof(*cmd));
-	cmd->vdev_id = cpu_to_le32(vdev_id);
-	cmd->vdev_assoc_id = cpu_to_le32(aid);
+	cmd->vdev_id = cpu_to_le32(params->vdev_id);
+	cmd->vdev_assoc_id = cpu_to_le32(params->aid);
 
-	ether_addr_copy(cmd->vdev_bssid.addr, bssid);
+	ether_addr_copy(cmd->vdev_bssid.addr, params->bssid);
 
 	ath12k_dbg(ar->ab, ATH12K_DBG_WMI,
 		   "WMI mgmt vdev up id 0x%x assoc id %d bssid %pM\n",
-		   vdev_id, aid, bssid);
+		   params->vdev_id, params->aid, params->bssid);
 
 	ret = ath12k_wmi_cmd_send(wmi, skb, WMI_VDEV_UP_CMDID);
 	if (ret) {
diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
index adc72c0f2862..2ad32a717d83 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -2740,6 +2740,12 @@ struct wmi_vdev_delete_cmd {
 	__le32 vdev_id;
 } __packed;
 
+struct ath12k_wmi_vdev_up_params {
+	u32 vdev_id;
+	u32 aid;
+	const u8 *bssid;
+};
+
 struct wmi_vdev_up_cmd {
 	__le32 tlv_header;
 	__le32 vdev_id;
@@ -4836,8 +4842,7 @@ int ath12k_wmi_bcn_tmpl(struct ath12k *ar, u32 vdev_id,
 			struct ieee80211_mutable_offsets *offs,
 			struct sk_buff *bcn);
 int ath12k_wmi_vdev_down(struct ath12k *ar, u8 vdev_id);
-int ath12k_wmi_vdev_up(struct ath12k *ar, u32 vdev_id, u32 aid,
-		       const u8 *bssid);
+int ath12k_wmi_vdev_up(struct ath12k *ar, struct ath12k_wmi_vdev_up_params *params);
 int ath12k_wmi_vdev_stop(struct ath12k *ar, u8 vdev_id);
 int ath12k_wmi_vdev_start(struct ath12k *ar, struct wmi_vdev_start_req_arg *arg,
 			  bool restart);
-- 
2.39.0


