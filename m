Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F2A7EDFBE
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Nov 2019 13:09:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728857AbfKDMJv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 4 Nov 2019 07:09:51 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:41970 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728671AbfKDMJv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 4 Nov 2019 07:09:51 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id F2E1160A1B; Mon,  4 Nov 2019 12:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1572869390;
        bh=cXuJ9e5wftAJSQP+049qKsJZUlWgpUYplzMsiva7KqA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UalN/vC5IpHekq+zQDK5oVOfZoQfylvDglyJlANHvlWnNZLVh5QQZE8+8yEgeaknD
         tA2/talGX+pWeGW9CaXsDFabtXLpobmJnpdudMD4XXSag3agrN0++sQ+J00CfBYaOI
         s27IOFE4H+YIV7sGMs5I63qLEG7rGqgCP2wjiRcA=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from murugana-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: murugana@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2894C6083E;
        Mon,  4 Nov 2019 12:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1572869388;
        bh=cXuJ9e5wftAJSQP+049qKsJZUlWgpUYplzMsiva7KqA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MOK2WMTqGl6x1UyaGTr27NNZ0ubawujsmyY/wG5eH6o+d9mLnEed8aR7177ZabEtN
         dEyxUTysaJj/C3YJWHDYOgRqy+MtNBoF4z9CvSE5m9c5iINRfhwdnXRi7wB2eXsEsl
         Mxk2KBmxWBgyCRI5uEKuoBxnuIHPl0kgmSuIvfq0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2894C6083E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=murugana@codeaurora.org
From:   Sathishkumar Muruganandam <murugana@codeaurora.org>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
Subject: [PATCH v2 2/2] ath11k: add Wide Band Scan support
Date:   Mon,  4 Nov 2019 17:39:34 +0530
Message-Id: <1572869374-9635-3-git-send-email-murugana@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1572869374-9635-1-git-send-email-murugana@codeaurora.org>
References: <1572869374-9635-1-git-send-email-murugana@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Doing wide band scan instead of normal 20Mhz scan before spectral dump,
allows to fetch FFT reports for the complete requested bandwidth
(40Mhz, 80Mhz).

Below are the FW expectations and configs from host to request
Wide Band Scan,

1. SCAN_PHYMODE_SUPPORT WMI service bit advertised from FW.

2. SCAN_CHAN_LIST_CMD updated with the phymode and other channel params
   of the requested channel to do wide band scan.

3. START_SCAN_CMD updated with all the seven supported TLVs and PHYMODE TLV
   being the last. PHYMODE TLV holds the (wmi_phy_mode + 1) value
   corresponding to wide band scan channel. Scan flags scan_f_wide_band and
   scan_f_passive need to be set for wide band scan request from host.

In case of supporting NL80211_EXT_FEATURE_WIDE_BAND_SCAN,
cfg80211_scan_request holds the cfg80211_chan_def of the requested channel
from which we update the center frequencies and phymode params needed for
SCAN_CHAN_LIST_CMD and START_SCAN_CMD to FW.

Signed-off-by: Sathishkumar Muruganandam <murugana@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/mac.c |  41 ++++++++++--
 drivers/net/wireless/ath/ath11k/wmi.c | 115 +++++++++++++++++++++++++++++++---
 drivers/net/wireless/ath/ath11k/wmi.h |  34 +++++++++-
 3 files changed, 175 insertions(+), 15 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 6f82fdbbd358..56cd6f5d8ced 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -2088,6 +2088,28 @@ static int ath11k_start_scan(struct ath11k *ar,
 	return 0;
 }
 
+static void ath11k_mac_update_scan_params(struct cfg80211_scan_request *req,
+					  struct scan_req_params *arg)
+{
+	int i;
+	struct wmi_chan_info *chan = &arg->chan_list.chan[0];
+	enum nl80211_band band;
+	enum nl80211_chan_width width;
+
+	if (req->chandef) {
+		band = req->chandef->chan->band;
+		width = req->chandef->width;
+	}
+
+	arg->chan_list.num_chan = req->n_channels;
+	for (i = 0; i < arg->chan_list.num_chan; i++) {
+		if (req->channels)
+			chan[i].freq = req->channels[i]->center_freq;
+		if (req->chandef)
+			chan[i].phymode = ath11k_phymodes[band][width];
+	}
+}
+
 static int ath11k_mac_op_hw_scan(struct ieee80211_hw *hw,
 				 struct ieee80211_vif *vif,
 				 struct ieee80211_scan_request *hw_req)
@@ -2144,10 +2166,16 @@ static int ath11k_mac_op_hw_scan(struct ieee80211_hw *hw,
 		arg.scan_flags |= WMI_SCAN_FLAG_PASSIVE;
 	}
 
