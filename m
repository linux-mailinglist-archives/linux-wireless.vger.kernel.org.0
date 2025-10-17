Return-Path: <linux-wireless+bounces-28005-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69F7ABE642B
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Oct 2025 06:08:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB0891A64C81
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Oct 2025 04:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A24230CD92;
	Fri, 17 Oct 2025 04:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hIrBQLWh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE9B30C37D
	for <linux-wireless@vger.kernel.org>; Fri, 17 Oct 2025 04:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760674096; cv=none; b=Vuqydpnc1ELYyVvP4bN8fXaAP2L3VxPiWeVdgsOnTyz2kE/GEfRUOyBxCJV2FJWiCsCVb3rjRxD3ZStEY2r8qw4rImzdbG8syu+fCP9D2PNZXrlcMxDNnhEDEnGlfwJbdgJgbJcv4PBHm068phwhbuEvK93qPLQJwa2eTU3Q25A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760674096; c=relaxed/simple;
	bh=lEsJnpzptU7Y1tjhh6qn3WuDbr4ZKrkKsd11LQZXKIA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UQYCo88EZ4sy7h39fagGU+vswgkzBF4QhmTqkRcOIhKWehxHS2T+n1Zboe1WRqeR9YaJKZSjQBmBsBqQZSZGP3FmTH6TZochgZZux7b/PCr3zLk52QCOOZle1H1r8FR0DtdQBNoUeozwtRAIYpXLWzJ/DifhsBg44j1Dhu/uj3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hIrBQLWh; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59GKLQ3P001982
	for <linux-wireless@vger.kernel.org>; Fri, 17 Oct 2025 04:08:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EF1qbmeFyQyWyqzjkXpojfq3u9UdcWSnsZnd7x6nRMQ=; b=hIrBQLWhlXI2+hFb
	Yfr++9gdu9hA3LLr9JBgB+obUI7iEK3+B5mIZCOSghrAq7Spm8MJmHVvunnygSAl
	dwjnrCkb7AVmD0gIqpJy6CDhQ8G1Oy2ujNmSGG+Rl5DfNMga2W3Cmo6mvCdYAssi
	Svsw6ltLLMUA7Tn5uElpaujOcIvlQcBBirB4GnJrZjsJ5+BeDWAF4rm8tDuCqBp6
	TuSFooFc1+xdjKBxQplTnDyeYLRJj2kAHUNkr7WxINB0f52E/YOmQSr43qN2yfs9
	ARL7h848ptaZsZ+I7AmnIUa42yEFYUcqoUT3Es/kox75juEC1ZKBHEC+KHCYlj5I
	tO3gUg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfa8jt6u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 17 Oct 2025 04:08:12 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-286a252bfbfso39510485ad.3
        for <linux-wireless@vger.kernel.org>; Thu, 16 Oct 2025 21:08:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760674091; x=1761278891;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EF1qbmeFyQyWyqzjkXpojfq3u9UdcWSnsZnd7x6nRMQ=;
        b=P7SIg/Rq1ZkISFYKrwSn+Za2F5p/RdQPNPvZHfGF51d787/UYJjWq0r1ClOcgnleFF
         8fgL5IhMw2C4UaSJjnXWSZvZdlcsoMAuc1KaPK2uvblP0epEPcDntxWw+ibGR6FrRXMu
         eJjNa2b4XbFPbPeDJZk3HdD3gkoAiNbYkAUiGQHf/2pL4gt8AMx5FBaHlzhbKVqUCyOG
         3ff1E4t30zz+8mQALGUAnSCTYmHweASAOxQkVNvEsR+vHVUnWxD9U1yPmYUXKiddwa2A
         I73A8ercfoGhz2nSaoEcdK/BO9O98+hMWOQ6KK4VpmeuZiNlR2ek5DYjnj+RsimkhoSi
         B1bw==
X-Gm-Message-State: AOJu0Yx8qSLTsKFyxz6/kaR6OKfKNJ0DXRwWPW/EnWeu6aCJKsx8ALTh
	grB6a3ZvOPKhTXAom/GQs+UjMpWqJATzzp5sdkBa007RqF+Av83qNQUw3C45Fwv4dalKbEMxn8m
	Y8CfRKd1vgDHKtVln2AaBSKh4ARfkHOHOdhvxlPDyc8N2hDc4HI24G2OXq+rFyPUbFHwFiNsuXW
	ADjw==
