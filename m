Return-Path: <linux-wireless+bounces-19886-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69A6DA54839
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 11:44:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F79D3ACBA1
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 10:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 301172054E6;
	Thu,  6 Mar 2025 10:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W1Syc5z6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A196520AF77
	for <linux-wireless@vger.kernel.org>; Thu,  6 Mar 2025 10:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741257836; cv=none; b=mQdcK3hUKVgvxrUVU7na3Lb+nlU378m4+bj1iVeLR2qAQuMm6LI58V846ntIUKIY7+V8PHHZ2lmDldLED6xdzQww33xni1FM7Hto/m4Wb7X6DPN/6qFs/GrwDMMKhjeap4cR4sELsp73mqdbkaKWFdOndvNsLm7P3OtPwU3VaAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741257836; c=relaxed/simple;
	bh=qNu7cBgx21Jtj0k1YDhalz/PZF88UWia1kyMtsuxMy0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VOnyi5GtJ8EZaUpj1Iwm+mc7zmeHO2Y2lrHkb79Yc/qemBE3lKu0QIcey2Sp4+289DN0j6Ow0MHbJsR84NX0xshJy9XWUYW48/pTKiF2JWuLsNXgEuECBBMyiA7ya2q9Itk/WjvBPJBTmXtd6Aq9vs6l82kBYSXomCbQYRLfuwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W1Syc5z6; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741257835; x=1772793835;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qNu7cBgx21Jtj0k1YDhalz/PZF88UWia1kyMtsuxMy0=;
  b=W1Syc5z6IWCtQ5RFNvhUMd42TGUhnQVH7fs2AySWPtmoVN0IRpI/LGEy
   TCwODVBnQy+mZXnS2GcN9uHskU4hlXysENOQnGEubUHJq8+wPrYDoDKaw
   xLn2+PUrcbcxEAdIdqIJ0Ml8DiKXMMlivvxwkpJvipsDW9H/n4joiCJj/
   uDoS37LagcJxWZQilkVoCJCtUDdYX02GqyvI5Bh0ZdSrr0qIKDOLk10ag
   C2ODDW1y5eCgmbPOj8sJ8LmDKPepOHZuQxY465SnWFHY9NlRVFahozEnU
   uN0fU/aKmeWamACXXuaeeVm6wzfkTPYm6p37NNSqDXNPnFptq0vz1SoqB
   g==;
X-CSE-ConnectionGUID: IswiAmx5Tz6MMgacgHH5Sw==
X-CSE-MsgGUID: O+fXaULwQ/2MbS4SPEk7hw==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="29844499"
X-IronPort-AV: E=Sophos;i="6.14,225,1736841600"; 
   d="scan'208";a="29844499"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 02:43:54 -0800
X-CSE-ConnectionGUID: g3KadxVUTLa8XzTYxAJTNA==
X-CSE-MsgGUID: CXd2/C7+QVash/3xSVVT/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,225,1736841600"; 
   d="scan'208";a="118797765"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 02:43:52 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH wireless-next 10/15] wifi: mac80211: fix warning on disconnect during failed ML reconf
Date: Thu,  6 Mar 2025 12:43:21 +0200
Message-Id: <20250306124057.7275233ffcd2.I599d5ff69092a65e916e2acd25137ae9df8debe8@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250306104326.4105722-1-miriam.rachel.korenblit@intel.com>
References: <20250306104326.4105722-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

If multi-link reconfiguration fails, we can disconnect with a local link
already allocated but the BSS entry not assigned yet, which leads to a
warning in cfg80211. Add a check to avoid the warning.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/mlme.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 85ae66197674..f3bf66d4ce6a 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -4466,7 +4466,7 @@ static void __ieee80211_disconnect(struct ieee80211_sub_if_data *sdata)
 			struct ieee80211_link_data *link;
 
 			link = sdata_dereference(sdata->link[link_id], sdata);
-			if (!link)
+			if (!link || !link->conf->bss)
 				continue;
 			cfg80211_unlink_bss(local->hw.wiphy, link->conf->bss);
 			link->conf->bss = NULL;
-- 
2.34.1


