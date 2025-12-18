Return-Path: <linux-wireless+bounces-29867-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C219CCA042
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Dec 2025 02:55:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 16B57304C285
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Dec 2025 01:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E124126E6F0;
	Thu, 18 Dec 2025 01:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="g1/6/G47";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="K/tuzhnb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C245272E7C
	for <linux-wireless@vger.kernel.org>; Thu, 18 Dec 2025 01:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766022919; cv=none; b=HUM6wTbLnp/NwUMPwP7cr0CL+2UY3jPMdrhXRBf3r5RSIPfYXqEngGhibwuCL24I5p50vzUlBt9fSN7hTykwQ4nJc+MS1QqqMZm9Pggz4mu9xW5WuLw6x3RXDHcCqII11ZctsT3WMuHJ4ARlQ5o8D6RhwikfFVn3dPTtapRGguY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766022919; c=relaxed/simple;
	bh=gQUGzP7JNNU6tvmIfyajjZbvrmkcF24OTytvk8RuwsI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WMrmElzQzLhs43NVRXWqFklLPHUwDPdhJhuQ20tFEyY+Urccfa36sAvbksPey1j7cUh3qHFA6s7rMXUkak0dALMDENFwUhNjQF8orRrSBL/t+SOgd7BRZlatChS0nUQNQXnxxdItHO8BcOfEexjtSPWbg8ZNxVBr1HHtRYKRpew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=g1/6/G47; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=K/tuzhnb; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BI1YZL94147984
	for <linux-wireless@vger.kernel.org>; Thu, 18 Dec 2025 01:55:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	USK9gTegbFUVTqdlXJ3G4I84U5jaASDFB+zUUzmxWHU=; b=g1/6/G47T8ktb4vf
	w2jX+F7m5FidKDodsnNKaoldgskHjFUVYGs7NhX6/jJ+VJWNvFo+7illlLPUDlHv
	vrXA1CusoUG/cokbhNP1C/ZaAGY94u+0TBACH81lEjU853fIaPbScN0BGgAs+Vxr
	+7w1OO0gjYc4wQHUFz/Tzhva6vepUFk+jNFYn49Uj05dF9Sq6RCh+0jObeCqh08H
	8y7TKUCsG+KcMaws2Ml4vYP4h4vmxTFBfV5N/2IrThCgNTx630zJ8gHU3Ofx8D3U
	uvxeHG592qycSRS4vOePOvc1is1bTzwqNnA8a69NieN5P3BNtXEtmQkuOUypilRo
	G3738g==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b40u798kx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 18 Dec 2025 01:55:17 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2a0e952f153so3969825ad.0
        for <linux-wireless@vger.kernel.org>; Wed, 17 Dec 2025 17:55:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766022917; x=1766627717; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=USK9gTegbFUVTqdlXJ3G4I84U5jaASDFB+zUUzmxWHU=;
        b=K/tuzhnbZfRpjCaQrQwiqCsm0KqRQTFcFoGFaRwgidSBOoBRVpdA461tDQD5uzWAEn
         il+C+RIzsjNaG5ZlPkf2wTCNZy4Tp7cFPEKOpDOg+BSOnvodtiBDK/vD6JCpReQtsK+S
         210vXXjpsLtXLlokt99SaoEHzLRI6hkKHE9KyrKI81I/oWVncvQhvbPnW6kM9r5jKjvw
         TEU9O+kDVXt+r/ynL2h/g9gIi3EQQsOCzvrTULIBifJRi59jTHao7SKU2Q3K4qEBkVY5
         6TpCqE30AH65HqOFmzFOhwJJ0ZZ9EKGP8jvUVFdlebpfoorGWP+UuGJSiOMjUiRGjXAt
         xFbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766022917; x=1766627717;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=USK9gTegbFUVTqdlXJ3G4I84U5jaASDFB+zUUzmxWHU=;
        b=rSlWR57NUdANWpsjyk00+JBrq0T8TXh7JTxaLEdi0Z1v0aIY6pz/2FhrE+QxKmNbuk
         6CK0n8CoAr18xSY9VYL4+AwW6taG6jYzQTkU3A8maG/KHDfNp/En2vBnGDYHS9S0y+HC
         i2UWiMKH8JrKsQELRp+OFgKZyAiQRBBuYOZtF7OFcMUvj5uZMWMOVnuNeKFswAlg+em3
         rR9ThWM3Tz6kAYbgspf4dKDkHmEwUO4elrpGnZbUwdXKIAJNGbLUmk2tNNWa30DSFVeL
         MlhobPeJJlZi9T1iL38l+hzgo7vHwgLm7aKVeyxpRJNpZ8fh6sEuICEzCZTbMsOSsVaM
         KtfA==
