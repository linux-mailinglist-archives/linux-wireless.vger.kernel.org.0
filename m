Return-Path: <linux-wireless+bounces-26844-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84CC6B3B0D0
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Aug 2025 04:18:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B6B7460D20
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Aug 2025 02:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C09821FF3E;
	Fri, 29 Aug 2025 02:18:11 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99C31E32BE;
	Fri, 29 Aug 2025 02:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756433891; cv=none; b=qupyXHLlS7hQxvTvFr4gRJ0jqGLWPYKa5imY2NFopP5TEgH8CXHu7nQYdhiXO3U+CuOY9QRsuykIwhFLtet4x+koYstGEKfcs7EbbRHrcb8Fxwkiwl16wXUWrwNg9y/LzCFRjIn/rt1lSDv7BCDu0AFf8lEgHr3uQE/ENlyaecE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756433891; c=relaxed/simple;
	bh=zPImQ+S2+bHhXt3/ANQ8J2V6d3n857iAaQD+q/4oskw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=JCjLnuXSllFRicaWXpzgJ/7Rz69B17OK02wXnp5IxR1vEd2SlcPFVwY0MLOJumJ7sCBzNvgcc6/E1gj7LSpxP4+TwxOzjSGsEj699KEt5fv0KSJ9gMpIwnL9AkdPp3QJnnZUEclmOUTe1PGxBQZLWIDV7mxyrDc6/dG7aUMZF3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf17.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 68A861192D6;
	Fri, 29 Aug 2025 02:18:02 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf17.hostedemail.com (Postfix) with ESMTPA id A458F19;
	Fri, 29 Aug 2025 02:18:00 +0000 (UTC)
Date: Thu, 28 Aug 2025 22:17:59 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>, linux-wireless@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH] cfg80211: Remove unused tracepoints
Message-ID: <20250828221759.131160ee@batman.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: dksocuffydty3ausz59s7nha8f7q8jnf
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: A458F19
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+VFm/Vr4/2aUDNPbM/CaHBykL/3/sP+EY=
X-HE-Tag: 1756433880-90718
X-HE-Meta: U2FsdGVkX19djLNOA9fsDBdUBzRNk8elZK/ZlmS2qU4kZ+A/uafVQnZHNU/JujwdOswNiCKHl6AjZ5sM86iKUMmsNCkzldmtBe398xRS0SwK8XPQmnK+gXOsKB45OrTEkcoQGSu20P6drrkNw/RKbTl8bi+iUsDWz/rdwKJ0k/54+VN//yAN9eljtmNL2MEWyadJQyM1xq8oXvm5q1xJxo2EBJbH/Qp6V8PCnQeR5nmW4pi3dDZNYDR+AMA0TcUIMaAFLO0tbYR+3lNg3+LqEOVecufWA4/CDpJILdMCX/6bWeWOeao8wFJKhxNglJ6y+yuNV0HJ9UKLqQMGQ/A7WNXN1ke/piT4i+pRLBmFyswtL0R3Ae8VgPxJfr/Zdovi

From: Steven Rostedt <rostedt@goodmis.org>

Tracepoints that are defined take up around 5K each, even if they are not
used. If they are defined and not used, then they waste memory for unused
code. Soon unused tracepoints will cause warnings.

Remove the unused tracepoints of the cfg80211 subsystem. They are:

cfg80211_chandef_dfs_required
cfg80211_return_u32
cfg80211_return_uint
cfg80211_send_rx_auth

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 net/wireless/trace.h | 56 --------------------------------------------
 1 file changed, 56 deletions(-)

diff --git a/net/wireless/trace.h b/net/wireless/trace.h
index 34c584a215e5..9b6074155d59 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -3137,23 +3137,6 @@ DEFINE_EVENT(cfg80211_netdev_mac_evt, cfg80211_notify_new_peer_candidate,
 	TP_ARGS(netdev, macaddr)
 );
 
-DECLARE_EVENT_CLASS(netdev_evt_only,
-	TP_PROTO(struct net_device *netdev),
-	TP_ARGS(netdev),
-	TP_STRUCT__entry(
-		NETDEV_ENTRY
-	),
-	TP_fast_assign(
-		NETDEV_ASSIGN;
-	),
-	TP_printk(NETDEV_PR_FMT , NETDEV_PR_ARG)
-);
-
-DEFINE_EVENT(netdev_evt_only, cfg80211_send_rx_auth,
-	TP_PROTO(struct net_device *netdev),
-	TP_ARGS(netdev)
-);
-
 TRACE_EVENT(cfg80211_send_rx_assoc,
 	TP_PROTO(struct net_device *netdev,
 		 const struct cfg80211_rx_assoc_resp_data *data),
@@ -3480,21 +3463,6 @@ TRACE_EVENT(cfg80211_reg_can_beacon,
 		  __entry->prohibited_flags, __entry->permitting_flags)
 );
 
-TRACE_EVENT(cfg80211_chandef_dfs_required,
-	TP_PROTO(struct wiphy *wiphy, struct cfg80211_chan_def *chandef),
-	TP_ARGS(wiphy, chandef),
-	TP_STRUCT__entry(
-		WIPHY_ENTRY
-		CHAN_DEF_ENTRY
-	),
-	TP_fast_assign(
-		WIPHY_ASSIGN;
-		CHAN_DEF_ASSIGN(chandef);
-	),
-	TP_printk(WIPHY_PR_FMT ", " CHAN_DEF_PR_FMT,
-		  WIPHY_PR_ARG, CHAN_DEF_PR_ARG)
-);
-
 TRACE_EVENT(cfg80211_ch_switch_notify,
 	TP_PROTO(struct net_device *netdev,
 		 struct cfg80211_chan_def *chandef,
@@ -3862,30 +3830,6 @@ DEFINE_EVENT(cfg80211_bss_evt, cfg80211_return_bss,
 	TP_ARGS(pub)
 );
 
-TRACE_EVENT(cfg80211_return_uint,
-	TP_PROTO(unsigned int ret),
-	TP_ARGS(ret),
-	TP_STRUCT__entry(
-		__field(unsigned int, ret)
-	),
-	TP_fast_assign(
-		__entry->ret = ret;
-	),
-	TP_printk("ret: %d", __entry->ret)
-);
-
-TRACE_EVENT(cfg80211_return_u32,
-	TP_PROTO(u32 ret),
-	TP_ARGS(ret),
-	TP_STRUCT__entry(
-		__field(u32, ret)
-	),
-	TP_fast_assign(
-		__entry->ret = ret;
-	),
-	TP_printk("ret: %u", __entry->ret)
-);
-
 TRACE_EVENT(cfg80211_report_wowlan_wakeup,
 	TP_PROTO(struct wiphy *wiphy, struct wireless_dev *wdev,
 		 struct cfg80211_wowlan_wakeup *wakeup),
-- 
2.50.1


