Return-Path: <linux-wireless+bounces-26405-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40354B287B6
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Aug 2025 23:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E36BDAE846D
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Aug 2025 21:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D108CB665;
	Fri, 15 Aug 2025 21:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jcDA7y/t"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC8527713
	for <linux-wireless@vger.kernel.org>; Fri, 15 Aug 2025 21:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755293424; cv=none; b=Rt1xlnThqXD/ffGRKmqKcUUQTh/bSsc0MZNDiqTcCm/k9p4u0ApNT0tohqO91TEs3qJWIXDMWk9j1OKsapxkFPnVjv9DbDxeJrZ/+qJ+uvowYTU8V86ruGexmPFBJ6X2Gaarh8/ONJVvtUPqZ7VO//5GdG82a8FdF7Qf/zF5uLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755293424; c=relaxed/simple;
	bh=DrxjSjJfQoJ1isVaF2cPLMUEjSOMWvSrjbq9T9Rh3ZU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YnMsawj5HIpNWR1LSrvOwJ6zh0K7SuJX0qqfatYpTsjdgc365aiC6Irp+YV1Hs8s5/k3ghu9khnbMHWCW1ccCo1L6IWOk88tUp/yStDreYlImY0WYVP67FUt65iitUycQubCPTZVjmRZN/ZY55qHJZrszSqFWQJmgvElbCpL+UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jcDA7y/t; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57FJKmwB014962
	for <linux-wireless@vger.kernel.org>; Fri, 15 Aug 2025 21:30:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=jlNhRjcA6G3gUz7SrPAykcZK2ncntR50pn8
	WgjDJUzg=; b=jcDA7y/tbEbjbt9L0owiIrV9wDCKmwFEDPlbVewoW6hodCafod5
	UoXZ+0Ijj/YLXu4iJ9avUpnaepdERMjXLLpVYmTNCTKrAMOT8af5B4gIMs1V4pCr
	qJFiZJU9wpccunmCEt/kZe7OL1Df0fnpO0pZMqRV/Lg1wrz84R7GwuRLIuMP0z/s
	wb9skDAr9ByovtZeq2d5WLeT5cG717UvBAF9A4OBzKXxogrG5q5x9q81fo7qR778
	2yoIr6gwqBotaUIXmORGDL95lYnkaKovE4TQv8l7G6/Efp47+F0euXF9DMbwb/2Z
	KJFJcybthxa4OJLAwFaf9nri7IBDHYuv5kA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48g5hmm6n7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 15 Aug 2025 21:30:21 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-24458264c5aso22734275ad.3
        for <linux-wireless@vger.kernel.org>; Fri, 15 Aug 2025 14:30:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755293420; x=1755898220;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jlNhRjcA6G3gUz7SrPAykcZK2ncntR50pn8WgjDJUzg=;
        b=cahT9LCnBrXAcTF7L+TGLUWTPC5+96wtK22KCWCR7WCFYVifk0iqjDnWg0Dhg4uUUS
         CgIhAJq3TQnk6ZMAgFm4ntAsmwtt4hFF6cAAJKAFIQugkWvnZ0itjd3eTIy8oGzOrz5u
         gfNpaDdjHdI1kDi21sl5gfVR6TM6Psvn1QdftuWAqKxxIOvdTUX9YXJMgNPCNo0YxzIK
         vFv0x8t1mPRwYcSoSWsLmNU9p+f5vqVphiQNG1M0eS2UjTuhUflxb10A9fjm48oUtZte
         SNqPtYzzvr51SJ5hbFZ9V6FcDZXDr2sGNJGVx9a7gHXwIhaWzOdxrvvEQiZUpKo+Bj4n
         YPgQ==
X-Gm-Message-State: AOJu0YwjpY0m6RClkPcfs3xs3AoCqXquFt4M1HvZxX+c5/Ay1YXKW+2l
	HbNnZeLpfkgn8B3YiScb0O4/RrgKyN7y1E8zzu4UrSId/gOvFD/yuZtW2iyTb1TgG/iGKaosVeZ
	+1njqYKUNOnPZ8CzDJaZiuL9/sXYEA1W0vb527UVUDeChp8J7V9Zbnn/y/pb51WjxTIZ1dQ==
