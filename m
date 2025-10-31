Return-Path: <linux-wireless+bounces-28431-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EBBFC231F9
	for <lists+linux-wireless@lfdr.de>; Fri, 31 Oct 2025 04:08:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 547551A20EA6
	for <lists+linux-wireless@lfdr.de>; Fri, 31 Oct 2025 03:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFCE12F29;
	Fri, 31 Oct 2025 03:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="J68eeW0A";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="M9shtcNP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F097264628
	for <linux-wireless@vger.kernel.org>; Fri, 31 Oct 2025 03:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761880079; cv=none; b=ZYUoVnhlivSP9QM4GfK8cq1/Bnl5OBsm7pe5DhZFenoI96GQ48Lo1LXxuWEAs0bfJMVFVJxZe4QmPKfnynPhh+M1a5Yar0vHXX2VJcfUUkS1emiBllkLVhod13tJIFwY2a/prE9poYM2liyYNWvyEISV1d0t2/dys3uvtLNWkrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761880079; c=relaxed/simple;
	bh=1Y6zxjUj+VHqVACnYREGfUVmE70npZA1J82PaOjXw5Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fjVHwo1lsyCh+nWVMHz4LmWLeyqGcqmY1NpY/iR6fROckLRqu/9Mf0xPUQ+/ZYfl63iWg05hz4zvT4nnSQdmHyWWVhcNvFUSEiGYeu0D8umMvMoH6HTGGcCad1kDCr+EtwHT3iSdsI1krJd2kmjv8LkjJePtfCuzifWBw2rCJGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=J68eeW0A; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=M9shtcNP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59V2B6mV102654
	for <linux-wireless@vger.kernel.org>; Fri, 31 Oct 2025 03:07:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	K95Ko3CGgptOLyfI80+QbvELENUisYEUnnFY8ZDOn74=; b=J68eeW0AzovFztMF
	KzAQuXQ2lgeHlvgYNicAhEYOOHK8MDiMR1QAe4W8Z9OEb72PvgX/9PXeFoD0OB73
	mjP7vbeZpbqai89SYAW4J9/TENEx2eyaj0fh9h4leF3VEDJqdvglUjGOhu3z+cZg
	aB9EQORiVip+VuydK6egqfYJDUrQ/zRGEgVrgPFmciUIXA193UvfQD+V2aFE0GtL
	ql9kQ8RNRQRDSCL1RsrJxTPG23QJlho0i1QPqOXAmYKzLXg/fT7ri16wz424VMnB
	jELfq1q3yf9TQaAEKIpBzZilyc4qxlK+HdanSBO41u8t+dqaizvENpYOa52i/maf
	Lfzx3Q==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a4ahdhq5k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 31 Oct 2025 03:07:57 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-7a675fbd71eso2582416b3a.2
        for <linux-wireless@vger.kernel.org>; Thu, 30 Oct 2025 20:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761880076; x=1762484876; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K95Ko3CGgptOLyfI80+QbvELENUisYEUnnFY8ZDOn74=;
        b=M9shtcNP71RVXbrp4AWQXtitpVQ1325zrPgIwh8+8WjC7oUpJlIo7ENkNcvD9LGn7K
         RCp6lhaneCQbYizXaIv/1OdV03/8OVGd/nA3gk/c6aySvcOTQTB4bdHJFL6djHXMU8ss
         3hd8ooba51nMr2vgIODo8f8LMQdsjn/dOq3PVWWaKvXd9YMgs+fJ5FoHTJlnhWaThlhH
         lFmxRKhuY6DiGdKaCe8MxFRWuuuotGlLRPX+/a/dm4ztBxSFZaNVQb7Z+8OVY0DxNAt/
         XfN1CEDr0wQ6oQ5WhkfSFZJDRokYv4dX56CLfad8fSGlI3sgpdSJWv6EE36d7cFI+vc/
         tl/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761880076; x=1762484876;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K95Ko3CGgptOLyfI80+QbvELENUisYEUnnFY8ZDOn74=;
        b=SRRcoPmukeA53WLSGFOi39LpysGQ9SekHpL/esdOpRP4bRllJeEJDB5WvZ8DeuaKix
         Zh/pfS0IFAuufDMPH02HFS667b2sLp0EdYhgQkSuyp9F3pbS0HVKbLhtGWeoaCI68AoZ
         Wh2z5z5vzimhp3pS5CjYcd+Q0s4Fa7inceqQn4HAMBKeI+8Uvz5ZsmU/z2md7oPv23/U
         34oWaATnziDeHzfyRoans2IWN0jA3LUhOpYkABzkIBxzSbcegdFMQrfhyrRRdhrHDfWD
         ZP5ZH1PDvHEL57dDpKp1EqtJnYwuXsgc+aCRVuVVX5P0znU0b+aahyxaRP+5Q77Pe9Y0
         cFlg==
