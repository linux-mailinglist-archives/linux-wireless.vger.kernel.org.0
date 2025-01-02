Return-Path: <linux-wireless+bounces-16986-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B498E9FFA61
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Jan 2025 15:21:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC0A23A280E
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Jan 2025 14:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 077DF1B4F09;
	Thu,  2 Jan 2025 14:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AROyvqCT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25DE71B4250
	for <linux-wireless@vger.kernel.org>; Thu,  2 Jan 2025 14:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735827638; cv=none; b=jITt/ZKV6eFgi8lVyaQsmmNkOW2mQnUDDQFBnSOzV8xruLyG0wILTzSoXLaUwZ4JmmFEza8PQlNiQqhNt9d0jpi6ThcO/y/lKiryY8yNzrz7MuA5bdSQKnOipS1PRzbp4mrN0E4gyOTPTY+XQ+6S3wZJBKzedWCNmxhh1tU4o/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735827638; c=relaxed/simple;
	bh=LXNUUO/V7qb2Kt6nJWhnekim8+kYkn5bm6O9wnH7XqU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=quxgUW1a8rcxmcb7EZzTZO4kwo0qa4QsGB/W9crKyGXJRmSBK51bhaU7EZE2nS9x+SvhzUEsh84KcWncSAT9sEilPvSTlEjqMelfErj/ofc1qJoMEnGfHqao+u9vUNRCgypWbZRmgDX3Hc99Gj/QRgLRHYaEZM2b+AaGiC4Pm7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AROyvqCT; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735827636; x=1767363636;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LXNUUO/V7qb2Kt6nJWhnekim8+kYkn5bm6O9wnH7XqU=;
  b=AROyvqCTm8U2TQW7KB6daAR5L30ZLbeuc9Rae0JfunelVYCo8yu6kHkh
   5M+RzKbRZgfquuxK/pc5KGPoRBNePhVpnf9CinlhnTtvJ41BXGEn92IoR
   /dXqPqB5dl+nu271JdLzz5T3baRCKFIq0hStCme4oBH+D5MDePQ3I3luU
   L4OnNkSeEROEALdNvyTPRfxhpR7oGaa0LD7xBep+Tig9VYHzjruX3y2ts
   S6WbZAUD6SQK8v9v755ZLOREOyleSkYyUgfbch2BlQv+10tREAao6fqre
   cd13KYkpDKibjlQMAc25CnhP7sJdlZb3CCSvUZj3RBs87Mo/N3o3mwOJs
   A==;
X-CSE-ConnectionGUID: VPbcwfquSVy7k4Ut5Yw47w==
X-CSE-MsgGUID: aD5t0eDGQSyFverS2YZEzw==
X-IronPort-AV: E=McAfee;i="6700,10204,11302"; a="46735114"
X-IronPort-AV: E=Sophos;i="6.12,285,1728975600"; 
   d="scan'208";a="46735114"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2025 06:20:36 -0800
X-CSE-ConnectionGUID: 9Z4kiwtLS3Ou+qb2QItf9w==
X-CSE-MsgGUID: 9ZFwPV2lSrex3VVq9++27Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,285,1728975600"; 
   d="scan'208";a="132357408"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2025 06:20:34 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Ilan Peer <ilan.peer@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 08/17] wifi: mac80211: Fix common size calculation for ML element
Date: Thu,  2 Jan 2025 16:20:00 +0200
Message-Id: <20250102161730.5790376754a7.I381208cbb72b1be2a88239509294099e9337e254@changeid>
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

When the ML type is EPCS the control bitmap is reserved, the length
is always 7 and is captured by the 1st octet after the control.

Fixes: 0f48b8b88aa9 ("wifi: ieee80211: add definitions for multi-link element")
Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 include/linux/ieee80211.h | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index b5c5b5c39d9a..16741e542e81 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -5084,28 +5084,24 @@ static inline u8 ieee80211_mle_common_size(const u8 *data)
 {
 	const struct ieee80211_multi_link_elem *mle = (const void *)data;
 	u16 control = le16_to_cpu(mle->control);
-	u8 common = 0;
 
 	switch (u16_get_bits(control, IEEE80211_ML_CONTROL_TYPE)) {
 	case IEEE80211_ML_CONTROL_TYPE_BASIC:
 	case IEEE80211_ML_CONTROL_TYPE_PREQ:
 	case IEEE80211_ML_CONTROL_TYPE_TDLS:
 	case IEEE80211_ML_CONTROL_TYPE_RECONF:
+	case IEEE80211_ML_CONTROL_TYPE_PRIO_ACCESS:
 		/*
 		 * The length is the first octet pointed by mle->variable so no
 		 * need to add anything
 		 */
 		break;
-	case IEEE80211_ML_CONTROL_TYPE_PRIO_ACCESS:
-		if (control & IEEE80211_MLC_PRIO_ACCESS_PRES_AP_MLD_MAC_ADDR)
-			common += ETH_ALEN;
-		return common;
 	default:
 		WARN_ON(1);
 		return 0;
 	}
 
-	return sizeof(*mle) + common + mle->variable[0];
+	return sizeof(*mle) + mle->variable[0];
 }
 
 /**
@@ -5392,8 +5388,7 @@ static inline bool ieee80211_mle_size_ok(const u8 *data, size_t len)
 		check_common_len = true;
 		break;
 	case IEEE80211_ML_CONTROL_TYPE_PRIO_ACCESS:
-		if (control & IEEE80211_MLC_PRIO_ACCESS_PRES_AP_MLD_MAC_ADDR)
-			common += ETH_ALEN;
+		common = ETH_ALEN + 1;
 		break;
 	default:
 		/* we don't know this type */
-- 
2.34.1


