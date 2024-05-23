Return-Path: <linux-wireless+bounces-7981-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5C18CCB2D
	for <lists+linux-wireless@lfdr.de>; Thu, 23 May 2024 05:32:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 612B3283258
	for <lists+linux-wireless@lfdr.de>; Thu, 23 May 2024 03:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AA5C42040;
	Thu, 23 May 2024 03:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="b4CALF4d"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4B78005C
	for <linux-wireless@vger.kernel.org>; Thu, 23 May 2024 03:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716435142; cv=none; b=qdYqE6hME/bjjZXufEkVGu1/rrJKeDj5DecwJ/olqXXFC3UEtSTXqz7//xcRcgsGMwBNaBMRW3+swnQzQmVB7YzZUpgwvEsSormpvR5svze325Y0whaRiQ9qEdj1PpCOXRMd78Z7tzoKP/SyDYEvU6oZ2oNVSvNl1cp+j6lEmx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716435142; c=relaxed/simple;
	bh=loIgDwHt8k9HQgRE8mz8hIZFCLS7rBlKw+NN6ZPYhCs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i2mQIS0SGVw4Fv70sqJcFHC0lPITjS5l65gBwCZdTNxJCc/r61zNzGvEwRwh776mJoBGirqTwip7AKP25/5CVQ/OvWOmixzYp5Q4Jra1VW6TUXn6dba5EKbEmY4A69u0hwNTNXuL92rOCMVo/cCNhsxw6DEYdRqWu6tUepTlAS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=b4CALF4d; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44MNgvdV025789;
	Thu, 23 May 2024 03:32:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=tJ2H6OaUAq8uHyA3Qq0yuZgg5tWg1cFfXsueYgto5XI=; b=b4
	CALF4dBpUaJHweRnZv8kIXejMY347ZhhbngBPxtP/oPtWXxPZ6FTYupljwodqvlk
	dppY02UrkFSVFaRIb9aUhTXvi4UzS0xVQnV4M1rQ2Bs9f64YgN/DGF+agTrt3nYL
	YH9sNYXIS9iH0Mfx4ARPitifhBebb3+x+Td+iAR+2aPVGgKsJjTxyZDAGh4Fs0ij
	eEaywJs5gxtT+aR1UmZlh/yFcj/llH3zEmmBbLAoF+3Gu0fcYTUKdrPrWV1oyt68
	k67zQKCHpEsTV3aKxQRdkmOxugZeojs+XMFSrZl2GfPG4sgqWzAmroscPtHxjwmP
	gQMPtPH4vLijNFZVXebg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y6pqcatcy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 May 2024 03:32:11 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44N3W9YP009753
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 May 2024 03:32:09 GMT
Received: from bqiang-SFF.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 22 May 2024 20:32:07 -0700
From: Baochen Qiang <quic_bqiang@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_bqiang@quicinc.com>
Subject: [PATCH v2 7/7] wifi: ath12k: handle keepalive during WoWLAN suspend and resume
Date: Thu, 23 May 2024 11:31:43 +0800
Message-ID: <20240523033143.21677-8-quic_bqiang@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240523033143.21677-1-quic_bqiang@quicinc.com>
References: <20240523033143.21677-1-quic_bqiang@quicinc.com>
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
X-Proofpoint-ORIG-GUID: cPhu1nRbnla0tFK0XRc5FpUXuNHN4D2E
X-Proofpoint-GUID: cPhu1nRbnla0tFK0XRc5FpUXuNHN4D2E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-23_01,2024-05-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 priorityscore=1501 bulkscore=0 adultscore=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405230023

With WoWLAN enabled and after sleeping for a rather long time,
we are seeing that with some APs, it is not able to wake up
the STA though the correct wake up pattern has been configured.
This is because the host doesn't send keepalive command to
firmware, thus firmware will not send any packet to the AP and
after a specific time the AP kicks out the STA.

So enable keepalive before going to suspend and disable it after
resume back.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4

Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 31 ++++++++++++++++++
 drivers/net/wireless/ath/ath12k/mac.h |  4 +++
 drivers/net/wireless/ath/ath12k/wmi.c | 38 ++++++++++++++++++++++
 drivers/net/wireless/ath/ath12k/wmi.h | 46 +++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath12k/wow.c | 34 ++++++++++++++++++++
 5 files changed, 153 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 098ffe5750c7..5efa8380c7fe 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -9526,3 +9526,34 @@ int ath12k_mac_allocate(struct ath12k_base *ab)
 
 	return ret;
 }
