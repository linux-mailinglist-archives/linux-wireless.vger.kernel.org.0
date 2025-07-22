Return-Path: <linux-wireless+bounces-25845-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DEB9B0D69F
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 12:02:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B38A5624D6
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 10:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 680272E4254;
	Tue, 22 Jul 2025 09:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ga6MkXEy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2682E3AEA
	for <linux-wireless@vger.kernel.org>; Tue, 22 Jul 2025 09:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753178392; cv=none; b=XApLd2bo0qxCNctdGvmx7reoyP3DAwRkhptPeVDLNBNEWpsZDVPDPwRyNh/B6x8OrRizIYfrq8n8ztBJLau23lbkTWrVYFp14IEUBmJqs5Bx4dGNUS/Hp7PwwJc8rdhqjcfUUwjsmSxpPZtFLcrG7PGKYTkhUhpzC6SZjC3yESo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753178392; c=relaxed/simple;
	bh=u9feYEjOMdIJKaQZrCyNmr4FfePGPx12f0vNXuW7pfI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Chy40YHmQMahE++CuhfYHvgm97acrRkbp8iTtP8Eb4VodzMiHAPfh1xpx66ueySHFbXhGNcy1rokPZ6aiZ6gtwNToMUDxtpYfExoFGs13gPtRjNlcZLPDVGn+UsezggcCWsZT1uBu6ogLaibKNbimF3Ko5w8sfwDTwOlJ2rMTK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ga6MkXEy; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56M83u6J010576
	for <linux-wireless@vger.kernel.org>; Tue, 22 Jul 2025 09:59:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=VgzX3k+2zDL
	XED9O2BnpgtU3ooZETwOsm6yDUHppipU=; b=ga6MkXEyz+z0xuFC+F1nAXEIKwZ
	D3kvxLp+6wJFsGaK7z8GVUQVGTa7Ze6EcHHvKBNEGXgdxQRnsbpfKpB8etcsrN6A
	oQcgjlA7HagrbY/mEfeH9TcX1kMeWniE6jU59RNRKPh/GOpaJmSjhyVkkiTAcxr7
	vAYaP0Y1LM6ttOKPawVy2RYeHWg7ebUj6aqW21Y2Dkr992BPFnGYBFjs9uxu8n7G
	c5b5U7W2Y0znS951QGEvNbbQOFN10WZfD5qySeYrmNwfMUt1bRydOLy751w8g+Nl
	qUY2wB35qmjcJhHyrGoxyzZ67tvAengOpjYp4jN37/uBq8249qG/nRl7opQ==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4826t18c05-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 22 Jul 2025 09:59:49 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-74ea7007866so4994852b3a.2
        for <linux-wireless@vger.kernel.org>; Tue, 22 Jul 2025 02:59:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753178388; x=1753783188;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VgzX3k+2zDLXED9O2BnpgtU3ooZETwOsm6yDUHppipU=;
        b=adLWKlUylap6r8ZPPIGBxu5f8I+bFLeLDhBcoTLc9eccTwWpotMt+kT3e3QGsEY6mc
         x0HExqVi12q/w4SskpWMFJhk9E92d+KLmmLe39aEeqaZpUA8nKfowre7qHru5PoaHrWT
         tRKGMVwExKW2EevYIzYyQFc0iH0l2SOqnEH19KgPWohinW8lmjSAOLsm3+wMdYLKVuSH
         BsMWY1mfqpBeH9VREE7+zdnssqZXiFfaecKeMYYCDZ3v7drVGhWO79+x9buID+ht3kVp
         seRLcYcjJU0iHhNEVhIilTVvirpi8alJaLCNSjGhJspIvKsMbYDQgN+L1wiYVoS5Cc55
         K2AQ==
X-Gm-Message-State: AOJu0YxtWEZyYBqg0aiG+bss/xwfim+N3h2RFM/gE1uc9p0Cm4FsuSu5
	dbuHDDj/o89eYnE/ny8zebNxrUxvQqh7Vu7zCyXCuOWry3KqMGoH+9TjXkPlRY9fjK1bnKOZ6F/
	4elqOIYr7GzsfYnV4r7n7R1SFV2ZsmsXQ0381pmiYAqfjZRFkM2mW3BHri1xVM2tu5/W0lw==
