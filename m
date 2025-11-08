Return-Path: <linux-wireless+bounces-28694-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CD06C433AE
	for <lists+linux-wireless@lfdr.de>; Sat, 08 Nov 2025 20:23:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D6C554E252F
	for <lists+linux-wireless@lfdr.de>; Sat,  8 Nov 2025 19:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 158FD2798F3;
	Sat,  8 Nov 2025 19:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NyKNHtKc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD0A14884C
	for <linux-wireless@vger.kernel.org>; Sat,  8 Nov 2025 19:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762629809; cv=none; b=rhKLdjrRBmFdjacFPrCkJxPRx57ML3ddec4+FPPO7A5u7t3nwMTyldUCIR1zOFE90bZMjWXkZOxfLDdS95WFC1zPQeQRnpeJaP7TPR7hgScf+PtJOb0Hg0tXvcX8I9SnenIoP0sdHIHNtC8xsGINbVoYYxmYMNQ78cgZTN8I2cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762629809; c=relaxed/simple;
	bh=kcIKczlzCfJGAzAeeI7+1EEjz0g43/jNkVh4WqXF6pw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JU2aKgbyy73ikJEF+kRe5K1xoVe4UiNRES0R4dRHbB7tMzUDQK7Rj/cFqz4b1L61LAO4WtAsnYlB6OO3MCvbJP3+yV8ebhg7Vj9pVJu8Fk9XN8A3aGLu5b9LLkCOQXaZdvIAvm6zfKrqGhxNOKEYTHDDtELE+i4iyjSQYMIayJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NyKNHtKc; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-640ca678745so3357421a12.2
        for <linux-wireless@vger.kernel.org>; Sat, 08 Nov 2025 11:23:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762629806; x=1763234606; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kp2ZeBi6SvTbBzgugqmwW6fOLnFolXjbumalI3r/8Jw=;
        b=NyKNHtKcJnfEHz8b32/Ks4bMLtcjWz1tDvcZ442/fCBeIk17famnD+ROeKJE7NGdO6
         65JyrupSe0EBWg1TQSXfuHHJvAghXVNp/hlEwtT7IqpCABNMf5towK4RgkTLW3A3nO4o
         o3pLK2B1wgmrpH6PzLQf44Sckye0BpvfOlD/ZaJwiOnnCpgV8wX0mypCU//yYZASGUPH
         UJspzftTbovWXFK/T+dc7EdepDBg/VyV9KSe14vMdgB37u0iHlCosbaNvtdhaeACks5K
         YCceAiGJKdI4kcxn+GnteQsrXpFlAcF9Mf2beOmcerIyTt4GHol0MYBobYWU4EVv63dR
         yg0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762629806; x=1763234606;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kp2ZeBi6SvTbBzgugqmwW6fOLnFolXjbumalI3r/8Jw=;
        b=s9js9hFVIDBq8NoscfuxW0fIfSOHkuLiQrn5QEv45EJP8lDRzQsvnKIFTLKATAO8jz
         0WSj5gERJre3jqZENGOgCBxFGYPYeX4l9O0h5Kn0fHK+bdhFQddyoq3kVEn3mEiFqlR5
         NSJiy2othcaWjKSGe1hJ8TKvPdCjOKBFdLyi7cQmiiftTt7ZgMZgNTrPmZhprc55XMWZ
         4Ess0LF7xxGjvJyDre6nKSogO9635QeUyMxObE8+iYg+grawoPeHOqjWR9MLW0L2/Hkm
         Em8vVZeAeLuM7GKJt8ycG8YjKiJs8HvyvUcnJccaMM1d646Hbt2UrQXBpYkJJrgQnyd1
         DhtQ==
X-Gm-Message-State: AOJu0Yz5DOtlQ3TiVxwC29+QJk0Jqzgl6M//0AMzhU+RplE1tXIxTKEv
	tLAU30a977pJjoADf8xqxwCLp3DMWfzFg5azhj9T/5p/OUTfkxWH/dt7zWQfJg==