+
+int ath12k_mac_vif_set_keepalive(struct ath12k_vif *arvif,
+				 enum wmi_sta_keepalive_method method,
+				 u32 interval)
+{
+	struct wmi_sta_keepalive_arg arg = {};
+	struct ath12k *ar = arvif->ar;
+	int ret;
+
+	lockdep_assert_held(&ar->conf_mutex);
+
+	if (arvif->vdev_type != WMI_VDEV_TYPE_STA)
+		return 0;
+
+	if (!test_bit(WMI_TLV_SERVICE_STA_KEEP_ALIVE, ar->ab->wmi_ab.svc_map))
+		return 0;
+
+	arg.vdev_id = arvif->vdev_id;
+	arg.enabled = 1;
+	arg.method = method;
+	arg.interval = interval;
+
+	ret = ath12k_wmi_sta_keepalive(ar, &arg);
+	if (ret) {
+		ath12k_warn(ar->ab, "failed to set keepalive on vdev %i: %d\n",
+			    arvif->vdev_id, ret);
+		return ret;
+	}
+
+	return 0;
+}
diff --git a/drivers/net/wireless/ath/ath12k/mac.h b/drivers/net/wireless/ath/ath12k/mac.h
index 69fd282b9dd3..2c6cb144827a 100644
--- a/drivers/net/wireless/ath/ath12k/mac.h
+++ b/drivers/net/wireless/ath/ath12k/mac.h
@@ -9,6 +9,7 @@
 
 #include <net/mac80211.h>
 #include <net/cfg80211.h>
+#include "wmi.h"
 
 struct ath12k;
 struct ath12k_base;
@@ -81,5 +82,8 @@ int ath12k_mac_rfkill_config(struct ath12k *ar);
 int ath12k_mac_wait_tx_complete(struct ath12k *ar);
 void ath12k_mac_handle_beacon(struct ath12k *ar, struct sk_buff *skb);
 void ath12k_mac_handle_beacon_miss(struct ath12k *ar, u32 vdev_id);
+int ath12k_mac_vif_set_keepalive(struct ath12k_vif *arvif,
+				 enum wmi_sta_keepalive_method method,
+				 u32 interval);
 
 #endif
diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index ebbac036b330..3b244fe006b8 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -8039,3 +8039,41 @@ int ath12k_wmi_gtk_rekey_getinfo(struct ath12k *ar,
 		   arvif->vdev_id);
 	return ath12k_wmi_cmd_send(ar->wmi, skb, WMI_GTK_OFFLOAD_CMDID);
 }
+
+int ath12k_wmi_sta_keepalive(struct ath12k *ar,
+			     const struct wmi_sta_keepalive_arg *arg)
+{
+	struct wmi_sta_keepalive_arp_resp_params *arp;
+	struct ath12k_wmi_pdev *wmi = ar->wmi;
+	struct wmi_sta_keepalive_cmd *cmd;
+	struct sk_buff *skb;
+	size_t len;
+
+	len = sizeof(*cmd) + sizeof(*arp);
+	skb = ath12k_wmi_alloc_skb(wmi->wmi_ab, len);
+	if (!skb)
+		return -ENOMEM;
+
+	cmd = (struct wmi_sta_keepalive_cmd *)skb->data;
+	cmd->tlv_header = ath12k_wmi_tlv_cmd_hdr(WMI_TAG_STA_KEEPALIVE_CMD, sizeof(*cmd));
+	cmd->vdev_id = cpu_to_le32(arg->vdev_id);
+	cmd->enabled = cpu_to_le32(arg->enabled);
+	cmd->interval = cpu_to_le32(arg->interval);
+	cmd->method = cpu_to_le32(arg->method);
+
+	arp = (struct wmi_sta_keepalive_arp_resp_params *)(cmd + 1);
+	arp->tlv_header = ath12k_wmi_tlv_cmd_hdr(WMI_TAG_STA_KEEPALVE_ARP_RESPONSE,
+						 sizeof(*arp));
+	if (arg->method == WMI_STA_KEEPALIVE_METHOD_UNSOLICITED_ARP_RESPONSE ||
+	    arg->method == WMI_STA_KEEPALIVE_METHOD_GRATUITOUS_ARP_REQUEST) {
+		arp->src_ip4_addr = cpu_to_le32(arg->src_ip4_addr);
+		arp->dest_ip4_addr = cpu_to_le32(arg->dest_ip4_addr);
+		ether_addr_copy(arp->dest_mac_addr.addr, arg->dest_mac_addr);
+	}
+
+	ath12k_dbg(ar->ab, ATH12K_DBG_WMI,
+		   "wmi sta keepalive vdev %d enabled %d method %d interval %d\n",
+		   arg->vdev_id, arg->enabled, arg->method, arg->interval);
+
+	return ath12k_wmi_cmd_send(wmi, skb, WMI_STA_KEEPALIVE_CMDID);
+}
diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
index be8c4117708c..b81942381a87 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -5395,6 +5395,50 @@ struct wmi_gtk_rekey_offload_cmd {
 	u8 replay_ctr[GTK_REPLAY_COUNTER_BYTES];
 } __packed;
 
