Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBF971F4E6D
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jun 2020 08:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbgFJGv0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 10 Jun 2020 02:51:26 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:60671 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726081AbgFJGv0 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 10 Jun 2020 02:51:26 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1591771885; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=bnrS7RQKDQ4zgUN4grcn44Ln/d7BCGaiybY1n+Sq1wA=; b=kODfPwPRiG1Up1L2rfibkJ27cNEYb4LqUfZjiX53t75VO76LF0LAvi2LLATXDJV7UY/dI+5P
 ttZxRhHwRGOiCtQn7435qvXCeONYufoeKVwrl7U3RzqGAQn8FpKexJ9EOjTDlb9zVKPYq9GP
 Ri8wLC6S6QQyLOOfxceJqKMW1W8=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n15.prod.us-west-2.postgun.com with SMTP id
 5ee082ce6bebe35deb20315d (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 10 Jun 2020 06:50:54
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 7AC8DC43387; Wed, 10 Jun 2020 06:50:54 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vnaralas-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vnaralas)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9BD72C433C6;
        Wed, 10 Jun 2020 06:50:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9BD72C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=vnaralas@codeaurora.org
From:   Venkateswara Naralasetty <vnaralas@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Venkateswara Naralasetty <vnaralas@codeaurora.org>
Subject: [PATCH] ath11k: fix wmi peer flags in peer assoc command
Date:   Wed, 10 Jun 2020 12:20:41 +0530
Message-Id: <1591771841-25503-1-git-send-email-vnaralas@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Currently need ptk/gtk wmi peer flags in wmi peer assoc cmd
are set based on the rsnie and wpaie of the bss from the bss list.
Since this bss list is not updated with current BSSID for AP mode,
we may not find bss from the bss list. Which results in ptk/gtk peer
flags are not set in the wmi peer assoc cmd. Due to this EAPOL frames
are going in data rates instead of management rates.

Tested-on: IPQ8074 WLAN.HK.2.1.0.1-01228-QCAHKSWPL_SILICONZ-1

Signed-off-by: Venkateswara Naralasetty <vnaralas@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/core.h |  2 ++
 drivers/net/wireless/ath/ath11k/mac.c  | 21 ++++++++++++++++++++-
 drivers/net/wireless/ath/ath11k/wmi.c  |  6 +++---
 3 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index e04f0e7..bcc223d 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -221,6 +221,8 @@ struct ath11k_vif {
 	int num_legacy_stations;
 	int rtscts_prot_mode;
 	int txpower;
+	bool rsnie_present;
+	bool wpaie_present;
 };
 
 struct ath11k_vif_iter {
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 2836a0f..195b45e 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -698,6 +698,8 @@ static int ath11k_mac_setup_bcn_tmpl(struct ath11k_vif *arvif)
 	struct ieee80211_vif *vif = arvif->vif;
 	struct ieee80211_mutable_offsets offs = {};
 	struct sk_buff *bcn;
+	struct ieee80211_mgmt *mgmt;
+	u8 *ies;
 	int ret;
 
 	if (arvif->vdev_type != WMI_VDEV_TYPE_AP)
@@ -709,6 +711,17 @@ static int ath11k_mac_setup_bcn_tmpl(struct ath11k_vif *arvif)
 		return -EPERM;
 	}
 
+	ies = bcn->data + ieee80211_get_hdrlen_from_skb(bcn);
+	ies += sizeof(mgmt->u.beacon);
+
+	if (cfg80211_find_ie(WLAN_EID_RSN, ies, (skb_tail_pointer(bcn) - ies)))
+		arvif->rsnie_present = true;
+
+	if (cfg80211_find_vendor_ie(WLAN_OUI_MICROSOFT,
+				    WLAN_OUI_TYPE_MICROSOFT_WPA,
+				    ies, (skb_tail_pointer(bcn) - ies)))
+		arvif->wpaie_present = true;
+
 	ret = ath11k_wmi_bcn_tmpl(ar, arvif->vdev_id, &offs, bcn);
 
 	kfree_skb(bcn);
@@ -798,6 +811,7 @@ static void ath11k_peer_assoc_h_crypto(struct ath11k *ar,
 	struct ieee80211_bss_conf *info = &vif->bss_conf;
 	struct cfg80211_chan_def def;
 	struct cfg80211_bss *bss;
+	struct ath11k_vif *arvif = (struct ath11k_vif *)vif->drv_priv;
 	const u8 *rsnie = NULL;
 	const u8 *wpaie = NULL;
 
@@ -808,7 +822,12 @@ static void ath11k_peer_assoc_h_crypto(struct ath11k *ar,
 
 	bss = cfg80211_get_bss(ar->hw->wiphy, def.chan, info->bssid, NULL, 0,
 			       IEEE80211_BSS_TYPE_ANY, IEEE80211_PRIVACY_ANY);
-	if (bss) {
+
+	if (arvif->rsnie_present || arvif->wpaie_present) {
+		arg->need_ptk_4_way = true;
+		if (arvif->wpaie_present)
+			arg->need_gtk_2_way = true;
+	} else if (bss) {
 		const struct cfg80211_bss_ies *ies;
 
 		rcu_read_lock();
diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index c2a9723..ac97bc4 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -1692,10 +1692,10 @@ ath11k_wmi_copy_peer_flags(struct wmi_peer_assoc_complete_cmd *cmd,
 	 */
 	if (param->auth_flag)
 		cmd->peer_flags |= WMI_PEER_AUTH;
-	if (param->need_ptk_4_way)
+	if (param->need_ptk_4_way) {
 		cmd->peer_flags |= WMI_PEER_NEED_PTK_4_WAY;
-	else
-		cmd->peer_flags &= ~WMI_PEER_NEED_PTK_4_WAY;
+		cmd->peer_flags &= ~WMI_PEER_AUTH;
+	}
 	if (param->need_gtk_2_way)
 		cmd->peer_flags |= WMI_PEER_NEED_GTK_2_WAY;
 	/* safe mode bypass the 4-way handshake */
-- 
2.7.4

