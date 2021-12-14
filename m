Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09A924743BF
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Dec 2021 14:44:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234524AbhLNNoc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Dec 2021 08:44:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234519AbhLNNob (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Dec 2021 08:44:31 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD7C9C061756
        for <linux-wireless@vger.kernel.org>; Tue, 14 Dec 2021 05:44:30 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id u17so32486801wrt.3
        for <linux-wireless@vger.kernel.org>; Tue, 14 Dec 2021 05:44:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mGEAJEXtZGbf3P6h2PQMWH6TzjiJnSEaoubmRK35wQM=;
        b=xF0MD93P6pSd0+8TSGKeUn/DFLEYvE9JVvZMGywn9Srfj/qa2IszI+KTUKC4D1/FAJ
         a/Kyea/DgfRlHlKiV2qzRYrsPF5iUrP8NVfDLjAkiOlZsgb04xxMKKOxr9UGVWvekPbt
         Q4pUuNkreGCH4SKfZGVycPs43gESsHKu0Qv2P111rwrNZfH+PCW5fsluTjsOSduvdKYA
         J7tNwsDVksZ3iWTEXmwhtLZtlZy65+yndQuD9bnp6qpCaQf+qOH1iTRtlg85zvQ05GCn
         pOsvGoYWZNIV7JlM7AJoNi/0wJVQ82FrOjaX02L2p0YQkdyfw0rA2ukuRP7fKLM43jVX
         Pbxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mGEAJEXtZGbf3P6h2PQMWH6TzjiJnSEaoubmRK35wQM=;
        b=F0RVBuHxQFb/p7OvoGXo4jutuQmjWvZIONC4m2Jkzf4kNqAvLalmGpUmhHLUsxjjLi
         M13oUxlu8DBh4flEAwUbm/SspJAqU1jerh1Xms81Kf/HOJbNv+/aNS+FKYSK7+ZckvmL
         h+so4Hcj/FGSzHtOqOPcgHpbrfVdeA4Q6jhVntTARR3WPZaMBaijKNHUAB/mV1BXar9o
         lUueP4EMsbFpKYasKiLcoJBg3O/uM03CqUFsrc654C7uKGpljwWtA9H2zo7yRwz5Ivzr
         V9Zrt18DuJy/43BuAsnKbCWXwV1o/Bg1AnOz6IHVD65jH8y2EBcH1xXrlzx6Nez/Ksxl
         0mcQ==
X-Gm-Message-State: AOAM530zLDrb9KPeSsuSUsdTAO9B03nTGBq8bY1mfmoqQMokE8J/fSdV
        jTITivd4HlsNW+KOPiupiNTClg==
X-Google-Smtp-Source: ABdhPJxh8Q6xsiueV6lpI26YRWd3mA02LTC+Hysj2OonmFn2Mi8dIGLQg6YCu/GtI2amXtbHiRWQwQ==
X-Received: by 2002:a5d:52c3:: with SMTP id r3mr5981800wrv.115.1639489468946;
        Tue, 14 Dec 2021 05:44:28 -0800 (PST)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id g19sm2309592wmg.12.2021.12.14.05.44.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 05:44:28 -0800 (PST)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org,
        wcn36xx@lists.infradead.org, linux-arm-msm@vger.kernel.org
Cc:     loic.poulain@linaro.org, benl@squareup.com,
        bryan.odonoghue@linaro.org
Subject: [PATCH v3 3/3] wcn36xx: Implement downstream compliant beacon filtering
Date:   Tue, 14 Dec 2021 13:46:30 +0000
Message-Id: <20211214134630.2214840-4-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211214134630.2214840-1-bryan.odonoghue@linaro.org>
References: <20211214134630.2214840-1-bryan.odonoghue@linaro.org>
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
 drivers/net/wireless/ath/wcn36xx/hal.h  | 17 +++++
 drivers/net/wireless/ath/wcn36xx/main.c |  2 +
 drivers/net/wireless/ath/wcn36xx/smd.c  | 87 +++++++++++++++++++++++++
 drivers/net/wireless/ath/wcn36xx/smd.h  |  3 +
 4 files changed, 109 insertions(+)

diff --git a/drivers/net/wireless/ath/wcn36xx/hal.h b/drivers/net/wireless/ath/wcn36xx/hal.h
index e9fec110721b5..a6968f9785d6f 100644
--- a/drivers/net/wireless/ath/wcn36xx/hal.h
+++ b/drivers/net/wireless/ath/wcn36xx/hal.h
@@ -3468,6 +3468,23 @@ struct beacon_filter_ie {
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
+#define WCN36XX_FILTER_IE_PWR_CONSTRAINT_MASK	0x00
+#define WCN36XX_FILTER_IE_OPMODE_NOTIF_MASK	0x00
+#define WCN36XX_FILTER_IE_VHTOP_CHWIDTH_MASK	0xFC
+#define WCN36XX_FILTER_IE_RSN_MASK		0x00
+#define WCN36XX_FILTER_IE_VENDOR_MASK		0x00
+
 /* The above structure would be followed by multiple of below mentioned
  * structure
  */
diff --git a/drivers/net/wireless/ath/wcn36xx/main.c b/drivers/net/wireless/ath/wcn36xx/main.c
index f59eb1119da88..ec355807f5817 100644
--- a/drivers/net/wireless/ath/wcn36xx/main.c
+++ b/drivers/net/wireless/ath/wcn36xx/main.c
@@ -934,6 +934,8 @@ static void wcn36xx_bss_info_changed(struct ieee80211_hw *hw,
 			 * place where AID is available.
 			 */
 			wcn36xx_smd_config_sta(wcn, vif, sta);
+			if (vif->type == NL80211_IFTYPE_STATION)
+				wcn36xx_smd_add_beacon_filter(wcn, vif);
 			wcn36xx_enable_keep_alive_null_packet(wcn, vif);
 		} else {
 			wcn36xx_dbg(WCN36XX_DBG_MAC,
diff --git a/drivers/net/wireless/ath/wcn36xx/smd.c b/drivers/net/wireless/ath/wcn36xx/smd.c
index b05d10f9f6005..6791853088d61 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.c
+++ b/drivers/net/wireless/ath/wcn36xx/smd.c
@@ -3193,6 +3193,92 @@ int wcn36xx_smd_host_resume(struct wcn36xx *wcn)
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
@@ -3248,6 +3334,7 @@ int wcn36xx_smd_rsp_process(struct rpmsg_device *rpdev,
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