X-Gm-Gg: ASbGncsAMhoEmcNjNiRCYZP3qDTbXwk6Xzh033bQxsfto5MbsliySvrfa0HoqO50nIg
	wSWoi2m/FzQz2E+P4vqCNFNWoBzczEnsB/ca9jQy20EB8TlJcl9zAqkppQTSgKSJYaEMdmXKmC9
	bru0wFEIWXYYtQYn+/xNsJj2iCBaAOJeJMIc/0RFgl5hbe5v5qlkRMIeevh9+fX7kwgVvWyTySB
	yapoUyMihcZXTvYJaegkkTPVpGnX+b9NDRXfXSTXvbnAeilrTH3f7XJpNy6btTsyZ63ZZwotvVD
	NlgnIwiJ82qh/4VCTliRKAmhNT2O4PNtiGB070gqrvQ8FzyLlhoT1pixt6W6UNLg9olBS1a8XcO
	zRLUKJXJBIVyrYmGnAtaYul5ZE/JO+mA/WA6MgADnRCrsRa8A2b3Fmg==
X-Received: by 2002:a05:6a00:3e1a:b0:73f:f623:55f8 with SMTP id d2e1a72fcca58-7572267ae68mr25018150b3a.5.1753178388164;
        Tue, 22 Jul 2025 02:59:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGOL5bsLv/gTYJEiPUeramDIE0f81nOocoZlU4Xhv+jaI0Ua8x6+aULj9I4EdexAzl/8nip2A==
X-Received: by 2002:a05:6a00:3e1a:b0:73f:f623:55f8 with SMTP id d2e1a72fcca58-7572267ae68mr25018118b3a.5.1753178387681;
        Tue, 22 Jul 2025 02:59:47 -0700 (PDT)
Received: from QCOM-kZLYnuwaz1.na.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759c89d6bf2sm6851065b3a.53.2025.07.22.02.59.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 02:59:47 -0700 (PDT)
From: Kang Yang <kang.yang@oss.qualcomm.com>
To: ath12k@lists.infradead.org, kang.yang@oss.qualcomm.com
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH ath-next 2/3] wifi: ath12k: fix HAL_PHYRX_COMMON_USER_INFO handling in monitor mode
Date: Tue, 22 Jul 2025 17:59:33 +0800
Message-ID: <20250722095934.67-3-kang.yang@oss.qualcomm.com>
X-Mailer: git-send-email 2.49.0.windows.1
In-Reply-To: <20250722095934.67-1-kang.yang@oss.qualcomm.com>
References: <20250722095934.67-1-kang.yang@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Oy72JvhKX1_3DiNYzLuyr4lVmE1CT4BN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIyMDA4MiBTYWx0ZWRfX9EOPQ/k9wEr0
 q/aAV97XlmgSXhpsapuEGX7MLtQgpa9E29Ea2o+dIvvpmV4hx1aoKq3yJjzp4ybcewUOCWgX9zL
 KN43rSoVxKhfyfuhiEP8ZvJ/eX2d3WC3lsa45fnOqp9VQeUoGgxzqfYElnkvQS1lNWgpxd+vcem
 WOE6A82LLaZT9U8e4yUx5/OHQnZWzROg/ILaXM0YjbV2lVXa+kX+v6COkUiN3PD8H5jzGDUIu9L
 3qSYsfvaEDDFV4KpMj5i1H2cxEoh5V6zjG8rwPb4KLBCKhL46j56iKY9f3svppAVr4BozrR5e6n
 zO/jsnHAf39rHqFEK1YT7TVOQX20adQwY0ovOMvbn5GurJzu6pDfZcRXBAGOibYKqBgfs7M6XuX
 wLqXBTCRkV2q8XpbsXJL6ic6aesdvQrIIMdtWHL7eII8Pb6khi7pWTwT0ttxGiWdM4eVQ5JT
X-Authority-Analysis: v=2.4 cv=E8/Npbdl c=1 sm=1 tr=0 ts=687f6115 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=zMJAYs59dPwnCMFDeCQA:9
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-ORIG-GUID: Oy72JvhKX1_3DiNYzLuyr4lVmE1CT4BN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-22_01,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 clxscore=1015 phishscore=0
 mlxlogscore=999 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507220082

Current monitor mode will parse TLV HAL_PHYRX_OTHER_RECEIVE_INFO with
struct hal_phyrx_common_user_info.

Obviously, they do not match. The original intention here was to parse
HAL_PHYRX_COMMON_USER_INFO. So fix it by correctly parsing
HAL_PHYRX_COMMON_USER_INFO instead.

Also add LTF parsing and report to radiotap along with GI.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1

