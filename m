Return-Path: <linux-wireless+bounces-28503-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02032C2B4BC
	for <lists+linux-wireless@lfdr.de>; Mon, 03 Nov 2025 12:23:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6C383B06C3
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Nov 2025 11:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BEC12FF678;
	Mon,  3 Nov 2025 11:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Ay1evVXR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49ADC3019D6
	for <linux-wireless@vger.kernel.org>; Mon,  3 Nov 2025 11:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762168923; cv=none; b=ih79xcYS1JKMoONV4debM1KKXuOu6I7z35xWPGPZ3AjJh4p+1ZSz/2EjpfiV/aJrpGZ409HffA2sSqjskgC3wV60pvGvInHn+QtyN9o0/1JJWMfwmBEvqkBuSYCi70INwGneXttD3MmtZAzXjNTJHxOGCnZbnm/OkubAeYtW6lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762168923; c=relaxed/simple;
	bh=H/cYEs5sh6pLuWYHfAvaIvZEolwE1xtQXjjdGquz8A8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b0U/zL16gUXdYVvOePY503Doff4HANLz49HHAGE1CobB9SOTuwC4XsU576vSGEb3AOdR+B/6eoWP2S/+5EPVQPu2Xg1UHUQjYztYwEPribshqOQdS8/xHFCQkDD4LkJsnRMVQFVUpf2QxslkayTiCKhSSeXkfaesM1dxD40Ago4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Ay1evVXR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A38OCN61108817;
	Mon, 3 Nov 2025 11:21:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wgri3PEG9OBxX7AfSLEUO6OGncle5ZvcdyUB/D0XnM0=; b=Ay1evVXRsI4nD8yd
	NtOMukdPHOMri24TwCFyrwEusHRp7tU/hEOqkNrQy7KoMbgT5qiVwWFMkp/iHMLS
	FrgOUvuG1xycTmHs/Q8DGS8W8G9TYpAvzSLjds8+5hirMYhksi7aWKaaYf7gWM/H
	MXtThLtU4mN0NlvvzcVxFR61QgJXrYGRI7kuZExnDknfa5VNu6oUZ7fLQW64L1tn
	wvf12zy4eglYWt9s5wylqjEFKBf9Jj3e9DHiiL0b7A2YzzODp9nqidDT9dEhcdZJ
	u487UuC257hsEgYc95XaxUTVM6OUNj1/wVZDMX8MrDyX4cr1Ypn6aFjxHXNH5CvL
	26eIew==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a5ak8me2x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Nov 2025 11:21:56 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5A3BLtkf005223
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 3 Nov 2025 11:21:55 GMT
Received: from hu-rdeuri-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Mon, 3 Nov 2025 03:21:54 -0800
From: Ripan Deuri <quic_rdeuri@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH ath12k-ng 12/12] wifi: ath12k: Replace lock/unlock with guard()
Date: Mon, 3 Nov 2025 16:51:11 +0530
Message-ID: <20251103112111.2260639-13-quic_rdeuri@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251103112111.2260639-1-quic_rdeuri@quicinc.com>
References: <20251103112111.2260639-1-quic_rdeuri@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: YfqJqtj_uNmuMCZhmAXO6JdikQctTTVE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAzMDEwMyBTYWx0ZWRfX7NGU5DKedeKW
 FMCPLWEaWkzdiIYDddUo5qhijhjOSl/SHXm9xV8zDhGQAHBfY19zBlbfF+j8RJlwFkNrtkggKk6
 pyesJh+QNKIZ6n5lbg0yTFIWj+nZ6rlT58Rm8Gx3OSqgL2NXQk+m3i57E1Rl/IZaxbyXQaIw7Yn
 3F1WO5tFBEbJrCWAEBd3BMgQu0Ns4t1vMVQMS3cTUK+cNjSXhtU+cLvNj2MSyNHVNDiryLrJiGp
 Bf+pIfjZ7+EELocrmS2aVgLb/sHz90/LJjh4Bisq8YZjyYS6hlb8C7nq6WocbLIyPRFbaxSdsG1
 05ZKVg9mgm/o4WkbuUJuQdhB+He6Y2hrnqOwbNfS5ZQVBin/ApakYOvBaTTtyCFDBOTMcUg30PN
 MZkGt2BLIYU7RV5THjdnBRsvowpUDw==
X-Authority-Analysis: v=2.4 cv=ZZEQ98VA c=1 sm=1 tr=0 ts=69089055 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=COk6AnOGAAAA:8 a=vRo11cHgEgMZMzEvRbsA:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: YfqJqtj_uNmuMCZhmAXO6JdikQctTTVE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_01,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 adultscore=0 bulkscore=0 impostorscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511030103

Use guard(wiphy)(...) and guard(spinlock_bh)(...) in:

ath12k_dbg_sta_dump_rx_stats()
ath12k_mac_op_link_sta_statistics()

The guard() API ensures locks are automatically released when the scope
exits, reducing the risk of missing unlocks in error paths and improving
code readability.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Ripan Deuri <quic_rdeuri@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/debugfs_sta.c | 36 ++++++-------------
 drivers/net/wireless/ath/ath12k/mac.c         |  7 ++--
 2 files changed, 13 insertions(+), 30 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/debugfs_sta.c b/drivers/net/wireless/ath/ath12k/debugfs_sta.c
index dde3efed4b60..585c40bd2951 100644
--- a/drivers/net/wireless/ath/ath12k/debugfs_sta.c
+++ b/drivers/net/wireless/ath/ath12k/debugfs_sta.c
@@ -153,41 +153,32 @@ static ssize_t ath12k_dbg_sta_dump_rx_stats(struct file *file,
 	bool he_rates_avail;
 	struct ath12k *ar;
 
-	wiphy_lock(ah->hw->wiphy);
+	guard(wiphy)(ah->hw->wiphy);
 
-	if (!(BIT(link_id) & ahsta->links_map)) {
-		wiphy_unlock(ah->hw->wiphy);
+	if (!(BIT(link_id) & ahsta->links_map))
 		return -ENOENT;
-	}
 
 	arsta = wiphy_dereference(ah->hw->wiphy, ahsta->link[link_id]);
-	if (!arsta || !arsta->arvif->ar) {
-		wiphy_unlock(ah->hw->wiphy);
+	if (!arsta || !arsta->arvif->ar)
 		return -ENOENT;
-	}
 
 	ar = arsta->arvif->ar;
 
 	u8 *buf __free(kfree) = kzalloc(size, GFP_KERNEL);
-	if (!buf) {
-		ret = -ENOENT;
-		goto out;
-	}
+	if (!buf)
+		return -ENOMEM;
 
 	dp = ath12k_ab_to_dp(ar->ab);
-	spin_lock_bh(&dp->dp_lock);
+
+	guard(spinlock_bh)(&dp->dp_lock);
 
 	link_peer = ath12k_dp_link_peer_find_by_addr(dp, arsta->addr);
-	if (!link_peer) {
-		ret = -ENOENT;
-		goto unlock;
-	}
+	if (!link_peer)
+		return -ENOENT;
 
 	rx_stats = link_peer->peer_stats.rx_stats;
-	if (!rx_stats) {
-		ret = -ENOENT;
-		goto unlock;
-	}
+	if (!rx_stats)
+		return -ENOENT;
 
 	len += scnprintf(buf + len, size - len, "RX peer stats:\n\n");
 	len += scnprintf(buf + len, size - len, "Num of MSDUs: %llu\n",
@@ -247,13 +238,8 @@ static ssize_t ath12k_dbg_sta_dump_rx_stats(struct file *file,
 	len += ath12k_dbg_sta_dump_rate_stats(buf, len, size, he_rates_avail,
 					      &rx_stats->byte_stats);
 
-unlock:
-	spin_unlock_bh(&dp->dp_lock);
-
 	if (len)
 		ret = simple_read_from_buffer(user_buf, count, ppos, buf, len);
-out:
-	wiphy_unlock(ah->hw->wiphy);
 	return ret;
 }
 
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 4647c555cb48..aa80afebb69e 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -12792,12 +12792,10 @@ void ath12k_mac_op_link_sta_statistics(struct ieee80211_hw *hw,
 	db2dbm = test_bit(WMI_TLV_SERVICE_HW_DB2DBM_CONVERSION_SUPPORT,
 			  ar->ab->wmi_ab.svc_map);
 
-	spin_lock_bh(&ar->ab->dp->dp_lock);
+	guard(spinlock_bh)(&ar->ab->dp->dp_lock);
 	peer = ath12k_dp_link_peer_find_by_addr(ar->ab->dp, arsta->addr);
-	if (!peer) {
-		spin_unlock_bh(&ar->ab->dp->dp_lock);
+	if (!peer)
 		return;
-	}
 
 	link_sinfo->rx_duration = peer->rx_duration;
 	link_sinfo->filled |= BIT_ULL(NL80211_STA_INFO_RX_DURATION);
@@ -12853,7 +12851,6 @@ void ath12k_mac_op_link_sta_statistics(struct ieee80211_hw *hw,
 	link_sinfo->tx_failed = peer->tx_retry_failed;
 	link_sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_RETRIES);
 	link_sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_FAILED);
-	spin_unlock_bh(&ar->ab->dp->dp_lock);
 }
 EXPORT_SYMBOL(ath12k_mac_op_link_sta_statistics);
 
-- 
2.34.1


