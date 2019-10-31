Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0C9EB037
	for <lists+linux-wireless@lfdr.de>; Thu, 31 Oct 2019 13:28:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbfJaM2Q (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 31 Oct 2019 08:28:16 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:41160 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbfJaM2P (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 31 Oct 2019 08:28:15 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 3FDAB60913; Thu, 31 Oct 2019 12:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1572524894;
        bh=O8dzojXX/pGh9ECofSzQBhTtetBTtJgnafjsAHTeuIY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a3+hLPe+b/PIytNsEPqxUt0wIxwerSP5o50bSg6vVHwIqjSfVOPtr77yoXazHgL3S
         0B9rcie4ZH6e6dBpkxWy+d/F6xnj3t3vzLFnocA4h5JMIJ+4AzFFytr4f+3Jf08r5i
         +9cTmyaeOYn3tmVAS0Lnbm6ZfFggaBUkZtNjgWdg=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E66D3603A3;
        Thu, 31 Oct 2019 12:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1572524893;
        bh=O8dzojXX/pGh9ECofSzQBhTtetBTtJgnafjsAHTeuIY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LKtf3lLkxchrv2k+2TKD6LGDgQOEVxyCI5Fn9MDZo+6/p8hOhsx7Wh6GZZeEAdyII
         U5pwJF8vTthAfByc4Iu+lbM3yarDx8baHUe54JhcRZo0rxEO3oxVHEeao0W+xiNM/4
         NwmcX53nnHaxF1fLmmKOebjA8Zs6ERcKXhBFIid0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E66D3603A3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=murugana@codeaurora.org
From:   Sathishkumar Muruganandam <murugana@codeaurora.org>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
Subject: [PATCH 1/2] nl80211: add Wide Band Scan support
Date:   Thu, 31 Oct 2019 17:57:46 +0530
Message-Id: <1572524867-26703-2-git-send-email-murugana@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1572524867-26703-1-git-send-email-murugana@codeaurora.org>
References: <1572524867-26703-1-git-send-email-murugana@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

New nl80211 ext_feature and scan_flag added to support wide band scan which
allows driver to scan on requested channel with corresponding
phy mode/bandwidth (40Mhz, 80Mhz).

To handle center frequency of 80Mhz channel, struct cfg80211_chan_def is
included in cfg80211_scan_request.

Signed-off-by: Sathishkumar Muruganandam <murugana@codeaurora.org>
---
 include/net/cfg80211.h       |  2 ++
 include/uapi/linux/nl80211.h |  7 +++++
 net/mac80211/scan.c          |  2 ++
 net/wireless/nl80211.c       | 68 ++++++++++++++++++++++++++++----------------
 4 files changed, 55 insertions(+), 24 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 4ab2c49423dc..c303344e5832 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -1906,6 +1906,7 @@ struct cfg80211_scan_info {
  * @channels: channels to scan on.
  * @n_channels: total number of channels to scan
  * @scan_width: channel width for scanning
+ * @chandef: defines the channel to do wide band scan
  * @ie: optional information element(s) to add into Probe Request or %NULL
  * @ie_len: length of ie in octets
  * @duration: how long to listen on each channel, in TUs. If
@@ -1932,6 +1933,7 @@ struct cfg80211_scan_request {
 	int n_ssids;
 	u32 n_channels;
 	enum nl80211_bss_scan_width scan_width;
+	struct cfg80211_chan_def *chandef;
 	const u8 *ie;
 	size_t ie_len;
 	u16 duration;
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 64135ab3a7ac..7b87e9a06d1f 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -5492,6 +5492,9 @@ enum nl80211_feature_flags {
  * @NL80211_EXT_FEATURE_SAE_OFFLOAD: Device wants to do SAE authentication in
  *	station mode (SAE password is passed as part of the connect command).
  *
+ * @NL80211_EXT_FEATURE_WIDE_BAND_SCAN: Driver/device supports wide band scan
+ *	on a frequency along with its corresponding phymode (40Mhz, 80Mhz)
+ *
  * @NUM_NL80211_EXT_FEATURES: number of extended features.
  * @MAX_NL80211_EXT_FEATURES: highest extended feature index.
  */
@@ -5537,6 +5540,7 @@ enum nl80211_ext_feature_index {
 	NL80211_EXT_FEATURE_EXT_KEY_ID,
 	NL80211_EXT_FEATURE_STA_TX_PWR,
 	NL80211_EXT_FEATURE_SAE_OFFLOAD,
+	NL80211_EXT_FEATURE_WIDE_BAND_SCAN,
 
 	/* add new features before the definition below */
 	NUM_NL80211_EXT_FEATURES,
@@ -5648,6 +5652,8 @@ enum nl80211_timeout_reason {
  * @NL80211_SCAN_FLAG_MIN_PREQ_CONTENT: minimize probe request content to
  *	only have supported rates and no additional capabilities (unless
  *	added by userspace explicitly.)
+ * @NL80211_SCAN_FLAG_WIDE_BAND_SCAN: This flag intends the driver to perform
+ *	wide band scan only if the driver supports it.
  */
 enum nl80211_scan_flags {
 	NL80211_SCAN_FLAG_LOW_PRIORITY				= 1<<0,
@@ -5663,6 +5669,7 @@ enum nl80211_scan_flags {
 	NL80211_SCAN_FLAG_HIGH_ACCURACY				= 1<<10,
 	NL80211_SCAN_FLAG_RANDOM_SN				= 1<<11,
 	NL80211_SCAN_FLAG_MIN_PREQ_CONTENT			= 1<<12,
+	NL80211_SCAN_FLAG_WIDE_BAND_SCAN			= 1<<13,
 };
 
 /**
diff --git a/net/mac80211/scan.c b/net/mac80211/scan.c
index 4d31d9688dc2..343c0c6e2ecb 100644
--- a/net/mac80211/scan.c
+++ b/net/mac80211/scan.c
@@ -688,11 +688,13 @@ static int __ieee80211_start_scan(struct ieee80211_sub_if_data *sdata,
 
 		local->hw_scan_req = kmalloc(
 				sizeof(*local->hw_scan_req) +
+				sizeof(*req->chandef) +
 				req->n_channels * sizeof(req->channels[0]) +
 				local->hw_scan_ies_bufsize, GFP_KERNEL);
 		if (!local->hw_scan_req)
 			return -ENOMEM;
 
+		local->hw_scan_req->req.chandef = req->chandef;
 		local->hw_scan_req->req.ssids = req->ssids;
 		local->hw_scan_req->req.n_ssids = req->n_ssids;
 		ies = (u8 *)local->hw_scan_req +
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index d1451e731bb8..67d29a309eb6 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -7476,7 +7476,10 @@ nl80211_check_scan_flags(struct wiphy *wiphy, struct wireless_dev *wdev,
 				     NL80211_EXT_FEATURE_SCAN_RANDOM_SN) ||
 	    !nl80211_check_scan_feat(wiphy, *flags,
 				     NL80211_SCAN_FLAG_MIN_PREQ_CONTENT,
-				     NL80211_EXT_FEATURE_SCAN_MIN_PREQ_CONTENT))
+				     NL80211_EXT_FEATURE_SCAN_MIN_PREQ_CONTENT) ||
+	    !nl80211_check_scan_feat(wiphy, *flags,
+				     NL80211_SCAN_FLAG_WIDE_BAND_SCAN,
+				     NL80211_EXT_FEATURE_WIDE_BAND_SCAN))
 		return -EOPNOTSUPP;
 
 	if (*flags & NL80211_SCAN_FLAG_RANDOM_ADDR) {
@@ -7499,10 +7502,12 @@ static int nl80211_trigger_scan(struct sk_buff *skb, struct genl_info *info)
 	struct cfg80211_registered_device *rdev = info->user_ptr[0];
 	struct wireless_dev *wdev = info->user_ptr[1];
 	struct cfg80211_scan_request *request;
+	struct cfg80211_chan_def chandef;
 	struct nlattr *attr;
 	struct wiphy *wiphy;
-	int err, tmp, n_ssids = 0, n_channels, i;
+	int err, tmp, n_ssids = 0, n_channels = 0, i;
 	size_t ie_len;
+	bool chandef_found = false;
 
 	wiphy = &rdev->wiphy;
 
@@ -7517,7 +7522,14 @@ static int nl80211_trigger_scan(struct sk_buff *skb, struct genl_info *info)
 		goto unlock;
 	}
 
-	if (info->attrs[NL80211_ATTR_SCAN_FREQUENCIES]) {
+	if (info->attrs[NL80211_ATTR_WIPHY_FREQ]) {
+		n_channels = 1;
+		if (nl80211_parse_chandef(rdev, info, &chandef)) {
+			err = -EINVAL;
+			goto unlock;
+		}
+		chandef_found = true;
+	} else if (info->attrs[NL80211_ATTR_SCAN_FREQUENCIES]) {
 		n_channels = validate_scan_freqs(
 				info->attrs[NL80211_ATTR_SCAN_FREQUENCIES]);
 		if (!n_channels) {
@@ -7548,6 +7560,7 @@ static int nl80211_trigger_scan(struct sk_buff *skb, struct genl_info *info)
 	}
 
 	request = kzalloc(sizeof(*request)
+			+ sizeof(*request->chandef)
 			+ sizeof(*request->ssids) * n_ssids
 			+ sizeof(*request->channels) * n_channels
 			+ ie_len, GFP_KERNEL);
@@ -7556,6 +7569,12 @@ static int nl80211_trigger_scan(struct sk_buff *skb, struct genl_info *info)
 		goto unlock;
 	}
 
+	if (chandef_found) {
+		request->chandef = &chandef;
+		request->channels[0] = chandef.chan;
+		request->n_channels = n_channels;
+	}
+
 	if (n_ssids)
 		request->ssids = (void *)&request->channels[n_channels];
 	request->n_ssids = n_ssids;
@@ -7586,7 +7605,7 @@ static int nl80211_trigger_scan(struct sk_buff *skb, struct genl_info *info)
 			request->channels[i] = chan;
 			i++;
 		}
-	} else {
+	} else if (!chandef_found) {
 		enum nl80211_band band;
 
 		/* all channels */
@@ -7609,31 +7628,32 @@ static int nl80211_trigger_scan(struct sk_buff *skb, struct genl_info *info)
 		}
 	}
 
-	if (!i) {
-		err = -EINVAL;
-		goto out_free;
-	}
-
-	request->n_channels = i;
-
-	wdev_lock(wdev);
-	if (!cfg80211_off_channel_oper_allowed(wdev)) {
-		struct ieee80211_channel *chan;
-
-		if (request->n_channels != 1) {
-			wdev_unlock(wdev);
-			err = -EBUSY;
+	if (!chandef_found) {
+		if (!i) {
+			err = -EINVAL;
 			goto out_free;
 		}
+		request->n_channels = i;
 
-		chan = request->channels[0];
-		if (chan->center_freq != wdev->chandef.chan->center_freq) {
-			wdev_unlock(wdev);
-			err = -EBUSY;
-			goto out_free;
+		wdev_lock(wdev);
+		if (!cfg80211_off_channel_oper_allowed(wdev)) {
+			struct ieee80211_channel *chan;
+
+			if (request->n_channels != 1) {
+				wdev_unlock(wdev);
+				err = -EBUSY;
+				goto out_free;
+			}
+
+			chan = request->channels[0];
+			if (chan->center_freq != wdev->chandef.chan->center_freq) {
+				wdev_unlock(wdev);
+				err = -EBUSY;
+				goto out_free;
+			}
 		}
+		wdev_unlock(wdev);
 	}
-	wdev_unlock(wdev);
 
 	i = 0;
 	if (n_ssids) {
-- 
2.7.4

