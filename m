Return-Path: <linux-wireless+bounces-16504-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E746B9F57AD
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Dec 2024 21:27:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FD3716F1D8
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Dec 2024 20:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 057BC1F9433;
	Tue, 17 Dec 2024 20:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UnVRgpu5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59EA1F9EAD
	for <linux-wireless@vger.kernel.org>; Tue, 17 Dec 2024 20:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734467181; cv=none; b=O1ibFVmjilRW1zmOQNBXYkfcQdrAQ4MnBcy5J2nauLybRJN9l2MTNeQXlf7PLLFEYxqFTQYXZokeZdfmJ+Bk69RY8k8knn4LZorTdDYIKtsoO/mrjRTIeKJbr2JXqlZfAG/DyFgsKHcgaclgWR5gOP2y7KLkAs1Fg871Zs6z1WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734467181; c=relaxed/simple;
	bh=oHhMU+EKio682SB2+Dh1hNm9yIecNFwww1aqgC/Qv50=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Gi6cuhcxch6FVG61HDwHaFhjPzsTHCJPkoMLbk72EvucIj41OrN50qRDv+d9bJOB6zLOoVzMTIGIut1nkhyNZmjgprQMYhXlDlcg+GabUEqDLC5CA7l+bdTHlfoPF6pEUmLOleaGuohyThl/fh5hc6oB75AWpesnoDEKGTR+l+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UnVRgpu5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC24CC4CEDD;
	Tue, 17 Dec 2024 20:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734467181;
	bh=oHhMU+EKio682SB2+Dh1hNm9yIecNFwww1aqgC/Qv50=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UnVRgpu5leLLhjvxgOkwrCuxsBcwxrb/MwHGZeGFnOSoQBJpLRN4mdKl8a9ZV7Gtb
	 s8A8Pl7NMtZCEe/qdPdtIBzP5DfkIbLl1n6dM6PCbad7QiGtz1ZMKphIqo4qgLZ1v8
	 ONc3S67ROBtiVKPsBAoRdamlUIs+O0S9MWnkBeopvikQCQrhRtdJiFdBGJQnhXbigD
	 jfq4gl1PmREURcxOuASqmIpl5pZQmxNGnnIffmw0sqfRreMIFXYw3gU6Od93Vgah4p
	 hB18k/6jZpuBve56SeTvISE9fYI2EwFw1BumrrgmX0aYvds16eXJ4d18uQAzTMWRpH
	 hWTnTKXRdJ80A==
From: Kalle Valo <kvalo@kernel.org>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 1/4] wifi: ath12k: Decrease ath12k_mac_op_remain_on_channel() stack usage
Date: Tue, 17 Dec 2024 22:26:15 +0200
Message-Id: <20241217202618.1329312-2-kvalo@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241217202618.1329312-1-kvalo@kernel.org>
References: <20241217202618.1329312-1-kvalo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Johnson <quic_jjohnson@quicinc.com>

Building the ath12k driver with llvm-18.1.7-x86_64 produces the warning:

drivers/net/wireless/ath/ath12k/mac.c:10028:12: warning: stack frame size (1080) exceeds limit (1024) in 'ath12k_mac_op_remain_on_channel' [-Wframe-larger-than]

A major contributor to the stack usage in this function is:

	struct ath12k_wmi_scan_req_arg arg;

