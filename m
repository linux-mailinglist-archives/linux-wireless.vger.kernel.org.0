Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0206E4399BF
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Oct 2021 17:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233864AbhJYPNK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 Oct 2021 11:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233844AbhJYPNF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 Oct 2021 11:13:05 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67314C061746
        for <linux-wireless@vger.kernel.org>; Mon, 25 Oct 2021 08:10:43 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id j2-20020a1c2302000000b0032ca9b0a057so292004wmj.3
        for <linux-wireless@vger.kernel.org>; Mon, 25 Oct 2021 08:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=TqXdNbefF7RAL7fjD/5aezfDOsdViE8WPR3vaybxXEw=;
        b=PPrJHLQkcXSnW01Zi/vSfN4MOFTm2No77lWAG2AwEt+lDDBuMQhW/cvEyfZDdLflj1
         dsHBtZzhnRp8wDt8R56sdWDVDvW3VEY/DQgqw3j1fPd61v0HOUszJzcaj208RvbOGNkh
         E2bEqC/rtdW/DJ/6ZII5zvYQryVYfcNX7iC+BwqS7i57xdPluGNw0TpHsBWnIQmb+/G9
         L3o2t79lHB5OeDvdLxo25s3zETqd8eLEzixQvpcLfHwmvs/zsNrJNo3JembXl+S+cud0
         Scq31in0ccYRJ0ZVt4oaSSlOFBxpMdJz71VYAIWsbNeP2PfUCGKVEXhZlwtU9Nkwi1BY
         iawg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TqXdNbefF7RAL7fjD/5aezfDOsdViE8WPR3vaybxXEw=;
        b=7v1wD3crYA7WQbgratUuCjUgZDUejA9pmRbsngEUzTsQp1Vbg3ntotymqH/F7euMJS
         EnifLc1QrHNTIEIRBVAyzh5UCTClfd67rJAsV3dqXmRayifGzRXTfih4+0eZRaig02qE
         1mbJSRfh/Ld/B27X7flkzJn1+HegDayz5xRwjjm9Ql1/aowX90mKz/uS7QjHylngfTAY
         KA8QXgWEOdDG1oO8SVKBWmqHR2mF4mp3DUwIJEmQTISNxziFjvDy1kgUC12Q7/5J9mfZ
         4R5snQF28yECl9gjDpXDEsQLiyFqS7z5UGtUmLVcynaU/scGgqt8nNJPmYMi+IllQ7W3
         1eww==
X-Gm-Message-State: AOAM533TQuiw1Ea+ieasOupATKa/ecWl+BT2DNV3+NmQwRbfUHLCufq3
        GrU/GbBLciOAUTMdr/8msDcDv5ekSfQfw1Ad
X-Google-Smtp-Source: ABdhPJxbdUNAkfKFnmgxdM5jbKDbza/R5D1+iyrYIY9iM2flLzd44HHzIAxUylnrGYki7B+kroLW+A==
X-Received: by 2002:a1c:9a4f:: with SMTP id c76mr19825550wme.182.1635174641812;
        Mon, 25 Oct 2021 08:10:41 -0700 (PDT)
Received: from localhost.localdomain ([88.160.176.23])
        by smtp.gmail.com with ESMTPSA id v185sm19709359wme.35.2021.10.25.08.10.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Oct 2021 08:10:41 -0700 (PDT)
From:   Loic Poulain <loic.poulain@linaro.org>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, wcn36xx@lists.infradead.org,
        bryan.odonoghue@linaro.org, Loic Poulain <loic.poulain@linaro.org>
Subject: [PATCH v2] wcn36xx: Channel list update before hardware scan
Date:   Mon, 25 Oct 2021 17:22:08 +0200
Message-Id: <1635175328-25642-1-git-send-email-loic.poulain@linaro.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The channel scan list must be updated before triggering a hardware scan
so that firmware takes into account the regulatory info for each single
channel such as active/passive config, power, DFS, etc... Without this
the firmware uses its own internal default channel configuration, which
is not aligned with mac80211 regulatory rules, and misses several
channels (e.g. 144).

Fixes: 2f3bef4b247e ("wcn36xx: Add hardware scan offload support")
Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
---
 v2: Use u32_replace_bits() for setting channel update fields

 drivers/net/wireless/ath/wcn36xx/hal.h  | 32 +++++++++++++
 drivers/net/wireless/ath/wcn36xx/main.c |  1 +
 drivers/net/wireless/ath/wcn36xx/smd.c  | 82 +++++++++++++++++++++++++++++++++
 drivers/net/wireless/ath/wcn36xx/smd.h  |  1 +
 4 files changed, 116 insertions(+)

