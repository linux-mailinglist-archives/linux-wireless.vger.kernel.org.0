Return-Path: <linux-wireless+bounces-28211-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 49189C03F35
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Oct 2025 02:20:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 23D3D4F46C3
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Oct 2025 00:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD39035971;
	Fri, 24 Oct 2025 00:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aPFR6wqS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0227E19ABDE
	for <linux-wireless@vger.kernel.org>; Fri, 24 Oct 2025 00:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761265184; cv=none; b=szHBjSikd8CM4kp4Ou5wnp6bSur8P0hH8GQcNEif8pNH1V5nJ/Joa2j+67j5xBUI2o0Sp/qh9Wk4wrOCbvPNSexiM4idSBOnPv0LT4buTSeffE6NpJ8iPu3APNAiO+/fOCNQzpLWGll+1hyWRiM+mQV7wSHMdNuZKGp387Ady68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761265184; c=relaxed/simple;
	bh=ormVbav3x4JcrolM2MONctcmtZzG6Nxm7WdPQV7witg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i9qARMj+FQIbBO1G2GpA/StLd5UY6kEEKXMQE+kTkh/xGzlQYeR7yeCg1QDg1G2+BaJjkQRkW4YuAjL5Xjp2Mp/2QoNm3bResQPV0yN/JgTxZBII9OGKmlc80q1qrp5cOlIL7IZKLV0z+p09G1fhImnlSWgtIwL/OQUqdMcrQFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aPFR6wqS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59NG4I35027485
	for <linux-wireless@vger.kernel.org>; Fri, 24 Oct 2025 00:19:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=1uhYmznrh4Y
	sAZSxAhg6tzNwg1UihZ2Youcj43pOEBw=; b=aPFR6wqSqEOI0no2JJZI9OkAwK+
	GLfjx7JuhaX87L4vyYuikUyyNaW4P343pNk/xgbPSU98mJR9zaICtmuqYBPn4kai
	IwG1u9SoayR3heB0PSNNxx0jsRkJ3mtU0XKbMg9gK2jPZqaRruDSt4SMMjk5xPbZ
	5qqpDUauE4N47zw5hgoJK0osyiR9IdfshJNOYwjJgij0seZsdhbsflqw/LR3XFM8
	1oDBdya+cTcL7X4Mp+EwG6U1AVHCGoJuV1fn7jKqRhxZhnJMEOF9NpIjyjF7yHr2
	hkS++MNebxRuggvAlCTsml4gL0f0ID4D/K9/vNK2bZexysGL73hxvyelahA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49y524cg6k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 24 Oct 2025 00:19:42 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-33ba9047881so1604893a91.1
        for <linux-wireless@vger.kernel.org>; Thu, 23 Oct 2025 17:19:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761265181; x=1761869981;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1uhYmznrh4YsAZSxAhg6tzNwg1UihZ2Youcj43pOEBw=;
        b=CwTQx3AVPtSQ1IHpa76isB0Ll+fsrH7vl5IPAfOWPifNzhodfgyKdO9TfTXLUV8zzD
         YAD0vAHb9/L82gzxKhLanYkBn0/n+2dqf6PMX0YbxcS+XZBB3SdE7JjxrPkdLLcMf6Or
         jWGv7YQKBEw4FVp65uOPUxBHSx9Ev+5poOGvOqdYl1VONGj99sWPa3xEPnaxfpFdGMkK
         F3lnvdQHUmhS7/JZojfKY01NdpbHjWPVJN3SHYOk5WRgz4orcfsRKQrxC6yyCob6PeWS
         HnfD0I6jMH4OhFjXyzYMY1s3+hRzjpGhxSDQaGX25drpaGkkPcJZx7JBjo4HnASOkrRk
         B7pg==
X-Gm-Message-State: AOJu0YxDoHsZJcnfUh5KqisophoNKFW5Az256QbDd9u1DtRbeMYltUNZ
	NeGLUxxV+68IKg9cy6RIVmzaUsqJpHNqH8WMhZIml/YJ/T+f6i6RdzLiCjgnvYFdxwP6wTYKraq
	gPAQgW/+9TQ1sbFPHYicf5OmBzlEO78xKNPgJxD7TSqW4lpFD2Ho8G0URhcy5wSLVlIZCjZMKvN
	Fwug==
