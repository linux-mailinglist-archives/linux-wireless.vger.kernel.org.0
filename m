Return-Path: <linux-wireless+bounces-4849-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B26AC87EE0F
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Mar 2024 17:54:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E25D21C21D4C
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Mar 2024 16:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F20C55763;
	Mon, 18 Mar 2024 16:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F6xSIRuw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FCA655784
	for <linux-wireless@vger.kernel.org>; Mon, 18 Mar 2024 16:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710780839; cv=none; b=c0AScjeTeLszNPzob3hdSMASAPDAnSJV7rrDyIMTcNHUu/OgNIam+m8cFsveb97I7dF0lDUZ7efkJbGGi9Ul5Qt/yEGDfO7EmjATfPOR4QBatnmc2vyM2P8oenFT7ms/NIQFuQxRvwd+99+aVy5YRzNpHAN+jACUF4NlpvCPrD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710780839; c=relaxed/simple;
	bh=871JndVF66Ox22Baul085PLG5nnkJMtkTPaXhoL7zDA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HTCJZdymGEvpLwiIs49kGPB4SZGOGDKQNXuQ9gSW4no9EYOvANUv8jrnSpD8ki2EdO+kuG+S+nr32yxON4NRjqEv1MR53Orb4CfMYO4ChexTZjY+cE9GLEAkylVbqLEgTmFpP65CU+ifc88qCsM7EVu2orysYrFdBAeXjBatJcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F6xSIRuw; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710780838; x=1742316838;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=871JndVF66Ox22Baul085PLG5nnkJMtkTPaXhoL7zDA=;
  b=F6xSIRuwkCLO4zACZ+duUm6VJmkpzovHBSO/Bgkfcynkbqnny/Pl332i
   +ksTXQGm0edWJls4z6bIMv3w+BSLcGDTm8Tf+nA/NKeipIv/oaSMb1oHq
   kjXkMq1678BY2J+vLBFLhoePAwO+DlD83iXmtarnZkQgEXcr02aZzcWOo
   FK3pQTp+hnk5xT/bokXiUUKe1DbbpC6bxK8GNqq/8FrPr2rzLQbZXP5s/
   3LACxC5Ztq8WC5llqRjlVqY3pHFPZB55p6aRnaJK+YH6f+EC3eAnHOCwj
   /u8XrC2EOXF5GllN2ZMAlwbopdOJmN71I46Y6N52on3XVOTULV+/ZZzl4
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="5819406"
X-IronPort-AV: E=Sophos;i="6.07,134,1708416000"; 
   d="scan'208";a="5819406"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 09:53:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,134,1708416000"; 
   d="scan'208";a="13909831"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 09:53:55 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Ayala Beker <ayala.beker@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH 06/15] wifi: mac80211: correctly set active links upon TTLM
Date: Mon, 18 Mar 2024 18:53:22 +0200
Message-Id: <20240318184907.acddbbf39584.Ide858f95248fcb3e483c97fcaa14b0cd4e964b10@changeid>
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

From: Ayala Beker <ayala.beker@intel.com>

Fix ieee80211_ttlm_set_links() to not set all active links,
but instead let the driver know that valid links status changed
and select the active links properly.

Fixes: 8f500fbc6c65 ("wifi: mac80211: process and save negotiated TID to Link mapping request")
Signed-off-by: Ayala Beker <ayala.beker@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/mlme.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 47a2cba8313f..30cba84e7053 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -5874,6 +5874,15 @@ static int ieee80211_ttlm_set_links(struct ieee80211_sub_if_data *sdata,
 	}
 
 	if (sdata->vif.active_links != active_links) {
+		/* usable links are affected when active_links are changed,
+		 * so notify the driver about the status change
+		 */
+		changed |= BSS_CHANGED_MLD_VALID_LINKS;
+		active_links &= sdata->vif.active_links;
+		if (!active_links)
+			active_links =
+				BIT(__ffs(sdata->vif.valid_links &
+				    ~dormant_links));
 		ret = ieee80211_set_active_links(&sdata->vif, active_links);
 		if (ret) {
 			sdata_info(sdata, "Failed to set TTLM active links\n");
@@ -5888,7 +5897,6 @@ static int ieee80211_ttlm_set_links(struct ieee80211_sub_if_data *sdata,
 		goto out;
 	}
 
-	changed |= BSS_CHANGED_MLD_VALID_LINKS;
 	sdata->vif.suspended_links = suspended_links;
 	if (sdata->vif.suspended_links)
 		changed |= BSS_CHANGED_MLD_TTLM;
-- 
2.34.1