X-Gm-Gg: ASbGnct8XfdexZdgPjApAyz06LijQaTyeggtZyFjUh711OMoZfxvYuMsBGa2HUcJwfR
	4TfZzGr5zg2NGnE3JUttQJLQaKS7BEChxhFXlmWEPaKOIvlvrtoKsLeDHwMjqKlVhXV4aLNmFm7
	dVXrzc6TYqYL3M1KgcbMJl09s9IQVyAoBfL7SKEwiAz0FL/f6YfgUgWOuq7tGpawzB89Ynb5YXP
	T2LBYsTfTXL+t7c6rEK/mtqPt3mXPnGEtK65C8+jLc3k5TYDknhttVKcat5iZDNYWnbBaQaPKUj
	qMz9SGte3gaSc6Q5u4EIJJcTCiJ9tLCXId7S2jJLfl7srWdsj4kQgjOdjfrcjoaL5xMjnkpxLGd
	hVvQD/IPFPzhQvsaJhXTbx2eRBgUx6iZezlD0eWFSYLCUsz/lLse4EYgeS6cecnyw9+Uw9HOtw6
	V18Pv36DdeS5igyKP5aRRiYe0=
X-Received: by 2002:a17:903:46c7:b0:274:aab9:4ed4 with SMTP id d9443c01a7336-290cb65f861mr28662235ad.57.1760674090711;
        Thu, 16 Oct 2025 21:08:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHYZ//wDhpZNdjOOqwxCLJUlSkjpBoq4u/LLVBhCq3t3hCocjGsXJZenz8XfT/xsP0zsVXQ/Q==
X-Received: by 2002:a17:903:46c7:b0:274:aab9:4ed4 with SMTP id d9443c01a7336-290cb65f861mr28661925ad.57.1760674090279;
        Thu, 16 Oct 2025 21:08:10 -0700 (PDT)
Received: from hu-adisi-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29099a7afcbsm47635345ad.76.2025.10.16.21.08.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 21:08:09 -0700 (PDT)
From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Date: Fri, 17 Oct 2025 09:37:57 +0530
Subject: [PATCH ath-next 1/4] wifi: ath11k: relocate some Tx power related
 functions in mac.c
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251017-add_tx_power_insertion_support-v1-1-f08feacfca93@oss.qualcomm.com>
References: <20251017-add_tx_power_insertion_support-v1-0-f08feacfca93@oss.qualcomm.com>
In-Reply-To: <20251017-add_tx_power_insertion_support-v1-0-f08feacfca93@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: w2wtsSkK08Pzji8wI7Jg4k287r57D9zf
X-Proofpoint-ORIG-GUID: w2wtsSkK08Pzji8wI7Jg4k287r57D9zf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxNyBTYWx0ZWRfX0EhNBi9u7bDz
 umdpHL7RzfNsy3BNpCYakZNq3Fw1vbop8Jj6E6Vvli3tOHjckqVbz0a1Qn8OtUBn+4hXYZH1SQ4
 mb5aC6Gf4WhvY7h81JF1IuonLcy+Lnv4npbdiTXKidWYzKl39RVahP1My08On5CnQf9ayKfsyeo
 vBjz6XpBbILn60i/s+8QP/Ptum9MlYtSd3zyYHJYZgDoctirixGwvNpPeQ9tnV/U+cQIQCmiSKI
 HcjVwP84ZGNdQrSUdmaKir/bQFFnpVlOQ4TFuZ2L+AqEjwlDf1theqdPr3AK6L4D+ui18pxnjEF
 DViihsZ0mep5EG5dWDmSJZrGAjdOXQGhFy9nfHbHlykyxDQH4BeH7otKYQ/1TbMjC6HDBEY550i
 WwuVQp+oK4UELQ6ecBHZiuV59ZmZHQ==
