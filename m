Return-Path: <linux-wireless+bounces-17892-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 394C7A1B04E
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Jan 2025 07:17:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 821E4164104
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Jan 2025 06:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D80F1DA60F;
	Fri, 24 Jan 2025 06:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="bNoBIcXm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 831641D9A7E;
	Fri, 24 Jan 2025 06:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737699422; cv=none; b=miGcNnqAdv93yh5d/ywCM0qUHeF7ai7+hfLFJnJwGhFTURI4fNF+Xck8OtQBaAr38RVmR0+6lrkgPaPd1I36Tj4YiUIosFgz5KNe8wj5G/DOxDLgQ1c9/jCTjbAjO2bZ0LaKmtvBVVSmcidFPQjxoxvj1lK99UQOQtF+yuN0SZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737699422; c=relaxed/simple;
	bh=+yuYBkeapbi80guxfAvQW7rn92g/0QSnY+ENo43kWqE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=mE8h9Sy5/Y+hSJwerCKpBifOrcFp+wE1F9b4xAgtfG/70OW3N2SR7aA3ki8YaIhbaaaR8FrtJ8dCwIYDMTWdXwDfZDFY4qOuD1W6ZeH1cmO8MdFDrZYmQYiE5aH7NS9SgQ3MWctE8k4td3NbJfE5esVvswfdPiajvEb+KTFp2vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=bNoBIcXm; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50NK1b9W025017;
	Fri, 24 Jan 2025 06:16:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	p3nmUpv3Y8HdEf4idOouiiVdVWFH7olg5v8qS1f+BvE=; b=bNoBIcXmuVgSS69H
	wmgc2O+tvOhcQJf+7vjKr8+XLHsppH0tdl8dKRrDj7+uU7nMW7jrqsuGTqase+u2
	eH6pU9R88HOaiEHvjTDngEQVHhtNy3jMTKmmMnxOHft6wXjwZiRgGkDmpE2elESr
	OCE3O93krYgzRLl0A0mnKN758TR8m+jy+ps8PW2xrd/pf2bt85eJBrDLF3GDDOMp
	s64Y2cJnImz/cC8DLuBBDnen6JoSBwtl2ea+PMheJ5FRqYCO57dgx4UoIFMOFjP3
	Z74acPMucxcWRClLvdqVhHiypBITzSnm9DYi1lFUBs36MpeQhkVngxtSxFupFxcP
	PbemOQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44bvenh1pw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jan 2025 06:16:56 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50O6Guw9013567
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jan 2025 06:16:56 GMT
Received: from hu-adisi-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 23 Jan 2025 22:16:53 -0800
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
Date: Fri, 24 Jan 2025 11:46:36 +0530
Subject: [PATCH v2 2/4] wifi: ath12k: fix handling of CSA offsets in beacon
 template command
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250124-ath12k_mlo_csa-v2-2-420c42fcfecf@quicinc.com>
References: <20250124-ath12k_mlo_csa-v2-0-420c42fcfecf@quicinc.com>
In-Reply-To: <20250124-ath12k_mlo_csa-v2-0-420c42fcfecf@quicinc.com>
To: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <ath12k@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Aditya Kumar Singh <quic_adisi@quicinc.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: JCm4PVYEDANlaZA4NlpKiOn4if-34O4y
X-Proofpoint-ORIG-GUID: JCm4PVYEDANlaZA4NlpKiOn4if-34O4y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-24_02,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 suspectscore=0 adultscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 mlxscore=0 bulkscore=0 clxscore=1015 malwarescore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501240043

The driver is informed of the counter offsets in the beacon during CSA
through the ieee80211_mutable_offsets structure. According to the
documentation for the cntdwn_counter_offs member, "This array can contain
zero values which should be ignored." However, the current implementation
uses these values unconditionally, without checking for zeros.

Whenever CSA is active, these offsets are guaranteed to be set. Therefore,
add a check for CSA active status before setting the CSA switch count
offsets. This ensures that the offsets are only set when CSA is active,
preventing incorrect configurations.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1

Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c |  2 +-
 drivers/net/wireless/ath/ath12k/mac.h |  3 ++-
 drivers/net/wireless/ath/ath12k/wmi.c | 23 ++++++++++++++++++++---
 3 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 417d53dd9c79d15b69642793c6846005a9da4cf3..53c01debf8f8fd6eae675f189e4dfd00717555db 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -503,7 +503,7 @@ static int ath12k_mac_vif_link_chan(struct ieee80211_vif *vif, u8 link_id,
 	return 0;
 }
 
