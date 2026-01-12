Return-Path: <linux-wireless+bounces-30679-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BA19D10EA4
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Jan 2026 08:37:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 17D7930869B3
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Jan 2026 07:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C016C331A5B;
	Mon, 12 Jan 2026 07:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oKKMdmrd";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jekHsA0d"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67FD930CD82
	for <linux-wireless@vger.kernel.org>; Mon, 12 Jan 2026 07:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768203427; cv=none; b=VHjlCj2T1Wq4dpRipZTGT9pJ+vFcj/+nykoI1PeiOIfpWq9EaSiv5aNdDloeKA5850SiasTE8Rq16d8sE+GcC+SraLNyBxnjAqNDAkMutDm5nyskoNMfa2iBE596i7OsSk97xAofeDTQywhf+5/2DgNt2wKLxU7NnXs8752K4+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768203427; c=relaxed/simple;
	bh=vnMw/+9Hb/N2pjnSCowCVoWPy4Z5gRy2Hq2RNi/vLuc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r+85k3oJQHAWEz+UgSeYtjkkgSR0xvbou/6juiGlghDq10/A5YFZY2Rat+5EryJp5WwMwvfrPVO98jRnZAFKkB1XZ3r2ZY6hVmYfKpl709S4AZXOsn3JgTapz9Jf8RrF6gU56ouQWlk0m0JISu78nRAL24wCUkitOGVvS1KE2jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oKKMdmrd; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jekHsA0d; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60C7Ocm3555254
	for <linux-wireless@vger.kernel.org>; Mon, 12 Jan 2026 07:37:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TM3rjSfEe43fhT+aoVY7K+zVTC/c8MyJyzGFdi0Enm4=; b=oKKMdmrdeq98vXEe
	sbIJtTTjFHnelh9xyO7XC6AYWhwtrGJP8oXXHrBXV/eBw1mcIn2yaEVUcDufr4m+
	s31PDYthGjHtimCC7QoSRi+TlOYR5tmmBwHM8+L0E5jSNocV6zapOuq/zbT7BMUa
	WA1njIm4E29NllMTiUmnFsdFjVvDTbj8nxyj1iVVHM94jaA35uP9b2edsqPZFRvm
	65oxbePbZpYWT7i81BE8U37s4rJZNl48qnAwtFnZ46RC+lKuux/sjBKD0mkhxvAU
	sQGbYczPa032l6pRK4HvFERZijFRYtUZvEGtmcb52RYlASjWJkAm1GgKZNOnsLkt
	U3nkTQ==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bmvhw014m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 12 Jan 2026 07:37:05 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-81ee4f90ef8so1520238b3a.1
        for <linux-wireless@vger.kernel.org>; Sun, 11 Jan 2026 23:37:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768203425; x=1768808225; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TM3rjSfEe43fhT+aoVY7K+zVTC/c8MyJyzGFdi0Enm4=;
        b=jekHsA0dwkiUfukMxdFM2UkVPUZNbUaZHLDe1FWz6iIicWeYGJ8MnxVR2YwnZrskGB
         KAt5pCmMRmFn8yGzllJy3OcMapczI6z6eIvpMcnwNA7/20xNovDbIc61llVxEaIznoDI
         I0ZD6rnAo2xwbTuUUn5EEQeHGy2Gcb3n2PCNbxWAm6pEOU1R09vJbVNaiaxuVQ6RzEYs
         LXW2QqeEX0PpOKUwtkQ1C/ACatIyfV8ZR11zHlbCSX6LoI5RzsZ+BxR0NPjKitoJbpsP
         +/s9EQSi2C7OSmZLSTCBDa3CFd7Xg109HcQn7LjAyo0O1TzXo9hUVBlEG+HoIg286LK2
         gosA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768203425; x=1768808225;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TM3rjSfEe43fhT+aoVY7K+zVTC/c8MyJyzGFdi0Enm4=;
        b=oCXlgP5JAl6odbxpXzHJZqey+BX5DLScbGtzThLgCb4lSxJ7h6l7kjcF3+82IZ9OFe
         IGAlSZhoKfd3+qVyObgjlK/m703j0hbI3r+BLhnmC9kn8UwMzsNRuNHZEqO4EffH+jWf
         I1xrFExS4ITQ/MfiV/7+eve7MiDJKRBvam1Xde+WTQE5+wej3s1r2xqIsj1LHlRuaVkY
         EXAPka5xJGOfEQOo8C6Ean/aSen7qLmGNIDmw8LQJnTSYuACUWo2Q3MGPLbyDqEpYnur
         bJ0ev7JwlVUHALsAFIqJvgQ+vWiK0+umum7wwXQaLQewwWSUvoDS7tF5gocy7gNF3UPS
         gjlw==