X-Gm-Gg: ASbGncvYrpil/RqnTNci8tSzeqGn0bs1tF9rSQCR2ZyVhjL9aE8MZPp/5Dpu33mNs4Y
	DnfanN181Vo19CsBx7kAh/baN8N0GU1Mi2bGH+cFQEk1BpErZuHDw/bDQKJGJknicaN5b7IjjMF
	dkqNAeRqbJcn7qrFHni08jllay3jKdB2zG/2RSblA6VmWTdB4VtLAxWanJl1y7tWgUtMWdknXzG
	O1XPCFgZajVg1eyoTufqF3MSUkEZiREg+XkxOFyP9aGjvmlsipmA98b/4I3m/QDOJ9s559vzL5A
	gEQckYCMYAYiJrDthcnZkvJ7FXnxSy4xuxsTzHfn7vw+kb7jgzC/aYn6yMaarqw3eaNofEiOV9e
	T1eYcseQ9QP6eNhFqXiparJGidcQCZ0HK5ypxF3PR6JAI2nJEUqp6We3GL9AQu5yHWoAACq8W8y
	woZpRlhoLFfyK07QyyOxwetLFwxnRBEsqHdHjtWafVf8e1sdYX
X-Google-Smtp-Source: AGHT+IFpbShQZGnJqTenSHoGw2tFCTK1UqxfCVpiNtCibGc9r0fnNJ/yicoWCUU4gvsGGXHVKRZbuw==
X-Received: by 2002:a05:6402:3594:b0:641:1c8c:ab39 with SMTP id 4fb4d7f45d1cf-6415e856730mr2426532a12.37.1762629806272;
        Sat, 08 Nov 2025 11:23:26 -0800 (PST)
Received: from hp.. (109241135248.swidnica.vectranet.pl. [109.241.135.248])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6411f86e0cesm7284377a12.33.2025.11.08.11.23.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 11:23:25 -0800 (PST)
From: Janusz Dziedzic <janusz.dziedzic@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net,
	Janusz Dziedzic <janusz.dziedzic@gmail.com>
