Return-Path: <linux-wireless+bounces-31145-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aMfTKQc/dmmXOAEAu9opvQ
	(envelope-from <linux-wireless+bounces-31145-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 25 Jan 2026 17:04:23 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E24481545
	for <lists+linux-wireless@lfdr.de>; Sun, 25 Jan 2026 17:04:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C72D43008E13
	for <lists+linux-wireless@lfdr.de>; Sun, 25 Jan 2026 16:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A109AD24;
	Sun, 25 Jan 2026 16:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="icHWwxbM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8F731A7E1
	for <linux-wireless@vger.kernel.org>; Sun, 25 Jan 2026 16:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769357051; cv=none; b=IqKYmQfjHeCLpfhmhMZdtyVzKNadQLtR4Yh6uUZUaqv5DJuCxw3/LZVmZrmx7rmfWt/K1nA6YeyrJgKUURRzdHqbioKH1uNYzhTh1BOj3o3sEBTj5xhcjhKDTlAW+oJbEOg1cK7BvDcCM8is576PHc0FnWGVJjcrp1Bf9FEvUVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769357051; c=relaxed/simple;
	bh=/0XdYXO1M86bT12fQu3XesMPgIof8xuJzfjl5C0XJAo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZpBXv/Clvo+fKsR+C0G53qSJa4muRJB+41KCYzgYK6LaXwrvOk74wdoQ/2djaepbo26olljwDuBtChK2JtQ/uzajFObSGVdrTILEtPg7oR3403GE2ljRKfDrcuXnmMsYkMwdKEtxmtH2oxojRrjUuiuhxRoZ9+hzZAaOzqFRVFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=icHWwxbM; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b7cf4a975d2so542219966b.2
        for <linux-wireless@vger.kernel.org>; Sun, 25 Jan 2026 08:04:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769357048; x=1769961848; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iQ5jxsrC6AekA3hTFrO2XakuC+6Vj65PTj/TCafuIn0=;
        b=icHWwxbM4HjikBciBHQm5xixx/qdcggTC9i05dilzjRRbcARd0VeknV4U2/hoTNcv3
         ZRNTpSr/YQXb2SlEyTYPBEZNXfPY/JM4kw9hLxCFi9wEmjFGxafoTDShnc64vNa/I/5g
         ECzGSdqOIfJsomaw1zm0TRhloK214+h8OF6JkBn2yB2XrUjpTM+IY+9EqNWtQ4zjhLp8
         VqPMWbs6OStdEUDR2m3lFBCvswBERY2eLg+X4hsiXf+lPBTuD44QzhZJLhjp4M1Uipvm
         kPf+PLsGNoLVibGMlodeOwiYr1WWtM4pt3bneg7B6rzZtam7aPHoe0X+rbb0PTU3GyFi
         ULsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769357048; x=1769961848;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iQ5jxsrC6AekA3hTFrO2XakuC+6Vj65PTj/TCafuIn0=;
        b=jmRb8EkL/NNIDiYn0oKWvdzqCYCEhdfpB23DalVd6GgtLd9N7BKK+nh3Q21hi/oNqY
         d48PZlxINCZkbm1qPhvCVlxrWa8LFlJjg39UjXZGa/qr5rvLfimLQJniK+v3Ra7DIt8+
         VtJVK898y8MG8kUQe04QBuEQ2S6yg8VHXouCFMSgwzeXmlypGQfh8RbKj6QFTztJoTnQ
         cRqWSnvKFPKhHUnFyMI9hC3ESQubEnnYQrmIPDHLnblQ2J/oSsYA+vX7yGj9nhDOjs83
         9Asp1MvbeOV4xb4eI7GLPcaWFGvfupnMa1PkoBqGI4YqNa+CXlSI5GEbky9iCmxHXidj
         thCQ==
X-Gm-Message-State: AOJu0Yzqd87ToXLtGae5hO/zhk1pv1j/Nvbbg0CqejPjIgUPBhjmbJJd
	d61jkF4yM8y3LHEBhy712Vl57FUtu308UAF7c42fnJy1zpARmHOkDvcNiCwMvA==
X-Gm-Gg: AZuq6aJxreU29APlJNK8/T7APOgzDnMsjvS4ZxZXPCOaVLO/mSmxM+eybMJ7dffSuNo
	byXHHzEwNWobbowZK2x5/WcCPe6yrzfnEK5yvgaCJ2u4/Hk1xHDuBtyOpvifqUfLE8GXI8FhIXY
	55wtJlO/3SZGY2LsRYD+d+AOvEBKZWVgI+ybMru7xJo7Pbwx3lS4YF19y2SSFAed9RvbJdaoCq/
	ZtE6nIEQAUk2HzGbhwmNF1orwd6bBqmWukcWbmps6mVWX4FMCyOmDQ3wfSOF6vR23qFMDKS8Yeq
	p8ob+Ujdd9vIEnLa0TjldFuxb9FlBz8mvr33+LTp1KSO4PEdvb3APqYIvFgXlgtxluDq+z89Rv5
	+UAVbz+CvAXLKXuZ/BiRPEN22VzprmIwahmwGf9arxmFkZJWk9WERD4v7W14aTFAA85nX/R/1v1
	OsVUSLK+eohJokGrBTHw8FemZOGIBhz9DztJKVKeF3mkDiLcjXGcjzRKzCzEo=
X-Received: by 2002:a17:907:d0b:b0:b88:637d:30e1 with SMTP id a640c23a62f3a-b8d2e8cde57mr118726166b.65.1769357047590;
        Sun, 25 Jan 2026 08:04:07 -0800 (PST)
Received: from hp.. (109241135248.swidnica.vectranet.pl. [109.241.135.248])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b886a249e69sm408330466b.6.2026.01.25.08.04.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jan 2026 08:04:07 -0800 (PST)
From: Janusz Dziedzic <janusz.dziedzic@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net,
	Janusz Dziedzic <janusz.dziedzic@gmail.com>
Subject: [RFC v5 wireless-next 2/4] wifi: cfg80211: set and report chandef CAC ongoing
Date: Sun, 25 Jan 2026 17:00:30 +0100
Message-ID: <20260125160353.34102-3-janusz.dziedzic@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260125160353.34102-1-janusz.dziedzic@gmail.com>
References: <20260125160353.34102-1-janusz.dziedzic@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-31145-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[sipsolutions.net,gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_NEQ_ENVFROM(0.00)[januszdziedzic@gmail.com,linux-wireless@vger.kernel.org];
	TAGGED_RCPT(0.00)[linux-wireless];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 0E24481545
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
index 6d8e35a0dde4..c35ce6d620df 100644
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
index b0f050e36fa4..7c23fd1b8ce9 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -4452,6 +4452,10 @@ enum nl80211_wmm_rule {
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
@@ -4501,6 +4505,8 @@ enum nl80211_frequency_attr {
 	NL80211_FREQUENCY_ATTR_NO_8MHZ,
 	NL80211_FREQUENCY_ATTR_NO_16MHZ,
 	NL80211_FREQUENCY_ATTR_S1G_NO_PRIMARY,
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
index 56cc5ed33ea3..a29419d7256a 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -1318,6 +1318,12 @@ static int nl80211_msg_put_channel(struct sk_buff *msg, struct wiphy *wiphy,
 		if ((chan->flags & IEEE80211_CHAN_S1G_NO_PRIMARY) &&
 		    nla_put_flag(msg, NL80211_FREQUENCY_ATTR_S1G_NO_PRIMARY))
 			goto nla_put_failure;
+		if (chan->cac_ongoing_time &&
+		    nla_put_u64_64bit(msg,
+				      NL80211_FREQUENCY_ATTR_CAC_START_TIME,
+				      chan->cac_ongoing_time,
+				      NL80211_FREQUENCY_ATTR_PAD))
+			goto nla_put_failure;
 	}
 
 	if (nla_put_u32(msg, NL80211_FREQUENCY_ATTR_MAX_TX_POWER,
@@ -11249,6 +11255,7 @@ static int nl80211_start_radar_detection(struct sk_buff *skb,
 	wdev->links[link_id].cac_started = true;
 	wdev->links[link_id].cac_start_time = jiffies;
 	wdev->links[link_id].cac_time_ms = cac_time_ms;
+	cfg80211_set_cac_state(wiphy, &chandef, true);
 
 	return 0;
 }
-- 
2.43.0