-static struct ieee80211_bss_conf *
+struct ieee80211_bss_conf *
 ath12k_mac_get_link_bss_conf(struct ath12k_link_vif *arvif)
 {
 	struct ieee80211_vif *vif = arvif->ahvif->vif;
diff --git a/drivers/net/wireless/ath/ath12k/mac.h b/drivers/net/wireless/ath/ath12k/mac.h
index 3594729b63974e942b91eed0ebdfcabcb6a3c3a1..58897217d63b3644a78a49bb580cf4235d2f9985 100644
--- a/drivers/net/wireless/ath/ath12k/mac.h
+++ b/drivers/net/wireless/ath/ath12k/mac.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #ifndef ATH12K_MAC_H
@@ -108,5 +108,6 @@ int ath12k_mac_vdev_stop(struct ath12k_link_vif *arvif);
 void ath12k_mac_get_any_chanctx_conf_iter(struct ieee80211_hw *hw,
 					  struct ieee80211_chanctx_conf *conf,
 					  void *data);
+struct ieee80211_bss_conf *ath12k_mac_get_link_bss_conf(struct ath12k_link_vif *arvif);
 
 #endif
diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index c129dce5832aa76e0c084548c5019dfd63386186..6ed3d2e8e86e362bb2fafa6bd267c45e2b2e314f 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -1896,8 +1896,11 @@ int ath12k_wmi_bcn_tmpl(struct ath12k_link_vif *arvif,
 {
 	struct ath12k *ar = arvif->ar;
 	struct ath12k_wmi_pdev *wmi = ar->wmi;
+	struct ath12k_base *ab = ar->ab;
 	struct wmi_bcn_tmpl_cmd *cmd;
 	struct ath12k_wmi_bcn_prb_info_params *bcn_prb_info;
+	struct ath12k_vif *ahvif = arvif->ahvif;
+	struct ieee80211_bss_conf *conf;
 	u32 vdev_id = arvif->vdev_id;
 	struct wmi_tlv *tlv;
 	struct sk_buff *skb;
@@ -1906,6 +1909,14 @@ int ath12k_wmi_bcn_tmpl(struct ath12k_link_vif *arvif,
 	int ret, len;
 	size_t aligned_len = roundup(bcn->len, 4);
 
+	conf = ath12k_mac_get_link_bss_conf(arvif);
+	if (!conf) {
+		ath12k_warn(ab,
+			    "unable to access bss link conf in beacon template command for vif %pM link %u\n",
+			    ahvif->vif->addr, arvif->link_id);
+		return -EINVAL;
+	}
+
 	len = sizeof(*cmd) + sizeof(*bcn_prb_info) + TLV_HDR_SIZE + aligned_len;
 
 	skb = ath12k_wmi_alloc_skb(wmi->wmi_ab, len);
@@ -1917,8 +1928,14 @@ int ath12k_wmi_bcn_tmpl(struct ath12k_link_vif *arvif,
 						 sizeof(*cmd));
 	cmd->vdev_id = cpu_to_le32(vdev_id);
 	cmd->tim_ie_offset = cpu_to_le32(offs->tim_offset);
-	cmd->csa_switch_count_offset = cpu_to_le32(offs->cntdwn_counter_offs[0]);
-	cmd->ext_csa_switch_count_offset = cpu_to_le32(offs->cntdwn_counter_offs[1]);
+
+	if (conf->csa_active) {
+		cmd->csa_switch_count_offset =
+				cpu_to_le32(offs->cntdwn_counter_offs[0]);
+		cmd->ext_csa_switch_count_offset =
+				cpu_to_le32(offs->cntdwn_counter_offs[1]);
+	}
+
 	cmd->buf_len = cpu_to_le32(bcn->len);
 	cmd->mbssid_ie_offset = cpu_to_le32(offs->mbssid_off);
 	if (ema_args) {
@@ -1948,7 +1965,7 @@ int ath12k_wmi_bcn_tmpl(struct ath12k_link_vif *arvif,
 
 	ret = ath12k_wmi_cmd_send(wmi, skb, WMI_BCN_TMPL_CMDID);
 	if (ret) {
-		ath12k_warn(ar->ab, "failed to send WMI_BCN_TMPL_CMDID\n");
+		ath12k_warn(ab, "failed to send WMI_BCN_TMPL_CMDID\n");
 		dev_kfree_skb(skb);
 	}
 

-- 
2.34.1


