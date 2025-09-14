Return-Path: <linux-wireless+bounces-27280-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 395E0B56AEE
	for <lists+linux-wireless@lfdr.de>; Sun, 14 Sep 2025 19:47:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92E407AD769
	for <lists+linux-wireless@lfdr.de>; Sun, 14 Sep 2025 17:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D3B82DE1E0;
	Sun, 14 Sep 2025 17:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jq09e2u1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF391D618E
	for <linux-wireless@vger.kernel.org>; Sun, 14 Sep 2025 17:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757872015; cv=none; b=Z6cVv717LYxbeaOgyCm1WA1tW1I8vxBSfZJS0DlY2Lb2qmvHdg7G3vodk/ENQh8NLBFS3dOxeI3r+LVF31UqGNs2Rv1fe2ZUIL0wXQ4Henm0ozU5rek8vQpbPkU42J49ZwcIJbnFZ6soF8XVMmjoVLWBj4S9GpxkGQZMOTH41mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757872015; c=relaxed/simple;
	bh=0vSd2YqQIHBF+2tya48ioFIOmpmU2XApy9Ln06uhWOM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T53oOgR1w658xbjc0Pk3Qz8ciq7uPbgM9Vsmf5nADd2KlrTTVBcVsDidizNr0OEQ2pyXgJSSljLi08aLMKyhxycohazezlzLP7J1u74taaSMwn/Y062eCeTfwJHBX/OFN/XnfufH+OuiTYw4f88kanh9P/s7CogZxtHtzjpgLGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jq09e2u1; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-62105d21297so6851160a12.0
        for <linux-wireless@vger.kernel.org>; Sun, 14 Sep 2025 10:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757872011; x=1758476811; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5kmp/UhCSke/4KkvCF9XZ6Mfg8e1vlWRTxk+1pjfGOQ=;
        b=jq09e2u1P7o0g+zvKgdu6IWDHXgnSdZszFcIt9pnn+R3pkGxGZaWpYM/PGao8hrHgC
         99fQPZzivVe06o3FiF+Q29KTXL2TysZ6RrMUzMtGKF17oxeI8QT8zq7/hTmC4ididzd3
         /2a8XIrskpqZETKUxXcPHf3Zeate0cLB/ok9hp6/IFFKN0u3TdIuwqCD2zUpl4uqr2U7
         3CV9HMq5L0cC4Un+CCTfTgK2x96X6A8M6oa6Yqc7vQ5iX0C+HbH0utUbopoRZo6PexU1
         b+o8/m4CDE/ElPKUF9rc0sQ5zMFwLBWOZx+bgVOiMiC5wiG0z05wN2lQKGBkOfc8T7L8
         Hiyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757872011; x=1758476811;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5kmp/UhCSke/4KkvCF9XZ6Mfg8e1vlWRTxk+1pjfGOQ=;
        b=NRxckpsvcW5l7y29I5J47+5ExKb5w5SCqPXS8W0kpHMfmlNbl3rWoBH0UEvMP9+fo8
         jwZmtWnClfxH55YzIbLTGjZwe+28q00BUb3HHQ/xQzR//VlBn/yYU9m3vc/FS0+NrUlM
         30CJ9AvUg7uWMDT0mA2czdz49ygCHjhtGO6mpNqJB6rmO6cwdkjKdr7ZOy+0uAaAaQvO
         v33OXBolGlzzeg/jGBqT/YARPHAU8muQYLmAKlE0YlNInk88BQ+u+5HwMT/LcqcK/aC9
         JpKO5vn2up55x29v52jpbbfu/t0JPoMDMemFALip1e9llzHn6BQsND43CKhPw5yt3Vtu
         5YxQ==
X-Gm-Message-State: AOJu0YzKQMRhZDvVBEPPYuzdaWfzeP3ohX5k/H6cvyu8uiaRkEAhxlzz
	d0k2E/D+f8ig2oTvBZEmcUFIRwnIjftg+Qo2fRcbFfsJYiD8f16TWyp9DwCwBw==
