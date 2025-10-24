Return-Path: <linux-wireless+bounces-28209-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 33854C03F29
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Oct 2025 02:20:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6DDC4356C25
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Oct 2025 00:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A91F17332C;
	Fri, 24 Oct 2025 00:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NbEtV5Oc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5BC78F3E
	for <linux-wireless@vger.kernel.org>; Fri, 24 Oct 2025 00:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761265182; cv=none; b=KnMJzO4nOwCSAi6cM8hWsg+q9WkSLGbqkePJaGd2xaT4i9COI6v8NPCGOGdvBDuvsdpwVDhO2fH17qr+TwmKU3ngvkSmNsF639GkMpBixpGeWCdN+xCl8bGNnWGXTjcv1InzTphy1c3ec7Ua6hrOtAdU4Dlh8G1UKibKPFYtIlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761265182; c=relaxed/simple;
	bh=HqwMD6KsSS3qWuRo5OjX6e/TbLsat7xA3gKOVECMXfs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AnC8B4xt07z+NqBqDr9eXzOvggUYVpvMJkHprrp/C68FwQZk4swgb6+uZDLeAnat4+28Mr3ScEuuO/K22jJ5oohmN8YaouObWkhZSxIQb4MU+BDwP2xzi66UIbNkUuwtQSA+nd11slfIyo6H1ZppJPKKZoONOwxKI/zdwIecyqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NbEtV5Oc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59NE3LuD016465
	for <linux-wireless@vger.kernel.org>; Fri, 24 Oct 2025 00:19:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=Ae7UoLdgspS
	b6jjEVxk41LPKz4Rzp1dN1ifdoLtkxkM=; b=NbEtV5OcJ921klYrr7Ly4xINMk6
	7QKtJmMRiyvZ6DAuk/uov3fCaQy1UemwrcjhILqeLcleoIEckdNd348EfkxzGmma
	qGVR5ev+3n2ythMzITraZ3jX5dq2Ql/GoDmEXslrhYKU3/5Nzx9lt229Zp3nc+jY
	47+zwPk8g1XuYz2v6jsSwDagFiIHeNhEolIeYH0Ps7+/Qj7qYm8PcrKON/qJy2rU
	FcRyLh1+io1ls52Pwe3x8ufedail00ZCo4nrciovtZI6AeZE48rHLTq/QvvHoQwI
	EL1cn0pFPsxZcnPntHhOpj+Gij2UPDQNSpyjB6IqlFWrh3/xEJnMadANXow==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49xkpsfvww-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 24 Oct 2025 00:19:39 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-336b9f3b5b0so1426072a91.3
        for <linux-wireless@vger.kernel.org>; Thu, 23 Oct 2025 17:19:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761265178; x=1761869978;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ae7UoLdgspSb6jjEVxk41LPKz4Rzp1dN1ifdoLtkxkM=;
        b=lpg7OWuBxWG9PlOGoAsOc2xVJl/NysnsEZrHB40x/MJFM2B36Ums+0Qoo17ccUIGQn
         3Q53nulRdOecVQQco51/JRxQIQArU3q8ytZFX95kh1+kf8FbD3jEghsvyrU7v82azEER
         uOUevE7QfXtSGLX5ePQjIA3F1cxuG8soGnvRj+uFBFMHG3Z+s6MRdA1K20xlEWqPk3yT
         8AwPM82p5Fzce79xzMyb2v/1k0/2BdJXH1McNpyZWlDBr7NyNyxD20ezrRudeoE/FsP5
         +PhNqOpuFFfobqRqQDWBXxZKMwvUQiMLJYpIPtrGVg7ocfRkOXDUQzN2+FH8YlAIgIlh
         q5aA==
X-Gm-Message-State: AOJu0YxtE+dL9JDKHEj2IgoJkpuZqN2lNHEWXEUpEh/CpFoghLyB0zTg
	FpX3OplTu3yMwayA0KisFJrs/hQQ6r/zGDTXs4wae3auBqWGqeavnw+XtJdOp+XgqEEuug/K0/j
	0QTJyxyFPJ2duoc/iG+f0xFNLbuhHtdcDTW1vdORipuS1OA7JJyqVIbBWrgewAo/J639tBjHxv/
	cQVA==
X-Gm-Gg: ASbGncvTlkoDJ5lGYCvvPmWw1GDPRIueeUphkKpa4w7Wl8adR/ErLektOGE02bAMJWF
	1qpahjFPsi54cVPmSaNVQ724y+jKlXMmDMhIswA5qF4ERzpu+MXM0+Yc3xAGhI1ZWRDDKWRpBWk
	kGqJX6/48m7y2zwov55P0lklbUreP8ORK6tA9pEahXShQsUy9PaaKxM2WnvWxkwOlcXxDaWavpK
	79CpRIIGUo1KroZ74Q8/TcD3xm+6v/cTxrbFdxN2kEGBw5+6HAyMiGBjzfQlTth0W0VHeXXPLsE
	sb7JKPpT9QSum2tV8bXnodCoi0owAQhTWmqCL5wcJyBk2UEDneWedm53n9KqkhNffrE/u9zhFZZ
	xOqJd12fIiSdfxAqEOS31PsyiYJTciMat6G6k0UkncVlL0DnsG8euYNE=
