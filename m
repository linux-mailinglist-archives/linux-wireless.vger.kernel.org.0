Return-Path: <linux-wireless+bounces-33173-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gDSuBpdXs2kRVQAAu9opvQ
	(envelope-from <linux-wireless+bounces-33173-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Mar 2026 01:17:27 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 929DE27B838
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Mar 2026 01:17:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B7785317ECBD
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Mar 2026 00:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF2722236FD;
	Fri, 13 Mar 2026 00:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JUvIHvPe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0E619C540
	for <linux-wireless@vger.kernel.org>; Fri, 13 Mar 2026 00:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773360989; cv=none; b=SywTmEt7cLTEvfJUwl30UHHtox71iIV7SU9BR0KKXQ8KVzKOwZaMRe+QuPrMAeeimvjw1eZIhMAteGTzB1Q3RXMcDqNfB3zZRDiKukR8czYr2qFJzvVng3Hkx714P/OQcW2it8Jr+bO92ggEYbO9VDAh9OVkDHAfTG+DYyu0pvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773360989; c=relaxed/simple;
	bh=RLLe8Nn4Adi81Y8GPo3Efcp1Ndv2LUmLZ/8xBbKDvVM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P2Cj/eHl32i3Ptry0BgqcOpkH/VAKrD6EShfLBrqgPp+4wJgbsrkfa0zdg2hSg511/pOosDMgdgC/xBJBDKOL/FavVanE4Q52vHMXrczAP5ZIV4eEMfr5qsJSOBmm4SNGCHlqba44BEDIeIa8TscqWaFBjhjxgRdjKShUgMi9G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JUvIHvPe; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-64c97997b0fso1366976d50.3
        for <linux-wireless@vger.kernel.org>; Thu, 12 Mar 2026 17:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773360987; x=1773965787; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F3YA59Mp4HTuyJkhwuElaXOAlXnXSvbB0FwywcY2nbs=;
        b=JUvIHvPe5ofQwTps7zIgtv7hAsIj8ABsSvgTE3ec6jR3R8ug8j/mTZgbOGagu3/ZAj
         NRSMIZQ/xoGbDytpPEfnS01IIGiEjEuWYlXTUoPH7XKO1uSGCflewfSgzMpNj8G2BEWf
         sJdIGBL26ZQOJOcXOInOYjIyW6qMXSfbuPcCbMggiCCaeTKB0RH9xtbTwnyXb93RScCY
         uNQSiqgWOD73giAsKT39op4Cf9FuVgUIShECJAeIUIM8Hk4XsV+MmhaG+ufj4Ad0zBg4
         lpDNjRj2e64PNCxsmkdS2KscBe53GNSScALX3Od4j14G9ZHGQllHimvFQZbEbk10VQA8
         rhNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773360987; x=1773965787;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F3YA59Mp4HTuyJkhwuElaXOAlXnXSvbB0FwywcY2nbs=;
        b=Vjavo4kzPWVgPaK23SrMEwv2JcpEp1bfby+mliZwtRg9cbd2JWnrHBiFjoM7lnop3j
         gSEc4tAq6a/XBw8ODGaLYVjynQVQPCgHGyggkwKzeoN4LGFRZ4QojdMIkIch3R1qqbh6
         c1w75ZyHQiImyQd7+6Q5KFaXOM2KOnFHQN/An9pI/xQU2mLQHtukxMomtKYIH8VbNGkT
         VpIfKrPtupG/AdDOEFDwzMPdzBmS7iQvbunbsArYsEyzLWDm3DxnPuSxSBo8HSdeos0V
         MBPBY91HuAP2fMuNO0NwAiqhDv+k362M5uYNOiDrQqtj5byHbFmaCaUdLXbZs0IdqJ7n
         UtOQ==
X-Gm-Message-State: AOJu0YzwirkjADLzRwC9pCHFycmfUeZx31n/7bSARj5gsco2q6L5Qjpi
	/+IEDMKpapy7BSq+n7pATu6b7JVkWCJQE1llUVOtMjklLOZtksrhj2E1TqfuCWgU
X-Gm-Gg: ATEYQzyU5J1lIeTb9XqQbkH7gtgNwSAd1aEbeHQqBnv3W64Bb225gRb1tm6uwSV/p+n
	JHfqYr4tTBomqHscbfQmZQhxRqiWJPhlYM39O6ttGRfvtajdyWOa2hLEb3VvfEPZLotydR9NfLS
	f4gTRqmJBX/3tD2lDEM2+vFYOg+iDzcfmJdLc7CkJpra0VZdW7dqDVxIzvimkpUL6gZWuQz2UY7
	ohO/VsFdG4lKY22OHGpfC/M9zCtIhkNxOnStvdW7xPHUBKkQGoWBlkEbJVtWnssPfl5xBEiJ4pD
	xlKgGjESaKI16C5kVb5X0VKUrmf3fq4B/d+RQbEs0TiOO1f/o4vvertmb1QHvAP3wYoURHEBj9w
	xDI3ojFv7sB4OM0EkI454L1fl2dFs2+OLsaU6+kwv1o/4vNkn6E18IWn+Zn8AbgZXjtPjgA6MH4
	EEYCE1fp7XDYG2sca9f1W6dc4GVfqrNcT9k2RAu3Lp3fkpfIekJBxuEw==
X-Received: by 2002:a53:c448:0:b0:64c:9fd7:676a with SMTP id 956f58d0204a3-64e630dc827mr1182932d50.83.1773360986740;
        Thu, 12 Mar 2026 17:16:26 -0700 (PDT)
Received: from ryzen ([2601:644:8000:56f5::8bd])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64e65a405c5sm157460d50.2.2026.03.12.17.16.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 17:16:26 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: Jeff Johnson <jjohnson@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	ath11k@lists.infradead.org (open list:QUALCOMM ATHEROS ATH11K WIRELESS DRIVER),
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCH ath-next] wifi: ath11k: use kzalloc_flex
Date: Thu, 12 Mar 2026 17:16:08 -0700
Message-ID: <20260313001608.118294-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33173-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 929DE27B838
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Convert kzalloc_obj + kcalloc to kzalloc_flex to save an allocation.

