Return-Path: <linux-wireless+bounces-21981-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09EC1A9ADA8
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Apr 2025 14:39:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B2AC1940749
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Apr 2025 12:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D3CC27A92E;
	Thu, 24 Apr 2025 12:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l40zfhR+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729D827A91D
	for <linux-wireless@vger.kernel.org>; Thu, 24 Apr 2025 12:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745498330; cv=none; b=MwtM+nDwBP3xFV43xBO6wnIusPZlBNEeff65NJCs2nC0tZQtRIuSJXLCwrFXmK7FQmyXXAGxjUPlWvfYpIMTATh7hxwwApB0BQgk251CDKtr2dGZcSo9FiNTaZjsVeuiE6crtFNk76mA8kGNc8ZufZTQUSdeGLhWRelIfSxmT+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745498330; c=relaxed/simple;
	bh=c/V2aRHqPEAfrppj7F21Qr3t8qAwhyhUigfJ3ebJt+s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mghiXSBqOgO3VQyVMOIjIz+FkzHvyxGEcKJX6T8Gz0/lPUTjCiLi46uTMWY2Gl+LBjHsnWHpEmym5dnVQNh7Fsz5doY9FNlQJ17zAJfwGt6oIg4FvRM2lP9An3VlRXQ89j/ZJoWz9wD09vOVNLSBCWAvTWu+YlC3qz0fLrIxuyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l40zfhR+; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745498329; x=1777034329;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=c/V2aRHqPEAfrppj7F21Qr3t8qAwhyhUigfJ3ebJt+s=;
  b=l40zfhR+8JFcQcQelzPOFDhyP6YkQlmcZfaZ9NBG4ilbCre88z8kGiHo
   cRxde80mTuHYsv+ziQPnGbfzEZqEL441X3/bv4aqZevR17QZ7fOiqLL3F
   9ze/XFmxb11+9BEWy948ecNtBToJP9sVIRjOvf5a0ZYl/+lg08CHABIOw
   wGgYVtfgM2oKtcOeQuULK0wme2T9cDibXF6xqiqGUfD/pgvTU8YvM6rCR
   we6e98D3ZdQSmntwcZQnI8Qh9lqb6P7XNoyb6KApsSIqNQetxqFxbURVd
   nYKf0ed9rPEwv/3Dxn7rOCJpCDqLEPbs8Xv4yDUMflYtY68asEo/JESmM
   g==;
X-CSE-ConnectionGUID: xlDEK1BhTJ6udQfL2EmMVA==
X-CSE-MsgGUID: VamUtIeARZuIEXn4CBgMBg==
X-IronPort-AV: E=McAfee;i="6700,10204,11413"; a="47302406"
X-IronPort-AV: E=Sophos;i="6.15,236,1739865600"; 
   d="scan'208";a="47302406"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 05:38:49 -0700
X-CSE-ConnectionGUID: na9sHWbuQOa5rLFzu3cqIA==
X-CSE-MsgGUID: I2T6SyhiTj6oRw//SZosLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,236,1739865600"; 
   d="scan'208";a="133137383"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 05:38:48 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next 02/14] wifi: iwlwifi: mld: clarify variable type
Date: Thu, 24 Apr 2025 15:38:19 +0300
Message-Id: <20250424153620.ddf54a728ec0.Ie2e8de150f67369c4e034452c5f1a15f85d2931c@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250424123831.3524359-1-miriam.rachel.korenblit@intel.com>
References: <20250424123831.3524359-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

In iwl_mld_emlsr_disallowed_with_link() the code uses an
enum for a bitmap of values from it, which doesn't really
make sense.Use u32 for the variable just like the return
value.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/mlo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mlo.c b/drivers/net/wireless/intel/iwlwifi/mld/mlo.c
index a870e169e265..bf158af5f6f3 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mlo.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mlo.c
@@ -643,7 +643,7 @@ iwl_mld_emlsr_disallowed_with_link(struct iwl_mld *mld,
 {
 	struct wiphy *wiphy = mld->wiphy;
 	struct ieee80211_bss_conf *conf;
-	enum iwl_mld_emlsr_exit ret = 0;
+	u32 ret = 0;
 
 	conf = wiphy_dereference(wiphy, vif->link_conf[link->link_id]);
 	if (WARN_ON_ONCE(!conf))
-- 
2.34.1


