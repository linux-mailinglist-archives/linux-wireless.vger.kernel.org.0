Return-Path: <linux-wireless+bounces-8531-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAD1A8FC98B
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Jun 2024 12:58:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D3F6B22BC9
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Jun 2024 10:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D1B4192B6D;
	Wed,  5 Jun 2024 10:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BEHiHXdo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056F71922E7
	for <linux-wireless@vger.kernel.org>; Wed,  5 Jun 2024 10:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717585056; cv=none; b=BFoM7uj9uwP8DNKhhuAsgShaqjGFT+TNVLMcTj3zaxt4bVC8VftwXl7NCLzyAlxcnfi9hil93SXGMFXTq0ozQFX5XSG0iWqXtWFVakvi37ZqxLEhMmdFmmMVsvic2Zuqh6T727G+Zl8QQNxDr5WIC53X/UzAHIU/PhvW93ksY2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717585056; c=relaxed/simple;
	bh=KM/m/ZCX4S9OiNRm4UNazr5uMdahk3wtZUHrJlE7pBk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SOUtWM5BQX8LB4BDBKpDnHhiPEnH4zS7ityXkrOCOaC0D4I31xzKrWFziioKCZU1HRky4urJkJc40uGQ//Y9covsm5saedlhpOJ2mEvc/ruywXa6JJFhiAYU9HEsoZE3SULGcibh1AXIMbVD5g+4U1bDJXH8gc4LhuweQZf+LTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BEHiHXdo; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717585055; x=1749121055;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KM/m/ZCX4S9OiNRm4UNazr5uMdahk3wtZUHrJlE7pBk=;
  b=BEHiHXdocePOUdwRLONmB3D9N5mWJ2rUOtB9OykRBRUHn2NJakK67WuA
   3S5oX0LIQwhnbVeU1fggRXFvfNypynEOTV1fQtzMRR243hw9rcyQtDEmx
   EQBb7sihji1oFnGb03d5l5oOR/9AY2xFwt7bKAxrsP55dDUnPCsjZFXrd
   xLsxjCZNTUVArc2k5Yc0WiO0Ehs3XmCgIkrBLMdmOE9N9Jufkka9laVJv
   CHFSo4opC9Gu0U8CzH3iomW8ss+cVTDp7meNQpErkQjKdZutcj7VttGIn
   vLagdqF36uOK9T7oyX5QUr0AcOCbcb4LG7SR3uzvf5nE2WqxFFqhXtB29
   A==;
X-CSE-ConnectionGUID: +kUdUa8EQZ+NQmKZ+CXRww==
X-CSE-MsgGUID: vL1/98PXSd+lAQj3V6eRkg==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="11919955"
X-IronPort-AV: E=Sophos;i="6.08,216,1712646000"; 
   d="scan'208";a="11919955"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 03:57:35 -0700
X-CSE-ConnectionGUID: Wtw81o55R0Sz2wJYvlbErg==
X-CSE-MsgGUID: 6chxHtBPTr2c4cXvVnPEmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,216,1712646000"; 
   d="scan'208";a="37563016"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 03:57:34 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 4/7] wifi: mac80211: clean up 'ret' in sta_link_apply_parameters()
Date: Wed,  5 Jun 2024 13:57:19 +0300
Message-Id: <20240605135233.eb7a24632d98.I72d7fe1da89d4b89bcfd0f5fb9057e3e69355cfe@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240605105722.2034610-1-miriam.rachel.korenblit@intel.com>
References: <20240605105722.2034610-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

There's no need to have the always-zero ret variable in
the function scope, move it into the inner scope only.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/cfg.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 54b03a86f71e..890590146fa4 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1825,7 +1825,6 @@ static int sta_link_apply_parameters(struct ieee80211_local *local,
 				     enum sta_link_apply_mode mode,
 				     struct link_station_parameters *params)
 {
-	int ret = 0;
 	struct ieee80211_supported_band *sband;
 	struct ieee80211_sub_if_data *sdata = sta->sdata;
 	u32 link_id = params->link_id < 0 ? 0 : params->link_id;
@@ -1876,6 +1875,8 @@ static int sta_link_apply_parameters(struct ieee80211_local *local,
 	}
 
 	if (params->txpwr_set) {
+		int ret;
+
 		link_sta->pub->txpwr.type = params->txpwr.type;
 		if (params->txpwr.type == NL80211_TX_POWER_LIMITED)
 			link_sta->pub->txpwr.power = params->txpwr.power;
@@ -1928,7 +1929,7 @@ static int sta_link_apply_parameters(struct ieee80211_local *local,
 
 	ieee80211_sta_init_nss(link_sta);
 
-	return ret;
+	return 0;
 }
 
 static int sta_apply_parameters(struct ieee80211_local *local,
-- 
2.34.1