Add __counted_by to get extra runtime analysis. Move counting variable
assignment immediately after allocation as required by __counted_by.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/wireless/ath/ath11k/mac.c | 71 ++++++++++-----------------
 drivers/net/wireless/ath/ath11k/wmi.h |  2 +-
 2 files changed, 28 insertions(+), 45 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 4a68bb9ca4fa..b5f3d7221b5f 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -4228,13 +4228,14 @@ static int ath11k_mac_op_hw_scan(struct ieee80211_hw *hw,
 	if (ret)
 		goto exit;

-	arg = kzalloc_obj(*arg);
+	arg = kzalloc_flex(*arg, chan_list, req->n_channels);

 	if (!arg) {
 		ret = -ENOMEM;
 		goto exit;
 	}

+	arg->num_chan = req->n_channels;
 	ath11k_wmi_start_scan_init(ar, arg);
 	arg->vdev_id = arvif->vdev_id;
 	arg->scan_id = ATH11K_SCAN_ID;
@@ -4262,38 +4263,27 @@ static int ath11k_mac_op_hw_scan(struct ieee80211_hw *hw,
 		arg->scan_f_passive = 1;
 	}

-	if (req->n_channels) {
-		arg->num_chan = req->n_channels;
-		arg->chan_list = kcalloc(arg->num_chan, sizeof(*arg->chan_list),
-					 GFP_KERNEL);
+	for (i = 0; i < arg->num_chan; i++) {
+		if (test_bit(WMI_TLV_SERVICE_SCAN_CONFIG_PER_CHANNEL,
+			     ar->ab->wmi_ab.svc_map)) {
+			arg->chan_list[i] =
+				u32_encode_bits(req->channels[i]->center_freq,
+						WMI_SCAN_CONFIG_PER_CHANNEL_MASK);

-		if (!arg->chan_list) {
-			ret = -ENOMEM;
-			goto exit;
-		}
-
-		for (i = 0; i < arg->num_chan; i++) {
-			if (test_bit(WMI_TLV_SERVICE_SCAN_CONFIG_PER_CHANNEL,
-				     ar->ab->wmi_ab.svc_map)) {
-				arg->chan_list[i] =
-					u32_encode_bits(req->channels[i]->center_freq,
-							WMI_SCAN_CONFIG_PER_CHANNEL_MASK);
-
-				/* If NL80211_SCAN_FLAG_COLOCATED_6GHZ is set in scan
-				 * flags, then scan all PSC channels in 6 GHz band and
-				 * those non-PSC channels where RNR IE is found during
-				 * the legacy 2.4/5 GHz scan.
-				 * If NL80211_SCAN_FLAG_COLOCATED_6GHZ is not set,
-				 * then all channels in 6 GHz will be scanned.
-				 */
-				if (req->channels[i]->band == NL80211_BAND_6GHZ &&
-				    req->flags & NL80211_SCAN_FLAG_COLOCATED_6GHZ &&
-				    !cfg80211_channel_is_psc(req->channels[i]))
-					arg->chan_list[i] |=
-						WMI_SCAN_CH_FLAG_SCAN_ONLY_IF_RNR_FOUND;
-			} else {
-				arg->chan_list[i] = req->channels[i]->center_freq;
-			}
+			/* If NL80211_SCAN_FLAG_COLOCATED_6GHZ is set in scan
+			 * flags, then scan all PSC channels in 6 GHz band and
+			 * those non-PSC channels where RNR IE is found during
+			 * the legacy 2.4/5 GHz scan.
+			 * If NL80211_SCAN_FLAG_COLOCATED_6GHZ is not set,
+			 * then all channels in 6 GHz will be scanned.
+			 */
+			if (req->channels[i]->band == NL80211_BAND_6GHZ &&
+			    req->flags & NL80211_SCAN_FLAG_COLOCATED_6GHZ &&
+			    !cfg80211_channel_is_psc(req->channels[i]))
+				arg->chan_list[i] |=
+					WMI_SCAN_CH_FLAG_SCAN_ONLY_IF_RNR_FOUND;
+		} else {
+			arg->chan_list[i] = req->channels[i]->center_freq;
 		}
 	}

@@ -9736,19 +9726,14 @@ static int ath11k_mac_op_remain_on_channel(struct ieee80211_hw *hw,

 	scan_time_msec = ar->hw->wiphy->max_remain_on_channel_duration * 2;

-	arg = kzalloc_obj(*arg);
+	arg = kzalloc_flex(*arg, chan_list, 1);
 	if (!arg) {
 		ret = -ENOMEM;
 		goto exit;
 	}
-	ath11k_wmi_start_scan_init(ar, arg);
+
 	arg->num_chan = 1;
-	arg->chan_list = kcalloc(arg->num_chan, sizeof(*arg->chan_list),
-				 GFP_KERNEL);
-	if (!arg->chan_list) {
-		ret = -ENOMEM;
-		goto free_arg;
-	}
+	ath11k_wmi_start_scan_init(ar, arg);

 	arg->vdev_id = arvif->vdev_id;
 	arg->scan_id = ATH11K_SCAN_ID;
@@ -9769,7 +9754,7 @@ static int ath11k_mac_op_remain_on_channel(struct ieee80211_hw *hw,
 		spin_lock_bh(&ar->data_lock);
 		ar->scan.state = ATH11K_SCAN_IDLE;
 		spin_unlock_bh(&ar->data_lock);
-		goto free_chan_list;
+		goto free_arg;
 	}

 	ret = wait_for_completion_timeout(&ar->scan.on_channel, 3 * HZ);
@@ -9779,7 +9764,7 @@ static int ath11k_mac_op_remain_on_channel(struct ieee80211_hw *hw,
 		if (ret)
 			ath11k_warn(ar->ab, "failed to stop scan: %d\n", ret);
 		ret = -ETIMEDOUT;
-		goto free_chan_list;
+		goto free_arg;
 	}

 	ieee80211_queue_delayed_work(ar->hw, &ar->scan.timeout,
@@ -9787,8 +9772,6 @@ static int ath11k_mac_op_remain_on_channel(struct ieee80211_hw *hw,

 	ret = 0;

-free_chan_list:
-	kfree(arg->chan_list);
 free_arg:
 	kfree(arg);
 exit:
diff --git a/drivers/net/wireless/ath/ath11k/wmi.h b/drivers/net/wireless/ath/ath11k/wmi.h
index baed501b640b..b2dade0516ac 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.h
+++ b/drivers/net/wireless/ath/ath11k/wmi.h
@@ -3423,7 +3423,6 @@ struct scan_req_params {
 	u32 num_bssid;
 	u32 num_ssids;
 	u32 n_probes;
-	u32 *chan_list;
 	u32 notify_scan_events;
 	struct wlan_ssid ssid[WLAN_SCAN_PARAMS_MAX_SSID];
 	struct wmi_mac_addr bssid_list[WLAN_SCAN_PARAMS_MAX_BSSID];
@@ -3436,6 +3435,7 @@ struct scan_req_params {
 	struct hint_bssid hint_bssid[WLAN_SCAN_MAX_HINT_BSSID];
 	struct wmi_mac_addr mac_addr;
 	struct wmi_mac_addr mac_mask;
+	u32 chan_list[] __counted_by(num_chan);
 };

 struct wmi_ssid_arg {
--
2.53.0