Subject: [RFC v2 wireless-next 2/4] wifi: cfg80211: set and report chandef CAC ongoing
Date: Sat,  8 Nov 2025 20:22:37 +0100
Message-ID: <20251108192239.2830459-2-janusz.dziedzic@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251108192239.2830459-1-janusz.dziedzic@gmail.com>
References: <20251108192239.2830459-1-janusz.dziedzic@gmail.com>
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
 include/net/cfg80211.h       |  5 +++++
 include/uapi/linux/nl80211.h |  6 ++++++
 net/wireless/ap.c            |  9 +++++++++
 net/wireless/chan.c          | 25 +++++++++++++++++++++++++
 net/wireless/core.h          |  4 ++++
 net/wireless/mlme.c          |  5 +++++
 net/wireless/nl80211.c       |  6 ++++++
 7 files changed, 60 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index f2e8963cfaac..b8a518d8ab31 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -188,6 +188,9 @@ enum ieee80211_channel_flags {
  *	on this channel.
  * @dfs_state_entered: timestamp (jiffies) when the dfs state was entered.
  * @dfs_cac_ms: DFS CAC time in milliseconds, this is valid for DFS channels.
+ * @cac_ongoing: true if CAC is currently in progress on this channel
+ * @cac_ongoing_time: timestamp (CLOCK_BOOTTIME, nanoseconds) when CAC was
+ *	started on this channel. Only valid when @cac_ongoing is true.
  * @psd: power spectral density (in dBm)
  */
 struct ieee80211_channel {
@@ -205,6 +208,8 @@ struct ieee80211_channel {
 	enum nl80211_dfs_state dfs_state;
 	unsigned long dfs_state_entered;
 	unsigned int dfs_cac_ms;
+	bool cac_ongoing;
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
diff --git a/net/wireless/ap.c b/net/wireless/ap.c
index 9a9a870806f5..12656b853875 100644
--- a/net/wireless/ap.c
+++ b/net/wireless/ap.c
@@ -27,6 +27,14 @@ static int ___cfg80211_stop_ap(struct cfg80211_registered_device *rdev,
 	    dev->ieee80211_ptr->iftype != NL80211_IFTYPE_P2P_GO)
 		return -EOPNOTSUPP;
 
+	/* Clear CAC state if it was ongoing, even if beaconing hasn't started */
+	if (wdev->links[link_id].cac_started) {
+		wdev->links[link_id].cac_started = false;
+		cfg80211_set_cac_state(&rdev->wiphy,
+				       &wdev->links[link_id].ap.chandef,
+				       false);
+	}
+
 	if (!wdev->links[link_id].ap.beacon_interval)
 		return -ENOENT;
 
@@ -34,6 +42,7 @@ static int ___cfg80211_stop_ap(struct cfg80211_registered_device *rdev,
 	if (!err) {
 		wdev->conn_owner_nlportid = 0;
 		wdev->links[link_id].ap.beacon_interval = 0;
+
 		memset(&wdev->links[link_id].ap.chandef, 0,
 		       sizeof(wdev->links[link_id].ap.chandef));
 		wdev->u.ap.ssid_len = 0;
diff --git a/net/wireless/chan.c b/net/wireless/chan.c
index 68221b1ab45e..c2cd54814e9e 100644
--- a/net/wireless/chan.c
+++ b/net/wireless/chan.c
@@ -642,6 +642,31 @@ void cfg80211_set_dfs_state(struct wiphy *wiphy,
 	}
 }
 
+void cfg80211_set_cac_state(struct wiphy *wiphy,
+			    const struct cfg80211_chan_def *chandef,
+			    bool cac_ongoing)
+{
+	struct ieee80211_channel *c;
+	int width;
+
+	if (WARN_ON(!cfg80211_chandef_valid(chandef)))
+		return;
+
+	width = cfg80211_chandef_get_width(chandef);
+	if (width < 0)
+		return;
+
+	for_each_subchan(chandef, freq, cf) {
+		c = ieee80211_get_channel_khz(wiphy, freq);
+		if (!c || !(c->flags & IEEE80211_CHAN_RADAR))
+			continue;
+
+		c->cac_ongoing = cac_ongoing;
+		if (cac_ongoing)
+			c->cac_ongoing_time = ktime_get_boottime_ns();
+	}
+}
+
 static bool
 cfg80211_dfs_permissive_check_wdev(struct cfg80211_registered_device *rdev,
 				   enum nl80211_iftype iftype,
diff --git a/net/wireless/core.h b/net/wireless/core.h
index b6bd7f4d6385..543f87c4c63d 100644
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
index 65ea469d2d77..ea291f166f88 100644
--- a/net/wireless/mlme.c
+++ b/net/wireless/mlme.c
@@ -1160,9 +1160,11 @@ void cfg80211_cac_event(struct net_device *netdev,
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
@@ -1190,6 +1192,7 @@ __cfg80211_background_cac_event(struct cfg80211_registered_device *rdev,
 	switch (event) {
 	case NL80211_RADAR_CAC_FINISHED:
 		cfg80211_set_dfs_state(wiphy, chandef, NL80211_DFS_AVAILABLE);
+		cfg80211_set_cac_state(wiphy, chandef, false);
 		memcpy(&rdev->cac_done_chandef, chandef, sizeof(*chandef));
 		queue_work(cfg80211_wq, &rdev->propagate_cac_done_wk);
 		cfg80211_sched_dfs_chan_update(rdev);
@@ -1197,8 +1200,10 @@ __cfg80211_background_cac_event(struct cfg80211_registered_device *rdev,
 	case NL80211_RADAR_CAC_ABORTED:
 		if (!cancel_delayed_work(&rdev->background_cac_done_wk))
 			return;
+		cfg80211_set_cac_state(wiphy, chandef, false);
 		break;
 	case NL80211_RADAR_CAC_STARTED:
+		cfg80211_set_cac_state(wiphy, chandef, true);
 		break;
 	default:
 		return;
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 2187e148389d..50bccb6b33b0 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -1249,6 +1249,11 @@ static int nl80211_msg_put_channel(struct sk_buff *msg, struct wiphy *wiphy,
 					NL80211_FREQUENCY_ATTR_DFS_CAC_TIME,
 					chan->dfs_cac_ms))
 				goto nla_put_failure;
+			if (chan->cac_ongoing &&
+			    nla_put_u64_64bit(msg, NL80211_FREQUENCY_ATTR_CAC_START_TIME,
+					      chan->cac_ongoing_time,
+					      NL80211_FREQUENCY_ATTR_PAD))
+				goto nla_put_failure;
 		}
 	}
 
@@ -11228,6 +11233,7 @@ static int nl80211_start_radar_detection(struct sk_buff *skb,
 	wdev->links[link_id].cac_started = true;
 	wdev->links[link_id].cac_start_time = jiffies;
 	wdev->links[link_id].cac_time_ms = cac_time_ms;
+	cfg80211_set_cac_state(wiphy, &chandef, true);
 
 	return 0;
 }
-- 
2.43.0


