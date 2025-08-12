Return-Path: <linux-wireless+bounces-26346-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ABF3B23AC9
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Aug 2025 23:37:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E5C62A773E
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Aug 2025 21:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA49197A76;
	Tue, 12 Aug 2025 21:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UXe8XTGa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3372D0624
	for <linux-wireless@vger.kernel.org>; Tue, 12 Aug 2025 21:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755034619; cv=none; b=oO/+xKj6mqYCdCszouokrYXwLWyzQBCVIbRlx0cAIxtZDU/5E+RaUBUVE43BxFJlHGzki1rsiZQfiMuyjxjJC+cRuxecWMIB90rUOt2kfaZRYSa1/9gLMDaRuDCxHh6JfzXLXRdWem9Go1kTTFCvTncB64Q+NPti8qfWKzd1GL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755034619; c=relaxed/simple;
	bh=QVz6os6XmvTHxNmnXMG4cltahyeIKI+2pBWVk+XftVQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uW3um7Sja6FnGC908JnslGBxYb7SCwt7aFl97q9EHAO5FBY+JA8yE9AHbVx28woPeYVTMNbckKtAcdCiwD/G3UEoJtu24yFRRsTX6fNzQ1KwyRZKxuQH++50ShIxQWxcK2j50vX/8x7MR5gzREonrHYBr+fT/JwqrRr8ecmeMUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UXe8XTGa; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57CH6IFv010549
	for <linux-wireless@vger.kernel.org>; Tue, 12 Aug 2025 21:36:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=BbNon3v1iADOEsodwNge+EuREs3l0/Fb8ni
	ZghKMEMA=; b=UXe8XTGa3HGzlMRSSB1tTZ8PKG8gbK1MNCTybxxUi9gRk7YfQdY
	FxeK+Yc72kPMlS3FsARfsvMqJSo2jZfzLSighUs7eNyWb/rBnvoOqyG0HlKHGHQF
	hIA1BM/2rUbnyYThFt7brw+b4f5AeXbm2/WrGOvATuXOvuSoxCnGmnJ821aPldQX
	ZzB3JgPHlPTPAhrQHxVA72A6+Xequo1MR+RqSqCtn9TjYWrMRpBe92Mnk7LZoae+
	VjKeRVzT8Kun36RODoiB0XJpukppWOmourG6QeAPzvW5x/UQ5TB9v1j0n2cryxbm
	JFB0IGXk+ZdUFdbDsoZ3REBIFjGN5POpK1g==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48g9q9rnp5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 12 Aug 2025 21:36:56 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b42bcfe9cf3so2914540a12.2
        for <linux-wireless@vger.kernel.org>; Tue, 12 Aug 2025 14:36:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755034616; x=1755639416;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BbNon3v1iADOEsodwNge+EuREs3l0/Fb8niZghKMEMA=;
        b=lwRL2OrbcSPrVmYNzyu5uuGrXu9dekNfLwfwTLU5Ftd/5+l+NPI7iH0BQEXXpmmgbP
         j5U0VrPxmhFH1uRWHv3heXMh2DSloA4r5u6pozdAMcV9+SF3fMvLi3/Ek7zKL1xaNmi0
         KopWT3uwzHUnNgWPieVpEchcowjZEbW5Q8Y7LEmoijMEJG628z7TteAAhAM06T8+5Gc+
         h8zgBFC04GY7BfWOGAFeWn2oLx5Abor77sB4c052hdjCGgZhs23huKW9EnN92IhM4qCo
         1I5mhxtz8eqbMO2AkbbMIC6Ul1kZYdTOHRTDbeYDWhlmcwlNs9UG9d+xTWSHnLFQwXX+
         2UvQ==
X-Gm-Message-State: AOJu0YzOIOQLOVHf2Ttx2zyBnvqmHz4LvB4STbnxfJSHLaFNiOL9WIHO
	1ABHPvmw6OIDynFelqwsT5gK6/S8qO+CKMprDJ35RtMOwEFbqHJrAF2OFlCUULASN55ftGYbOjM
	1mVSjaoNeZCvcOKir6uhoZam1k+PWhDLAzutzv8vSCfso+DQNetSZA9NM6UrEmux7bObx9A==
