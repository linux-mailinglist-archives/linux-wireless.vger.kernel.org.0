Return-Path: <linux-wireless+bounces-4949-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D2264880BCC
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 08:15:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72ADA1F2454B
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 07:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2470C20DCD;
	Wed, 20 Mar 2024 07:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QlqKCtjk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6695C1EB44
	for <linux-wireless@vger.kernel.org>; Wed, 20 Mar 2024 07:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710918872; cv=none; b=mM4jcVx8RKOKR8qvUIlq2/ZY6nauxZUbi1hT9JALI86j0HLzkSRwJ+OUg092kkJOShu+9YiBM7DTrF4UDOab/U8yey5NOvZkOiVDXVbcScIC0m/ZhaVxsInOI/4oFiUVsSN88rm3wmoU1uIkNsomepaKCfrMQXoxrIKTcaFkaW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710918872; c=relaxed/simple;
	bh=ZtKFd3Bi4Cle40OK/sRPs46B+k4y2b9A0Jtju5McVHI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mgxJSs6LRpk+6sDdaiBkQKQgUdCPSJmPYP5x8IpawE7vGPULsIY50K91ViDnhSh2lPxWj5MItv0YqN9UIY8q3EfbpAJfOySnIOJLuS2mc7Ht9jzCParsliiXCURnUJpcCPsCxwAQjXJkiDanYs26tzAa7qGGYd19ySBp1+olR70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QlqKCtjk; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710918870; x=1742454870;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZtKFd3Bi4Cle40OK/sRPs46B+k4y2b9A0Jtju5McVHI=;
  b=QlqKCtjkUvLwv/2xil1FDO80K8aBBD9cmzHOshCk3cO3afBXIpnS/Njz
   NiFZQ91NT/Quow+9+8e03BT18r/LYuNmkqJQUAbEP1tfQlXQmJPyHqxmd
   CFtm0F8Bb8/39l+aNcepAIw8f3d3TegHtIQHZdl5kP59puY6GSFEKudDA
   4g5ETRSvftRrgIa2I0NbbVjr01vxxrnaRA3bsldfF7P8ysS2w7835e9Ec
   CJTbBAFEs0EGUcomewxkM6ZEa7a0fYhDvTwOIUOCKz5hhQPROKG4Uh4JZ
   ODAMKB6e39gOcdUs4Ntadgi+JdbdN6bkNfsYCb9pTb7rzkjeCbZRmqgVY
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11018"; a="5763847"
X-IronPort-AV: E=Sophos;i="6.07,139,1708416000"; 
   d="scan'208";a="5763847"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 00:14:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,139,1708416000"; 
   d="scan'208";a="14477421"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 00:14:29 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 7/8] wifi: mac80211: improve drop for action frame return
Date: Wed, 20 Mar 2024 09:14:04 +0200
Message-Id: <20240320091155.34daf0a89eb4.I60e0639511f9de64e40e6105b640adf90f8f57f7@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240320071405.815427-1-miriam.rachel.korenblit@intel.com>
References: <20240320071405.815427-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

If we use a drop we not only save the extra call to
dev_kfree_skb(), but also have a better reason in
tracing, so do that.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/drop.h | 3 ++-
 net/mac80211/rx.c   | 4 ++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/mac80211/drop.h b/net/mac80211/drop.h
index 12a6f0e9eca6..59e3ec4dc960 100644
--- a/net/mac80211/drop.h
+++ b/net/mac80211/drop.h
@@ -2,7 +2,7 @@
 /*
  * mac80211 drop reason list
  *
- * Copyright (C) 2023 Intel Corporation
+ * Copyright (C) 2023-2024 Intel Corporation
  */
 
 #ifndef MAC80211_DROP_H
@@ -66,6 +66,7 @@ typedef unsigned int __bitwise ieee80211_rx_result;
 	R(RX_DROP_U_UNEXPECTED_STA_4ADDR)	\
 	R(RX_DROP_U_UNEXPECTED_VLAN_MCAST)	\
 	R(RX_DROP_U_NOT_PORT_CONTROL)		\
+	R(RX_DROP_U_UNKNOWN_ACTION_REJECTED)	\
 /* this line for the trailing \ - add before this */
 
 /* having two enums allows for checking ieee80211_rx_result use with sparse */
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index c1f850138405..4b4cbd8bf35d 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -3958,8 +3958,8 @@ ieee80211_rx_h_action_return(struct ieee80211_rx_data *rx)
 		__ieee80211_tx_skb_tid_band(rx->sdata, nskb, 7, -1,
 					    status->band);
 	}
-	dev_kfree_skb(rx->skb);
-	return RX_QUEUED;
+
+	return RX_DROP_U_UNKNOWN_ACTION_REJECTED;
 }
 
 static ieee80211_rx_result debug_noinline
-- 
2.34.1