X-Authority-Analysis: v=2.4 cv=JLw2csKb c=1 sm=1 tr=0 ts=68f1c12d cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=xoC9ZPpSTKSxfhOel_IA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-17_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110017

A forthcoming change necessitates that these functions be defined prior to
their usage. Therefore, relocate them now as a preparatory step for the
upcoming modifications.

Compile tested only.

Signed-off-by: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath11k/mac.c | 270 +++++++++++++++++-----------------
 1 file changed, 135 insertions(+), 135 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 0e41b5a91d66..a7bd0ddf5fdf 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -4028,6 +4028,141 @@ static int ath11k_start_scan(struct ath11k *ar,
 	return 0;
 }
 
+static void ath11k_mac_fw_stats_reset(struct ath11k *ar)
+{
+	spin_lock_bh(&ar->data_lock);
+	ath11k_fw_stats_pdevs_free(&ar->fw_stats.pdevs);
+	ath11k_fw_stats_vdevs_free(&ar->fw_stats.vdevs);
+	ar->fw_stats.num_vdev_recvd = 0;
+	ar->fw_stats.num_bcn_recvd = 0;
+	spin_unlock_bh(&ar->data_lock);
+}
+
+int ath11k_mac_fw_stats_request(struct ath11k *ar,
+				struct stats_request_params *req_param)
+{
+	struct ath11k_base *ab = ar->ab;
+	unsigned long time_left;
+	int ret;
+
+	lockdep_assert_held(&ar->conf_mutex);
+
+	ath11k_mac_fw_stats_reset(ar);
+
+	reinit_completion(&ar->fw_stats_complete);
+	reinit_completion(&ar->fw_stats_done);
+
+	ret = ath11k_wmi_send_stats_request_cmd(ar, req_param);
+
+	if (ret) {
+		ath11k_warn(ab, "could not request fw stats (%d)\n",
+			    ret);
+		return ret;
+	}
+
+	time_left = wait_for_completion_timeout(&ar->fw_stats_complete, 1 * HZ);
+	if (!time_left)
+		return -ETIMEDOUT;
+
+	/* FW stats can get split when exceeding the stats data buffer limit.
+	 * In that case, since there is no end marking for the back-to-back
+	 * received 'update stats' event, we keep a 3 seconds timeout in case,
+	 * fw_stats_done is not marked yet
+	 */
+	time_left = wait_for_completion_timeout(&ar->fw_stats_done, 3 * HZ);
+	if (!time_left)
+		return -ETIMEDOUT;
+
+	return 0;
+}
+
+static int ath11k_mac_get_fw_stats(struct ath11k *ar, u32 pdev_id,
+				   u32 vdev_id, u32 stats_id)
+{
+	struct ath11k_base *ab = ar->ab;
+	struct stats_request_params req_param;
+	int ret;
+
+	lockdep_assert_held(&ar->conf_mutex);
+
+	if (ar->state != ATH11K_STATE_ON)
+		return -ENETDOWN;
+
+	req_param.pdev_id = pdev_id;
+	req_param.vdev_id = vdev_id;
+	req_param.stats_id = stats_id;
+
+	ret = ath11k_mac_fw_stats_request(ar, &req_param);
+	if (ret)
+		ath11k_warn(ab, "failed to request fw stats: %d\n", ret);
+
+	ath11k_dbg(ab, ATH11K_DBG_WMI,
+		   "debug get fw stat pdev id %d vdev id %d stats id 0x%x\n",
+		   pdev_id, vdev_id, stats_id);
+
+	return ret;
+}
+
+static int ath11k_mac_op_get_txpower(struct ieee80211_hw *hw,
+				     struct ieee80211_vif *vif,
+				     unsigned int link_id,
+				     int *dbm)
+{
+	struct ath11k *ar = hw->priv;
+	struct ath11k_base *ab = ar->ab;
+	struct ath11k_fw_stats_pdev *pdev;
+	int ret;
+
+	/* Final Tx power is minimum of Target Power, CTL power, Regulatory
+	 * Power, PSD EIRP Power. We just know the Regulatory power from the
+	 * regulatory rules obtained. FW knows all these power and sets the min
+	 * of these. Hence, we request the FW pdev stats in which FW reports
+	 * the minimum of all vdev's channel Tx power.
+	 */
+	mutex_lock(&ar->conf_mutex);
+
+	/* Firmware doesn't provide Tx power during CAC hence no need to fetch
+	 * the stats.
+	 */
+	if (test_bit(ATH11K_CAC_RUNNING, &ar->dev_flags)) {
+		mutex_unlock(&ar->conf_mutex);
+		return -EAGAIN;
+	}
+
+	ret = ath11k_mac_get_fw_stats(ar, ar->pdev->pdev_id, 0,
+				      WMI_REQUEST_PDEV_STAT);
+	if (ret) {
+		ath11k_warn(ab, "failed to request fw pdev stats: %d\n", ret);
+		goto err_fallback;
+	}
+
+	spin_lock_bh(&ar->data_lock);
+	pdev = list_first_entry_or_null(&ar->fw_stats.pdevs,
+					struct ath11k_fw_stats_pdev, list);
+	if (!pdev) {
+		spin_unlock_bh(&ar->data_lock);
+		goto err_fallback;
+	}
+
+	/* tx power is set as 2 units per dBm in FW. */
+	*dbm = pdev->chan_tx_power / 2;
+
+	spin_unlock_bh(&ar->data_lock);
+	mutex_unlock(&ar->conf_mutex);
+
+	ath11k_dbg(ar->ab, ATH11K_DBG_MAC, "txpower from firmware %d, reported %d dBm\n",
+		   pdev->chan_tx_power, *dbm);
+	return 0;
+
+err_fallback:
+	mutex_unlock(&ar->conf_mutex);
+	/* We didn't get txpower from FW. Hence, relying on vif->bss_conf.txpower */
+	*dbm = vif->bss_conf.txpower;
+	ath11k_dbg(ar->ab, ATH11K_DBG_MAC, "txpower from firmware NaN, reported %d dBm\n",
+		   *dbm);
+	return 0;
+}
+
 static int ath11k_mac_op_hw_scan(struct ieee80211_hw *hw,
 				 struct ieee80211_vif *vif,
 				 struct ieee80211_scan_request *hw_req)
