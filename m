Return-Path: <linux-wireless+bounces-31912-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EOUCK3aSk2lu6gEAu9opvQ
	(envelope-from <linux-wireless+bounces-31912-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Feb 2026 22:56:06 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 81D0D147D6D
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Feb 2026 22:56:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 166BE3023339
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Feb 2026 21:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE23329D26E;
	Mon, 16 Feb 2026 21:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bTXIPdkl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5DE2C0278
	for <linux-wireless@vger.kernel.org>; Mon, 16 Feb 2026 21:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771278921; cv=none; b=QisKlaipXIUPcKLX1NsneXOKwDxs1gsRkN7Dl7p85WNrwERStxWXBh9c45KHFQQZzF3xP10LhRbRfiO0lS6gUzC1veoHVarx2LbqlAOkNmxCGy6nrR7Q8zGCiOZsLZ/9w3ivYUpvx6eOoUpOhBeIXWQWYQth8YcPIE4u+ccK3iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771278921; c=relaxed/simple;
	bh=LpgCnq3cYBLmRQSpuSvLDLpO/O1DO0KWg55JSgtD9RQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sH+bitMm9uQ3XQRbWu8NkqlOq49n34cr4cGJvNWXPXHDuJem+20w6gd9ARaTs237kE0cIFCGMu4fSGay32S/kgkhvvD9WOkYcSzrBd9MCBba0rnSo18pSS0vRFdeR9TzF6vZ1iJsVQfu5NEbGRdQkRqa7CfDOcQ8znU4lSkgmdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bTXIPdkl; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771278920; x=1802814920;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LpgCnq3cYBLmRQSpuSvLDLpO/O1DO0KWg55JSgtD9RQ=;
  b=bTXIPdklCvR8pnzXpugSbsIuCeXRotjb47bLvmssdmDDPevb9N1rh93s
   na/tzF8pcVNr5bZCWI6AWdjO5v1g75PdopWL/3k7UcebvGCy7cJQpqcu1
   5gr0rXhTdOhV+rEYG/Va51yElVYrnQv184iyACuSJHqUN27XxLxVEOX3q
   kcgsmty6oceb8LNSEgILI42Br8DUe3BI0++fOiey9mgttLgXCzRgn1ewr
   QgAZ5bauPIuL7B0V9XX63lt9gP7ZhGpoytCwnBel/sAEy7Ck2J8vMUpe/
   omy8wVGVBVxUyaaFcB+er3hVehV3ec3pxDjEt4xmEsRkbQ4c4dwACG7FL
   g==;
X-CSE-ConnectionGUID: xChic7e0Q2KVJmJcffXdnA==
X-CSE-MsgGUID: +0dSGfuxT8a/sOJTsODLJg==
X-IronPort-AV: E=McAfee;i="6800,10657,11703"; a="75980299"
X-IronPort-AV: E=Sophos;i="6.21,295,1763452800"; 
   d="scan'208";a="75980299"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2026 13:55:20 -0800
X-CSE-ConnectionGUID: 7hk48jfZSUGfSw6CuKYoOg==
X-CSE-MsgGUID: tzO8t+qNRByXYX/9Qa0xlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,295,1763452800"; 
   d="scan'208";a="213547368"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2026 13:55:19 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 13/15] wifi: nl80211: allow reporting spurious NAN Data frames
Date: Mon, 16 Feb 2026 23:54:50 +0200
Message-Id: <20260216215452.1538316-6-miriam.rachel.korenblit@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260216215452.1538316-1-miriam.rachel.korenblit@intel.com>
References: <20260216215452.1538316-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-31912-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url,intel.com:mid,intel.com:dkim,intel.com:email]
X-Rspamd-Queue-Id: 81D0D147D6D
X-Rspamd-Action: no action

Currently we have this ability for AP and GO. But it is now needed also for
NAN_DATA mode - as per Wi-Fi Aware (TM) 4.0 specification 6.2.5:
"If a NAN Device receives a unicast NAN Data frame destined for it, but
 with A1 address and A2 address that are not assigned to the NDP, it shall
 discard the frame, and should send a Data Path Termination NAF to the
 frame transmitter"

