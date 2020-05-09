Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 629F11CBBA5
	for <lists+linux-wireless@lfdr.de>; Sat,  9 May 2020 02:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728371AbgEIANd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 8 May 2020 20:13:33 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:22985 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728365AbgEIANc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 8 May 2020 20:13:32 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588983211; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: References: In-Reply-To: Message-Id: Date: Subject: Cc:
 To: From: Sender; bh=0KydgDVkyQrj1WbuFY977D49Oq+9F4mu8tFdGtKqMt4=; b=B4H8yp+ecWwgkoPt28XUn6zsgyNUxwGdgVaC/9ayOYMIiXI06CXQbIFm9/elSpd2e+CfWMm0
 lJNMZwWG7reeBg1+FjdiPp4KJX1OawbgGIXFnqSDzfyP4TYJYFauSae40ebUc3przio/J+o8
 rojdaOUXWSEWH97xkf1kPfgzxQ8=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eb5f5a2.7f722327bf80-smtp-out-n03;
 Sat, 09 May 2020 00:13:22 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 0066FC4478F; Sat,  9 May 2020 00:13:21 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from rmanohar-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rmanohar)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id ECB93C433BA;
        Sat,  9 May 2020 00:13:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org ECB93C433BA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=rmanohar@codeaurora.org
From:   Rajkumar Manoharan <rmanohar@codeaurora.org>
To:     johannes@sipsolutions.net, kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        Rajkumar Manoharan <rmanohar@codeaurora.org>
Subject: [PATCH v3 03/11] nl80211: add HE 6 GHz Band Capability support
Date:   Fri,  8 May 2020 17:12:57 -0700
Message-Id: <1588983185-5741-3-git-send-email-rmanohar@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1588983185-5741-1-git-send-email-rmanohar@codeaurora.org>
References: <1588983185-5741-1-git-send-email-rmanohar@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Define new structures for HE 6 GHz band capabilities as per
IEEE P802.11ax/D6.0, 9.4.2.261 HE 6 GHz Band Capabilities element
and 6 GHz Operation Information field of HE operation element
(IEEE P802.11ax/D6.0, Figure 9-787k).

Signed-off-by: Rajkumar Manoharan <rmanohar@codeaurora.org>
---
 include/linux/ieee80211.h | 57 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index 16268ef1cbcc..77462dff6db3 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -1632,6 +1632,44 @@ struct ieee80211_he_mcs_nss_supp {
 } __packed;
 
 /**
+ * enum ieee80211_he_6ghz_chanwidth - HE 6 GHz channel width
+ * @IEEE80211_HE_6GHZ_CHANWIDTH_20MHZ: 20 MHz bandwidth
+ * @IEEE80211_HE_6GHZ_CHANWIDTH_40MHZ: 40 MHz bandwidth
+ * @IEEE80211_HE_6GHZ_CHANWIDTH_80MHZ: 80 MHz bandwidth
+ * @IEEE80211_HE_6GHZ_CHANWIDTH_80P80MHZ: 160 or 80+80 MHz bandwidth
+ */
+enum ieee80211_he_6ghz_chanwidth {
+	IEEE80211_HE_6GHZ_CHANWIDTH_20MHZ		= 0,
+	IEEE80211_HE_6GHZ_CHANWIDTH_40MHZ		= 1,
+	IEEE80211_HE_6GHZ_CHANWIDTH_80MHZ		= 2,
+	IEEE80211_HE_6GHZ_CHANWIDTH_160MHZ_80P80MHZ	= 3,
+};
+
+/**
+ * struct ieee80211_he_oper_6ghz_op_info - 6 GHz Operation Information
+ *
+ * This structure is defined as described in IEEE P802.11ax/D6.0,
+ * Figure 9-787k—6 GHz Operation Information field.
+ *
+ * @primary_chan: The channel number of the primary channel in the 6 GHz band.
+ * @control: First two bits defines channel width field indicates the BSS
+ *	channel width and is set to 0 for 20 MHz, 1 for 40 MHz, 2 for 80 MHz,
+ *	and 3 for 80+80 or 160 MHz.
+ * @center_freq_seg0_idx: Channel center frequency index for the 20 MHz,
+ *	40 MHz, or 80 MHz, or 80+80 MHz.
+ * @center_freq_seg1_idx: Channel center frequency index of the 160 MHz.
+ * @min_rate: Minimum rate, in units of 1 Mb/s, that the non-AP STA is allowed
+ *	to use for sending PPDUs.
+ */
+struct ieee80211_he_oper_6ghz_op_info {
+	u8 primary_chan;
+	u8 control;
+	u8 center_freq_seg0_idx;
+	u8 center_freq_seg1_idx;
+	u8 min_rate;
+} __packed;
+
+/**
  * struct ieee80211_he_operation - HE capabilities element
  *
  * This structure is the "HE operation element" fields as
@@ -1682,6 +1720,15 @@ struct ieee80211_mu_edca_param_set {
 	struct ieee80211_he_mu_edca_param_ac_rec ac_vo;
 } __packed;
 
+/**
+ * struct ieee80211_he_6ghz_band_cap - HE 6 GHz Band Capabilities element
+ *
+ * This structure is defined as described in IEEE P802.11ax/D6.0, 9.4.2.261.
+ */
+struct ieee80211_he_6ghz_band_cap {
+	__le16 capab;
+} __packed;
+
 /* 802.11ac VHT Capabilities */
 #define IEEE80211_VHT_CAP_MAX_MPDU_LENGTH_3895			0x00000000
 #define IEEE80211_VHT_CAP_MAX_MPDU_LENGTH_7991			0x00000001
