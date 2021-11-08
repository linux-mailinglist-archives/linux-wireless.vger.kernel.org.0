Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16517447F8B
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Nov 2021 13:38:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238209AbhKHMlR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 8 Nov 2021 07:41:17 -0500
Received: from so254-9.mailgun.net ([198.61.254.9]:31857 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231529AbhKHMlR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 8 Nov 2021 07:41:17 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1636375113; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=6ozcYf0B2G31qBNR2RL9a+tqM8DVofWgqAwo7Jke7AY=; b=dZB8UI7E1+vQyUnhF9THZS50qsoZo5C/kdBiNYhg9pub5z0J0K4alq7jREwvJ2pwaY55YMKb
 pDQ5hrNO4kj7O+E56rCZJ4YN4rJTJnv071/7uPAKk0VY/9t1f8U02BammyJryQdkpRYgHOeH
 EtVKGjJ1remYhlaRLWU/UzaLFBA=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 61891a469198e3b25675530c (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 08 Nov 2021 12:38:30
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id ADCAEC43616; Mon,  8 Nov 2021 12:38:30 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from tykki.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 681E5C4338F;
        Mon,  8 Nov 2021 12:38:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 681E5C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH v2 1/2] ath11k: convert ath11k_wmi_pdev_set_ps_mode() to use enum wmi_sta_ps_mode
Date:   Mon,  8 Nov 2021 14:38:25 +0200
Message-Id: <20211108123826.8463-1-kvalo@codeaurora.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

It's more descriptive to use the actual enum used by the firmware instead of a
boolean so change ath11k_wmi_pdev_set_ps_mode() to use a boolean.

Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1

Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
---

v2:

* new patch

 drivers/net/wireless/ath/ath11k/mac.c | 3 ++-
 drivers/net/wireless/ath/ath11k/wmi.c | 7 ++++---
 drivers/net/wireless/ath/ath11k/wmi.h | 3 ++-
 3 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 1cc55602787b..f6511fc8ae8c 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -5638,7 +5638,8 @@ static int ath11k_mac_op_add_interface(struct ieee80211_hw *hw,
 			goto err_peer_del;
 		}
 
-		ret = ath11k_wmi_pdev_set_ps_mode(ar, arvif->vdev_id, false);
+		ret = ath11k_wmi_pdev_set_ps_mode(ar, arvif->vdev_id,
+						  WMI_STA_PS_MODE_DISABLED);
 		if (ret) {
 			ath11k_warn(ar->ab, "failed to disable vdev %d ps mode: %d\n",
 				    arvif->vdev_id, ret);
diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index 5ae2ef4680d6..b9bfe0407cd7 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -1244,7 +1244,8 @@ int ath11k_wmi_pdev_set_param(struct ath11k *ar, u32 param_id,
 	return ret;
 }
 
-int ath11k_wmi_pdev_set_ps_mode(struct ath11k *ar, int vdev_id, u32 enable)
+int ath11k_wmi_pdev_set_ps_mode(struct ath11k *ar, int vdev_id,
+				enum wmi_sta_ps_mode psmode)
 {
 	struct ath11k_pdev_wmi *wmi = ar->wmi;
 	struct wmi_pdev_set_ps_mode_cmd *cmd;
@@ -1259,7 +1260,7 @@ int ath11k_wmi_pdev_set_ps_mode(struct ath11k *ar, int vdev_id, u32 enable)
 	cmd->tlv_header = FIELD_PREP(WMI_TLV_TAG, WMI_TAG_STA_POWERSAVE_MODE_CMD) |
 			  FIELD_PREP(WMI_TLV_LEN, sizeof(*cmd) - TLV_HDR_SIZE);
 	cmd->vdev_id = vdev_id;
-	cmd->sta_ps_mode = enable;
+	cmd->sta_ps_mode = psmode;
 
 	ret = ath11k_wmi_cmd_send(wmi, skb, WMI_STA_POWERSAVE_MODE_CMDID);
 	if (ret) {
@@ -1269,7 +1270,7 @@ int ath11k_wmi_pdev_set_ps_mode(struct ath11k *ar, int vdev_id, u32 enable)
 
 	ath11k_dbg(ar->ab, ATH11K_DBG_WMI,
 		   "WMI vdev set psmode %d vdev id %d\n",
-		   enable, vdev_id);
+		   psmode, vdev_id);
 
 	return ret;
 }
diff --git a/drivers/net/wireless/ath/ath11k/wmi.h b/drivers/net/wireless/ath/ath11k/wmi.h
index 0584e68e7593..93e2992db862 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.h
+++ b/drivers/net/wireless/ath/ath11k/wmi.h
@@ -5351,7 +5351,8 @@ int ath11k_wmi_set_peer_param(struct ath11k *ar, const u8 *peer_addr,
 			      u32 vdev_id, u32 param_id, u32 param_val);
 int ath11k_wmi_pdev_set_param(struct ath11k *ar, u32 param_id,
 			      u32 param_value, u8 pdev_id);
-int ath11k_wmi_pdev_set_ps_mode(struct ath11k *ar, int vdev_id, u32 enable);
+int ath11k_wmi_pdev_set_ps_mode(struct ath11k *ar, int vdev_id,
+				enum wmi_sta_ps_mode psmode);
 int ath11k_wmi_wait_for_unified_ready(struct ath11k_base *ab);
 int ath11k_wmi_cmd_init(struct ath11k_base *ab);
 int ath11k_wmi_wait_for_service_ready(struct ath11k_base *ab);

base-commit: 042696e7d5cff4bf705caa191ea458352bcc07f3
-- 
2.20.1

