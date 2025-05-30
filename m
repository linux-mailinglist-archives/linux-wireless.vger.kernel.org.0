Return-Path: <linux-wireless+bounces-23505-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F4AAC956B
	for <lists+linux-wireless@lfdr.de>; Fri, 30 May 2025 20:03:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 661C01C21CEC
	for <lists+linux-wireless@lfdr.de>; Fri, 30 May 2025 18:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40F92194A65;
	Fri, 30 May 2025 18:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YT6bfQvv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91EF625E806
	for <linux-wireless@vger.kernel.org>; Fri, 30 May 2025 18:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748628182; cv=none; b=EEKR25rpranEUZ2gtkh4SC3Itys9th74NMY+Kd/Xia0kr79+yFqUFeDiGtpHPUzxqigmKFXyKBpE30tizBGnlTSpW1Y82h2HeyVGTmQsxPb/YchxYbN9N9dvt5YgQRIyd+e84zj8+WdXwSjN4IwpBEQMTQOmEDBjx/j6jwy56+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748628182; c=relaxed/simple;
	bh=0EJi3aX5YuP7Z/3rjkjiApIoX0fmJRtVkTslsselr44=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=kxI9M2jbWHlVlfhI6bfUrLQAU18vra8Or0UDBOdvKOfYY32yCtFS0OVR+RL+0bCD1ky21/rL8cR02cXGqlxtaG7KbS0Hc60WmqOQYKTgssPPHXAmfhOCgyDVlwpGe8DsG8w5TsV6SbeZiW8NuM5fJ4OReBT0AMDxC+nailjtUHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YT6bfQvv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54UAhATu009444
	for <linux-wireless@vger.kernel.org>; Fri, 30 May 2025 18:02:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:date:from:in-reply-to:message-id:references:subject:to; s=
	qcppdkim1; bh=tbzjtDFPMgDSfw8+tY1nLj4pEi94zY5+Io8Fdjldiuo=; b=YT
	6bfQvvhB4M48JUQUGMNT05J6yPFZpBK/rpgv+o51Ip9wfdYKJFqdRVTlXkgpXmsK
	eiROtwQVukDkXuWxe3dufdxxqz4Kx8+LyU7lkrCijfvzlhs8rvjchHqrVgzxoStq
	7xIVikriAUo2rZx2sS5B4YvN/KecAn8TBGaqEuGtslCUXrRgUPt2NuID/ZiNAZ/c
	vdyyv3Gd7H+PPlQ1M02bt0iCsf8v/lp/YbFxeIRo3sMV0ElbXHIjVRtkz6fwug9K
	xwNhtRbzgmoMbAZiR4KUdTKzlHK5VEFs/srhmpvtli/BfOcMo1jYu3ggX33g+OH+
	5Pj1v0GsgxwX2TDmknyQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46w691mnqs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 30 May 2025 18:02:59 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-22c31b55ac6so32675515ad.0
        for <linux-wireless@vger.kernel.org>; Fri, 30 May 2025 11:02:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748628179; x=1749232979;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tbzjtDFPMgDSfw8+tY1nLj4pEi94zY5+Io8Fdjldiuo=;
        b=IjQ1UKWTyzZZaWt5a637GzTXra6Jseml2X7uzmUw73o4AgbsUozlIb7Kgb5wLX6nrt
         g9CnKskrDgxwaiQjzpUhEMBsLR6kWfSA8PWC1SRBZJbTWBMZkDmT9QgtzGkcsYZdfYmw
         RrRZA/HLhuHcEhP5oupKDX1DdceVvTh0iMLd1438XHXDf1KBJ7cxzaXQYn4LxS1d1n69
         BC65fOgVr6fj1qE0td0IgbdOCEaMzYohr8/RJ0nyGFYDJckQ4nh4/Hmlqq1SDogf9rys
         gWvKSSNlx023o8/6SjBMo/XX6ZWsBw0hC1vKn8/pHJkuofNtRoKyAhw+tfDtvcnd2SLn
         aOLA==
X-Gm-Message-State: AOJu0YwAB+moTPh5Ljh5Ki5coPm/1eet1B1UKleoT+GcEDileu2Nljbd
	eyQj4ERoozdOtx1/CdjtTNBUd557E0CHeuFjM8KO6ySSq+iRj5DAJKTYcVYAc+Wj0bkk/mxQyl1
	ZmA3MiZ05LjN3Iv3Lk9mOlrKd+Jf6zOCvkWkfgKM6c1cItGYtwTcv/FCq1Pd5kamH7GKfAw==