X-Gm-Message-State: AOJu0YwBW+KsU03iO+FTsG3iwN13aGxXrOUNfQt6qAJ/zh1lEm+CxYOa
	JsICzTuD77jfJ+20m0KXgzdRtgzrXibO431phRxZisS+FiTrwBYRuZHRPIekNYzLtpjO5B3vDV9
	pjQ6LHAbK2xvzmISZrElFVURdN8NTU+87XEsgT/48ksjXlsGPTuDzyzIT0Dy0JrM+0LKy7S5uHY
	gxVQ==
X-Gm-Gg: ASbGncskS1sFYnkFlO/OMDBZ4KXJWpnSImI6WFQe5Z76z33/HG9AByQuC9rtb0IiVbW
	S7/MtdwofgvKISyQ266jA4eJOM1rfXksyvnfm1EJZdUwCPwvg+3ygFuuoewFNc2YU16lqwM7BWA
	EmWc1AFEdq1NowizM0Gggz1jCO0QhrH8QycxN5vPl/xFLCPGSY93Xl2LkwwYa+U8i6kdju2uUwL
	H87PUeEVflJ44DdiEOLJOWnpkAs2NQm8iGGJRCVN88gYwLcklFmEp8UYB0VKG31B/c5XkopqS2v
	t7PE6IhAaauj9fGyq+alNs07I+7s2gfPIPfduyq2kkHqyL4GWqHEhCNmpGVpYWLHXNQyz9BaywD
	Nnci4rC5IEJL4ayA+wvCu/ancUZt+nPeGf9mt/vYVKarXc1BalWN0U15ELVPSJ/loJzl/i/pAZR
	RG2SVfqXb8dN8rvqHM2oDhfpgEGJa3xQc=
X-Received: by 2002:a05:6a20:2446:b0:343:6f53:e97 with SMTP id adf61e73a8af0-348cc8e377bmr2711646637.48.1761880076164;
        Thu, 30 Oct 2025 20:07:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGUiCAhShpTI+lCmKGzYA1Uo+PVpMB6cFI0JJzik1O352ZEBS6coEhPZ8shA1KJp+QEzbjumA==
X-Received: by 2002:a05:6a20:2446:b0:343:6f53:e97 with SMTP id adf61e73a8af0-348cc8e377bmr2711602637.48.1761880075636;
        Thu, 30 Oct 2025 20:07:55 -0700 (PDT)
