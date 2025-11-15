Return-Path: <linux-wireless+bounces-28997-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 362E9C6099B
	for <lists+linux-wireless@lfdr.de>; Sat, 15 Nov 2025 18:43:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C8D08359B75
	for <lists+linux-wireless@lfdr.de>; Sat, 15 Nov 2025 17:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AABEA303C93;
	Sat, 15 Nov 2025 17:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RtReySjt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A463043B9
	for <linux-wireless@vger.kernel.org>; Sat, 15 Nov 2025 17:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763228575; cv=none; b=HwpiNbO8t7loGnUplyD6Wrk6yDltl4ZSp6Ig01LZYxorOWR8T+EdMKcke+fOXPcxSstRvVu7kaPJga6L4aJrHm3sycWzBownQWOl89313ECuu4q3NznonEPWCFd+xKCrKJ58jxFu0kh/l+P7WyKNQTqEckebwJ6F/+E4EU1ONwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763228575; c=relaxed/simple;
	bh=oY0VjKfnZc/UBI+cEwzFvBJ2YXzpCYXswcljiLg9JrA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MeTiJwPYoA/SCW0C+fi3eB6elfo7/vEeDdO2pHr6glqM3MYLDLemJe9xpyYREatMCiidwEtHuSymRXeABTbKk+GnPPIldw1Ld/yuSGu+nD6AXmoN2nLi0Ik+DTINgwi1wZHoVuOXNXBpUBw6EbiihzIS5AhgtYZz9MSge0zkPYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RtReySjt; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b736f48ba11so286309366b.0
        for <linux-wireless@vger.kernel.org>; Sat, 15 Nov 2025 09:42:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763228572; x=1763833372; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JVzRdTJcVzyAQYXar2jlosC+zpl5Ofl1CfDUWYFQTdQ=;
        b=RtReySjtGL0eY65C1LkVdHSbzgr/Upqm7gobEwfwkOATOmfHHj28/b+PrU+JlVqNSs
         uA/+7Z+Nz1LNuXr1m8UZ0e2sCNZOS/mmT3t7CAQwoCCk1G8tHtiw0mA/avL7AiSjrP3U
         WJnMTbdTK5Ac9AZS8xhGapJzbXe/mjzVGjKhBQtf7X0TqdMibpVbev3i8hvkF8Hn+czz
         fM0gWfQ5e0JCZx6eoTnLC7lAeodUpVZzXwdlzgTsRc/8rDGq3gMZAL/di7YPjkFTiafd
         MqlEKiWyX2JN3w5JuoLL8tqQIY+ZZGw7V8DEfnzeMBFtbS5rMh/INsLMxIF/fPIoCk0f
         b36Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763228572; x=1763833372;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JVzRdTJcVzyAQYXar2jlosC+zpl5Ofl1CfDUWYFQTdQ=;
        b=HWTI8jfZFc9T8tuH1Cs7AUsXXmxLX15AeYfl9guGJSH3up5lsumU7iEN8ZgRUxnwvA
         8HekyaZH8H64fRBnQjmIMAL+YXQxCyyh0eVK3LDJYxp7CeA28gU0gzwKU4vgGVVUkAJd
         8MOBRdTL7bW1RvU/syuzPKjM/jDt6CH8ewtRSr/OKx+5J3a+d3OThmfszD5tOFKOgmHE
         b1080ZSagATuw9l2NLt12r49iCbrlL/v1SpxlrNTIpceJLLE88/Z/iY8pTNterqDS7OU
         c16gqe5s+Ymwtl0r3xlsG4kywRGBFvh0DQWhe5WS+OICDA+zs0OiV//bOd4keiIt2t/v
         mJ4w==
X-Gm-Message-State: AOJu0YycUt053blwpnMkKHJQfDHZHsS614FjC7jEQPD7HZLd+uysfT+J
	86J+RMZTxg2CddEJyHKP0tWezHUz2mPXWVrc4ia1JN+vJJav8GM+pBkyQKZXpA==
