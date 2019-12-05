Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB01D113BAA
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Dec 2019 07:27:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbfLEG04 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 Dec 2019 01:26:56 -0500
Received: from nbd.name ([46.4.11.11]:56166 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726128AbfLEG0z (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 Dec 2019 01:26:55 -0500
Received: from pd95fd3d5.dip0.t-ipconnect.de ([217.95.211.213] helo=bertha.datto.lan)
        by ds12 with esmtpa (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1ickbC-0001bo-Mw; Thu, 05 Dec 2019 07:26:50 +0100
From:   John Crispin <john@phrozen.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        John Crispin <john@phrozen.org>
Subject: [PATCH 1/2] ath11k: add some missing __packed qualifiers
Date:   Thu,  5 Dec 2019 07:26:44 +0100
Message-Id: <20191205062645.6033-1-john@phrozen.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

A few of the WMI parameter structs were missing this.

Signed-off-by: John Crispin <john@phrozen.org>
---
 drivers/net/wireless/ath/ath11k/wmi.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/wmi.h b/drivers/net/wireless/ath/ath11k/wmi.h
index 0d7caa1e4d75..7a1ed73d8b7b 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.h
+++ b/drivers/net/wireless/ath/ath11k/wmi.h
@@ -4562,12 +4562,12 @@ struct wmi_twt_enable_params_cmd {
 	u32 mode_check_interval;
 	u32 add_sta_slot_interval;
 	u32 remove_sta_slot_interval;
-};
+} __packed;
 
 struct wmi_twt_disable_params_cmd {
 	u32 tlv_header;
 	u32 pdev_id;
-};
+} __packed;
 
 enum WMI_HOST_TWT_COMMAND {
 	WMI_HOST_TWT_COMMAND_REQUEST_TWT = 0,
@@ -4682,7 +4682,7 @@ struct wmi_obss_spatial_reuse_params_cmd {
 	s32 obss_min;
 	s32 obss_max;
 	u32 vdev_id;
-};
+} __packed;
 
 struct target_resource_config {
 	u32 num_vdevs;
-- 
2.20.1

