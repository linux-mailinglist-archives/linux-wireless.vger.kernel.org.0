Return-Path: <linux-wireless+bounces-26743-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 87163B396E6
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Aug 2025 10:27:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5AA157B868E
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Aug 2025 08:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E6D2E0934;
	Thu, 28 Aug 2025 08:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="atK8TPbf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276812E1EE6
	for <linux-wireless@vger.kernel.org>; Thu, 28 Aug 2025 08:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756369624; cv=none; b=X0vjixorK/T+Sw4gnBx/0kM2DyNNhXn/gXwOIJRi0kpk7VNH6GKf7/skCkW32putYkDo1FPKc3lYUpE5bLqzsMr2M6c1QYO2YHbnYIYXnL34h+T7Magxr2l5DxW5ToXwHX3cyTzl8/nGXQjF7veAcTR1QTZXuo0uo01DEjHeJV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756369624; c=relaxed/simple;
	bh=HTFBOod11J72RQD26cnkM725hJsk2tzSmJqrepFvoNo=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZewMnLQ+4XiLmvh98qL7vs+E7Odr/rLnh4IKHhvGwA4xSiY0/fPiQem7k0adkIQlfCpeKAPRh9guS3WiG59PHIG2maWm+n8x7efJfDQUZOh9woLVA23DZU42GnmflTECle39vICQtho5FZazay7ElstPQXxDXCWwcbfv0WjxA9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=atK8TPbf; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756369622; x=1787905622;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=HTFBOod11J72RQD26cnkM725hJsk2tzSmJqrepFvoNo=;
  b=atK8TPbfVr1gMuqUXjSlf0JwuZvNufgrz/PKfGVvth6HbBjgwSVTbga3
   T6qTW5Ux6YnDPgbN780j/dqqJsc2kETc+EIMaA08gwoxsDPPBD84WfB+U
   tTR3cfzFCG0IoYVlTzR98/y2gtT1JB2G3ittszwbV6jj0f9Kw9TUjxzxb
   MFZqNX4gUU0AOjs+t0qsCv/p+gnaBws5Rf8gje5yjPJdnDIMBDjrD3Y87
   MpRDfxPdr0GKjdaBTs8lqorTEQ6QLbbUScuyFi3vwXUVnUIIEOWae93wc
   TQt4YQW07Y7CFNr1eIv/2/evly+n2QIATGLFC4OBEmX4oFdACxpbbxvQc
   g==;
X-CSE-ConnectionGUID: sSEZhXK6SC2qXn1SctJzOg==
X-CSE-MsgGUID: mYf1BtqNS1+lT5/RI8A2Tg==
X-IronPort-AV: E=McAfee;i="6800,10657,11535"; a="70003377"
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="70003377"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 01:26:50 -0700
X-CSE-ConnectionGUID: vz/rUis9T8ibgQCLydFMlw==
X-CSE-MsgGUID: kbf/2VuNS+mI0sBBzZxF+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="170224531"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 01:26:50 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Subject: [PATCH iwlwifi-next 14/15] wifi: iwlwifi: mld: remove a TODO
Date: Thu, 28 Aug 2025 11:26:00 +0300
Message-Id: <20250828111032.c445b2fc8bce.Ic616d605a4d6f82122466f50022cd046d229de4e@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250828082601.537908-1-miriam.rachel.korenblit@intel.com>
References: <20250828082601.537908-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

This was already done.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/mlo.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mlo.c b/drivers/net/wireless/intel/iwlwifi/mld/mlo.c
index e57f5388fe77..99a9219438a6 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mlo.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mlo.c
@@ -735,12 +735,6 @@ iwl_mld_set_link_sel_data(struct iwl_mld *mld,
 	u16 max_grade = 0;
 	unsigned long link_id;
 
-	/*
-	 * TODO: don't select links that weren't discovered in the last scan
-	 * This requires mac80211 (or cfg80211) changes to forward/track when
-	 * a BSS was last updated. cfg80211 already tracks this information but
-	 * it is not exposed within the kernel.
-	 */
 	for_each_set_bit(link_id, &usable_links, IEEE80211_MLD_MAX_NUM_LINKS) {
 		struct ieee80211_bss_conf *link_conf =
 			link_conf_dereference_protected(vif, link_id);
-- 
2.34.1


