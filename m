Return-Path: <linux-wireless+bounces-33885-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gDDEOjxSxGljyAQAu9opvQ
	(envelope-from <linux-wireless+bounces-33885-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 22:23:08 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A7A32C616
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 22:23:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AE89B303D2F8
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 21:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B108A356A3C;
	Wed, 25 Mar 2026 21:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JgOdVf71"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786B5378830
	for <linux-wireless@vger.kernel.org>; Wed, 25 Mar 2026 21:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774473370; cv=none; b=KGzBW0esMVhndmGUABKeESUnnbwYXnrpWFzBCnrZ3xdRGyn77eSMEUv3HrHrEv625qac41xyrF4FA5d5c1qYVNES6AnYJEe3dB4OPJZGihsRlUhe+EjnL/p7B20AmOExjQM9KqXqPQvqJll4FD50wGyfRAYbFF6cuhC52xkmpz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774473370; c=relaxed/simple;
	bh=oLXw93Hkgb7eXW+tuXn6Wn9UcpOg/qVYSmMbrVANZP0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qEiYSO2irSxsSdKwOPkgb6I56EjWBUgLaybZGLR9KhzqQMKLxxhJTFy9yQZYobeDjN0njF3a+4g+yhJYa0vwJirTtm9Ttm7UqYuMAhA9EAQBTlTE0qCkdAE2lOMqp35b9r7J3VFFuWRviGNqHoxak9cq72AGCAYtH1gUVhxvZVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JgOdVf71; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774473370; x=1806009370;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oLXw93Hkgb7eXW+tuXn6Wn9UcpOg/qVYSmMbrVANZP0=;
  b=JgOdVf719v9zCPNwvVUtlQhyEslpkyAodmo1cdE8SO9qhPQ4loYegVFW
   uoo6yuqvB1dS1YuXiPP2kEEwEv+7w03ecVyAxuUnwVKaqXkYkT6UUuvLu
   Mdex8t59YDOWOUJViVUG5URskt06f5eIjBwpa37CFyCIqTFmkBGbiyPB6
   TD8cQw1Y8CnNkTgfvOwAiqqcm7v4zfN/lJUSFobSi9K0X3hsRST+ENvys
   a9C3IHLcunTQXrQxFvxJqbSQ/OKTf8Y3giu5qRLcR0Q1rktHQoIoS+Jzl
   R7bqN5A53MPAeqHE/6rBsnPX9pYrH/xzAxA9NzW2nNndX0DHKNmEo5mWs
   g==;
X-CSE-ConnectionGUID: x2T3+UpPTSSTShWTSwO/QA==
X-CSE-MsgGUID: YRd7p62vQOeTFI6OzwRfvA==
X-IronPort-AV: E=McAfee;i="6800,10657,11740"; a="75485386"
X-IronPort-AV: E=Sophos;i="6.23,140,1770624000"; 
   d="scan'208";a="75485386"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2026 14:16:10 -0700
X-CSE-ConnectionGUID: Xf85tA/tQUuNbdqvOyBIEQ==
X-CSE-MsgGUID: wTzAWagISSKBno0TC/ESQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,140,1770624000"; 
   d="scan'208";a="224747555"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2026 14:16:08 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next 14/15] wifi: mac80211: report and drop spurious NAN Data frames
Date: Wed, 25 Mar 2026 23:15:35 +0200
Message-Id: <20260325230443.aca015e39209.I19e3572508beeba143871682c80e9a56b6c1046a@changeid>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-33885-lists,linux-wireless=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 70A7A32C616
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

According to Wi-Fi Aware (TM) 4.0 specification 6.2.5, in case a frame
is recevied from an address that doesn't belong to any active NDP, the
frame should be dropped and a NAN Data Path Termination should be sent
to the transmitter.
Do it by dropping the frame and calling cfg80211_rx_spurious_frame in
that case.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
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


