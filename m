Return-Path: <linux-wireless+bounces-15869-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 100CB9E2E1D
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Dec 2024 22:32:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA650B2FDFD
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Dec 2024 20:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9826A2500D3;
	Tue,  3 Dec 2024 20:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W0/lCPi5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3210620124F
	for <linux-wireless@vger.kernel.org>; Tue,  3 Dec 2024 20:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733257750; cv=none; b=afudhPvcDWZAkfbVCW8yFozgSMdHlW0Sc6P+sl0Z0RQNxUSoeKKU32gX6cHmevoXwnL9Lr56ILpB1umIwdYLubUNP515gX0hHITZP8m/oCiJNMUHG9DqiAFlehUJLiY9iwPHddEPBgB4oUV4Qgi4ffJcQ2qGXrhI8MpCerhj8/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733257750; c=relaxed/simple;
	bh=vcJfFo8N8v/lHDAzlWAJnuCEN4dNRWNdCEUsZhBGT2E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Jhnkj2BCTxmlvO1PFA4/vpNQ5e5j7Q/AdBE0uWrZ3qp96kh6mOvyu9a9ooUL6DtIN5nNpBm5vmgguVKGsDqY0+GCgHwj55g0Q/HRY6l15lhWfJstYMPefS1r6u053YkJNsSXn4l3TrxI3TxMqxWvw9EIcs14d7zRl4dnG8jA6xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W0/lCPi5; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733257748; x=1764793748;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vcJfFo8N8v/lHDAzlWAJnuCEN4dNRWNdCEUsZhBGT2E=;
  b=W0/lCPi5SivxJXFKIK4hoEPr9NQKLnvvi17ROZXsB0Z43qX0mjQgrsXo
   1cdRdF79C/EwKAI3qdz8Sq39+mi4vPs4cpdSZNGY5FL0sr9k2G88fLyPi
   MaiiUQ25P4ebktul/UynelxYVC9zvdCBe4SdGhfn5VqSo3zvdbQ1nqGIA
   t7VmUygIFkebKvAUcnR54H9v4L8poeMuDZiOTmXgLmMiLY93NJlqHjHAg
   m7BqdIzpbQ+8lOWQ3xK+dfDqHI3gsc07Jg2UkYjGM5bVvmG5bdpcYC1Al
   ss0UdksNob2kS0xZr8wES+YdYOo+Ypq6n702XqBusVBhV8vjNPdG8sabY
   Q==;
X-CSE-ConnectionGUID: C0eYbnNyScKUywFmKMfQew==
X-CSE-MsgGUID: blO7dkwyTtKxcLK/tA97cA==
X-IronPort-AV: E=McAfee;i="6700,10204,11275"; a="32840482"
X-IronPort-AV: E=Sophos;i="6.12,206,1728975600"; 
   d="scan'208";a="32840482"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 12:29:08 -0800
X-CSE-ConnectionGUID: GotpdNjtQjqQYK23cHEb1w==
X-CSE-MsgGUID: evvKbN0NR8WLmOXUYrJQig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,206,1728975600"; 
   d="scan'208";a="93406469"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 12:29:06 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Andrei Otcheretianski <andrei.otcheretianski@intel.com>,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [RESEND][PATCH v4] wifi: mac80211: Accept authentication frames on P2P device
Date: Tue,  3 Dec 2024 22:28:50 +0200
Message-Id: <20241203222744.6ee3ef9f1374.Ib3074ffbe7b296e0f162b2543e84346b190dfbeb@changeid>
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

Signed-off-by: Andrei Otcheretianski <andrei.otcheretianski@intel.com>
Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
---
v2: fixed commit message title
v3: removed internal tags
v4: removed internal tag for real

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