X-Gm-Gg: ASbGncvSKswGZozWsyQX+UDIxKCP641YCueaVp9GRyBhADJTjUeaklWQpNRKo3HM4Ze
	oN///Y2/mXEkjU/BYrEmXIJutDfU97dRUbjudd5PyX1FXe5WZLTRa0R3YLWlj80dWdI8H1ru3VV
	RORThPFCLVaT4WqEUzuSIQW47iAQpyQCL2pacSeAJE7gcxc42fHxnhMsKpysE15Btx+MkgbgFu0
	jUlPbysECR7OHnrF+DUyd1lTRXRiTSHPwyxxDTvUlSsYHFGW4VLCVgT8bbiMGh2vFIORgsjeQ6c
	QKLvVBkFuRPxDGXCNIPn644IIBeVf9TeNhDlmNZsHcbApWtRqQlHpzmBC2a1fZmV1f2cyIFk44c
	UQVNGskSPe3PBBIf5Fs0C3mEK1gtc/h617Im7nCjjdg1uNtQrxOe3gydtMKaci0ksfsHTxepKnf
	m6ge+f1NiSTydqsWlirIteZmJEksvxt12H+uglebhvvYjbbQROA9U=
X-Google-Smtp-Source: AGHT+IG1+q0Py4CHKwnB8g9zrr9R22ozmn3Fg7sf09hY2f6I0StuPb9Z0WOVw8cdOjrlOULxY2W7GQ==
X-Received: by 2002:a17:906:2991:b0:b70:e107:1918 with SMTP id a640c23a62f3a-b736574c6b4mr685839966b.3.1763228571740;
        Sat, 15 Nov 2025 09:42:51 -0800 (PST)
Received: from hp.lan (109241135248.swidnica.vectranet.pl. [109.241.135.248])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b734fd8099asm664941666b.43.2025.11.15.09.42.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Nov 2025 09:42:51 -0800 (PST)
From: Janusz Dziedzic <janusz.dziedzic@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net,
	Janusz Dziedzic <janusz.dziedzic@gmail.com>
Subject: [RFC v3 wireless-next 2/4] wifi: cfg80211: set and report chandef CAC ongoing
Date: Sat, 15 Nov 2025 18:33:20 +0100
Message-ID: <20251115174230.20504-3-janusz.dziedzic@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251115174230.20504-1-janusz.dziedzic@gmail.com>
References: <20251115174230.20504-1-janusz.dziedzic@gmail.com>
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
index 625cb2c78361..cfe5e8c4ae66 100644
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
index 68221b1ab45e..fccae9127f09 100644
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
+		if (!c || !(c->flags & IEEE80211_CHAN_RADAR))
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
index 8f947115369f..df01550be15a 100644
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
index 29c92bc8291b..b3fadf9665a4 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -1249,6 +1249,12 @@ static int nl80211_msg_put_channel(struct sk_buff *msg, struct wiphy *wiphy,
 					NL80211_FREQUENCY_ATTR_DFS_CAC_TIME,
 					chan->dfs_cac_ms))
 				goto nla_put_failure;
+			if (chan->cac_ongoing_time &&
+			    nla_put_u64_64bit(msg,
+					      NL80211_FREQUENCY_ATTR_CAC_START_TIME,
+					      chan->cac_ongoing_time,
+					      NL80211_FREQUENCY_ATTR_PAD))
+				goto nla_put_failure;
 		}
 	}
 
@@ -11228,6 +11234,7 @@ static int nl80211_start_radar_detection(struct sk_buff *skb,
 	wdev->links[link_id].cac_started = true;
 	wdev->links[link_id].cac_start_time = jiffies;
 	wdev->links[link_id].cac_time_ms = cac_time_ms;
+	cfg80211_set_cac_state(wiphy, &chandef, true);
 
 	return 0;
 }
-- 
2.43.0


