Return-Path: <linux-wireless+bounces-16068-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B90D9E9A9C
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 16:31:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65767162404
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 15:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 836781F2C29;
	Mon,  9 Dec 2024 15:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SLDuPEMU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AEAF1C5CD1;
	Mon,  9 Dec 2024 15:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733758246; cv=none; b=ezy8ksxtp/H4RA/WVgoa8ZNJSypi54t1VCemvZlaQS9ohDXsfWVgkXvuYrRMNwtnlr/EZNdEomYXuAKp80sRpMBHMSt9AMqWdao5rdzb3nnW4mwFYy+aoo5bSaEtm5BtUgUGTJ+p3OaFdHnKEbYIm8gBgp8+lfgG8I3bI4Gy0jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733758246; c=relaxed/simple;
	bh=d0QZughSZQWEuh5lk2IPYSI2BmSOFSPhXvF7DYFzblM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=abZCZWibdK9+NigzFwFl5OX1cRRe7IUiRlloocKRRsTPLMc+7L/SFIi+9VM0JMmHJfXZX69THErg/KjdKsLmpFQs2ixpd3K8IhdFnGZKvHbzoMC9ffVWgWV4uhOvHKXqdIiVCziYe1KGtqCIe0dOoJth92upTQCyaoXsndZy+TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SLDuPEMU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73011C4CED1;
	Mon,  9 Dec 2024 15:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733758246;
	bh=d0QZughSZQWEuh5lk2IPYSI2BmSOFSPhXvF7DYFzblM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SLDuPEMUDM2qn+o16LPVytwLxZ/byju9vw7WA1PxfK+K4wLMmWci0qSD+5cp3ESku
	 fIMtJhYnyJzDM5SMI5Y2xRr87Pxhc4rvCYnq01n+tBenyN6pHd9fca/RQeMqyka3z/
	 zorWrTpC+IS3sH8B51wnOzz+LKIIJwewb0z+8DXN9SYCOwCyLeh6bIvi/0LIKmcUB8
	 Gt4K65G09SLgea9CZjAMJY9qsV83ES+42UJ0ZN6A4s/H4RXQrcGsfy5HMKyoLazsvg
	 nCRtoninn8kHFwIosl8w3RKYSNvf7wDCKW4x1YIjAcDsD3uB8tFdHvbeVEhv4K8Gkw
	 YbKnXAZukP/9w==
From: Kalle Valo <kvalo@kernel.org>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v2 7/8] wifi: ath12k: enable MLO setup and teardown from core
Date: Mon,  9 Dec 2024 17:30:33 +0200
Message-Id: <20241209153034.50558-8-kvalo@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241209153034.50558-1-kvalo@kernel.org>
References: <20241209153034.50558-1-kvalo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>

In case of multi device group abstraction, host has to exchange the multi-link
operation commands such as setup and ready to firmware before registering the
device group to mac80211.

The multi-link operation commands - setup, ready and teardown are necessary for
many commands such as WMI_PEER_ASSOC_CMD, WMI_BCN_TMPL_CMD in case of
multi-link interfaces.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Signed-off-by: Harshitha Prem <quic_hprem@quicinc.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.c |  73 ++++++++++++-
 drivers/net/wireless/ath/ath12k/core.h |   3 +
 drivers/net/wireless/ath/ath12k/mac.c  | 142 +++++++++++++++++++++++++
 drivers/net/wireless/ath/ath12k/mac.h  |   3 +
 drivers/net/wireless/ath/ath12k/wmi.c  |   3 +
 drivers/net/wireless/ath/ath12k/wmi.h  |   1 +
 6 files changed, 224 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index 1a43e00cffb2..af642b466ea0 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -887,6 +887,70 @@ static void ath12k_core_hw_group_stop(struct ath12k_hw_group *ag)
 	ath12k_mac_destroy(ag);
 }
 
