Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05794472DCB
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Dec 2021 14:49:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237951AbhLMNt2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Dec 2021 08:49:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234610AbhLMNt1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Dec 2021 08:49:27 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8201CC06173F
        for <linux-wireless@vger.kernel.org>; Mon, 13 Dec 2021 05:49:26 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id c6-20020a05600c0ac600b0033c3aedd30aso11604448wmr.5
        for <linux-wireless@vger.kernel.org>; Mon, 13 Dec 2021 05:49:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Gsa1pstyv6w1sqIg/mnQZfaPOzABwBdP6qpZqIqI/04=;
        b=OPHTOBIuWWj1+K8ommhE6DlXjsm8U2Zd2ax59j5cpgyJPniPq2RBftR6/PTRAFkdYq
         3Kyusd5lI1Eez9uTk9mZNHOxcvczDhbIMnoqI21IJ2sa7pHoGzkLLV7J/SnQZ8cbJYd0
         e5/nYON2xXMQrRTtNor/QeKf5jKLPBD8zb51qowDiLE2iXsQbq1b+Rk23BIfaI1pEFgV
         8feKr/YEzRHq69s9R8mNusjMF5kHOMLsNKgZSPGFGjKAYo6bFlaGL6PVjdGSJXZc96B0
         0CSsv/1yb/2qVmCPTLWLdHCNWfFl9NNfIlIevjrsUbtfy/DHJ6o5VP8zvi7gvAN9Nbqn
         YJOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Gsa1pstyv6w1sqIg/mnQZfaPOzABwBdP6qpZqIqI/04=;
        b=jOvZzMm+pDanP+SAKMzXFoxrrylqvsCL+P7MZzEY9+CdtEE9kWOqiByT/JNhfTVDKy
         2YV3QEnghcoRfppYaKE+X49cSgBvGD1vQ6XaE/sM/xwCYtrnN30xFupE56RkL+xYy9JH
         2U/33+4BbsZJAa73j0PRSAA+ObSuBlplZSWnO00Y0vFEEQAnvrinYU26A2c3TGW0ruWH
         nl7IURlnKETluIiLobA8RIeEt3bThX21aU5qdb+T6b45vE6R+Rcr7Os0a0zeWYoiIMGT
         AyvkT10bgEWCf9iNXNoC4T9pgvsrpCudTIQJds7BEfyCgoJsLJG2IVzTrr/Nm0dVQkbR
         k+AA==
X-Gm-Message-State: AOAM531vbyvbuywifJCy9hph1jU7S87WxILvNWqTKVqdyjIaN5yJDQB9
        NBBvRIXGp8Po/wbIgRU6N7vFXtyIh2CAjQ==
X-Google-Smtp-Source: ABdhPJwGsaRP8zxx8t6TY+AMeeHBOJl6HLm6GfS0I+XVBdspUoDpGyoHGGmkoPNlfEr3mhanhR5K3w==
X-Received: by 2002:a1c:7714:: with SMTP id t20mr37604668wmi.139.1639403365114;
        Mon, 13 Dec 2021 05:49:25 -0800 (PST)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id m9sm7366621wmq.1.2021.12.13.05.49.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 05:49:24 -0800 (PST)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org,
        wcn36xx@lists.infradead.org, linux-arm-msm@vger.kernel.org
Cc:     loic.poulain@linaro.org, benl@squareup.com,
        bryan.odonoghue@linaro.org
Subject: [PATCH 3/3] wcn36xx: Implement downstream compliant beacon filtering
Date:   Mon, 13 Dec 2021 13:51:27 +0000
Message-Id: <20211213135127.1656258-4-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211213135127.1656258-1-bryan.odonoghue@linaro.org>
References: <20211213135127.1656258-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Downstream facilitates the direct programming of beacon filter tables via
SMD commands.

The purpose of beacon filters is quote:

/* When beacon filtering is enabled, firmware will
 * analyze the selected beacons received during BMPS,
 * and monitor any changes in the IEs as listed below.
 * The format of the table is:
 *    - EID
 *    - Check for IE presence
 *    - Byte offset
 *    - Byte value
 *    - Bit Mask
 *    - Byte reference
 */