Received: from hu-mdharane-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a7db0a2663sm372130b3a.48.2025.10.30.20.07.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 20:07:54 -0700 (PDT)
From: Manish Dharanenthiran <manish.dharanenthiran@oss.qualcomm.com>
Date: Fri, 31 Oct 2025 08:37:45 +0530
Subject: [PATCH ath-next 1/2] wifi: ath12k: Make firmware stats reset
 caller-driven
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251031-beacon_stats-v1-1-f52fce7b03ac@qti.qualcomm.com>
References: <20251031-beacon_stats-v1-0-f52fce7b03ac@qti.qualcomm.com>
In-Reply-To: <20251031-beacon_stats-v1-0-f52fce7b03ac@qti.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Manish Dharanenthiran <manish.dharanenthiran@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-1b0d6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMxMDAyNiBTYWx0ZWRfX2AqM8401QX15
 sLqmCrvRP4RG73AEaVWhPHV7GaKSqh7krQQL1HWMNFvjiRlizZ0HQ2PY7QRhR8lGXj4BV3duBdf
 8YuSN07QQ2q0au/7Xu7z6FGrxggyEeomK1hQwO/be7UoXhiWhw7NAJMmhj0j+NV7w2cjcuXQBhK
 Ifq/b2THkrsCYpyFbBqJLZhbIy52+AQWkvzKePky4o8olDifNcbx/wvskX+4so2PywVjE4mrW+1
 B+bxodtwPyT0QLLAEGtZUiEGUIRIIQDCWSAaiiz98Tc5SSbPmkbdcKNG5IzSC0dVvLj8itDoovF
 05b3y9/kbYg+EfumiIcTlim0Wz4gq7S4UG7XALWVt+3OJmlgmngchpyovih3iw83zNimy2IOAgY
 TfCPJYEz1+eQtDfG9jK785U6BMA6wQ==
X-Proofpoint-GUID: J9-k3Zw21zBUCKAQUZIOjAn_ij044Fzo
X-Authority-Analysis: v=2.4 cv=TsnrRTXh c=1 sm=1 tr=0 ts=6904280d cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=GELq1AYrxFz-Eafd698A:9
 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-ORIG-GUID: J9-k3Zw21zBUCKAQUZIOjAn_ij044Fzo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_08,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 spamscore=0 bulkscore=0 phishscore=0 suspectscore=0 adultscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2510310026

Currently, ath12k_fw_stats_reset() is called in
ath12k_mac_get_fw_stats() before fetching the required stats from the
firmware. However, ath12k_open_bcn_stats() requests firmware stats for
each enabled BSS individually. Since the firmware stats are reset before
fetching, only the last BSS's data is displayed.

Also, in ath12k_mac_op_get_txpower(), ath12k_mac_op_sta_statistics(), and
ath12k_mac_op_link_sta_statistics(), after getting the stats from the
firmware, the reset function is not called until the next firmware
stats are requested or while unloading the module. Hence, the stats buffer
will not be freed until one of the above sequences is executed. However,
in ath12k_open_vdev_stats(), ath12k_open_bcn_stats() and
ath12k_open_pdev_stats(), firmware stats are reset after copying the
necessary data in ath12k_wmi_fw_stats_dump().

This leads to inconsistent usage of ath12k_fw_stats_reset() for
freeing the firmware stats.

Avoid these discrepancies by making it the caller's responsibility to
free the stats buffer, thereby removing the need to free the stats buffer
in ath12k_mac_get_fw_stats() and ath12k_wmi_fw_stats_dump().

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1

Signed-off-by: Manish Dharanenthiran <manish.dharanenthiran@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/debugfs.c |  9 +++------
 drivers/net/wireless/ath/ath12k/mac.c     | 15 ++++++++++-----
 drivers/net/wireless/ath/ath12k/wmi.c     |  2 --
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/debugfs.c b/drivers/net/wireless/ath/ath12k/debugfs.c
index 15219429d4ed88c77941533b1ab4c9202ea9da57..d6a86f075d73b92504bef6939ddaa3baa9ce9c1d 100644
--- a/drivers/net/wireless/ath/ath12k/debugfs.c
+++ b/drivers/net/wireless/ath/ath12k/debugfs.c
@@ -1286,6 +1286,7 @@ static int ath12k_open_vdev_stats(struct inode *inode, struct file *file)
 
 	ath12k_wmi_fw_stats_dump(ar, &ar->fw_stats, param.stats_id,
 				 buf);
+	ath12k_fw_stats_reset(ar);
 
 	file->private_data = no_free_ptr(buf);
 
@@ -1352,12 +1353,7 @@ static int ath12k_open_bcn_stats(struct inode *inode, struct file *file)
 
 	ath12k_wmi_fw_stats_dump(ar, &ar->fw_stats, param.stats_id,
 				 buf);