X-Received: by 2002:a17:90b:4f90:b0:32e:859:c79 with SMTP id 98e67ed59e1d1-33fd6430575mr418905a91.0.1761265178364;
        Thu, 23 Oct 2025 17:19:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENojITSb/gTAVTdxVDHRr1KdYYHla0xYunQvL5BL0qxlyD0HPm8esrXbGv70OU4ddp9nWcTw==
X-Received: by 2002:a17:90b:4f90:b0:32e:859:c79 with SMTP id 98e67ed59e1d1-33fd6430575mr418881a91.0.1761265177854;
        Thu, 23 Oct 2025 17:19:37 -0700 (PDT)
Received: from msinada-linux.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6cf4bb65b3sm3296264a12.8.2025.10.23.17.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 17:19:37 -0700 (PDT)
From: Muna Sinada <muna.sinada@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, Muna Sinada <muna.sinada@oss.qualcomm.com>
Subject: [PATCH ath-next 4/6] wifi: ath12k: Add EHT fixed GI/LTF
Date: Thu, 23 Oct 2025 17:19:26 -0700
Message-Id: <20251024001928.257356-5-muna.sinada@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIxMDE5MCBTYWx0ZWRfX65TO0ZmzhCJP
 gSk1J/Yv9mfOely+I7xre/ONsljHpWz+2/YRA+nra+STke2itGakls6gtAA3Uo2o3GxSL8vhrkT
 xQJ+dN7ja3a4kuxKsZsFXpnLv9Sm29Fmht4ou4rMkuMxH5NI/4+VKrkIvqGLuDYRP6pi76Lm7g6
 of7ANxw3vGoYPb5kPaKlVB8tTqBDqwocJQKtEGwolpLaPVT6XSvdaaVQfdCGLAwmhhjVGPqaWcp
 0t47PlfeC+6jbnvakUg0Z1gA0vT//aOVHclwSl0Bgj6U9IOMN8xAwiIl0qppSza8jeLR+DNcD3H
 +9UFMzNGkxBFx/pgDnxAORkSs97cjhvNn9ok+IAKiRU0GaYki4bOFgj/D/1dBie4ed9bzpCpG7f
 weXVh0tBt4bqXZ48hWlZLMBh7i3Adg==
X-Authority-Analysis: v=2.4 cv=FbM6BZ+6 c=1 sm=1 tr=0 ts=68fac61b cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=hBW4dpCEVM4ugrTErwAA:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: PxS5PUP9b6tKKRsk15FUtPkAtdHveSaR
X-Proofpoint-ORIG-GUID: PxS5PUP9b6tKKRsk15FUtPkAtdHveSaR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-23_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 spamscore=0 impostorscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510210190

Add EHT functionality to set fixed GI/LTF parameters.
Add new wmi vdev parameter id for EHT LTF

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Signed-off-by: Muna Sinada <muna.sinada@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 50 +++++++++++++++++++++------
 drivers/net/wireless/ath/ath12k/wmi.h |  1 +
 2 files changed, 41 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index eff1ec1eb4e0..732ddd78635d 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -12254,10 +12254,11 @@ ath12k_mac_get_single_legacy_rate(struct ath12k *ar,
 }
 
 static int
-ath12k_mac_set_fixed_rate_gi_ltf(struct ath12k_link_vif *arvif, u8 gi, u8 ltf)
+ath12k_mac_set_fixed_rate_gi_ltf(struct ath12k_link_vif *arvif, u8 gi, u8 ltf,
+				 u32 param)
 {
 	struct ath12k *ar = arvif->ar;
-	int param, ret;
+	int ret;
 
 	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
 
@@ -12272,11 +12273,16 @@ ath12k_mac_set_fixed_rate_gi_ltf(struct ath12k_link_vif *arvif, u8 gi, u8 ltf)
 			    gi, ret);
 		return ret;
 	}
-	/* start from 1 */
-	if (ltf != 0xFF)
-		ltf += 1;
 
-	param = WMI_VDEV_PARAM_HE_LTF;
+	if (param == WMI_VDEV_PARAM_HE_LTF) {
+		/* HE values start from 1 */
+		if (ltf != 0xFF)
+			ltf += 1;
+	} else {
+		/* EHT values start from 5 */
+		if (ltf != 0xFF)
+			ltf += 4;
+	}
 
 	ret = ath12k_wmi_vdev_set_param_cmd(ar, arvif->vdev_id,
 					    param, ltf);
