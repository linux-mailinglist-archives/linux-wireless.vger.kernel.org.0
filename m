Return-Path: <linux-wireless+bounces-27315-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33B2EB5730A
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Sep 2025 10:35:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87A6C18890CC
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Sep 2025 08:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05D082EFD86;
	Mon, 15 Sep 2025 08:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mMGbyrDJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA252EF665
	for <linux-wireless@vger.kernel.org>; Mon, 15 Sep 2025 08:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757925306; cv=none; b=oi97dbMPkEePWrWshGWyoz4ZcF+6NdPp7rLOfFdNoR8LiaIHwvf57mtyKwiruxrtJPWZHOsATCJ7AvTKqy2fvYUzpBcAPgr9C6MqyBvUDX9um+Y40e4wFh6U4xDnPfYfAuDzuIFeC+YExqEQBBnQ9ALj/UqprTfDHLM94F1ehN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757925306; c=relaxed/simple;
	bh=8TmWSqUAkIey7Gqqy2J2MS5M6sVhM6fwXgvZiFhv59s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hGgyi2S8Zm/M4srAcCM39iZY4pkXuz0sJrj7rhZmaHtRhoPd+LAcoil66WHibWhUChgxUmwamCFr1czbKErCIGc8XShq0dE4YLgBIUzRH+FED/3l8YLqkiuFF3LPmsiaM+uhcyjYlr4LuJr2V98XA9Ss3SfpTj7cbk03KI2RcTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mMGbyrDJ; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757925305; x=1789461305;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8TmWSqUAkIey7Gqqy2J2MS5M6sVhM6fwXgvZiFhv59s=;
  b=mMGbyrDJCMd0CaY5pabE/X/Ks1IDLUYUJjQgnECyEIZGDUdKb5pLXyVb
   A3PLz2uwh0Y6OoxDNFsy+LI75BkF+RHCiq1k6Bjl5oV1NzosKr7xv2dVY
   MqeBZ7WMUke8Q4a4f/Wr52idAeXJaz6LdCIgTULUZep1wRYpme/3EbpS4
   QZiXyFA0yA7cjlWuVSAboXlLys55mummxv/o3R1u/qPdAagYv9zImPER/
   r+4jwCU4n8TyFzqbyG6jMVsriO0TgdXAFIf2p3IZLCqpdD7R+PDuAzqJ6
   ST2t0ka4dOIIoTr3KU2R52IanHzmpnjqtzRosVroAuf8erc06WIcHm3sA
   A==;
X-CSE-ConnectionGUID: fAPTpTOWTv2W6lGEl0d6JQ==
X-CSE-MsgGUID: 8htE6XOmRBuV6ss8UUKLEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11553"; a="59213072"
X-IronPort-AV: E=Sophos;i="6.18,265,1751266800"; 
   d="scan'208";a="59213072"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2025 01:35:05 -0700
X-CSE-ConnectionGUID: rHzkGInqQV2Z+ic/g9CGng==
X-CSE-MsgGUID: 77V2EDVvST+2PY0LMpQLQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,265,1751266800"; 
   d="scan'208";a="178569866"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2025 01:35:04 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 03/11] wifi: iwlwifi: mld: reschedule check_tpt_wk also not in EMLSR
Date: Mon, 15 Sep 2025 11:34:24 +0300
Message-Id: <20250915113137.2a9cf2b2529d.I8284c0da9597e4c963e38ae133384f6f42044499@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250915083432.1048608-1-miriam.rachel.korenblit@intel.com>
References: <20250915083432.1048608-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

When the throughput count reaches the threshold, EMLSR is no longer
blocked by throughput.
This doesn't mean that EMLSR will be activated immediately, since there
might be other reasons that block EMLSR.

When the throughput blocker is not set, check_tpt_wk should run every 5
seconds and check if the throughput blocker should be set (if the
throughtput counter dropped).
If not, it should reschedule itself.

In the current code, the worker will reschedule itself only if we are in
EMLSR. This is wrong, since we might be in a case where the throughput
blocker is not set but we are not in EMLSR, and then we will never check
again the throughput counters (and block EMLSR if needed).

Fix this by rescheduling the worker also when EMLSR is not active.

Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/mlo.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mlo.c b/drivers/net/wireless/intel/iwlwifi/mld/mlo.c
index 241a6271d13d..fa04fbe06656 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mlo.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mlo.c
@@ -603,7 +603,7 @@ void iwl_mld_emlsr_check_tpt(struct wiphy *wiphy, struct wiphy_work *wk)
 
 	/* EMLSR is not active */
 	if (sec_link_id == -1)
-		return;
+		goto schedule;
 
 	IWL_DEBUG_INFO(mld, "Secondary Link %d: Tx MPDUs: %ld. Rx MPDUs: %ld\n",
 		       sec_link_id, sec_link_tx, sec_link_rx);
@@ -625,6 +625,7 @@ void iwl_mld_emlsr_check_tpt(struct wiphy *wiphy, struct wiphy_work *wk)
 		return;
 	}
 
+schedule:
 	/* Check again when the next window ends  */
 	wiphy_delayed_work_queue(mld_vif->mld->wiphy,
 				 &mld_vif->emlsr.check_tpt_wk,
-- 
2.34.1