X-Gm-Gg: ASbGncsLZPcYm4n+Y17Ho59YJS1Vyn9SXkhkxWdqwnrdmz0AqU9qtsa7yqMtxhREufP
	FgoBd9N/g+LChRKWoF7/q18h9h4wXIayN/n5fTK/+jL/GbuDqBT2aj3n2CDeoauh00MZ9Iw1yyM
	zakh+6FJhOgrz7+tYP4Lczge+tSaK77UeK599ZRTCXFxJTS+7id/kNkxRDp6JYHfprbUEbOsjXp
	zM4b+zrpRvnrikfLveV/lAbc+AIzTM6AVRfhElE1hJ3ssuredvhH3UocvW1yycmmDSk/swmFQNF
	lc8PB49MYY+EWZ0Z8i/vTLUVEILEJ9NNMKaUvJX8r29T5XDTFyty+eFj0U07yU0QwLy0urvVgNL
	xnhFne7ojsZ6Tcko3ZDXlWKGe9D5MndhL4Pd0Uvq4oNcm/1QAjXWiCzH5SM0r
X-Google-Smtp-Source: AGHT+IEVudLoUHoxy9/D6KSH/ju8XNYgxGWxpna/lC8W8ku+xiG36CYxZpyFU1dYMAsYuaVSnDAI3A==
X-Received: by 2002:a05:6402:44d7:b0:618:a4fe:d821 with SMTP id 4fb4d7f45d1cf-62ed827194amr7972726a12.14.1757872011483;
        Sun, 14 Sep 2025 10:46:51 -0700 (PDT)
Received: from hp.. (109241135248.swidnica.vectranet.pl. [109.241.135.248])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62ee7b531d7sm5063438a12.51.2025.09.14.10.46.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 10:46:51 -0700 (PDT)
From: Janusz Dziedzic <janusz.dziedzic@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net,
	Janusz Dziedzic <janusz.dziedzic@gmail.com>
Subject: [RFC wireless-next 2/3] wifi: cfg80211: set and report chandef CAC ongoing
Date: Sun, 14 Sep 2025 19:46:21 +0200
Message-ID: <20250914174622.479249-2-janusz.dziedzic@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250914174622.479249-1-janusz.dziedzic@gmail.com>
References: <20250914174622.479249-1-janusz.dziedzic@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In case of background Channel Availability Check we
can start it from any application or via iw. This patch
allow to track and check CAC state from user mode by
simple check phy channels eg. using iw phy1 channels
command.

