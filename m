Return-Path: <linux-wireless+bounces-16987-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6A729FFA62
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Jan 2025 15:21:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9E163A2BF6
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Jan 2025 14:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 300661B4259;
	Thu,  2 Jan 2025 14:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VdRGoqLr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBFB31B4245
	for <linux-wireless@vger.kernel.org>; Thu,  2 Jan 2025 14:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735827640; cv=none; b=MhktVMAqG14owvXQ8wqIc04l0uo5g0yMUSSKEOYMw/pgoy7+D/tskhQAzgSWQRfXDjbmcoT8hjLNXOZaq2xzexZKfR+YT1MwcqNh+HxcgZeZucHBHRBHGYwA1f49A+gdqyy4IAiiE43lbigVTaOFjwvGxS81NFTMAy/Vc4KYk+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735827640; c=relaxed/simple;
	bh=FdjyHsSsaQOf6iSENrU6HnAqaXiXVLUCn/0aplTnKe8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kHX7lVZdKWm9gHG11zCgD6mc61J4UdSz7ZOvDH677z8yDkByzNhPd9YYAoojREL/l807PwbEcsF6vr42OoLteHhI9/pCyA2p6x88ynacWK7g6cNqr1nm7Bpt12aX0hYtWR8d3Trzb2jzqI4b15PPkHj7QcLzhBWSLLXjaTV+ci0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VdRGoqLr; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735827638; x=1767363638;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FdjyHsSsaQOf6iSENrU6HnAqaXiXVLUCn/0aplTnKe8=;
  b=VdRGoqLrBvVFqZOdsyto7CwuSvhwFlmn4Z4P/d5RUYESPBphSCWnqeza
   VP8Yb2nqRNcwG3JzdqplCL9BNJ4FSxkNMERZASxPPdy2uAreZriPP60yv
   aIIHgIZOHIBxzdneg1rwRM1sJe+4Buae2Te18tqt0mH2yBuxP/ft5rpl2
   KrjzIm7EJ55ioFAlMdbBa7mtmucgoiUqputy7nOxdsgaat85aKYJVeYye
   oHvhVqzDB6RM8J6ggKyWsHUxlGbgls06zq8r6hR67FtIOiMrSquD3Ks3a
   8JOLcCnKQ6YNLR7nRCWMJD8zyJ6rQiKAIyKzVezdtwllFw3yKv4aF9t1p
   g==;
X-CSE-ConnectionGUID: f5qhTKf3QUGPLZAL60Nebw==
X-CSE-MsgGUID: PKXlnU6GQfqHgFxJHiY41w==
X-IronPort-AV: E=McAfee;i="6700,10204,11302"; a="46735116"
X-IronPort-AV: E=Sophos;i="6.12,285,1728975600"; 
   d="scan'208";a="46735116"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2025 06:20:37 -0800
X-CSE-ConnectionGUID: Wq5VaPE/RfWQGRa7+jtcIg==
X-CSE-MsgGUID: p/nCaoF4RvCXViBlWadiFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,285,1728975600"; 
   d="scan'208";a="132357413"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2025 06:20:35 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Ilan Peer <ilan.peer@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 09/17] wifi: mac80211: Support parsing EPCS ML element
Date: Thu,  2 Jan 2025 16:20:01 +0200
Message-Id: <20250102161730.5afdf65cff46.I0ffa30b40fbad47bc5b608b5fd46047a8c44e904@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250102142009.3057049-1-miriam.rachel.korenblit@intel.com>
References: <20250102142009.3057049-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Ilan Peer <ilan.peer@intel.com>

Add support for parsing an ML element of type EPCS priority
access, which can optionally be included in EHT protected action
frames used to configure EPCS.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/ieee80211_i.h |  2 ++
 net/mac80211/parse.c       | 29 +++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 64df7d739ebf..5c5a91ead339 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1762,6 +1762,7 @@ struct ieee802_11_elems {
 	const struct ieee80211_eht_operation *eht_operation;
 	const struct ieee80211_multi_link_elem *ml_basic;
 	const struct ieee80211_multi_link_elem *ml_reconf;
+	const struct ieee80211_multi_link_elem *ml_epcs;
 	const struct ieee80211_bandwidth_indication *bandwidth_indication;
 	const struct ieee80211_ttlm_elem *ttlm[IEEE80211_TTLM_MAX_CNT];
 
@@ -1792,6 +1793,7 @@ struct ieee802_11_elems {
 	/* mult-link element can be de-fragmented and thus u8 is not sufficient */
 	size_t ml_basic_len;
 	size_t ml_reconf_len;
+	size_t ml_epcs_len;
 
 	u8 ttlm_num;
 
diff --git a/net/mac80211/parse.c b/net/mac80211/parse.c
index 279c5143b335..cd318c1c67be 100644
--- a/net/mac80211/parse.c
+++ b/net/mac80211/parse.c
@@ -44,6 +44,9 @@ struct ieee80211_elems_parse {
 	/* The reconfiguration Multi-Link element in the original elements */
 	const struct element *ml_reconf_elem;
 
+	/* The EPCS Multi-Link element in the original elements */
+	const struct element *ml_epcs_elem;
+
 	/*
 	 * scratch buffer that can be used for various element parsing related
 	 * tasks, e.g., element de-fragmentation etc.
@@ -159,6 +162,9 @@ ieee80211_parse_extension_element(u32 *crc,
 			case IEEE80211_ML_CONTROL_TYPE_RECONF:
 				elems_parse->ml_reconf_elem = elem;
 				break;
+			case IEEE80211_ML_CONTROL_TYPE_PRIO_ACCESS:
+				elems_parse->ml_epcs_elem = elem;
+				break;
 			default:
 				break;
 			}
@@ -943,6 +949,27 @@ ieee80211_mle_defrag_reconf(struct ieee80211_elems_parse *elems_parse)
 	elems_parse->scratch_pos += ml_len;
 }
 
+static void
+ieee80211_mle_defrag_epcs(struct ieee80211_elems_parse *elems_parse)
+{
+	struct ieee802_11_elems *elems = &elems_parse->elems;
+	ssize_t ml_len;
+
+	ml_len = cfg80211_defragment_element(elems_parse->ml_epcs_elem,
+					     elems->ie_start,
+					     elems->total_len,
+					     elems_parse->scratch_pos,
+					     elems_parse->scratch +
+						elems_parse->scratch_len -
+						elems_parse->scratch_pos,
+					     WLAN_EID_FRAGMENT);
+	if (ml_len < 0)
+		return;
+	elems->ml_epcs = (void *)elems_parse->scratch_pos;
+	elems->ml_epcs_len = ml_len;
+	elems_parse->scratch_pos += ml_len;
+}
+
 struct ieee802_11_elems *
 ieee802_11_parse_elems_full(struct ieee80211_elems_parse_params *params)
 {
@@ -1001,6 +1028,8 @@ ieee802_11_parse_elems_full(struct ieee80211_elems_parse_params *params)
 
 	ieee80211_mle_defrag_reconf(elems_parse);
 
+	ieee80211_mle_defrag_epcs(elems_parse);
+
 	if (elems->tim && !elems->parse_error) {
 		const struct ieee80211_tim_ie *tim_ie = elems->tim;
 
-- 
2.34.1


