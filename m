Return-Path: <linux-wireless+bounces-22458-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CDF30AA9798
	for <lists+linux-wireless@lfdr.de>; Mon,  5 May 2025 17:36:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BA013AAC77
	for <lists+linux-wireless@lfdr.de>; Mon,  5 May 2025 15:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B1AD2561D1;
	Mon,  5 May 2025 15:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="VNYBsaeH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4251725CC77
	for <linux-wireless@vger.kernel.org>; Mon,  5 May 2025 15:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746459375; cv=none; b=YtKHfF9mNYWEamgyq727kN4hvDLSfDxC/IaAE3EdBp/w3bJK3gHlD5/T6tOH1pQ+ShLdEDlEaTxFc+CnuB2KeSrW/aaIbxW9KGz+X2oH0uECb8zODlDehWn3VF8L+zj08RQ8/ftPwCaJO0fcqxXLh+CCesKkCoXqIvWkqg1eiHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746459375; c=relaxed/simple;
	bh=DfzPPYb1x1CJsTDXNyswpbGgMG3OdVa7miPIg9l+7qc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DJsByj++YtfnIn4j3hJhGLWpxlSwNyHQ65r+kJk7apN1nc/x7lgMYbJDoT/eypfoTznvjFzLFB3OgqQZno3CLzOJ1fduxVhsBdXUaY8iXVV9rrBEcI+pSs7rO/zo7GfjalGFssDm09wsI5sbNRmcVvFPDYLwenFxq3ehEYTDobY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=VNYBsaeH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 545BZaGe005126;
	Mon, 5 May 2025 15:36:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=JXHr2dOxtzI5gHllAeoJFa
	isxFGgHcV+JYHt1lAsiN0=; b=VNYBsaeHK6Mbc0jz6D/JdEuGmr0/nZwILvxRI+
	uWk10tFIvohcTHawns6qDbZXbkMKODYgsRvaETvKhzxRlDVDXE4WxDRkalJpl6lJ
	S+zylJG6bXktC2JClQKdaYa6LFq2ADdZgrnjFCQF5/Hh7PIcuIzBH1hf+GJsPSid
	MJ+yF5QbDS2Qdy4SMKFbgzX8Db9ywnpV22cmloH4WTapw+r567bDU6bKBO8EwBiB
	o2+agubuQqyRqqGSZTR5Bg19Rr5qQNbCPXqIkUj5TNv3CHV89z+Mfe95rj02C/Vb
	J8r1mhWoxRX8jyJDTzMixicRsnevQO0Faf/mg/nrFvXlyTvQ==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46dbwfmcdj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 May 2025 15:36:10 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 545FaA4p020015
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 5 May 2025 15:36:10 GMT
Received: from hu-mkumarg-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 5 May 2025 08:36:08 -0700
From: Mohan Kumar G <quic_mkumarg@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Mohan Kumar G
	<quic_mkumarg@quicinc.com>,
        Dhanavandhana Kannan <quic_dhanavan1@quicinc.com>
Subject: [PATCH ath-next v2] wifi: ath12k: Send MCS15 support to firmware during peer assoc
Date: Mon, 5 May 2025 21:05:36 +0530
Message-ID: <20250505153536.3275145-1-quic_mkumarg@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: S_sJysJeLjGkasussrxj7vC1TxJpjNxw
X-Proofpoint-GUID: S_sJysJeLjGkasussrxj7vC1TxJpjNxw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA1MDE0OCBTYWx0ZWRfX1+RGUZryemfu
 PEbSDm7J5pwYVamIvgdEGiUhqldK3NKVp80pbHSpMQizIGReqXqyl4WASlZMFOEkGrRPhaMpaq8
 SrNkgIcAbh7I/NmtI6/1m4tx/McC4SLAoBrcR8Sk8mxp6Acqmn6QSbXJU/Ur6wQ/G8xIkqpHAaM
 5i9sKL4OT+N3d0xf9QCCpG9qX03ZGQAeUn//4g3kn2HyHiQfGAQ4+rYmOMEnQN21XZTBVFxG5NX
 CtTn39ubJoZ4wPo2ROaJqJPdgazSjblY7t2NzyBlVH2lxaNXiFb2CcPCsJBeNVH+QWQtGqGneo5
 dn0e9mWPPoNAkEEKQRIJRJRkvB1LlmhCIIWodK03CMVH1qRIM6nv87wVg61RQzxntbkSgvCd+9n
 AJebvhohyyfiWEQP9ZsreQbhnGy8vhsRZ/G/5GRxANcB5hchEZiFDRLluKdDzguNOuW2Kawe
X-Authority-Analysis: v=2.4 cv=AfqxH2XG c=1 sm=1 tr=0 ts=6818daea cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8
 a=_JNsq_4efX1U1AbLB0wA:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-05_07,2025-05-05_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 priorityscore=1501 phishscore=0 impostorscore=0
 mlxscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0 mlxlogscore=999
 spamscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505050148

As per IEEE 802.11be-2024 - 9.4.2.321, EHT operation element
contains MCS15 Disable subfield as the sixth bit, which is set when
MCS15 support is not enabled.

During association, firmware will use this MCS15 flag to enable or
disable the reception of PPDU with EHT-MCS15 capability.

Send MCS15 support to firmware through WMI command during peer assoc.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Co-developed-by: Dhanavandhana Kannan <quic_dhanavan1@quicinc.com>
Signed-off-by: Dhanavandhana Kannan <quic_dhanavan1@quicinc.com>
Signed-off-by: Mohan Kumar G <quic_mkumarg@quicinc.com>
---

