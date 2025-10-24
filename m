Return-Path: <linux-wireless+bounces-28210-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0537EC03F34
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Oct 2025 02:20:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0967A4F24E1
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Oct 2025 00:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D3D318FDAF;
	Fri, 24 Oct 2025 00:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FfvqXOB2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAFD513957E
	for <linux-wireless@vger.kernel.org>; Fri, 24 Oct 2025 00:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761265182; cv=none; b=H1bYxG4YEb6IJ3cZrlRvKOdlNqgVNj7qu7QYP0ESmYGGSb3EAcbX3Z5Iz37tXIm9BoOzyEujBcrWwPjvMOmX5zP1qtRu7vNCzRATnWCTvKfz+j1ioGkYCC5BHl9B9hSnqMUOfhBBCk1Ai2Zw71Do6ht2f1Qq0nOF6t/jEeJk0AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761265182; c=relaxed/simple;
	bh=9O2b2dtLe5hV9wwTumoZ99pKuSZt/bAVlC7Cuee4O0A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mBO7dxYeCanIsqfJlT76f8+QFl3CTSJZ86LG3hOw+0ujS0uvEO2qJo6QGIwZgUeHMBhKgwGrKQJVTXYytaAFaqUff6mBzobL9glh7WIZWhpYG3qvVG8agkBYc0S5o+QkWlhX6+OGaLvA/Z41TZ88IIzDbvH2dnW2/2O1aq7QyBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FfvqXOB2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59NF1O4D011813
	for <linux-wireless@vger.kernel.org>; Fri, 24 Oct 2025 00:19:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=d3yytTsCASa
	UNGDTYRZwoAUPXrxIYAiEFcB06UyRsUc=; b=FfvqXOB2sdLh3e9gsc/iFRqJokJ
	689ADtJGonjhIYqhDLP+J540KMT2h2pIg/aik1iDbBq6tGjVzPzd34weoH6KRxMw
	uZDeBiCEOa+sRK+BJv8U0NhktzYdNPkt43up7lZnKJkN27IoWPskhLqMBPYhmbO/
	U29Q0ovz665Mjw3DuZenTKLLkd2mjXnNIRCPWH7d9be561OYSfIr4Ik+4/hieg1Y
	/PCAJjl5xlW+PgUn7mBaW8BgVl0OEQ7F+zKUXJ1BdPpDf7pfRDNmqs+FuyTwDr+M
	RVyn9MbBYP2o15379/wE3hC7HKFAPB2sLGKi3CfVGwend6JE4FzPGRFCaqg==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49y524cg6d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 24 Oct 2025 00:19:40 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-781253de15aso2946432b3a.2
        for <linux-wireless@vger.kernel.org>; Thu, 23 Oct 2025 17:19:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761265179; x=1761869979;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d3yytTsCASaUNGDTYRZwoAUPXrxIYAiEFcB06UyRsUc=;
        b=auJOsD2OTgmjfSyWtGXWFf1t2n6RLrIqWlPM58vdddgJQiYDwywtc9XMGIkRQMM8R/
         3fvg9WDhn4xmLOTspb2To1OORw91XvaGfiMocSk35P1cUJbWx+r2K8XmW6ZMeOPKbnnd
         jkVgX6uW+RRShKIpvRuXjyTHemxLDISfRfQ8SXE1C2Fd3YC8gdhKtJC3saABBNbHDfLb
         kUchuY1vY5hf94QLq9SINCldgxiyzM4kCqJh8BIAPhFl6k9XaCQbE8/7TwjpCwjvv1BC
         KDNyvwbKlqw2f9DSPNiJzidfdemLMR4Ir6UNakwJ/hqVluW9YIzv6iqeX3Piib5ln7oo
         vN0g==
X-Gm-Message-State: AOJu0YxifnlkmfsancsfFpK7bIup8/Mf+4Kl7yTQ0t3yR4LxaXL6DiUB
	RimWTa30zO5U1fhZ+zsG1t9eTkp4fs/ZVr2k8CWPe2arhVolH8MmuAzajWqQT5O3kUakdvTvr6/
	GLK8If8I/LH+5V1mAD2eXJIPlKQl5K+Zc3AKlMyb5Gs95P6pFyzvXKnMJ4zf6ne8/VkZlSw==
