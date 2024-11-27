Return-Path: <linux-wireless+bounces-15767-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 517559DAD97
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Nov 2024 20:14:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 061F8282695
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Nov 2024 19:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE05E1FE45C;
	Wed, 27 Nov 2024 19:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gGNN2PyG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35DBE2581
	for <linux-wireless@vger.kernel.org>; Wed, 27 Nov 2024 19:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732734860; cv=none; b=PmRzJHz7qxFxMh6/Im0/MU3fSqyUcJIzTqfgTd33wVbOI3M0ibpMQkAVUAcs+sAmdHF6ORxHUgRI+G59+RRDTm9rKO3ns27XR91xzC42p/a+CtUJ0yWJbTuB1nHhZnBI/oGVhQXDLJPwam8Y8Qg0Lb8boZtbpLNsRDwAkr2ZOCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732734860; c=relaxed/simple;
	bh=46O4DpBAMZPxyzGT9UQ3v8Lu+sb6GAV0DgpfjgiFYlE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OJHp7HQWpcqA9lqyW5Su9yZBu4tVPw0OkA8gObXE9E2mHOercxuPaTNxgZjWcbk4YdrQp/UrxttemG+SWsz7UMZ50paI+1qCFdCO/WlGRNRUdL1Q50p52OfuTeT/CwUheLqWSsHh3c57cQKloLPEQVdiH63klrviZzx+kv+9Hoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gGNN2PyG; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732734859; x=1764270859;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=46O4DpBAMZPxyzGT9UQ3v8Lu+sb6GAV0DgpfjgiFYlE=;
  b=gGNN2PyGo6hsYVnUMji6GRKHwORou9PyFqt7I5HVsGerCoOwywcKqV/9
   aWvq+s+xg0NAyBYh7LTyQ5mgIuosIpOgoZesHEHl24q3cnzf9IfXvQQaD
   AVxaSB98vfzQbSt5Hxm8tQum3o7jA51RTUhHmlcCKOb1i0IjHcYZ+L7CR
   2KXl5yoqAuEPXPVPS043XIo0N01dXZucS+sDG+/CYnxbRybc1zsQM2GLV
   h5Qd/V4uda/6knDyiRlq+AqEMXDnl/0m1MO/0Q9m25VYWip6twe33Wq48
   J7Owr6OAZz4l3fjTQk0vWgksHlgtfnya863UFflGescj0OhEKmNanCUNN
   A==;
X-CSE-ConnectionGUID: xZxrRJClTFyElQHlUMB1Aw==
X-CSE-MsgGUID: yPFFysYpTWujHXuCwhTMug==
X-IronPort-AV: E=McAfee;i="6700,10204,11269"; a="58362948"
X-IronPort-AV: E=Sophos;i="6.12,190,1728975600"; 
   d="scan'208";a="58362948"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2024 11:14:18 -0800
X-CSE-ConnectionGUID: KuXIt8ANRIuMQ9aCkKTvuA==
X-CSE-MsgGUID: 0zftBBHLTAGXQn3nVq1yQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,190,1728975600"; 
   d="scan'208";a="92119116"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2024 11:14:17 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Andrei Otcheretianski <andrei.otcheretianski@intel.com>,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [RESEND] [PATCH v3] wifi: mac80211: Accept authentication frames on P2P device
Date: Wed, 27 Nov 2024 21:14:04 +0200
Message-Id: <20241127211312.60ccc73a916b.Ib3074ffbe7b296e0f162b2543e84346b190dfbeb@changeid>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Andrei Otcheretianski <andrei.otcheretianski@intel.com>

This is needed for PASN based P2P pairing.

type=feature
ticket=none

Signed-off-by: Andrei Otcheretianski <andrei.otcheretianski@intel.com>
Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
---
v2: fixed commit message title
v3: removed internal tags

 net/mac80211/main.c | 9 +++++++--
 net/mac80211/rx.c   | 4 +++-
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index ee1211a213d7..f13c14fa82e8 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -5,7 +5,7 @@
  * Copyright 2006-2007	Jiri Benc <jbenc@suse.cz>
  * Copyright 2013-2014  Intel Mobile Communications GmbH
  * Copyright (C) 2017     Intel Deutschland GmbH
- * Copyright (C) 2018-2023 Intel Corporation
+ * Copyright (C) 2018-2024 Intel Corporation
  */
 
 #include <net/mac80211.h>
@@ -726,8 +726,13 @@ ieee80211_default_mgmt_stypes[NUM_NL80211_IFTYPES] = {
 	},
 	[NL80211_IFTYPE_P2P_DEVICE] = {
 		.tx = 0xffff,
+		/*
+		 * To support P2P PASN pairing let user space register to rx
+		 * also AUTH frames on P2P device interface.
+		 */
 		.rx = BIT(IEEE80211_STYPE_ACTION >> 4) |
-			BIT(IEEE80211_STYPE_PROBE_REQ >> 4),
+			BIT(IEEE80211_STYPE_PROBE_REQ >> 4) |
+			BIT(IEEE80211_STYPE_AUTH >> 4),
 	},
 };
 
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 2bec18fc1b03..58c1b9a4e8b5 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -4562,7 +4562,9 @@ static bool ieee80211_accept_frame(struct ieee80211_rx_data *rx)
 		return ieee80211_is_public_action(hdr, skb->len) ||
 		       ieee80211_is_probe_req(hdr->frame_control) ||
 		       ieee80211_is_probe_resp(hdr->frame_control) ||
-		       ieee80211_is_beacon(hdr->frame_control);
+		       ieee80211_is_beacon(hdr->frame_control) ||
+		       (ieee80211_is_auth(hdr->frame_control) &&
+			ether_addr_equal(sdata->vif.addr, hdr->addr1));
 	case NL80211_IFTYPE_NAN:
 		/* Currently no frames on NAN interface are allowed */
 		return false;
-- 
2.34.1