X-Gm-Gg: ASbGncvhEfCnqcGLfiJU+5qGMjt7EESZNLKst4iPr+AlGnpaFWAxgspRCkRDCkzOXOe
	gCjQg0cZrYBxtG6w32rc+nHTMMZnZ+9KLd/kC/lFv/+XnXfiDSmni0/6bm1d6UXXBu7gZXoId6o
	9e0MxUcSLERE7sxmifZ2YEXZC7YL9JoVsZEZZ3VZ5Y7oKtKZg/vzagNxrrNCm6X2uSiZW3CgogR
	0+T0zp0xfUeFNJzGtewXbpZ4Lh6msKyB52w2SfnTJtLa89EwHN57zj3UWiapDFKh649JzJOdOVU
	w6KRy6JABwm4Z0KSJnqabPE07MWc3/CcWxmbUi1JcchXeoy1lpfVI1B04hcU3Jau92MTr330g/+
	PFQ0ClkK1D34BrQGgM5Va
X-Received: by 2002:a05:6a20:12c1:b0:240:1c36:79a3 with SMTP id adf61e73a8af0-240a8b0c120mr1403260637.22.1755034615823;
        Tue, 12 Aug 2025 14:36:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7+Fqkex1wh+iYAxGH1hcOXLTMVAX2dIpyeIGxuDB/kCOo4xRuCiZt0bGKOrvxrGbBMr4m/Q==
X-Received: by 2002:a05:6a20:12c1:b0:240:1c36:79a3 with SMTP id adf61e73a8af0-240a8b0c120mr1403224637.22.1755034615341;
        Tue, 12 Aug 2025 14:36:55 -0700 (PDT)
Received: from msinada-linux.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bcce6f6fesm30157647b3a.26.2025.08.12.14.36.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 14:36:54 -0700 (PDT)
From: Muna Sinada <muna.sinada@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, Muna Sinada <muna.sinada@oss.qualcomm.com>,
        Aloka Dixit <aloka.dixit@oss.qualcomm.com>
Subject: [PATCH wireless-next] wifi: nl80211: Add EHT fixed Tx rate support
Date: Tue, 12 Aug 2025 14:36:52 -0700
Message-Id: <20250812213652.3763535-1-muna.sinada@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=CNMqXQrD c=1 sm=1 tr=0 ts=689bb3f9 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=5bTSNDBzF7mqxrjNMNsA:9
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: wrVOtBx_pd1lA7cDxcAc2Ihile8cf68o
X-Proofpoint-ORIG-GUID: wrVOtBx_pd1lA7cDxcAc2Ihile8cf68o
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDE2NCBTYWx0ZWRfX1NpiJqBo31y/
 wtC9EVPHx6LJKxnbw6ykNLMnToiM7AxImuZ1CI9mFYoA0EL86TA3ch/0oR/3ecYFtP0QArkc9/Z
 dsB/MStbAdTLqHBLDC+E5883WeTqN1LiObPMMycLo4s3Iyg8iHdIf1HNA1YaqGwL6lE6v7ocQi1
 KaqpnT5Hc5SN3zwBiMD/Tvob8MfDm3AFfaDEiuxZ9bjBPBS0c+EOrw6YCWTgp3Yd99hLqpbemPJ
 TBTgr3GTWhHzkXYs46J0Bkp6eTwLxtKOgqsL0/4uFew9p8N8A1uT5lKNuoLLJauNbUOgZ48CAZ2
 ZlJahEVCZnEkOmQyKAItSJBtmlNhzCVGjdRcsf3v+eIFAkzGpSNhO2kWNdch6vuY+/f9nbD0M4m
 2TAyu1Ms
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_08,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 phishscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508120164

Add new attributes to support EHT MCS/NSS Tx rates and EHT GI/LTF.
Parse EHT fixed MCS/NSS Tx rates and EHT GI/LTF values passed by the
userspace, validate and add as part of cfg80211_bitrate_mask.

MCS mask is constructed by new function, eht_build_mcs_mask(). Max NSS
supported for MCS rates of 7, 9, 11 and 13 is utilized to set MCS
bitmask for each NSS. MCS rates 14, and 15 if supported, are set only
for NSS = 0.