-	if (req->n_channels) {
-		arg.num_chan = req->n_channels;
-		for (i = 0; i < arg.num_chan; i++)
-			arg.chan_list[i] = req->channels[i]->center_freq;
+	if (req->n_channels)
+		ath11k_mac_update_scan_params(req, &arg);
+
+	if (req->chandef) {
+		arg.scan_f_wide_band = true;
+		arg.scan_f_passive = true;
+		arg.chandef = req->chandef;
+		ret = ath11k_wmi_append_scan_chan_list(ar, &arg);
+		if (ret)
+			goto exit;
 	}
 
 	ret = ath11k_start_scan(ar, &arg);
@@ -5577,6 +5605,11 @@ static int ath11k_mac_register(struct ath11k *ar)
 
 	wiphy_ext_feature_set(ar->hw->wiphy, NL80211_EXT_FEATURE_CQM_RSSI_LIST);
 
+	if (test_bit(WMI_TLV_SERVICE_SCAN_PHYMODE_SUPPORT,
+		     ar->ab->wmi_sc.svc_map))
+		wiphy_ext_feature_set(ar->hw->wiphy,
+				      NL80211_EXT_FEATURE_WIDE_BAND_SCAN);
+
 	ar->hw->wiphy->cipher_suites = cipher_suites;
 	ar->hw->wiphy->n_cipher_suites = ARRAY_SIZE(cipher_suites);
 
diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index ccebf7ce420a..3950c0f94a9e 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -1810,6 +1810,57 @@ int ath11k_wmi_send_peer_assoc_cmd(struct ath11k *ar,
 	return ret;
 }
 
+int ath11k_wmi_append_scan_chan_list(struct ath11k *ar,
+				     struct scan_req_params *arg)
+{
+	struct scan_chan_list_params *params;
+	struct channel_param *ch;
+	struct cfg80211_chan_def *chandef;
+	struct ieee80211_channel *channel;
+	int params_len;
+	int ret;
+
+	params_len = sizeof(struct scan_chan_list_params) +
+			arg->chan_list.num_chan * sizeof(struct channel_param);
+	params = kzalloc(params_len, GFP_KERNEL);
+
+	if (!params)
+		return -ENOMEM;
+
+	params->pdev_id = ar->pdev->pdev_id;
+	params->nallchans = arg->chan_list.num_chan;
+	params->append_chan_list = true;
+
+	ch = params->ch_param;
+	chandef = arg->chandef;
+	channel = chandef->chan;
+
+	ch->mhz = arg->chan_list.chan[0].freq;
+	ch->cfreq1 = chandef->center_freq1;
+	ch->cfreq2 = chandef->center_freq2;
+	ch->phy_mode = arg->chan_list.chan[0].phymode;
+
+	ch->dfs_set =
+		!!(channel->flags & IEEE80211_CHAN_RADAR);
+	ch->is_chan_passive = !!(channel->flags &
+				IEEE80211_CHAN_NO_IR);
+	ch->is_chan_passive |= ch->dfs_set;
+	ch->minpower = 0;
+	ch->maxpower = channel->max_power * 2;
+	ch->maxregpower = channel->max_reg_power * 2;
+	ch->antennamax = channel->max_antenna_gain * 2;
+
+	ath11k_dbg(ar->ab, ATH11K_DBG_WMI,
+		   "scan chan list %d freq %d cfreq1 %d phymode %d is_dfs_ch %u is_chan_passive %u\n",
+		   params->nallchans, ch->mhz, ch->cfreq1, ch->phy_mode,
+		   ch->dfs_set, ch->is_chan_passive);
+
+	ret = ath11k_wmi_send_scan_chan_list_cmd(ar, params);
+	kfree(params);
+
+	return ret;
+}
+
 void ath11k_wmi_start_scan_init(struct ath11k *ar,
 				struct scan_req_params *arg)
 {
@@ -1922,13 +1973,15 @@ int ath11k_wmi_send_scan_start_cmd(struct ath11k *ar,
 	void *ptr;
 	int i, ret, len;
 	u32 *tmp_ptr;
+	u8 *phy_ptr;
 	u8 extraie_len_with_pad = 0;
+	u8 phymode_roundup = 0;
 
 	len = sizeof(*cmd);
 
 	len += TLV_HDR_SIZE;
-	if (params->num_chan)
-		len += params->num_chan * sizeof(u32);
+	if (params->chan_list.num_chan)
+		len += params->chan_list.num_chan * sizeof(u32);
 
 	len += TLV_HDR_SIZE;
 	if (params->num_ssids)
@@ -1944,6 +1997,19 @@ int ath11k_wmi_send_scan_start_cmd(struct ath11k *ar,
 			roundup(params->extraie.len, sizeof(u32));
 	len += extraie_len_with_pad;
 
+	len += TLV_HDR_SIZE;
+	if (params->scan_f_en_ie_whitelist_in_probe)
+		len += params->ie_whitelist.num_vendor_oui *
+				sizeof(struct wmi_vendor_oui);
+
+	len += TLV_HDR_SIZE;
+	if (params->scan_f_wide_band)
+		phymode_roundup =
+			roundup(params->chan_list.num_chan * sizeof(u8),
+				sizeof(u32));
+
+	len += phymode_roundup;
+
 	skb = ath11k_wmi_alloc_skb(wmi->wmi_sc, len);
 	if (!skb)
 		return -ENOMEM;
@@ -1973,7 +2039,7 @@ int ath11k_wmi_send_scan_start_cmd(struct ath11k *ar,
 	cmd->max_scan_time = params->max_scan_time;
 	cmd->probe_delay = params->probe_delay;
 	cmd->burst_duration = params->burst_duration;
-	cmd->num_chan = params->num_chan;
+	cmd->num_chan = params->chan_list.num_chan;
 	cmd->num_bssid = params->num_bssid;
 	cmd->num_ssids = params->num_ssids;
 	cmd->ie_len = params->extraie.len;
@@ -1981,7 +2047,7 @@ int ath11k_wmi_send_scan_start_cmd(struct ath11k *ar,
 
 	ptr += sizeof(*cmd);
 
-	len = params->num_chan * sizeof(u32);
+	len = params->chan_list.num_chan * sizeof(u32);
 
 	tlv = ptr;
 	tlv->header = FIELD_PREP(WMI_TLV_TAG, WMI_TAG_ARRAY_UINT32) |
@@ -1989,8 +2055,8 @@ int ath11k_wmi_send_scan_start_cmd(struct ath11k *ar,
 	ptr += TLV_HDR_SIZE;
 	tmp_ptr = (u32 *)ptr;
 
-	for (i = 0; i < params->num_chan; ++i)
-		tmp_ptr[i] = params->chan_list[i];
+	for (i = 0; i < params->chan_list.num_chan; ++i)
+		tmp_ptr[i] = params->chan_list.chan[i].freq;
 
 	ptr += len;
 
@@ -2042,6 +2108,36 @@ int ath11k_wmi_send_scan_start_cmd(struct ath11k *ar,
 
 	ptr += extraie_len_with_pad;
 
+	len = params->ie_whitelist.num_vendor_oui * sizeof(struct wmi_vendor_oui);
+	tlv = ptr;
+	tlv->header = FIELD_PREP(WMI_TLV_TAG, WMI_TAG_ARRAY_STRUCT) |
+		      FIELD_PREP(WMI_TLV_LEN, len);
+	ptr += TLV_HDR_SIZE;
+
+	if (params->scan_f_en_ie_whitelist_in_probe) {
+		/* TODO: fill vendor OUIs for probe req ie whitelisting */
+		/* currently added for FW TLV validation */
+	}
+
+	ptr += cmd->num_vendor_oui * sizeof(struct wmi_vendor_oui);
+
+	len = phymode_roundup;
+	tlv = ptr;
+	tlv->header = FIELD_PREP(WMI_TLV_TAG, WMI_TAG_ARRAY_BYTE) |
+		      FIELD_PREP(WMI_TLV_LEN, len);
+	ptr += TLV_HDR_SIZE;
+
+	/* Wide Band Scan */
+	if (params->scan_f_wide_band) {
+		phy_ptr = (u8 *)ptr;
+		/* Add PHY mode TLV for wide band scan with phymode + 1 value
+		 * so that phymode '0' is ignored by FW as default value.
+		 */
+		for (i = 0; i < params->chan_list.num_chan; ++i)
+			phy_ptr[i] = params->chan_list.chan[i].phymode + 1;
+	}
+	ptr += phymode_roundup;
+
 	ret = ath11k_wmi_cmd_send(wmi, skb,
 				  WMI_START_SCAN_CMDID);
 	if (ret) {
@@ -2129,6 +2225,9 @@ int ath11k_wmi_send_scan_chan_list_cmd(struct ath11k *ar,
 	cmd->pdev_id = chan_list->pdev_id;
 	cmd->num_scan_chans = chan_list->nallchans;
 
+	if (chan_list->append_chan_list)
+		cmd->flags |= WMI_APPEND_TO_EXISTING_CHAN_LIST_FLAG;
+
 	ptr = skb->data + sizeof(*cmd);
 
 	len = sizeof(*chan_info) * chan_list->nallchans;
@@ -2181,8 +2280,8 @@ int ath11k_wmi_send_scan_chan_list_cmd(struct ath11k *ar,
 				    tchan_info->antennamax);
 
 		ath11k_dbg(ar->ab, ATH11K_DBG_WMI,
-			   "WMI chan scan list chan[%d] = %u\n",
-			   i, chan_info->mhz);
+			   "WMI chan scan list chan[%d] = %u, chan_info->info %8x\n",
+			   i, chan_info->mhz, chan_info->info);
 
 		ptr += sizeof(*chan_info);
 
diff --git a/drivers/net/wireless/ath/ath11k/wmi.h b/drivers/net/wireless/ath/ath11k/wmi.h
index 4a518d406bc5..989b461394dc 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.h
+++ b/drivers/net/wireless/ath/ath11k/wmi.h
@@ -2930,6 +2930,12 @@ struct wlan_ssid {
 };
 
 #define WMI_IE_BITMAP_SIZE             8
+#define PROBE_REQ_MAX_OUIS	       16
+
+struct wmi_vendor_oui {
+	u32 tlv_header;
+	u32 oui_type_subtype; /* vendor OUI type and subtype */
+};
 
 #define WMI_SCAN_MAX_NUM_SSID                0x0A
 /* prefix used by scan requestor ids on the host */
@@ -3051,6 +3057,22 @@ enum {
 	((flag) |= (((mode) << WMI_SCAN_DWELL_MODE_SHIFT) & \
 		    WMI_SCAN_DWELL_MODE_MASK))
 
+struct wmi_chan_info {
+	u32 freq;
+	u32 phymode;
+};
+
+struct wmi_chan_list {
+	u32 num_chan;
+	struct wmi_chan_info chan[WLAN_SCAN_MAX_NUM_CHANNELS];
+};
+
+struct wmi_probe_req_whitelist {
+	u32 ie_bitmap[WMI_IE_BITMAP_SIZE];
+	u32 num_vendor_oui;
+	u32 voui[PROBE_REQ_MAX_OUIS];
+};
+
 struct scan_req_params {
 	u32 scan_id;
 	u32 scan_req_id;
@@ -3111,23 +3133,24 @@ struct scan_req_params {
 			    scan_f_forced:1,
 			    scan_f_2ghz:1,
 			    scan_f_5ghz:1,
-			    scan_f_80mhz:1;
+			    scan_f_wide_band:1;
 		};
 		u32 scan_flags;
 	};
 	enum scan_dwelltime_adaptive_mode adaptive_dwell_time_mode;
 	u32 burst_duration;
-	u32 num_chan;
 	u32 num_bssid;
 	u32 num_ssids;
 	u32 n_probes;
-	u32 chan_list[WLAN_SCAN_MAX_NUM_CHANNELS];
+	struct wmi_chan_list chan_list;
+	struct cfg80211_chan_def *chandef;
 	u32 notify_scan_events;
 	struct wlan_ssid ssid[WLAN_SCAN_MAX_NUM_SSID];
 	struct wmi_mac_addr bssid_list[WLAN_SCAN_MAX_NUM_BSSID];
 	struct element_info extraie;
 	struct element_info htcap;
 	struct element_info vhtcap;
+	struct wmi_probe_req_whitelist ie_whitelist;
 };
 
 struct wmi_ssid_arg {
@@ -3470,9 +3493,12 @@ struct wmi_stop_scan_cmd {
 struct scan_chan_list_params {
 	u32 pdev_id;
 	u16 nallchans;
+	bool append_chan_list;
 	struct channel_param ch_param[1];
 };
 
+#define WMI_APPEND_TO_EXISTING_CHAN_LIST_FLAG BIT(0)
+
 struct wmi_scan_chan_list_cmd {
 	u32 tlv_header;
 	u32 num_scan_chans;
@@ -4710,6 +4736,8 @@ int ath11k_wmi_vdev_delete(struct ath11k *ar, u8 vdev_id);
 void ath11k_wmi_start_scan_init(struct ath11k *ar, struct scan_req_params *arg);
 int ath11k_wmi_send_scan_start_cmd(struct ath11k *ar,
 				   struct scan_req_params *params);
+int ath11k_wmi_append_scan_chan_list(struct ath11k *ar,
+				     struct scan_req_params *params);
 int ath11k_wmi_send_scan_stop_cmd(struct ath11k *ar,
 				  struct scan_cancel_param *param);
 int ath11k_wmi_send_wmm_update_cmd_tlv(struct ath11k *ar, u32 vdev_id,
-- 
2.7.4