@@ -1982,6 +2029,15 @@ int ieee80211_get_vht_max_nss(struct ieee80211_vht_cap *cap,
 #define IEEE80211_TX_RX_MCS_NSS_SUPP_TX_BITMAP_MASK			0x07c0
 #define IEEE80211_TX_RX_MCS_NSS_SUPP_RX_BITMAP_MASK			0xf800
 
+/* 802.11ax HE 6 GHz Band Capability */
+#define IEEE80211_HE_6GHZ_CAP_MIN_MPDU_START_SPACE_MASK		GENMASK(2, 0)
+#define IEEE80211_HE_6GHZ_CAP_MAX_A_MPDU_LENGTH_EXPONENT_MASK	GENMASK(5, 3)
+#define IEEE80211_HE_6GHZ_CAP_MAX_MPDU_LENGTH_MASK		GENMASK(7, 6)
+#define IEEE80211_HE_6GHZ_CAP_SMPS_MASK				GENMASK(10, 9)
+#define IEEE80211_HE_6GHZ_CAP_RD_RESP				BIT(11)
+#define IEEE80211_HE_6GHZ_CAP_RX_ANTENNA_PATTERN		BIT(12)
+#define IEEE80211_HE_6GHZ_CAP_TX_ANTENNA_PATTERN		BIT(13)
+
 /* TX/RX HE MCS Support field Highest MCS subfield encoding */
 enum ieee80211_he_highest_mcs_supported_subfield_enc {
 	HIGHEST_MCS_SUPPORTED_MCS7 = 0,
@@ -2059,6 +2115,7 @@ ieee80211_he_ppe_size(u8 ppe_thres_hdr, const u8 *phy_cap_info)
 #define IEEE80211_HE_OPERATION_BSS_COLOR_OFFSET			24
 #define IEEE80211_HE_OPERATION_PARTIAL_BSS_COLOR		0x40000000
 #define IEEE80211_HE_OPERATION_BSS_COLOR_DISABLED		0x80000000
+#define IEEE80211_HE_OPERATION_6GHZ_OP_INFO_CTRL_CHAN_WIDTH	0x3
 
 /*
  * ieee80211_he_oper_size - calculate 802.11ax HE Operations IE size
-- 
2.7.4
