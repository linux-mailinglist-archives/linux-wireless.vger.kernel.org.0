Return-Path: <linux-wireless+bounces-34657-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qPGCEAuM22nuDAkAu9opvQ
	(envelope-from <linux-wireless+bounces-34657-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Apr 2026 14:11:55 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EF4563E3BBC
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Apr 2026 14:11:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 63110301681A
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Apr 2026 12:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37D183537D4;
	Sun, 12 Apr 2026 12:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AE8kXH07"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E023C3382F1
	for <linux-wireless@vger.kernel.org>; Sun, 12 Apr 2026 12:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775995902; cv=none; b=j9nCVIOe6R5c8GS0E+lRqqO0SQk7zM6iolhuv+UbIo7Lvlddpq3/jZXgxYtiPRqredwv99G0PCkRAaZq/y06WsBG3EDOJhSgnieSSM+oDBEroBK5XXmJG6svGOyYYN2+cham/uD+agKOZY5J0i+amhcbEFEUYTafScSvI+4Fa7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775995902; c=relaxed/simple;
	bh=XMUBzYW4ZmvubPpHYMYpnNs13e+TeVRvFuTp6UT2SaM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iRePaDjrPwwo2A4MiW8TozbqcVyMxCWKw1uPBy7SSI9DdqOIubDS0kYNyA9rybukoJhiCoOhNJiG5wqIgwO3FyeaWIhMgnwSTTxCK8e7M/5G53/Ku/PXUJawycIZKN9zl709R++MxFRy1IoA5XG55Va5YemnChi4ZCfuem7M+io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AE8kXH07; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775995900; x=1807531900;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XMUBzYW4ZmvubPpHYMYpnNs13e+TeVRvFuTp6UT2SaM=;
  b=AE8kXH07zqMAPNfr5IkZ51RWOCznjekvNddbMgiqQdlFqnUGgYhQ9exA
   sHTcpaIHWi5TBejggW0Uo+F9DM/LANMueksrhqfrhx8dCW+WwS4PfQQCf
   rnDZmbP4l6EFtKtqyIAdwc6fVZaqxgQcfXwlH3kHXojZGNACey2LnuyvX
   RMKdDEHzkzCiu+9O6j/bzU4Zx1QI9C5fIYpr0OOSt1j30i6u9QH7TZKlH
   Lex34nwEUVYKRjPuya1gCGd1CQ7hQFq0/tT7P3wJ8zsB0Q51HtOY8ETrJ
   dMwKJ+xR+sVdHD0P8MP42pYr/sJvCqGkEu8HXS1nCNqD0qTIfNaARDYvn
   g==;
X-CSE-ConnectionGUID: 23IeuFJ0TXiwRKjCjC2GHA==
X-CSE-MsgGUID: mWlrb8vCQcaRtNHVswmIyg==
X-IronPort-AV: E=McAfee;i="6800,10657,11757"; a="88028459"
X-IronPort-AV: E=Sophos;i="6.23,175,1770624000"; 
   d="scan'208";a="88028459"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2026 05:11:40 -0700
X-CSE-ConnectionGUID: VCvbp8nTQ0yhXqLwnX9Vtg==
X-CSE-MsgGUID: HHRXuVMXRc+6WWkmEeVlOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,175,1770624000"; 
   d="scan'208";a="229411887"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2026 05:11:40 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Avraham Stern <avraham.stern@intel.com>
Subject: [PATCH wireless-next 03/15] wifi: mac80211: accept protected frames for NAN device
Date: Sun, 12 Apr 2026 15:11:12 +0300
Message-Id: <20260412150826.d96981ef8bb8.Ia25b2e82b250058fefa179c39327d9c8b3c3cd62@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260412121124.2246222-1-miriam.rachel.korenblit@intel.com>
References: <20260412121124.2246222-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-34657-lists,linux-wireless=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EF4563E3BBC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Avraham Stern <avraham.stern@intel.com>

Some frames sent to the NAN device may be protected, such as
protected action frames (in particular protected dual of
public action).

Accept robust management frames except disassoc on the NAN
device, and clean up the code a little bit.

Signed-off-by: Avraham Stern <avraham.stern@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/rx.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 82ea7404f3da..e1f376e0620c 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -4624,16 +4624,24 @@ static bool ieee80211_accept_frame(struct ieee80211_rx_data *rx)
 		    ieee80211_has_fromds(hdr->frame_control))
 			return false;
 
-		/* Accept only frames that are addressed to the NAN cluster
+		/*
+		 * Accept only frames that are addressed to the NAN cluster
 		 * (based on the Cluster ID). From these frames, accept only
-		 * action frames or authentication frames that are addressed to
-		 * the local NAN interface.
+		 *  - public action frames,
+		 *  - authentication frames to the local address, and
+		 *  - robust management frames except disassoc.
 		 */
-		return memcmp(sdata->u.nan.conf.cluster_id,
-			      hdr->addr3, ETH_ALEN) == 0 &&
-			(ieee80211_is_public_action(hdr, skb->len) ||
-			 (ieee80211_is_auth(hdr->frame_control) &&
-			  ether_addr_equal(sdata->vif.addr, hdr->addr1)));
+		if (!ether_addr_equal(sdata->u.nan.conf.cluster_id, hdr->addr3))
+			return false;
+		if (ieee80211_is_public_action(hdr, skb->len))
+			return true;
+		if (ieee80211_is_auth(hdr->frame_control) &&
+		    ether_addr_equal(sdata->vif.addr, hdr->addr1))
+			return true;
+		if (!ieee80211_is_disassoc(hdr->frame_control) &&
+		    ieee80211_is_robust_mgmt_frame(skb))
+			return true;
+		return false;
 	case NL80211_IFTYPE_NAN_DATA:
 		if (ieee80211_has_tods(hdr->frame_control) ||
 		    ieee80211_has_fromds(hdr->frame_control))
-- 
2.34.1


