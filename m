Return-Path: <linux-wireless+bounces-7232-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EE938BD50F
	for <lists+linux-wireless@lfdr.de>; Mon,  6 May 2024 21:00:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41D2C1C21612
	for <lists+linux-wireless@lfdr.de>; Mon,  6 May 2024 19:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B7A8158D9B;
	Mon,  6 May 2024 19:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="MCaJMdEi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D28158D82
	for <linux-wireless@vger.kernel.org>; Mon,  6 May 2024 19:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715022010; cv=none; b=KW3q3X/rO3WjdXsrDkHDtZmHsS749vHvEb2X32Tvyk7L0FYdZAbVrCy+Ysn/sQqx6BDlCKJf5fmpOE/Ber/10nMYv365zo6RZLATqOm56j98PfpQf0O+70WxBN742Fbd8ghhuNsiSSQzlyOlkTIbcftacdG1oqqvY7fP8DBJ3jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715022010; c=relaxed/simple;
	bh=QyB//3IUrzfqO23z9lr9hQ4gS5XZRxSAeqHHxC5Hbd0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BRZicg6g+uZ/zPWHhkWW9scP/x4nCxqqgDPuwGIsx2bdvHSDp8QJmYkkRQ50Wiz12dlABYv1yHDh0O0ex19AMIjoDwTQeb6UpwQh2OouwQHEZ8jOtSelqMyXlpE8oLEifoBroKUZ1RRs7R6vwiEE/CEKXN+n9kKpyjUgXT+ppIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=MCaJMdEi; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=ES7RY2sCEFEy4SCCyThYbBCmiEsvUpGS8N3+oCMC3xA=; t=1715022008; x=1716231608; 
	b=MCaJMdEiLuMvsQGs7qHTU9hg5WLNj+mhZd0gincKNdRHmX+80mDCqQsdyGLeUB1cFAiQeEi2rTr
	UHIIpcAi/sJHAJKoaf+XrUo+rhqCQF9XyonfqYL7Q0xHA8BZLf0+QUy6zDjo7r6uGx1zoVIrga7/C
	47vnjXvQ1Ydhh9rtditY3stAKsXRAHH9GkyOabfCmmBb91Uwt3fOvUYRT5uURj9JyMJ8ffkTzRIBw
	GdB+6MojA4lRobqt9GAWszZjkAZX4VZ4y2EAFtaBA1EK32vyczvk+xKnal1oyFdrr4qtZHtpyDjlh
	MWcwXTEVOh6bFS8+WMyfJRPD56VaC32NqdQA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1s43ZF-0000000899m-021o;
	Mon, 06 May 2024 21:00:05 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH 1/2] wifi: cfg80211: sort trace events again
Date: Mon,  6 May 2024 21:00:02 +0200
Message-ID: <20240506210002.0b3a86a5d8d7.I5591c03223bdb95597e181de63a2eded424de34c@changeid>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

They were meant to be split into ops and APIs, but some
ops were added in the wrong place. Fix that.

Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/wireless/trace.h | 138 +++++++++++++++++++++----------------------
 1 file changed, 69 insertions(+), 69 deletions(-)

diff --git a/net/wireless/trace.h b/net/wireless/trace.h
index 9bf987519811..b76e3b21051a 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -2889,6 +2889,75 @@ DEFINE_EVENT(wiphy_wdev_link_evt, rdev_del_intf_link,
 	TP_ARGS(wiphy, wdev, link_id)
 );
 
+TRACE_EVENT(rdev_del_link_station,
+	TP_PROTO(struct wiphy *wiphy, struct net_device *netdev,
+		 struct link_station_del_parameters *params),
+	TP_ARGS(wiphy, netdev, params),
+	TP_STRUCT__entry(
+		WIPHY_ENTRY
+		NETDEV_ENTRY
+		__array(u8, mld_mac, 6)
+		__field(u32, link_id)
+	),
+	TP_fast_assign(
+		WIPHY_ASSIGN;
+		NETDEV_ASSIGN;
+		memset(__entry->mld_mac, 0, 6);
+		if (params->mld_mac)
+			memcpy(__entry->mld_mac, params->mld_mac, 6);
+		__entry->link_id = params->link_id;
+	),
+	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", station mac: %pM"
+		  ", link id: %u",
+		  WIPHY_PR_ARG, NETDEV_PR_ARG, __entry->mld_mac,
+		  __entry->link_id)
+);
+
+TRACE_EVENT(rdev_set_hw_timestamp,
+	TP_PROTO(struct wiphy *wiphy, struct net_device *netdev,
+		 struct cfg80211_set_hw_timestamp *hwts),
+
+	TP_ARGS(wiphy, netdev, hwts),
+
+	TP_STRUCT__entry(
+		WIPHY_ENTRY
+		NETDEV_ENTRY
+		MAC_ENTRY(macaddr)
+		__field(bool, enable)
+	),
+
+	TP_fast_assign(
+		WIPHY_ASSIGN;
+		NETDEV_ASSIGN;
+		MAC_ASSIGN(macaddr, hwts->macaddr);
+		__entry->enable = hwts->enable;
+	),
+
+	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", mac %pM, enable: %u",
+		  WIPHY_PR_ARG, NETDEV_PR_ARG, __entry->macaddr,
+		  __entry->enable)
+);
+
+TRACE_EVENT(rdev_set_ttlm,
+	TP_PROTO(struct wiphy *wiphy, struct net_device *netdev,
+		 struct cfg80211_ttlm_params *params),
+	TP_ARGS(wiphy, netdev, params),
+	TP_STRUCT__entry(
+		WIPHY_ENTRY
+		NETDEV_ENTRY
+		__array(u8, dlink, sizeof(u16) * 8)
+		__array(u8, ulink, sizeof(u16) * 8)
+	),
+	TP_fast_assign(
+		WIPHY_ASSIGN;
+		NETDEV_ASSIGN;
+		memcpy(__entry->dlink, params->dlink, sizeof(params->dlink));
+		memcpy(__entry->ulink, params->ulink, sizeof(params->ulink));
+	),
+	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT,
+		  WIPHY_PR_ARG, NETDEV_PR_ARG)
+);
+
 /*************************************************************
  *	     cfg80211 exported functions traces		     *
  *************************************************************/