X-Gm-Gg: ASbGncsquKuC7IfbrFDX0cyImeSKhJphEecA1CUK6DmAxgR4kf0gZbZmRHpZMzVhNtP
	Uj3+8R5cpMhXKB0TUmzXY4bvktea78XOvmfDK3raDanjQ34eLlM2unk37eJalkVPxnJBM0lRSmG
	mp/3OW3w3t+b2MC/uHm7kbwHQIrZc50hDdvZ5Z5QuM190iT4xZ99RPQVjXZbQFZb5IcmlegZY5U
	IyZhzge8veeHDFZ1fSRXBOTYkjHPDfMpj2odemacMDlXWrQ1xJzLnafLS68fBOfY7DiNsqmp4fb
	UWbB0iEb1WRR9eBmpyGQpjWOFWLpQfstEYhwX5H+5kRnZVZooa4lP72qfC4ni7nXmC9lIh49SlG
	sSUnLLewHjsuc01W+ZD1d
X-Received: by 2002:a17:902:d488:b0:234:a139:11fb with SMTP id d9443c01a7336-2446d8b1f78mr47492465ad.27.1755293419854;
        Fri, 15 Aug 2025 14:30:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE6MWeFMxxnZMreEI4LoNe0bDHWpPN4X1kS8KyACPY173PhXCYN6QoB3A/vo1x8P8PZF4xBLQ==
X-Received: by 2002:a17:902:d488:b0:234:a139:11fb with SMTP id d9443c01a7336-2446d8b1f78mr47492145ad.27.1755293419314;
        Fri, 15 Aug 2025 14:30:19 -0700 (PDT)
Received: from msinada-linux.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446ca9d05csm21333705ad.30.2025.08.15.14.30.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 14:30:18 -0700 (PDT)
From: Muna Sinada <muna.sinada@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, Muna Sinada <muna.sinada@oss.qualcomm.com>,
        Aloka Dixit <aloka.dixit@oss.qualcomm.com>
Subject: [PATCH wireless-next v2] wifi: nl80211: Add EHT fixed Tx rate support
Date: Fri, 15 Aug 2025 14:30:11 -0700
Message-Id: <20250815213011.2704803-1-muna.sinada@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDExOSBTYWx0ZWRfXxIYM4uBVkuSP
 tIilCE540MaYSjHzkTevn+v9daxifNqSWBu1wyN9YLMxH8fhbx1Vu++iPK5U1EmAftnp0iaH8Fi
 Y0sEso94/l3/Zlvx0CppkwDs/s8qDTzUa+ec+VCNb9dVuiNDKNxSlXtZFKveheqH9d09/1dAChR
 2qCbZ0GWdOYAGUnVBGEtFvCHMXvHnkvmOOdvawD04FIRWAn0glm2KnycaDTlWNlWfsuHgvUSAsr
 xt5I1a2VAzpHj7J4ew/RQyn566nVfSSDYfwYdmwBiHfWNOslT+gmYzjSiFwgq8EHPN/oiyJj4Cw
 +UZ5iPisdSJoPAcbv9De/1U9Zl4gVFvZ+lCv9V1E24O+o5fhM6VePuLt1lXmsABd9r0bHc3T0zY
 u+OXgFxE
X-Proofpoint-GUID: RncZXwsJSyQkKMessPTFzvaNcIrT3ugr
X-Proofpoint-ORIG-GUID: RncZXwsJSyQkKMessPTFzvaNcIrT3ugr
X-Authority-Analysis: v=2.4 cv=d4b1yQjE c=1 sm=1 tr=0 ts=689fa6ed cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=0_fGfNMFXauCpGQD5kIA:9
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-15_07,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 spamscore=0 phishscore=0 adultscore=0
 bulkscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508120119

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
v2:
- Added necessary EHT additions to validate_beacon_tx_rate()
- Added new Enum for EHT beacon rate:
  NL80211_EXT_FEATURE_BEACON_RATE_EHT
- Removed MCS 15 checks as that is only for MRUs
- Moved setting MCS 14 and 15 outside of NSS loop since it is only
  applicable for NSS 0
- Moved checks out of eht_build_mcs_mask() in order to have no
  possible errors for this function.