The default downstream firmware filter table looks something like this:
tBeaconFilterIe gaBcnFilterTable[12] =
{
  { WLAN_EID_DS_PARAMS, 0u, { 0u, 0u, 0u, 0u } },
  { WLAN_EID_ERP_INFO, 0u, { 0u, 0u, 248u, 0u } },
  { WLAN_EID_EDCA_PARAM_SET, 0u, { 0u, 0u, 240u, 0u } },
  { WLAN_EID_QOS_CAPA, 0u, { 0u, 0u, 240u, 0u } },
  { WLAN_EID_CHANNEL_SWITCH, 1u, { 0u, 0u, 0u, 0u } },
  { WLAN_EID_QUIET, 1u, { 0u, 0u, 0u, 0u } },
  { WLAN_EID_HT_OPERATION, 0u, { 0u, 0u, 0u, 0u } },
  { WLAN_EID_HT_OPERATION, 0u, { 1u, 0u, 248u, 0u } },
  { WLAN_EID_HT_OPERATION, 0u, { 2u, 0u, 235u, 0u } },
  { WLAN_EID_HT_OPERATION, 0u, { 5u, 0u, 253u, 0u } },
  { WLAN_EID_PWR_CONSTRAINT, 0u, { 0u, 0u, 0u, 0u } },
  { WLAN_EID_OPMODE_NOTIF, 0u, { 0u, 0u, 0u, 0u } }
};

Add in an equivalent filter set as present in the downstream Linux driver.
For now omit the beacon filter "rem" command as downstream does not have an
explicit call to that SMD command. The filter mask should only count when
we are inside BMPS anyway.

Replicating the downstream ability to program the filter table gives us
scope to add and remove elements in future. For now though this patch
makes the rote-copy of the downstream Linux beacon filter table, which we
can tweak as desired from now on.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/net/wireless/ath/wcn36xx/hal.h  |  16 ++++
 drivers/net/wireless/ath/wcn36xx/main.c |   1 +
 drivers/net/wireless/ath/wcn36xx/smd.c  | 104 ++++++++++++++++++++++++
 drivers/net/wireless/ath/wcn36xx/smd.h  |   3 +
 4 files changed, 124 insertions(+)

diff --git a/drivers/net/wireless/ath/wcn36xx/hal.h b/drivers/net/wireless/ath/wcn36xx/hal.h
index e9fec110721b5..3351aaf5140df 100644
--- a/drivers/net/wireless/ath/wcn36xx/hal.h
+++ b/drivers/net/wireless/ath/wcn36xx/hal.h
@@ -3468,6 +3468,22 @@ struct beacon_filter_ie {
 	u8 ref;
 } __packed;
 
+/* Downstream values for the bitmask field */
+#define WCN36XX_FILTER_CAPABILITY_MASK		0x73cf
+#define WCN36XX_FILTER_IE_DS_CHANNEL_MASK	0x00
+#define WCN36XX_FILTER_IE_ERP_FILTER_MASK	0xF8
+#define WCN36XX_FILTER_IE_EDCA_FILTER_MASK	0xF0
+#define WCN36XX_FILTER_IE_QOS_FILTER_MASK	0xF0
+#define WCN36XX_FILTER_IE_CHANNEL_SWITCH_MASK	0x00
+#define WCN36XX_FILTER_IE_HT_BYTE0_FILTER_MASK	0x00
+#define WCN36XX_FILTER_IE_HT_BYTE1_FILTER_MASK	0xF8
+#define WCN36XX_FILTER_IE_HT_BYTE2_FILTER_MASK	0xEB
+#define WCN36XX_FILTER_IE_HT_BYTE5_FILTER_MASK	0xFD
+#define WCN36XX_FILTER_IE_OPMODE_NOTIF_MASK	0x00
+#define WCN36XX_FILTER_IE_VHTOP_CHWIDTH_MASK	0xFC
+#define WCN36XX_FILTER_IE_RSN_MASK		0x00
+#define WCN36XX_FILTER_IE_VENDOR_MASK		0x00
+
 /* The above structure would be followed by multiple of below mentioned
  * structure
  */