X-Gm-Gg: ASbGncvFyxqaauWv5wAm7CpI4zGuZtCbKu09qQzDes9yYB4yIL620qWwnAiqZ1rnnpc
	qBjjrSO7NLoSDBL5DXGt2e2CHDS+52kLQRhEsBD49rZ2zDRXmFey/7/hbb6izwLe0EheHpeR/wx
	BN8lIuhXZioj2nxxDWq3ZrBHa967pWrBKSiZ+WoCgGnvEqu2aDKlUyHBgqEBsNt5QRhy/nIjmYC
	wQizXJ0r4tc2c2zMJJgznJ8Qcs4/PpSOmEjwZLFsKZGuw3qm/m+RA3QFXcQ2r/AD/HagvhCpe1i
	U7A2nzD2mZ89NyuTm/qYB5vrZDsIP5aTnHUrB99pYUVsU+wnluyqZU0mPc/9ENSx6Fd/Z1BVfMi
	HHKE25PiCiij2ZwxQAcaK9Xs1KaqgJ6ms8QOeyDk6Vkob7BDJbPLbB5c=
X-Received: by 2002:a05:6a21:3994:b0:334:a8b8:3ce5 with SMTP id adf61e73a8af0-334a8b83ee1mr36442958637.28.1761265179199;
        Thu, 23 Oct 2025 17:19:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFGajz+6YoP2IqypLTEqv4/WvOOEj6rRfLIMcsUx82zfQ0WcQgjK8+EIgcjyJ6Nv9rTd2qtGQ==
X-Received: by 2002:a05:6a21:3994:b0:334:a8b8:3ce5 with SMTP id adf61e73a8af0-334a8b83ee1mr36442935637.28.1761265178778;
        Thu, 23 Oct 2025 17:19:38 -0700 (PDT)
Received: from msinada-linux.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6cf4bb65b3sm3296264a12.8.2025.10.23.17.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 17:19:38 -0700 (PDT)
From: Muna Sinada <muna.sinada@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, Muna Sinada <muna.sinada@oss.qualcomm.com>,
        Aaradhana Sahu <quic_aarasahu@quicinc.com>
Subject: [PATCH ath-next 5/6] wifi: ath12k: add EHT rates to ath12k_mac_op_set_bitrate_mask()
Date: Thu, 23 Oct 2025 17:19:27 -0700
Message-Id: <20251024001928.257356-6-muna.sinada@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIyMDE1NSBTYWx0ZWRfXzK7RkyOsvv6e
 oW6iOKBGqFKsJ+ymZvWNfbsCJtFVWbnyPjprEeqx1wEsnbmAJpOJ3DuRxOw9LqQJT1+HUUwyfYW
 03oDN1Mkv87Bcde+AyqpiMzu4OCq2Lgdb1EnVNv0RxB160WHuX51mj5iHX55f7Lmgt0lo/HR7k9
 SqV+MsDbVseZcWUUBgK07K32AqRFTJz2IyWyzGZoXHpbycTobVp/HR5FPPihqO54eb9JN1caK93
 GHkfeWDZMaqxcfK488rp2vskMrsQO2RZrd9IQgOM4XEPWGIEOh5Ez8Bh7LVCLjCMKKnjn6PxDRL
 i/uPj4Mq9qfeqRzTQ3A61dw4p9M8FYzwpo84bQXPLARUzJXAPs08JhgBx7gNEvyzxpSkViJ+vzD
 k915btnryiCXdifE03/In1ksPOIuTg==
X-Authority-Analysis: v=2.4 cv=Uotu9uwB c=1 sm=1 tr=0 ts=68fac61c cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=Xnj9w1_vVb6zP76ol7IA:9 a=zc0IvFSfCIW2DFIPzwfm:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: otgasBubcaxZ8WMLWA8R0b2uHmPGQsae
X-Proofpoint-ORIG-GUID: otgasBubcaxZ8WMLWA8R0b2uHmPGQsae
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-23_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 adultscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510220155