Depends-on: https://lore.kernel.org/linux-wireless/20250505152836.3266829-1-quic_mkumarg@quicinc.com/

v2:
 - Added eht_ prefix to disable_mcs15

---
 drivers/net/wireless/ath/ath12k/mac.c | 8 ++++++++
 drivers/net/wireless/ath/ath12k/wmi.c | 8 ++++++--
 drivers/net/wireless/ath/ath12k/wmi.h | 1 +
 3 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 4dae941c9615..5b9feddb0e21 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -2935,6 +2935,7 @@ static void ath12k_peer_assoc_h_eht(struct ath12k *ar,
 	const struct ieee80211_sta_eht_cap *eht_cap;
 	const struct ieee80211_sta_he_cap *he_cap;
 	struct ieee80211_link_sta *link_sta;
+	struct ieee80211_bss_conf *link_conf;
 	u32 *rx_mcs, *tx_mcs;
 
 	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
@@ -2946,6 +2947,12 @@ static void ath12k_peer_assoc_h_eht(struct ath12k *ar,
 		return;
 	}
 
+	link_conf = ath12k_mac_get_link_bss_conf(arvif);
+	if (!link_conf) {
+		ath12k_warn(ar->ab, "unable to access link_conf in peer assoc eht set\n");
+		return;
+	}
+
 	eht_cap = &link_sta->eht_cap;
 	he_cap = &link_sta->he_cap;
 	if (!he_cap->has_he || !eht_cap->has_eht)
@@ -3017,6 +3024,7 @@ static void ath12k_peer_assoc_h_eht(struct ath12k *ar,
 	}
 
 	arg->punct_bitmap = ~arvif->punct_bitmap;
+	arg->eht_disable_mcs15 = link_conf->eht_disable_mcs15;
 }
 
 static void ath12k_peer_assoc_h_mlo(struct ath12k_link_sta *arsta,
diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index ea303dca38b5..17c670ab8025 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -2380,6 +2380,10 @@ int ath12k_wmi_send_peer_assoc_cmd(struct ath12k *ar,
 		ptr += sizeof(*eht_mcs);
 	}
 
+	/* Update MCS15 capability */
+	if (arg->eht_disable_mcs15)
+		cmd->peer_eht_ops = cpu_to_le32(IEEE80211_EHT_OPER_MCS15_DISABLE);
+
 	tlv = ptr;
 	len = arg->ml.enabled ? arg->ml.num_partner_links * sizeof(*partner_info) : 0;
 	/* fill ML Partner links */
@@ -2420,7 +2424,7 @@ int ath12k_wmi_send_peer_assoc_cmd(struct ath12k *ar,
 
 send:
 	ath12k_dbg(ar->ab, ATH12K_DBG_WMI,
-		   "wmi peer assoc vdev id %d assoc id %d peer mac %pM peer_flags %x rate_caps %x peer_caps %x listen_intval %d ht_caps %x max_mpdu %d nss %d phymode %d peer_mpdu_density %d vht_caps %x he cap_info %x he ops %x he cap_info_ext %x he phy %x %x %x peer_bw_rxnss_override %x peer_flags_ext %x eht mac_cap %x %x eht phy_cap %x %x %x\n",
+		   "wmi peer assoc vdev id %d assoc id %d peer mac %pM peer_flags %x rate_caps %x peer_caps %x listen_intval %d ht_caps %x max_mpdu %d nss %d phymode %d peer_mpdu_density %d vht_caps %x he cap_info %x he ops %x he cap_info_ext %x he phy %x %x %x peer_bw_rxnss_override %x peer_flags_ext %x eht mac_cap %x %x eht phy_cap %x %x %x peer_eht_ops %x\n",
 		   cmd->vdev_id, cmd->peer_associd, arg->peer_mac,
 		   cmd->peer_flags, cmd->peer_rate_caps, cmd->peer_caps,
 		   cmd->peer_listen_intval, cmd->peer_ht_caps,
@@ -2433,7 +2437,7 @@ int ath12k_wmi_send_peer_assoc_cmd(struct ath12k *ar,
 		   cmd->peer_bw_rxnss_override, cmd->peer_flags_ext,
 		   cmd->peer_eht_cap_mac[0], cmd->peer_eht_cap_mac[1],
 		   cmd->peer_eht_cap_phy[0], cmd->peer_eht_cap_phy[1],
-		   cmd->peer_eht_cap_phy[2]);
+		   cmd->peer_eht_cap_phy[2], cmd->peer_eht_ops);
 
 	ret = ath12k_wmi_cmd_send(wmi, skb, WMI_PEER_ASSOC_CMDID);
 	if (ret) {
diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
index 80fdbc566518..c50f0543c231 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -3833,6 +3833,7 @@ struct ath12k_wmi_peer_assoc_arg {
 	u32 punct_bitmap;
 	bool is_assoc;
 	struct peer_assoc_mlo_params ml;
+	bool eht_disable_mcs15;
 };
 
 #define ATH12K_WMI_FLAG_MLO_ENABLED			BIT(0)

base-commit: 21346cd925c2567d5f56cdb1421c94815ac10221
prerequisite-patch-id: c3c503f594fb7b68ea377f7b4c6f7b2deb0fce0e
-- 
2.34.1