To allow this, change NL80211_CMD_UNEXPECTED_FRAME to support also
NAN_DATA, so drivers can report such cases and the user space can act
accordingly.

Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Link: https://patch.msgid.link/20260108102921.5cf9f1351655.I47c98ce37843730b8b9eb8bd8e9ef62ed6c17613@changeid
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 include/net/cfg80211.h       | 13 +++++++------
 include/uapi/linux/nl80211.h |  5 +++--
 net/wireless/mlme.c          |  4 ++--
 net/wireless/nl80211.c       | 12 +++++++-----
 4 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 57d0dca1702e..0dee775ddbbc 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -6936,8 +6936,8 @@ enum ieee80211_ap_reg_power {
  *	the P2P Device.
  * @ps: powersave mode is enabled
  * @ps_timeout: dynamic powersave timeout
- * @ap_unexpected_nlportid: (private) netlink port ID of application
- *	registered for unexpected class 3 frames (AP mode)
+ * @unexpected_nlportid: (private) netlink port ID of application
+ *	registered for unexpected frames (AP mode or NAN_DATA mode)
  * @conn: (private) cfg80211 software SME connection state machine data
  * @connect_keys: (private) keys to set after connection is established
  * @conn_bss_type: connecting/connected BSS type
@@ -6999,7 +6999,7 @@ struct wireless_dev {
 	bool ps;
 	int ps_timeout;
 
-	u32 ap_unexpected_nlportid;
+	u32 unexpected_nlportid;
 
 	u32 owner_nlportid;
 	bool nl_owner_dead;
@@ -9570,9 +9570,10 @@ void cfg80211_pmksa_candidate_notify(struct net_device *dev, int index,
  * @addr: the transmitter address
  * @gfp: context flags
  *
- * This function is used in AP mode (only!) to inform userspace that
- * a spurious class 3 frame was received, to be able to deauth the
- * sender.
+ * This function is used in AP mode to inform userspace that a spurious
+ * class 3 frame was received, to be able to deauth the sender.
+ * It is also used in NAN_DATA mode to report frames from unknown peers
+ * (A2 not assigned to any active NDP), per Wi-Fi Aware (TM) 4.0 specification 6.2.5.
  * Return: %true if the frame was passed to userspace (or this failed
  * for a reason other than not having a subscription.)
  */
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index cc6eb95ccabf..838edc27e666 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -906,8 +906,9 @@
  * @NL80211_CMD_UNEXPECTED_FRAME: Used by an application controlling an AP
  *	(or GO) interface (i.e. hostapd) to ask for unexpected frames to
  *	implement sending deauth to stations that send unexpected class 3
- *	frames. Also used as the event sent by the kernel when such a frame
- *	is received.
+ *	frames. For NAN_DATA interfaces, this is used to report frames from
+ *	unknown peers (A2 not assigned to any active NDP).
+ *	Also used as the event sent by the kernel when such a frame is received.
  *	For the event, the %NL80211_ATTR_MAC attribute carries the TA and
  *	other attributes like the interface index are present.
  *	If used as the command it must have an interface index and you can
diff --git a/net/wireless/mlme.c b/net/wireless/mlme.c
index 3fc175f9f868..903a3dc59007 100644
--- a/net/wireless/mlme.c
+++ b/net/wireless/mlme.c
@@ -782,8 +782,8 @@ void cfg80211_mlme_unregister_socket(struct wireless_dev *wdev, u32 nlportid)
 		rdev_crit_proto_stop(rdev, wdev);
 	}
 
-	if (nlportid == wdev->ap_unexpected_nlportid)
-		wdev->ap_unexpected_nlportid = 0;
+	if (nlportid == wdev->unexpected_nlportid)
+		wdev->unexpected_nlportid = 0;
 }
 
 void cfg80211_mlme_purge_registrations(struct wireless_dev *wdev)
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index a7f97efe6a0d..7a22980aa7f0 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -15750,13 +15750,14 @@ static int nl80211_register_unexpected_frame(struct sk_buff *skb,
 	struct wireless_dev *wdev = dev->ieee80211_ptr;
 
 	if (wdev->iftype != NL80211_IFTYPE_AP &&
-	    wdev->iftype != NL80211_IFTYPE_P2P_GO)
+	    wdev->iftype != NL80211_IFTYPE_P2P_GO &&
+	    wdev->iftype != NL80211_IFTYPE_NAN_DATA)
 		return -EINVAL;
 
-	if (wdev->ap_unexpected_nlportid)
+	if (wdev->unexpected_nlportid)
 		return -EBUSY;
 
-	wdev->ap_unexpected_nlportid = info->snd_portid;
+	wdev->unexpected_nlportid = info->snd_portid;
 	return 0;
 }
 
@@ -21215,7 +21216,7 @@ static bool __nl80211_unexpected_frame(struct net_device *dev, u8 cmd,
 	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wdev->wiphy);
 	struct sk_buff *msg;
 	void *hdr;
-	u32 nlportid = READ_ONCE(wdev->ap_unexpected_nlportid);
+	u32 nlportid = READ_ONCE(wdev->unexpected_nlportid);
 
 	if (!nlportid)
 		return false;
@@ -21255,7 +21256,8 @@ bool cfg80211_rx_spurious_frame(struct net_device *dev, const u8 *addr,
 	trace_cfg80211_rx_spurious_frame(dev, addr, link_id);
 
 	if (WARN_ON(wdev->iftype != NL80211_IFTYPE_AP &&
-		    wdev->iftype != NL80211_IFTYPE_P2P_GO)) {
+		    wdev->iftype != NL80211_IFTYPE_P2P_GO &&
+		    wdev->iftype != NL80211_IFTYPE_NAN_DATA)) {
 		trace_cfg80211_return_bool(false);
 		return false;
 	}
-- 
2.34.1