+static int __ath12k_mac_mlo_ready(struct ath12k *ar)
+{
+	int ret;
+
+	ret = ath12k_wmi_mlo_ready(ar);
+	if (ret) {
+		ath12k_err(ar->ab, "MLO ready failed for pdev %d: %d\n",
+			   ar->pdev_idx, ret);
+		return ret;
+	}
+
+	ath12k_dbg(ar->ab, ATH12K_DBG_MAC, "mlo ready done for pdev %d\n",
+		   ar->pdev_idx);
+
+	return 0;
+}
+
+int ath12k_mac_mlo_ready(struct ath12k_hw_group *ag)
+{
+	struct ath12k_hw *ah;
+	struct ath12k *ar;
+	int ret;
+	int i, j;
+
+	for (i = 0; i < ag->num_hw; i++) {
+		ah = ag->ah[i];
+		if (!ah)
+			continue;
+
+		for_each_ar(ah, ar, j) {
+			ar = &ah->radio[j];
+			ret = __ath12k_mac_mlo_ready(ar);
+			if (ret)
+				goto out;
+		}
+	}
+
+out:
+	return ret;
+}
+
+static int ath12k_core_mlo_setup(struct ath12k_hw_group *ag)
+{
+	int ret;
+
+	if (!ag->mlo_capable || ag->num_devices == 1)
+		return 0;
+
+	ret = ath12k_mac_mlo_setup(ag);
+	if (ret)
+		return ret;
+
+	ret = ath12k_mac_mlo_ready(ag);
+	if (ret)
+		goto err_mlo_teardown;
+
+	return 0;
+
+err_mlo_teardown:
+	ath12k_mac_mlo_teardown(ag);
+
+	return ret;
+}
+
 static int ath12k_core_hw_group_start(struct ath12k_hw_group *ag)
 {
 	struct ath12k_base *ab;
@@ -901,10 +965,14 @@ static int ath12k_core_hw_group_start(struct ath12k_hw_group *ag)
 	if (WARN_ON(ret))
 		return ret;
 
-	ret = ath12k_mac_register(ag);
+	ret = ath12k_core_mlo_setup(ag);
 	if (WARN_ON(ret))
 		goto err_mac_destroy;
 
+	ret = ath12k_mac_register(ag);
+	if (WARN_ON(ret))
+		goto err_mlo_teardown;
+
 	set_bit(ATH12K_GROUP_FLAG_REGISTERED, &ag->flags);
 
 core_pdev_create:
@@ -939,6 +1007,9 @@ static int ath12k_core_hw_group_start(struct ath12k_hw_group *ag)
 	ath12k_core_hw_group_stop(ag);
 	return ret;
 
+err_mlo_teardown:
+	ath12k_mac_mlo_teardown(ag);
+
 err_mac_destroy:
 	ath12k_mac_destroy(ag);
 
diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index bf310df3d8f7..dc01f7b3fd73 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -715,6 +715,9 @@ struct ath12k {
 	u32 freq_high;
 
 	bool nlo_enabled;
+
+	struct completion mlo_setup_done;
+	u32 mlo_setup_status;
 };
 
 struct ath12k_hw {
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index c4eab4c1c10e..23c5c8fd952d 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -10810,6 +10810,7 @@ static void ath12k_mac_setup(struct ath12k *ar)
 	init_completion(&ar->scan.started);
 	init_completion(&ar->scan.completed);
 	init_completion(&ar->scan.on_channel);
+	init_completion(&ar->mlo_setup_done);
 
 	INIT_DELAYED_WORK(&ar->scan.timeout, ath12k_scan_timeout_work);
 	INIT_WORK(&ar->regd_update_work, ath12k_regd_update_work);
@@ -10818,6 +10819,147 @@ static void ath12k_mac_setup(struct ath12k *ar)
 	skb_queue_head_init(&ar->wmi_mgmt_tx_queue);
 }
 
+static int __ath12k_mac_mlo_setup(struct ath12k *ar)
+{
+	u8 num_link = 0, partner_link_id[ATH12K_GROUP_MAX_RADIO] = {};
+	struct ath12k_base *partner_ab, *ab = ar->ab;
+	struct ath12k_hw_group *ag = ab->ag;
+	struct wmi_mlo_setup_arg mlo = {};
+	struct ath12k_pdev *pdev;
+	unsigned long time_left;
+	int i, j, ret;
+
+	lockdep_assert_held(&ag->mutex);
+
+	reinit_completion(&ar->mlo_setup_done);
+
+	for (i = 0; i < ag->num_devices; i++) {
+		partner_ab = ag->ab[i];
+
+		for (j = 0; j < partner_ab->num_radios; j++) {
+			pdev = &partner_ab->pdevs[j];
+
+			/* Avoid the self link */
+			if (ar == pdev->ar)
+				continue;
+
+			partner_link_id[num_link] = pdev->hw_link_id;
+			num_link++;
+
+			ath12k_dbg(ab, ATH12K_DBG_MAC, "device %d pdev %d hw_link_id %d num_link %d\n",
+				   i, j, pdev->hw_link_id, num_link);
+		}
+	}
+
+	mlo.group_id = cpu_to_le32(ag->id);
+	mlo.partner_link_id = partner_link_id;
+	mlo.num_partner_links = num_link;
+	ar->mlo_setup_status = 0;
+
+	ath12k_dbg(ab, ATH12K_DBG_MAC, "group id %d num_link %d\n", ag->id, num_link);
+
+	ret = ath12k_wmi_mlo_setup(ar, &mlo);
+	if (ret) {
+		ath12k_err(ab, "failed to send  setup MLO WMI command for pdev %d: %d\n",
+			   ar->pdev_idx, ret);
+		return ret;
+	}
+
+	time_left = wait_for_completion_timeout(&ar->mlo_setup_done,
+						WMI_MLO_CMD_TIMEOUT_HZ);
+
+	if (!time_left || ar->mlo_setup_status)
+		return ar->mlo_setup_status ? : -ETIMEDOUT;
+
+	ath12k_dbg(ab, ATH12K_DBG_MAC, "mlo setup done for pdev %d\n", ar->pdev_idx);
+
+	return 0;
+}
+
+static int __ath12k_mac_mlo_teardown(struct ath12k *ar)
+{
+	struct ath12k_base *ab = ar->ab;
+	int ret;
+
+	if (test_bit(ATH12K_FLAG_RECOVERY, &ab->dev_flags))
+		return 0;
+
+	ret = ath12k_wmi_mlo_teardown(ar);
+	if (ret) {
+		ath12k_warn(ab, "failed to send MLO teardown WMI command for pdev %d: %d\n",
+			    ar->pdev_idx, ret);
+		return ret;
+	}
+
+	ath12k_dbg(ab, ATH12K_DBG_MAC, "mlo teardown for pdev %d\n", ar->pdev_idx);
+
+	return 0;
+}
+
+int ath12k_mac_mlo_setup(struct ath12k_hw_group *ag)
+{
+	struct ath12k_hw *ah;
+	struct ath12k *ar;
+	int ret;
+	int i, j;
+
+	for (i = 0; i < ag->num_hw; i++) {
+		ah = ag->ah[i];
+		if (!ah)
+			continue;
+
+		for_each_ar(ah, ar, j) {
+			ar = &ah->radio[j];
+			ret = __ath12k_mac_mlo_setup(ar);
+			if (ret) {
+				ath12k_err(ar->ab, "failed to setup MLO: %d\n", ret);
+				goto err_setup;
+			}
+		}
+	}
+
+	return 0;
+
+err_setup:
+	for (i = i - 1; i >= 0; i--) {
+		ah = ag->ah[i];
+		if (!ah)
+			continue;
+
+		for (j = j - 1; j >= 0; j--) {
+			ar = &ah->radio[j];
+			if (!ar)
+				continue;
+
+			__ath12k_mac_mlo_teardown(ar);
+		}
+	}
+
+	return ret;
+}
+
+void ath12k_mac_mlo_teardown(struct ath12k_hw_group *ag)
+{
+	struct ath12k_hw *ah;
+	struct ath12k *ar;
+	int ret, i, j;
+
+	for (i = 0; i < ag->num_hw; i++) {
+		ah = ag->ah[i];
+		if (!ah)
+			continue;
+
+		for_each_ar(ah, ar, j) {
+			ar = &ah->radio[j];
+			ret = __ath12k_mac_mlo_teardown(ar);
+			if (ret) {
+				ath12k_err(ar->ab, "failed to teardown MLO: %d\n", ret);
+				break;
+			}
+		}
+	}
+}
+
 int ath12k_mac_register(struct ath12k_hw_group *ag)
 {
 	struct ath12k_base *ab = ag->ab[0];
diff --git a/drivers/net/wireless/ath/ath12k/mac.h b/drivers/net/wireless/ath/ath12k/mac.h
index ccfc215d83ff..81cfb950e6cd 100644
--- a/drivers/net/wireless/ath/ath12k/mac.h
+++ b/drivers/net/wireless/ath/ath12k/mac.h
@@ -96,6 +96,9 @@ int ath12k_mac_vif_set_keepalive(struct ath12k_link_vif *arvif,
 				 enum wmi_sta_keepalive_method method,
 				 u32 interval);
 u8 ath12k_mac_get_target_pdev_id(struct ath12k *ar);
+int ath12k_mac_mlo_setup(struct ath12k_hw_group *ag);
+int ath12k_mac_mlo_ready(struct ath12k_hw_group *ag);
+void ath12k_mac_mlo_teardown(struct ath12k_hw_group *ag);
 int ath12k_mac_vdev_stop(struct ath12k_link_vif *arvif);
 
 #endif
diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index 8f4b0941360d..10a6ba926343 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -7369,6 +7369,9 @@ static void ath12k_wmi_event_mlo_setup_complete(struct ath12k_base *ab,
 		goto out;
 	}
 
+	ar->mlo_setup_status = le32_to_cpu(ev->status);
+	complete(&ar->mlo_setup_done);
+
 out:
 	kfree(tb);
 }
diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
index 640720b68782..270ed458302e 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -4938,6 +4938,7 @@ struct wmi_probe_tmpl_cmd {
 
 #define MAX_RADIOS 2
 
+#define WMI_MLO_CMD_TIMEOUT_HZ (5 * HZ)
 #define WMI_SERVICE_READY_TIMEOUT_HZ (5 * HZ)
 #define WMI_SEND_TIMEOUT_HZ (3 * HZ)
 
-- 
2.39.5


