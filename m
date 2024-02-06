Return-Path: <linux-wireless+bounces-3229-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7F0684B892
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Feb 2024 15:56:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6432A2820DA
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Feb 2024 14:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47AE11332B1;
	Tue,  6 Feb 2024 14:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aEMEKWRP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8EB213474E
	for <linux-wireless@vger.kernel.org>; Tue,  6 Feb 2024 14:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707231283; cv=none; b=ia/lp9w2Wnly4J+lOBImpKsMsXM/eoHT4cnX1xV0TSQQdUjgq/cJvNYlBXEJQRzKXn5QRLdzacVmY5HhC0stHGxgd5BjEu1z+M1BozZdKyXFlLWpJBYi16/VdjOGDmbGbeHyGwdytGcSRidI2p/pze7xQA7Z7cLwZ90TnRzY5z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707231283; c=relaxed/simple;
	bh=MVBfkWYChY6wIF3NbaqebONg6Bf5AJ9iBScXBDJEfTE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e2H8893xxHnVgtxuQgBZURN/YDOFtIqvkvRxlfi/0nYzVv3xZK4z1rU+7aXrt7Rwfm0xlftrIhHPAJsDR6lSKRVztT4Keaq8eTdAdAYsn80XGwVeyCzjTOmtE3YiUcU8X8JgrrCUhoAISb4yNLAKVNfw9w5kHMbaMbQwVEiurFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aEMEKWRP; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707231282; x=1738767282;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MVBfkWYChY6wIF3NbaqebONg6Bf5AJ9iBScXBDJEfTE=;
  b=aEMEKWRPpX+F+cMXxjZggekusMdSpkBJjnmhFxfFG13ZUI+lgFQxBEzT
   kM06jygfoofAdNBymOa+six4GB+QBbjCCW0mUuuk8HBFjZmMFXsslwqwJ
   Hzh9sdwUyWBeT5WXW7PkhHq5c1ePKeHdFq+hlexbHRJs1SqYW7RvGfwwD
   06vJBH0931JgovRWFBehz/S6xJOA+jsgRs/JUdo8ZN/kfZr+oE+VHv/1T
   PY1iHkRTAzzY11e8o/wsCGpArqxFYNoQTywqzP6OVWweG1wZiwfz8pMEs
   wZnpqQg71I+5UAK0kkJb/Bis2xi9alqXRgMZIsQwFk4aKThGwb9zBwcpw
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="917831"
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="917831"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 06:54:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="824197961"
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="824197961"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 06:54:39 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Shaul Triebitz <shaul.triebitz@intel.com>
Subject: [PATCH 7/8] wifi: nl80211: add WOWLAN_TRIG_UNPROTECTED_DEAUTH_DISASSOC
Date: Tue,  6 Feb 2024 16:54:10 +0200
Message-Id: <20240206164849.8dc9ad531a17.I7f8e926adf927f762e11aaa3458f6354665c7fc5@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240206145411.3217588-1-miriam.rachel.korenblit@intel.com>
References: <20240206145411.3217588-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Shaul Triebitz <shaul.triebitz@intel.com>

Add a report reason for waking up due to an uprotected
deauth/disassoc in MFP.

If setting wowlan to wake on disconnection, and an unprotected
deatuh/disassoc arrived (in MFP), some drivers might want to report
UNPROTECTED_DEAUTH_DISASSOC (and not DISASSOC). Add support for that.

Signed-off-by: Shaul Triebitz <shaul.triebitz@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 include/uapi/linux/nl80211.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 0cac86d090c8..88af476bb8ff 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -5756,6 +5756,8 @@ struct nl80211_pattern_support {
  *	%NL80211_ATTR_SCAN_FREQUENCIES contains more than one
  *	frequency, it means that the match occurred in more than one
  *	channel.
+ * @NL80211_WOWLAN_TRIG_UNPROTECTED_DEAUTH_DISASSOC: For wakeup reporting only.
+ *	Wake up happened due to unprotected deauth or disassoc frame in MFP.
  * @NUM_NL80211_WOWLAN_TRIG: number of wake on wireless triggers
  * @MAX_NL80211_WOWLAN_TRIG: highest wowlan trigger attribute number
  *
@@ -5783,6 +5785,7 @@ enum nl80211_wowlan_triggers {
 	NL80211_WOWLAN_TRIG_WAKEUP_TCP_NOMORETOKENS,
 	NL80211_WOWLAN_TRIG_NET_DETECT,
 	NL80211_WOWLAN_TRIG_NET_DETECT_RESULTS,
+	NL80211_WOWLAN_TRIG_UNPROTECTED_DEAUTH_DISASSOC,
 
 	/* keep last */
 	NUM_NL80211_WOWLAN_TRIG,
-- 
2.34.1


