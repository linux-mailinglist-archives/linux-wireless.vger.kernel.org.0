Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E888D1EC62D
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jun 2020 02:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728460AbgFCARw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 2 Jun 2020 20:17:52 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:11575 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726589AbgFCARv (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 2 Jun 2020 20:17:51 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1591143470; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=wRB2x5YBGu8y0aaTsAuF2pP+fvYpS6Tgm+EjAvYB4iY=; b=fHwRXk9muXs1y3kSPIvJ3jQz3gEZZ370fYtJHtyetEswU1w57gv2gNZlnCcn7fxnscTiv8EB
 gWlMEkotT2QE4nrVkJGij6C+Kpf0yvNVgMYZDtKuhQ3KEoLVed9YrSWYjXLgLqAxDLX+ZtWB
 PjiQRxQrfCvVaUbf5jf6pKen8Lk=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 5ed6ec1d09c3530d12c5e98b (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 03 Jun 2020 00:17:33
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A01F1C43395; Wed,  3 Jun 2020 00:17:33 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from pradeepc2-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pradeepc)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9A61CC433CA;
        Wed,  3 Jun 2020 00:17:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9A61CC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=pradeepc@codeaurora.org
From:   Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
Subject: [PATCH v5 7/8] ath11k: Send multiple scan_chan_list messages if required
Date:   Tue,  2 Jun 2020 17:17:23 -0700
Message-Id: <20200603001724.12161-8-pradeepc@codeaurora.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200603001724.12161-1-pradeepc@codeaurora.org>
References: <20200603001724.12161-1-pradeepc@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

With addition of 6Ghz channels, it is possible that wmi buffer size can
exceed the maximum wmi buffer size. So iterate over the channel list,
and send multiple messages till channel list is empty.
Also mark PSC channel flag for 6GHz channels accordingly.

Signed-off-by: Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/wmi.c | 170 ++++++++++++++------------
 drivers/net/wireless/ath/ath11k/wmi.h |   3 +
 2 files changed, 98 insertions(+), 75 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index 239a336f55f4..ad3a7b68d308 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -2194,91 +2194,111 @@ int ath11k_wmi_send_scan_chan_list_cmd(struct ath11k *ar,
 	struct channel_param *tchan_info;
 	struct wmi_tlv *tlv;
 	void *ptr;
-	int i, ret, len;
+	int i, ret = 0, len;
+	u16 num_send_chans, num_sends = 0, max_chan_limit = 0;
 	u32 *reg1, *reg2;
 
-	len = sizeof(*cmd) + TLV_HDR_SIZE +
-		 sizeof(*chan_info) * chan_list->nallchans;
-
-	skb = ath11k_wmi_alloc_skb(wmi->wmi_ab, len);
-	if (!skb)
-		return -ENOMEM;
-
-	cmd = (struct wmi_scan_chan_list_cmd *)skb->data;
-	cmd->tlv_header = FIELD_PREP(WMI_TLV_TAG, WMI_TAG_SCAN_CHAN_LIST_CMD) |
-			  FIELD_PREP(WMI_TLV_LEN, sizeof(*cmd) - TLV_HDR_SIZE);
-
-	ath11k_dbg(ar->ab, ATH11K_DBG_WMI,
-		   "WMI no.of chan = %d len = %d\n", chan_list->nallchans, len);
-	cmd->pdev_id = chan_list->pdev_id;
-	cmd->num_scan_chans = chan_list->nallchans;
-
-	ptr = skb->data + sizeof(*cmd);
-
-	len = sizeof(*chan_info) * chan_list->nallchans;
-	tlv = ptr;
-	tlv->header = FIELD_PREP(WMI_TLV_TAG, WMI_TAG_ARRAY_STRUCT) |
-		      FIELD_PREP(WMI_TLV_LEN, len - TLV_HDR_SIZE);
-	ptr += TLV_HDR_SIZE;
-
 	tchan_info = &chan_list->ch_param[0];
+	while (chan_list->nallchans) {
+		len = sizeof(*cmd) + TLV_HDR_SIZE;
+		max_chan_limit =
+			(wmi->wmi_ab->max_msg_len[ar->pdev_idx] - len) /
+			sizeof(*chan_info);
+
+		if (chan_list->nallchans > max_chan_limit)
+			num_send_chans = max_chan_limit;
+		else
+			num_send_chans = chan_list->nallchans;
+
+		chan_list->nallchans -= num_send_chans;
+		len += sizeof(*chan_info) * num_send_chans;
+
+		skb = ath11k_wmi_alloc_skb(wmi->wmi_ab, len);
+		if (!skb)
+			return -ENOMEM;
 
-	for (i = 0; i < chan_list->nallchans; ++i) {
-		chan_info = ptr;
-		memset(chan_info, 0, sizeof(*chan_info));
-		len = sizeof(*chan_info);
-		chan_info->tlv_header = FIELD_PREP(WMI_TLV_TAG,
-						   WMI_TAG_CHANNEL) |
-					FIELD_PREP(WMI_TLV_LEN,
-						   len - TLV_HDR_SIZE);
-
-		reg1 = &chan_info->reg_info_1;
-		reg2 = &chan_info->reg_info_2;
-		chan_info->mhz = tchan_info->mhz;
-		chan_info->band_center_freq1 = tchan_info->cfreq1;
-		chan_info->band_center_freq2 = tchan_info->cfreq2;
-
-		if (tchan_info->is_chan_passive)
-			chan_info->info |= WMI_CHAN_INFO_PASSIVE;
-		if (tchan_info->allow_he)
-			chan_info->info |= WMI_CHAN_INFO_ALLOW_HE;
-		else if (tchan_info->allow_vht)
-			chan_info->info |= WMI_CHAN_INFO_ALLOW_VHT;
-		else if (tchan_info->allow_ht)
-			chan_info->info |= WMI_CHAN_INFO_ALLOW_HT;
-		if (tchan_info->half_rate)
-			chan_info->info |= WMI_CHAN_INFO_HALF_RATE;
-		if (tchan_info->quarter_rate)
-			chan_info->info |= WMI_CHAN_INFO_QUARTER_RATE;
-
-		chan_info->info |= FIELD_PREP(WMI_CHAN_INFO_MODE,
-					      tchan_info->phy_mode);
-		*reg1 |= FIELD_PREP(WMI_CHAN_REG_INFO1_MIN_PWR,
-				    tchan_info->minpower);
-		*reg1 |= FIELD_PREP(WMI_CHAN_REG_INFO1_MAX_PWR,
-				    tchan_info->maxpower);
-		*reg1 |= FIELD_PREP(WMI_CHAN_REG_INFO1_MAX_REG_PWR,
-				    tchan_info->maxregpower);
-		*reg1 |= FIELD_PREP(WMI_CHAN_REG_INFO1_REG_CLS,
-				    tchan_info->reg_class_id);
-		*reg2 |= FIELD_PREP(WMI_CHAN_REG_INFO2_ANT_MAX,
-				    tchan_info->antennamax);
+		cmd = (struct wmi_scan_chan_list_cmd *)skb->data;
+		cmd->tlv_header = FIELD_PREP(WMI_TLV_TAG, WMI_TAG_SCAN_CHAN_LIST_CMD) |
+			FIELD_PREP(WMI_TLV_LEN, sizeof(*cmd) - TLV_HDR_SIZE);
+		cmd->pdev_id = chan_list->pdev_id;
+		cmd->num_scan_chans = num_send_chans;
+		if (num_sends)
+			cmd->flags |= WMI_APPEND_TO_EXISTING_CHAN_LIST_FLAG;
 
 		ath11k_dbg(ar->ab, ATH11K_DBG_WMI,
-			   "WMI chan scan list chan[%d] = %u\n",
-			   i, chan_info->mhz);
+			   "WMI no.of chan = %d len = %d pdev_id = %d num_sends = %d\n",
+			   num_send_chans, len, cmd->pdev_id, num_sends);
 
-		ptr += sizeof(*chan_info);
+		ptr = skb->data + sizeof(*cmd);
 
-		tchan_info++;
-	}
+		len = sizeof(*chan_info) * num_send_chans;
+		tlv = ptr;
+		tlv->header = FIELD_PREP(WMI_TLV_TAG, WMI_TAG_ARRAY_STRUCT) |
+			      FIELD_PREP(WMI_TLV_LEN, len - TLV_HDR_SIZE);
+		ptr += TLV_HDR_SIZE;
 
-	ret = ath11k_wmi_cmd_send(wmi, skb, WMI_SCAN_CHAN_LIST_CMDID);
-	if (ret) {
-		ath11k_warn(ar->ab, "failed to send WMI_SCAN_CHAN_LIST cmd\n");
-		dev_kfree_skb(skb);
-	}
+		for (i = 0; i < num_send_chans; ++i) {
+			chan_info = ptr;
+			memset(chan_info, 0, sizeof(*chan_info));
+			len = sizeof(*chan_info);
+			chan_info->tlv_header = FIELD_PREP(WMI_TLV_TAG,
+							   WMI_TAG_CHANNEL) |
+						FIELD_PREP(WMI_TLV_LEN,
+							   len - TLV_HDR_SIZE);
+
+			reg1 = &chan_info->reg_info_1;
+			reg2 = &chan_info->reg_info_2;
+			chan_info->mhz = tchan_info->mhz;
+			chan_info->band_center_freq1 = tchan_info->cfreq1;
+			chan_info->band_center_freq2 = tchan_info->cfreq2;
+
+			if (tchan_info->is_chan_passive)
+				chan_info->info |= WMI_CHAN_INFO_PASSIVE;
+			if (tchan_info->allow_he)
+				chan_info->info |= WMI_CHAN_INFO_ALLOW_HE;
+			else if (tchan_info->allow_vht)
+				chan_info->info |= WMI_CHAN_INFO_ALLOW_VHT;
+			else if (tchan_info->allow_ht)
+				chan_info->info |= WMI_CHAN_INFO_ALLOW_HT;
+			if (tchan_info->half_rate)
+				chan_info->info |= WMI_CHAN_INFO_HALF_RATE;
+			if (tchan_info->quarter_rate)
+				chan_info->info |= WMI_CHAN_INFO_QUARTER_RATE;
+			if (tchan_info->psc_channel)
+				chan_info->info |= WMI_CHAN_INFO_PSC;
+
+			chan_info->info |= FIELD_PREP(WMI_CHAN_INFO_MODE,
+						      tchan_info->phy_mode);
+			*reg1 |= FIELD_PREP(WMI_CHAN_REG_INFO1_MIN_PWR,
+					    tchan_info->minpower);
+			*reg1 |= FIELD_PREP(WMI_CHAN_REG_INFO1_MAX_PWR,
+					    tchan_info->maxpower);
+			*reg1 |= FIELD_PREP(WMI_CHAN_REG_INFO1_MAX_REG_PWR,
+					    tchan_info->maxregpower);
+			*reg1 |= FIELD_PREP(WMI_CHAN_REG_INFO1_REG_CLS,
+					    tchan_info->reg_class_id);
+			*reg2 |= FIELD_PREP(WMI_CHAN_REG_INFO2_ANT_MAX,
+					    tchan_info->antennamax);
+
+			ath11k_dbg(ar->ab, ATH11K_DBG_WMI,
+				   "WMI chan scan list chan[%d] = %u, chan_info->info %8x\n",
+				   i, chan_info->mhz, chan_info->info);
+
+			ptr += sizeof(*chan_info);
+
+			tchan_info++;
+		}
 
+		ret = ath11k_wmi_cmd_send(wmi, skb, WMI_SCAN_CHAN_LIST_CMDID);
+		if (ret) {
+			ath11k_warn(ar->ab, "failed to send WMI_SCAN_CHAN_LIST cmd\n");
+			dev_kfree_skb(skb);
+			goto end;
+		}
+
+		num_sends++;
+	}
+end:
 	return ret;
 }
 