Co-developed-by: Aloka Dixit <aloka.dixit@oss.qualcomm.com>
Signed-off-by: Aloka Dixit <aloka.dixit@oss.qualcomm.com>
Signed-off-by: Muna Sinada <muna.sinada@oss.qualcomm.com>
---
 include/net/cfg80211.h       |   3 +
 include/uapi/linux/nl80211.h |  32 ++++++
 net/wireless/nl80211.c       | 214 ++++++++++++++++++++++++++++++++++-
 3 files changed, 246 insertions(+), 3 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 406626ff6cc8..8f80b163b98b 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -841,9 +841,12 @@ struct cfg80211_bitrate_mask {
 		u8 ht_mcs[IEEE80211_HT_MCS_MASK_LEN];
 		u16 vht_mcs[NL80211_VHT_NSS_MAX];
 		u16 he_mcs[NL80211_HE_NSS_MAX];
+		u16 eht_mcs[NL80211_EHT_NSS_MAX];
 		enum nl80211_txrate_gi gi;
 		enum nl80211_he_gi he_gi;
+		enum nl80211_eht_gi eht_gi;
 		enum nl80211_he_ltf he_ltf;
+		enum nl80211_eht_ltf eht_ltf;
 	} control[NUM_NL80211_BANDS];
 };
 
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index d1a14f2892d9..f469e1f9f4cb 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -3735,6 +3735,22 @@ enum nl80211_eht_gi {
 	NL80211_RATE_INFO_EHT_GI_3_2,
 };
 
+/**
+ * enum nl80211_eht_ltf - EHT long training field
+ * @NL80211_RATE_INFO_EHT_1XLTF: 3.2 usec
+ * @NL80211_RATE_INFO_EHT_2XLTF: 6.4 usec
+ * @NL80211_RATE_INFO_EHT_4XLTF: 12.8 usec
+ * @NL80211_RATE_INFO_EHT_6XLTF: 19.2 usec
+ * @NL80211_RATE_INFO_EHT_8XLTF: 25.6 usec
+ */
+enum nl80211_eht_ltf {
+	NL80211_RATE_INFO_EHT_1XLTF,
+	NL80211_RATE_INFO_EHT_2XLTF,
+	NL80211_RATE_INFO_EHT_4XLTF,
+	NL80211_RATE_INFO_EHT_6XLTF,
+	NL80211_RATE_INFO_EHT_8XLTF,
+};
+
 /**
  * enum nl80211_eht_ru_alloc - EHT RU allocation values
  * @NL80211_RATE_INFO_EHT_RU_ALLOC_26: 26-tone RU allocation
@@ -5481,6 +5497,10 @@ enum nl80211_key_attributes {
  *	see &struct nl80211_txrate_he
  * @NL80211_TXRATE_HE_GI: configure HE GI, 0.8us, 1.6us and 3.2us.
  * @NL80211_TXRATE_HE_LTF: configure HE LTF, 1XLTF, 2XLTF and 4XLTF.
+ * @NL80211_TXRATE_EHT: EHT rates allowed for TX rate selection,
+ *	see &struct nl80211_txrate_eht
+ * @NL80211_TXRATE_EHT_GI: configure EHT GI, (u8, see &enum nl80211_eht_gi)
+ * @NL80211_TXRATE_EHT_LTF: configure EHT LTF, (u8, see &enum nl80211_eht_ltf)
  * @__NL80211_TXRATE_AFTER_LAST: internal
  * @NL80211_TXRATE_MAX: highest TX rate attribute
  */
