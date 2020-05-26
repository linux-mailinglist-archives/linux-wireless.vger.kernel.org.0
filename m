Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 981861E32E9
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2020 00:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404437AbgEZWsH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 26 May 2020 18:48:07 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:12951 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404359AbgEZWsG (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 26 May 2020 18:48:06 -0400
X-Greylist: delayed 300 seconds by postgrey-1.27 at vger.kernel.org; Tue, 26 May 2020 18:47:38 EDT
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1590533286; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=CJcZabUe+RZRkUgdEd0lB4wY0h4EeYTXmof575DZ0v0=; b=RDPwx3SpXWBp04J39Xj/ZV69Ys5455Ph1jxQ/A8xyGVju4yL++eTrkQnP9j6olxAb6V6BHYq
 3421okKpg9Ieec0OCIdoDOuYvJ3xWYsQ7tBvlzV6V2aFWH+SU6bDfBNAmAP5i8CfBfffxxom
 GvbFz7XbgASLUNd49SFCjRDz2g0=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 5ecd9b61c6d468324324fa7f (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 26 May 2020 22:42:41
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 13001C43387; Tue, 26 May 2020 22:42:41 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from pradeepc2-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pradeepc)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2F1DAC433CA;
        Tue, 26 May 2020 22:42:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2F1DAC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=pradeepc@codeaurora.org
From:   Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>,
        ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
Subject: [PATCH v3 9/9] ath11k: Add support for 6g scan hint
Date:   Tue, 26 May 2020 15:42:17 -0700
Message-Id: <20200526224217.11119-10-pradeepc@codeaurora.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200526224217.11119-1-pradeepc@codeaurora.org>
References: <20200526224217.11119-1-pradeepc@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add support for 6Ghz short ssid and bssid hint mechanism
as part of scan command.

Signed-off-by: Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/wmi.c | 72 +++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/wmi.h | 22 ++++++++
 2 files changed, 94 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index ad3a7b68d308..317376a4eb6e 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -2005,6 +2005,8 @@ int ath11k_wmi_send_scan_start_cmd(struct ath11k *ar,
 	int i, ret, len;
 	u32 *tmp_ptr;
 	u8 extraie_len_with_pad = 0;
+	struct hint_short_ssid *s_ssid = NULL;
+	struct hint_bssid *hint_bssid = NULL;
 
 	len = sizeof(*cmd);
 
@@ -2026,6 +2028,14 @@ int ath11k_wmi_send_scan_start_cmd(struct ath11k *ar,
 			roundup(params->extraie.len, sizeof(u32));
 	len += extraie_len_with_pad;
 
+	if (params->num_hint_bssid)
+		len += TLV_HDR_SIZE +
+		       params->num_hint_bssid * sizeof(struct hint_bssid);
+
+	if (params->num_hint_s_ssid)
+		len += TLV_HDR_SIZE +
+		       params->num_hint_s_ssid * sizeof(struct hint_short_ssid);
+
 	skb = ath11k_wmi_alloc_skb(wmi->wmi_ab, len);
 	if (!skb)
 		return -ENOMEM;
@@ -2126,6 +2136,68 @@ int ath11k_wmi_send_scan_start_cmd(struct ath11k *ar,
 
 	ptr += extraie_len_with_pad;
 
+	if (params->num_hint_s_ssid) {
+		len = params->num_hint_s_ssid * sizeof(struct hint_short_ssid);
+		tlv = ptr;
+		tlv->header = FIELD_PREP(WMI_TLV_TAG, WMI_TAG_ARRAY_FIXED_STRUCT) |
+			      FIELD_PREP(WMI_TLV_LEN, len);
+		ptr += TLV_HDR_SIZE;
+		s_ssid = ptr;
+		for (i = 0; i < params->num_hint_s_ssid; ++i) {
+			s_ssid->freq_flags = params->hint_s_ssid[i].freq_flags;
+			s_ssid->short_ssid = params->hint_s_ssid[i].short_ssid;
+			s_ssid++;
+		}
+		ptr += len;
+	}
+
+	if (params->num_hint_bssid) {
+		len = params->num_hint_bssid * sizeof(struct hint_bssid);
+		tlv = ptr;
+		tlv->header = FIELD_PREP(WMI_TLV_TAG, WMI_TAG_ARRAY_FIXED_STRUCT) |
+			      FIELD_PREP(WMI_TLV_LEN, len);
+		ptr += TLV_HDR_SIZE;
+		hint_bssid = ptr;
+		for (i = 0; i < params->num_hint_bssid; ++i) {
+			hint_bssid->freq_flags =
+				params->hint_bssid[i].freq_flags;
+			ether_addr_copy(&params->hint_bssid[i].bssid.addr[0],
+					&hint_bssid->bssid.addr[0]);
+			hint_bssid++;
+		}
+	}
+
+	len = params->num_hint_s_ssid * sizeof(struct hint_short_ssid);
+	tlv = ptr;
+	tlv->header = FIELD_PREP(WMI_TLV_TAG, WMI_TAG_ARRAY_FIXED_STRUCT) |
+		      FIELD_PREP(WMI_TLV_LEN, len);
+	ptr += TLV_HDR_SIZE;
+	if (params->num_hint_s_ssid) {
+		s_ssid = ptr;
+		for (i = 0; i < params->num_hint_s_ssid; ++i) {
+			s_ssid->freq_flags = params->hint_s_ssid[i].freq_flags;
+			s_ssid->short_ssid = params->hint_s_ssid[i].short_ssid;
+			s_ssid++;
+		}
+	}
+	ptr += len;
+
+	len = params->num_hint_bssid * sizeof(struct hint_bssid);
+	tlv = ptr;
+	tlv->header = FIELD_PREP(WMI_TLV_TAG, WMI_TAG_ARRAY_FIXED_STRUCT) |
+		      FIELD_PREP(WMI_TLV_LEN, len);
+	ptr += TLV_HDR_SIZE;
+	if (params->num_hint_bssid) {
+		hint_bssid = ptr;
+		for (i = 0; i < params->num_hint_bssid; ++i) {
+			hint_bssid->freq_flags =
+				params->hint_bssid[i].freq_flags;
+			ether_addr_copy(&params->hint_bssid[i].bssid.addr[0],
+					&hint_bssid->bssid.addr[0]);
+			hint_bssid++;
+		}
+	}
+
 	ret = ath11k_wmi_cmd_send(wmi, skb,
 				  WMI_START_SCAN_CMDID);
 	if (ret) {
diff --git a/drivers/net/wireless/ath/ath11k/wmi.h b/drivers/net/wireless/ath/ath11k/wmi.h
index 319ad7241e01..1162bd7a5f87 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.h
+++ b/drivers/net/wireless/ath/ath11k/wmi.h
@@ -50,6 +50,14 @@ struct wmi_tlv {
 #define WMI_MAX_MEM_REQS        32
 #define ATH11K_MAX_HW_LISTEN_INTERVAL 5
 
+#define WLAN_SCAN_MAX_HINT_S_SSID        10
+#define WLAN_SCAN_MAX_HINT_BSSID         10
+#define MAX_RNR_BSS                    5
+
+#define WLAN_SCAN_MAX_HINT_S_SSID        10
+#define WLAN_SCAN_MAX_HINT_BSSID         10
+#define MAX_RNR_BSS                    5
+
 #define WLAN_SCAN_PARAMS_MAX_SSID    16
 #define WLAN_SCAN_PARAMS_MAX_BSSID   4
 #define WLAN_SCAN_PARAMS_MAX_IE_LEN  256
@@ -3105,6 +3113,16 @@ enum {
 	((flag) |= (((mode) << WMI_SCAN_DWELL_MODE_SHIFT) & \
 		    WMI_SCAN_DWELL_MODE_MASK))
 
+struct hint_short_ssid {
+	u32 freq_flags;
+	u32 short_ssid;
+};
+
+struct hint_bssid {
+	u32 freq_flags;
+	struct wmi_mac_addr bssid;
+};
+
 struct scan_req_params {
 	u32 scan_id;
 	u32 scan_req_id;
@@ -3184,6 +3202,10 @@ struct scan_req_params {
 	struct element_info extraie;
 	struct element_info htcap;
 	struct element_info vhtcap;
+	u32 num_hint_s_ssid;
+	u32 num_hint_bssid;
+	struct hint_short_ssid hint_s_ssid[WLAN_SCAN_MAX_HINT_S_SSID];
+	struct hint_bssid hint_bssid[WLAN_SCAN_MAX_HINT_BSSID];
 };
 
 struct wmi_ssid_arg {
-- 
2.17.1

