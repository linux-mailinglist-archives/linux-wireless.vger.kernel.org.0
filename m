Return-Path: <linux-wireless+bounces-25975-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CDC2B10156
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Jul 2025 09:08:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F1451895410
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Jul 2025 07:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 373E122577C;
	Thu, 24 Jul 2025 07:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U0TYlkGy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C62F12E5B
	for <linux-wireless@vger.kernel.org>; Thu, 24 Jul 2025 07:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753340894; cv=none; b=WFhrPEKw35jqae4qz+RMr5YzeHkKwb4JYu0RA+cPg6hGZrAf97wVZ+jOpmNVGOZKPSUf7uyFdAJxsgwi3NR3FPpfylfkKWIL+u11getetq94eIDspADbai7zVp1bCdW0bfyomy9ZnqUSCa2OpG6ttZBDgrktZWLXQsW129FFUkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753340894; c=relaxed/simple;
	bh=XbJqdEWYRylha4Pa842lMTrhWRPwhP6GSz3MTG3vaS8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OoGl95PW/5FnIDu9KdKwewjwFc2I7iC/Y9tNM0+mv1UpCKAZ4FZ+OMCXFsiLIdojzpjFgTJ5DFbto9Wh2GVnbhu8w9s2FEaVrtpBCoppNP58ITECZD0I3giIca/LxxP9UQusuWzdwB+p2EmyPtFvneHveeAQbWvrM3klUXTvdWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U0TYlkGy; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753340892; x=1784876892;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XbJqdEWYRylha4Pa842lMTrhWRPwhP6GSz3MTG3vaS8=;
  b=U0TYlkGy0NleAyzExSlRghSHoD5btQzag81+5gIEUNyheRLlcJiuwJjP
   qQthg/aClFsZN85jfa09AWIbcIOOp5dHdiIb79c9k/TAFLcovys2P5R0h
   cXdWYlFAzqVRTzeBLlOUIGBThwu+2z/4VwKWbnlBEhLDPpcsABDVUozP0
   J866mTObAObhZoWXOOwYSofiGZFx2dppOLp6rWaJWrDQm5P+4i0E2ZXic
   A0aE55gPiu7G4rJQBVr3kUy3WhGndQCjmEuNLp1nKNZle3lFZSDVyXql8
   9NT9zVxzLYwlljYRv0r0LO/cU7tvLb2yzXr8NRyDbsPmxGGNRDn09Vq4a
   A==;
X-CSE-ConnectionGUID: YLbJ7scLT2+BfmtihBTbdA==
X-CSE-MsgGUID: axeQPGHLRvC4QG82LnKp9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="55732684"
X-IronPort-AV: E=Sophos;i="6.16,336,1744095600"; 
   d="scan'208";a="55732684"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2025 00:08:12 -0700
X-CSE-ConnectionGUID: cs2eUHlaR1+QlEPC4AzAFg==
X-CSE-MsgGUID: M/8jf9Q9SCuEOp5sKb+HKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,336,1744095600"; 
   d="scan'208";a="165422664"
Received: from aotchere-mobl1.ger.corp.intel.com (HELO aotchere-mobl1.intel.com) ([10.245.249.251])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2025 00:08:10 -0700
From: Andrei Otcheretianski <andrei.otcheretianski@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	quic_vganneva@quicinc.com,
	maheshkkv@google.com,
	Andrei Otcheretianski <andrei.otcheretianski@intel.com>
Subject: [RFC v2 3/4] wifi: nl80211: Add NAN Discovery Window (DW) notification
Date: Thu, 24 Jul 2025 13:04:56 +0300
Message-ID: <20250724100457.181825-4-andrei.otcheretianski@intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250724100457.181825-1-andrei.otcheretianski@intel.com>
References: <20250724100457.181825-1-andrei.otcheretianski@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This notification will be used by the device to inform user space
about upcoming DW. When received, user space will be able to prepare
multicast Service Discovery Frames (SDFs) to be transmitted during the
next DW using %NL80211_CMD_FRAME command on the NAN management interface.
The device/driver will take care to transmit the frames in the correct
timing and flush the queues upon the termination of the DW.
This allows to implement a synchronized Discovery Engine (DE) in user
space, if the device doesn't support DE offload.
Note that this notification can be sent before the actual DW starts as
long as the driver/device handles the actual timing of the SDF
transmission.

Signed-off-by: Andrei Otcheretianski <andrei.otcheretianski@intel.com>
---
 include/net/cfg80211.h       | 10 +++++++++
 include/uapi/linux/nl80211.h | 12 +++++++++++
 net/wireless/nl80211.c       | 40 ++++++++++++++++++++++++++++++++++++
 net/wireless/trace.h         | 16 +++++++++++++++
 4 files changed, 78 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 4ad5bfbe3350..95edd5d3f205 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -10026,6 +10026,16 @@ void cfg80211_schedule_channels_check(struct wireless_dev *wdev);
  */
 void cfg80211_epcs_changed(struct net_device *netdev, bool enabled);
 
