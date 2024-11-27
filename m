Return-Path: <linux-wireless+bounces-15766-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A16C89DAD96
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Nov 2024 20:10:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49CD028663F
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Nov 2024 19:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAA301FE45C;
	Wed, 27 Nov 2024 19:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IR0hjjCF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42DB12581
	for <linux-wireless@vger.kernel.org>; Wed, 27 Nov 2024 19:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732734606; cv=none; b=NOa3hMlqpoIKgZ6o45TLS3pzfvTj8pXQJNUHPFfgRZ3/BadYLFDLrg4H3lFw6G+CtDkA8eY5I7d+rNlwsmkC+Hsmv6BN77YIOb/v92vArhRM7EWyjsSiDV+4lfLnDknNWBQ5ocuZXLR3fkuFG1tpyPwkLDqPcMfUsuTVXhJBIhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732734606; c=relaxed/simple;
	bh=U953UA/fK9ldmY2Fs3cg8EMeTS8MZzrQGMnmKLysCZM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=m/P5HPAR+cD5RZvVwnpV+36b0Y2PQWw+X6Qnje76s7x+DuodPVCmZ/rabNHyPeRv62GQJUIS0C5raSLmIezMfBmWS1oioBv+oqml38/RN+irCVifPyxM/qiw+5oXhi6GgI6PxBWlvZp7/KyU3yneVUev9tg0WDwrxa+B9EP0dp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IR0hjjCF; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732734605; x=1764270605;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=U953UA/fK9ldmY2Fs3cg8EMeTS8MZzrQGMnmKLysCZM=;
  b=IR0hjjCF5jxWTm3mj3TYke2iOoh4ShiPkRXasDSUALVMiMr1UyvUPdfc
   JazvTMZfIkSki/TYdV31dsNLghJLwMP6J/nPVOwg5qBqqxEZtGZXiW4oP
   nHGu9nQWR+c7Zh1JuKXTFgl8eEAy3R0ycbJ0xtFaOTKMWcRDT81UxEH9P
   0J1pX377uQVzsjO6C28HUuqubNNtQ9NkQGT7MLt0hWzioGhTxgoCPyi03
   814K2tLjUMWxJyRWoh3ODEr3FE0pKFlfRKkbsMSn6/1NbO5o9AegK0qtr
   fmcWGHkluKa6FORSpR2GHzCnn4VYyHXdTi4yCm+t/kL1gaJ+xMTwpNILc
   g==;
X-CSE-ConnectionGUID: Rd0rU1RcTz+XfuKdbUN/FA==
X-CSE-MsgGUID: 2zC7x6uJRq2PcyUbiUqiGQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11269"; a="44332719"
X-IronPort-AV: E=Sophos;i="6.12,190,1728975600"; 
   d="scan'208";a="44332719"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2024 11:10:05 -0800
X-CSE-ConnectionGUID: UDt8VvmBQ767zrR2TfYDyw==
X-CSE-MsgGUID: bsZqsaagQ6y/4o5hKgxg9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,190,1728975600"; 
   d="scan'208";a="91955531"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2024 11:10:03 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Andrei Otcheretianski <andrei.otcheretianski@intel.com>,
	iil_jenkins iil_jenkins <EC.GER.UNIX.IIL.JENKINS@INTEL.COM>,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [RESEND] [PATCH v2] wifi: mac80211: Accept authentication frames on P2P device
Date: Wed, 27 Nov 2024 21:09:49 +0200
Message-Id: <20241127210848.5bebdce84c95.Ib3074ffbe7b296e0f162b2543e84346b190dfbeb@changeid>
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
Reviewed-on: https://gerritwcs.ir.intel.com/c/iwlwifi-stack-dev/+/94282
automatic-review: iil_jenkins iil_jenkins <EC.GER.UNIX.IIL.JENKINS@INTEL.COM>
tested: iil_jenkins iil_jenkins <EC.GER.UNIX.IIL.JENKINS@INTEL.COM>
Tested-by: iil_jenkins iil_jenkins <EC.GER.UNIX.IIL.JENKINS@INTEL.COM>
Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
---
v2: fix the commit message title

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