@@ -9079,81 +9214,6 @@ static void ath11k_mac_put_chain_rssi(struct station_info *sinfo,
 	}
 }
 
-static void ath11k_mac_fw_stats_reset(struct ath11k *ar)
-{
-	spin_lock_bh(&ar->data_lock);
-	ath11k_fw_stats_pdevs_free(&ar->fw_stats.pdevs);
-	ath11k_fw_stats_vdevs_free(&ar->fw_stats.vdevs);
-	ar->fw_stats.num_vdev_recvd = 0;
-	ar->fw_stats.num_bcn_recvd = 0;
-	spin_unlock_bh(&ar->data_lock);
-}
-
-int ath11k_mac_fw_stats_request(struct ath11k *ar,
-				struct stats_request_params *req_param)
-{
-	struct ath11k_base *ab = ar->ab;
-	unsigned long time_left;
-	int ret;
-
-	lockdep_assert_held(&ar->conf_mutex);
-
-	ath11k_mac_fw_stats_reset(ar);
-
-	reinit_completion(&ar->fw_stats_complete);
-	reinit_completion(&ar->fw_stats_done);
-
-	ret = ath11k_wmi_send_stats_request_cmd(ar, req_param);
-
-	if (ret) {
-		ath11k_warn(ab, "could not request fw stats (%d)\n",
-			    ret);
-		return ret;
-	}
-
-	time_left = wait_for_completion_timeout(&ar->fw_stats_complete, 1 * HZ);
-	if (!time_left)
-		return -ETIMEDOUT;
-
-	/* FW stats can get split when exceeding the stats data buffer limit.
-	 * In that case, since there is no end marking for the back-to-back
-	 * received 'update stats' event, we keep a 3 seconds timeout in case,
-	 * fw_stats_done is not marked yet
-	 */
-	time_left = wait_for_completion_timeout(&ar->fw_stats_done, 3 * HZ);
-	if (!time_left)
-		return -ETIMEDOUT;
-
-	return 0;
-}
-
-static int ath11k_mac_get_fw_stats(struct ath11k *ar, u32 pdev_id,
-				   u32 vdev_id, u32 stats_id)
-{
-	struct ath11k_base *ab = ar->ab;
-	struct stats_request_params req_param;
-	int ret;
-
-	lockdep_assert_held(&ar->conf_mutex);
-
-	if (ar->state != ATH11K_STATE_ON)
-		return -ENETDOWN;
-
-	req_param.pdev_id = pdev_id;
-	req_param.vdev_id = vdev_id;
-	req_param.stats_id = stats_id;
-
-	ret = ath11k_mac_fw_stats_request(ar, &req_param);
-	if (ret)
-		ath11k_warn(ab, "failed to request fw stats: %d\n", ret);
-
-	ath11k_dbg(ab, ATH11K_DBG_WMI,
-		   "debug get fw stat pdev id %d vdev id %d stats id 0x%x\n",
-		   pdev_id, vdev_id, stats_id);
-
-	return ret;
-}
-
 static void ath11k_mac_op_sta_statistics(struct ieee80211_hw *hw,
 					 struct ieee80211_vif *vif,
 					 struct ieee80211_sta *sta,
@@ -9539,66 +9599,6 @@ static int ath11k_mac_op_remain_on_channel(struct ieee80211_hw *hw,
 	return ret;
 }
 
-static int ath11k_mac_op_get_txpower(struct ieee80211_hw *hw,
-				     struct ieee80211_vif *vif,
-				     unsigned int link_id,
-				     int *dbm)
-{
-	struct ath11k *ar = hw->priv;
-	struct ath11k_base *ab = ar->ab;
-	struct ath11k_fw_stats_pdev *pdev;
-	int ret;
-
-	/* Final Tx power is minimum of Target Power, CTL power, Regulatory
-	 * Power, PSD EIRP Power. We just know the Regulatory power from the
-	 * regulatory rules obtained. FW knows all these power and sets the min
-	 * of these. Hence, we request the FW pdev stats in which FW reports
-	 * the minimum of all vdev's channel Tx power.
-	 */
-	mutex_lock(&ar->conf_mutex);
-
-	/* Firmware doesn't provide Tx power during CAC hence no need to fetch
-	 * the stats.
-	 */
-	if (test_bit(ATH11K_CAC_RUNNING, &ar->dev_flags)) {
-		mutex_unlock(&ar->conf_mutex);
-		return -EAGAIN;
-	}
-
-	ret = ath11k_mac_get_fw_stats(ar, ar->pdev->pdev_id, 0,
-				      WMI_REQUEST_PDEV_STAT);
-	if (ret) {
-		ath11k_warn(ab, "failed to request fw pdev stats: %d\n", ret);
-		goto err_fallback;
-	}
-
-	spin_lock_bh(&ar->data_lock);
-	pdev = list_first_entry_or_null(&ar->fw_stats.pdevs,
-					struct ath11k_fw_stats_pdev, list);
-	if (!pdev) {
-		spin_unlock_bh(&ar->data_lock);
-		goto err_fallback;
-	}
-
-	/* tx power is set as 2 units per dBm in FW. */
-	*dbm = pdev->chan_tx_power / 2;
-
-	spin_unlock_bh(&ar->data_lock);
-	mutex_unlock(&ar->conf_mutex);
-
-	ath11k_dbg(ar->ab, ATH11K_DBG_MAC, "txpower from firmware %d, reported %d dBm\n",
-		   pdev->chan_tx_power, *dbm);
-	return 0;
-
-err_fallback:
-	mutex_unlock(&ar->conf_mutex);
-	/* We didn't get txpower from FW. Hence, relying on vif->bss_conf.txpower */
-	*dbm = vif->bss_conf.txpower;
-	ath11k_dbg(ar->ab, ATH11K_DBG_MAC, "txpower from firmware NaN, reported %d dBm\n",
-		   *dbm);
-	return 0;
-}
-
 static int ath11k_mac_station_add(struct ath11k *ar,
 				  struct ieee80211_vif *vif,
 				  struct ieee80211_sta *sta)

-- 
2.34.1