X-Gm-Gg: ASbGncsbE9KC+Bg1aEQ/VQGaD6OGveasvR8u+kLPYMAhigfvt2Ojlt2AfR05AUjonRT
	rLDif/oeoBx7ztVKnaT8o2kO89y0l2kezfHCtg/F1B/2LNQY7/4qnNAtlqxu0FdF/DAW1/MnpxM
	ANzXldcKJIyTftr6AKM+tLGGdERbINR3z7UsZuahdI8qBsReBgz+DK8Dw4A2WOgQ1pFLN5CPqcG
	J5o0sJT/5GAOuTuHttlpY83vyl21ILfcFWW5embjQNCEHzkF+tosSEDAlmhRaHvD0FRti4Nlgag
	pU3sJim66WsFqlp3rY8SbzcojDWapY+37XNNbz8A/JP8bKyWPAhDBTXf7eZXF7IKDOeZIkkDlzx
	TduL5I2qbRcl1+QjM7J5ZX3BxSMVHuXxb8XeYt3O9yhe7iw==
X-Received: by 2002:a17:902:dacb:b0:234:8c3d:2912 with SMTP id d9443c01a7336-235289fdbabmr68768015ad.11.1748628178698;
        Fri, 30 May 2025 11:02:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEdEztbPoaFJSpq9upOrgHw5rokN4u18YbJRz/Yo+GH/QtKCo3WKkhqFQ21A/LUfJmgbWYTRQ==
X-Received: by 2002:a17:902:dacb:b0:234:8c3d:2912 with SMTP id d9443c01a7336-235289fdbabmr68767545ad.11.1748628178141;
        Fri, 30 May 2025 11:02:58 -0700 (PDT)
Received: from hu-nithp-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506bc868asm31374435ad.31.2025.05.30.11.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 May 2025 11:02:57 -0700 (PDT)
From: Nithyanantham Paramasivam <nithyanantham.paramasivam@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Nithyanantham Paramasivam <nithyanantham.paramasivam@oss.qualcomm.com>
Subject: [PATCH ath-next 1/3] wifi: ath12k: Fix the handling of TX packets in mode
Date: Fri, 30 May 2025 23:32:45 +0530
Message-Id: <20250530180247.424349-2-nithyanantham.paramasivam@oss.qualcomm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250530180247.424349-1-nithyanantham.paramasivam@oss.qualcomm.com>
References: <20250530180247.424349-1-nithyanantham.paramasivam@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=WfoMa1hX c=1 sm=1 tr=0 ts=6839f2d3 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=dt9VzEwgFbYA:10 a=EUspDBNiAAAA:8 a=vl7YvmKCL5Z24jtCxAEA:9
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: QAtpT-SiJAg3gFmI6oKjD-TKF17dns7q
X-Proofpoint-ORIG-GUID: QAtpT-SiJAg3gFmI6oKjD-TKF17dns7q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTMwMDE1OCBTYWx0ZWRfX7LTm31qxqP4q
 rpeEyxsIegONc6U7X4n9vSCwL0JdbHkj+xHluYBkPkuyyH+V+uZiABDs5M/Bk78iNhZ2t+qKIpf
 gAoyR6f0ETvQ2X+Bm2Z1LDpFXqCdJtbqLVGY+ZvA/sqNPWVWpoE6xzgahUEEBYgkA8vZEF+YIdm
 Cv+bmYwoRx+bp2i240fhp/UizSGihv2DFcyiOQtkn7Ab5pu9SUumhpiD3by4dmfP0zAGckBZeeU
 E3vncDhrQ4Dq4SYDmtfTi6nvwpa8ztYES7S6DLXkUFpaBNUV9L22tBx8su5bg4hU/wduH9+CrTc
 XplnGwzlK6M3KHZ3+h/0HIg//Sl6f5V6hpAhDY1UUqhaFL0VqCQottHJB1MTur9W7WXZec49Ceb
 QUWwCpZHbOhbg8qkyW8wd7X3QJOGxACI/wGeBXTp4AcGQ0nYszVlJO9lUPF34C03Hc2wpUrY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-30_08,2025-05-30_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 mlxlogscore=999 priorityscore=1501 mlxscore=0
 bulkscore=0 adultscore=0 spamscore=0 suspectscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505300158
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

Currently, in the transmit (TX) direction, EAPOL, QoS NULL,
and multicast frames are sent in native Wi-Fi (802.11) format.
However, when the virtual interface is configured in Ethernet
mode, transmission fails for packets received in this format.

To address this issue, the firmware should be instructed to
treat these packets as RAW type packets, ensuring proper
handling even when the interface operates in Ethernet mode.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00217-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Nithyanantham Paramasivam <nithyanantham.paramasivam@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/dp_tx.c | 38 ++++++++++++++++++++-----
 drivers/net/wireless/ath/ath12k/mac.c   |  1 +
 2 files changed, 32 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_tx.c b/drivers/net/wireless/ath/ath12k/dp_tx.c