@@ -3923,55 +3992,6 @@ DEFINE_EVENT(link_station_add_mod, rdev_mod_link_station,
 	TP_ARGS(wiphy, netdev, params)
 );
 
-TRACE_EVENT(rdev_del_link_station,
-	TP_PROTO(struct wiphy *wiphy, struct net_device *netdev,
-		 struct link_station_del_parameters *params),
-	TP_ARGS(wiphy, netdev, params),
-	TP_STRUCT__entry(
-		WIPHY_ENTRY
-		NETDEV_ENTRY
-		__array(u8, mld_mac, 6)
-		__field(u32, link_id)
-	),
-	TP_fast_assign(
-		WIPHY_ASSIGN;
-		NETDEV_ASSIGN;
-		memset(__entry->mld_mac, 0, 6);
-		if (params->mld_mac)
-			memcpy(__entry->mld_mac, params->mld_mac, 6);
-		__entry->link_id = params->link_id;
-	),
-	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", station mac: %pM"
-		  ", link id: %u",
-		  WIPHY_PR_ARG, NETDEV_PR_ARG, __entry->mld_mac,
-		  __entry->link_id)
-);
-
-TRACE_EVENT(rdev_set_hw_timestamp,
-	TP_PROTO(struct wiphy *wiphy, struct net_device *netdev,
-		 struct cfg80211_set_hw_timestamp *hwts),
-
-	TP_ARGS(wiphy, netdev, hwts),
-
-	TP_STRUCT__entry(
-		WIPHY_ENTRY
-		NETDEV_ENTRY
-		MAC_ENTRY(macaddr)
-		__field(bool, enable)
-	),
-
-	TP_fast_assign(
-		WIPHY_ASSIGN;
-		NETDEV_ASSIGN;
-		MAC_ASSIGN(macaddr, hwts->macaddr);
-		__entry->enable = hwts->enable;
-	),
-
-	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", mac %pM, enable: %u",
-		  WIPHY_PR_ARG, NETDEV_PR_ARG, __entry->macaddr,
-		  __entry->enable)
-);
-
 TRACE_EVENT(cfg80211_links_removed,
 	TP_PROTO(struct net_device *netdev, u16 link_mask),
 	TP_ARGS(netdev, link_mask),
@@ -3987,26 +4007,6 @@ TRACE_EVENT(cfg80211_links_removed,
 		  __entry->link_mask)
 );
 
-TRACE_EVENT(rdev_set_ttlm,
-	TP_PROTO(struct wiphy *wiphy, struct net_device *netdev,
-		 struct cfg80211_ttlm_params *params),
-	TP_ARGS(wiphy, netdev, params),
-	TP_STRUCT__entry(
-		WIPHY_ENTRY
-		NETDEV_ENTRY
-		__array(u8, dlink, sizeof(u16) * 8)
-		__array(u8, ulink, sizeof(u16) * 8)
-	),
-	TP_fast_assign(
-		WIPHY_ASSIGN;
-		NETDEV_ASSIGN;
-		memcpy(__entry->dlink, params->dlink, sizeof(params->dlink));
-		memcpy(__entry->ulink, params->ulink, sizeof(params->ulink));
-	),
-	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT,
-		  WIPHY_PR_ARG, NETDEV_PR_ARG)
-);
-
 #endif /* !__RDEV_OPS_TRACE || TRACE_HEADER_MULTI_READ */
 
 #undef TRACE_INCLUDE_PATH
-- 
2.44.0


