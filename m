Return-Path: <linux-wireless+bounces-18501-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9B46A286CA
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Feb 2025 10:40:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0802A167BA8
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Feb 2025 09:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B16122ACFA;
	Wed,  5 Feb 2025 09:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ghAwKoxQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D2C22A809
	for <linux-wireless@vger.kernel.org>; Wed,  5 Feb 2025 09:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738748398; cv=none; b=nY3t6XVd8oxr599NzPmMazvl8FgBo8LLBIqa50S/lVg7Hvmyoi+iMvlUIuxOzs72+1D8YQaXq2+Rn95KmNvhwXc7eHtwZwZN3bBJb4780Y7bmst8qP6Xn7kb/vhcv/P1OI4p9AVoan19vYdIQmKi8Yjn8qcQupieOqR50hMikJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738748398; c=relaxed/simple;
	bh=e3/mHnTAuXyZN/A9ohxIHcpjB3/hv4A7Iiq91DKrGTw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LC+fvHF/wa8bsEXphVoR95YnupAUUWMPQPPZ0GF9o5xk2bAVHpts55uZZGbY0lIl89SlCEfuKEvoVURuk9bh1cL3o63dBW6qyx//mNmP8t329WQx+VNLyIW0ZBC+UhGOfL71GSQGevYZIa7f4OZja+vJpEhGY7oYAoCj/9LuqkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ghAwKoxQ; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738748397; x=1770284397;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=e3/mHnTAuXyZN/A9ohxIHcpjB3/hv4A7Iiq91DKrGTw=;
  b=ghAwKoxQdNPGH2u1hO3SekihxFHhOSKD3uixFVruuZCvq0LTHlHyne8U
   LH5xi1ik3stpoIPFOKMeNVI4mMJToT4PAuDio/+T0k2HTiikUCs8sEdPH
   fviTUrUDY5Hd7zsqh2PjsvEJuMQqfSzqFMgtZfcJp/lxB0dvQ1OOnDydb
   eZG268pWr7FVckNa/kagZjqWXD0ItJ/cCzZnISIyjRZ3V3rs8AiFlXi3C
   49JHAOBGGKr/SYPRUmk50D8goAEj4/11Li/6yW3bj6gxJZgRNu2ucdaBh
   2GdeLM5D2V5NlD6fuZsKBmWo07vaU1W/bvRFERO+EYXwtlsn/Rh9pfORn
   A==;
X-CSE-ConnectionGUID: 0eKRiAh/Tf2B4hi3iH9RVA==
X-CSE-MsgGUID: FkDZBR9mQ4mqC+9DC9rllA==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="43225226"
X-IronPort-AV: E=Sophos;i="6.13,261,1732608000"; 
   d="scan'208";a="43225226"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 01:39:56 -0800
X-CSE-ConnectionGUID: azcsSaiVQkiM9TsyJvJ40w==
X-CSE-MsgGUID: LOL/5MesS8eybQ51LCetfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,261,1732608000"; 
   d="scan'208";a="115845290"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 01:39:53 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 07/17] wifi: mac80211_hwsim: enable strict mode
Date: Wed,  5 Feb 2025 11:39:17 +0200
Message-Id: <20250205110958.85bee694f09c.I61ec37d20fe97699d47fce252dc4ae2e4475fc51@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250205093927.1775858-1-miriam.rachel.korenblit@intel.com>
References: <20250205093927.1775858-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Since we use hwsim for testing e.g. the hostapd implementation,
enable strict mode to catch errors that would otherwise not be
caught.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/virtual/mac80211_hwsim.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/net/wireless/virtual/mac80211_hwsim.c
index cf6a331d4042..d0d9dab7f11f 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
@@ -5345,6 +5345,7 @@ static int mac80211_hwsim_new_radio(struct genl_info *info,
 	ieee80211_hw_set(hw, REPORTS_TX_ACK_STATUS);
 	ieee80211_hw_set(hw, TDLS_WIDER_BW);
 	ieee80211_hw_set(hw, SUPPORTS_MULTI_BSSID);
+	ieee80211_hw_set(hw, STRICT);
 
 	if (param->mlo) {
 		hw->wiphy->flags |= WIPHY_FLAG_SUPPORTS_MLO;
-- 
2.34.1