diff --git a/drivers/net/wireless/ath/wcn36xx/main.c b/drivers/net/wireless/ath/wcn36xx/main.c
index f59eb1119da88..a4510f144041f 100644
--- a/drivers/net/wireless/ath/wcn36xx/main.c
+++ b/drivers/net/wireless/ath/wcn36xx/main.c
@@ -934,6 +934,7 @@ static void wcn36xx_bss_info_changed(struct ieee80211_hw *hw,
 			 * place where AID is available.
 			 */
 			wcn36xx_smd_config_sta(wcn, vif, sta);
+			wcn36xx_smd_add_beacon_filter(wcn, vif);
 			wcn36xx_enable_keep_alive_null_packet(wcn, vif);
 		} else {
 			wcn36xx_dbg(WCN36XX_DBG_MAC,
diff --git a/drivers/net/wireless/ath/wcn36xx/smd.c b/drivers/net/wireless/ath/wcn36xx/smd.c
index b05d10f9f6005..e6ee14adbe0da 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.c
+++ b/drivers/net/wireless/ath/wcn36xx/smd.c
@@ -3193,6 +3193,109 @@ int wcn36xx_smd_host_resume(struct wcn36xx *wcn)
 	return ret;
 }
 
+#define BEACON_FILTER(eid, presence, offs, val, mask, ref_val) \
+	{					\
+		.element_id = eid,		\
+		.check_ie_presence = presence,	\
+		.offset = offs,			\
+		.value = val,			\
+		.bitmask = mask,		\
+		.ref = ref_val,			\
+	}
+
+/* Downstream values for the bitmask field */
+#define WCN36XX_FILTER_CAPABILITY_MASK		0x73cf
+#define WCN36XX_FILTER_IE_DS_CHANNEL_MASK	0x00
+#define WCN36XX_FILTER_IE_ERP_FILTER_MASK	0xF8
+#define WCN36XX_FILTER_IE_EDCA_FILTER_MASK	0xF0
+#define WCN36XX_FILTER_IE_QOS_FILTER_MASK	0xF0
+#define WCN36XX_FILTER_IE_CHANNEL_SWITCH_MASK	0x00
+#define WCN36XX_FILTER_IE_HT_BYTE0_FILTER_MASK	0x00
+#define WCN36XX_FILTER_IE_HT_BYTE1_FILTER_MASK	0xF8
+#define WCN36XX_FILTER_IE_HT_BYTE2_FILTER_MASK	0xEB
+#define WCN36XX_FILTER_IE_HT_BYTE5_FILTER_MASK	0xFD
+#define WCN36XX_FILTER_IE_PWR_CONSTRAINT_MASK	0x00
+#define WCN36XX_FILTER_IE_OPMODE_NOTIF_MASK	0x00
+#define WCN36XX_FILTER_IE_VHTOP_CHWIDTH_MASK	0xFC
+#define WCN36XX_FILTER_IE_RSN_MASK		0x00
+#define WCN36XX_FILTER_IE_VENDOR_MASK		0x00
+
+/* CORE/MAC/src/pe/lim/limSendMessages.c::beaconFilterTable[] */
+static struct beacon_filter_ie bcn_filter_ies[] = {
+	BEACON_FILTER(WLAN_EID_DS_PARAMS, 0, 0, 0,
+		      WCN36XX_FILTER_IE_DS_CHANNEL_MASK, 0),
+	BEACON_FILTER(WLAN_EID_ERP_INFO, 0, 0, 0,
+		      WCN36XX_FILTER_IE_ERP_FILTER_MASK, 0),
+	BEACON_FILTER(WLAN_EID_EDCA_PARAM_SET, 0, 0, 0,
+		      WCN36XX_FILTER_IE_EDCA_FILTER_MASK, 0),
+	BEACON_FILTER(WLAN_EID_QOS_CAPA, 0, 0, 0,
+		      WCN36XX_FILTER_IE_QOS_FILTER_MASK, 0),
+	BEACON_FILTER(WLAN_EID_CHANNEL_SWITCH, 1, 0, 0,
+		      WCN36XX_FILTER_IE_CHANNEL_SWITCH_MASK, 0),
+	BEACON_FILTER(WLAN_EID_HT_OPERATION, 0, 0, 0,
+		      WCN36XX_FILTER_IE_HT_BYTE0_FILTER_MASK, 0),
+	BEACON_FILTER(WLAN_EID_HT_OPERATION, 0, 2, 0,
+		      WCN36XX_FILTER_IE_HT_BYTE2_FILTER_MASK, 0),
+	BEACON_FILTER(WLAN_EID_HT_OPERATION, 0, 5, 0,
+		      WCN36XX_FILTER_IE_HT_BYTE5_FILTER_MASK, 0),
+	BEACON_FILTER(WLAN_EID_PWR_CONSTRAINT, 0, 0, 0,
+		      WCN36XX_FILTER_IE_PWR_CONSTRAINT_MASK, 0),
+	BEACON_FILTER(WLAN_EID_OPMODE_NOTIF, 0, 0, 0,
+		      WCN36XX_FILTER_IE_OPMODE_NOTIF_MASK, 0),
+	BEACON_FILTER(WLAN_EID_VHT_OPERATION, 0, 0, 0,
+		      WCN36XX_FILTER_IE_VHTOP_CHWIDTH_MASK, 0),
+	BEACON_FILTER(WLAN_EID_RSN, 1, 0, 0,
+		      WCN36XX_FILTER_IE_RSN_MASK, 0),
+	BEACON_FILTER(WLAN_EID_VENDOR_SPECIFIC, 1, 0, 0,
+		      WCN36XX_FILTER_IE_VENDOR_MASK, 0),
+};
+
+int wcn36xx_smd_add_beacon_filter(struct wcn36xx *wcn,
+				  struct ieee80211_vif *vif)
+{
+	struct wcn36xx_hal_add_bcn_filter_req_msg msg_body, *body;
+	struct wcn36xx_vif *vif_priv = wcn36xx_vif_to_priv(vif);
+	u8 *payload;
+	size_t payload_size;
+	int ret;
+
+	if (!get_feat_caps(wcn->fw_feat_caps, BCN_FILTER))
+		return -EOPNOTSUPP;
+
+	mutex_lock(&wcn->hal_mutex);
+	INIT_HAL_MSG(msg_body, WCN36XX_HAL_ADD_BCN_FILTER_REQ);
+
+	PREPARE_HAL_BUF(wcn->hal_buf, msg_body);
+
+	body = (struct wcn36xx_hal_add_bcn_filter_req_msg *)wcn->hal_buf;
+	body->capability_info = vif->bss_conf.assoc_capability;
+	body->capability_mask = WCN36XX_FILTER_CAPABILITY_MASK;
+	body->beacon_interval = vif->bss_conf.beacon_int;
+	body->ie_num = ARRAY_SIZE(bcn_filter_ies);
+	body->bss_index = vif_priv->bss_index;
+
+	payload = ((u8 *)body) + body->header.len;
+	payload_size = sizeof(bcn_filter_ies);
+	memcpy(payload, &bcn_filter_ies, payload_size);
+
+	body->header.len += payload_size;
+
+	ret = wcn36xx_smd_send_and_wait(wcn, body->header.len);
+	if (ret) {
+		wcn36xx_err("Sending add bcn_filter failed\n");
+		goto out;
+	}
+
+	ret = wcn36xx_smd_rsp_status_check(wcn->hal_buf, wcn->hal_rsp_len);
+	if (ret) {
+		wcn36xx_err("add bcn filter response failed err=%d\n", ret);
+		goto out;
+	}
+out:
+	mutex_unlock(&wcn->hal_mutex);
+	return ret;
+}
+
 int wcn36xx_smd_rsp_process(struct rpmsg_device *rpdev,
 			    void *buf, int len, void *priv, u32 addr)
 {
@@ -3248,6 +3351,7 @@ int wcn36xx_smd_rsp_process(struct rpmsg_device *rpdev,
 	case WCN36XX_HAL_ENTER_IMPS_RSP:
 	case WCN36XX_HAL_EXIT_IMPS_RSP:
 	case WCN36XX_HAL_UPDATE_CHANNEL_LIST_RSP:
+	case WCN36XX_HAL_ADD_BCN_FILTER_RSP:
 		memcpy(wcn->hal_buf, buf, len);
 		wcn->hal_rsp_len = len;
 		complete(&wcn->hal_rsp_compl);
diff --git a/drivers/net/wireless/ath/wcn36xx/smd.h b/drivers/net/wireless/ath/wcn36xx/smd.h
index cfde15341a88d..957cfa87fbdea 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.h
+++ b/drivers/net/wireless/ath/wcn36xx/smd.h
@@ -167,4 +167,7 @@ int wcn36xx_smd_host_resume(struct wcn36xx *wcn);
 int wcn36xx_smd_enter_imps(struct wcn36xx *wcn);
 int wcn36xx_smd_exit_imps(struct wcn36xx *wcn);
 
+int wcn36xx_smd_add_beacon_filter(struct wcn36xx *wcn,
+				  struct ieee80211_vif *vif);
+
 #endif	/* _SMD_H_ */
-- 
2.33.0

