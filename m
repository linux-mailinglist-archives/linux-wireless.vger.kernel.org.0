Return-Path: <linux-wireless+bounces-30535-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD00D03A29
	for <lists+linux-wireless@lfdr.de>; Thu, 08 Jan 2026 16:03:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D50743009748
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Jan 2026 14:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57B25366DD8;
	Thu,  8 Jan 2026 08:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hTCdo56W"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1FC23590D7
	for <linux-wireless@vger.kernel.org>; Thu,  8 Jan 2026 08:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767861407; cv=none; b=Vi4B3iyZbGb4p2aYnbr/4Mvf5Y7GYs5y9Fd4qAQp/RHidFs9e6q5SkyBgizYylsQAkNLIdqZkDepVHTpAXxLAH1Nx+O1qXr34OejDCCCjBhd8aWysjaHZQ1DFimsw6zFFV4daCHDocLpjps3vAmwpsnTWwc/UV1QVDnE7Vt+730=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767861407; c=relaxed/simple;
	bh=hK+9SYw1EshsUw65Pk+qi5V1bmBgmVNHb+taGbGDEO4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pHdg1M04W/W7cmyCuytYvLy+vggVs5gI/FBtodZZnm/UqfkGiXw87dEB3khOe/gYY0OKd1zrseYyh0XcczF+xsXODP80LyRq+GGqPUEVZ3dY6pMqIMJ0ZmjQicGB4KUwKuAifbXHQg5uJaxAJrkeJp7cz03I4TThK2/8pSYBoYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hTCdo56W; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767861400; x=1799397400;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hK+9SYw1EshsUw65Pk+qi5V1bmBgmVNHb+taGbGDEO4=;
  b=hTCdo56WkvQW+u1epDsxyMylhQs9in+zjIA1JOXa9Y4kccn2vQOgPiL4
   6sBiRlnCGDtul+fS+o/dNLM1xKGMl/v0cbAIbbNM1P4NP2KvF6ybUSF6w
   g5+PtX7cC5W6uEL9P8bzovYIA6f4nGVkZGrw0zG9by8TCY9oGQlslWy5R
   14BPY8VxzzT63pYPfHJqj35aPCUGGsWEilD+bF1kC3bdgjAXcARAbuYeC
   AuzyRIlSCraqKeoSWvm6H6Qu84BFGXz7TSubCeEWcEJzVaG+k6cIisma3
   P+MUXt5kmg4dAhFHIOlvtspMdRL022FBiCYRov4tILeNDH0+6smh3L8nP
   w==;
X-CSE-ConnectionGUID: g8c8KnuEREaY6lnPc+ZuqA==
X-CSE-MsgGUID: GCotc4rIR7CjUiPlbbszrg==
X-IronPort-AV: E=McAfee;i="6800,10657,11664"; a="73084817"
X-IronPort-AV: E=Sophos;i="6.21,210,1763452800"; 
   d="scan'208";a="73084817"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2026 00:36:11 -0800
X-CSE-ConnectionGUID: EQlVHZrGSkejpYjeHOqU6g==
X-CSE-MsgGUID: dbOn+tlARIiT16K+Mtnnzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,210,1763452800"; 
   d="scan'208";a="233847522"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2026 00:36:09 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next v2 14/14] wifi: nl80211: allow reporting spurious NAN Data frames
Date: Thu,  8 Jan 2026 10:35:40 +0200
Message-Id: <20260108102921.5cf9f1351655.I47c98ce37843730b8b9eb8bd8e9ef62ed6c17613@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260108083540.3129471-1-miriam.rachel.korenblit@intel.com>
References: <20260108083540.3129471-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

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
---
 include/net/cfg80211.h       | 13 +++++++------
 include/uapi/linux/nl80211.h |  5 +++--
 net/wireless/mlme.c          |  4 ++--
 net/wireless/nl80211.c       | 12 +++++++-----
 4 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 9495c5e57ace..5d4c223e3c6e 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -6845,8 +6845,8 @@ enum ieee80211_ap_reg_power {
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
@@ -6908,7 +6908,7 @@ struct wireless_dev {
 	bool ps;
 	int ps_timeout;
 
-	u32 ap_unexpected_nlportid;
+	u32 unexpected_nlportid;
 
 	u32 owner_nlportid;
 	bool nl_owner_dead;
@@ -9478,9 +9478,10 @@ void cfg80211_pmksa_candidate_notify(struct net_device *dev, int index,
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
index 8c8ed55d357f..4ad24fa5feae 100644
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
index 8f73d26b02a7..27f5a786a4db 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -15592,13 +15592,14 @@ static int nl80211_register_unexpected_frame(struct sk_buff *skb,
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
 
@@ -20982,7 +20983,7 @@ static bool __nl80211_unexpected_frame(struct net_device *dev, u8 cmd,
 	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wdev->wiphy);
 	struct sk_buff *msg;
 	void *hdr;
-	u32 nlportid = READ_ONCE(wdev->ap_unexpected_nlportid);
+	u32 nlportid = READ_ONCE(wdev->unexpected_nlportid);
 
 	if (!nlportid)
 		return false;
@@ -21022,7 +21023,8 @@ bool cfg80211_rx_spurious_frame(struct net_device *dev, const u8 *addr,
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


