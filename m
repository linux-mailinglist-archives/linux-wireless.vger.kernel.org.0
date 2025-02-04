Return-Path: <linux-wireless+bounces-18455-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B29E5A278E3
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 18:45:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 917061881DC2
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 17:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B6AE21770B;
	Tue,  4 Feb 2025 17:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VYhSP05F"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD81216E09
	for <linux-wireless@vger.kernel.org>; Tue,  4 Feb 2025 17:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738691032; cv=none; b=dXzi5hEsXATU99QXyL4jM/oqAQ4xCZca23WP9/wi6glY6Bqgr3efFkF9/osY1OEzJwrXVN3Bof0o10yzP32q/juvk7WfixFH2FzvCJUswpt1YDPVG27/Vu7sbqmTqOFuEHhlJtZ5lzTCs2dpx21EnLI1ufB3DYZ5Kr2QUxHrZBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738691032; c=relaxed/simple;
	bh=JSIxL35e/4dQ025+uMXUDi4XIPK/zNZMnKhmRNl4zOo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F2wlsUjpTc6Ncaegq44zWQVqYDNtUTzSMn9D7T1nZh4+34/DRjZ41gchpvkJHnQXKocGlmblZm7MHdFPYuGy8e8Ux/dX0KafkUVRSviA4ORqoF7lvCSlLVeOPdrynYbQLvm3mxS2ZXXMOKkupRp7fgkI9odtvOCHEX85HteSIA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VYhSP05F; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738691030; x=1770227030;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JSIxL35e/4dQ025+uMXUDi4XIPK/zNZMnKhmRNl4zOo=;
  b=VYhSP05FOSOYzFxiiqx8ocGCIxlg+jN8UPwIyI/l6nSDkVMnbnOjkR8u
   2cCIsDPdWx49cMaRT3Bel6B0AboGVudkW5aY6uc3WpYhbRbSJQK1GCTfF
   52oIGpAnq3LtiuWNu8x1hOnMwXekVLyC4djmMGKC7GbJdMJK0xcXQLWEG
   RXb7FZvXvfo77XZkjGtr8xmiuAzmwD0zHrDYC3bvp8Adw/ahTDKihMdVn
   zHw+I0D1KPh6AwCFRFUcf0qfbyJNnmM8gtD7MgwZUgKrp3UVekFIjW1ym
   SPLq3Lqbe7fiT2t2FfZ/LGvL6WimaqpcOVDIO6wb/B33oVIl2YJ4YNh7d
   A==;
X-CSE-ConnectionGUID: l4jR4VG6SoahO91V8exKDg==
X-CSE-MsgGUID: 9vhk2vFhR4i97MWr+MQhEA==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="64585466"
X-IronPort-AV: E=Sophos;i="6.13,259,1732608000"; 
   d="scan'208";a="64585466"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 09:43:01 -0800
X-CSE-ConnectionGUID: 6hfBcVwpR7+6qMNU44JuMQ==
X-CSE-MsgGUID: 3Q7LxGZtT0OKPeGdB8vK4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,259,1732608000"; 
   d="scan'208";a="115696842"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 09:43:00 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH 17/20] wifi: mac80211: enable removing assoc link
Date: Tue,  4 Feb 2025 19:42:14 +0200
Message-Id: <20250204193721.4a62954f6777.I8f62609a682fdf3f703872d0fce63ab6a4780a7e@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250204174217.1161638-1-miriam.rachel.korenblit@intel.com>
References: <20250204174217.1161638-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

With the previous patch to no longer access deflink for aggregation
it seems we no longer access the deflink for MLO stations (MLDs) so
we can allow removing the assoc link.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/mlme.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index d44252c0c27a..3c0d11290b7f 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -10392,9 +10392,6 @@ int ieee80211_mgd_assoc_ml_reconf(struct ieee80211_sub_if_data *sdata,
 	if (WARN_ON(!sta))
 		return -ENOLINK;
 
-	if (rem_links & BIT(sta->sta.deflink.link_id))
-		return -EINVAL;
-
 	/* Adding links to the set of valid link is done only after a successful
 	 * ML reconfiguration frame exchange. Here prepare the data for the ML
 	 * reconfiguration frame construction and allocate the required
-- 
2.34.1


