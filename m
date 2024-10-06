Return-Path: <linux-wireless+bounces-13571-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41126992227
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Oct 2024 00:53:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0A36B211E5
	for <lists+linux-wireless@lfdr.de>; Sun,  6 Oct 2024 22:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F1AA18C016;
	Sun,  6 Oct 2024 22:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="CKhc6S5M"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF3417335C;
	Sun,  6 Oct 2024 22:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728255200; cv=none; b=L7asYnQW4eGYUsNl0vjyKBWQ8YBqGg7fnof/hlPFmydWzYAV/BWpRTibWe57j1CsPUPhnMK50AzclJ6Y5Q9uxerS1kMpbny4uH5gNvyTyFB5cjfNfTUwPkY+ABU168wr0za7H9aDTuDhv24Qehx7wTcbK0DalS0sVVwhTDyqx1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728255200; c=relaxed/simple;
	bh=Of3ewFYPAsAI1H+tkSL99SC2LLS2QQ9DuiAiKAP1EGk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iContvtZ14bndEb4PMO+pWsijrcJztlm9usArjXyzCPBtk4RjT8OstdCU6pZeta3pVCEmDvrtJuNT35npq7VtuaOY4ldvT4OkcbPQo2mlU3JHci7clHwAVcMdsDK3T8FioCFK1OaM74RIKo2OM0dQ21Ym1//xSW+7OSOocW0gfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=CKhc6S5M; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=1Po/4b5GDhTFckPAtrsG1PuoF6Q+mG7FncT9Bby/ovc=; b=CKhc6S5MF2n2CsK1
	NRQIEaOWUiyhAo3oM8Bw5hIk4IDdyXPaShoBBYReeL8DhqrxzMSmhdeNdx7uSw4oBeMXfXxCkiPzC
	ag42UqeZLRQcO+enMhqWOwBDhaFtG8J6RAEewZXR6C6PZVW89xTo4IGxRKp6a3fr6kvzEzjcz9pZy
	NZNlEfqsoqUqoILLQlxJ6ad+yYM2ICTQMFTf1bo1iz7TM2wwGxax/f5j1lOMH2uNAkGnGj/SjU4sl
	j48Wl0xdnLbSvfzmOtCJrHg+X8HjXhGdAYNGmC9zm0AqataYBymxv2IiuuYA7xnUoWXFq12RB3F0Z
	pmY2mVsBdZmaQFNWbg==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1sxa7d-009LcO-26;
	Sun, 06 Oct 2024 22:53:05 +0000
From: linux@treblig.org
To: johannes@sipsolutions.net,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-wireless@vger.kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH 2/2] cfg80211: Remove unused cfg80211_vendor_ functions
Date: Sun,  6 Oct 2024 23:53:03 +0100
Message-ID: <20241006225303.121445-3-linux@treblig.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241006225303.121445-1-linux@treblig.org>
References: <20241006225303.121445-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

cfg80211_vendor_cmd_get_sender() and cfg80211_vendor_event_alloc_ucast()
were added in 2019 by commit
55c1fdf0d6c5 ("cfg80211: allow sending vendor events unicast")

but never used.

Remove them.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 include/net/cfg80211.h | 45 ------------------------------------------
 net/wireless/nl80211.c | 11 -----------
 2 files changed, 56 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index fd843a519329..cd3ed718efe2 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -7806,16 +7806,6 @@ cfg80211_vendor_cmd_alloc_reply_skb(struct wiphy *wiphy, int approxlen)
  */
 int cfg80211_vendor_cmd_reply(struct sk_buff *skb);
 
-/**
- * cfg80211_vendor_cmd_get_sender - get the current sender netlink ID
- * @wiphy: the wiphy
- *
- * Return: the current netlink port ID in a vendor command handler.
- *
- * Context: May only be called from a vendor command handler
- */
-unsigned int cfg80211_vendor_cmd_get_sender(struct wiphy *wiphy);
-
 /**
  * cfg80211_vendor_event_alloc - allocate vendor-specific event skb
  * @wiphy: the wiphy
@@ -7846,41 +7836,6 @@ cfg80211_vendor_event_alloc(struct wiphy *wiphy, struct wireless_dev *wdev,
 					  0, event_idx, approxlen, gfp);
 }
 
-/**
- * cfg80211_vendor_event_alloc_ucast - alloc unicast vendor-specific event skb
- * @wiphy: the wiphy
- * @wdev: the wireless device
- * @event_idx: index of the vendor event in the wiphy's vendor_events
- * @portid: port ID of the receiver
- * @approxlen: an upper bound of the length of the data that will
- *	be put into the skb
- * @gfp: allocation flags
- *
- * This function allocates and pre-fills an skb for an event to send to
- * a specific (userland) socket. This socket would previously have been
- * obtained by cfg80211_vendor_cmd_get_sender(), and the caller MUST take
- * care to register a netlink notifier to see when the socket closes.
- *
- * If wdev != NULL, both the ifindex and identifier of the specified
- * wireless device are added to the event message before the vendor data
- * attribute.
- *
- * When done filling the skb, call cfg80211_vendor_event() with the
- * skb to send the event.
- *
- * Return: An allocated and pre-filled skb. %NULL if any errors happen.
- */
-static inline struct sk_buff *
-cfg80211_vendor_event_alloc_ucast(struct wiphy *wiphy,
-				  struct wireless_dev *wdev,
-				  unsigned int portid, int approxlen,
-				  int event_idx, gfp_t gfp)
-{
-	return __cfg80211_alloc_event_skb(wiphy, wdev, NL80211_CMD_VENDOR,
-					  NL80211_ATTR_VENDOR_DATA,
-					  portid, event_idx, approxlen, gfp);
-}
-
 /**
  * cfg80211_vendor_event - send the event
  * @skb: The skb, must have been allocated with cfg80211_vendor_event_alloc()
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 9ab777e0bd4d..674ab5fa6da0 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -15416,17 +15416,6 @@ int cfg80211_vendor_cmd_reply(struct sk_buff *skb)
 }
 EXPORT_SYMBOL_GPL(cfg80211_vendor_cmd_reply);
 
-unsigned int cfg80211_vendor_cmd_get_sender(struct wiphy *wiphy)
-{
-	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wiphy);
-
-	if (WARN_ON(!rdev->cur_cmd_info))
-		return 0;
-
-	return rdev->cur_cmd_info->snd_portid;
-}
-EXPORT_SYMBOL_GPL(cfg80211_vendor_cmd_get_sender);
-
 static int nl80211_set_qos_map(struct sk_buff *skb,
 			       struct genl_info *info)
 {
-- 
2.46.2


