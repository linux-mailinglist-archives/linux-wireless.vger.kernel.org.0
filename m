Return-Path: <linux-wireless+bounces-32023-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wMyhK1TclmlJpgIAu9opvQ
	(envelope-from <linux-wireless+bounces-32023-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Feb 2026 10:48:04 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EC8C15D827
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Feb 2026 10:48:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E7FBF30166C3
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Feb 2026 09:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B229C309DAB;
	Thu, 19 Feb 2026 09:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eDJjX2zx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42815325488
	for <linux-wireless@vger.kernel.org>; Thu, 19 Feb 2026 09:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771494474; cv=none; b=dXdkJuPS/cYPWKkn0rckZWt455R1wvAw2PYKzrO0c5zDq9U+U/sF6d34ypk2FVGquDrwA8uJQNf18pO4Kek53h/D+9MBIIdNVICD3uZnFR+NjjjdknxcIbFOR4c9zAOqUVaVDF+g3MDiHL+ErFJKswPi/Q6dIZttcwICTG1buok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771494474; c=relaxed/simple;
	bh=LpgCnq3cYBLmRQSpuSvLDLpO/O1DO0KWg55JSgtD9RQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Qi5DAyspWFxPBGMxaKkEST2UOXS4uPoTsnM1BwLEH1PCNin3GKv7bgQ7bvw+cf9J56hsu8Ey4zAolV95PpXy7uK0KQyZopsEtbxTfIN00CkStju3mZqwZ5xO3L/fy+v8C5E09+rwsI5WB5cRVVDQnQsy0PujgobK5sLbNxbqdlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eDJjX2zx; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771494474; x=1803030474;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LpgCnq3cYBLmRQSpuSvLDLpO/O1DO0KWg55JSgtD9RQ=;
  b=eDJjX2zx7naw9kSybgfdxo6DhZm7k1x2gD2wahOQgwgwDeXXGY2gfIXX
   zZ3j/3zRgooPraNuZUlsoyadTZlWttxwZaroHrLeoda9g4nq0v/DTRJBX
   Zas99JyxJG2A0hD1hhDyW8aErcebruiYwma1+YuVf+KIeB4WHJU/wr03Q
   S2+2xH1FthiwBbfzopTW5ZMbS8I7IwMXFyP8VmvI1dSX2Tws4Yc9AkRC9
   NnFKYG7VUrtFOwPxmJ/qPMThvfuTgTNuq8Fxx78fOY+yDSbaX7/xR2ily
   sAUXGbdCPbRwtX4giWD3vTYGt2f/lQhaoMRUuQhgBeA9dOT093CuVtkru
   Q==;
X-CSE-ConnectionGUID: twAwc/TLTnyDbmPQr7wzNw==
X-CSE-MsgGUID: N8kQD/IVSBib28Zu7Z2yvA==
X-IronPort-AV: E=McAfee;i="6800,10657,11705"; a="83680118"
X-IronPort-AV: E=Sophos;i="6.21,299,1763452800"; 
   d="scan'208";a="83680118"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2026 01:47:53 -0800
X-CSE-ConnectionGUID: 4BQHqz0MRw++F7nbZ+y3EQ==
X-CSE-MsgGUID: gaCBgLeuT7yg0MiiT2yvLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,299,1763452800"; 
   d="scan'208";a="218989051"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2026 01:47:52 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v4 wireless-next 13/15] wifi: nl80211: allow reporting spurious NAN Data frames
Date: Thu, 19 Feb 2026 11:47:23 +0200
Message-Id: <20260219094725.3846371-6-miriam.rachel.korenblit@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260219094725.3846371-1-miriam.rachel.korenblit@intel.com>
References: <20260219094725.3846371-1-miriam.rachel.korenblit@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-32023-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:mid,intel.com:dkim,intel.com:email,msgid.link:url]
X-Rspamd-Queue-Id: 5EC8C15D827
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


