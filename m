Return-Path: <linux-wireless+bounces-16992-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2A1D9FFA67
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Jan 2025 15:21:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC00B1883AC4
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Jan 2025 14:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0A391B6547;
	Thu,  2 Jan 2025 14:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dXPCgtim"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3431B3F30
	for <linux-wireless@vger.kernel.org>; Thu,  2 Jan 2025 14:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735827646; cv=none; b=rzVEaWd+z4rVXA/B7dTCq0EPOA1zDdo8CWOEkqmjZPkEFUds50LbpSqww+vDHeIWPtQrFTJLohKbLH7GgVx9orMNHbnFp88k8dDADRIoKiEr90jLDhfVx6cbGMLulfUhjwaXsEkMZA614TZ++Bl+l9Ko8E2Uk9u1NEPGRrVYWls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735827646; c=relaxed/simple;
	bh=DETo942FnqZ28bDGgiCZ/+4Dec3hfUumHdGDEXNW3wA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I2X94dexJphr7ZJriM8IHhGF3UQsUENdyOhar1ijq8nubrIV/7ylBD3owHZKYmwvkrxHjoUyunPbZCHvIrm63FLkDzAI70uP2AW/SLocr/CAkVjL/Gyqcj1sPxgjpuk8c5DWjqFgDU5msHULpNk95p4wrMCf59Yw7ofNXFhuYLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dXPCgtim; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735827645; x=1767363645;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DETo942FnqZ28bDGgiCZ/+4Dec3hfUumHdGDEXNW3wA=;
  b=dXPCgtimv3Be6Zj+KQkpFS94Lr1Rtt33SBtd/Uk514qhPNe1foohEZBl
   hg/MZe1yXbT39zDI9BdYjMn6ThWd/S+JHkZRSNGLi3x0Ipg5TLeyaUX4H
   kax2g5NIVU0xKHnLRpls8mjsp1c14J1duSpiR9OVB13/2rmwDJCNi6RIf
   fKCHG4eVsnw0BDfBvFTgmFILSh4SIqgVg/jXr9QAKcBYm1fLW9OwHyXUI
   sceAGbmkv5c8Ss5JZEaT+Y7T0kIjd3O1l3A89mPXLP5ZllikTnZpNkgKJ
   tL8tFM9NUxNsDe7xD09FwoEsch2qs7IH+ER5JKpJ44WQpdMMk3Sg2Kcj0
   w==;
X-CSE-ConnectionGUID: nfx3mPysSY+SngaJMWSw9A==
X-CSE-MsgGUID: oey7TotWSuC8txn47oq7nA==
X-IronPort-AV: E=McAfee;i="6700,10204,11302"; a="46735127"
X-IronPort-AV: E=Sophos;i="6.12,285,1728975600"; 
   d="scan'208";a="46735127"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2025 06:20:44 -0800
X-CSE-ConnectionGUID: YoKWt3vlRf2x1dV7XykFzg==
X-CSE-MsgGUID: f15OI0O2Q1+s2wgGUej+VA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,285,1728975600"; 
   d="scan'208";a="132357431"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2025 06:20:43 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 14/17] wifi: mac80211: don't flush non-uploaded STAs
Date: Thu,  2 Jan 2025 16:20:06 +0200
Message-Id: <20250102161730.e3d10970a7c7.I491bbcccc46f835ade07df0640a75f6ed92f20a3@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250102142009.3057049-1-miriam.rachel.korenblit@intel.com>
References: <20250102142009.3057049-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

If STA state is pre-moved to AUTHORIZED (such as in IBSS
scenarios) and insertion fails, the station is freed.
In this case, the driver never knew about the station,
so trying to flush it is unexpected and may crash.

Check if the sta was uploaded to the driver before and
fix this.

Fixes: d00800a289c9 ("wifi: mac80211: add flush_sta method")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/driver-ops.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/mac80211/driver-ops.h b/net/mac80211/driver-ops.h
index c64531e0a60e..5acecc7bd4a9 100644
--- a/net/mac80211/driver-ops.h
+++ b/net/mac80211/driver-ops.h
@@ -724,6 +724,9 @@ static inline void drv_flush_sta(struct ieee80211_local *local,
 	if (sdata && !check_sdata_in_driver(sdata))
 		return;
 
+	if (!sta->uploaded)
+		return;
+
 	trace_drv_flush_sta(local, sdata, &sta->sta);
 	if (local->ops->flush_sta)
 		local->ops->flush_sta(&local->hw, &sdata->vif, &sta->sta);
-- 
2.34.1


