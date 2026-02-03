Return-Path: <linux-wireless+bounces-31508-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ECIVDllGgmlHRQMAu9opvQ
	(envelope-from <linux-wireless+bounces-31508-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 03 Feb 2026 20:02:49 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B40A8DE07A
	for <lists+linux-wireless@lfdr.de>; Tue, 03 Feb 2026 20:02:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7523730DD949
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Feb 2026 18:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C65366DDF;
	Tue,  3 Feb 2026 18:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JLvlaGzd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F39B31ED73
	for <linux-wireless@vger.kernel.org>; Tue,  3 Feb 2026 18:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770145056; cv=none; b=KMXEoUHC6r8fXdDfxBx7vH7btd3gd99AsIjp648u45qucMau2hVtG6d/oMs9klF7TDGg29p1VYqME8x/GDfl6UVs2GcDhhLa6uz879CVuwlUSYmFs0vWDhNUyES9+TDArnkVkj3sG9O+UOP7YCdjqYeGM1urx7NmURirR2/zESg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770145056; c=relaxed/simple;
	bh=DEFdJmxb+y8cdFoKPUC52cxLFQPWr2mDeOH0LvL7d4s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O9hhT2au7r7AJ9IeahapQfbAI7osTGblII2bS5aFW90Sp2QJGM0w/+s8auCXXTWWovkFBKfYBxXNciNhxJ9DRlOCDerIrOHDAqiEgqy3Jt8ZlryvvGfF/d0fwGJe4QOq3rVQvqJnmpGV1EF47tq0shBzbjErKqs+z4PqI6LiQqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JLvlaGzd; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4806cc07ce7so60057755e9.1
        for <linux-wireless@vger.kernel.org>; Tue, 03 Feb 2026 10:57:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770145053; x=1770749853; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hdFe/segB4QmDAxU0QlmGbRC05RUwO/bjixFgiYeL0c=;
        b=JLvlaGzdaIXNI3GvkA32iczIOUK03STQkTPknT5dsktmhauCC/XXWhssfYzhUvSu1l
         fmc3aEWl+Wzflot51pVKXLx9lMoT46sVASRisYPZY2Dq3XoCGtFRHICSeogOM3PI4Xps
         V32EXyz2ImjdoNNLwPENJkiBoT4uASzZRZxKv7pzAgoIlq+fIwZso2gAXQBZ6XE26gTl
         Z44gATzG/8Uq5HSLBhE0Bw0SGGYF8VHOpElSqJm5m+WgA8jpAsEwzZPCp9R2Y1plxY4R
         dtENot55gSgZvQWf9tgWXYQRcbYycq50JfJwjT7NnL6S4jTYKosiey8xTaqm/5fs3t/L
         tjyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770145053; x=1770749853;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hdFe/segB4QmDAxU0QlmGbRC05RUwO/bjixFgiYeL0c=;
        b=lWtUskBea5EJF10rBFRAIzezZQpFLnBG6xHh5NNk+/aODLLka9e+RT2iR6OgwGpBnX
         9u4WB9W6wko5xSC8DVILgO3TzlxiRXVWQ3BvQIykrjjFfl+5lLnIifMj5eMFw7xlvqyc
         MAjSawCPzwivMTmsplebFJH9N3rK5P+Qx2hHy3XcnbeHfxWwmM3+snBc4Zh4vIsyrfzb
         wWBC9/HOxF9np8M9YjFffGA1PVVnKuY3yy5vq6uL/MLmaso+U8Uj1eLKRVUBuQ087vPZ
         tkqZ9/of7hAp6lEHQ2IrLW3grIeNXeLXZZnoZBCRmLq/n71xlzai9TvQtT2c7gO9UW3g
         x8zw==
X-Gm-Message-State: AOJu0Yw5V3LJJyIuQySk0KrQdZ5d6R72HQ5ff9KbClXMJEFOxkD7bA8V
	vaCsTjDc/j4cxmrJ51D5i1gMOLN/3Kbo/MI1uNujKgC2soRhEf0277buXJ24pA==
X-Gm-Gg: AZuq6aLIQIhHfNO9bMyXDX0rrsdnN1zdC8dRr+5eOUmBb07eXvzdpDAEGQINGfn4i1Z
	0OqGfw5kaVls/7pG/57pp3AGY5TB0i9GH1LATkNgVWZaQEFvpg6dN7irEDDgtN+yG/Mpsi7/xJ6
	zD88z4T4NKbKIL/3ribbdhmW1PURWoOI6ERQNsKG+eFgIO9F5+9zxpuqqqqqfma2Lz2xBrKgopf
	9WAmLIuSdKj6kR07MAGDEz70SJJsabMTLRilypUPtNvueOzxs4zdyN+1S2mDsULSLN2C+rjahuQ
	tZAtSmYF2vM4i6PSWEOW8T7GMIAz/0zqehlowkOKNKzgk1SLk9ubr46q07jE4l4EuUOhiGOFyyX
	CSXlkm5vV30qaKCzDP1rR0eJENSj5T2E4CSxJQmOMtfAFWFaDSIPciF2RT9B2H3f64eTFuRu99i
	4MP9Uey26+X2BooE+/WXSNBjvg4tqXGFOKGiMrQ/Qq4bo07cUJ
X-Received: by 2002:a05:600c:4513:b0:480:3b26:82c3 with SMTP id 5b1f17b1804b1-4830e988d63mr8150975e9.20.1770145053237;
        Tue, 03 Feb 2026 10:57:33 -0800 (PST)
Received: from hp.. (109241135248.swidnica.vectranet.pl. [109.241.135.248])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4830eac4d11sm7773425e9.3.2026.02.03.10.57.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 10:57:32 -0800 (PST)
From: Janusz Dziedzic <janusz.dziedzic@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net,
	Janusz Dziedzic <janusz.dziedzic@gmail.com>
Subject: [PATCH wireless-next 2/4] wifi: cfg80211: set and report chandef CAC ongoing
Date: Tue,  3 Feb 2026 19:53:47 +0100
Message-ID: <20260203185717.103810-3-janusz.dziedzic@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260203185717.103810-1-janusz.dziedzic@gmail.com>
References: <20260203185717.103810-1-janusz.dziedzic@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31508-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B40A8DE07A
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