X-Gm-Gg: ASbGncuY3CkqEXgfSP0Ztztewl/aRIImy1vkJpOm+I34geJ/WhDVYDG5SdMWX1kIxbx
	5tADbW0t6CF2cXT64GIlmgQrZ1qifzIeMPmQBxO8Xg4YzV3WeyNsRa3/yP17mSaxxrx9vBSDSD3
	8MpS1VsT5v102LtpCotbG4kpdpynW+v1O1nPzQuTYTUoi+D1lng42M6XegseadP+0aa1N3EJ/xJ
	GrMJoyGnbkz9O4HSjhEK/zk/KoaKV46D3/NCYwdmey4uWOoBeeYiQXN9OmZslx+49woThTGW/gw
	WzzarausYQ6oBrfdiMAAeORZQYZRnbieciG4OKTqKb352QftDsv1Zmxx4uSM+jJUDrilOExQ8dc
	/LWlRcmZpKO1vVEf5V8xHC7HCHFViZdY1RnZu7eSlCPlCkYnD2koffqg=
X-Received: by 2002:a17:90b:4a50:b0:339:e8c7:d47d with SMTP id 98e67ed59e1d1-33fd3bbcfefmr942219a91.9.1761265180160;
        Thu, 23 Oct 2025 17:19:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH6QSj6H0WeJ0+oL2ydkaYa1rBwt3i5f7u23A5zXKVR/sHBK6Ahw/kWEDCV7tlhk366lC+Hhg==
X-Received: by 2002:a17:90b:4a50:b0:339:e8c7:d47d with SMTP id 98e67ed59e1d1-33fd3bbcfefmr942195a91.9.1761265179709;
        Thu, 23 Oct 2025 17:19:39 -0700 (PDT)
Received: from msinada-linux.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6cf4bb65b3sm3296264a12.8.2025.10.23.17.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 17:19:39 -0700 (PDT)
From: Muna Sinada <muna.sinada@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, Muna Sinada <muna.sinada@oss.qualcomm.com>,
        Aaradhana Sahu <quic_aarasahu@quicinc.com>
Subject: [PATCH ath-next 6/6] wifi: ath12k: Set EHT fixed rates for associated STAs
Date: Thu, 23 Oct 2025 17:19:28 -0700
Message-Id: <20251024001928.257356-7-muna.sinada@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251024001928.257356-1-muna.sinada@oss.qualcomm.com>
References: <20251024001928.257356-1-muna.sinada@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIyMDE1NSBTYWx0ZWRfX1tkpiBJUoH0D
 4VzAGBoLuN3ya/eXlNDyyimu/difxp7QO56L6BHu4T6yNjXFSg6AlQGErEtLZP34jiDCmgN/qEX
 xqEoOTodgao/qNGPIULBRTYeI0Hi4KVT5RddunincTOMWl5Kg1lNi//o4hcpFPuZ44+zqf0ddoX
 R6ZtFqq71wPwg5v9I1Eylb62z7bNW58zghKsnwiyRcz/hMNzwb3qbsyttDS7CZTyBzSNH4gcge0
 CiePTv1cCHkF3psQG2JS4Y1HC+DIrADbvpjufPBqpqa0GBaRmhhTKTMIALD9EWXKebB7JELkmfr
 t49RFAENU2YGp6WrxOFjlZf3/zhI3hZGRi5zdSIGd336h/ZgLfmGB6/2MZz4mbphXBnPRTyxZhi
 V92UKaLaWc8ovLIq6DU/g46p4qzjfQ==
X-Authority-Analysis: v=2.4 cv=Uotu9uwB c=1 sm=1 tr=0 ts=68fac61e cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=y3pyt056CyUJ2_mRiK0A:9 a=iS9zxrgQBfv6-_F4QbHw:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: BC0AH7wcHzz8MaZA096qs7eayEMnPneP
X-Proofpoint-ORIG-GUID: BC0AH7wcHzz8MaZA096qs7eayEMnPneP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-23_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 adultscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510220155

Fixed rate is set for STAs that are associated. This will be done
during association or with ath12k_sta_rc_update_wk().

