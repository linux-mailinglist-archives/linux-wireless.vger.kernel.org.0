Return-Path: <linux-wireless+bounces-4946-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F7E880BC9
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 08:14:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20B0D1C224E8
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 07:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F7712CCA4;
	Wed, 20 Mar 2024 07:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O0cRlVMI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2AB42C6BB
	for <linux-wireless@vger.kernel.org>; Wed, 20 Mar 2024 07:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710918865; cv=none; b=pbx9cMXudzOrA//Sg749ZZC9wv6gWxdAJNVQcKP7MxvYvQrZkKqmLsq5k4C3/PD+y96XhBB2Jd/iyrtAA5192J/0FyE0/hojxkGZz22AlC4ZY2NhUctegEDzBe8NHzSSdvBTT5iK+0xlsQnYojDDL2JHjLij6LhyG9neH+jjeSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710918865; c=relaxed/simple;
	bh=tTL/viAfyjiu0dYZw/j1lxbLsfKv/fvkE2mrf9/csu4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CiW7JGOfApxSLK7+5d1bncRk8sKMj3zYvgSb0oPq3oniMGpTF480Pp/gy8degxlALsPd0ExIs7uBMIfedd2HIIwxrPMBq/tEudals2TU9ryy8T1zo8gdIUB+QJRHwHGrskMAtCrAc1BAjCvdqzlk11Mbez9mTzD6iRZYNWhK2O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O0cRlVMI; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710918864; x=1742454864;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tTL/viAfyjiu0dYZw/j1lxbLsfKv/fvkE2mrf9/csu4=;
  b=O0cRlVMIPPvB0Ub3TjxMQW0dhhpsCDE0FyEV1uIfWOOT2BtwUvSrR1NM
   1eBdEyk1jn441xXAbgC4mm5XdYB6EBalde5Q2oWa8vzfZDCTVc6OYWvyv
   a7DNY9V8fZc0xlEFyDZ3+jI6tOW2CkDvd8lfLv6B87InUrcbU/oEQ4iX7
   CHStUH7mFa0hPPNBuMiXgq3JWpa+XQemoYyM9faGCSyrufACw+KTT5HKs
   jDbUW2xKSjMtnApLmD6JrwRaBzJl7/YXHFqy4VhTPqHxqptvdcTuuBrGH
   zxWS+FspyGRh4hKiN81CPYQekaq3fs5l1leJEhLJ9txRpaeVkxiP314Jw
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11018"; a="5763834"
X-IronPort-AV: E=Sophos;i="6.07,139,1708416000"; 
   d="scan'208";a="5763834"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 00:14:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,139,1708416000"; 
   d="scan'208";a="14477407"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 00:14:21 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Ilan Peer <ilan.peer@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 4/8] wifi: mac80211_hwsim: Declare HE/EHT capabilities support for P2P interfaces
Date: Wed, 20 Mar 2024 09:14:01 +0200
Message-Id: <20240320091155.73ae309d27c2.I31ef6af2f1ebf54281858e2f63afcb10b61985fe@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240320071405.815427-1-miriam.rachel.korenblit@intel.com>
References: <20240320071405.815427-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Ilan Peer <ilan.peer@intel.com>

Declare HE/EHT capabilities support also for P2P client and P2P GO
interface types.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/virtual/mac80211_hwsim.c | 20 +++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/net/wireless/virtual/mac80211_hwsim.c
index 450913cf6583..30acd78926a6 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
@@ -4125,7 +4125,8 @@ static void hwsim_mcast_new_radio(int id, struct genl_info *info,
 
 static const struct ieee80211_sband_iftype_data sband_capa_2ghz[] = {
 	{
-		.types_mask = BIT(NL80211_IFTYPE_STATION),
+		.types_mask = BIT(NL80211_IFTYPE_STATION) |
+			      BIT(NL80211_IFTYPE_P2P_CLIENT),
 		.he_cap = {
 			.has_he = true,
 			.he_cap_elem = {
@@ -4232,7 +4233,8 @@ static const struct ieee80211_sband_iftype_data sband_capa_2ghz[] = {
 		},
 	},
 	{
-		.types_mask = BIT(NL80211_IFTYPE_AP),
+		.types_mask = BIT(NL80211_IFTYPE_AP) |
+			      BIT(NL80211_IFTYPE_P2P_GO),
 		.he_cap = {
 			.has_he = true,
 			.he_cap_elem = {
@@ -4383,8 +4385,8 @@ static const struct ieee80211_sband_iftype_data sband_capa_2ghz[] = {
 
 static const struct ieee80211_sband_iftype_data sband_capa_5ghz[] = {
 	{
-		/* TODO: should we support other types, e.g., P2P? */
-		.types_mask = BIT(NL80211_IFTYPE_STATION),
+		.types_mask = BIT(NL80211_IFTYPE_STATION) |
+			      BIT(NL80211_IFTYPE_P2P_CLIENT),
 		.he_cap = {
 			.has_he = true,
 			.he_cap_elem = {
@@ -4508,7 +4510,8 @@ static const struct ieee80211_sband_iftype_data sband_capa_5ghz[] = {
 		},
 	},
 	{
-		.types_mask = BIT(NL80211_IFTYPE_AP),
+		.types_mask = BIT(NL80211_IFTYPE_AP) |
+			      BIT(NL80211_IFTYPE_P2P_GO),
 		.he_cap = {
 			.has_he = true,
 			.he_cap_elem = {
@@ -4679,8 +4682,8 @@ static const struct ieee80211_sband_iftype_data sband_capa_5ghz[] = {
 
 static const struct ieee80211_sband_iftype_data sband_capa_6ghz[] = {
 	{
-		/* TODO: should we support other types, e.g., P2P? */
-		.types_mask = BIT(NL80211_IFTYPE_STATION),
+		.types_mask = BIT(NL80211_IFTYPE_STATION) |
+			      BIT(NL80211_IFTYPE_P2P_CLIENT),
 		.he_6ghz_capa = {
 			.capa = cpu_to_le16(IEEE80211_HE_6GHZ_CAP_MIN_MPDU_START |
 					    IEEE80211_HE_6GHZ_CAP_MAX_AMPDU_LEN_EXP |
@@ -4825,7 +4828,8 @@ static const struct ieee80211_sband_iftype_data sband_capa_6ghz[] = {
 		},
 	},
 	{
-		.types_mask = BIT(NL80211_IFTYPE_AP),
+		.types_mask = BIT(NL80211_IFTYPE_AP) |
+			      BIT(NL80211_IFTYPE_P2P_GO),
 		.he_6ghz_capa = {
 			.capa = cpu_to_le16(IEEE80211_HE_6GHZ_CAP_MIN_MPDU_START |
 					    IEEE80211_HE_6GHZ_CAP_MAX_AMPDU_LEN_EXP |
-- 
2.34.1