+/**
+ * cfg80211_next_nan_dw_notif - Notify about the next NAN Discovery Window (DW)
+ * @wdev: Pointer to the wireless device structure
+ * @chan: DW channel (6, 44 or 149)
+ * @gfp: Memory allocation flags
+ */
+void cfg80211_next_nan_dw_notif(struct wireless_dev *wdev,
+				struct ieee80211_channel *chan,
+				gfp_t gfp);
+
 #ifdef CONFIG_CFG80211_DEBUGFS
 /**
  * wiphy_locked_debugfs_read - do a locked read in debugfs
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 7f291986ed6a..0bb7553ce293 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -1347,6 +1347,16 @@
  *	control EPCS configuration. Used to notify userland on the current state
  *	of EPCS.
  *
+ * @NL80211_CMD_NAN_NEXT_DW_NOTIFICATION: This command is used to notify
+ *	user space about the next NAN Discovery Window (DW). User space may use
+ *	it to prepare frames to be sent in the next DW.
+ *	%NL80211_ATTR_WIPHY_FREQ is used to indicate the frequency of the next
+ *	DW. SDF transmission should be requested with %NL80211_CMD_FRAME and
+ *	the device/driver shall take care of the actual transmission timing.
+ *	Untransmitted multicast frames shall not be carried over to the next DW
+ *	and should be dropped. This notification is only sent to the netlink
+ *	socket owner (see %NL80211_ATTR_SOCKET_OWNER flag).
+ *
  * @NL80211_CMD_MAX: highest used command number
  * @__NL80211_CMD_AFTER_LAST: internal use
  */
@@ -1607,6 +1617,8 @@ enum nl80211_commands {
 	NL80211_CMD_ASSOC_MLO_RECONF,
 	NL80211_CMD_EPCS_CFG,
 
+	NL80211_CMD_NAN_NEXT_DW_NOTIFICATION,
+
 	/* add new commands above here */
 
 	/* used to define NL80211_CMD_MAX below */
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 7313f6ba4560..1af188f62788 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -21439,6 +21439,46 @@ void cfg80211_epcs_changed(struct net_device *netdev, bool enabled)
 }
 EXPORT_SYMBOL(cfg80211_epcs_changed);
 
+void cfg80211_next_nan_dw_notif(struct wireless_dev *wdev,
+				struct ieee80211_channel *chan,
+				gfp_t gfp)
+{
+	struct wiphy *wiphy = wdev->wiphy;
+	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wiphy);
+	struct sk_buff *msg;
+	void *hdr;
+
+	trace_cfg80211_next_nan_dw_notif(wdev, chan);
+
+	if (!wdev->owner_nlportid)
+		return;
+
+	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, gfp);
+	if (!msg)
+		return;
+
+	hdr = nl80211hdr_put(msg, 0, 0, 0,
+			     NL80211_CMD_NAN_NEXT_DW_NOTIFICATION);
+	if (!hdr)
+		goto nla_put_failure;
+
+	if (nla_put_u32(msg, NL80211_ATTR_WIPHY, rdev->wiphy_idx) ||
+	    nla_put_u64_64bit(msg, NL80211_ATTR_WDEV, wdev_id(wdev),
+			      NL80211_ATTR_PAD) ||
+	    nla_put_u32(msg, NL80211_ATTR_WIPHY_FREQ, chan->center_freq))
+		goto nla_put_failure;
+
+	genlmsg_end(msg, hdr);
+
+	genlmsg_unicast(wiphy_net(&rdev->wiphy), msg, wdev->owner_nlportid);
+
+	return;
+
+ nla_put_failure:
+	nlmsg_free(msg);
+}
+EXPORT_SYMBOL(cfg80211_next_nan_dw_notif);
+
 /* initialisation/exit functions */
 
 int __init nl80211_init(void)
diff --git a/net/wireless/trace.h b/net/wireless/trace.h
index 34c584a215e5..2ed1b090d519 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -4222,6 +4222,22 @@ TRACE_EVENT(cfg80211_epcs_changed,
 		  WDEV_PR_ARG, __entry->enabled)
 );
 
+TRACE_EVENT(cfg80211_next_nan_dw_notif,
+	TP_PROTO(struct wireless_dev *wdev,
+		 struct ieee80211_channel *chan),
+	TP_ARGS(wdev, chan),
+	TP_STRUCT__entry(
+		WDEV_ENTRY
+		CHAN_ENTRY
+	),
+	TP_fast_assign(
+		WDEV_ASSIGN;
+		CHAN_ASSIGN(chan);
+	),
+	TP_printk(WDEV_PR_FMT " " CHAN_PR_FMT,
+		  WDEV_PR_ARG, CHAN_PR_ARG)
+);
+
 #endif /* !__RDEV_OPS_TRACE || TRACE_HEADER_MULTI_READ */
 
 #undef TRACE_INCLUDE_PATH
-- 
2.49.0


