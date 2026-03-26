Return-Path: <linux-wireless+bounces-33961-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mNRWHioMxWn05wQAu9opvQ
	(envelope-from <linux-wireless+bounces-33961-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 11:36:26 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CE7E9333803
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 11:36:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F1BBA31B5F1F
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 10:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E905215F7D;
	Thu, 26 Mar 2026 10:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oBqYrvN3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455613C2769
	for <linux-wireless@vger.kernel.org>; Thu, 26 Mar 2026 10:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774520119; cv=none; b=KXj/QNaGfgKz2bew/npI4cRVT9C5hNK7GOEIZn/ohJKTo29+0UW0t3DFWij++NQWUXjzYt2BTJqGIlWDO6eVqkkS+yRoFkbxrYswoS9Smkuv8jxAV46HKvuWZOSzL3U3o/e5lJWKRrTQCxnz0f7LBhKJutwgJUeGD0/caeKGRoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774520119; c=relaxed/simple;
	bh=C41Tsn9zTIhfbqIQmYOje5tB57ioH7gLdou5+Z71vjM=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D2OPNlvXcrem8xDSZ+U4N4Ydnnf43egSZc2kDbOfKSrrgTjnoCkFAQWuXXueCCiK4UpmuYniApJOC/JizdtlIRSMzhuU+qQmO1ZzuAy4+kPD5jv0m2pTB8mcyLfSQEzTes0vj+vK5vr451AZ5EaDWiol4fFJYxVggBCeiHJBrdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oBqYrvN3; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774520117; x=1806056117;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=C41Tsn9zTIhfbqIQmYOje5tB57ioH7gLdou5+Z71vjM=;
  b=oBqYrvN3sZ7n4yt4gz6pCH1RfueuHJ3M2ElBN5sncHd3BY5g8Ga9lKML
   94aizx6duBatCaf97swmi9ZSq+HoPxealR+BlPSrglMKS6u0NBs8wbHHq
   L0vrwJyjYGB6MVY4R1yDA1bCPVrEQ3JLo78VhOqXfs5G9cI+w9V98AeV0
   tNofMMJYxBuXgxOdrTadXdvSTgOy45oj/te8ZLaAfYekNmkX+9O/LS5Bm
   OOz9v5wf6ix3Txdl9Z8EpildgT7VjeSFao7oYtMAxsuG141sju9WHPExX
   KRXw1cM3LVwnWwvkpFJbzfaIukA55oSF17d0JuScX1XrzGlwvAvVUXs2O
   Q==;
X-CSE-ConnectionGUID: sdY85ut9T7i1DItuIn0jsw==
X-CSE-MsgGUID: xVBuOX6ASeSHtMWkvy58pg==
X-IronPort-AV: E=McAfee;i="6800,10657,11740"; a="87048575"
X-IronPort-AV: E=Sophos;i="6.23,141,1770624000"; 
   d="scan'208";a="87048575"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 03:15:16 -0700
X-CSE-ConnectionGUID: XJf9VUi+QVeYGYdJpPlWJQ==
X-CSE-MsgGUID: mwxp3f6+R7+XLEKTcPWG/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,141,1770624000"; 
   d="scan'208";a="221653240"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 03:15:15 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Subject: [PATCH v2 wireless-next 14/15] wifi: mac80211: report and drop spurious NAN Data frames
Date: Thu, 26 Mar 2026 12:14:44 +0200
Message-Id: <20260326121156.721b3a61c580.I19e3572508beeba143871682c80e9a56b6c1046a@changeid>
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
	TAGGED_FROM(0.00)[bounces-33961-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CE7E9333803
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

According to Wi-Fi Aware (TM) 4.0 specification 6.2.5, in case a frame
is recevied from an address that doesn't belong to any active NDP, the
frame should be dropped and a NAN Data Path Termination should be sent
to the transmitter.
Do it by dropping the frame and calling cfg80211_rx_spurious_frame in
that case.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/rx.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 979ac26d1173..3e5d1c47a5b0 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -1589,6 +1589,25 @@ ieee80211_rx_h_check(struct ieee80211_rx_data *rx)
 	if (ieee80211_vif_is_mesh(&rx->sdata->vif))
 		return ieee80211_rx_mesh_check(rx);
 
+	/*
+	 * Wi-Fi Aware (TM) 4.0 specification 6.2.5:
+	 * For NAN_DATA, unicast data frames must have A2 (source)
+	 * assigned to an active NDP. If not the frame must be dropped
+	 * and NAN Data Path termination frame should be sent. Notify
+	 * user space so it can do so.
+	 */
+	if (rx->sdata->vif.type == NL80211_IFTYPE_NAN_DATA) {
+		if (ieee80211_is_data(hdr->frame_control) &&
+		    !is_multicast_ether_addr(hdr->addr1) &&
+		    (!rx->sta || !test_sta_flag(rx->sta, WLAN_STA_ASSOC))) {
+			if (cfg80211_rx_spurious_frame(rx->sdata->dev, hdr->addr2,
+						       rx->link_id, GFP_ATOMIC))
+				return RX_DROP_U_SPURIOUS_NOTIF;
+			return RX_DROP_U_SPURIOUS;
+		}
+		return RX_CONTINUE;
+	}
+
 	if (unlikely((ieee80211_is_data(hdr->frame_control) ||
 		      ieee80211_is_pspoll(hdr->frame_control)) &&
 		     rx->sdata->vif.type != NL80211_IFTYPE_ADHOC &&
-- 
2.34.1


