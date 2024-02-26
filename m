Return-Path: <linux-wireless+bounces-3990-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A20D8669D6
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Feb 2024 07:03:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 848641C21052
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Feb 2024 06:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1430A1BC5A;
	Mon, 26 Feb 2024 06:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="gja1hTJB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379271BC35
	for <linux-wireless@vger.kernel.org>; Mon, 26 Feb 2024 06:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708927370; cv=none; b=QR4EZ/cAbvU4RiZMhhOdkMbLThVFT7ADsWHeF/hyjXistqd1aiARhw0j7NkgjZ1n3JN+qxByRQc71v1isgG0un850JTkQ4a+PW9kPzJ9/fDaKCuWRczHYSj4JnU4HWZqbOiTV4x/eR7Z4pi0s5U3JkhdEXXucISeoQtXLE/AK9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708927370; c=relaxed/simple;
	bh=moHFcc+SeDnmn4rq5zoRK7gdMOyHtmw0Ic4w7WTUl2E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LLMYXKtzIZj/lPydv3opqCZ74rP14koeqGFtoBZinjMhx0NhwcTdJhzdxXd0/zZqEq9dvd3jXFcclBbdDXm+0aFNRFFLIB5T/0aX0CYDKxcRek3cni7LmmlNK9qxvLx8nJEnIyUinxldcDB8VBg6WwUpjJf9dgfwkIwGs87qdKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=gja1hTJB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41Q5soD4018232;
	Mon, 26 Feb 2024 06:02:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=D+5I1GR1zWLe8NjR1ZqehIEV+5l8TfVKF8mkQfKddzA=; b=gj
	a1hTJBW5c2M2Wrs4lxNCW4bKs4gOu5cMsNAVR9fHV2a+f332ShmwoLxPAKWhKKV1
	EshVnoyg4J8RIikxCGFOZ0+MXhE8+69mE1hZq8nTsYt3gxmtmclnOkSawJx6bNrM
	JmkiPb+CA+c1pgFeZU7kFjOV/H8tShk7JQLt1Vh90nZBepPBHglZD0Tr1u6Ka+rF
	ebTUOgUS26vle13GcRTvdO/qVh3fPsAKvlfIhkN4vo5M2JiV1tb3SuVF6gq7oYed
	IP+lZZOkrE2g/q4Obf4fwSyD0GmREW+BBvSOYhdKr6PQJjvDnbHstl7Iym9bK+rC
	5YVUXIWTNwAu7OD5b6Qg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wgkxkr3n3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Feb 2024 06:02:44 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41Q62OHx016933
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Feb 2024 06:02:24 GMT
Received: from Mayan.qca.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sun, 25 Feb 2024 22:02:23 -0800
From: Kang Yang <quic_kangyang@quicinc.com>
To: <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_kangyang@quicinc.com>
Subject: [PATCH 3/6] wifi: ath11k: implement handling of P2P NoA event
Date: Mon, 26 Feb 2024 14:02:00 +0800
Message-ID: <20240226060203.2040444-4-quic_kangyang@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240226060203.2040444-1-quic_kangyang@quicinc.com>
References: <20240226060203.2040444-1-quic_kangyang@quicinc.com>
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
X-Proofpoint-ORIG-GUID: fRqeTJHP9vbpQ_SX20mTmVsnYA0_NoYO
X-Proofpoint-GUID: fRqeTJHP9vbpQ_SX20mTmVsnYA0_NoYO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-26_03,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 bulkscore=0 adultscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2402120000 definitions=main-2402260044

The NoA(Notice of Absence) attribute is used by the P2P Group Owner to
signal its absence due to power save timing, concurrent operation, or
off-channel scanning. It is also used in the P2P Presence Request-Response
mechanism.

The NoA attribute shall be present in the P2P IE in the beacon frames
transmitted by a P2P Group Owner when a NoA schedule is being advertised,
or when the CTWindow is non-zero.

