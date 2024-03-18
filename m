Return-Path: <linux-wireless+bounces-4854-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C8287EE14
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Mar 2024 17:54:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 019831C212F0
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Mar 2024 16:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5680C55E4E;
	Mon, 18 Mar 2024 16:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iSxrJXIZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A009055E46
	for <linux-wireless@vger.kernel.org>; Mon, 18 Mar 2024 16:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710780850; cv=none; b=QE9P15XHSZJ6kGVtqCeLdfxj3KwqgfVilVe99EpLy0vxBH8Bgds3aoy5ypMmltwKJk/UhDKGiBCuWSUH/B4xen01MCkvGSpCVMFMX17EXKTaub/dARSm6BWCqzO7NG7jQqQCmqAenARA6vU7Ls1LzvPhAwtfKEOU0dwxTxEy5IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710780850; c=relaxed/simple;
	bh=owzzHfbqDK43sOQ5GBzl1Ibk1JRPSdXnbt6uyc15iOg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y+WklSCJiu8Ob3MwOKJI8zAslrQETM3KDH3Cch37B33bJ0FVAwuKpRJUkO7ueSnOFGCbcDv3bnwQBAUYO65UsJpS9mf/roHPXdBtjw9VLCIwNEagpV8jEVe4p1y5NG00gDlsc4oCEb+a1RyvxUQN4qQbksJmkREOaY20JzW0QYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iSxrJXIZ; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710780849; x=1742316849;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=owzzHfbqDK43sOQ5GBzl1Ibk1JRPSdXnbt6uyc15iOg=;
  b=iSxrJXIZ3fNmZj4qzSFiFIZNyTRD4cIFAGZHS0HC4XPqChktbXZbQtQr
   k0sW1PJ6E+ACtZDayxtuSqMNICtkanqeFRyO6cJiaOTRbAPxO+9CdtA1q
   GQvvdNxLb7Q2DMHqHHKaaEuXd8hWf1kvRLu6W3IWk8xVv4Vg//2Jpoud9
   cK5ETgNprZJlz+sJ8kfsBvmJholw3qdrP77RW2JSlV6sGpYbQjF4xlyTs
   EEhA7xkYfiPB09dKG92EKSb7FuktYENiqQ7QCakwh/CTDkxkXQbaZZsW1
   1F/57BtW4ibE1dZ2WXrtli2wis2V/+P2gj8PTiDJlA6UnpPBTEXsxuonb
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="5819443"
X-IronPort-AV: E=Sophos;i="6.07,134,1708416000"; 
   d="scan'208";a="5819443"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 09:54:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,134,1708416000"; 
   d="scan'208";a="13909905"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 09:54:07 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Benjamin Berg <benjamin.berg@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 11/15] wifi: mac80211: improve association error reporting slightly
Date: Mon, 18 Mar 2024 18:53:27 +0200
Message-Id: <20240318184907.695faa9be279.I71b11a8d66a9cae4c27e242a47d1d92922609b03@changeid>
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

There is no reason to check the request flags for each of the links, so
pull that out of the loop. Also, within the loop we can set the per-link
error everywhere.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/mlme.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 958ff328a6c1..2434023317e9 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -8214,6 +8214,14 @@ int ieee80211_mgd_assoc(struct ieee80211_sub_if_data *sdata,
 	if (req->ap_mld_addr) {
 		uapsd_supported = true;
 
+		if (req->flags & (ASSOC_REQ_DISABLE_HT |
+				  ASSOC_REQ_DISABLE_VHT |
+				  ASSOC_REQ_DISABLE_HE |
+				  ASSOC_REQ_DISABLE_EHT)) {
+			err = -EINVAL;
+			goto err_free;
+		}
+
 		for (i = 0; i < IEEE80211_MLD_MAX_NUM_LINKS; i++) {
 			struct ieee80211_supported_band *sband;
 			struct cfg80211_bss *link_cbss = req->links[i].bss;
@@ -8226,19 +8234,13 @@ int ieee80211_mgd_assoc(struct ieee80211_sub_if_data *sdata,
 
 			if (!bss->wmm_used) {
 				err = -EINVAL;
-				goto err_free;
-			}
-
-			if (req->flags & (ASSOC_REQ_DISABLE_HT |
-					  ASSOC_REQ_DISABLE_VHT |
-					  ASSOC_REQ_DISABLE_HE |
-					  ASSOC_REQ_DISABLE_EHT)) {
-				err = -EINVAL;
+				req->links[i].error = err;
 				goto err_free;
 			}
 
 			if (link_cbss->channel->band == NL80211_BAND_S1GHZ) {
 				err = -EINVAL;
+				req->links[i].error = err;
 				goto err_free;
 			}
 
-- 
2.34.1