diff --git a/drivers/net/wireless/ath/wcn36xx/hal.h b/drivers/net/wireless/ath/wcn36xx/hal.h
index 5f1f248..9bea2b0 100644
--- a/drivers/net/wireless/ath/wcn36xx/hal.h
+++ b/drivers/net/wireless/ath/wcn36xx/hal.h
@@ -359,6 +359,8 @@ enum wcn36xx_hal_host_msg_type {
 	WCN36XX_HAL_START_SCAN_OFFLOAD_RSP = 205,
 	WCN36XX_HAL_STOP_SCAN_OFFLOAD_REQ = 206,
 	WCN36XX_HAL_STOP_SCAN_OFFLOAD_RSP = 207,
+	WCN36XX_HAL_UPDATE_CHANNEL_LIST_REQ = 208,
+	WCN36XX_HAL_UPDATE_CHANNEL_LIST_RSP = 209,
 	WCN36XX_HAL_SCAN_OFFLOAD_IND = 210,
 
 	WCN36XX_HAL_AVOID_FREQ_RANGE_IND = 233,
@@ -1353,6 +1355,36 @@ struct wcn36xx_hal_stop_scan_offload_rsp_msg {
 	u32 status;
 } __packed;
 
+#define WCN36XX_HAL_CHAN_REG1_MIN_PWR_MASK  0x000000ff
+#define WCN36XX_HAL_CHAN_REG1_MAX_PWR_MASK  0x0000ff00
+#define WCN36XX_HAL_CHAN_REG1_REG_PWR_MASK  0x00ff0000
+#define WCN36XX_HAL_CHAN_REG1_CLASS_ID_MASK 0xff000000
+#define WCN36XX_HAL_CHAN_REG2_ANT_GAIN_MASK 0x000000ff
+#define WCN36XX_HAL_CHAN_INFO_FLAG_PASSIVE  BIT(7)
+#define WCN36XX_HAL_CHAN_INFO_FLAG_DFS      BIT(10)
+#define WCN36XX_HAL_CHAN_INFO_FLAG_HT       BIT(11)
+#define WCN36XX_HAL_CHAN_INFO_FLAG_VHT      BIT(12)
+#define WCN36XX_HAL_CHAN_INFO_PHY_11A       0
+#define WCN36XX_HAL_CHAN_INFO_PHY_11BG      1
+#define WCN36XX_HAL_DEFAULT_ANT_GAIN        6
+#define WCN36XX_HAL_DEFAULT_MIN_POWER       6
+
+struct wcn36xx_hal_channel_param {
+	u32 mhz;
+	u32 band_center_freq1;
+	u32 band_center_freq2;
+	u32 channel_info;
+	u32 reg_info_1;
+	u32 reg_info_2;
+} __packed;
+
+struct wcn36xx_hal_update_channel_list_req_msg {
+	struct wcn36xx_hal_msg_header header;
+
+	u8 num_channel;
+	struct wcn36xx_hal_channel_param channels[80];
+} __packed;
+
 enum wcn36xx_hal_rate_index {
 	HW_RATE_INDEX_1MBPS	= 0x82,
 	HW_RATE_INDEX_2MBPS	= 0x84,
diff --git a/drivers/net/wireless/ath/wcn36xx/main.c b/drivers/net/wireless/ath/wcn36xx/main.c
index e65d575..a650b9e 100644
--- a/drivers/net/wireless/ath/wcn36xx/main.c
+++ b/drivers/net/wireless/ath/wcn36xx/main.c
@@ -689,6 +689,7 @@ static int wcn36xx_hw_scan(struct ieee80211_hw *hw,
 
 	mutex_unlock(&wcn->scan_lock);
 
+	wcn36xx_smd_update_channel_list(wcn, &hw_req->req);
 	return wcn36xx_smd_start_hw_scan(wcn, vif, &hw_req->req);
 }
 
diff --git a/drivers/net/wireless/ath/wcn36xx/smd.c b/drivers/net/wireless/ath/wcn36xx/smd.c
index 3cecc8f..e1f4a5d 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.c
+++ b/drivers/net/wireless/ath/wcn36xx/smd.c
@@ -16,6 +16,7 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <linux/bitfield.h>
 #include <linux/etherdevice.h>
 #include <linux/firmware.h>
 #include <linux/bitops.h>
@@ -928,6 +929,86 @@ int wcn36xx_smd_stop_hw_scan(struct wcn36xx *wcn)
 	return ret;
 }
 
+int wcn36xx_smd_update_channel_list(struct wcn36xx *wcn, struct cfg80211_scan_request *req)
+{
+	struct wcn36xx_hal_update_channel_list_req_msg *msg_body;
+	int ret, i;
+
+	msg_body = kzalloc(sizeof(*msg_body), GFP_KERNEL);
+	if (!msg_body)
+		return -ENOMEM;
+
+	INIT_HAL_MSG((*msg_body), WCN36XX_HAL_UPDATE_CHANNEL_LIST_REQ);
+
+	msg_body->num_channel = min_t(u8, req->n_channels, sizeof(msg_body->channels));
+	for (i = 0; i < msg_body->num_channel; i++) {
+		struct wcn36xx_hal_channel_param *param = &msg_body->channels[i];
+		u32 min_power = WCN36XX_HAL_DEFAULT_MIN_POWER;
+		u32 ant_gain = WCN36XX_HAL_DEFAULT_ANT_GAIN;
+
+		param->mhz = req->channels[i]->center_freq;
+		param->band_center_freq1 = req->channels[i]->center_freq;
+		param->band_center_freq2 = 0;
+
+		if (req->channels[i]->flags & IEEE80211_CHAN_NO_IR)
+			param->channel_info |= WCN36XX_HAL_CHAN_INFO_FLAG_PASSIVE;
+
+		if (req->channels[i]->flags & IEEE80211_CHAN_RADAR)
+			param->channel_info |= WCN36XX_HAL_CHAN_INFO_FLAG_DFS;
+
+		if (req->channels[i]->band == NL80211_BAND_5GHZ) {
+			param->channel_info |= WCN36XX_HAL_CHAN_INFO_FLAG_HT;
+			param->channel_info |= WCN36XX_HAL_CHAN_INFO_FLAG_VHT;
+			param->channel_info |= WCN36XX_HAL_CHAN_INFO_PHY_11A;
+		} else {
+			param->channel_info |= WCN36XX_HAL_CHAN_INFO_PHY_11BG;
+		}
+
+		if (min_power > req->channels[i]->max_power)
+			min_power = req->channels[i]->max_power;
+
+		if (req->channels[i]->max_antenna_gain)
+			ant_gain = req->channels[i]->max_antenna_gain;
+
+		u32p_replace_bits(&param->reg_info_1, min_power,
+				  WCN36XX_HAL_CHAN_REG1_MIN_PWR_MASK);
+		u32p_replace_bits(&param->reg_info_1, req->channels[i]->max_power,
+				  WCN36XX_HAL_CHAN_REG1_MAX_PWR_MASK);
+		u32p_replace_bits(&param->reg_info_1, req->channels[i]->max_reg_power,
+				  WCN36XX_HAL_CHAN_REG1_REG_PWR_MASK);
+		u32p_replace_bits(&param->reg_info_1, 0,
+				  WCN36XX_HAL_CHAN_REG1_CLASS_ID_MASK);
+		u32p_replace_bits(&param->reg_info_2, ant_gain,
+				  WCN36XX_HAL_CHAN_REG2_ANT_GAIN_MASK);
+
+		wcn36xx_dbg(WCN36XX_DBG_HAL,
+			    "%s: freq=%u, channel_info=%08x, reg_info1=%08x, reg_info2=%08x\n",
+			    __func__, param->mhz, param->channel_info, param->reg_info_1,
+			    param->reg_info_2);
+	}
+
+	mutex_lock(&wcn->hal_mutex);
+
+	PREPARE_HAL_BUF(wcn->hal_buf, (*msg_body));
+
+	ret = wcn36xx_smd_send_and_wait(wcn, msg_body->header.len);
+	if (ret) {
+		wcn36xx_err("Sending hal_update_channel_list failed\n");
+		goto out;
+	}
+
+	ret = wcn36xx_smd_rsp_status_check(wcn->hal_buf, wcn->hal_rsp_len);
+	if (ret) {
+		wcn36xx_err("hal_update_channel_list response failed err=%d\n", ret);
+		goto out;
+	}
+
+out:
+	kfree(msg_body);
+	mutex_unlock(&wcn->hal_mutex);
+	return ret;
+}
+
 static int wcn36xx_smd_switch_channel_rsp(void *buf, size_t len)
 {
 	struct wcn36xx_hal_switch_channel_rsp_msg *rsp;
@@ -3138,6 +3219,7 @@ int wcn36xx_smd_rsp_process(struct rpmsg_device *rpdev,
 	case WCN36XX_HAL_HOST_RESUME_RSP:
 	case WCN36XX_HAL_ENTER_IMPS_RSP:
 	case WCN36XX_HAL_EXIT_IMPS_RSP:
+	case WCN36XX_HAL_UPDATE_CHANNEL_LIST_RSP:
 		memcpy(wcn->hal_buf, buf, len);
 		wcn->hal_rsp_len = len;
 		complete(&wcn->hal_rsp_compl);
diff --git a/drivers/net/wireless/ath/wcn36xx/smd.h b/drivers/net/wireless/ath/wcn36xx/smd.h
index 5f98c1d..88e045d 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.h
+++ b/drivers/net/wireless/ath/wcn36xx/smd.h
@@ -70,6 +70,7 @@ int wcn36xx_smd_update_scan_params(struct wcn36xx *wcn, u8 *channels, size_t cha
 int wcn36xx_smd_start_hw_scan(struct wcn36xx *wcn, struct ieee80211_vif *vif,
 			      struct cfg80211_scan_request *req);
 int wcn36xx_smd_stop_hw_scan(struct wcn36xx *wcn);
+int wcn36xx_smd_update_channel_list(struct wcn36xx *wcn, struct cfg80211_scan_request *req);
 int wcn36xx_smd_add_sta_self(struct wcn36xx *wcn, struct ieee80211_vif *vif);
 int wcn36xx_smd_delete_sta_self(struct wcn36xx *wcn, u8 *addr);
 int wcn36xx_smd_delete_sta(struct wcn36xx *wcn, u8 sta_index);
-- 
2.7.4