So add support to update P2P information after P2P GO is up through
event WMI_P2P_NOA_EVENTID, and always put it in probe resp.

Create p2p.c and p2p.h for P2P related functions and definitions.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.37
Tested-on: QCA2066 hw2.1 PCI WLAN.HSP.1.1-03926.13-QCAHSPSWPL_V2_SILICONZ_CE-2.52297.2

Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/Makefile |   3 +-
 drivers/net/wireless/ath/ath11k/p2p.c    | 145 +++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/p2p.h    |  23 ++++
 drivers/net/wireless/ath/ath11k/wmi.c    |  57 ++++++++-
 drivers/net/wireless/ath/ath11k/wmi.h    |  31 +++++
 5 files changed, 257 insertions(+), 2 deletions(-)
 create mode 100644 drivers/net/wireless/ath/ath11k/p2p.c
 create mode 100644 drivers/net/wireless/ath/ath11k/p2p.h

diff --git a/drivers/net/wireless/ath/ath11k/Makefile b/drivers/net/wireless/ath/ath11k/Makefile
index 2c94d50ae36f..43d2d8ddcdc0 100644
--- a/drivers/net/wireless/ath/ath11k/Makefile
+++ b/drivers/net/wireless/ath/ath11k/Makefile
@@ -18,7 +18,8 @@ ath11k-y += core.o \
 	    dbring.o \
 	    hw.o \
 	    pcic.o \
-	    fw.o
+	    fw.o \
+	    p2p.o
 
 ath11k-$(CONFIG_ATH11K_DEBUGFS) += debugfs.o debugfs_htt_stats.o debugfs_sta.o
 ath11k-$(CONFIG_NL80211_TESTMODE) += testmode.o
