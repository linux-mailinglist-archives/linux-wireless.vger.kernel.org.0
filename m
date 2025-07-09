Return-Path: <linux-wireless+bounces-25130-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7B75AFF324
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 22:38:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F351C174EEA
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 20:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D5A202F8F;
	Wed,  9 Jul 2025 20:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DgEtucGk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C1B242D77
	for <linux-wireless@vger.kernel.org>; Wed,  9 Jul 2025 20:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752093508; cv=none; b=DOi4JMjv6FoQ1VgKTefF+WDCXeoOscd39cUlM4da+OPChmunacxOib6lMnYPyjVCrr9vNWBXAAZoJWStIyxkKH79zxca7PxUJIL7N3DoTjD00A5v+wxSdxBm1xqB+79PZfbcBTjaX3sQJjYUDcnmsmWGeTeHxkQCUgudd8fUHAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752093508; c=relaxed/simple;
	bh=YqbfafMrvX5d76cE9du0D8O1egGiX2e1+NCwUq4WAYA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CnqTqTl2muUft6no1O/RLOH96BLaNCKN7x9VLQxJEP9QQO+ThWYDuDNjTAH+Y47va//KbD+/hTd6If+nyXJ3aZDAFbbllRdT+W3/MsJ/RimbHPHCHAhtoZfAKAILV0J+il6I2C2RBImOMzWABtfR7wmPE47deG4aUdS46LDw5l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DgEtucGk; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752093507; x=1783629507;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YqbfafMrvX5d76cE9du0D8O1egGiX2e1+NCwUq4WAYA=;
  b=DgEtucGkZc5eFlwSTqc70JD7d6LcEc5wxP5yXERZ1PWbkUL94MG5rq2Q
   0euJKIX+EZsVkf1B8AAdvbiibNuaSNuLFYkWAdJU+5qm+9FN8ix1L2PLv
   sYJ9lWShyeq8t6xGZ1n9Ka0/pSRCLXokwUCc1ymzHkY005xsEGB5a/mVM
   UCI0eO2io5WwfUgIVla60l6HIeFT1x0E8sbLRXzys9u6CLi60EGUBguVf
   fZ79jYyGPSe4Qj1vpoUwedS4Ub5ob0D14ZzriTU4bSNoX8zr0SOzolOvI
   ex3zu1AXc+MHT6hUuflcQpgF0378wd4eMOgxs6QSpXHtYas7gkmVE5iuW
   Q==;
X-CSE-ConnectionGUID: 3HVvUfAUTBKCZiZBjNlv4g==
X-CSE-MsgGUID: j4tRQx1ATtaTB0gIQp/RcQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11489"; a="56974434"
X-IronPort-AV: E=Sophos;i="6.16,299,1744095600"; 
   d="scan'208";a="56974434"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 13:38:25 -0700
X-CSE-ConnectionGUID: biIqV7vEQCa9/M1BSLTg4Q==
X-CSE-MsgGUID: uQfW28tRTDCpieu/icQfJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,299,1744095600"; 
   d="scan'208";a="161532647"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 13:38:24 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next 01/11] wifi: mac80211: don't unreserve never reserved chanctx
Date: Wed,  9 Jul 2025 23:37:53 +0300
Message-Id: <20250709233537.022192f4b1ae.Ib58156ac13e674a9f4d714735be0764a244c0aae@changeid>
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

If a link has no chanctx, indicating it is an inactive link
that we tracked CSA for, then attempting to unreserve the
reserved chanctx will throw a warning and fail, since there
never was a reserved chanctx. Skip the unreserve.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/mlme.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 8b9c132cce3d..d64b09d07db3 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -2561,7 +2561,8 @@ ieee80211_sta_abort_chanswitch(struct ieee80211_link_data *link)
 	if (!local->ops->abort_channel_switch)
 		return;
 
-	ieee80211_link_unreserve_chanctx(link);
+	if (rcu_access_pointer(link->conf->chanctx_conf))
+		ieee80211_link_unreserve_chanctx(link);
 
 	ieee80211_vif_unblock_queues_csa(sdata);
 
-- 
2.34.1


