Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B01881DE0C3
	for <lists+linux-wireless@lfdr.de>; Fri, 22 May 2020 09:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728481AbgEVHYq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 22 May 2020 03:24:46 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:30664 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728281AbgEVHYq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 22 May 2020 03:24:46 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1590132285; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: References: In-Reply-To: Message-Id: Date: Subject: Cc:
 To: From: Sender; bh=0py7nHDtFNM37C9OrIO7osS5eI9QRO8TdNp8NZ95Azg=; b=ipFJ++gzSVMrGaUz57BqaLMEDqHNGM1Z9CAWx/A8HJvx/ClHsWy6K9Lw4gF7j50ct8E5cytD
 wuX8/qXZgBlQODigJDbsfauTcIk3ZTaIuBc4qkt9cPuIJ6pWQC87OKizaVGhj206Z2emdF8c
 0fJPZSnnt3WN7UXIGb6H/GhzPkA=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ec77e3d.7fdc5329bab0-smtp-out-n05;
 Fri, 22 May 2020 07:24:45 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 2B735C433C6; Fri, 22 May 2020 07:24:45 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from pradeepc2-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pradeepc)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 79968C433CA;
        Fri, 22 May 2020 07:24:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 79968C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=pradeepc@codeaurora.org
From:   Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>,
        ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
Subject: [PATCH v2 5/9] ath11k: extend peer_assoc_cmd for 6GHz band
Date:   Fri, 22 May 2020 00:24:27 -0700
Message-Id: <20200522072431.27601-6-pradeepc@codeaurora.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200522072431.27601-1-pradeepc@codeaurora.org>
References: <20200522072431.27601-1-pradeepc@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This adds support required for configuring min_data_rate of 6GHz oper IE
and peer_he_caps_6ghz in peer assoc command. The Minimum Rate field
indicates the minimum rate, in units of 1 Mb/s, that the non-AP STA is
allowed to use for sending PPDUs as defined in IEEE P802.11ax™/D6.0.

Signed-off-by: Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/wmi.c | 2 ++
 drivers/net/wireless/ath/ath11k/wmi.h | 5 +++++
 2 files changed, 7 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index 500108fa59d9..a6bbb3badd1f 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -1789,6 +1789,7 @@ int ath11k_wmi_send_peer_assoc_cmd(struct ath11k *ar,
 	cmd->peer_he_cap_info = param->peer_he_cap_macinfo[0];
 	cmd->peer_he_cap_info_ext = param->peer_he_cap_macinfo[1];
 	cmd->peer_he_cap_info_internal = param->peer_he_cap_macinfo_internal;
+	cmd->peer_he_caps_6ghz = param->peer_he_caps_6ghz;
 	cmd->peer_he_ops = param->peer_he_ops;
 	memcpy(&cmd->peer_he_cap_phy, &param->peer_he_cap_phyinfo,
 	       sizeof(param->peer_he_cap_phyinfo));
@@ -1842,6 +1843,7 @@ int ath11k_wmi_send_peer_assoc_cmd(struct ath11k *ar,
 
 	/* HE Rates */
 	cmd->peer_he_mcs = param->peer_he_mcs_count;
+	cmd->min_data_rate = param->min_data_rate;
 
 	ptr += sizeof(*mcs);
 
diff --git a/drivers/net/wireless/ath/ath11k/wmi.h b/drivers/net/wireless/ath/ath11k/wmi.h
index afa3c4cf90e9..fd82cff7537b 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.h
+++ b/drivers/net/wireless/ath/ath11k/wmi.h
@@ -1011,6 +1011,7 @@ enum wmi_tlv_vdev_param {
 	WMI_VDEV_PARAM_FILS_MAX_CHANNEL_GUARD_TIME,
 	WMI_VDEV_PARAM_BA_MODE = 0x7e,
 	WMI_VDEV_PARAM_SET_HE_SOUNDING_MODE = 0x87,
+	WMI_VDEV_PARAM_6GHZ_PARAMS = 0x99,
 	WMI_VDEV_PARAM_PROTOTYPE = 0x8000,
 	WMI_VDEV_PARAM_BSS_COLOR,
 	WMI_VDEV_PARAM_SET_HEMU_MODE,
@@ -3444,6 +3445,7 @@ struct peer_assoc_params {
 	u32 tx_max_rate;
 	u32 tx_mcs_set;
 	u8 vht_capable;
+	u8 min_data_rate;
 	u32 tx_max_mcs_nss;
 	u32 peer_bw_rxnss_override;
 	bool is_pmf_enabled;
@@ -3472,6 +3474,7 @@ struct peer_assoc_params {
 	bool he_flag;
 	u32 peer_he_cap_macinfo[2];
 	u32 peer_he_cap_macinfo_internal;
+	u32 peer_he_caps_6ghz;
 	u32 peer_he_ops;
 	u32 peer_he_cap_phyinfo[WMI_HOST_MAX_HECAP_PHY_SIZE];
 	u32 peer_he_mcs_count;
@@ -3509,6 +3512,8 @@ struct  wmi_peer_assoc_complete_cmd {
 	u32 peer_he_mcs;
 	u32 peer_he_cap_info_ext;
 	u32 peer_he_cap_info_internal;
+	u32 min_data_rate;
+	u32 peer_he_caps_6ghz;
 } __packed;
 
 struct wmi_stop_scan_cmd {
-- 
2.17.1