X-Gm-Message-State: AOJu0YzpPd8i/Io1lE87knSMBeDA632ZvF2FdFsnhKU8U1ui88UHiwkb
	W0QX7dHCSuo8wNvcDgEcSGhQUNKVOjhDUGRURyghnCdCOBCkgufpnorgaknHnwVfikpUeY7RW6d
	7c6Eeh5t4f3xS6p6X2kmu77ezyi10teO/I6jA4huhtC5g9aQLcYDVsUVxHhweOv7m/0ZZnw==
X-Gm-Gg: AY/fxX5jNVcedfPWTYlw1wOrgw64Orj/PcC4tXykfn7yQBC3m7ElXwUduolbjE8fgih
	qxlxoEwCtWXdLfaAy9fxgRGB/Mkd5evy2tkpCKLsWSTVBowoSX1dH7DLuX540ohb5CUr6POrz3B
	78Hz0/w7APo6k0dWimNa7hbbVeqhBVQmyabOw20PKxRXI0VBIw/e/sPe6G62up2zpnaXHSI8dqx
	ajsTZEzx8DpqgMxLaY6PMYJX1pbLEN4ORHHY2peSt4W5qdv5HTDiSDHa29fYD9clEeQ64MTaWgE
	I1BgjisGPvF/KZLgFZ0vDVJ7jUBVlbyAskStdCu/+xNrWGij57dhjXjoJdE5SKuZocrtKa8GeCM
	lPo0mZuGPLXNgI4buAwTEUuGwQJKPa+QYjPEP+lWj5/f7thtf93JKTzPP0s+Z8jw=
X-Received: by 2002:a05:6a00:8088:b0:7e8:450c:61b8 with SMTP id d2e1a72fcca58-81b806c8389mr15215730b3a.40.1768203424908;
        Sun, 11 Jan 2026 23:37:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG3rWtugbYV4vAb6oMxXrmEG1FVXJtQzJwP+lPOmpG0tx+hpTUMmsprOniOQc8a4w1Sk2aLgg==
X-Received: by 2002:a05:6a00:8088:b0:7e8:450c:61b8 with SMTP id d2e1a72fcca58-81b806c8389mr15215711b3a.40.1768203424433;
        Sun, 11 Jan 2026 23:37:04 -0800 (PST)
Received: from [127.0.1.1] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c4cbf28faa9sm16548684a12.2.2026.01.11.23.37.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jan 2026 23:37:04 -0800 (PST)
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Date: Mon, 12 Jan 2026 15:36:26 +0800
Subject: [PATCH ath-next v2 06/18] wifi: ath12k: fix mac phy capability
 parsing
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260112-ath12k-support-qcc2072-v2-6-fc8ce1e43969@oss.qualcomm.com>
References: <20260112-ath12k-support-qcc2072-v2-0-fc8ce1e43969@oss.qualcomm.com>
In-Reply-To: <20260112-ath12k-support-qcc2072-v2-0-fc8ce1e43969@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEyMDA1OCBTYWx0ZWRfX0U3DIjLdKAi2
 DKxhQM05UieP/JNHRuJTwwYn586RDTa2rXxqoQv6FDw1xlH6z0VWRhj6kayvcDBZlvGxDgOVcMN
 1As5J/99YZyxEyLMnR5v6h8xSJ6lP25mM1THzXq78Kfd+aA5vKaVTuj7LIIiSgFj23j3KKCgxvZ
 WOC+YLnr+gnaEiXsEWLtUWMszAg0U599N/U9z0juhN7cwWlkpQQXwvvw3g7K6Sp/O/7lXHXeP7k
 hWHvplMhPsIFQHiGlAW04BmvQsTG6wu/KBIla7mTEVoAYm7lBM+3lQbGod59QTmx7ezB2SPgE80
 UiSB+OwuWZ0abnqcuWIZnDZ126iniQj8NBmhIcbdD4jWJPIKPcEbrSoTh0RkVBbqdVJKIDtqcRz
 PdG6+ID7TadxNebYafMTCSYNz6nCjPPAe6SwHZP3ObYtScaUXUL2zZFFdnwCNNsdKLu6EcI3M9u
 eH8+04a51aW0EWqGpdA==
X-Authority-Analysis: v=2.4 cv=JP02csKb c=1 sm=1 tr=0 ts=6964a4a1 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=f0Wkw4mh0JH31tpTHZgA:9
 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-GUID: rq3xjETYvevVIjJJ1aFL3NWDrvpmbWJ4
X-Proofpoint-ORIG-GUID: rq3xjETYvevVIjJJ1aFL3NWDrvpmbWJ4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-12_02,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 suspectscore=0 clxscore=1015 malwarescore=0 adultscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601120058

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
index 248933eac061..79a26203afad 100644
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


