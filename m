Return-Path: <linux-wireless+bounces-4855-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A58387EE15
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Mar 2024 17:54:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB0EA1C21335
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Mar 2024 16:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9746255E46;
	Mon, 18 Mar 2024 16:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oEqi6Dyw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E7855E5F
	for <linux-wireless@vger.kernel.org>; Mon, 18 Mar 2024 16:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710780852; cv=none; b=Cyqlf7xy1SBXGwaCjRM8/YyU7XaYqU3qtF//AlEGG5JJlI9YP3NSNbtNDquNAYlVOD3rPG2KyhKwXbajFRIROBk+6jgtMsPfZx87aVi7chI4rOVW9p/e9Ptn1vJnt8QB+d/QWldPDmVA9k6um8+7J/B2moAF/68DMRyW+3INzFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710780852; c=relaxed/simple;
	bh=Pi7hUuORqtdkvAdIYbr2eOr7xAenqmjs+iF3qobsm/0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GmyzdoaWKC5ZQKv2mlWpaMhjAtvER6TNQ1OrjhVkR1LWncHkOyC7euLPdNcuYUc13CRsUV0+8i6zyJJda4e768T0E1IECqFLM8Lze3De4ttDL7VSJ4Is21B5kvq77h5tkzSOtK467JK8L8yYlEUuL5MuIqy/9D0l6/wpccrQH4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oEqi6Dyw; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710780851; x=1742316851;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Pi7hUuORqtdkvAdIYbr2eOr7xAenqmjs+iF3qobsm/0=;
  b=oEqi6Dyw+n+Qwv6pBjNekpZPcDoH39GS4sWkcrRmC/RJ0jh2QeuKTa+g
   B4mavoBmiPF7uui382v5CbklfQ/jshLcTzlXswjdEBIJrrLUour7BE+wq
   4eH/+qnqvmxhRiUDuMwNLsIVreJ4a0Dfof18uN3uqhhht4N3BnSf7BSHk
   FBFE/0gnRRpIp3NLLgRhPiS3pF4h2v01E4rSLZH+AR5baTVivgUiR8p3X
   cd+rzWY+QMz9PHVQrEseBR2SWC3X3/BcVLAqze68w89DOC4AZLhLKGEW/
   pJOcJTGMkIk60e35TsFH/HLmRjltTv091/g6z3CrjRQhtuSHhGcm+bRKG
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="5819465"
X-IronPort-AV: E=Sophos;i="6.07,134,1708416000"; 
   d="scan'208";a="5819465"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 09:54:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,134,1708416000"; 
   d="scan'208";a="13909927"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 09:54:09 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Benjamin Berg <benjamin.berg@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 12/15] wifi: cfg80211: check BSSID Index against MaxBSSID
Date: Mon, 18 Mar 2024 18:53:28 +0200
Message-Id: <20240318184907.a7574d415adc.I02f40c2920a9f602898190679cc27d0c8ee2c67d@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240318165331.3170594-1-miriam.rachel.korenblit@intel.com>
References: <20240318165331.3170594-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Benjamin Berg <benjamin.berg@intel.com>

Add a verification that the BSSID Index does not exceed the maximum
number of BSSIDs in the Multiple-BSSID set.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/wireless/scan.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index b55ffe73e1ef..8ac2d19d8ede 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -2447,7 +2447,8 @@ cfg80211_parse_mbssid_data(struct wiphy *wiphy,
 				 profile, profile_len);
 			if (!mbssid_index_ie || mbssid_index_ie[1] < 1 ||
 			    mbssid_index_ie[2] == 0 ||
-			    mbssid_index_ie[2] > 46) {
+			    mbssid_index_ie[2] > 46 ||
+			    mbssid_index_ie[2] >= (1 << elem->data[0])) {
 				/* No valid Multiple BSSID-Index element */
 				continue;
 			}
-- 
2.34.1


