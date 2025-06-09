Return-Path: <linux-wireless+bounces-23878-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 871BAAD25AF
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jun 2025 20:36:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5246316DC97
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jun 2025 18:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC3CF218EA7;
	Mon,  9 Jun 2025 18:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WB28c20L"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B4D19258E
	for <linux-wireless@vger.kernel.org>; Mon,  9 Jun 2025 18:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749494150; cv=none; b=hJoav2t/kOdEs/nvPhxCTQMKySgQ2v4Qrz9urmwJ0kw3HbymLmFvqJjQgE31fOiFwlnGdW0dbo0LcJn3c8kJtIKvYerdAP/QZPAHHqCu1/AxHcARqU0ag/TACvs3xOQEKjkmT3bN/Ss4o/HUkv2Jg6+clonS3oljw3nV3tCYpYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749494150; c=relaxed/simple;
	bh=10NmB1L9eRsfDDnfWDAuMdagMWl1vAbQXmj0oLqgDco=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kzepRmkfv6W2TyHiavojvxcSHPjnMlCrW5WB0f9l4iQtq/4Z0CLxaAJT1kHKsnVCpgEuGDsMg0TVfuBmVFt9B7m8ZV4WrvcWQ0fDxWqpG0NNuT4spI+2xZTFHSEknx2FwbgUn64Y+kR710B5qGkvd9D8+4D4KlqM1DwtqjqsLhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WB28c20L; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749494148; x=1781030148;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=10NmB1L9eRsfDDnfWDAuMdagMWl1vAbQXmj0oLqgDco=;
  b=WB28c20LVDHc+rQNXEr14Xx/E0v5yd23LqUEwX+GaBQLCxblRbviM3EM
   /bhHrPRP1UYtQEgQYSEr4VISjJ8ibwCthq4JqfJVLPBE+lThkbEcezWr2
   w5JPK+gJmqSJrWdiogj1/OOeDOj01PpW/1wmG3XZ6jr/vlwBAYbZgOatb
   AHiAYtdDg7gpBNIX8gdOfFgLsKmKACBo5/H1kMmbW8uIT8M9S9CG4VabQ
   tS0oFzu9uMh7ekjMlHeS754fGGIafbG2FVt/aw4VbVeDBZcrpixefeFTf
   ekQ1YdDlZBAfzBqc3gjdGExlNjDJ6ylQ6uvjWYzKs401+0k484VHpGJI9
   g==;
X-CSE-ConnectionGUID: cPa/TTo0RCiOWCmJr6/cxQ==
X-CSE-MsgGUID: +T7nvRTvRtmjW21D7+iSTA==
X-IronPort-AV: E=McAfee;i="6800,10657,11459"; a="55249752"
X-IronPort-AV: E=Sophos;i="6.16,223,1744095600"; 
   d="scan'208";a="55249752"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 11:35:48 -0700
X-CSE-ConnectionGUID: ixoP7xaaR4iSuA13fzX3OA==
X-CSE-MsgGUID: lbI13HXhTZaOEsdzrFhVRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,223,1744095600"; 
   d="scan'208";a="151732458"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 11:35:47 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next 03/15] wifi: mac80211: verify state before connection
Date: Mon,  9 Jun 2025 21:35:15 +0300
Message-Id: <20250609213231.f616c7b693df.Ie983155627ad0d2e7c19c30ce642915246d0ed9d@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250609183527.3974138-1-miriam.rachel.korenblit@intel.com>
References: <20250609183527.3974138-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

ieee80211_prep_connection is supposed to be called when both bitmaps
(valid_links and active_links) are cleared.
Make sure of it and WARN if this is not the case, to avoid weird issues.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/mlme.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index d8953a855ab4..c8bf810ff5d8 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -8694,21 +8694,33 @@ static int ieee80211_prep_connection(struct ieee80211_sub_if_data *sdata,
 	bool have_sta = false;
 	bool mlo;
 	int err;
+	u16 new_links;
 
 	if (link_id >= 0) {
 		mlo = true;
 		if (WARN_ON(!ap_mld_addr))
 			return -EINVAL;
-		err = ieee80211_vif_set_links(sdata, BIT(link_id), 0);
+		new_links = BIT(link_id);
 	} else {
 		if (WARN_ON(ap_mld_addr))
 			return -EINVAL;
 		ap_mld_addr = cbss->bssid;
-		err = ieee80211_vif_set_links(sdata, 0, 0);
+		new_links = 0;
 		link_id = 0;
 		mlo = false;
 	}
 
+	if (assoc) {
+		rcu_read_lock();
+		have_sta = sta_info_get(sdata, ap_mld_addr);
+		rcu_read_unlock();
+	}
+
+	if (mlo && !have_sta &&
+	    WARN_ON(sdata->vif.valid_links || sdata->vif.active_links))
+		return -EINVAL;
+
+	err = ieee80211_vif_set_links(sdata, new_links, 0);
 	if (err)
 		return err;
 
@@ -8729,12 +8741,6 @@ static int ieee80211_prep_connection(struct ieee80211_sub_if_data *sdata,
 		goto out_err;
 	}
 
-	if (assoc) {
-		rcu_read_lock();
-		have_sta = sta_info_get(sdata, ap_mld_addr);
-		rcu_read_unlock();
-	}
-
 	if (!have_sta) {
 		if (mlo)
 			new_sta = sta_info_alloc_with_link(sdata, ap_mld_addr,
-- 
2.34.1