X-Gm-Message-State: AOJu0YyEb4jgKTJm18ReW7+jxZ8XQL108s78l34NDJ2D+5A3+6WCGfGK
	WdnwcZv/Lre77yeZrgRGYiomPmlZ99cm8x64fSnLUMuSAUV4dpoosoSXKkhgddvYO6b1zTOOr6W
	xIKJ7lw8FzFyfnbn0i/piSUracAeBuFIPOAdJKlWkA5KP8Fw/riydJtNyLVklIueGQ00Ledx4fn
	132+NI
X-Gm-Gg: AY/fxX4OofR/4OI05IZ/5yj+DkkXRztJqu+Rd4cfUaVZBJcayvr0hDoH0nuN2+5XlcN
	DHJCr+DjySc22tYFBBqJrAqekPY3DIAW5+OSK/kdZ/hYtf41+gH8PJLxm180NHMOhSM6qzLV+ar
	u/xfCGZlX/dYI7CGu5PFN0Q6wsQwwT9IhL7LTIU2M3S8BgMrwHDp/yKJfCbTVUW0JNGRTD9mrmL
	CnGefr1Mz4/XTOOgXxLya1fSk5s0+V8PyxaTMNr8+2HQ71x69vdI4N5rghR1YfaiieEYyubFmYe
	fv/Jn8Kzy5AxYmMTWAoxVFAlzrqZumPWvpYoRiiW+DIAWsvE5k+MiBtpFcPDzaRLBplbO5AkZVe
	1iUxUNOAbISjnXM1qDWcstH+ejinwceig9sIWYsWVqDKoC1rcjyGpdp4QrCZuLAE=
X-Received: by 2002:a17:903:2281:b0:2a1:e19:ff5 with SMTP id d9443c01a7336-2a10e191134mr108647695ad.38.1766022916699;
        Wed, 17 Dec 2025 17:55:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEb0WFeuaNdUD/muzLE3WY+H/ZJqp6xvlEcEEd6Q6rMJCQWUxIQzQfOq5WEEMx3ea7LYeXVjA==
X-Received: by 2002:a17:903:2281:b0:2a1:e19:ff5 with SMTP id d9443c01a7336-2a10e191134mr108647595ad.38.1766022916249;
        Wed, 17 Dec 2025 17:55:16 -0800 (PST)
Received: from [127.0.1.1] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2d087c812sm6548175ad.15.2025.12.17.17.55.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 17:55:15 -0800 (PST)
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Date: Thu, 18 Dec 2025 09:54:20 +0800
Subject: [PATCH ath-next 06/19] wifi: ath12k: fix mac phy capability
 parsing
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251218-ath12k-support-qcc2072-v1-6-87928cf8e547@oss.qualcomm.com>
References: <20251218-ath12k-support-qcc2072-v1-0-87928cf8e547@oss.qualcomm.com>
In-Reply-To: <20251218-ath12k-support-qcc2072-v1-0-87928cf8e547@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        20251201-wlan_image_load_skip_512k-v3-1-bedb5498a58a@oss.qualcomm.com,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: c6c7oO0N16cbXPBW9f_nt1T19VXp-WEx
X-Authority-Analysis: v=2.4 cv=Z8Th3XRA c=1 sm=1 tr=0 ts=69435f05 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=f0Wkw4mh0JH31tpTHZgA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: c6c7oO0N16cbXPBW9f_nt1T19VXp-WEx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE4MDAxMyBTYWx0ZWRfXzoHW/om7LKwD
 8NN+Ej/BNsdt29gXqJu3aBCIezAhx7NXVNIbqhIki/aEhEV++UvOvqF2d4h7nmnLTHoTJAcMcwM
 HMuUSu0X8NgiLq3J+65aUmizoFCVoYVc8Ake2UFLPOO7LXGGUbmX/d2mDbz3mmhLQNxbxR+HWd6
 doHXT/JUa995czztmmDOMK5aj7h3PEdBOD0kQ99Wl+aGj6iZjfR+B3sWreHE8d7amagNs2lbNn9
 9rU6TwUXLWgBsGrGu7fYjhc6UEZ2UxeNrblq1XRADCWxP0/IFh4ctofTm4McT16/Q/UQXkeGFcb
 CSfe7dg27yCPpOz/ub4sCLFxF2Ym6W4IFuiFKLxiRO16jFM826jeC1ZZa/8vU+Au5+SH9LV0COX
 68MEXkEDAFz9V/7XDOD2dt/ts45SZg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-18_01,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512180013

Currently ath12k_pull_mac_phy_cap_svc_ready_ext() assumes only one band
supported in each phy, hence it skips 5 GHz band if 2 GHz band support
is detected. This does not work for device which gets only one phy but
has both bands supported, such as QCC2072.

Change to check each band individually to fix this issue.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00302-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.115823.3