-	/* since beacon stats request is looped for all active VDEVs, saved fw
-	 * stats is not freed for each request until done for all active VDEVs
-	 */
-	spin_lock_bh(&ar->data_lock);
-	ath12k_fw_stats_bcn_free(&ar->fw_stats.bcn);
-	spin_unlock_bh(&ar->data_lock);
+	ath12k_fw_stats_reset(ar);
 
 	file->private_data = no_free_ptr(buf);
 
@@ -1418,6 +1414,7 @@ static int ath12k_open_pdev_stats(struct inode *inode, struct file *file)
 
 	ath12k_wmi_fw_stats_dump(ar, &ar->fw_stats, param.stats_id,
 				 buf);
+	ath12k_fw_stats_reset(ar);
 
 	file->private_data = no_free_ptr(buf);
 
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index e79d457e3c03da372c57e4b2c7970d07c38d6008..11e0514eced8d74e5038ddde66848c7798c7390b 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -4954,8 +4954,6 @@ int ath12k_mac_get_fw_stats(struct ath12k *ar,
 	if (ah->state != ATH12K_HW_STATE_ON)
 		return -ENETDOWN;
 
-	ath12k_fw_stats_reset(ar);
-
 	reinit_completion(&ar->fw_stats_complete);
 	reinit_completion(&ar->fw_stats_done);
 
@@ -5053,6 +5051,7 @@ static int ath12k_mac_op_get_txpower(struct ieee80211_hw *hw,
 	ar->chan_tx_pwr = pdev->chan_tx_power / 2;
 	spin_unlock_bh(&ar->data_lock);
 	ar->last_tx_power_update = jiffies;
+	ath12k_fw_stats_reset(ar);
 
 send_tx_power:
 	*dbm = ar->chan_tx_pwr;
@@ -12828,14 +12827,18 @@ static void ath12k_mac_op_sta_statistics(struct ieee80211_hw *hw,
 
 	if (!signal &&
 	    ahsta->ahvif->vdev_type == WMI_VDEV_TYPE_STA &&
-	    !(ath12k_mac_get_fw_stats(ar, &params)))
+	    !(ath12k_mac_get_fw_stats(ar, &params))) {
 		signal = arsta->rssi_beacon;
+		ath12k_fw_stats_reset(ar);
+	}
 
 	params.stats_id = WMI_REQUEST_RSSI_PER_CHAIN_STAT;
 	if (!(sinfo->filled & BIT_ULL(NL80211_STA_INFO_CHAIN_SIGNAL)) &&
 	    ahsta->ahvif->vdev_type == WMI_VDEV_TYPE_STA &&
-	    !(ath12k_mac_get_fw_stats(ar, &params)))
+	    !(ath12k_mac_get_fw_stats(ar, &params))) {
 		ath12k_mac_put_chain_rssi(sinfo, arsta);
+		ath12k_fw_stats_reset(ar);
+	}
 
 	spin_lock_bh(&ar->data_lock);
 	noise_floor = ath12k_pdev_get_noise_floor(ar);
@@ -12919,8 +12922,10 @@ static void ath12k_mac_op_link_sta_statistics(struct ieee80211_hw *hw,
 
 	if (!signal &&
 	    ahsta->ahvif->vdev_type == WMI_VDEV_TYPE_STA &&
-	    !(ath12k_mac_get_fw_stats(ar, &params)))
+	    !(ath12k_mac_get_fw_stats(ar, &params))) {
 		signal = arsta->rssi_beacon;
+		ath12k_fw_stats_reset(ar);
+	}
 
 	if (signal) {
 		link_sinfo->signal =
diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index 5075d86df36ff5a7863bd9c4b379c61997b02618..f812da24b21e68893327d61fe0ff9deb222bd54b 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -8089,8 +8089,6 @@ void ath12k_wmi_fw_stats_dump(struct ath12k *ar,
 		buf[len - 1] = 0;
 	else
 		buf[len] = 0;
-
-	ath12k_fw_stats_reset(ar);
 }
 
 static void

-- 
2.34.1


