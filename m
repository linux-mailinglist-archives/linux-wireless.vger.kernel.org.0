Return-Path: <linux-wireless+bounces-31429-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SIvRFPx8f2nMrwIAu9opvQ
	(envelope-from <linux-wireless+bounces-31429-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 01 Feb 2026 17:19:08 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C4637C66AF
	for <lists+linux-wireless@lfdr.de>; Sun, 01 Feb 2026 17:19:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 54F113009B01
	for <lists+linux-wireless@lfdr.de>; Sun,  1 Feb 2026 16:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 904DD242D91;
	Sun,  1 Feb 2026 16:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FR7mooWu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F266D245019
	for <linux-wireless@vger.kernel.org>; Sun,  1 Feb 2026 16:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769962736; cv=none; b=d3utzDOHOp5BGJyVltsdi1uGwAU4b3AdkUhPSAszja4vUVoL8/73lCMy1MKqKhLqR+YI9p7Q/7kpU5KVOvXuOx1zMA2gq10ZIVtdsi1yGCgPYX3LDctHMwWrUbQElQotEq4Py7l8FnCIIgrBtFP4GJx4ZCPHXBKyVP/yht0+v6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769962736; c=relaxed/simple;
	bh=3r591LqVlUrmnjvASagh7mox6dhK1KPqO+Qu/Y5oh1E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eJj52W5Hg1dB18ggji2ngXl/h/LG/7Msw2m86F/jC8uqY5tJsM+P3lqsN/zLD8GR9fZQsVSsEII30Hkj+thZeGcSMdj1qSd7tJNbgLc9z/yTr/1RNfnWTiezIYpJMTklpgNBb7RfoSoEFRfzZHRJK97HsWVghV0DbguqFNCZQJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FR7mooWu; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-435f177a8f7so2677794f8f.1
        for <linux-wireless@vger.kernel.org>; Sun, 01 Feb 2026 08:18:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769962733; x=1770567533; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4BtcOfsTNMjO1s1xNgK+IoI1+hSlSuAGGBIHgO9a7Vc=;
        b=FR7mooWu33o4L0F+d5Xpip2cQnznTeToMhOcnAZw+s9f0X3Q4PX0G4Cyg6FZrKs9Qh
         6q/n7W3B7oodsiMdaN7qgQRN1EJF+BhKDah/o/btbuOofOQvQLhV4Jqs3NZqaXfIByUn
         vw8Mu5qS3yLyYpSYktds1bA1axlOnwaw86muiwoUJSKpSdUcIM/51fOt/4rh4spQtGvI
         3DG6JlYQMz0gvoBVO8EDHdN/CUW0CsPxjZwUuUZ13Rdw0YjaU+V4yTL6a5fFX7/YQsRr
         g9cWZyxX+8Y3Tz5wFFqI5LfKtXGlm8hi3/CsTzSBFOKNdCWS+GlVStjyWBq3r9I0zD3o
         kfjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769962733; x=1770567533;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4BtcOfsTNMjO1s1xNgK+IoI1+hSlSuAGGBIHgO9a7Vc=;
        b=lxkuo1QVREx8CbEsvcn06D1A+o41Qyxc1gsMughIii8hsbTRrJOg9WQIYFIzRjcQpH
         642qhsy/wp2nMTiu5nkT4gfhrVTQ0LHdSlWXhP6RXn9YxNb/cdesYP6wE4OyVov9dXk7
         mXZ6aKByMETI0VUIaiaVRL/XxeiHyZN5mFheM5XyiGaBuKARHgZ3fWAIjK/yndvNIN5J
         PixbmKqYTmKzhQ4ULoPVD/GHiKSONEWw4cKw9cn1oeVJHv9Q/zKe3/czGwARDDv/xpmv
         H26YN6zA6o7jL+6gdVya1nv6+e9WKHKAUseX81zT9zEz1+mcqeLIKzBqPzSe0mAz2Rl6
         jHNg==
X-Gm-Message-State: AOJu0YzCmN+MsMuF9DOCmoi8eRP1dZnGImKq4d/YPH5+0LJkpKKQL4q9
	q+vOwsEXNxbJqEytBSu4E3fonoXQ1l0er54aaTW8JWrfgUVm/PJ0w5uUTEMhag==
X-Gm-Gg: AZuq6aKMIP/Fq+ll149COaABKZWUAGOedU/BkfBoUToE3O6dFBkWKOHuAOldkSkQuNc
	Gl++oKBJb7K4q162+/A6GHWUWWH7LFkZk+PqN2HnKJVr8MOFqwUiBNbAAvDMbyNIslo/5hJXyQ+
	PpQ4g+BAftXvlQyQ/bW3hNMy/oGSDsSmTgY1je9QTqtS4uuI7D1x7hIv5F6PcnwCCSN/GKlQRPi
	yVqlrdmxnPJonfUiHfFmzGTTOokxrXyoE0uINlGD+0kZBjc/fK2jd8ts0xb3K0c6Lv/GuEbt4w8
	+yK7vBOtljAZwNA4KFOn/VVpPDsbcESfgvtIp+G9Hzjd9mpaszLXS23s29ocRwJcyHclnffUtpj
	uoAL7Ae4aOAG5FIYACbVBhB6L7wZDeoghvN3hooDTKgVYn0aPe5DxeuzgSfJR0mOqWiKDOe2f2c
	Jy+CkE+Zgm9vUItZkc9nZzM4LU6kvbDLtnXSXTysUrsV1ZrRnF
X-Received: by 2002:a05:6000:2887:b0:430:f5ed:83e3 with SMTP id ffacd0b85a97d-435f3a6a951mr10906327f8f.6.1769962733196;
        Sun, 01 Feb 2026 08:18:53 -0800 (PST)
Received: from hp.. (109241135248.swidnica.vectranet.pl. [109.241.135.248])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e131ce93sm36368545f8f.24.2026.02.01.08.18.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Feb 2026 08:18:52 -0800 (PST)
From: Janusz Dziedzic <janusz.dziedzic@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net,
	Janusz Dziedzic <janusz.dziedzic@gmail.com>
Subject: [RFC v6 wireless-next 2/4] wifi: cfg80211: set and report chandef CAC ongoing
Date: Sun,  1 Feb 2026 17:15:40 +0100
Message-ID: <20260201161836.16506-3-janusz.dziedzic@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260201161836.16506-1-janusz.dziedzic@gmail.com>
References: <20260201161836.16506-1-janusz.dziedzic@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31429-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C4637C66AF
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
index 7911ed58abbb..82840040dc02 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -188,6 +188,8 @@ enum ieee80211_channel_flags {
  *	on this channel.
  * @dfs_state_entered: timestamp (jiffies) when the dfs state was entered.
  * @dfs_cac_ms: DFS CAC time in milliseconds, this is valid for DFS channels.
+ * @cac_start_time: timestamp (CLOCK_BOOTTIME, nanoseconds) when CAC was
+ *	started on this channel. Zero when CAC is not in progress.
  * @psd: power spectral density (in dBm)
  */
 struct ieee80211_channel {
@@ -205,6 +207,7 @@ struct ieee80211_channel {
 	enum nl80211_dfs_state dfs_state;
 	unsigned long dfs_state_entered;
 	unsigned int dfs_cac_ms;
+	u64 cac_start_time;
 	s8 psd;
 };
 
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 706a98686068..c13c587e83cf 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -4453,6 +4453,10 @@ enum nl80211_wmm_rule {
  * @NL80211_FREQUENCY_ATTR_S1G_NO_PRIMARY: Channel is not permitted for use
  *	as a primary channel. Does not prevent the channel from existing
  *	as a non-primary subchannel. Only applicable to S1G channels.
+ * @NL80211_FREQUENCY_ATTR_CAC_START_TIME: Channel Availability Check (CAC)
+ *	start time (CLOCK_BOOTTIME, nanoseconds). Only present when CAC is
+ *	currently in progress on this channel.
+ * @NL80211_FREQUENCY_ATTR_PAD: attribute used for padding for 64-bit alignment
  * @NL80211_FREQUENCY_ATTR_MAX: highest frequency attribute number
  *	currently defined
  * @__NL80211_FREQUENCY_ATTR_AFTER_LAST: internal use
@@ -4502,6 +4506,8 @@ enum nl80211_frequency_attr {
 	NL80211_FREQUENCY_ATTR_NO_8MHZ,
 	NL80211_FREQUENCY_ATTR_NO_16MHZ,
 	NL80211_FREQUENCY_ATTR_S1G_NO_PRIMARY,
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
index 212178d04efa..cafb39596a40 100644
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
@@ -1306,7 +1311,9 @@ void cfg80211_stop_radar_detection(struct wireless_dev *wdev)
 			continue;
 
 		chandef = *wdev_chandef(wdev, link_id);
+		wdev->links[link_id].cac_started = false;
 		rdev_end_cac(rdev, wdev->netdev, link_id);
+		cfg80211_set_cac_state(wiphy, &chandef, false);
 		nl80211_radar_notify(rdev, &chandef, NL80211_RADAR_CAC_ABORTED,
 				     wdev->netdev, GFP_KERNEL);
 	}
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 9aa83a6943a2..99b323528211 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -1319,6 +1319,12 @@ static int nl80211_msg_put_channel(struct sk_buff *msg, struct wiphy *wiphy,
 		if ((chan->flags & IEEE80211_CHAN_S1G_NO_PRIMARY) &&
 		    nla_put_flag(msg, NL80211_FREQUENCY_ATTR_S1G_NO_PRIMARY))
 			goto nla_put_failure;
+		if (chan->cac_start_time &&
+		    nla_put_u64_64bit(msg,
+				      NL80211_FREQUENCY_ATTR_CAC_START_TIME,
+				      chan->cac_start_time,
+				      NL80211_FREQUENCY_ATTR_PAD))
+			goto nla_put_failure;
 	}
 
 	if (nla_put_u32(msg, NL80211_FREQUENCY_ATTR_MAX_TX_POWER,
@@ -11276,6 +11282,7 @@ static int nl80211_start_radar_detection(struct sk_buff *skb,
 	wdev->links[link_id].cac_started = true;
 	wdev->links[link_id].cac_start_time = jiffies;
 	wdev->links[link_id].cac_time_ms = cac_time_ms;
+	cfg80211_set_cac_state(wiphy, &chandef, true);
 
 	return 0;
 }
-- 
2.43.0