Add EHT fixed rate setting for STAs by adding call to
ath12k_mac_set_peer_eht_fixed_rate() during the times fixed rate is
set for STAs. This new function sets EHT fixed rate for a peer, which
sends WMI command with the updated MCS/NSS rate using
WMI_PEER_PARAM_FIXED_RATE command id.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Co-developed-by: Aaradhana Sahu <quic_aarasahu@quicinc.com>
Signed-off-by: Aaradhana Sahu <quic_aarasahu@quicinc.com>
Signed-off-by: Muna Sinada <muna.sinada@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 92 +++++++++++++++++++++++++--
 1 file changed, 85 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 31b0e641ce55..da94108c3f64 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -6035,6 +6035,65 @@ ath12k_mac_set_peer_he_fixed_rate(struct ath12k_link_vif *arvif,
 	return ret;
 }
 
+static int
+ath12k_mac_set_peer_eht_fixed_rate(struct ath12k_link_vif *arvif,
+				   struct ath12k_link_sta *arsta,
+				   const struct cfg80211_bitrate_mask *mask,
+				   enum nl80211_band band)
+{
+	struct ath12k_sta *ahsta = arsta->ahsta;
+	struct ath12k *ar = arvif->ar;
+	struct ieee80211_sta *sta;
+	struct ieee80211_link_sta *link_sta;
+	u8 eht_rate, nss = 0;
+	u32 rate_code;
+	int ret, i;
+
+	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
+
+	sta = ath12k_ahsta_to_sta(ahsta);
+
+	for (i = 0; i < ARRAY_SIZE(mask->control[band].eht_mcs); i++) {
+		if (hweight16(mask->control[band].eht_mcs[i]) == 1) {
+			nss = i + 1;
+			eht_rate = ffs(mask->control[band].eht_mcs[i]) - 1;
+		}
+	}
+
+	if (!nss) {
+		ath12k_warn(ar->ab, "No single EHT Fixed rate found to set for %pM\n",
+			    arsta->addr);
+		return -EINVAL;
+	}
+
+	/* Avoid updating invalid nss as fixed rate*/
+	link_sta = ath12k_mac_get_link_sta(arsta);
+	if (!link_sta || nss > link_sta->rx_nss) {
+		ath12k_warn(ar->ab,
+			    "unable to access link sta for sta %pM link %u or fixed nss of %u is not supported by sta\n",
+			    sta->addr, arsta->link_id, nss);
+		return -EINVAL;
+	}
+
+	ath12k_dbg(ar->ab, ATH12K_DBG_MAC,
+		   "Setting Fixed EHT Rate for peer %pM. Device will not switch to any other selected rates\n",
+		   arsta->addr);
+
+	rate_code = ATH12K_HW_RATE_CODE(eht_rate, nss - 1,
+					WMI_RATE_PREAMBLE_EHT);
+
+	ret = ath12k_wmi_set_peer_param(ar, arsta->addr,
+					arvif->vdev_id,
+					WMI_PEER_PARAM_FIXED_RATE,
+					rate_code);
+	if (ret)
+		ath12k_warn(ar->ab,
+			    "failed to update STA %pM Fixed Rate %d: %d\n",
+			    arsta->addr, rate_code, ret);
+
+	return ret;
+}
+
 static int ath12k_mac_station_assoc(struct ath12k *ar,
 				    struct ath12k_link_vif *arvif,
 				    struct ath12k_link_sta *arsta,
@@ -6047,7 +6106,7 @@ static int ath12k_mac_station_assoc(struct ath12k *ar,
 	struct cfg80211_chan_def def;
 	enum nl80211_band band;
 	struct cfg80211_bitrate_mask *mask;
-	u8 num_vht_rates, num_he_rates;
+	u8 num_vht_rates, num_he_rates, num_eht_rates;
 	u8 link_id = arvif->link_id;
 
 	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
@@ -6090,10 +6149,11 @@ static int ath12k_mac_station_assoc(struct ath12k *ar,
 
 	num_vht_rates = ath12k_mac_bitrate_mask_num_vht_rates(ar, band, mask);
 	num_he_rates = ath12k_mac_bitrate_mask_num_he_rates(ar, band, mask);
+	num_eht_rates = ath12k_mac_bitrate_mask_num_eht_rates(ar, band, mask);
 
-	/* If single VHT/HE rate is configured (by set_bitrate_mask()),
-	 * peer_assoc will disable VHT/HE. This is now enabled by a peer specific
-	 * fixed param.
+	/* If single VHT/HE/EHT rate is configured (by set_bitrate_mask()),
+	 * peer_assoc will disable VHT/HE/EHT. This is now enabled by a peer
+	 * specific fixed param.
 	 * Note that all other rates and NSS will be disabled for this peer.
 	 */
 	link_sta = ath12k_mac_get_link_sta(arsta);
@@ -6113,6 +6173,10 @@ static int ath12k_mac_station_assoc(struct ath12k *ar,
 		ret = ath12k_mac_set_peer_he_fixed_rate(arvif, arsta, mask, band);
 		if (ret)
 			return ret;
+	} else if (link_sta->eht_cap.has_eht && num_eht_rates == 1) {
+		ret = ath12k_mac_set_peer_eht_fixed_rate(arvif, arsta, mask, band);
+		if (ret)
+			return ret;
 	}
 
 	/* Re-assoc is run only to update supported rates for given station. It
@@ -6175,8 +6239,9 @@ static void ath12k_sta_rc_update_wk(struct wiphy *wiphy, struct wiphy_work *wk)
 	const u8 *ht_mcs_mask;
 	const u16 *vht_mcs_mask;
 	const u16 *he_mcs_mask;
+	const u16 *eht_mcs_mask;
 	u32 changed, bw, nss, mac_nss, smps, bw_prev;
-	int err, num_vht_rates, num_he_rates;
+	int err, num_vht_rates, num_he_rates, num_eht_rates;
 	const struct cfg80211_bitrate_mask *mask;
 	enum wmi_phy_mode peer_phymode;
 	struct ath12k_link_sta *arsta;
@@ -6197,6 +6262,7 @@ static void ath12k_sta_rc_update_wk(struct wiphy *wiphy, struct wiphy_work *wk)
 	ht_mcs_mask = arvif->bitrate_mask.control[band].ht_mcs;
 	vht_mcs_mask = arvif->bitrate_mask.control[band].vht_mcs;
 	he_mcs_mask = arvif->bitrate_mask.control[band].he_mcs;
+	eht_mcs_mask = arvif->bitrate_mask.control[band].eht_mcs;
 
 	spin_lock_bh(&ar->data_lock);
 
@@ -6214,6 +6280,7 @@ static void ath12k_sta_rc_update_wk(struct wiphy *wiphy, struct wiphy_work *wk)
 	mac_nss = max3(ath12k_mac_max_ht_nss(ht_mcs_mask),
 		       ath12k_mac_max_vht_nss(vht_mcs_mask),
 		       ath12k_mac_max_he_nss(he_mcs_mask));
+	mac_nss = max(mac_nss, ath12k_mac_max_eht_nss(eht_mcs_mask));
 	nss = min(nss, mac_nss);
 
 	struct ath12k_wmi_peer_assoc_arg *peer_arg __free(kfree) =
@@ -6299,6 +6366,8 @@ static void ath12k_sta_rc_update_wk(struct wiphy *wiphy, struct wiphy_work *wk)
 								      mask);
 		num_he_rates = ath12k_mac_bitrate_mask_num_he_rates(ar, band,
 								    mask);
+		num_eht_rates = ath12k_mac_bitrate_mask_num_eht_rates(ar, band,
+								      mask);
 
 		/* Peer_assoc_prepare will reject vht rates in
 		 * bitrate_mask if its not available in range format and
@@ -6323,9 +6392,18 @@ static void ath12k_sta_rc_update_wk(struct wiphy *wiphy, struct wiphy_work *wk)
 							   band);
 		} else if (link_sta->he_cap.has_he && num_he_rates == 1) {
 			ath12k_mac_set_peer_he_fixed_rate(arvif, arsta, mask, band);
+		} else if (link_sta->eht_cap.has_eht && num_eht_rates == 1) {
+			err = ath12k_mac_set_peer_eht_fixed_rate(arvif, arsta,
+								 mask, band);
+			if (err) {
+				ath12k_warn(ar->ab,
+					    "failed to set peer EHT fixed rate for STA %pM ret %d\n",
+					    arsta->addr, err);
+				return;
+			}
 		} else {
-			/* If the peer is non-VHT/HE or no fixed VHT/HE rate
-			 * is provided in the new bitrate mask we set the
+			/* If the peer is non-VHT/HE/EHT or no fixed VHT/HE/EHT
+			 * rate is provided in the new bitrate mask we set the
 			 * other rates using peer_assoc command. Also clear
 			 * the peer fixed rate settings as it has higher proprity
 			 * than peer assoc
-- 
2.34.1