diff --git a/drivers/net/wireless/ath/ath11k/p2p.c b/drivers/net/wireless/ath/ath11k/p2p.c
new file mode 100644
index 000000000000..bfaeea12bc09
--- /dev/null
+++ b/drivers/net/wireless/ath/ath11k/p2p.c
@@ -0,0 +1,145 @@
+// SPDX-License-Identifier: BSD-3-Clause-Clear
+/*
+ * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include "core.h"
+#include "wmi.h"
+#include "mac.h"
+#include "p2p.h"
+
+static void ath11k_p2p_noa_ie_fill(u8 *data, size_t len,
+				   const struct ath11k_wmi_p2p_noa_info *noa)
+{
+	struct ieee80211_p2p_noa_attr *noa_attr;
+	u8 ctwindow = u32_get_bits(noa->noa_attr, WMI_P2P_NOA_INFO_CTWIN_TU);
+	bool oppps = u32_get_bits(noa->noa_attr, WMI_P2P_NOA_INFO_OPP_PS);
+	__le16 *noa_attr_len;
+	u16 attr_len;
+	u8 noa_descriptors = u32_get_bits(noa->noa_attr,
+					   WMI_P2P_NOA_INFO_DESC_NUM);
+	int i;
+
+	/* P2P IE */
+	data[0] = WLAN_EID_VENDOR_SPECIFIC;
+	data[1] = len - 2;
+	data[2] = (WLAN_OUI_WFA >> 16) & 0xff;
+	data[3] = (WLAN_OUI_WFA >> 8) & 0xff;
+	data[4] = (WLAN_OUI_WFA >> 0) & 0xff;
+	data[5] = WLAN_OUI_TYPE_WFA_P2P;
+
+	/* NOA ATTR */
+	data[6] = IEEE80211_P2P_ATTR_ABSENCE_NOTICE;
+	noa_attr_len = (__le16 *)&data[7]; /* 2 bytes */
+	noa_attr = (struct ieee80211_p2p_noa_attr *)&data[9];
+
+	noa_attr->index = u32_get_bits(noa->noa_attr,
+				       WMI_P2P_NOA_INFO_INDEX);
+	noa_attr->oppps_ctwindow = ctwindow;
+	if (oppps)
+		noa_attr->oppps_ctwindow |= IEEE80211_P2P_OPPPS_ENABLE_BIT;
+
+	for (i = 0; i < noa_descriptors; i++) {
+		noa_attr->desc[i].count = noa->descriptors[i].type_count;
+		noa_attr->desc[i].duration =
+			cpu_to_le32(noa->descriptors[i].duration);
+		noa_attr->desc[i].interval =
+			cpu_to_le32(noa->descriptors[i].interval);
+		noa_attr->desc[i].start_time =
+			cpu_to_le32(noa->descriptors[i].start_time);
+	}
+
+	attr_len = 2; /* index + oppps_ctwindow */
+	attr_len += noa_descriptors * sizeof(struct ieee80211_p2p_noa_desc);
+	*noa_attr_len = __cpu_to_le16(attr_len);
+}
+
+static size_t
+ath11k_p2p_noa_ie_len_compute(const struct ath11k_wmi_p2p_noa_info *noa)
+{
+	size_t len = 0;
+
+	if (!(u32_get_bits(noa->noa_attr, WMI_P2P_NOA_INFO_DESC_NUM)) &&
+	    !(u32_get_bits(noa->noa_attr, WMI_P2P_NOA_INFO_OPP_PS)))
+		return 0;
+
+	len += 1 + 1 + 4; /* EID + len + OUI */
+	len += 1 + 2; /* noa attr + attr len */
+	len += 1 + 1; /* index + oppps_ctwindow */
+	len += u32_get_bits(noa->noa_attr, WMI_P2P_NOA_INFO_DESC_NUM) *
+			sizeof(struct ieee80211_p2p_noa_desc);
+
+	return len;
+}
+
+static void ath11k_p2p_noa_ie_assign(struct ath11k_vif *arvif, void *ie,
+				     size_t len)
+{
+	struct ath11k *ar = arvif->ar;
+
+	lockdep_assert_held(&ar->data_lock);
+
+	kfree(arvif->u.ap.noa_data);
+
+	arvif->u.ap.noa_data = ie;
+	arvif->u.ap.noa_len = len;
+}
+
+static void __ath11k_p2p_noa_update(struct ath11k_vif *arvif,
+				    const struct ath11k_wmi_p2p_noa_info *noa)
+{
+	struct ath11k *ar = arvif->ar;
+	void *ie;
+	size_t len;
+
+	lockdep_assert_held(&ar->data_lock);
+
+	ath11k_p2p_noa_ie_assign(arvif, NULL, 0);
+
+	len = ath11k_p2p_noa_ie_len_compute(noa);
+	if (!len)
+		return;
+
+	ie = kmalloc(len, GFP_ATOMIC);
+	if (!ie)
+		return;
+
+	ath11k_p2p_noa_ie_fill(ie, len, noa);
+	ath11k_p2p_noa_ie_assign(arvif, ie, len); }
+
+void ath11k_p2p_noa_update(struct ath11k_vif *arvif,
+			   const struct ath11k_wmi_p2p_noa_info *noa)
+{
+	struct ath11k *ar = arvif->ar;
+
+	spin_lock_bh(&ar->data_lock);
+	__ath11k_p2p_noa_update(arvif, noa);
+	spin_unlock_bh(&ar->data_lock);
+}
+
+static void ath11k_p2p_noa_update_vdev_iter(void *data, u8 *mac,
+					    struct ieee80211_vif *vif)
+{
+	struct ath11k_vif *arvif = ath11k_vif_to_arvif(vif);
+	struct ath11k_p2p_noa_arg *arg = data;
+
+	if (arvif->vdev_id != arg->vdev_id)
+		return;
+
+	ath11k_p2p_noa_update(arvif, arg->noa);
+}
+
+void ath11k_p2p_noa_update_by_vdev_id(struct ath11k *ar, u32 vdev_id,
+				      const struct ath11k_wmi_p2p_noa_info *noa)
+{
+	struct ath11k_p2p_noa_arg arg = {
+		.vdev_id = vdev_id,
+		.noa = noa,
+	};
+
+	ieee80211_iterate_active_interfaces_atomic(ar->hw,
+						   IEEE80211_IFACE_ITER_NORMAL,
+						   ath11k_p2p_noa_update_vdev_iter,
+						   &arg);
+}
+
diff --git a/drivers/net/wireless/ath/ath11k/p2p.h b/drivers/net/wireless/ath/ath11k/p2p.h
new file mode 100644
index 000000000000..ebd076f7fe7f
--- /dev/null
+++ b/drivers/net/wireless/ath/ath11k/p2p.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: BSD-3-Clause-Clear */
+/*
+ * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef ATH11K_P2P_H
+#define ATH11K_P2P_H
+
+#include "wmi.h"
+
+struct ath11k_wmi_p2p_noa_info;
+
+struct ath11k_p2p_noa_arg {
+	u32 vdev_id;
+	const struct ath11k_wmi_p2p_noa_info *noa;
+};
+
+void ath11k_p2p_noa_update(struct ath11k_vif *arvif,
+			   const struct ath11k_wmi_p2p_noa_info *noa);
+void ath11k_p2p_noa_update_by_vdev_id(struct ath11k *ar, u32 vdev_id,
+				      const struct ath11k_wmi_p2p_noa_info *noa);
+#endif
+
diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index d86fcdd374c6..bbccddd7d729 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -20,6 +20,7 @@
 #include "hw.h"
 #include "peer.h"
 #include "testmode.h"
+#include "p2p.h"
 
 struct wmi_tlv_policy {
 	size_t min_len;
@@ -154,6 +155,10 @@ static const struct wmi_tlv_policy wmi_tlv_policies[] = {
 		.min_len = sizeof(struct wmi_per_chain_rssi_stats) },
 	[WMI_TAG_TWT_ADD_DIALOG_COMPLETE_EVENT] = {
 		.min_len = sizeof(struct wmi_twt_add_dialog_event) },
+	[WMI_TAG_P2P_NOA_INFO] = {
+		.min_len = sizeof(struct ath11k_wmi_p2p_noa_info) },
+	[WMI_TAG_P2P_NOA_EVENT] = {
+		.min_len = sizeof(struct wmi_p2p_noa_event) },
 };
 
 #define PRIMAP(_hw_mode_) \
@@ -981,7 +986,7 @@ int ath11k_wmi_vdev_start(struct ath11k *ar, struct wmi_vdev_start_req_arg *arg,
 		      FIELD_PREP(WMI_TLV_LEN, 0);
 
 	/* Note: This is a nested TLV containing:
-	 * [wmi_tlv][wmi_p2p_noa_descriptor][wmi_tlv]..
+	 * [wmi_tlv][ath11k_wmi_p2p_noa_descriptor][wmi_tlv]..
 	 */
 
 	ptr += sizeof(*tlv);