Signed-off-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/wmi.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index dd643af892c2..ef7690f829ca 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -399,6 +399,7 @@ ath12k_pull_mac_phy_cap_svc_ready_ext(struct ath12k_wmi_pdev *wmi_handle,
 	struct ath12k_band_cap *cap_band;
 	struct ath12k_pdev_cap *pdev_cap = &pdev->cap;
 	struct ath12k_fw_pdev *fw_pdev;
+	u32 supported_bands;
 	u32 phy_map;
 	u32 hw_idx, phy_idx = 0;
 	int i;
@@ -422,14 +423,19 @@ ath12k_pull_mac_phy_cap_svc_ready_ext(struct ath12k_wmi_pdev *wmi_handle,
 		return -EINVAL;
 
 	mac_caps = wmi_mac_phy_caps + phy_idx;
+	supported_bands = le32_to_cpu(mac_caps->supported_bands);
+
+	if (!(supported_bands & WMI_HOST_WLAN_2GHZ_CAP) &&
+	    !(supported_bands & WMI_HOST_WLAN_5GHZ_CAP))
+		return -EINVAL;
 
 	pdev->pdev_id = ath12k_wmi_mac_phy_get_pdev_id(mac_caps);
 	pdev->hw_link_id = ath12k_wmi_mac_phy_get_hw_link_id(mac_caps);
-	pdev_cap->supported_bands |= le32_to_cpu(mac_caps->supported_bands);
+	pdev_cap->supported_bands |= supported_bands;
 	pdev_cap->ampdu_density = le32_to_cpu(mac_caps->ampdu_density);
 
 	fw_pdev = &ab->fw_pdev[ab->fw_pdev_count];
-	fw_pdev->supported_bands = le32_to_cpu(mac_caps->supported_bands);
+	fw_pdev->supported_bands = supported_bands;
 	fw_pdev->pdev_id = ath12k_wmi_mac_phy_get_pdev_id(mac_caps);
 	fw_pdev->phy_id = le32_to_cpu(mac_caps->phy_id);
 	ab->fw_pdev_count++;
@@ -438,10 +444,12 @@ ath12k_pull_mac_phy_cap_svc_ready_ext(struct ath12k_wmi_pdev *wmi_handle,
 	 * band to band for a single radio, need to see how this should be
 	 * handled.
 	 */
-	if (le32_to_cpu(mac_caps->supported_bands) & WMI_HOST_WLAN_2GHZ_CAP) {
+	if (supported_bands & WMI_HOST_WLAN_2GHZ_CAP) {
 		pdev_cap->tx_chain_mask = le32_to_cpu(mac_caps->tx_chain_mask_2g);
 		pdev_cap->rx_chain_mask = le32_to_cpu(mac_caps->rx_chain_mask_2g);
-	} else if (le32_to_cpu(mac_caps->supported_bands) & WMI_HOST_WLAN_5GHZ_CAP) {
+	}
+
+	if (supported_bands & WMI_HOST_WLAN_5GHZ_CAP) {
 		pdev_cap->vht_cap = le32_to_cpu(mac_caps->vht_cap_info_5g);
 		pdev_cap->vht_mcs = le32_to_cpu(mac_caps->vht_supp_mcs_5g);
 		pdev_cap->he_mcs = le32_to_cpu(mac_caps->he_supp_mcs_5g);
@@ -451,8 +459,6 @@ ath12k_pull_mac_phy_cap_svc_ready_ext(struct ath12k_wmi_pdev *wmi_handle,
 			WMI_NSS_RATIO_EN_DIS_GET(mac_caps->nss_ratio);
 		pdev_cap->nss_ratio_info =
 			WMI_NSS_RATIO_INFO_GET(mac_caps->nss_ratio);
-	} else {
-		return -EINVAL;
 	}
 
 	/* tx/rx chainmask reported from fw depends on the actual hw chains used,
@@ -468,7 +474,7 @@ ath12k_pull_mac_phy_cap_svc_ready_ext(struct ath12k_wmi_pdev *wmi_handle,
 	pdev_cap->rx_chain_mask_shift =
 			find_first_bit((unsigned long *)&pdev_cap->rx_chain_mask, 32);
 
-	if (le32_to_cpu(mac_caps->supported_bands) & WMI_HOST_WLAN_2GHZ_CAP) {
+	if (supported_bands & WMI_HOST_WLAN_2GHZ_CAP) {
 		cap_band = &pdev_cap->band[NL80211_BAND_2GHZ];
 		cap_band->phy_id = le32_to_cpu(mac_caps->phy_id);
 		cap_band->max_bw_supported = le32_to_cpu(mac_caps->max_bw_supported_2g);
@@ -488,7 +494,7 @@ ath12k_pull_mac_phy_cap_svc_ready_ext(struct ath12k_wmi_pdev *wmi_handle,
 				le32_to_cpu(mac_caps->he_ppet2g.ppet16_ppet8_ru3_ru0[i]);
 	}
 
-	if (le32_to_cpu(mac_caps->supported_bands) & WMI_HOST_WLAN_5GHZ_CAP) {
+	if (supported_bands & WMI_HOST_WLAN_5GHZ_CAP) {
 		cap_band = &pdev_cap->band[NL80211_BAND_5GHZ];
 		cap_band->phy_id = le32_to_cpu(mac_caps->phy_id);
 		cap_band->max_bw_supported =

-- 
2.25.1