Extend ath12k_mac_op_set_bitrate_mask() to handle EHT rates.
Create and pass EHT mask containing MCS and NSS along with EHT GI and
LTF when calling ath12k_mac_set_rate_params()

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Co-developed-by: Aaradhana Sahu <quic_aarasahu@quicinc.com>
Signed-off-by: Aaradhana Sahu <quic_aarasahu@quicinc.com>
Signed-off-by: Muna Sinada <muna.sinada@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 55 +++++++++++++++++++++++++--
 1 file changed, 52 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 732ddd78635d..31b0e641ce55 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -12517,6 +12517,38 @@ ath12k_mac_he_mcs_range_present(struct ath12k *ar,
 	return true;
 }
 
+static bool
+ath12k_mac_eht_mcs_range_present(struct ath12k *ar,
+				 enum nl80211_band band,
+				 const struct cfg80211_bitrate_mask *mask)
+{
+	u16 eht_mcs;
+	int i;
+
+	for (i = 0; i < NL80211_EHT_NSS_MAX; i++) {
+		eht_mcs = mask->control[band].eht_mcs[i];
+
+		switch (eht_mcs) {
+		case 0:
+		case BIT(8) - 1:
+		case BIT(10) - 1:
+		case BIT(12) - 1:
+		case BIT(14) - 1:
+			break;
+		case BIT(15) - 1:
+		case BIT(16) - 1:
+		case BIT(16) - BIT(14) - 1:
+			if (i != 0)
+				return false;
+			break;
+		default:
+			return false;
+		}
+	}
+
+	return true;
+}
+
 static void ath12k_mac_set_bitrate_mask_iter(void *data,
 					     struct ieee80211_sta *sta)
 {
@@ -12644,6 +12676,7 @@ ath12k_mac_op_set_bitrate_mask(struct ieee80211_hw *hw,
 	const u8 *ht_mcs_mask;
 	const u16 *vht_mcs_mask;
 	const u16 *he_mcs_mask;
+	const u16 *eht_mcs_mask;
 	u8 he_ltf = 0;
 	u8 he_gi = 0;
 	u8 eht_ltf = 0, eht_gi = 0;
@@ -12671,6 +12704,7 @@ ath12k_mac_op_set_bitrate_mask(struct ieee80211_hw *hw,
 	ht_mcs_mask = mask->control[band].ht_mcs;
 	vht_mcs_mask = mask->control[band].vht_mcs;
 	he_mcs_mask = mask->control[band].he_mcs;
+	eht_mcs_mask = mask->control[band].eht_mcs;
 	ldpc = !!(ar->ht_cap_info & WMI_HT_CAP_LDPC);
 
 	sgi = mask->control[band].gi;
@@ -12722,9 +12756,10 @@ ath12k_mac_op_set_bitrate_mask(struct ieee80211_hw *hw,
 			ath12k_warn(ar->ab,
 				    "failed to update fixed rate settings due to mcs/nss incompatibility\n");
 
-		mac_nss = max3(ath12k_mac_max_ht_nss(ht_mcs_mask),
-			       ath12k_mac_max_vht_nss(vht_mcs_mask),
-			       ath12k_mac_max_he_nss(he_mcs_mask));
+		mac_nss = max(max3(ath12k_mac_max_ht_nss(ht_mcs_mask),
+				   ath12k_mac_max_vht_nss(vht_mcs_mask),
+				   ath12k_mac_max_he_nss(he_mcs_mask)),
+			       ath12k_mac_max_eht_nss(eht_mcs_mask));
 		nss = min_t(u32, ar->num_tx_chains, mac_nss);
 
 		/* If multiple rates across different preambles are given
@@ -12772,6 +12807,20 @@ ath12k_mac_op_set_bitrate_mask(struct ieee80211_hw *hw,
 			ret = -EINVAL;
 			goto out;
 		}
+
+		num_rates = ath12k_mac_bitrate_mask_num_eht_rates(ar, band,
+								  mask);
+		if (num_rates == 1)
+			eht_fixed_rate = true;
+
+		if (!ath12k_mac_eht_mcs_range_present(ar, band, mask) &&
+		    num_rates > 1) {
+			ath12k_warn(ar->ab,
+				    "Setting more than one EHT MCS Value in bitrate mask not supported\n");
+			ret = -EINVAL;
+			goto out;
+		}
+
 		ieee80211_iterate_stations_mtx(hw,
 					       ath12k_mac_disable_peer_fixed_rate,
 					       arvif);
-- 
2.34.1