@@ -12359,6 +12365,7 @@ static u32 ath12k_mac_nlgi_to_wmigi(enum nl80211_txrate_gi gi)
 static int ath12k_mac_set_rate_params(struct ath12k_link_vif *arvif,
 				      u32 rate, u8 nss, u8 sgi, u8 ldpc,
 				      u8 he_gi, u8 he_ltf, bool he_fixed_rate,
+				      u8 eht_gi, u8 eht_ltf,
 				      bool eht_fixed_rate)
 {
 	struct ieee80211_bss_conf *link_conf;
@@ -12385,8 +12392,9 @@ static int ath12k_mac_set_rate_params(struct ath12k_link_vif *arvif,
 		   "he_gi 0x%02x he_ltf 0x%02x he_fixed_rate %d\n", he_gi,
 		   he_ltf, he_fixed_rate);
 
-	ath12k_dbg(ar->ab, ATH12K_DBG_MAC, "eht_fixed_rate %d\n",
-		   eht_fixed_rate);
+	ath12k_dbg(ar->ab, ATH12K_DBG_MAC,
+		   "eht_gi 0x%02x eht_ltf 0x%02x eht_fixed_rate %d\n",
+		   eht_gi, eht_ltf, eht_fixed_rate);
 
 	if (!he_support && !eht_support) {
 		vdev_param = WMI_VDEV_PARAM_FIXED_RATE;
@@ -12417,9 +12425,26 @@ static int ath12k_mac_set_rate_params(struct ath12k_link_vif *arvif,
 		return ret;
 	}
 
+	if (eht_support) {
+		if (eht_fixed_rate)
+			ret = ath12k_mac_set_fixed_rate_gi_ltf(arvif, eht_gi, eht_ltf,
+							       WMI_VDEV_PARAM_EHT_LTF);
+		else
+			ret = ath12k_mac_set_auto_rate_gi_ltf(arvif, eht_gi, eht_ltf);
+
+		if (ret) {
+			ath12k_warn(ar->ab,
+				    "failed to set EHT LTF/GI params %d/%d: %d\n",
+				    eht_gi, eht_ltf, ret);
+			return ret;
+		}
+		gi_ltf_set = true;
+	}
+
 	if (he_support) {
 		if (he_fixed_rate)
-			ret = ath12k_mac_set_fixed_rate_gi_ltf(arvif, he_gi, he_ltf);
+			ret = ath12k_mac_set_fixed_rate_gi_ltf(arvif, he_gi, he_ltf,
+							       WMI_VDEV_PARAM_HE_LTF);
 		else
 			ret = ath12k_mac_set_auto_rate_gi_ltf(arvif, he_gi, he_ltf);
 		if (ret)
@@ -12621,6 +12646,7 @@ ath12k_mac_op_set_bitrate_mask(struct ieee80211_hw *hw,
 	const u16 *he_mcs_mask;
 	u8 he_ltf = 0;
 	u8 he_gi = 0;
+	u8 eht_ltf = 0, eht_gi = 0;
 	u32 rate;
 	u8 nss, mac_nss;
 	u8 sgi;
@@ -12656,6 +12682,9 @@ ath12k_mac_op_set_bitrate_mask(struct ieee80211_hw *hw,
 	he_gi = mask->control[band].he_gi;
 	he_ltf = mask->control[band].he_ltf;
 
+	eht_gi = mask->control[band].eht_gi;
+	eht_ltf = mask->control[band].eht_ltf;
+
 	/* mac80211 doesn't support sending a fixed HT/VHT MCS alone, rather it
 	 * requires passing at least one of used basic rates along with them.
 	 * Fixed rate setting across different preambles(legacy, HT, VHT) is
@@ -12754,7 +12783,8 @@ ath12k_mac_op_set_bitrate_mask(struct ieee80211_hw *hw,
 	}
 
 	ret = ath12k_mac_set_rate_params(arvif, rate, nss, sgi, ldpc, he_gi,
-					 he_ltf, he_fixed_rate, eht_fixed_rate);
+					 he_ltf, he_fixed_rate, eht_gi, eht_ltf,
+					 eht_fixed_rate);
 	if (ret) {
 		ath12k_warn(ar->ab, "failed to set rate params on vdev %i: %d\n",
 			    arvif->vdev_id, ret);
diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
index 01b2a865f103..3334fe32d412 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -1197,6 +1197,7 @@ enum wmi_tlv_vdev_param {
 	WMI_VDEV_PARAM_SET_HEMU_MODE,
 	WMI_VDEV_PARAM_HEOPS_0_31 = 0x8003,
 	WMI_VDEV_PARAM_SET_EHT_MU_MODE = 0x8005,
+	WMI_VDEV_PARAM_EHT_LTF,
 };
 
 enum wmi_tlv_peer_flags {
-- 
2.34.1


