Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3A221B57F7
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Apr 2020 11:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726746AbgDWJTt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Apr 2020 05:19:49 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:42761 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726145AbgDWJTt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 Apr 2020 05:19:49 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1587633588; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=lS6qvlWfaeFK3dX/BANkSbzEooAYY7Wv4YSmqUFIsEM=; b=FSyKaD+hoKEEMlRDQfMKcpC6HymnukthXSliaKE9oAnXauCdFC939sXD1wlfZ/W0rtU724//
 JIeOyj7zWWwNrV7kgHijmbXZbdm55uIKEvTugPq5R4+gfCpZNRhAVRsxjR77TvIj9mRMLRCe
 w3vkm1rnlknEg3yLA1aLlxNzdwI=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ea15daf.7f7c184ee998-smtp-out-n03;
 Thu, 23 Apr 2020 09:19:43 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D5BAFC433BA; Thu, 23 Apr 2020 09:19:43 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from wgong-HP-Z240-SFF-Workstation.qca.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0966DC433D2;
        Thu, 23 Apr 2020 09:19:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0966DC433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=wgong@codeaurora.org
From:   Wen Gong <wgong@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, wgong@codeaurora.org
Subject: [PATCH 1/4] ath10k: enable firmware peer stats info for wmi tlv
Date:   Thu, 23 Apr 2020 17:18:53 +0800
Message-Id: <20200423091856.24297-2-wgong@codeaurora.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200423091856.24297-1-wgong@codeaurora.org>
References: <20200423091856.24297-1-wgong@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

For wmi tlv type, firmware disable peer stats info by default, after
enable it, firmware will report WMI_TLV_PEER_STATS_INFO_EVENTID if
ath10k send WMI_TLV_REQUEST_PEER_STATS_INFO_CMDID to firmware.

Enable it will only set a flag in firmware, firmware will not report
it without receive request WMI command.

Tested with QCA6174 SDIO with firmware WLAN.RMH.4.4.1-00042.

Signed-off-by: Wen Gong <wgong@codeaurora.org>
---
 drivers/net/wireless/ath/ath10k/mac.c     | 5 +++++
 drivers/net/wireless/ath/ath10k/wmi-tlv.c | 1 +
 drivers/net/wireless/ath/ath10k/wmi-tlv.h | 1 +
 drivers/net/wireless/ath/ath10k/wmi.h     | 1 +
 4 files changed, 8 insertions(+)

diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
index 6791c0035be0..47fd5035f000 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -2959,6 +2959,11 @@ static void ath10k_bss_assoc(struct ieee80211_hw *hw,
 	arvif->aid = bss_conf->aid;
 	ether_addr_copy(arvif->bssid, bss_conf->bssid);
 
+	ret = ath10k_wmi_pdev_set_param(ar,
+					ar->wmi.pdev_param->peer_stats_info_enable, 1);
+	if (ret)
+		ath10k_warn(ar, "failed to enable peer stats info: %d\n", ret);
+
 	ret = ath10k_wmi_vdev_up(ar, arvif->vdev_id, arvif->aid, arvif->bssid);
 	if (ret) {
 		ath10k_warn(ar, "failed to set vdev %d up: %d\n",
diff --git a/drivers/net/wireless/ath/ath10k/wmi-tlv.c b/drivers/net/wireless/ath/ath10k/wmi-tlv.c
index e1ab900f2662..27aaa48615d2 100644
--- a/drivers/net/wireless/ath/ath10k/wmi-tlv.c
+++ b/drivers/net/wireless/ath/ath10k/wmi-tlv.c
@@ -4269,6 +4269,7 @@ static struct wmi_pdev_param_map wmi_tlv_pdev_param_map = {
 	.arp_dstaddr = WMI_PDEV_PARAM_UNSUPPORTED,
 	.rfkill_config = WMI_TLV_PDEV_PARAM_HW_RFKILL_CONFIG,
 	.rfkill_enable = WMI_TLV_PDEV_PARAM_RFKILL_ENABLE,
+	.peer_stats_info_enable = WMI_TLV_PDEV_PARAM_PEER_STATS_INFO_ENABLE,
 };
 
 static struct wmi_peer_param_map wmi_tlv_peer_param_map = {
diff --git a/drivers/net/wireless/ath/ath10k/wmi-tlv.h b/drivers/net/wireless/ath/ath10k/wmi-tlv.h
index 4972dc12991c..cd400b19a64d 100644
--- a/drivers/net/wireless/ath/ath10k/wmi-tlv.h
+++ b/drivers/net/wireless/ath/ath10k/wmi-tlv.h
@@ -451,6 +451,7 @@ enum wmi_tlv_pdev_param {
 	WMI_TLV_PDEV_PARAM_VDEV_RATE_STATS_UPDATE_PERIOD,
 	WMI_TLV_PDEV_PARAM_TXPOWER_REASON_NONE,
 	WMI_TLV_PDEV_PARAM_TXPOWER_REASON_SAR,
+	WMI_TLV_PDEV_PARAM_PEER_STATS_INFO_ENABLE = 0x8b,
 	WMI_TLV_PDEV_PARAM_TXPOWER_REASON_MAX,
 };
 
diff --git a/drivers/net/wireless/ath/ath10k/wmi.h b/drivers/net/wireless/ath/ath10k/wmi.h
index 209070714d1a..46740e16f3ce 100644
--- a/drivers/net/wireless/ath/ath10k/wmi.h
+++ b/drivers/net/wireless/ath/ath10k/wmi.h
@@ -3798,6 +3798,7 @@ struct wmi_pdev_param_map {
 	u32 enable_btcoex;
 	u32 rfkill_config;
 	u32 rfkill_enable;
+	u32 peer_stats_info_enable;
 };
 
 #define WMI_PDEV_PARAM_UNSUPPORTED 0
-- 
2.23.0
