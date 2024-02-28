Return-Path: <linux-wireless+bounces-4140-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5475486AA50
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Feb 2024 09:43:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07C751F2195F
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Feb 2024 08:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D5C22D044;
	Wed, 28 Feb 2024 08:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="ZDoBd677"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E412C85D
	for <linux-wireless@vger.kernel.org>; Wed, 28 Feb 2024 08:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709109782; cv=none; b=m8ujQJ6sNbMPXvDEI7ujiAF7qsKh1FKvsqQoK5bNgW921VkiKITWMjmGo96U/NM3R0+94aO9GoHZm1j4fvf5XL7EvPFjGQba6ftxLFphM1N1KLDpqf+W8Akl9aHKPWsQNdmwzMYbqrDvoyfGwLwf4VGREYwBOKXvJwaDHJs2v9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709109782; c=relaxed/simple;
	bh=Xf4ZtpBOkItZsmZZxLCQ72kqGdomi5hQ9UI5vyqJ0X4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ST+c1C33WqzbP0ySQLslJqJaN6jnmVVrd9SsSLjEkvry8DuFQxD5kPpnydodbp4cTUdR5rzeVPHWTUx+Zb9n/b9veoMuGzt5tkJ+XTojYAKO+akCPLMaEwPnQEBfFtmltiXgQxMWDuIdXz3c4/Wl7zu2ZhsB4lu+to4AWbQ5uOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=ZDoBd677; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=IJQIgZqTsykeUAqiffiyh5ks1DaakJMyA6qSEtv7UGg=; t=1709109779; x=1710319379; 
	b=ZDoBd677Kqe5rekIwaOGD5AW3Q5brxhwKtbAy0hwcfMYCwe1WTWWOqgo7HZ0RzwcIC41XcS4I+r
	NN2nMIlVgaboy47xZACB3zwviz1nLQzBSFhz09SWJ9d0ZKhp1dAcS/uIq69aIVi9YTTXgzIaGg/Db
	XpoZTJ1ZGaw0s/ZTSfz8RTwV2Mc91dbgFZKHWvYPImRzHufjky+TjXyjTn0x8/3GKHguvy2yz4ghi
	p0FnSnNsc37JyOLVZEka87IE9VGL/kklPTV3/6Ef1R6JnlkiOCpYc4ckxlboLn3qssB/qxaQqJ5eY
	6zvZF0Nu13mCxs/bdroNKuZkI20359qHVskg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rfFWi-0000000BzrV-2KFe;
	Wed, 28 Feb 2024 09:42:56 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH] wifi: cfg80211: print flags in tracing in hex
Date: Wed, 28 Feb 2024 09:42:54 +0100
Message-ID: <20240228094254.5f7f4ab2e137.Id5e665104bbc51377b4591289e32f8c1d4711dce@changeid>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

It's confusing to see decimal, e.g. 20, here. Printing
the flags in hex (0x14 == 20) is much clearer.

Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/wireless/trace.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/wireless/trace.h b/net/wireless/trace.h
index 361331c29116..e039e66ab377 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -818,8 +818,8 @@ DECLARE_EVENT_CLASS(station_add_change,
 			params->link_sta_params.opmode_notif_used;
 	),
 	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", station mac: %pM"
-		  ", station flags mask: %u, station flags set: %u, "
-		  "station modify mask: %u, listen interval: %d, aid: %u, "
+		  ", station flags mask: 0x%x, station flags set: 0x%x, "
+		  "station modify mask: 0x%x, listen interval: %d, aid: %u, "
 		  "plink action: %u, plink state: %u, uapsd queues: %u, vlan:%s",
 		  WIPHY_PR_ARG, NETDEV_PR_ARG, __entry->sta_mac,
 		  __entry->sta_flags_mask, __entry->sta_flags_set,
@@ -1075,7 +1075,7 @@ TRACE_EVENT(rdev_return_int_mpath_info,
 	),
 	TP_printk(WIPHY_PR_FMT ", returned %d. mpath info - generation: %d, "
 		  "filled: %u, frame qlen: %u, sn: %u, metric: %u, exptime: %u,"
-		  " discovery timeout: %u, discovery retries: %u, flags: %u",
+		  " discovery timeout: %u, discovery retries: %u, flags: 0x%x",
 		  WIPHY_PR_ARG, __entry->ret, __entry->generation,
 		  __entry->filled, __entry->frame_qlen, __entry->sn,
 		  __entry->metric, __entry->exptime, __entry->discovery_timeout,
@@ -1317,7 +1317,7 @@ TRACE_EVENT(rdev_assoc,
 			       req->fils_nonces, 2 * FILS_NONCE_LEN);
 	),
 	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", bssid: %pM"
-		  ", previous bssid: %pM, use mfp: %s, flags: %u",
+		  ", previous bssid: %pM, use mfp: %s, flags: 0x%x",
 		  WIPHY_PR_ARG, NETDEV_PR_ARG, __entry->bssid,
 		  __entry->prev_bssid, BOOL_TO_STR(__entry->use_mfp),
 		  __entry->flags)
@@ -1439,7 +1439,7 @@ TRACE_EVENT(rdev_connect,
 	),
 	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", bssid: %pM"
 		  ", ssid: %s, auth type: %d, privacy: %s, wpa versions: %u, "
-		  "flags: %u, previous bssid: %pM",
+		  "flags: 0x%x, previous bssid: %pM",
 		  WIPHY_PR_ARG, NETDEV_PR_ARG, __entry->bssid, __entry->ssid,
 		  __entry->auth_type, BOOL_TO_STR(__entry->privacy),
 		  __entry->wpa_versions, __entry->flags, __entry->prev_bssid)
-- 
2.43.2


