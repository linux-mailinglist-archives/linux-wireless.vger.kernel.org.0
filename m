Return-Path: <linux-wireless+bounces-33883-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YKFuCPpQxGljyAQAu9opvQ
	(envelope-from <linux-wireless+bounces-33883-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 22:17:46 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AD80032C55E
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 22:17:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 692E730A894A
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 21:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A3536F43D;
	Wed, 25 Mar 2026 21:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iLzQPJEk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A95374730
	for <linux-wireless@vger.kernel.org>; Wed, 25 Mar 2026 21:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774473367; cv=none; b=OMs4HWAQ6loVXWqgdWebd8xnylBdcObH8g7Un4g7Egj2dHx3CLy1mIWilTc8r6T3fwmGRb0oo5n+QTM2laGH3rGhrbyf9Tz5RlC+Y5Tu1T1u/aAPiZ4XwEFmEYk7UNEr1Nv3IqDhdpC1LZR2RMgCaDwYpQy3DY+uEqSCdxBy/ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774473367; c=relaxed/simple;
	bh=3UMfgc+HnZiD6t1MYjdRWstxg6U1YDGzTx+VR2BxU9Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RE34r00Ywo79c2xtvBBZln9SP2w/o6ewj7loe7DCl/zLwAu4USsk1xp5wVx9Z8f03XTZXUs+JYolwlelM2UHCTmSj6xP/ebK1aFILdI+5Ded1whHaLjEwLnmUGuDCap5bW2bwTQBufyDmk8K/mejHJLwFv86H0JqdzaSuGguk28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iLzQPJEk; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774473367; x=1806009367;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3UMfgc+HnZiD6t1MYjdRWstxg6U1YDGzTx+VR2BxU9Y=;
  b=iLzQPJEkr/FnBDgqiimAaAoiyoZsECBt1WVm1/woqCEYN2XOOqTkrG3U
   QUdRdhMj4QNvqyzCjus2917ERoSfTHXPtp5DH+JBSngVqdXm4klPzcZ7D
   Zpn8G2TR+fWmTlqQFhrlDufX+LBT/3ijA0ujfrwanLHS70pSIoAIiSDy3
   YbSgPPTc1Bw0fDG1oPIYy8GtHt4/pN9kHfFwLTVGk9NYANYv3ebeGqAGV
   I1vAWHTvMo9Y+DwW6i3C3p9A5ztcKmgOxg0haXTW/cI1EdrxIc26IuCeV
   C8cN7DqsYakFaLk/QNHsMYKbTIzO54ZZ0IXvN8yvU+UmviTrMBGMVSZXu
   w==;
X-CSE-ConnectionGUID: aYh3vxxvQEWQl0fodTNeaw==
X-CSE-MsgGUID: Rq+DZr/dTtKdzfeTPkvxUQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11740"; a="75485383"
X-IronPort-AV: E=Sophos;i="6.23,140,1770624000"; 
   d="scan'208";a="75485383"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2026 14:16:07 -0700
X-CSE-ConnectionGUID: bKkccGkESTKdqc/oktIqTQ==
X-CSE-MsgGUID: pCM9LijGTmWdt1GrvITnrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,140,1770624000"; 
   d="scan'208";a="224747545"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2026 14:16:06 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next 12/15] wifi: mac80211: Accept frames on NAN DATA interfaces
Date: Wed, 25 Mar 2026 23:15:33 +0200
Message-Id: <20260325230443.7987da40ac7f.Iaa84cc3d063392f0150fcdf2bf610bdb41062f70@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260325211536.910411-1-miriam.rachel.korenblit@intel.com>
References: <20260325211536.910411-1-miriam.rachel.korenblit@intel.com>
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
	TAGGED_FROM(0.00)[bounces-33883-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AD80032C55E
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
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
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


