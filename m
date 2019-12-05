Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31F7E113BAB
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Dec 2019 07:27:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbfLEG04 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 Dec 2019 01:26:56 -0500
Received: from nbd.name ([46.4.11.11]:56164 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725963AbfLEG0z (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 Dec 2019 01:26:55 -0500
Received: from pd95fd3d5.dip0.t-ipconnect.de ([217.95.211.213] helo=bertha.datto.lan)
        by ds12 with esmtpa (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1ickbD-0001bo-4S; Thu, 05 Dec 2019 07:26:51 +0100
From:   John Crispin <john@phrozen.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        John Crispin <john@phrozen.org>
Subject: [PATCH 2/2] ath11k: explicitly cast wmi commands to their correct struct type
Date:   Thu,  5 Dec 2019 07:26:45 +0100
Message-Id: <20191205062645.6033-2-john@phrozen.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191205062645.6033-1-john@phrozen.org>
References: <20191205062645.6033-1-john@phrozen.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Three of the WMI command handlers were not casting to the right data type.
Lets make the code consistent with the other handlers.

Signed-off-by: John Crispin <john@phrozen.org>
---
 drivers/net/wireless/ath/ath11k/wmi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index a2f03360e19f..0c1064a0aa39 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -2517,7 +2517,7 @@ ath11k_wmi_send_twt_enable_cmd(struct ath11k *ar, u32 pdev_id)
 	if (!skb)
 		return -ENOMEM;
 
-	cmd = (void *)skb->data;
+	cmd = (struct wmi_twt_enable_params_cmd *)skb->data;
 	cmd->tlv_header = FIELD_PREP(WMI_TLV_TAG, WMI_TAG_TWT_ENABLE_CMD) |
 			  FIELD_PREP(WMI_TLV_LEN, len - TLV_HDR_SIZE);
 	cmd->pdev_id = pdev_id;
@@ -2568,7 +2568,7 @@ ath11k_wmi_send_twt_disable_cmd(struct ath11k *ar, u32 pdev_id)
 	if (!skb)
 		return -ENOMEM;
 
-	cmd = (void *)skb->data;
+	cmd = (struct wmi_twt_disable_params_cmd *)skb->data;
 	cmd->tlv_header = FIELD_PREP(WMI_TLV_TAG, WMI_TAG_TWT_DISABLE_CMD) |
 			  FIELD_PREP(WMI_TLV_LEN, len - TLV_HDR_SIZE);
 	cmd->pdev_id = pdev_id;
@@ -2768,7 +2768,7 @@ ath11k_wmi_send_obss_spr_cmd(struct ath11k *ar, u32 vdev_id,
 	if (!skb)
 		return -ENOMEM;
 
-	cmd = (void *)skb->data;
+	cmd = (struct wmi_obss_spatial_reuse_params_cmd *)skb->data;
 	cmd->tlv_header = FIELD_PREP(WMI_TLV_TAG,
 				     WMI_TAG_OBSS_SPATIAL_REUSE_SET_CMD) |
 			  FIELD_PREP(WMI_TLV_LEN, len - TLV_HDR_SIZE);
-- 
2.20.1

