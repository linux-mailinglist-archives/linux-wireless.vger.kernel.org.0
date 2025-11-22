Return-Path: <linux-wireless+bounces-29259-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A8A34C7D642
	for <lists+linux-wireless@lfdr.de>; Sat, 22 Nov 2025 20:22:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C7E414E1464
	for <lists+linux-wireless@lfdr.de>; Sat, 22 Nov 2025 19:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42C3F29E11B;
	Sat, 22 Nov 2025 19:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nguX8p94"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6779283FD6
	for <linux-wireless@vger.kernel.org>; Sat, 22 Nov 2025 19:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763839349; cv=none; b=M8Xqm6GChoNoWuKqd9QkNG7NTJeQlthyOqnp8r3BTKKPJdPs3upuNVWCeQZP+GYmAc5CkckFmzd/V4w+ynZ7YFVKJ+42F3VZ1IPmIxh27R4TXdbjMEPMs8YKhIjHz0ld4GfXPWA/lV7lyM4ciOchxJzg6sDcLpJdvtsGPjjjAWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763839349; c=relaxed/simple;
	bh=qci3mNMrYXKxi/RRqfsliHrE8mh/BUCF5Bt7obO3yII=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MeXl0acUaXmJOPRpTipa1AycunRyf1nj2ozPzFDRLBOsTiXTfRVW1yIDDhjhiJ74hBMh/9NIbwOzRnePNPqETqvcsAaq5Wdw6Rnhd42Ak6J09ZjI1cUboYuplYbCCY4JX11SlKDCmTiPl0/pJb32I9VopLr5guCE8Ovrt0g54PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nguX8p94; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-640d0ec9651so5012810a12.3
        for <linux-wireless@vger.kernel.org>; Sat, 22 Nov 2025 11:22:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763839345; x=1764444145; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d+tVvO1Z3Gmoq5LLEioSwSkx/t0aMwYerwCjyjDSxIs=;
        b=nguX8p94N6IgyqJUAtylnrH6EBUg16scPmAvwCIfOnhVe91HiuqqCHL5uwSETOkmMA
         ufvcyV36hNvRno8sERWulrc1Xvuh9EoV2MAu+p8Dn4neq+At8iU16CDh9asK2c4LZhZW
         qvnJU/FBYKpGiaWxeo8pDhm4mF19OZiGVXi7SJ34evprzNXl/2954nZ39aTAGBZSpysN
         bpbZuX/HBPp91zBPQLUedXOUpfCG+VQSnHjXbh08WI9c0MT687RqVCbP7GIx6/r8bZTr
         R8N8rgj5GJcexWJspdyZnP6ggwD0gAfsMb5aNGfX5M6bYH219s8d06ghcb8WrkQwht/p
         hvnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763839345; x=1764444145;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=d+tVvO1Z3Gmoq5LLEioSwSkx/t0aMwYerwCjyjDSxIs=;
        b=IsrJpjBpU4Km9SlDEU4a5SYYMFK7x8z0aJTG8HSzacvrl7nSCgd2M8fxWgCBMfbiAZ
         hwl0HP9Rvp4OK9z0HwA5Z3pb+6fs556HGUa/kVXCt/G21U/JgGrgT78lQUNuZ4YEwNuW
         /fJNVhuS3vYBRCUvHgHEMDpoMYhloCRiozCW95DbRgFnVdqeEwnxWDwoXBP7pWtaA5hp
         ykBEHbQSKfgyL+VdDuB4mJlDzeqk3pqTCCRwFYCFqvbNZDGvmrDYuIAFSeUz35hrG+W7
         myJZR/Bw/JHAQSpIps8xv+Jf9pMLf0Ltre2syadVrIqwaTAeyKzHdnF1iaWi1JLOVt5Z
         Sslw==
X-Gm-Message-State: AOJu0YxnvOWxwOQPJLfEFZjBX90Y4YyZtD5lYl336F8Nf8HPLCSco9Xu
	KoeEbTI077yy5d6/cXtqBEvd/2pZwNVlGucF5kkOQ53fc+gJfOIRnPs1u3DNJWWC
X-Gm-Gg: ASbGnctKTbwYytvUbdH8WczxTR6jOpuVU/Ueovn+yeDe3HyZu1LLwYPMVGiSzYgjAFP
	M99JWiLMA1rSw5LEsBcIu49VcU4pQsZUR9X5siyFvI4N/yI2QEJ5P72WYgR2rBz4E0HD0VolUX4
	pnbpOTGGaN2VPM6VuhBbBkoyF48fsjzrgAg9TfqtzTGfR5N6wc9DYR5GF6RLRlwTbWC3qz7piCV
	j4//OvZSfQGZ0/Z/dZr1xEvxxdEaGa1H2jTboX0f+hlbHFBGvrxMVfYKB+HMntk57u72/XqdfdN
	tBild6OexqUhXvSmIwUGb1MeadS3flljRblKUVu1QQWXG3oYvP1veykVwfINWs7G7bBN4CmAQf1
	QDDYkVW+/uCZvycL89YwC3/h3ofj75Z4A75cwpSeyGEtAhfDf5AD57xjmdHPJ064/i27ki8+/ir
	otKWpB2FdZ2bqlVKyC6BxAUvFEE/kStf9cN0BDCqP2IC0IsqbuD0o=