---
 include/net/cfg80211.h       |   3 +
 include/uapi/linux/nl80211.h |  41 ++++++-
 net/wireless/nl80211.c       | 229 ++++++++++++++++++++++++++++++++++-
 3 files changed, 266 insertions(+), 7 deletions(-)

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
index d1a14f2892d9..455d5fad44d4 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -1943,8 +1943,9 @@ enum nl80211_commands {
  *	The driver must also specify support for this with the extended
  *	features NL80211_EXT_FEATURE_BEACON_RATE_LEGACY,
  *	NL80211_EXT_FEATURE_BEACON_RATE_HT,
- *	NL80211_EXT_FEATURE_BEACON_RATE_VHT and
- *	NL80211_EXT_FEATURE_BEACON_RATE_HE.
+ *	NL80211_EXT_FEATURE_BEACON_RATE_VHT,
+ *	NL80211_EXT_FEATURE_BEACON_RATE_HE and
+ *	NL80211_EXT_FEATURE_BEACON_RATE_EHT.
  *
  * @NL80211_ATTR_FRAME_MATCH: A binary attribute which typically must contain
  *	at least one byte, currently used with @NL80211_CMD_REGISTER_FRAME.
@@ -3735,6 +3736,22 @@ enum nl80211_eht_gi {
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
@@ -5481,6 +5498,10 @@ enum nl80211_key_attributes {
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
@@ -5493,6 +5514,9 @@ enum nl80211_tx_rate_attributes {
 	NL80211_TXRATE_HE,
 	NL80211_TXRATE_HE_GI,
 	NL80211_TXRATE_HE_LTF,
+	NL80211_TXRATE_EHT,
+	NL80211_TXRATE_EHT_GI,
+	NL80211_TXRATE_EHT_LTF,
 
 	/* keep last */
 	__NL80211_TXRATE_AFTER_LAST,
@@ -5525,6 +5549,15 @@ enum nl80211_txrate_gi {
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
@@ -6649,6 +6682,9 @@ enum nl80211_feature_flags {
  *	(signaling and payload protected) A-MSDUs and this shall be advertised
  *	in the RSNXE.
  *
+ * @NL80211_EXT_FEATURE_BEACON_RATE_EHT: Driver supports beacon rate
+ *	configuration (AP/mesh) with EHT rates.
+ *
  * @NUM_NL80211_EXT_FEATURES: number of extended features.
  * @MAX_NL80211_EXT_FEATURES: highest extended feature index.
  */
@@ -6724,6 +6760,7 @@ enum nl80211_ext_feature_index {
 	NL80211_EXT_FEATURE_OWE_OFFLOAD_AP,
 	NL80211_EXT_FEATURE_DFS_CONCURRENT,
 	NL80211_EXT_FEATURE_SPP_AMSDU_SUPPORT,
+	NL80211_EXT_FEATURE_BEACON_RATE_EHT,
 
 	/* add new features before the definition below */
 	NUM_NL80211_EXT_FEATURES,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 89519aa52893..364d83fb9992 100644
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
@@ -5393,6 +5401,164 @@ static bool he_set_mcs_mask(struct genl_info *info,
 	return true;
 }
 
+static void eht_build_mcs_mask(struct genl_info *info,
+			       const struct ieee80211_sta_eht_cap *eht_cap,
+			       u8 mcs_nss_len, u16 *mcs_mask)
+{
+	struct net_device *dev = info->user_ptr[1];
+	struct wireless_dev *wdev = dev->ieee80211_ptr;
+	u8 nss, mcs_7 = 0, mcs_9 = 0, mcs_11 = 0, mcs_13 = 0;
+	unsigned int link_id = nl80211_link_id(info->attrs);
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
+		case NL80211_IFTYPE_MESH_POINT:
+			width = wdev->u.mesh.chandef.width;
+			break;
+		case NL80211_IFTYPE_OCB:
+			width = wdev->u.ocb.chandef.width;
+			break;
+		default:
+			if (wdev->valid_links)
+				width = wdev->links[link_id].ap.chandef.width;
+			else
+				width = wdev->u.ap.preset_chandef.width;
+			break;
+		}
+
+		switch (width) {
+		case NL80211_CHAN_WIDTH_320:
+			mcs = &eht_cap->eht_mcs_nss_supp.bw._320;
+			break;
+		case NL80211_CHAN_WIDTH_160:
+			mcs = &eht_cap->eht_mcs_nss_supp.bw._160;
+			break;
+		default:
+			mcs = &eht_cap->eht_mcs_nss_supp.bw._80;
+			break;
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
+	/* Enable MCS 14 for NSS 0 */
+	if (eht_cap->eht_cap_elem.phy_cap_info[6] &
+	    IEEE80211_EHT_PHY_CAP6_EHT_DUP_6GHZ_SUPP)
+		mcs_mask[0] |= 0x4000;
+
+	/* Enable MCS 15 for NSS 0 */
+	mcs_mask[0] |= 0x8000;
+
+	for (nss = 0; nss < NL80211_EHT_NSS_MAX; nss++) {
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
+	u8 i, mcs_nss_len;
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
+	mcs_nss_len = ieee80211_eht_mcs_nss_size(&he_cap->he_cap_elem,
+						 &eht_cap->eht_cap_elem,
+						 wdev->iftype ==
+							NL80211_IFTYPE_STATION);
+
+	if (mcs_nss_len == 3) {
+		/* Supported iftypes for setting non-20 MHZ only EHT MCS */
+		switch (wdev->iftype) {
+		case NL80211_IFTYPE_ADHOC:
+		case NL80211_IFTYPE_AP:
+		case NL80211_IFTYPE_P2P_GO:
+		case NL80211_IFTYPE_MESH_POINT:
+		case NL80211_IFTYPE_OCB:
+			break;
+		default:
+			return false;
+		}
+	}
+
+	/* Build eht_mcs_mask from EHT and HE capabilities */
+	eht_build_mcs_mask(info, eht_cap, mcs_nss_len, tx_mcs_mask);
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
@@ -5413,6 +5579,8 @@ static int nl80211_parse_tx_bitrate_mask(struct genl_info *info,
 	/* Default to all rates enabled */
 	for (i = 0; i < NUM_NL80211_BANDS; i++) {
 		const struct ieee80211_sta_he_cap *he_cap;
+		const struct ieee80211_sta_eht_cap *eht_cap;
+		u8 mcs_nss_len;
 
 		if (!default_all_enabled)
 			break;
@@ -5441,6 +5609,21 @@ static int nl80211_parse_tx_bitrate_mask(struct genl_info *info,
 
 		mask->control[i].he_gi = 0xFF;
 		mask->control[i].he_ltf = 0xFF;
+
+		eht_cap = ieee80211_get_eht_iftype_cap(sband, wdev->iftype);
+		if (!eht_cap)
+			continue;
+
+		mcs_nss_len = ieee80211_eht_mcs_nss_size(&he_cap->he_cap_elem,
+							 &eht_cap->eht_cap_elem,
+							 wdev->iftype ==
+							 NL80211_IFTYPE_STATION);
+
+		eht_build_mcs_mask(info, eht_cap, mcs_nss_len,
+				   mask->control[i].eht_mcs);
+
+		mask->control[i].eht_gi = 0xFF;
+		mask->control[i].eht_ltf = 0xFF;
 	}
 
 	/* if no rates are given set it back to the defaults */
@@ -5512,13 +5695,27 @@ static int nl80211_parse_tx_bitrate_mask(struct genl_info *info,
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
@@ -5533,6 +5730,10 @@ static int nl80211_parse_tx_bitrate_mask(struct genl_info *info,
 				if (mask->control[band].he_mcs[i])
 					goto out;
 
+			for (i = 0; i < NL80211_EHT_NSS_MAX; i++)
+				if (mask->control[band].eht_mcs[i])
+					goto out;
+
 			/* legacy and mcs rates may not be both empty */
 			return -EINVAL;
 		}
@@ -5546,7 +5747,7 @@ static int validate_beacon_tx_rate(struct cfg80211_registered_device *rdev,
 				   enum nl80211_band band,
 				   struct cfg80211_bitrate_mask *beacon_rate)
 {
-	u32 count_ht, count_vht, count_he, i;
+	u32 count_ht, count_vht, count_he, count_eht, i;
 	u32 rate = beacon_rate->control[band].legacy;
 
 	/* Allow only one rate */
@@ -5592,8 +5793,21 @@ static int validate_beacon_tx_rate(struct cfg80211_registered_device *rdev,
 			return -EINVAL;
 	}
 
-	if ((count_ht && count_vht && count_he) ||
-	    (!rate && !count_ht && !count_vht && !count_he))
+	count_eht = 0;
+	for (i = 0; i < NL80211_EHT_NSS_MAX; i++) {
+		if (hweight16(beacon_rate->control[band].eht_mcs[i]) > 1) {
+			return -EINVAL;
+		} else if (beacon_rate->control[band].eht_mcs[i]) {
+			count_eht++;
+			if (count_eht > 1)
+				return -EINVAL;
+		}
+		if (count_eht && rate)
+			return -EINVAL;
+	}
+
+	if ((count_ht && count_vht && count_he && count_eht) ||
+	    (!rate && !count_ht && !count_vht && !count_he && !count_eht))
 		return -EINVAL;
 
 	if (rate &&
@@ -5613,6 +5827,11 @@ static int validate_beacon_tx_rate(struct cfg80211_registered_device *rdev,
 				     NL80211_EXT_FEATURE_BEACON_RATE_HE))
 		return -EINVAL;
 
+	if (count_eht &&
+	    !wiphy_ext_feature_isset(&rdev->wiphy,
+				     NL80211_EXT_FEATURE_BEACON_RATE_EHT))
+		return -EINVAL;
+
 	return 0;
 }
 

base-commit: d9104cec3e8fe4b458b74709853231385779001f
-- 
2.34.1