diff --git a/drivers/net/wireless/ath/ath11k/wmi.h b/drivers/net/wireless/ath/ath11k/wmi.h
index 4937d02839fc..319ad7241e01 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.h
+++ b/drivers/net/wireless/ath/ath11k/wmi.h
@@ -54,6 +54,8 @@ struct wmi_tlv {
 #define WLAN_SCAN_PARAMS_MAX_BSSID   4
 #define WLAN_SCAN_PARAMS_MAX_IE_LEN  256
 
+#define WMI_APPEND_TO_EXISTING_CHAN_LIST_FLAG 1
+
 #define WMI_BA_MODE_BUFFER_SIZE_256  3
 /*
  * HW mode config type replicated from FW header
@@ -3271,6 +3273,7 @@ struct  wmi_bcn_send_from_host_cmd {
 #define WMI_CHAN_INFO_QUARTER_RATE	BIT(15)
 #define WMI_CHAN_INFO_DFS_FREQ2		BIT(16)
 #define WMI_CHAN_INFO_ALLOW_HE		BIT(17)
+#define WMI_CHAN_INFO_PSC		BIT(18)
 
 #define WMI_CHAN_REG_INFO1_MIN_PWR	GENMASK(7, 0)
 #define WMI_CHAN_REG_INFO1_MAX_PWR	GENMASK(15, 8)
-- 
2.17.1

