Return-Path: <linux-wireless+bounces-31620-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YBVQA4YihmklKAQAu9opvQ
	(envelope-from <linux-wireless+bounces-31620-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 06 Feb 2026 18:19:02 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2183D100DF0
	for <lists+linux-wireless@lfdr.de>; Fri, 06 Feb 2026 18:19:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 74E51300C7C1
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Feb 2026 17:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 940F03D667F;
	Fri,  6 Feb 2026 17:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bkXn/AGa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3879C3B95FA
	for <linux-wireless@vger.kernel.org>; Fri,  6 Feb 2026 17:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770398325; cv=none; b=coZu0uZMGrTVwtr/5kLcLrmOYfiEqkMWr4GH3ZjNN/iohGsscuobTVTQafFArOhJtIp7ujXyBIbBYAyuBcTwffTWIfdBjMDAn5aV1bVQgzDgceLnb2hGzplxqopWmK9di7/zQoeoayksm0VpX77fPrgBqpL7qRvfzORkbTgQkH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770398325; c=relaxed/simple;
	bh=w/TCUz+0G+JI9CGXNVfx0ft9HLYZyqRJUsVvvE9d2wI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rxHz39/jVw9mxt751BtAV92RmOLuBOFNGC24R4v3x1RPdEQcYGDEs16VX+pZsqu9TOh6TYOTGfFyVz0Fpmm/5ctl0Mt8jnbKxd1FsA6B3kgP2lPhYx1LQ4RvdL03gq3AdfU2RDeizBswkAxenD3ZB155h8xWsTlqmOlgfjii3eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bkXn/AGa; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-4359a302794so669539f8f.1
        for <linux-wireless@vger.kernel.org>; Fri, 06 Feb 2026 09:18:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770398324; x=1771003124; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y1WUdXpXIIU+hHo0tAa2hXSb+QlTI+CNyfedG+sHqBQ=;
        b=bkXn/AGax8j8quFOx//o+Q+SO29idEeoKheVCQYCSpupOixStX5OLcJmpiOoLtGdBe
         tya3Bs3uWAA15tCZmHT4xTAWIimrPXM+jbs2Tegz7fNdCsDLxXOG/2PZVEM0N0cmet/m
         sXdWwl/EE+N5qjMP9UUIQi5ap9w/mt1hc4F4SqTmxgkmPdSY6MlhchiDYrROuR0scVGE
         /HWDhOdtYlH6ol2H/KyOSZZKcF/sP24YhO7IADOtoyqjSkQ/6xD6DDn8QJBvqn31Fquf
         IlZi26x1K+nLTaDa59Boj10oAbczQbQMwqS0Bcca+tHwOY7wrQPKJeHMPB6Cgg/MPTGZ
         GlMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770398324; x=1771003124;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=y1WUdXpXIIU+hHo0tAa2hXSb+QlTI+CNyfedG+sHqBQ=;
        b=jKALchcxo2fCLNyeJVIvTG14L9+CCVLavKL7I7yfxzfeGv/aZek0BSftHydmQEF91+
         iwUimdqkCz+UfwxrlQxthkQJYZoVescQNQ9BMI7YxGM3cygC5LSXOF590JJpeFTiL8/g
         JjWXAjDKFVsioLaM8VxwbySHHjmnfUk/0v0gWYDy2G+ZRMZBp+ryxoWBwEu1rLOj38PU
         n5cHTUbcX0tO6b3esZ9G0YNbslo4KXMIwEHpfmEvoN+nj6iLMvm5wAm4H7NXHvuBD7y0
         pSBY75owIRF+kYMB8AD2TotqjRiSvR5TwUMexAnq0IeOSccZCp08PYEkdfdEG9dd6zbV
         l14g==
X-Gm-Message-State: AOJu0YyjM7TYxmck9z8GcWu1pj6Y8crdhjawiDBLc5vokO7gPbmOecZ1
	u00AmMm2E9+FyYL5bjCxpUS228JAxF1s9rVOhPBifryleKh8SqJ2d30vXRCNM/JV
X-Gm-Gg: AZuq6aJQ1Lup2iGdxZc1ukQ8ZnI4aKZuKAy3t/ilYWx/5S2K8sonf5lr6qevadeR/52
	755mFFvrMm+nSquLfhCq9im5NuUNi8CgxITQKr4vre7Hk21EhEzyF7kT6GjchjVEjGASuln7qFR
	JGiG06X+BxVShZitD3twQQMyjnMuFsooxt8FwQ+AF5s9UVEAGfMspdZBp0b1HkdsKCx9fmbl/0A
	qkaik+xzRUqbfmsoqb/l4mo73/U4pnEXZIdkgBhAimNsjdBwgpQPfV9SsACKWJagb95QiU3tx2O
	lZCQ0J8nP+TCXaYgz99coM9UQU560HoArZdl1AVmcso0T5MWv8ZyxcmcwyYu8pzFWblzKK3YaS1
	+9wGT9/s4DQ15qAlgFKPS0JFBBIDJ0EN+Au5+ZFCOayKtlamrQZWMhI1TeDVxCUUGAZqWd2hy1I
	ICAn/1DP0KP2CVR9dMzsm3WWgTdQV6CLDDZU3Azx3s+lDeH5Wogfo21Ju8Bcg=
X-Received: by 2002:a5d:5f50:0:b0:431:b6e:8be3 with SMTP id ffacd0b85a97d-43629380ed0mr5786070f8f.38.1770398323363;
        Fri, 06 Feb 2026 09:18:43 -0800 (PST)
Received: from hp.. (109241135248.swidnica.vectranet.pl. [109.241.135.248])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4362974527fsm7986208f8f.31.2026.02.06.09.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 09:18:42 -0800 (PST)
From: Janusz Dziedzic <janusz.dziedzic@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net,
	Janusz Dziedzic <janusz.dziedzic@gmail.com>
Subject: [PATCH v2 wireless-next 2/4] wifi: cfg80211: set and report chandef CAC ongoing
Date: Fri,  6 Feb 2026 18:15:49 +0100
Message-ID: <20260206171830.553879-3-janusz.dziedzic@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260206171830.553879-1-janusz.dziedzic@gmail.com>
References: <20260206171830.553879-1-janusz.dziedzic@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31620-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[sipsolutions.net,gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_NEQ_ENVFROM(0.00)[januszdziedzic@gmail.com,linux-wireless@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2183D100DF0
X-Rspamd-Action: no action

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
 net/wireless/mlme.c          |  7 +++++++
 net/wireless/nl80211.c       |  7 +++++++
 6 files changed, 54 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index fc01de19c798..e00045c150e7 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -190,6 +190,8 @@ enum ieee80211_channel_flags {
  *	on this channel.
  * @dfs_state_entered: timestamp (jiffies) when the dfs state was entered.
  * @dfs_cac_ms: DFS CAC time in milliseconds, this is valid for DFS channels.
+ * @cac_start_time: timestamp (CLOCK_BOOTTIME, nanoseconds) when CAC was
+ *	started on this channel. Zero when CAC is not in progress.
  * @psd: power spectral density (in dBm)
  */
 struct ieee80211_channel {
@@ -207,6 +209,7 @@ struct ieee80211_channel {
 	enum nl80211_dfs_state dfs_state;
 	unsigned long dfs_state_entered;
 	unsigned int dfs_cac_ms;
+	u64 cac_start_time;
 	s8 psd;
 };
 
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index b63f71850906..c75aa039f096 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -4480,6 +4480,10 @@ enum nl80211_wmm_rule {
  *	as a non-primary subchannel. Only applicable to S1G channels.
  * @NL80211_FREQUENCY_ATTR_NO_UHR: UHR operation is not allowed on this channel
  *	in current regulatory domain.
+ * @NL80211_FREQUENCY_ATTR_CAC_START_TIME: Channel Availability Check (CAC)
+ *	start time (CLOCK_BOOTTIME, nanoseconds). Only present when CAC is
+ *	currently in progress on this channel.
+ * @NL80211_FREQUENCY_ATTR_PAD: attribute used for padding for 64-bit alignment
  * @NL80211_FREQUENCY_ATTR_MAX: highest frequency attribute number
  *	currently defined
  * @__NL80211_FREQUENCY_ATTR_AFTER_LAST: internal use
@@ -4530,6 +4534,8 @@ enum nl80211_frequency_attr {
 	NL80211_FREQUENCY_ATTR_NO_16MHZ,
 	NL80211_FREQUENCY_ATTR_S1G_NO_PRIMARY,
 	NL80211_FREQUENCY_ATTR_NO_UHR,
+	NL80211_FREQUENCY_ATTR_CAC_START_TIME,
+	NL80211_FREQUENCY_ATTR_PAD,
 
 	/* keep last */
 	__NL80211_FREQUENCY_ATTR_AFTER_LAST,
diff --git a/net/wireless/chan.c b/net/wireless/chan.c
index 68221b1ab45e..dfe319565280 100644
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
+		c->cac_start_time = cac_time;
+	}
+}
+
 static bool
 cfg80211_dfs_permissive_check_wdev(struct cfg80211_registered_device *rdev,
 				   enum nl80211_iftype iftype,
diff --git a/net/wireless/core.h b/net/wireless/core.h
index 6ac57b7b2615..6cace846d7a3 100644
--- a/net/wireless/core.h
+++ b/net/wireless/core.h
@@ -481,6 +481,10 @@ void cfg80211_set_dfs_state(struct wiphy *wiphy,
 			    const struct cfg80211_chan_def *chandef,
 			    enum nl80211_dfs_state dfs_state);
 
+void cfg80211_set_cac_state(struct wiphy *wiphy,
+			    const struct cfg80211_chan_def *chandef,
+			    bool cac_ongoing);
+
 void cfg80211_dfs_channels_update_work(struct work_struct *work);
 
 void cfg80211_sched_dfs_chan_update(struct cfg80211_registered_device *rdev);
diff --git a/net/wireless/mlme.c b/net/wireless/mlme.c
index 212178d04efa..283ea4c7c61e 100644
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
@@ -1307,6 +1312,8 @@ void cfg80211_stop_radar_detection(struct wireless_dev *wdev)
 
 		chandef = *wdev_chandef(wdev, link_id);
 		rdev_end_cac(rdev, wdev->netdev, link_id);
+		wdev->links[link_id].cac_started = false;
+		cfg80211_set_cac_state(wiphy, &chandef, false);
 		nl80211_radar_notify(rdev, &chandef, NL80211_RADAR_CAC_ABORTED,
 				     wdev->netdev, GFP_KERNEL);
 	}
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 6e58b238a1f8..f9a739d1ebfb 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -1334,6 +1334,12 @@ static int nl80211_msg_put_channel(struct sk_buff *msg, struct wiphy *wiphy,
 		if ((chan->flags & IEEE80211_CHAN_NO_UHR) &&
 		    nla_put_flag(msg, NL80211_FREQUENCY_ATTR_NO_UHR))
 			goto nla_put_failure;
+		if (chan->cac_start_time &&
+		    nla_put_u64_64bit(msg,
+				      NL80211_FREQUENCY_ATTR_CAC_START_TIME,
+				      chan->cac_start_time,
+				      NL80211_FREQUENCY_ATTR_PAD))
+			goto nla_put_failure;
 	}
 
 	if (nla_put_u32(msg, NL80211_FREQUENCY_ATTR_MAX_TX_POWER,
@@ -11354,6 +11360,7 @@ static int nl80211_start_radar_detection(struct sk_buff *skb,
 	wdev->links[link_id].cac_started = true;
 	wdev->links[link_id].cac_start_time = jiffies;
 	wdev->links[link_id].cac_time_ms = cac_time_ms;
+	cfg80211_set_cac_state(wiphy, &chandef, true);
 
 	return 0;
 }
-- 
2.43.0