X-Google-Smtp-Source: AGHT+IFwU5kg3GomjClcHmGx2JAIA4mAsEwSYfphjFclrjZJAVvXXiKt0b9aMMEu2CrAlUnbvs1fMA==
X-Received: by 2002:a05:6402:26d1:b0:641:1f6c:bccf with SMTP id 4fb4d7f45d1cf-64555cd9bcdmr5865019a12.16.1763839344752;
        Sat, 22 Nov 2025 11:22:24 -0800 (PST)
Received: from hp.lan (109241135248.swidnica.vectranet.pl. [109.241.135.248])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6453642d321sm7517378a12.20.2025.11.22.11.22.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Nov 2025 11:22:24 -0800 (PST)
From: Janusz Dziedzic <janusz.dziedzic@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net,
	Janusz Dziedzic <janusz.dziedzic@gmail.com>
Subject: [RFC v4 wireless-next 2/4] wifi: cfg80211: set and report chandef CAC ongoing
Date: Sat, 22 Nov 2025 20:17:04 +0100
Message-ID: <20251122192204.6866-3-janusz.dziedzic@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251122192204.6866-1-janusz.dziedzic@gmail.com>
References: <20251122192204.6866-1-janusz.dziedzic@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow to track and check CAC state from user mode by
simple check phy channels eg. using iw phy1 channels
command.
This is done for regular CAC and background CAC.
It is important for background CAC while we can start
it from any app (eg. iw or hostapd).