Fixes: d939919a36f4 ("wifi: ath12k: Add HAL_PHYRX_OTHER_RECEIVE_INFO TLV parsing support")
Signed-off-by: Kang Yang <kang.yang@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/dp_mon.c | 35 ++++++++++++++++++++----
 drivers/net/wireless/ath/ath12k/hal_rx.h |  3 +-
 2 files changed, 32 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.c b/drivers/net/wireless/ath/ath12k/dp_mon.c
index ec1587d0b917..e93ede5e6197 100644
--- a/drivers/net/wireless/ath/ath12k/dp_mon.c
+++ b/drivers/net/wireless/ath/ath12k/dp_mon.c
@@ -1440,6 +1440,34 @@ static void ath12k_dp_mon_parse_rx_msdu_end_err(u32 info, u32 *errmap)
 		*errmap |= HAL_RX_MPDU_ERR_MPDU_LEN;
 }
 
+static void
+ath12k_parse_cmn_usr_info(const struct hal_phyrx_common_user_info *cmn_usr_info,
+			  struct hal_rx_mon_ppdu_info *ppdu_info)
+{
+	struct hal_rx_radiotap_eht *eht = &ppdu_info->eht_info.eht;
+	u32 known, data, cp_setting, ltf_size;
+
+	known = __le32_to_cpu(eht->known);
+	known |= IEEE80211_RADIOTAP_EHT_KNOWN_GI |
+		IEEE80211_RADIOTAP_EHT_KNOWN_EHT_LTF;
+	eht->known = cpu_to_le32(known);
+
+	cp_setting = le32_get_bits(cmn_usr_info->info0,
+				   HAL_RX_CMN_USR_INFO0_CP_SETTING);
+	ltf_size = le32_get_bits(cmn_usr_info->info0,
+				 HAL_RX_CMN_USR_INFO0_LTF_SIZE);
+
+	data = __le32_to_cpu(eht->data[0]);
+	data |= u32_encode_bits(cp_setting, IEEE80211_RADIOTAP_EHT_DATA0_GI);
+	data |= u32_encode_bits(ltf_size, IEEE80211_RADIOTAP_EHT_DATA0_LTF);
+	eht->data[0] = cpu_to_le32(data);
+
+	if (!ppdu_info->ltf_size)
+		ppdu_info->ltf_size = ltf_size;
+	if (!ppdu_info->gi)
+		ppdu_info->gi = cp_setting;
+}
+
 static void
 ath12k_dp_mon_parse_status_msdu_end(struct ath12k_mon_data *pmon,
 				    const struct hal_rx_msdu_end *msdu_end)
@@ -1641,11 +1669,8 @@ ath12k_dp_mon_rx_parse_status_tlv(struct ath12k *ar,
 					     HAL_RX_PHYRX_RSSI_LEGACY_INFO_INFO0_RX_BW);
 		break;
 	}
-	case HAL_PHYRX_OTHER_RECEIVE_INFO: {
-		const struct hal_phyrx_common_user_info *cmn_usr_info = tlv_data;
-
-		ppdu_info->gi = le32_get_bits(cmn_usr_info->info0,
-					      HAL_RX_PHY_CMN_USER_INFO0_GI);
+	case HAL_PHYRX_COMMON_USER_INFO: {
+		ath12k_parse_cmn_usr_info(tlv_data, ppdu_info);
 		break;
 	}
 	case HAL_RX_PPDU_START_USER_INFO:
diff --git a/drivers/net/wireless/ath/ath12k/hal_rx.h b/drivers/net/wireless/ath/ath12k/hal_rx.h
index a3ab588aae19..801a5f6d3458 100644
--- a/drivers/net/wireless/ath/ath12k/hal_rx.h
+++ b/drivers/net/wireless/ath/ath12k/hal_rx.h
@@ -695,7 +695,8 @@ struct hal_rx_resp_req_info {
 #define HAL_RX_MPDU_ERR_MPDU_LEN		BIT(6)
 #define HAL_RX_MPDU_ERR_UNENCRYPTED_FRAME	BIT(7)
 
-#define HAL_RX_PHY_CMN_USER_INFO0_GI		GENMASK(17, 16)
+#define HAL_RX_CMN_USR_INFO0_CP_SETTING			GENMASK(17, 16)
+#define HAL_RX_CMN_USR_INFO0_LTF_SIZE			GENMASK(19, 18)
 
 struct hal_phyrx_common_user_info {
 	__le32 rsvd[2];
-- 
2.34.1


