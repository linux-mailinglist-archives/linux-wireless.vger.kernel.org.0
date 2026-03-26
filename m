Return-Path: <linux-wireless+bounces-33958-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eHqwOREMxWma5wQAu9opvQ
	(envelope-from <linux-wireless+bounces-33958-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 11:36:01 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 86E033337A6
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 11:36:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4CDBD31AE9D6
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 10:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 440F23C198E;
	Thu, 26 Mar 2026 10:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rrxn3KlM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D003C2788
	for <linux-wireless@vger.kernel.org>; Thu, 26 Mar 2026 10:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774520117; cv=none; b=RIN0Tn4tU/rqm/fJuJGeqzSRvgGkQIOKTtx/Fsp5bhhY2j2Bd9uGRsPCneELBZD83islGle2vA7914RvmqIzzdS9lZOvENnWDgw2aazU32wfSaemyoJSsXCkWlCR0J1V3Ub6z4ihozp3oQrgVaUrfeh4Xog+pkYsXFlnSxNXhtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774520117; c=relaxed/simple;
	bh=gthBWffH1vX9HhLkPe3ot/Wm0p7PjcEe+DgkvYc2z0g=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ITQhYzkYS+/Zwqti32F7a645xKGTRufDKGCcPQrmoOWAIPxTqN27Y/055cqAfmGOVnyltgtjiUbY047BUy3OUTodJgRS40AJyyoaEAtEuRSWgsXTtdI0LZFvCA344m+Z2PGtv+6MAWLzZAtJQec3CFF3yGHfIBV2iFPUe0VkDS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rrxn3KlM; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774520116; x=1806056116;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=gthBWffH1vX9HhLkPe3ot/Wm0p7PjcEe+DgkvYc2z0g=;
  b=Rrxn3KlMbTNb8sFrdRBP4Y++yHpFjKYIvpVfqD51bYJSzgRRavTPlT1e
   RlKk0QgQZDARwTspWdujYgR2VHcnOMiSG6Wfg0Opy3qQnvuEEOwUxKDtM
   349XefUYLLWul6rHbbg1GZlh1sQlcRjc6+cDtWJExWwSPbiKT39XhxZMI
   yhjaqPu3qS/FonggGJwsz1L/EDcFHh12Qt20C2VIaDR59q5boIus+G+15
   r4gTplZECMcMIyt4poZ4mFKqEXXrxB/IHDwG5H8rQrRf6M5SD7XLYzz/s
   6SJUEE2OvzrJLIBh4outNi3ImaQpLzJRx5JkH1JA/sjCeNx5032AP9UF6
   A==;
X-CSE-ConnectionGUID: TbphigzwRJGLPrEXhK1nHg==
X-CSE-MsgGUID: Z1bhTRm1QziG4+Le4ikgcg==
X-IronPort-AV: E=McAfee;i="6800,10657,11740"; a="87048570"
X-IronPort-AV: E=Sophos;i="6.23,141,1770624000"; 
   d="scan'208";a="87048570"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 03:15:14 -0700
X-CSE-ConnectionGUID: gqAtja8UQse92GG3SYFNhQ==
X-CSE-MsgGUID: /U0z7X49S7aC4UVUw4aoQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,141,1770624000"; 
   d="scan'208";a="221653223"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 03:15:14 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Subject: [PATCH v2 wireless-next 12/15] wifi: mac80211: Accept frames on NAN DATA interfaces
Date: Thu, 26 Mar 2026 12:14:42 +0200
Message-Id: <20260326121156.0e6f37d4a40c.Iaa84cc3d063392f0150fcdf2bf610bdb41062f70@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260326101445.1443198-1-miriam.rachel.korenblit@intel.com>
References: <20260326101445.1443198-1-miriam.rachel.korenblit@intel.com>
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
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33958-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_ONE(0.00)[1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,intel.com:email]
X-Rspamd-Queue-Id: 86E033337A6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Accept frames there were received on NAN DATA interfaces:

- Data frames, both multicast or unicast
- Non-Public action frames, both multicast or unicast
- Unicast secure management frames
- FromDS and ToDS are 0.

While at it, check FromDS/ToDS also for NAN management frames.

Accept only data frames from devices that are part of the NAN
cluster.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/rx.c | 37 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index dbdd67c181d8..a00b73420929 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -4469,6 +4469,9 @@ static bool ieee80211_accept_frame(struct ieee80211_rx_data *rx)
 	u8 *bssid = ieee80211_get_bssid(hdr, skb->len, sdata->vif.type);
 	bool multicast = is_multicast_ether_addr(hdr->addr1) ||
 			 ieee80211_is_s1g_beacon(hdr->frame_control);
+	static const u8 nan_network_id[ETH_ALEN] __aligned(2) = {
+		0x51, 0x6F, 0x9A, 0x01, 0x00, 0x00
+	};
 
 	switch (sdata->vif.type) {
 	case NL80211_IFTYPE_STATION:
@@ -4597,6 +4600,10 @@ static bool ieee80211_accept_frame(struct ieee80211_rx_data *rx)
 		       (ieee80211_is_auth(hdr->frame_control) &&
 			ether_addr_equal(sdata->vif.addr, hdr->addr1));
 	case NL80211_IFTYPE_NAN:
+		if (ieee80211_has_tods(hdr->frame_control) ||
+		    ieee80211_has_fromds(hdr->frame_control))
+			return false;
+
 		/* Accept only frames that are addressed to the NAN cluster
 		 * (based on the Cluster ID). From these frames, accept only
 		 * action frames or authentication frames that are addressed to
@@ -4608,7 +4615,35 @@ static bool ieee80211_accept_frame(struct ieee80211_rx_data *rx)
 			 (ieee80211_is_auth(hdr->frame_control) &&
 			  ether_addr_equal(sdata->vif.addr, hdr->addr1)));
 	case NL80211_IFTYPE_NAN_DATA:
-		return false;
+		if (ieee80211_has_tods(hdr->frame_control) ||
+		    ieee80211_has_fromds(hdr->frame_control))
+			return false;
+
+		if (ieee80211_is_data(hdr->frame_control)) {
+			struct ieee80211_sub_if_data *nmi;
+
+			nmi = rcu_dereference(sdata->u.nan_data.nmi);
+			if (!nmi)
+				return false;
+
+			if (!ether_addr_equal(nmi->wdev.u.nan.cluster_id,
+					      hdr->addr3))
+				return false;
+
+			return multicast ||
+			       ether_addr_equal(sdata->vif.addr, hdr->addr1);
+		}
+
+		/* Non-public action frames (unicast or multicast) */
+		if (ieee80211_is_action(hdr->frame_control) &&
+		    !ieee80211_is_public_action(hdr, skb->len) &&
+		    (ether_addr_equal(nan_network_id, hdr->addr1) ||
+		     ether_addr_equal(sdata->vif.addr, hdr->addr1)))
+			return true;
+
+		/* Unicast secure management frames */
+		return ether_addr_equal(sdata->vif.addr, hdr->addr1) &&
+		       ieee80211_is_unicast_robust_mgmt_frame(skb);
 	default:
 		break;
 	}
-- 
2.34.1


