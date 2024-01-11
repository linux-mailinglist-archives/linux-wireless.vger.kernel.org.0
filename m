Return-Path: <linux-wireless+bounces-1727-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B8C182B2BA
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jan 2024 17:20:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A2DC1C22F39
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jan 2024 16:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2123D42066;
	Thu, 11 Jan 2024 16:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="leIEvn6B"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7F64F889
	for <linux-wireless@vger.kernel.org>; Thu, 11 Jan 2024 16:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704989904; x=1736525904;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=A8Kz8Qa2DDI0a0eZKuRKxQJpuKnhmJBWjEFF9XHZ0Y0=;
  b=leIEvn6BO+qT7eOYYRAtCcHWb/5ItJSUtAH42BEoJhWcgiJi+AD73LYn
   Bj7kDSvH+NVno1vHQELo8b2g1Xn5gKDOYb05njR4Ary4Yv/aHEZakWAyk
   vag0CkRq1sA9L8395i2+nFsGgyMnIMmluR9vaBsYksN44sKYkbPly7xz/
   DwvN75xXg/8/HMosd/Vt4kMO+HKYGg63wceEusqPjf3yTL2h2cFNYS5O5
   FqdUNQvF3QS3ZqfN1VumI29/b910cmX/RAHTd/DZpNyBxpebbWQid7iHn
   KmcFQuSYs6rtbjKZxcolLAQB/0KgISP/hkXfyEK4nXandVGVwbhywjy9v
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10950"; a="463182479"
X-IronPort-AV: E=Sophos;i="6.04,186,1695711600"; 
   d="scan'208";a="463182479"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2024 08:18:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10950"; a="1029606458"
X-IronPort-AV: E=Sophos;i="6.04,186,1695711600"; 
   d="scan'208";a="1029606458"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2024 08:18:10 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>,
	Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH 1/8] wifi: mac80211_hwsim: advertise 15 simultaneous links
Date: Thu, 11 Jan 2024 18:17:39 +0200
Message-Id: <20240111181514.52a1d48b67e6.Ie459df742944d24d6401683d54d2f3ac44834803@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240111161746.3978601-1-miriam.rachel.korenblit@intel.com>
References: <20240111161746.3978601-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Advertise MLD capabilities and operations in AP mode that
say that up to 15 links are supported simultaneously.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Gregory Greenman <gregory.greenman@intel.com>
Reviewed-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/virtual/mac80211_hwsim.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/net/wireless/virtual/mac80211_hwsim.c
index 304dc96fc3bb..403d892c0468 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
@@ -4993,9 +4993,11 @@ static const u8 iftypes_ext_capa_ap[] = {
 	 [9] = WLAN_EXT_CAPA10_TWT_RESPONDER_SUPPORT,
 };
 
-#define MAC80211_HWSIM_MLD_CAPA_OPS FIELD_PREP_CONST( \
-	IEEE80211_MLD_CAP_OP_TID_TO_LINK_MAP_NEG_SUPP, \
-	IEEE80211_MLD_CAP_OP_TID_TO_LINK_MAP_NEG_SUPP_SAME)
+#define MAC80211_HWSIM_MLD_CAPA_OPS				\
+	FIELD_PREP_CONST(IEEE80211_MLD_CAP_OP_TID_TO_LINK_MAP_NEG_SUPP, \
+			 IEEE80211_MLD_CAP_OP_TID_TO_LINK_MAP_NEG_SUPP_SAME) | \
+	FIELD_PREP_CONST(IEEE80211_MLD_CAP_OP_MAX_SIMUL_LINKS, \
+			 IEEE80211_MLD_MAX_NUM_LINKS - 1)
 
 static const struct wiphy_iftype_ext_capab mac80211_hwsim_iftypes_ext_capa[] = {
 	{
-- 
2.34.1