Avoid the excess stack usage by dynamically allocating arg instead of
declaring it on the stack. As part of the effort use __free() for both
this new allocation as well as the existing chan_list allocation, and
since then no central cleanup is required, replace all cleanup gotos
with returns.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 76 ++++++++++++---------------
 1 file changed, 33 insertions(+), 43 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 186765fa95f5..05d2c75e5df2 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -10054,7 +10054,6 @@ static int ath12k_mac_op_remain_on_channel(struct ieee80211_hw *hw,
 {
 	struct ath12k_vif *ahvif = ath12k_vif_to_ahvif(vif);
 	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
-	struct ath12k_wmi_scan_req_arg arg;
 	struct ath12k_link_vif *arvif;
 	struct ath12k *ar;
 	u32 scan_time_msec;
@@ -10065,10 +10064,8 @@ static int ath12k_mac_op_remain_on_channel(struct ieee80211_hw *hw,
 	lockdep_assert_wiphy(hw->wiphy);
 
 	ar = ath12k_mac_select_scan_device(hw, vif, chan->center_freq);
-	if (!ar) {
-		ret = -EINVAL;
-		goto exit;
-	}
+	if (!ar)
+		return -EINVAL;
 
 	/* check if any of the links of ML VIF is already started on
 	 * radio(ar) correpsondig to given scan frequency and use it,
@@ -10087,15 +10084,11 @@ static int ath12k_mac_op_remain_on_channel(struct ieee80211_hw *hw,
 	 * always on the same band for the vif
 	 */
 	if (arvif->is_created) {
-		if (WARN_ON(!arvif->ar)) {
-			ret = -EINVAL;
-			goto exit;
-		}
+		if (WARN_ON(!arvif->ar))
+			return -EINVAL;
 
-		if (ar != arvif->ar && arvif->is_started) {
-			ret = -EBUSY;
-			goto exit;
-		}
+		if (ar != arvif->ar && arvif->is_started)
+			return -EBUSY;
 
 		if (ar != arvif->ar) {
 			ath12k_mac_remove_link_interface(hw, arvif);
@@ -10112,7 +10105,7 @@ static int ath12k_mac_op_remain_on_channel(struct ieee80211_hw *hw,
 		if (ret) {
 			ath12k_warn(ar->ab, "unable to create scan vdev for roc: %d\n",
 				    ret);
-			goto exit;
+			return ret;
 		}
 	}
 
@@ -10140,37 +10133,41 @@ static int ath12k_mac_op_remain_on_channel(struct ieee80211_hw *hw,
 	spin_unlock_bh(&ar->data_lock);
 
 	if (ret)
-		goto exit;
+		return ret;
 
 	scan_time_msec = hw->wiphy->max_remain_on_channel_duration * 2;
 
-	memset(&arg, 0, sizeof(arg));
-	ath12k_wmi_start_scan_init(ar, &arg);
-	arg.num_chan = 1;
-	arg.chan_list = kcalloc(arg.num_chan, sizeof(*arg.chan_list),
-				GFP_KERNEL);
-	if (!arg.chan_list) {
-		ret = -ENOMEM;
-		goto exit;
-	}
+	struct ath12k_wmi_scan_req_arg *arg __free(kfree) =
+					kzalloc(sizeof(*arg), GFP_KERNEL);
+	if (!arg)
+		return -ENOMEM;
 
-	arg.vdev_id = arvif->vdev_id;
-	arg.scan_id = ATH12K_SCAN_ID;
-	arg.chan_list[0] = chan->center_freq;
-	arg.dwell_time_active = scan_time_msec;
-	arg.dwell_time_passive = scan_time_msec;
-	arg.max_scan_time = scan_time_msec;
-	arg.scan_f_passive = 1;
-	arg.burst_duration = duration;
+	ath12k_wmi_start_scan_init(ar, arg);
+	arg->num_chan = 1;
 
-	ret = ath12k_start_scan(ar, &arg);
+	u32 *chan_list __free(kfree) = kcalloc(arg->num_chan, sizeof(*chan_list),
+					       GFP_KERNEL);
+	if (!chan_list)
+		return -ENOMEM;
+
+	arg->chan_list = chan_list;
+	arg->vdev_id = arvif->vdev_id;
+	arg->scan_id = ATH12K_SCAN_ID;
+	arg->chan_list[0] = chan->center_freq;
+	arg->dwell_time_active = scan_time_msec;
+	arg->dwell_time_passive = scan_time_msec;
+	arg->max_scan_time = scan_time_msec;
+	arg->scan_f_passive = 1;
+	arg->burst_duration = duration;
+
+	ret = ath12k_start_scan(ar, arg);
 	if (ret) {
 		ath12k_warn(ar->ab, "failed to start roc scan: %d\n", ret);
 
 		spin_lock_bh(&ar->data_lock);
 		ar->scan.state = ATH12K_SCAN_IDLE;
 		spin_unlock_bh(&ar->data_lock);
-		goto free_chan_list;
+		return ret;
 	}
 
 	ret = wait_for_completion_timeout(&ar->scan.on_channel, 3 * HZ);
@@ -10179,20 +10176,13 @@ static int ath12k_mac_op_remain_on_channel(struct ieee80211_hw *hw,
 		ret = ath12k_scan_stop(ar);
 		if (ret)
 			ath12k_warn(ar->ab, "failed to stop scan: %d\n", ret);
-		ret = -ETIMEDOUT;
-		goto free_chan_list;
+		return -ETIMEDOUT;
 	}
 
 	ieee80211_queue_delayed_work(hw, &ar->scan.timeout,
 				     msecs_to_jiffies(duration));
 
-	ret = 0;
-
-free_chan_list:
-	kfree(arg.chan_list);
-
-exit:
-	return ret;
+	return 0;
 }
 
 static void ath12k_mac_op_set_rekey_data(struct ieee80211_hw *hw,
-- 
2.39.5


