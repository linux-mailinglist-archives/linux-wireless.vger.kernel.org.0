Return-Path: <linux-wireless+bounces-2724-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CAF9841340
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 20:22:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29D84287DDC
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 19:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AC094C637;
	Mon, 29 Jan 2024 19:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jb1hN88i"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B17048790
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jan 2024 19:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706556146; cv=none; b=Td0VVwSGrNtXCleLRpYeNQez599vww5awtf3jirNWa9TtFEiPUorZwIYkQF2B+qEWQJpPuZJ3Ra1fokDkoIDDbK9whJeUwKzFjnE9Q9lI8uKEFHpW7O4CkPZxcrsdKiHKEvdkhpFDANhHuo1FozEA21K6z+/+vQECOmoDjx+F2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706556146; c=relaxed/simple;
	bh=ejLnDNNdfVtGVvRUyZvvbi0tx+hNy9zTWm5AkPVZRYs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TDQ3dnW8A9YQZndyPVlfNW1BPzjNcPZ0i7LWLFPl3QYYLONn5QCUUBaGHzf0HC3dSHeySeAVU8GHZDLoB56U9P4Fa3i1dXGd1kB+l5QLOl8IhREIxGBygkvEqAISvH2hWLpZzMzEEQGrr+G4YdG7IIgveYozid/KTwZ7I+G10qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jb1hN88i; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706556145; x=1738092145;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ejLnDNNdfVtGVvRUyZvvbi0tx+hNy9zTWm5AkPVZRYs=;
  b=jb1hN88iP/eaGvUJYHGA6LSwzOpIe/oSqOxi3yedh9K+myXyjOvcbwYq
   qhCd4ajTYVRuJDrrnMA9K1uA5hzcgMu3h3vYZd5zoJ3It9r4ObLQCHrLS
   2xfKQJXYRLUdwopdmjB/vslE1sgTL2yVEqEUWUMrr2VCW1TucyQUXeuTQ
   X2wjNYZBPT5URhzSvxLSaJP5x25aCkDQ0DNe0zJXuafh8P/hO3H2W0KQE
   h04wpsnw2sKC5faMWHO57KPqmONMBismOtpkIKfxA1JQpidngbMrxPeAf
   rBDF09/JhcV7uDxb7yfYkTjBaZKS6TpKPOlLi8KttOIRJFozhV0h9wefJ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="2942964"
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="2942964"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 11:22:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="3459068"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 11:22:22 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 03/15] wifi: iwlwifi: mvm: d3: fix IPN byte order
Date: Mon, 29 Jan 2024 21:21:51 +0200
Message-Id: <20240129211905.138ed8a698e3.I1b66c386e45b5392696424ec636474bff86fd5ef@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240129192203.4189915-1-miriam.rachel.korenblit@intel.com>
References: <20240129192203.4189915-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

The IPN is reported by the firmware in 6 bytes little endian,
but mac80211 expects big endian so it can do memcmp() on it.
We used to store this as a u64 which was filled in the right
way, but never used. When implementing that it's used, we
changed it to just be 6 bytes, but lost the conversion. Add
it back.

Fixes: 04f78e242fff ("wifi: iwlwifi: mvm: Add support for IGTK in D3 resume flow")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Gregory Greenman <gregory.greenman@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index 61aeb7f6604b..6ab9def2c670 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -2194,7 +2194,10 @@ static void iwl_mvm_convert_gtk_v3(struct iwl_wowlan_status_data *status,
 static void iwl_mvm_convert_igtk(struct iwl_wowlan_status_data *status,
 				 struct iwl_wowlan_igtk_status *data)
 {
+	int i;
+
 	BUILD_BUG_ON(sizeof(status->igtk.key) < sizeof(data->key));
+	BUILD_BUG_ON(sizeof(status->igtk.ipn) != sizeof(data->ipn));
 
 	if (!data->key_len)
 		return;
@@ -2206,7 +2209,10 @@ static void iwl_mvm_convert_igtk(struct iwl_wowlan_status_data *status,
 		+ WOWLAN_IGTK_MIN_INDEX;
 
 	memcpy(status->igtk.key, data->key, sizeof(data->key));
-	memcpy(status->igtk.ipn, data->ipn, sizeof(data->ipn));
+
+	/* mac80211 expects big endian for memcmp() to work, convert */
+	for (i = 0; i < sizeof(data->ipn); i++)
+		status->igtk.ipn[i] = data->ipn[sizeof(data->ipn) - i - 1];
 }
 
 static void iwl_mvm_convert_bigtk(struct iwl_wowlan_status_data *status,
-- 
2.34.1