@@ -5493,6 +5513,9 @@ enum nl80211_tx_rate_attributes {
 	NL80211_TXRATE_HE,
 	NL80211_TXRATE_HE_GI,
 	NL80211_TXRATE_HE_LTF,
+	NL80211_TXRATE_EHT,
+	NL80211_TXRATE_EHT_GI,
+	NL80211_TXRATE_EHT_LTF,
 
 	/* keep last */
 	__NL80211_TXRATE_AFTER_LAST,
@@ -5525,6 +5548,15 @@ enum nl80211_txrate_gi {
 	NL80211_TXRATE_FORCE_LGI,
 };
 
+#define NL80211_EHT_NSS_MAX             16
+/**
+ * struct nl80211_txrate_eht - EHT MCS/NSS txrate bitmap
+ * @mcs: MCS bitmap table for each NSS (array index 0 for 1 stream, etc.)
+ */
+struct nl80211_txrate_eht {
+	__u16 mcs[NL80211_EHT_NSS_MAX];
+};
+
 /**
  * enum nl80211_band - Frequency band
  * @NL80211_BAND_2GHZ: 2.4 GHz ISM band
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 89519aa52893..8526fc366ad7 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -411,6 +411,14 @@ static const struct nla_policy nl80211_txattr_policy[NL80211_TXRATE_MAX + 1] = {
 	[NL80211_TXRATE_HE_LTF] = NLA_POLICY_RANGE(NLA_U8,
 						   NL80211_RATE_INFO_HE_1XLTF,
 						   NL80211_RATE_INFO_HE_4XLTF),
+	[NL80211_TXRATE_EHT] = NLA_POLICY_EXACT_LEN(sizeof(struct nl80211_txrate_eht)),
+	[NL80211_TXRATE_EHT_GI] =  NLA_POLICY_RANGE(NLA_U8,
+						   NL80211_RATE_INFO_EHT_GI_0_8,
+						   NL80211_RATE_INFO_EHT_GI_3_2),
+	[NL80211_TXRATE_EHT_LTF] = NLA_POLICY_RANGE(NLA_U8,
+						   NL80211_RATE_INFO_EHT_1XLTF,
+						   NL80211_RATE_INFO_EHT_8XLTF),
+
 };
 
 static const struct nla_policy
@@ -5393,6 +5401,174 @@ static bool he_set_mcs_mask(struct genl_info *info,
 	return true;
 }
 
+static int eht_build_mcs_mask(struct genl_info *info,
+			      const struct ieee80211_sta_he_cap *he_cap,
+			      const struct ieee80211_sta_eht_cap *eht_cap,
+			      u16 *mcs_mask)
+{
+	struct net_device *dev = info->user_ptr[1];
+	struct wireless_dev *wdev = dev->ieee80211_ptr;
+	u8 mcs_nss_len, nss, mcs_7 = 0, mcs_9 = 0, mcs_11 = 0, mcs_13 = 0;
+	bool mcs_14 = false, mcs_15 = false;
+	unsigned int link_id = nl80211_link_id(info->attrs);
+
+	mcs_nss_len = ieee80211_eht_mcs_nss_size(&he_cap->he_cap_elem,
+						 &eht_cap->eht_cap_elem,
+						 wdev->iftype ==
+							NL80211_IFTYPE_STATION);
+
+	if (eht_cap->eht_cap_elem.phy_cap_info[6] &
+	    IEEE80211_EHT_PHY_CAP6_EHT_DUP_6GHZ_SUPP)
+		mcs_14 = true;
+
+	if (eht_cap->eht_cap_elem.phy_cap_info[6] &
+	    IEEE80211_EHT_PHY_CAP6_MCS15_SUPP_MASK)
+		mcs_15 = true;
+
+	if (mcs_nss_len == 4) {
+		const struct ieee80211_eht_mcs_nss_supp_20mhz_only *mcs =
+					&eht_cap->eht_mcs_nss_supp.only_20mhz;
+
+		mcs_7 = u8_get_bits(mcs->rx_tx_mcs7_max_nss,
+				    IEEE80211_EHT_MCS_NSS_TX);
+		mcs_9 = u8_get_bits(mcs->rx_tx_mcs9_max_nss,
+				    IEEE80211_EHT_MCS_NSS_TX);
+		mcs_11 = u8_get_bits(mcs->rx_tx_mcs11_max_nss,
+				     IEEE80211_EHT_MCS_NSS_TX);
+		mcs_13 = u8_get_bits(mcs->rx_tx_mcs13_max_nss,
+				     IEEE80211_EHT_MCS_NSS_TX);
+
+	} else {
+		const struct ieee80211_eht_mcs_nss_supp_bw *mcs;
+		enum nl80211_chan_width width;
+
+		switch (wdev->iftype) {
+		case NL80211_IFTYPE_ADHOC:
+			width = wdev->u.ibss.chandef.width;
+			break;
+		case NL80211_IFTYPE_AP:
+		case NL80211_IFTYPE_P2P_GO:
+			if (wdev->valid_links)
+				width = wdev->links[link_id].ap.chandef.width;
+			else
+				width = wdev->u.ap.preset_chandef.width;
+			break;
+		case NL80211_IFTYPE_MESH_POINT:
+			width = wdev->u.mesh.chandef.width;
+			break;
+		case NL80211_IFTYPE_OCB:
+			width = wdev->u.ocb.chandef.width;
+			break;
+		default:
+			return -EINVAL;
+		}
+
+		switch (width) {
+		case NL80211_CHAN_WIDTH_320:
+			mcs = &eht_cap->eht_mcs_nss_supp.bw._320;
+			break;
+		case NL80211_CHAN_WIDTH_160:
+			mcs = &eht_cap->eht_mcs_nss_supp.bw._160;
+			break;
+		case NL80211_CHAN_WIDTH_80:
+		case NL80211_CHAN_WIDTH_40:
+		case NL80211_CHAN_WIDTH_20:
+			mcs = &eht_cap->eht_mcs_nss_supp.bw._80;
+			break;
+		default:
+			return -EINVAL;
+		}
+
+		mcs_7 = u8_get_bits(mcs->rx_tx_mcs9_max_nss,
+				    IEEE80211_EHT_MCS_NSS_TX);
+		mcs_9 = u8_get_bits(mcs->rx_tx_mcs9_max_nss,
+				    IEEE80211_EHT_MCS_NSS_TX);
+		mcs_11 = u8_get_bits(mcs->rx_tx_mcs11_max_nss,
+				     IEEE80211_EHT_MCS_NSS_TX);
+		mcs_13 = u8_get_bits(mcs->rx_tx_mcs13_max_nss,
+				     IEEE80211_EHT_MCS_NSS_TX);
+	}
+
+	for (nss = 0; nss < NL80211_EHT_NSS_MAX; nss++) {
+		if (nss == 0) {
+			if (mcs_14)
+				mcs_mask[nss] |= 0x4000;
+			if (mcs_15)
+				mcs_mask[nss] |= 0x8000;
+		}
+
+		if (!mcs_7)
+			continue;
+		mcs_mask[nss] |= 0x00FF;
+		mcs_7--;
+
+		if (!mcs_9)
+			continue;
+		mcs_mask[nss] |= 0x0300;
+		mcs_9--;
+
+		if (!mcs_11)
+			continue;
+		mcs_mask[nss] |= 0x0C00;
+		mcs_11--;
+
+		if (!mcs_13)
+			continue;
+		mcs_mask[nss] |= 0x3000;
+		mcs_13--;
+	}
+
+	return 0;
+}
+
+static bool eht_set_mcs_mask(struct genl_info *info, struct wireless_dev *wdev,
+			     struct ieee80211_supported_band *sband,
+			     struct nl80211_txrate_eht *txrate,
+			     u16 mcs[NL80211_EHT_NSS_MAX])
+{
+	const struct ieee80211_sta_he_cap *he_cap;
+	const struct ieee80211_sta_eht_cap *eht_cap;
+	u16 tx_mcs_mask[NL80211_EHT_NSS_MAX] = { 0 };
+	u8 i;
+
+	he_cap = ieee80211_get_he_iftype_cap(sband, wdev->iftype);
+	if (!he_cap)
+		return false;
+
+	eht_cap = ieee80211_get_eht_iftype_cap(sband, wdev->iftype);
+	if (!eht_cap)
+		return false;
+
+	/* Checks for MCS 14 */
+	if (txrate->mcs[0] & 0x4000) {
+		if (sband->band != NL80211_BAND_6GHZ)
+			return false;
+
+		if (!(eht_cap->eht_cap_elem.phy_cap_info[6] &
+		      IEEE80211_EHT_PHY_CAP6_EHT_DUP_6GHZ_SUPP))
+			return false;
+	}
+
+	/* Checks for MCS 15 */
+	if ((txrate->mcs[0] & 0x8000) &&
+	    (!(eht_cap->eht_cap_elem.phy_cap_info[6] &
+	       IEEE80211_EHT_PHY_CAP6_MCS15_SUPP_MASK)))
+		return false;
+
+	if (eht_build_mcs_mask(info, he_cap, eht_cap, tx_mcs_mask))
+		return false;
+
+	memset(mcs, 0, sizeof(u16) * NL80211_EHT_NSS_MAX);
+	for (i = 0; i < NL80211_EHT_NSS_MAX; i++) {
+		if ((tx_mcs_mask[i] & txrate->mcs[i]) == txrate->mcs[i])
+			mcs[i] = txrate->mcs[i];
+		else
+			return false;
+	}
+
+	return true;
+}
+
 static int nl80211_parse_tx_bitrate_mask(struct genl_info *info,
 					 struct nlattr *attrs[],
 					 enum nl80211_attrs attr,
@@ -5404,7 +5580,7 @@ static int nl80211_parse_tx_bitrate_mask(struct genl_info *info,
 	struct nlattr *tb[NL80211_TXRATE_MAX + 1];
 	struct cfg80211_registered_device *rdev = info->user_ptr[0];
 	struct wireless_dev *wdev = dev->ieee80211_ptr;
-	int rem, i;
+	int rem, i, ret;
 	struct nlattr *tx_rates;
 	struct ieee80211_supported_band *sband;
 	u16 vht_tx_mcs_map, he_tx_mcs_map;
@@ -5413,6 +5589,7 @@ static int nl80211_parse_tx_bitrate_mask(struct genl_info *info,
 	/* Default to all rates enabled */
 	for (i = 0; i < NUM_NL80211_BANDS; i++) {
 		const struct ieee80211_sta_he_cap *he_cap;
+		const struct ieee80211_sta_eht_cap *eht_cap;
 
 		if (!default_all_enabled)
 			break;
@@ -5441,6 +5618,19 @@ static int nl80211_parse_tx_bitrate_mask(struct genl_info *info,
 
 		mask->control[i].he_gi = 0xFF;
 		mask->control[i].he_ltf = 0xFF;
+
+		eht_cap = ieee80211_get_eht_iftype_cap(sband, wdev->iftype);
+		if (!eht_cap)
+			continue;
+
+		ret = eht_build_mcs_mask(info, he_cap, eht_cap,
+					 mask->control[i].eht_mcs);
+		if (ret)
+			return ret;
+
+		mask->control[i].eht_gi = 0xFF;
+		mask->control[i].eht_ltf = 0xFF;
+
 	}
 
 	/* if no rates are given set it back to the defaults */
@@ -5512,13 +5702,27 @@ static int nl80211_parse_tx_bitrate_mask(struct genl_info *info,
 			mask->control[band].he_ltf =
 				nla_get_u8(tb[NL80211_TXRATE_HE_LTF]);
 
+		if (tb[NL80211_TXRATE_EHT] &&
+		    !eht_set_mcs_mask(info, wdev, sband,
+				      nla_data(tb[NL80211_TXRATE_EHT]),
+				      mask->control[band].eht_mcs))
+			return -EINVAL;
+
+		if (tb[NL80211_TXRATE_EHT_GI])
+			mask->control[band].eht_gi =
+				nla_get_u8(tb[NL80211_TXRATE_EHT_GI]);
+		if (tb[NL80211_TXRATE_EHT_LTF])
+			mask->control[band].eht_ltf =
+				nla_get_u8(tb[NL80211_TXRATE_EHT_LTF]);
+
 		if (mask->control[band].legacy == 0) {
-			/* don't allow empty legacy rates if HT, VHT or HE
+			/* don't allow empty legacy rates if HT, VHT, HE or EHT
 			 * are not even supported.
 			 */
 			if (!(rdev->wiphy.bands[band]->ht_cap.ht_supported ||
 			      rdev->wiphy.bands[band]->vht_cap.vht_supported ||
-			      ieee80211_get_he_iftype_cap(sband, wdev->iftype)))
+			      ieee80211_get_he_iftype_cap(sband, wdev->iftype) ||
+			      ieee80211_get_eht_iftype_cap(sband, wdev->iftype)))
 				return -EINVAL;
 
 			for (i = 0; i < IEEE80211_HT_MCS_MASK_LEN; i++)
@@ -5533,6 +5737,10 @@ static int nl80211_parse_tx_bitrate_mask(struct genl_info *info,
 				if (mask->control[band].he_mcs[i])
 					goto out;
 
+			for (i = 0; i < NL80211_EHT_NSS_MAX; i++)
+				if (mask->control[band].eht_mcs[i])
+					goto out;
+
 			/* legacy and mcs rates may not be both empty */
 			return -EINVAL;
 		}

base-commit: d9104cec3e8fe4b458b74709853231385779001f
-- 
2.34.1