@@ -8645,6 +8650,53 @@ static void ath11k_wmi_gtk_offload_status_event(struct ath11k_base *ab,
 	kfree(tb);
 }
 
+static int ath11k_wmi_p2p_noa_event(struct ath11k_base *ab,
+				    struct sk_buff *skb)
+{
+	const void **tb;
+	const struct wmi_p2p_noa_event *ev;
+	const struct ath11k_wmi_p2p_noa_info *noa;
+	struct ath11k *ar;
+	int ret, vdev_id;
+
+	tb = ath11k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
+	if (IS_ERR(tb)) {
+		ret = PTR_ERR(tb);
+		ath11k_warn(ab, "failed to parse tlv: %d\n", ret);
+		return ret;
+	}
+
+	ev = tb[WMI_TAG_P2P_NOA_EVENT];
+	noa = tb[WMI_TAG_P2P_NOA_INFO];
+
+	if (!ev || !noa) {
+		ret = -EPROTO;
+		goto out;
+	}
+
+	vdev_id = ev->vdev_id;
+
+	ath11k_dbg(ab, ATH11K_DBG_WMI,
+		   "wmi tlv p2p noa vdev_id %i descriptors %u\n",
+		   vdev_id, u32_get_bits(noa->noa_attr, WMI_P2P_NOA_INFO_DESC_NUM));
+	rcu_read_lock();
+	ar = ath11k_mac_get_ar_by_vdev_id(ab, vdev_id);
+	if (!ar) {
+		ath11k_warn(ab, "invalid vdev id %d in P2P NoA event\n",
+			    vdev_id);
+		ret = -EINVAL;
+		goto unlock;
+	}
+
+	ath11k_p2p_noa_update_by_vdev_id(ar, vdev_id, noa);
+
+unlock:
+	rcu_read_unlock();
+out:
+	kfree(tb);
+	return 0;
+}
+
 static void ath11k_wmi_tlv_op_rx(struct ath11k_base *ab, struct sk_buff *skb)
 {
 	struct wmi_cmd_hdr *cmd_hdr;
@@ -8772,6 +8824,9 @@ static void ath11k_wmi_tlv_op_rx(struct ath11k_base *ab, struct sk_buff *skb)
 	case WMI_GTK_OFFLOAD_STATUS_EVENTID:
 		ath11k_wmi_gtk_offload_status_event(ab, skb);
 		break;
+	case WMI_P2P_NOA_EVENTID:
+		ath11k_wmi_p2p_noa_event(ab, skb);
+		break;
 	default:
 		ath11k_dbg(ab, ATH11K_DBG_WMI, "unsupported event id 0x%x\n", id);
 		break;
diff --git a/drivers/net/wireless/ath/ath11k/wmi.h b/drivers/net/wireless/ath/ath11k/wmi.h
index 4c20202947c7..564f4a9ac8ce 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.h
+++ b/drivers/net/wireless/ath/ath11k/wmi.h
@@ -3630,6 +3630,37 @@ struct wmi_ftm_event_msg {
 	u8 data[];
 } __packed;
 
+#define WMI_P2P_MAX_NOA_DESCRIPTORS		4
+
+struct wmi_p2p_noa_event {
+	u32 vdev_id;
+} __packed;
+
+struct ath11k_wmi_p2p_noa_descriptor {
+	u32 type_count; /* 255: continuous schedule, 0: reserved */
+	u32 duration;  /* Absent period duration in micro seconds */
+	u32 interval;   /* Absent period interval in micro seconds */
+	u32 start_time; /* 32 bit tsf time when in starts */
+} __packed;
+
+#define WMI_P2P_NOA_INFO_CHANGED_FLAG		BIT(0)
+#define WMI_P2P_NOA_INFO_INDEX			GENMASK(15, 8)
+#define WMI_P2P_NOA_INFO_OPP_PS			BIT(16)
+#define WMI_P2P_NOA_INFO_CTWIN_TU		GENMASK(23, 17)
+#define WMI_P2P_NOA_INFO_DESC_NUM		GENMASK(31, 24)
+
+struct ath11k_wmi_p2p_noa_info {
+	/* Bit 0 - Flag to indicate an update in NOA schedule
+	 * Bits 7-1 - Reserved
+	 * Bits 15-8 - Index (identifies the instance of NOA sub element)
+	 * Bit  16 - Opp PS state of the AP
+	 * Bits 23-17 -  Ctwindow in TUs
+	 * Bits 31-24 -  Number of NOA descriptors
+	 */
+	u32 noa_attr;
+	struct ath11k_wmi_p2p_noa_descriptor descriptors[WMI_P2P_MAX_NOA_DESCRIPTORS];
+} __packed;
+
 #define WMI_BEACON_TX_BUFFER_SIZE	512
 
 #define WMI_EMA_TMPL_IDX_SHIFT            8
-- 
2.34.1


