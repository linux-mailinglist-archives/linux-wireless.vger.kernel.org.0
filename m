Return-Path: <linux-wireless+bounces-21790-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E643BA95064
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Apr 2025 13:47:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C84F33AEB8D
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Apr 2025 11:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 293371CAA62;
	Mon, 21 Apr 2025 11:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LxmY68ai"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36DA34C85
	for <linux-wireless@vger.kernel.org>; Mon, 21 Apr 2025 11:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745236047; cv=none; b=mzQ41zreCrl6M5tx/w/CkuLB0r47vPrZhQIZnbQvWTjD92NoKj4CmybkVbtUz5p61GGJyhKTkkUmYbpjlq69/S01KgVujXUilU4jpfnz5H+HIr0WWMqutBkaFwXgDf7OS6kW9xDu4SnQay7lzFnYeY02pcZYbsIW8UBh1UV5jwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745236047; c=relaxed/simple;
	bh=kI9H04x00rKdNCa1EK3ORCPMfl1JEulbq1EdU8pJQH8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=K3i/WJQuFGHV2PlN/e0lgjODKeT0zzX2fSeAjgMw/J3NOp0+2TP7uI8S2g0wrGS7N3Xy4XKhwsLvCqTRKgN2cBh8nS54G3eZIUf6Rl2GUOH4tjo21VsQziL9VUQeSec8gGCOtzLkC/CwjUgT4C+aZTJDxHiNOCjvv68K0F4MqvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LxmY68ai; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53LAQwr1008977
	for <linux-wireless@vger.kernel.org>; Mon, 21 Apr 2025 11:47:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=97qgRjv+DMq9qzeWj1r82+ZRkb/4AuF7pRo
	L1UNlID0=; b=LxmY68ai/5RUsLe3wQKt8XP0Z4NJo/1ZQXgA99QxscnNwXn/yx+
	cHbPrgcWY4KtifaHe0o8cjWpyz54aJaR7gXFGmCwB/kfU2jBDvuD/S3nu4QFB4WQ
	0CSfQo9DakrxYlOmTa96zhCzcZ7H6WSJcs38Gz00tGsvlqd8qYsIjhUeXK9VzgV3
	0Ska9V27vO2nYjtWSWzLjSfOwYNDtuWvJYFIrC6XecOLddQORfTHGWnP5AloIYgH
	e8qTRhQbnVuuXqueNmAf6ZL3XEc+6JG8n6+X1h0YfkNYnuyfsYg6Gd1lfj/p19WG
	OOT6DTcF/lkz/vtujhGz2eaA+5BtWWy1/UQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46450pbx6x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 21 Apr 2025 11:47:24 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2ff7cf599beso3726098a91.0
        for <linux-wireless@vger.kernel.org>; Mon, 21 Apr 2025 04:47:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745236043; x=1745840843;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=97qgRjv+DMq9qzeWj1r82+ZRkb/4AuF7pRoL1UNlID0=;
        b=ds7ie2YNUPIcd71J8byhhzpeT2ywK2pL4InJXpArZy5XrHEcixS0xPg2J/bLYS7BA4
         hYguyD5R/8jUDDQZE5D79NFyd0N4lBh0aKcCy4YuZzQBfjRKOK5QBhtqRu5oOKv7Fa88
         MV1mob+bLWRIZtHtRCCUz4+GlsNvys5HYHxV/aTkQjRWGFApEDDbyAFr+D/hSYFe2u2u
         mf9xwcds87kz5QmaA5wOwRpHde6g7LU7k4T0lbx6APYKNbcf8cuK7IvGB8/Ehtn8tcnn
         l5jN4KX06GS8LZt31iR5qnHqVA4x5tW9sgl8vKsHCGz4P3Tig6LFh1X1dRcUnisbgNIc
         G4+w==
X-Gm-Message-State: AOJu0YwXO2Yn5Lm5G95yFRSsbh6zmTM2U1u9wT6uHH7yJoa24Npn1B+a
	O3IggfApKGcgWjulv0aq+blLtaGTPMJZHMYBUoJEpYiqhK2hIeqbtGJsCpIP6OPHHCPmfqypbs+
	mAefPff3hqnQtdJXzcXktTV5IJ6HCkMKxbXy5Q5VARY3rmtuvBVoW/3bu6peyWwJzKA==
