Return-Path: <linux-wireless+bounces-35536-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eAq4H3sg8WkhdwEAu9opvQ
	(envelope-from <linux-wireless+bounces-35536-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 23:02:51 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 86A4348C2B9
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 23:02:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F1B9F302329F
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 20:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64CFE3624CB;
	Tue, 28 Apr 2026 20:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="osE5EJhf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2CF12D4816
	for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2026 20:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777409437; cv=none; b=LXDJ63n1mUmbMntN3VALZx6aKjN0hmyyf3yWBNa9ARh/2YfrTRS5aD02j9eGiuBrvi+rEtf3d6xs8pCqc+ZAkPOdyBA4rEIq0N7bUhs4NZP1bXQCK3KQFWgPg3PCOCpPRQB9SVbYoPI/AveRoJ6uZ6JgxPz8ZNI78WpAcQRhRY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777409437; c=relaxed/simple;
	bh=96eFmX7Hw7uaVXtRcZ0NGiKwvwPVVaFtiROart6yDJY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Iwjrc2ppBXD7iDuoj3/qRbOnlj1nndtzyZBVlZvZI85awjpvLI5PiW42z6tTDL5n6wR74cdo9THtiRxno9t20gYHpgxVKMEacon3jG6Boed6/6pS5RlorRE9iQ2izW1JYYdNXZq0T6pVAXe5yybqp6KE9/siZhMHSdBUzhdb0Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=osE5EJhf; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-83177129e28so2564380b3a.1
        for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2026 13:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777409435; x=1778014235; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8NzPUuQXwNwzOXO6cxunjkL9bjxxgNti1T1DyCWU3h0=;
        b=osE5EJhfAVhySA+zQ+NnsH21dS/78NLTjQECUwtE1Drj2T2IuP9P2vzsBMKQUrg+G9
         H/jOQQnZbcRQ81edbqUyBD87T6wyAYIpW1ylCzHGU/i2W/w1uRrM68UfJ+Sqj57dV9bu
         PrUOmEnJSN0KU5qesVlaBCDUmadQLxH2+r4Q+WyQcMHWoNW+9c55c5CyBo7tx/8OEFy0
         iGpJlBOzfQa6JzciV1yY1TNv2McsbrerhzTWSxFM01z7qZFaGtMOG9DdLZyG7D0ILWnH
         qHjFeUwB/YEZKOBb14dXx/cCTrIftqccS7Lp1w9znh14x6kWfDmpvlyhnga+iGbcVuCQ
         rcgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777409435; x=1778014235;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8NzPUuQXwNwzOXO6cxunjkL9bjxxgNti1T1DyCWU3h0=;
        b=dEAKTXGdn63xDssulJ5xwLYAPKfnZAkUM2K9AM5VGe10odbwtFDacfFZjZOXOjrIFT
         8Hmr6pQBj4pn0oIb5ofjG1qExK5xb39b7FCDD5xgpNvYV7gQa3KeOmNB45Bk7OLMLcCb
         oT7TsETvttz9RBt8/8MJ9abC/Z0JCRwc7ooPY7L28c0NVvud1n0hZCGPFYtQX9GWtF7/
         hNsRe3vzBsySuVJ0n41sJ/ok/SdDhjbRv9kgtlpTPtb4T2OBejzub+K+6tQ0uZVnEbiX
         iOJsekveZzG19e+zgEI7t19It5s5EoptGbMeQ12IvhpKXAGdu3UVLqL1tG3XX03a44z6
         Pj8g==
X-Gm-Message-State: AOJu0YxeQP4FKp/HJfWe44J/9cohIEOUGfiJdXyfrH9jj2N73cgZFoCY
	z3n+AMH/2WXUzpWTueobM9hDtWjpjOL9ODODmCNzL+1kqk9czSJkcR436PoFZQ==
X-Gm-Gg: AeBDievCoWjMubFdpUsmmDhbdVyQlOZVQhkikoMeRKjS7hJgVLNVs+LiIwBMQYQfloA
	U9WahIJI+dTAskdllkwjz8zwjSgLrIk4v6obb8Zeh7sdJiXIDm4tPgNRIzYsW74UfvkmyaCkBjz
	OQzXV5Xs9m45T6WziuszRMEI125/c9IxNX0bvh797mNVUhbyzwSNcjORudhdfelbkGTKEDm7gos
	T030e46XO6ikpLDRMV9CW1APm+5Yxhh8MWv/gLIYKF2muEJaW5KNtPz6IjlnLcmrM68G0uj4Yhx
	7V/wIlW0w9mo37QViry8EAsROBhaH0GW/i0N4QAwGSOaHp7B8yww1KpQtyvRx3/6No63wFfliAr
	XQefOyvzDVpFhlntw2iVK5Hmh+Zu4frjebSPQqOgIgx2Vausa93fk8zHVfZzEbx8vi/hIoBtLQz
	bEAzrGWxm9hSaintd4IzkESR66jSLGWiDMlj68U8te4qj84DVXsOts/vsJyt9FrQ909gTvSHWQo
	hgOLff22MCmj8M7ee0EzsCfYQ==
X-Received: by 2002:a05:6a00:950d:b0:81f:ac81:d597 with SMTP id d2e1a72fcca58-834ea2200cdmr812642b3a.0.1777409434826;
        Tue, 28 Apr 2026 13:50:34 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d::8bd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-834dae1fd8esm3301581b3a.13.2026.04.28.13.50.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 13:50:34 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: Jeff Johnson <jjohnson@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	ath11k@lists.infradead.org (open list:QUALCOMM ATHEROS ATH11K WIRELESS DRIVER),
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCHv3 ath-next] wifi: ath11k: use kzalloc_flex
Date: Tue, 28 Apr 2026 13:50:17 -0700
Message-ID: <20260428205017.26288-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 86A4348C2B9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_FROM(0.00)[bounces-35536-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

Convert kzalloc_obj + kcalloc to kzalloc_flex to save an allocation.

Add __counted_by to get extra runtime analysis. Move counting variable
assignment immediately after allocation before any potential accesses.
kzalloc_flex does this anyway for GCC >= 15.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 v3: remove one more kfree for chan_list.
 v2: reword counting variable comment.
 drivers/net/wireless/ath/ath11k/mac.c | 72 ++++++++++-----------------
 drivers/net/wireless/ath/ath11k/wmi.h |  2 +-
 2 files changed, 28 insertions(+), 46 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 4a68bb9ca4fa..8d9e1e33e47d 100644
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
 
@@ -4336,7 +4326,6 @@ static int ath11k_mac_op_hw_scan(struct ieee80211_hw *hw,
 
 exit:
 	if (arg) {
-		kfree(arg->chan_list);
 		kfree(arg->extraie.ptr);
 		kfree(arg);
 	}
@@ -9736,19 +9725,14 @@ static int ath11k_mac_op_remain_on_channel(struct ieee80211_hw *hw,
 
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
@@ -9769,7 +9753,7 @@ static int ath11k_mac_op_remain_on_channel(struct ieee80211_hw *hw,
 		spin_lock_bh(&ar->data_lock);
 		ar->scan.state = ATH11K_SCAN_IDLE;
 		spin_unlock_bh(&ar->data_lock);
-		goto free_chan_list;
+		goto free_arg;
 	}
 
 	ret = wait_for_completion_timeout(&ar->scan.on_channel, 3 * HZ);
@@ -9779,7 +9763,7 @@ static int ath11k_mac_op_remain_on_channel(struct ieee80211_hw *hw,
 		if (ret)
 			ath11k_warn(ar->ab, "failed to stop scan: %d\n", ret);
 		ret = -ETIMEDOUT;
-		goto free_chan_list;
+		goto free_arg;
 	}
 
 	ieee80211_queue_delayed_work(ar->hw, &ar->scan.timeout,
@@ -9787,8 +9771,6 @@ static int ath11k_mac_op_remain_on_channel(struct ieee80211_hw *hw,
 
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
2.54.0