+struct wmi_sta_keepalive_cmd {
+	__le32 tlv_header;
+	__le32 vdev_id;
+	__le32 enabled;
+
+	/* WMI_STA_KEEPALIVE_METHOD_ */
+	__le32 method;
+
+	/* in seconds */
+	__le32 interval;
+
+	/* following this structure is the TLV for struct
+	 * wmi_sta_keepalive_arp_resp_params
+	 */
+} __packed;
+
+struct wmi_sta_keepalive_arp_resp_params {
+	__le32 tlv_header;
+	__le32 src_ip4_addr;
+	__le32 dest_ip4_addr;
+	struct ath12k_wmi_mac_addr_params dest_mac_addr;
+} __packed;
+
+struct wmi_sta_keepalive_arg {
+	u32 vdev_id;
+	u32 enabled;
+	u32 method;
+	u32 interval;
+	u32 src_ip4_addr;
+	u32 dest_ip4_addr;
+	const u8 dest_mac_addr[ETH_ALEN];
+};
+
+enum wmi_sta_keepalive_method {
+	WMI_STA_KEEPALIVE_METHOD_NULL_FRAME = 1,
+	WMI_STA_KEEPALIVE_METHOD_UNSOLICITED_ARP_RESPONSE = 2,
+	WMI_STA_KEEPALIVE_METHOD_ETHERNET_LOOPBACK = 3,
+	WMI_STA_KEEPALIVE_METHOD_GRATUITOUS_ARP_REQUEST = 4,
+	WMI_STA_KEEPALIVE_METHOD_MGMT_VENDOR_ACTION = 5,
+};
+
+#define WMI_STA_KEEPALIVE_INTERVAL_DEFAULT	30
+#define WMI_STA_KEEPALIVE_INTERVAL_DISABLE	0
+
 void ath12k_wmi_init_qcn9274(struct ath12k_base *ab,
 			     struct ath12k_wmi_resource_config_arg *config);
 void ath12k_wmi_init_wcn7850(struct ath12k_base *ab,
@@ -5566,5 +5610,7 @@ int ath12k_wmi_gtk_rekey_offload(struct ath12k *ar,
 				 struct ath12k_vif *arvif, bool enable);
 int ath12k_wmi_gtk_rekey_getinfo(struct ath12k *ar,
 				 struct ath12k_vif *arvif);
+int ath12k_wmi_sta_keepalive(struct ath12k *ar,
+			     const struct wmi_sta_keepalive_arg *arg);
 
 #endif
diff --git a/drivers/net/wireless/ath/ath12k/wow.c b/drivers/net/wireless/ath/ath12k/wow.c
index 8e30201f6a89..41b3d6ccbe26 100644
--- a/drivers/net/wireless/ath/ath12k/wow.c
+++ b/drivers/net/wireless/ath/ath12k/wow.c
@@ -671,6 +671,24 @@ static int ath12k_wow_protocol_offload(struct ath12k *ar, bool enable)
 	return 0;
 }
 
+static int ath12k_wow_set_keepalive(struct ath12k *ar,
+				    enum wmi_sta_keepalive_method method,
+				    u32 interval)
+{
+	struct ath12k_vif *arvif;
+	int ret;
+
+	lockdep_assert_held(&ar->conf_mutex);
+
+	list_for_each_entry(arvif, &ar->arvifs, list) {
+		ret = ath12k_mac_vif_set_keepalive(arvif, method, interval);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 int ath12k_wow_op_suspend(struct ieee80211_hw *hw,
 			  struct cfg80211_wowlan *wowlan)
 {
@@ -715,6 +733,14 @@ int ath12k_wow_op_suspend(struct ieee80211_hw *hw,
 		goto cleanup;
 	}
 
+	ret = ath12k_wow_set_keepalive(ar,
+				       WMI_STA_KEEPALIVE_METHOD_NULL_FRAME,
+				       WMI_STA_KEEPALIVE_INTERVAL_DEFAULT);
+	if (ret) {
+		ath12k_warn(ar->ab, "failed to enable wow keepalive: %d\n", ret);
+		goto cleanup;
+	}
+
 	ret = ath12k_wow_enable(ar);
 	if (ret) {
 		ath12k_warn(ar->ab, "failed to start wow: %d\n", ret);
@@ -795,6 +821,14 @@ int ath12k_wow_op_resume(struct ieee80211_hw *hw)
 		goto exit;
 	}
 
+	ret = ath12k_wow_set_keepalive(ar,
+				       WMI_STA_KEEPALIVE_METHOD_NULL_FRAME,
+				       WMI_STA_KEEPALIVE_INTERVAL_DISABLE);
+	if (ret) {
+		ath12k_warn(ar->ab, "failed to disable wow keepalive: %d\n", ret);
+		goto exit;
+	}
+
 exit:
 	if (ret) {
 		switch (ah->state) {
-- 
2.25.1