X-Gm-Gg: ASbGnct0rcR0DspF8k2w7STDSIfPqj+wMvWnemWArUy4pYTmkDDq8I//e6fCu2gzpdu
	N29exuYm0lOaSf1XSTWbF7ek63dpguB0P+A+80rOW6ohkH6YQHaDwyixgeLgxzFFdPHixsW8f4f
	znKIVYisU3vXYvftnxLKSb+jhSKSrfOLu/mu1XHSf0HIWOxde3CS+YliWaXTmPvpxKGhe5oRBwR
	vos4KFGg+BSXBxXhoYPIL3s5umrXCOjxa/jVhe37Z7KtAG1v7FO0J+Os4xA1qlW6ehPvLDAaxWZ
	bs5uzvartio/BRjXPnEMYDWc3u+2H6flG44HxJiHRQ7ayvDp8s2XqvcT
X-Received: by 2002:a17:90b:2801:b0:2fe:99cf:f566 with SMTP id 98e67ed59e1d1-3087bb573d8mr16488888a91.13.1745236042961;
        Mon, 21 Apr 2025 04:47:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHuStkKMdb4q+TpBnfcVEupfU7/7Jnc0mQi7iH1c1GzjO0O2h/W9TO93xrkLfGGHtm9os+kNg==
X-Received: by 2002:a17:90b:2801:b0:2fe:99cf:f566 with SMTP id 98e67ed59e1d1-3087bb573d8mr16488850a91.13.1745236042434;
        Mon, 21 Apr 2025 04:47:22 -0700 (PDT)
Received: from hu-kathirve-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3087df1e2acsm6384283a91.21.2025.04.21.04.47.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 04:47:21 -0700 (PDT)
From: Karthikeyan Kathirvel <karthikeyan.kathirvel@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Karthikeyan Kathirvel <karthikeyan.kathirvel@oss.qualcomm.com>
Subject: [PATCH ath-next] wifi: ath12k: allow beacon protection keys to be installed in hardware
Date: Mon, 21 Apr 2025 17:17:11 +0530
Message-Id: <20250421114711.3660911-1-karthikeyan.kathirvel@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Hd0UTjE8 c=1 sm=1 tr=0 ts=6806304c cx=c_pps a=RP+M6JBNLl+fLTcSJhASfg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=-gpDE4vgwXxYWL_pqeMA:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: MTQOSXknCtJLjnaUyDcc-G8C_sYAUk8I
X-Proofpoint-ORIG-GUID: MTQOSXknCtJLjnaUyDcc-G8C_sYAUk8I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-21_05,2025-04-21_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 mlxscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 phishscore=0 clxscore=1015 spamscore=0
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504210092

Install beacon protection keys in hardware for AP modes only if hardware
supports it, as indicated by the WMI service bit
WMI_TLV_SERVICE_BEACON_PROTECTION_SUPPORT. Allow keyidx up to 7, since
beacon protection uses keyidx 6 and 7.

Control this feature by setting bit 0 of feature_enable_bitmap when sending
the WMI_BCN_TMPL_CMDID command to firmware.

Check for the beacon protection enabled bit in both tx and non-tx profiles
for MBSSID cases. If set in either profile, enable the beacon protection
feature in firmware for transmitted vif.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1