Signed-off-by: Janusz Dziedzic <janusz.dziedzic@gmail.com>
---
 include/net/cfg80211.h       |  5 +++++
 include/uapi/linux/nl80211.h |  6 ++++++
 net/wireless/chan.c          | 25 +++++++++++++++++++++++++
 net/wireless/core.h          |  4 ++++
 net/wireless/mlme.c          |  5 +++++
 net/wireless/nl80211.c       |  8 ++++++++
 6 files changed, 53 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 4072a67c9cc9..ae1052c2db4a 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -191,6 +191,9 @@ enum ieee80211_channel_flags {
  *	on this channel.
  * @dfs_state_entered: timestamp (jiffies) when the dfs state was entered.
  * @dfs_cac_ms: DFS CAC time in milliseconds, this is valid for DFS channels.
+ * @cac_ongoing: true if CAC is currently in progress on this channel
+ * @cac_ongoing_time: timestamp (jiffies) when CAC was started on this channel.
+ *	Only valid when @cac_ongoing is true.
  * @psd: power spectral density (in dBm)
  */
 struct ieee80211_channel {
@@ -208,6 +211,8 @@ struct ieee80211_channel {
 	enum nl80211_dfs_state dfs_state;
 	unsigned long dfs_state_entered;
 	unsigned int dfs_cac_ms;
+	bool cac_ongoing;
+	unsigned long cac_ongoing_time;
 	s8 psd;
 };
 
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index aed0b4c5d5e8..56e748afea4e 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -4396,6 +4396,10 @@ enum nl80211_wmm_rule {
  *	very low power (VLP) AP, despite being NO_IR.
  * @NL80211_FREQUENCY_ATTR_ALLOW_20MHZ_ACTIVITY: This channel can be active in
  *	20 MHz bandwidth, despite being NO_IR.
+ * @NL80211_FREQUENCY_ATTR_CAC_ONGOING: Channel Availability Check (CAC) is
+ *	currently in progress on this channel.
+ * @NL80211_FREQUENCY_ATTR_CAC_ONGOING_TIME: CAC ongoing time in milliseconds
+ *	since CAC started. Only present when CAC is ongoing.
  * @NL80211_FREQUENCY_ATTR_MAX: highest frequency attribute number
  *	currently defined
  * @__NL80211_FREQUENCY_ATTR_AFTER_LAST: internal use
@@ -4441,6 +4445,8 @@ enum nl80211_frequency_attr {
 	NL80211_FREQUENCY_ATTR_CAN_MONITOR,
 	NL80211_FREQUENCY_ATTR_ALLOW_6GHZ_VLP_AP,
 	NL80211_FREQUENCY_ATTR_ALLOW_20MHZ_ACTIVITY,
+	NL80211_FREQUENCY_ATTR_CAC_ONGOING,
+	NL80211_FREQUENCY_ATTR_CAC_ONGOING_TIME,
 
 	/* keep last */
 	__NL80211_FREQUENCY_ATTR_AFTER_LAST,
diff --git a/net/wireless/chan.c b/net/wireless/chan.c
index 193734b7f9dc..1833bafa2b03 100644
--- a/net/wireless/chan.c
+++ b/net/wireless/chan.c
@@ -646,6 +646,31 @@ void cfg80211_set_dfs_state(struct wiphy *wiphy,
 	}
 }
 
+void cfg80211_set_cac_state(struct wiphy *wiphy,
+			     const struct cfg80211_chan_def *chandef,
+			     bool cac_ongoing)
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
+			c->cac_ongoing_time = jiffies;
+	}
+}
+
 static bool
 cfg80211_dfs_permissive_check_wdev(struct cfg80211_registered_device *rdev,
 				   enum nl80211_iftype iftype,
diff --git a/net/wireless/core.h b/net/wireless/core.h
index b6bd7f4d6385..c6da96e50fc4 100644
--- a/net/wireless/core.h
+++ b/net/wireless/core.h
@@ -480,6 +480,10 @@ void cfg80211_set_dfs_state(struct wiphy *wiphy,
 			    const struct cfg80211_chan_def *chandef,
 			    enum nl80211_dfs_state dfs_state);
 
+void cfg80211_set_cac_state(struct wiphy *wiphy,
+			     const struct cfg80211_chan_def *chandef,
+			     bool cac_ongoing);
+
 void cfg80211_dfs_channels_update_work(struct work_struct *work);
 
 void cfg80211_sched_dfs_chan_update(struct cfg80211_registered_device *rdev);
diff --git a/net/wireless/mlme.c b/net/wireless/mlme.c
index 9afda72aea38..538f95d02b6a 100644
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
@@ -1193,6 +1195,7 @@ __cfg80211_background_cac_event(struct cfg80211_registered_device *rdev,
 	switch (event) {
 	case NL80211_RADAR_CAC_FINISHED:
 		cfg80211_set_dfs_state(wiphy, chandef, NL80211_DFS_AVAILABLE);
+		cfg80211_set_cac_state(wiphy, chandef, false);
 		memcpy(&rdev->cac_done_chandef, chandef, sizeof(*chandef));
 		queue_work(cfg80211_wq, &rdev->propagate_cac_done_wk);
 		cfg80211_sched_dfs_chan_update(rdev);
@@ -1201,9 +1204,11 @@ __cfg80211_background_cac_event(struct cfg80211_registered_device *rdev,
 	case NL80211_RADAR_CAC_ABORTED:
 		if (!cancel_delayed_work(&rdev->background_cac_done_wk))
 			return;
+		cfg80211_set_cac_state(wiphy, chandef, false);
 		wdev = rdev->background_radar_wdev;
 		break;
 	case NL80211_RADAR_CAC_STARTED:
+		cfg80211_set_cac_state(wiphy, chandef, true);
 		break;
 	default:
 		return;
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index b7bc7e5e81dd..8235415e72cf 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -1197,6 +1197,13 @@ static int nl80211_msg_put_channel(struct sk_buff *msg, struct wiphy *wiphy,
 					NL80211_FREQUENCY_ATTR_DFS_CAC_TIME,
 					chan->dfs_cac_ms))
 				goto nla_put_failure;
+			if (chan->cac_ongoing) {
+				if (nla_put_flag(msg, NL80211_FREQUENCY_ATTR_CAC_ONGOING))
+					goto nla_put_failure;
+				if (nla_put_u32(msg, NL80211_FREQUENCY_ATTR_CAC_ONGOING_TIME,
+						elapsed_jiffies_msecs(chan->cac_ongoing_time)))
+					goto nla_put_failure;
+			}
 		}
 	}
 
@@ -11142,6 +11149,7 @@ static int nl80211_start_radar_detection(struct sk_buff *skb,
 	wdev->links[link_id].cac_started = true;
 	wdev->links[link_id].cac_start_time = jiffies;
 	wdev->links[link_id].cac_time_ms = cac_time_ms;
+	cfg80211_set_cac_state(wiphy, &chandef, true);
 
 	return 0;
 }
-- 
2.43.0


