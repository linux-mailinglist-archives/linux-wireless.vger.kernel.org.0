Return-Path: <linux-wireless+bounces-30455-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B92A7CFE1D0
	for <lists+linux-wireless@lfdr.de>; Wed, 07 Jan 2026 14:58:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 055E530081A7
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Jan 2026 13:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78808325720;
	Wed,  7 Jan 2026 13:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E2S7uf37"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48AC332A3F1
	for <linux-wireless@vger.kernel.org>; Wed,  7 Jan 2026 13:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767792031; cv=none; b=PjCadb8NZv9tcPaEWzBLpBOWO3b382KnimgBxVVXWlmvEW5FwWF4pkfFiSI1yVltP0QC+sHwU7fsqokUY5NMYw153E/FIhyXvN+PxJ+ASn/MYdkZ+8rT4rwCg1Q8uDms0LEoAZJN823DWVvVIjIsRloLis1NkCPwsbMnTy4VrFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767792031; c=relaxed/simple;
	bh=hK+9SYw1EshsUw65Pk+qi5V1bmBgmVNHb+taGbGDEO4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OAs5Kb5lEav778yvYm4oh9t8ISZG5o6zHDOPFPrJsvqT6dSPBAQb6x2OAHf/R6nZgK4qGSKlKoRlmEfqGlmuLxiOcHUbKOjd6OaUp4byPhZT/Yd7LqNUrPr2diAMJCwaAR3ah1/4aLC9SFC6IC4kcTlRX80+UoZM6ImntDZgVCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E2S7uf37; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767792029; x=1799328029;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hK+9SYw1EshsUw65Pk+qi5V1bmBgmVNHb+taGbGDEO4=;
  b=E2S7uf37NIxB9rwcSISTaNj9Kxn284Q4UgrDqaVvevCr2yKy4St1ov7F
   3tOO1ISBbraLw0X36bw1SjRjeeSNZytB3Ra5jFzhs2KzfXwMIapWJb5uf
   1M2Dc2uEN8+mW2BBwV1MSEmCXWIQItmmFOcqoES6uUb9XGeTfvX7zth/P
   rkWPzpLlE83KEa0eVqKhts2I3RB+l/1wuESiCNMJZcuBXfCCFtHzKqQDS
   eFwoRAYdaN+eHAMG1L40xDjVgvFyel1KFNK1IB6a185lArDuphL5ow/2p
   qgnBdgJPYxr16uHGJvMf7ltGW6VSznBkt0t6toSnX0Oxxdt3L7UodGoAd
   Q==;
X-CSE-ConnectionGUID: EJo7Nq+NQv6tJ+zq7RXnNA==
X-CSE-MsgGUID: xr390wMHTYSnGLdsd1s6cg==
X-IronPort-AV: E=McAfee;i="6800,10657,11664"; a="86576871"
X-IronPort-AV: E=Sophos;i="6.21,208,1763452800"; 
   d="scan'208";a="86576871"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2026 05:20:29 -0800
X-CSE-ConnectionGUID: wSKy+b+ISJWT3jo28akgNQ==
X-CSE-MsgGUID: RtG3JWqwSfCt1+tqVIfsiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,208,1763452800"; 
   d="scan'208";a="203185798"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2026 05:20:28 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next 13/15] wifi: nl80211: allow reporting spurious NAN Data frames
Date: Wed,  7 Jan 2026 15:20:01 +0200
Message-Id: <20260107150057.d0247776d833.I47c98ce37843730b8b9eb8bd8e9ef62ed6c17613@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260107132003.2291979-1-miriam.rachel.korenblit@intel.com>
References: <20260107132003.2291979-1-miriam.rachel.korenblit@intel.com>
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


