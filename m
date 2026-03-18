Return-Path: <linux-wireless+bounces-33391-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cIlLGleeumngZgIAu9opvQ
	(envelope-from <linux-wireless+bounces-33391-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Mar 2026 13:45:11 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C73172BBBE0
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Mar 2026 13:45:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6753931C195B
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Mar 2026 12:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F0E83D6691;
	Wed, 18 Mar 2026 12:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iB2XBNcd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91EAD3D75A8
	for <linux-wireless@vger.kernel.org>; Wed, 18 Mar 2026 12:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773837589; cv=none; b=gAxlc52BVGqJLtEtqwIcY691SHWZQLWJ00edC8cSsbUlmFslV25JBfzIwHhEva2icmE/fmC6URMroTCjFlhbULPc/+LAMbgTyd53eQ7K5jKDxIXZnc4VkO8z5jeKwvUkVv8gXX1u+nffab02pbENuOTS2UKtGeXv3zo4T1SHivs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773837589; c=relaxed/simple;
	bh=LBU3CJZTrcZWM+Mi2uBArIWNGDMdScFQk3mF8tAUgVU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gVmDAojllt5dIhB3e1FcnC2JFRvpfjh/wUERvU9oS44CpvlY2mV+ScSvxLDr1vCmGB4GFOStubQ/cT1i4d3nI2k1eScH5/5Tfm8HyOHfBLPepHaCrtrOOh17UM5aYOTa/bSgPXWQ9fwSh2fZ6rUZqCVx+LkjOjU6Li5A/gmTG58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iB2XBNcd; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773837588; x=1805373588;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LBU3CJZTrcZWM+Mi2uBArIWNGDMdScFQk3mF8tAUgVU=;
  b=iB2XBNcd+HVyfa9q0vnB1kZZ7g3xLNxY4hicS/dFyuJ3s6UviuAIGlzt
   0n4xPQTv48R6lR0Ly+GkfjON+jMSzufrrpWVneZyDQB7kos4EhCZ8sE30
   jroSbUPE/1C2G3Ts+z/4c7KRwT+Mnnj8tMwIfvQyJp6m6l/0VSJxxbn4x
   K31L6e6akouPMAKbVYHS+vbD0j9bU9eLFJL8S/XJAh1EN2GMKBfoh+Y0T
   G2LCl9xVRA48nXam/1L+vT6KP72zrsqci4wjuCCyla+hkvb7T4OiRlfbm
   aqahMTZQsGkBTAKZ/OEZS+ktmSdgywyx8nQA39+FtoSqk57urdm7aGr8v
   w==;
X-CSE-ConnectionGUID: Mdj1Qn+tRaOJ/lp+1BGevw==
X-CSE-MsgGUID: YFhQZ1YeRoCGcUrJ2f6slQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11733"; a="85519277"
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="85519277"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 05:39:47 -0700
X-CSE-ConnectionGUID: SpK8MAe3RQCQCg/ClHJBSw==
X-CSE-MsgGUID: 6Br0TvJWTIixJsQkPhAP7A==
X-ExtLoop1: 1
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 05:39:46 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v5 wireless-next 08/12] wifi: nl80211: allow reporting spurious NAN Data frames
Date: Wed, 18 Mar 2026 14:39:22 +0200
Message-Id: <20260318123926.206536-9-miriam.rachel.korenblit@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260318123926.206536-1-miriam.rachel.korenblit@intel.com>
References: <20260318123926.206536-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-33391-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: C73172BBBE0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
Link: https://patch.msgid.link/20260219094725.3846371-6-miriam.rachel.korenblit@intel.com
---
 include/net/cfg80211.h       | 13 +++++++------
 include/uapi/linux/nl80211.h |  5 +++--
 net/wireless/mlme.c          |  4 ++--
 net/wireless/nl80211.c       | 12 +++++++-----
 4 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 48ca5d3aa201..0d19f34ea7ac 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -6938,8 +6938,8 @@ enum ieee80211_ap_reg_power {
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
@@ -7001,7 +7001,7 @@ struct wireless_dev {
 	bool ps;
 	int ps_timeout;
 
-	u32 ap_unexpected_nlportid;
+	u32 unexpected_nlportid;
 
 	u32 owner_nlportid;
 	bool nl_owner_dead;
@@ -9572,9 +9572,10 @@ void cfg80211_pmksa_candidate_notify(struct net_device *dev, int index,
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
index e7f31a34eee4..cf6f1f6b9e36 100644
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
index 5cd86253a62e..e817ee297df0 100644
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
index 012fef1d6275..e162b0a3c2a6 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -15777,13 +15777,14 @@ static int nl80211_register_unexpected_frame(struct sk_buff *skb,
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
 
@@ -21281,7 +21282,7 @@ static bool __nl80211_unexpected_frame(struct net_device *dev, u8 cmd,
 	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wdev->wiphy);
 	struct sk_buff *msg;
 	void *hdr;
-	u32 nlportid = READ_ONCE(wdev->ap_unexpected_nlportid);
+	u32 nlportid = READ_ONCE(wdev->unexpected_nlportid);
 
 	if (!nlportid)
 		return false;
@@ -21321,7 +21322,8 @@ bool cfg80211_rx_spurious_frame(struct net_device *dev, const u8 *addr,
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


