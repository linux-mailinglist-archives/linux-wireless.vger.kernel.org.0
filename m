Return-Path: <linux-wireless+bounces-16848-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEDA29FDC30
	for <lists+linux-wireless@lfdr.de>; Sat, 28 Dec 2024 21:35:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85F06161568
	for <lists+linux-wireless@lfdr.de>; Sat, 28 Dec 2024 20:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A7831991D2;
	Sat, 28 Dec 2024 20:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F7t5FnGd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52FAB1991B8
	for <linux-wireless@vger.kernel.org>; Sat, 28 Dec 2024 20:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735418083; cv=none; b=Xiy0cJYR+LayeQmiWqsHfD/O1X3OuUCN18Me2YLVSJL5y17Sn3owElOgwOaBtHfAYyaPu589bhc0mRCHynJul4QYBT1igaiyExxCWQohkRXzmuwz4BCLq/XdaUzGTolhcCkP5l5hF5iHW/82CkJiDUnxtLyL52ODezI0UzXh2TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735418083; c=relaxed/simple;
	bh=Yj5zys47jGAG55ODB3gEFWVyzX5A8wuj6SbkmySD/yk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RLzI95+JwduL3+hwkUqrsJsS1MkhI8H08TBL61+Sz9bRGTFgI4WPf/Gu0f44tY69Pvn/itbiyhdqzI/0LXK6In3STtzbjPd2eITaGRAu42gy//lV1+gATX43/iLUUeXly/Jp/+2QOSrRk3MVA2jg3oJ3WnBRt1/bApKhq98jpyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F7t5FnGd; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735418082; x=1766954082;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Yj5zys47jGAG55ODB3gEFWVyzX5A8wuj6SbkmySD/yk=;
  b=F7t5FnGdG4DyyaLEO4gFW733nDyk9dGeOXW9xs6AGHA5QBsWh4skizsG
   HSxWNowQ/V8LXabGjovuNM4RH8yLTyJHgYSOv0Q+VKXhNBQxl8rJr3srt
   zfeW03WvPEej+x65YbMIs0g2wlcj4nZVHEpcv8XmnxlATcwD//DIjMfPA
   gbe8GfZNk60cf/y8kuNP6BAzJLu5A47sCLQaJFcUexW3mMpwYnG5HlzJs
   P6Jp6xy/cBbEgvklf/WT+uydSb1rzXfrfYi2BjXN8rffZ3nz7OOHuMsCr
   l5RfzmFB1cECd0kkZPmtg+SS2u33P467BfQnU1zDIiKcjQJy4cbdb6fSI
   g==;
X-CSE-ConnectionGUID: FJAsXXwHTPSmBdXAYQ1Tzg==
X-CSE-MsgGUID: 00Jdb5iPTxeT7ZsWS3PVXw==
X-IronPort-AV: E=McAfee;i="6700,10204,11299"; a="35479762"
X-IronPort-AV: E=Sophos;i="6.12,273,1728975600"; 
   d="scan'208";a="35479762"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2024 12:34:42 -0800
X-CSE-ConnectionGUID: Ihv5USYYSZquD1+dMxOs4Q==
X-CSE-MsgGUID: epPPR52fTBOICQA6WASsCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="104488399"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2024 12:34:41 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	"Somashekhar(Som)" <somashekhar.puttagangaiah@intel.com>
Subject: [PATCH 06/15] wifi: iwlwifi: Allow entering EMLSR for more band combinations
Date: Sat, 28 Dec 2024 22:34:10 +0200
Message-Id: <20241228223206.ec659168eeb7.I403f61f0e827c14cf2b245f48e1736559f17c476@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241228203419.2443350-1-miriam.rachel.korenblit@intel.com>
References: <20241228203419.2443350-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: "Somashekhar(Som)" <somashekhar.puttagangaiah@intel.com>

Enter EMLSR only when two bands are different.
EMLSR should be allowed when one of the link is LB.

Signed-off-by: Somashekhar(Som) <somashekhar.puttagangaiah@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/link.c        | 5 ++---
 drivers/net/wireless/intel/iwlwifi/mvm/tests/links.c | 2 +-
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/link.c b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
index 272da41567ef..1f2d281864a7 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/link.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
@@ -762,9 +762,8 @@ bool iwl_mvm_mld_valid_link_pair(struct ieee80211_vif *vif,
 	    iwl_mvm_esr_disallowed_with_link(mvm, vif, b, false))
 		return false;
 
-	if (a->chandef->width != b->chandef->width ||
-	    !(a->chandef->chan->band == NL80211_BAND_6GHZ &&
-	      b->chandef->chan->band == NL80211_BAND_5GHZ))
+	if (a->chandef->chan->band == b->chandef->chan->band ||
+	    a->chandef->width != b->chandef->width)
 		ret |= IWL_MVM_ESR_EXIT_BANDWIDTH;
 
 	if (ret) {
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tests/links.c b/drivers/net/wireless/intel/iwlwifi/mvm/tests/links.c
index 1dc57e022191..d692f1813d44 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tests/links.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tests/links.c
@@ -262,7 +262,7 @@ static const struct valid_link_pair_case {
 		.desc = "LB + HB, no BT.",
 		.chan_a = &chan_2ghz,
 		.chan_b = &chan_5ghz,
-		.valid = false,
+		.valid = true,
 	},
 	{
 		.desc = "LB + HB, with BT.",
-- 
2.34.1