index b6816b6c2c04..189c742f2a00 100644
--- a/drivers/net/wireless/ath/ath12k/dp_tx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_tx.c
@@ -245,6 +245,8 @@ int ath12k_dp_tx(struct ath12k *ar, struct ath12k_link_vif *arvif,
 	bool msdu_ext_desc = false;
 	bool add_htt_metadata = false;
 	u32 iova_mask = ab->hw_params->iova_mask;
+	bool is_diff_encap = false;
+	bool is_null_frame = false;
 
 	if (test_bit(ATH12K_FLAG_CRASH_FLUSH, &ar->ab->dev_flags))
 		return -ESHUTDOWN;
@@ -335,7 +337,19 @@ int ath12k_dp_tx(struct ath12k *ar, struct ath12k_link_vif *arvif,
 
 	switch (ti.encap_type) {
 	case HAL_TCL_ENCAP_TYPE_NATIVE_WIFI:
-		ath12k_dp_tx_encap_nwifi(skb);
+		is_null_frame = ieee80211_is_nullfunc(hdr->frame_control);
+		if (ahvif->vif->offload_flags & IEEE80211_OFFLOAD_ENCAP_ENABLED) {
+			if (skb->protocol == cpu_to_be16(ETH_P_PAE) || is_null_frame)
+				is_diff_encap = true;
+
+			/* Firmware expects msdu ext descriptor for nwifi/raw packets
+			 * received in ETH mode. Without this, observed tx fail for
+			 * Multicast packets in ETH mode.
+			 */
+			msdu_ext_desc = true;
+		} else {
+			ath12k_dp_tx_encap_nwifi(skb);
+		}
 		break;
 	case HAL_TCL_ENCAP_TYPE_RAW:
 		if (!test_bit(ATH12K_FLAG_RAW_MODE, &ab->dev_flags)) {
@@ -379,15 +393,25 @@ int ath12k_dp_tx(struct ath12k *ar, struct ath12k_link_vif *arvif,
 		goto fail_remove_tx_buf;
 	}
 
-	if (!test_bit(ATH12K_FLAG_HW_CRYPTO_DISABLED, &ar->ab->dev_flags) &&
-	    !(skb_cb->flags & ATH12K_SKB_HW_80211_ENCAP) &&
-	    !(skb_cb->flags & ATH12K_SKB_CIPHER_SET) &&
-	    ieee80211_has_protected(hdr->frame_control)) {
-		/* Add metadata for sw encrypted vlan group traffic */
+	if ((!test_bit(ATH12K_FLAG_HW_CRYPTO_DISABLED, &ar->ab->dev_flags) &&
+	     !(skb_cb->flags & ATH12K_SKB_HW_80211_ENCAP) &&
+	     !(skb_cb->flags & ATH12K_SKB_CIPHER_SET) &&
+	     ieee80211_has_protected(hdr->frame_control)) ||
+	     is_diff_encap) {
+		/* Firmware is not expecting meta data for qos null
+		 * nwifi packet received in ETH interface.
+		 */
+		if (is_null_frame && msdu_ext_desc)
+			goto skip_htt_meta;
+
+		/* Add metadata for sw encrypted vlan group traffic
+		 * and EAPOL nwifi packet received in ETH interface.
+		 */
 		add_htt_metadata = true;
 		msdu_ext_desc = true;
-		ti.flags0 |= u32_encode_bits(1, HAL_TCL_DATA_CMD_INFO2_TO_FW);
 		ti.meta_data_flags |= HTT_TCL_META_DATA_VALID_HTT;
+skip_htt_meta:
+		ti.flags0 |= u32_encode_bits(1, HAL_TCL_DATA_CMD_INFO2_TO_FW);
 		ti.encap_type = HAL_TCL_ENCAP_TYPE_RAW;
 		ti.encrypt_type = HAL_ENCRYPT_TYPE_OPEN;
 	}
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 88b59f3ff87a..958299bd5acc 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -7574,6 +7574,7 @@ static void ath12k_mac_op_tx(struct ieee80211_hw *hw,
 		is_dvlan = true;
 
 	if (!vif->valid_links || !is_mcast || is_dvlan ||
+	    (skb_cb->flags & ATH12K_SKB_HW_80211_ENCAP) ||
 	    test_bit(ATH12K_FLAG_RAW_MODE, &ar->ab->dev_flags)) {
 		ret = ath12k_dp_tx(ar, arvif, skb, false, 0, is_mcast);
 		if (unlikely(ret)) {
-- 
2.17.1