Signed-off-by: Janusz Dziedzic <janusz.dziedzic@gmail.com>
---
 include/net/cfg80211.h       |  3 +++
 include/uapi/linux/nl80211.h |  6 ++++++
 net/wireless/chan.c          | 27 +++++++++++++++++++++++++++
 net/wireless/core.h          |  4 ++++
 net/wireless/mlme.c          |  5 +++++
 net/wireless/nl80211.c       |  7 +++++++
 6 files changed, 52 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 3d3ed1932262..3a87193e5ddb 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -188,6 +188,8 @@ enum ieee80211_channel_flags {
  *	on this channel.
  * @dfs_state_entered: timestamp (jiffies) when the dfs state was entered.
  * @dfs_cac_ms: DFS CAC time in milliseconds, this is valid for DFS channels.
+ * @cac_ongoing_time: timestamp (CLOCK_BOOTTIME, nanoseconds) when CAC was
+ *	started on this channel. Zero when CAC is not in progress.
  * @psd: power spectral density (in dBm)
  */
 struct ieee80211_channel {
@@ -205,6 +207,7 @@ struct ieee80211_channel {
 	enum nl80211_dfs_state dfs_state;
 	unsigned long dfs_state_entered;
 	unsigned int dfs_cac_ms;
+	u64 cac_ongoing_time;
 	s8 psd;
 };
 
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 8134f10e4e6c..5b5dba08362d 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -4444,6 +4444,10 @@ enum nl80211_wmm_rule {
  *	channel in current regulatory domain.
  * @NL80211_FREQUENCY_ATTR_NO_16MHZ: 16 MHz operation is not allowed on this
  *	channel in current regulatory domain.
+ * @NL80211_FREQUENCY_ATTR_CAC_START_TIME: Channel Availability Check (CAC)
+ *	start time (CLOCK_BOOTTIME, nanoseconds). Only present when CAC is
+ *	currently in progress on this channel.
+ * @NL80211_FREQUENCY_ATTR_PAD: attribute used for padding for 64-bit alignment
  * @NL80211_FREQUENCY_ATTR_MAX: highest frequency attribute number
  *	currently defined
  * @__NL80211_FREQUENCY_ATTR_AFTER_LAST: internal use
@@ -4492,6 +4496,8 @@ enum nl80211_frequency_attr {
 	NL80211_FREQUENCY_ATTR_NO_4MHZ,
 	NL80211_FREQUENCY_ATTR_NO_8MHZ,
 	NL80211_FREQUENCY_ATTR_NO_16MHZ,
+	NL80211_FREQUENCY_ATTR_CAC_START_TIME,
+	NL80211_FREQUENCY_ATTR_PAD,
 
 	/* keep last */
 	__NL80211_FREQUENCY_ATTR_AFTER_LAST,
diff --git a/net/wireless/chan.c b/net/wireless/chan.c
index 68221b1ab45e..cd660b6e7a87 100644
--- a/net/wireless/chan.c
+++ b/net/wireless/chan.c
@@ -642,6 +642,33 @@ void cfg80211_set_dfs_state(struct wiphy *wiphy,
 	}
 }
 
+void cfg80211_set_cac_state(struct wiphy *wiphy,
+			    const struct cfg80211_chan_def *chandef,
+			    bool cac_ongoing)
+{
+	struct ieee80211_channel *c;
+	int width;
+	u64 cac_time;
+
+	if (WARN_ON(!cfg80211_chandef_valid(chandef)))
+		return;
+
+	width = cfg80211_chandef_get_width(chandef);
+	if (width < 0)
+		return;
+
+	/* Get the same timestamp for all subchannels */
+	cac_time = cac_ongoing ? ktime_get_boottime_ns() : 0;
+
+	for_each_subchan(chandef, freq, cf) {
+		c = ieee80211_get_channel_khz(wiphy, freq);
+		if (!c)
+			continue;
+
+		c->cac_ongoing_time = cac_time;
+	}
+}
+
 static bool
 cfg80211_dfs_permissive_check_wdev(struct cfg80211_registered_device *rdev,
 				   enum nl80211_iftype iftype,
diff --git a/net/wireless/core.h b/net/wireless/core.h
index 82f343663e8f..42b890a956ad 100644
--- a/net/wireless/core.h
+++ b/net/wireless/core.h
@@ -480,6 +480,10 @@ void cfg80211_set_dfs_state(struct wiphy *wiphy,
 			    const struct cfg80211_chan_def *chandef,
 			    enum nl80211_dfs_state dfs_state);
 
+void cfg80211_set_cac_state(struct wiphy *wiphy,
+			    const struct cfg80211_chan_def *chandef,
+			    bool cac_ongoing);
+
 void cfg80211_dfs_channels_update_work(struct work_struct *work);
 
 void cfg80211_sched_dfs_chan_update(struct cfg80211_registered_device *rdev);
diff --git a/net/wireless/mlme.c b/net/wireless/mlme.c
index 18f6d41de4e0..31a88d492b67 100644
--- a/net/wireless/mlme.c
+++ b/net/wireless/mlme.c
@@ -1162,9 +1162,11 @@ void cfg80211_cac_event(struct net_device *netdev,
 		fallthrough;
 	case NL80211_RADAR_CAC_ABORTED:
 		wdev->links[link_id].cac_started = false;
+		cfg80211_set_cac_state(wiphy, chandef, false);
 		break;
 	case NL80211_RADAR_CAC_STARTED:
 		wdev->links[link_id].cac_started = true;
+		cfg80211_set_cac_state(wiphy, chandef, true);
 		break;
 	default:
 		WARN_ON(1);
@@ -1192,15 +1194,18 @@ __cfg80211_background_cac_event(struct cfg80211_registered_device *rdev,
 	switch (event) {
 	case NL80211_RADAR_CAC_FINISHED:
 		cfg80211_set_dfs_state(wiphy, chandef, NL80211_DFS_AVAILABLE);
+		cfg80211_set_cac_state(wiphy, chandef, false);
 		memcpy(&rdev->cac_done_chandef, chandef, sizeof(*chandef));
 		queue_work(cfg80211_wq, &rdev->propagate_cac_done_wk);
 		cfg80211_sched_dfs_chan_update(rdev);
 		break;
 	case NL80211_RADAR_CAC_ABORTED:
+		cfg80211_set_cac_state(wiphy, chandef, false);
 		if (!cancel_delayed_work(&rdev->background_cac_done_wk))
 			return;
 		break;
 	case NL80211_RADAR_CAC_STARTED:
+		cfg80211_set_cac_state(wiphy, chandef, true);
 		break;
 	default:
 		return;
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 29c92bc8291b..f7c118bb8bec 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -1314,6 +1314,12 @@ static int nl80211_msg_put_channel(struct sk_buff *msg, struct wiphy *wiphy,
 		if ((chan->flags & IEEE80211_CHAN_NO_16MHZ) &&
 		    nla_put_flag(msg, NL80211_FREQUENCY_ATTR_NO_16MHZ))
 			goto nla_put_failure;
+		if (chan->cac_ongoing_time &&
+		    nla_put_u64_64bit(msg,
+				      NL80211_FREQUENCY_ATTR_CAC_START_TIME,
+				      chan->cac_ongoing_time,
+				      NL80211_FREQUENCY_ATTR_PAD))
+			goto nla_put_failure;
 	}
 
 	if (nla_put_u32(msg, NL80211_FREQUENCY_ATTR_MAX_TX_POWER,
@@ -11228,6 +11234,7 @@ static int nl80211_start_radar_detection(struct sk_buff *skb,
 	wdev->links[link_id].cac_started = true;
 	wdev->links[link_id].cac_start_time = jiffies;
 	wdev->links[link_id].cac_time_ms = cac_time_ms;
+	cfg80211_set_cac_state(wiphy, &chandef, true);
 
 	return 0;
 }
-- 
2.43.0


