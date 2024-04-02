Return-Path: <linux-wireless+bounces-5771-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48BFE895E6D
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Apr 2024 23:06:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C74EA1F258E8
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Apr 2024 21:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C78C15E7F7;
	Tue,  2 Apr 2024 21:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="kp1q+9NZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9FE15E5D2
	for <linux-wireless@vger.kernel.org>; Tue,  2 Apr 2024 21:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712091959; cv=none; b=uJtBnKO5RAkl4AaSwND4GDJ03H23iJoJIirjRdQBgPSCMFSAsBSJQtWjje7aBRvx96igXqwwyP9Suf0mtGZag95wUqAGB3autgiCZIyW0UMwo9+BYHPt2J4WsGISujVapCzU06npQL94o483AeRUXAlp4M1KIgej6QEa1h6JkFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712091959; c=relaxed/simple;
	bh=cpj6vNF0SzWwVrDsWLwyP/6Xsg22LxYTHrmfFG5iBmo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K/i1idgCfV3zQGehHUhroImA6DFTO0/AD0tDtI4mzSyPa3j2jbcFGdz3rT3EcaQTJ0FN7mttYtBhd6aBNaivKOBVcOr00cyoHJsojHCj3gLa4vLXWMPYWdXc6yK+PdLor8NEqmCFLwAWsJicZkfePmKTmst+QpwiajYkDpzOhtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=kp1q+9NZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 432HEFMs000939;
	Tue, 2 Apr 2024 21:05:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=jiFtotaSgI2H07brn+u6h6SyFzZZUPTROlllUc3SixQ=; b=kp
	1q+9NZ1gVM3ty+gxEYqucSOBAfJntonSV5WiNfgftTgD+RCQQX7SkP6dK/ZLfPAY
	fuSbwtMy1kTmobISaP5qvZHm5zlFJQjpSZEr5iwx6uZYKTEzALTnK2/j/aLsOYkc
	2fOkKnX8P6EJ2lHEugGLsxfS0TPtGhvIszsz/9WyjQxmZWqVFeZAjRscBxJ0MerJ
	cIy98PH7w5HK+SgPqc5mbTylgcg3Z3L90JA4+qSnibTA5I22wKq57PLqeQj86k+D
	+s+fJMXVlSRi9D5qSm1jokfvGSpgnlRryr2ErJZlVGZXvcBQEBM1DjmoWnXn8YqS
	i5+haqrbDLDQCmW1kEgg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x8c2vje66-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Apr 2024 21:05:52 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 432L5pH8031824
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 2 Apr 2024 21:05:51 GMT
Received: from alokad-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 2 Apr 2024 14:05:50 -0700
From: Aloka Dixit <quic_alokad@quicinc.com>
To: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
CC: Aloka Dixit <quic_alokad@quicinc.com>
Subject: [PATCH 7/9] wifi: ath12k: add MBSSID beacon support
Date: Tue, 2 Apr 2024 14:05:36 -0700
Message-ID: <20240402210538.7308-8-quic_alokad@quicinc.com>
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
X-Proofpoint-ORIG-GUID: NXc5QPCJg1ZkR7BcD_SuWo0UdZPXUEav
X-Proofpoint-GUID: NXc5QPCJg1ZkR7BcD_SuWo0UdZPXUEav
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-02_14,2024-04-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 bulkscore=0 mlxscore=0 spamscore=0 mlxlogscore=999 impostorscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2404020157

- A single beacon template is used for one multiple BSSID group as
only one interface from group transmits the beacons. But firmware
requires the host to send this template each time a nontransmitted
interface is brought up. Hence, modify existing logic to retrieve
the template from vif context of the transmitting interface. Also,
firmware crashes if host sends a template for a nontransmitted
interface which is already up, add a check to avoid this.
- Set rsnie_present and wpaie_present fields for nontransmitted VAPs.
- Send offset to the multiple BSSID element in the beacon template
firmware.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Signed-off-by: Aloka Dixit <quic_alokad@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 97 +++++++++++++++++++++++++--
 drivers/net/wireless/ath/ath12k/wmi.c |  1 +
 2 files changed, 94 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 996ce2c4698a..6bfa337ce693 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -1242,11 +1242,14 @@ static int ath12k_mac_remove_vendor_ie(struct sk_buff *skb, unsigned int oui,
 	return 0;
 }
 