Signed-off-by: Karthikeyan Kathirvel <karthikeyan.kathirvel@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/core.h |  1 +
 drivers/net/wireless/ath/ath12k/mac.c  | 52 +++++++++++++++++++-------
 drivers/net/wireless/ath/ath12k/wmi.c  |  3 ++
 drivers/net/wireless/ath/ath12k/wmi.h  |  5 ++-
 4 files changed, 46 insertions(+), 15 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 4b8f434e3e9a..48bcb6d95479 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -290,6 +290,7 @@ struct ath12k_link_vif {
 
 	int bank_id;
 	u8 vdev_id_check_en;
+	bool beacon_prot;
 
 	struct wmi_wmm_params_all_arg wmm_params;
 	struct list_head list;
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index d170bca72948..71236c4f36a6 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -1445,11 +1445,13 @@ static int ath12k_mac_remove_vendor_ie(struct sk_buff *skb, unsigned int oui,
 	return 0;
 }
 
-static void ath12k_mac_set_arvif_ies(struct ath12k_link_vif *arvif, struct sk_buff *bcn,
+static void ath12k_mac_set_arvif_ies(struct ath12k_link_vif *arvif,
+				     struct ath12k_link_vif *tx_arvif,
+					 struct sk_buff *bcn,
 				     u8 bssid_index, bool *nontx_profile_found)
 {
 	struct ieee80211_mgmt *mgmt = (struct ieee80211_mgmt *)bcn->data;
-	const struct element *elem, *nontx, *index, *nie;
+	const struct element *elem, *nontx, *index, *nie, *ext_cap_ie;
 	const u8 *start, *tail;
 	u16 rem_len;
 	u8 i;
@@ -1467,6 +1469,11 @@ static void ath12k_mac_set_arvif_ies(struct ath12k_link_vif *arvif, struct sk_bu
 				    start, rem_len))
 		arvif->wpaie_present = true;
 
+	ext_cap_ie = cfg80211_find_elem(WLAN_EID_EXT_CAPABILITY, start, rem_len);
+	if (ext_cap_ie && ext_cap_ie->datalen >= 11 &&
+	    (ext_cap_ie->data[10] & WLAN_EXT_CAPA11_BCN_PROTECT))
+		tx_arvif->beacon_prot = true;
+
 	/* Return from here for the transmitted profile */
 	if (!bssid_index)
 		return;
@@ -1509,6 +1516,19 @@ static void ath12k_mac_set_arvif_ies(struct ath12k_link_vif *arvif, struct sk_bu
 
 			if (index->data[0] == bssid_index) {
 				*nontx_profile_found = true;
+
+				/* Check if nontx BSS has beacon protection enabled */
+				if (!tx_arvif->beacon_prot) {
+					ext_cap_ie =
+					    cfg80211_find_elem(WLAN_EID_EXT_CAPABILITY,
+							       nontx->data,
+							       nontx->datalen);
+					if (ext_cap_ie && ext_cap_ie->datalen >= 11 &&
+					    (ext_cap_ie->data[10] &
+					     WLAN_EXT_CAPA11_BCN_PROTECT))
+						tx_arvif->beacon_prot = true;
+				}
+
 				if (cfg80211_find_ie(WLAN_EID_RSN,
 						     nontx->data,
 						     nontx->datalen)) {
@@ -1557,11 +1577,11 @@ static int ath12k_mac_setup_bcn_tmpl_ema(struct ath12k_link_vif *arvif,
 	}
 
 	if (tx_arvif == arvif)
-		ath12k_mac_set_arvif_ies(arvif, beacons->bcn[0].skb, 0, NULL);
+		ath12k_mac_set_arvif_ies(arvif, tx_arvif, beacons->bcn[0].skb, 0, NULL);
 
 	for (i = 0; i < beacons->cnt; i++) {
 		if (tx_arvif != arvif && !nontx_profile_found)
-			ath12k_mac_set_arvif_ies(arvif, beacons->bcn[i].skb,
+			ath12k_mac_set_arvif_ies(arvif, tx_arvif, beacons->bcn[i].skb,
 						 bssid_index,
 						 &nontx_profile_found);
 
@@ -1630,9 +1650,9 @@ static int ath12k_mac_setup_bcn_tmpl(struct ath12k_link_vif *arvif)
 	}
 
 	if (tx_arvif == arvif) {
-		ath12k_mac_set_arvif_ies(arvif, bcn, 0, NULL);
+		ath12k_mac_set_arvif_ies(arvif, tx_arvif, bcn, 0, NULL);
 	} else {
-		ath12k_mac_set_arvif_ies(arvif, bcn,
+		ath12k_mac_set_arvif_ies(arvif, tx_arvif, bcn,
 					 link_conf->bssid_index,
 					 &nontx_profile_found);
 		if (!nontx_profile_found)
@@ -4733,6 +4753,16 @@ static int ath12k_install_key(struct ath12k_link_vif *arvif,
 		arg.key_cipher = WMI_CIPHER_AES_GCM;
 		key->flags |= IEEE80211_KEY_FLAG_GENERATE_IV_MGMT;
 		break;
+	case WLAN_CIPHER_SUITE_AES_CMAC:
+		arg.key_cipher = WMI_CIPHER_AES_CMAC;
+		break;
+	case WLAN_CIPHER_SUITE_BIP_GMAC_128:
+	case WLAN_CIPHER_SUITE_BIP_GMAC_256:
+		arg.key_cipher = WMI_CIPHER_AES_GMAC;
+		break;
+	case WLAN_CIPHER_SUITE_BIP_CMAC_256:
+		arg.key_cipher = WMI_CIPHER_AES_CMAC;
+		break;
 	default:
 		ath12k_warn(ar->ab, "cipher %d is not supported\n", key->cipher);
 		return -EOPNOTSUPP;
@@ -4964,14 +4994,6 @@ static int ath12k_mac_op_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 
 	lockdep_assert_wiphy(hw->wiphy);
 
-	/* BIP needs to be done in software */
-	if (key->cipher == WLAN_CIPHER_SUITE_AES_CMAC ||
-	    key->cipher == WLAN_CIPHER_SUITE_BIP_GMAC_128 ||
-	    key->cipher == WLAN_CIPHER_SUITE_BIP_GMAC_256 ||
-	    key->cipher == WLAN_CIPHER_SUITE_BIP_CMAC_256) {
-		return 1;
-	}
-
 	if (key->keyidx > WMI_MAX_KEY_INDEX)
 		return -ENOSPC;
 
@@ -11588,6 +11610,8 @@ static int ath12k_mac_hw_register(struct ath12k_hw *ah)
 	}
 
 	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_PUNCT);
+	if (test_bit(WMI_TLV_SERVICE_BEACON_PROTECTION_SUPPORT, ab->wmi_ab.svc_map))
+		wiphy_ext_feature_set(hw->wiphy, NL80211_EXT_FEATURE_BEACON_PROTECTION);
 
 	ath12k_reg_init(hw);
 
diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index ea303dca38b5..89ed207225e6 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -2008,6 +2008,9 @@ int ath12k_wmi_bcn_tmpl(struct ath12k_link_vif *arvif,
 			u32p_replace_bits(&ema_params, 1, WMI_EMA_BEACON_LAST);
 		cmd->ema_params = cpu_to_le32(ema_params);
 	}
+	cmd->feature_enable_bitmap =
+		cpu_to_le32(u32_encode_bits(arvif->beacon_prot,
+					    WMI_BEACON_PROTECTION_EN_BIT));
 
 	ptr = skb->data + sizeof(*cmd);
 
diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
index 80fdbc566518..7c59fbf5ecff 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -2197,6 +2197,7 @@ enum wmi_tlv_service {
 	WMI_TLV_SERVICE_PER_PEER_HTT_STATS_RESET = 213,
 	WMI_TLV_SERVICE_FREQINFO_IN_METADATA = 219,
 	WMI_TLV_SERVICE_EXT2_MSG = 220,
+	WMI_TLV_SERVICE_BEACON_PROTECTION_SUPPORT = 244,
 	WMI_TLV_SERVICE_MBSS_PARAM_IN_VDEV_START_SUPPORT = 253,
 
 	WMI_MAX_EXT_SERVICE = 256,
@@ -3668,6 +3669,8 @@ struct ath12k_wmi_ftm_event {
 #define WMI_EMA_BEACON_FIRST    GENMASK(23, 16)
 #define WMI_EMA_BEACON_LAST     GENMASK(31, 24)
 
+#define WMI_BEACON_PROTECTION_EN_BIT	BIT(0)
+
 struct ath12k_wmi_bcn_tmpl_ema_arg {
 	u8 bcn_cnt;
 	u8 bcn_index;
@@ -4631,7 +4634,7 @@ enum wmi_ap_ps_peer_param {
 
 #define DISABLE_SIFS_RESPONSE_TRIGGER 0
 
-#define WMI_MAX_KEY_INDEX   3
+#define WMI_MAX_KEY_INDEX   7
 #define WMI_MAX_KEY_LEN     32
 
 enum wmi_key_type {

base-commit: d33705bb41ff786b537f8ed50a187a474db111c1
Depends-on: <20250421111505.3633992-1-karthikeyan.kathirvel@oss.qualcomm.com>
-- 
2.34.1


