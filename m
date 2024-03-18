Return-Path: <linux-wireless+bounces-4857-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A8DF87EE17
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Mar 2024 17:54:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39FC51C21ECE
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Mar 2024 16:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1157155E70;
	Mon, 18 Mar 2024 16:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X1Yh8ISl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81FC555E77
	for <linux-wireless@vger.kernel.org>; Mon, 18 Mar 2024 16:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710780857; cv=none; b=JdHjKhVpn3HWDyDMtQb+DVUUHAQVN1jHOSkHKuPP9GDTLizVnMjXe7/U8mpV6Iqmrx6mijvDOC8ZfuHfRoQz7HxTjCoPKt0zhgKsxD5auHD3VsUPwODaQ0kZ1FdMRVjjNOOSc5t3kzoxt9RMc+6Rx1jJBGvArSDtcb7En6h0Bso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710780857; c=relaxed/simple;
	bh=y/ECBVb8eLLCzg5a3fwN3z8CRdKZ0eQJi/uGZAFFxTc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Nzbj9TSxFAPHmdc4P8ZPtn5TZMhTBEqcIX3rwb74sL0DbCJ5VBArSEAU+HfmgHHxCDQS0N1qxx8RfkMY+rub6uOzyoYwvyvkMp0WJG8onax9ytzKZxlcSfFdq75u3nD30IAXFSMnZztWI+NyuMS7dcTwep8NZKqAgGEdCyn2x3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X1Yh8ISl; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710780856; x=1742316856;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=y/ECBVb8eLLCzg5a3fwN3z8CRdKZ0eQJi/uGZAFFxTc=;
  b=X1Yh8ISlUK/AFBUcn9Yh1FXAqB3G6lIHssdoPP25dH7uPcdr71Sa5xnK
   amWVifMUq6ySIijlUZSryCZN/pCBt9JCNsOWZA669dWMPSSvo0V+rGk/p
   FxA4Qr4R5U/vwc9pw6Kb0HuEiipwpMOt4/jZVqCocSTfGf+NSkvoXOdxk
   3iYoL1UJCqXKRONoatdDnjpxy8KhlUIgVxivSPMC8vViBejc5TS1cbmhy
   Vye0I0yvYIPK7ZHJSc5dImhus61Hotl1W6RTBc1gqejzbbMkmfun/Uupo
   IM5rnqtpqg8pv13iiu8OM5YhUfD0Jz3g6oQutHdeTERJD42BRdPXpRjfk
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="5819482"
X-IronPort-AV: E=Sophos;i="6.07,134,1708416000"; 
   d="scan'208";a="5819482"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 09:54:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,134,1708416000"; 
   d="scan'208";a="13909946"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 09:54:14 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 14/15] wifi: mac80211: fix prep_connection error path
Date: Mon, 18 Mar 2024 18:53:30 +0200
Message-Id: <20240318184907.2780c1f08c3d.I033c9b15483933088f32a2c0789612a33dd33d82@changeid>
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

From: Johannes Berg <johannes.berg@intel.com>

If prep_channel fails in prep_connection, the code releases
the deflink's chanctx, which is wrong since we may be using
a different link. It's already wrong to even do that always
though, since we might still have the station. Remove it
only if prep_channel succeeded and later updates fail.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/mlme.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 2434023317e9..082fe2bf14fd 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -7666,7 +7666,7 @@ static int ieee80211_prep_connection(struct ieee80211_sub_if_data *sdata,
 			sdata_info(sdata,
 				   "failed to insert STA entry for the AP (error %d)\n",
 				   err);
-			goto out_err;
+			goto out_release_chan;
 		}
 	} else
 		WARN_ON_ONCE(!ether_addr_equal(link->u.mgd.bssid, cbss->bssid));
@@ -7677,8 +7677,9 @@ static int ieee80211_prep_connection(struct ieee80211_sub_if_data *sdata,
 
 	return 0;
 
+out_release_chan:
+	ieee80211_link_release_channel(link);
 out_err:
-	ieee80211_link_release_channel(&sdata->deflink);
 	ieee80211_vif_set_links(sdata, 0, 0);
 	return err;
 }
-- 
2.34.1