-static void ath12k_mac_set_arvif_ies(struct ath12k_vif *arvif, struct sk_buff *bcn)
+static void ath12k_mac_set_arvif_ies(struct ath12k_vif *arvif, struct sk_buff *bcn,
+				     u8 bssid_index, bool *nontx_profile_found)
 {
 	struct ieee80211_mgmt *mgmt = (struct ieee80211_mgmt *)bcn->data;
+	const struct element *elem, *nontx, *index, *nie;
 	const u8 *start, *tail;
 	u16 rem_len;
+	u8 i;
 
 	start = bcn->data + ieee80211_get_hdrlen_from_skb(bcn) + sizeof(mgmt->u.beacon);
 	tail = skb_tail_pointer(bcn);
@@ -1260,28 +1263,114 @@ static void ath12k_mac_set_arvif_ies(struct ath12k_vif *arvif, struct sk_buff *b
 	if (cfg80211_find_vendor_ie(WLAN_OUI_MICROSOFT, WLAN_OUI_TYPE_MICROSOFT_WPA,
 				    start, rem_len))
 		arvif->wpaie_present = true;
+
+	/* Return from here for the transmitted profile */
+	if (!bssid_index)
+		return;
+
+	/* Initial rsnie_present for the nontransmitted profile is set to be same as that
+	 * of the transmitted profile. It will be changed if security configurations are
+	 * different.
+	 */
+	*nontx_profile_found = false;
+	for_each_element_id(elem, WLAN_EID_MULTIPLE_BSSID, start, rem_len) {
+		/* Fixed minimum MBSSID element length with at least one
+		 * nontransmitted BSSID profile is 12 bytes as given below;
+		 * 1 (max BSSID indicator) +
+		 * 2 (Nontransmitted BSSID profile: Subelement ID + length) +
+		 * 4 (Nontransmitted BSSID Capabilities: tag + length + info)
+		 * 2 (Nontransmitted BSSID SSID: tag + length)
+		 * 3 (Nontransmitted BSSID Index: tag + length + BSSID index
+		 */
+		if (elem->datalen < 12 || elem->data[0] < 1)
+			continue; /* Max BSSID indicator must be >=1 */
+
+		for_each_element(nontx, elem->data + 1, elem->datalen - 1) {
+			start = nontx->data;
+
+			if (nontx->id != 0 || nontx->datalen < 4)
+				continue; /* Invalid nontransmitted profile */
+
+			if (nontx->data[0] != WLAN_EID_NON_TX_BSSID_CAP ||
+			    nontx->data[1] != 2) {
+				continue; /* Missing nontransmitted BSS capabilities */
+			}
+
+			if (nontx->data[4] != WLAN_EID_SSID)
+				continue; /* Missing SSID for nontransmitted BSS */
+
+			index = cfg80211_find_elem(WLAN_EID_MULTI_BSSID_IDX,
+						   start, nontx->datalen);
+			if (!index || index->datalen < 1 || index->data[0] == 0)
+				continue; /* Invalid MBSSID Index element */
+
+			if (index->data[0] == bssid_index) {
+				*nontx_profile_found = true;
+				if (cfg80211_find_ie(WLAN_EID_RSN,
+						     nontx->data,
+						     nontx->datalen)) {
+					arvif->rsnie_present = true;
+					return;
+				} else if (!arvif->rsnie_present) {
+					return; /* Both tx and nontx BSS are open */
+				}
+
+				nie = cfg80211_find_ext_elem(WLAN_EID_EXT_NON_INHERITANCE,
+							     nontx->data,
+							     nontx->datalen);
+				if (!nie || nie->datalen < 2)
+					return; /* Invalid non-inheritance element */
+
+				for (i = 1; i < nie->datalen - 1; i++) {
+					if (nie->data[i] == WLAN_EID_RSN) {
+						arvif->rsnie_present = false;
+						break;
+					}
+				}
+
+				return;
+			}
+		}
+	}
 }
 
 static int ath12k_mac_setup_bcn_tmpl(struct ath12k_vif *arvif)
 {
+	struct ath12k_vif *tx_arvif = arvif;
 	struct ath12k *ar = arvif->ar;
 	struct ath12k_base *ab = ar->ab;
-	struct ieee80211_hw *hw = ath12k_ar_to_hw(ar);
 	struct ieee80211_vif *vif = arvif->vif;
 	struct ieee80211_mutable_offsets offs = {};
+	bool nontx_profile_found = false;
 	struct sk_buff *bcn;
 	int ret;
 
 	if (arvif->vdev_type != WMI_VDEV_TYPE_AP)
 		return 0;
 
-	bcn = ieee80211_beacon_get_template(hw, vif, &offs, 0);
+	if (vif->mbssid_tx_vif) {
+		tx_arvif = ath12k_vif_to_arvif(vif->mbssid_tx_vif);
+		if (tx_arvif != arvif && arvif->is_up)
+			return 0;
+	}
+
+	bcn = ieee80211_beacon_get_template(ath12k_ar_to_hw(tx_arvif->ar), tx_arvif->vif,
+					    &offs, 0);
 	if (!bcn) {
 		ath12k_warn(ab, "failed to get beacon template from mac80211\n");
 		return -EPERM;
 	}
 
-	ath12k_mac_set_arvif_ies(arvif, bcn);
+	if (tx_arvif == arvif) {
+		ath12k_mac_set_arvif_ies(arvif, bcn, 0, NULL);
+	} else {
+		ath12k_mac_set_arvif_ies(arvif, bcn,
+					 arvif->vif->bss_conf.bssid_index,
+					 &nontx_profile_found);
+		if (!nontx_profile_found)
+			ath12k_warn(ab,
+				    "nontransmitted profile not found in beacon template\n");
+	}
 
 	if (arvif->vif->type == NL80211_IFTYPE_AP && arvif->vif->p2p) {
 		ret = ath12k_mac_setup_bcn_p2p_ie(arvif, bcn);
diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index 09a9fc13e747..b8f240649d13 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -1813,6 +1813,7 @@ int ath12k_wmi_bcn_tmpl(struct ath12k *ar, u32 vdev_id,
 	cmd->csa_switch_count_offset = cpu_to_le32(offs->cntdwn_counter_offs[0]);
 	cmd->ext_csa_switch_count_offset = cpu_to_le32(offs->cntdwn_counter_offs[1]);
 	cmd->buf_len = cpu_to_le32(bcn->len);
+	cmd->mbssid_ie_offset = cpu_to_le32(offs->mbssid_off);
 
 	ptr = skb->data + sizeof(*cmd);
 
-- 
2.39.0


