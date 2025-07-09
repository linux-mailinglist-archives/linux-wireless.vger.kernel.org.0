Return-Path: <linux-wireless+bounces-25138-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EA33EAFF331
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 22:40:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E6557ACFB6
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 20:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04D1C248F52;
	Wed,  9 Jul 2025 20:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R4D994BF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A8D24DCE1
	for <linux-wireless@vger.kernel.org>; Wed,  9 Jul 2025 20:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752093516; cv=none; b=d+It6DskpusihiNBVLJKhv4ZDLSRpoL0tsyW0L1Dy1K1AXk7TYKPkoDJo70RTwVYMtuF8SN2t8yMQqBDspbdvwP78dYkl9ltS+85gY4Rgl9hrMLKbteVmflgLkVapoaECOOwlFaD0Ln4qLKsfDgnq6JfmcziS3NTcvcSB+arb6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752093516; c=relaxed/simple;
	bh=+5s/NKMZYniyfHxTGoGtfu0C0mxR0ct+9jWCh3qdcAc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YX4cySEAZfsjFw9LsCDUSjsa9I+RZYlwDKKlNt79eZAY6d5qEhhs1qIsGRIUi1akNj1qGHZMR0ax3fYKKrvMbsZhTAW/XcqTPJCwJgIWh0VRPj3cYISWhTF7uIp+6VVlYX13781gCtXNVqXW0yh5VsIW7LLvYZbucejW4279lao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R4D994BF; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752093515; x=1783629515;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+5s/NKMZYniyfHxTGoGtfu0C0mxR0ct+9jWCh3qdcAc=;
  b=R4D994BFl4Ea6KcKyqXmHnAHWFNxhEIoqDHTSv13G+xYZoci05PC0oez
   hmBCRFt/nAL82C85ip2rcCxmaY+6CVFFipn562OgafeWvCUILgJnO1vh6
   vHO8JCYLuu0t8BmKMlQBowp6w/tl11L3D00QXlPX22OWFTCqpAR3Pn53N
   GV/tprkWeLZDSF8ZHCZb8kkXnZiy/BimuMhYzdcrVzFBjj6WG/doKsOFs
   dfhYBfCC/b5ePe+CUGJpDVXHd0eY2FB8GLpGJo9BG21pLPyiE2k+greuD
   SyJdP2s3cTBjpbb4HY1ziLEBC5j7rsixV+ulyFt/e35+YCYtEOCuv6E7x
   A==;
X-CSE-ConnectionGUID: Ya1OnT5NQZKEYcH27GfhGg==
X-CSE-MsgGUID: KdNktTS1RgOjbdZSf4zypQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11489"; a="56974455"
X-IronPort-AV: E=Sophos;i="6.16,299,1744095600"; 
   d="scan'208";a="56974455"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 13:38:35 -0700
X-CSE-ConnectionGUID: lXKy/VhDS9KecYLkwRMJyQ==
X-CSE-MsgGUID: hdiOKko3Q0OsLgskoNhVvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,299,1744095600"; 
   d="scan'208";a="161533162"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 13:38:34 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next 09/11] wifi: mac80211: simplify __ieee80211_rx_h_amsdu() loop
Date: Wed,  9 Jul 2025 23:38:01 +0300
Message-Id: <20250709233537.a217a1e8c667.I5283df9627912c06c8327b5786d6b715c6f3a4e1@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250709203803.1736809-1-miriam.rachel.korenblit@intel.com>
References: <20250709203803.1736809-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

The loop handling individual subframes can be simplified to
not use a somewhat confusing goto inside the loop.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/rx.c | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index caa3e6b3f46e..9bca5e0a41b0 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -3033,7 +3033,6 @@ __ieee80211_rx_h_amsdu(struct ieee80211_rx_data *rx, u8 data_offset)
 	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
 	__le16 fc = hdr->frame_control;
 	struct sk_buff_head frame_list;
-	ieee80211_rx_result res;
 	struct ethhdr ethhdr;
 	const u8 *check_da = ethhdr.h_dest, *check_sa = ethhdr.h_source;
 
@@ -3095,24 +3094,18 @@ __ieee80211_rx_h_amsdu(struct ieee80211_rx_data *rx, u8 data_offset)
 	while (!skb_queue_empty(&frame_list)) {
 		rx->skb = __skb_dequeue(&frame_list);
 
-		res = ieee80211_rx_mesh_data(rx->sdata, rx->sta, rx->skb);
-		switch (res) {
+		switch (ieee80211_rx_mesh_data(rx->sdata, rx->sta, rx->skb)) {
 		case RX_QUEUED:
-			continue;
-		case RX_CONTINUE:
 			break;
+		case RX_CONTINUE:
+			if (ieee80211_frame_allowed(rx, fc)) {
+				ieee80211_deliver_skb(rx);
+				break;
+			}
+			fallthrough;
 		default:
-			goto free;
+			dev_kfree_skb(rx->skb);
 		}
-
-		if (!ieee80211_frame_allowed(rx, fc))
-			goto free;
-
-		ieee80211_deliver_skb(rx);
-		continue;
-
-free:
-		dev_kfree_skb(rx->skb);
 	}
 
 	return RX_QUEUED;
-- 
2.34.1


