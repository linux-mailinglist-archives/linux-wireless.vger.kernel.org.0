Return-Path: <linux-wireless+bounces-18528-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD251A28B05
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Feb 2025 13:57:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB7EB3A867A
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Feb 2025 12:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1889CA52;
	Wed,  5 Feb 2025 12:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l03kVC6c"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F8F8F5E
	for <linux-wireless@vger.kernel.org>; Wed,  5 Feb 2025 12:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738760183; cv=none; b=DA8V9bcKv3oRwGMKeAWThNN7YnMALLiplRB3kE4R3+/1tRXQGLi35nb+ZGxgB2eQLPkjU0C5687TbrJ34nEhMZ/dCAtMfFLReCfKm7ptIwk/Yd1ry0m/wbvE8WO+K0WR5PicboQxZhLdfwK08vJLRhkgY0J/75QIp2Dt9H4IvhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738760183; c=relaxed/simple;
	bh=VgdvNMbUd8zRetztX5DAn3y7qvWLfBEXrZDxsF0q78U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kpde2HJ+YBcdTJnsVl04Kv/eLOIDwGAnKSxiLohGzHBdY0UcdXkjq/EuSOybYvTAZTqg1k84EpYmZmtEWcWAihq2INvW46WeTJMhu4p2qxuQZFnrC15a/4w4wT1kybxgyuj9YKDRWBGAxGvCDyYpq4PLbPOmHzdeLP+NQr7aPdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l03kVC6c; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738760182; x=1770296182;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VgdvNMbUd8zRetztX5DAn3y7qvWLfBEXrZDxsF0q78U=;
  b=l03kVC6ctalsxVwIIroNI3x4YyJaFiS/JAF+gAasoD0zvgiJt6fjROW1
   Jg82jWDm9u2/QqEZGXQ1Nr0IWYtIqhmiA4ZmdPFe3qoSyDmdLOuQZDKse
   8icKE7NYm5tk1MA9vGzXDPhrgsTk5lLJm+uwFor4DIJF1aYMC0GoTMEEY
   xaBxPDhBTJoiVMV0qnIEtMMKooPRA6JMyU2nsYqROOUiBFy8bWE2EDThj
   MZxiPfKs4Dq3hnYLHMKg6UIE2bbnZbu4dD68PpdVsiKbQeHbWdE1r6VVo
   cnbUHx7VRP6TOx1zJ4GG53gpZQrQa8oJGbgcZ3hKSuriZvc0KY+YTmP/b
   Q==;
X-CSE-ConnectionGUID: fyZqBhTQSvOTdJDk7OSeAw==
X-CSE-MsgGUID: WwJXNcqTTbmUxIYpreWmFg==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="42159202"
X-IronPort-AV: E=Sophos;i="6.13,261,1732608000"; 
   d="scan'208";a="42159202"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 04:56:22 -0800
X-CSE-ConnectionGUID: Vfa26HfURgeRsrWu1Cc7sw==
X-CSE-MsgGUID: QHNe8bRiSb2498YJ8CnHUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="110745476"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 04:56:21 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH 10/19] wifi: iwlwifi: mvm: Indicate support link reconfiguration
Date: Wed,  5 Feb 2025 14:55:39 +0200
Message-Id: <20250205145347.92d19705d2b9.Id07fa3ebad6bc23ecf6e91868f67150ce70f47b0@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250205125548.1963070-1-miriam.rachel.korenblit@intel.com>
References: <20250205125548.1963070-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Ilan Peer <ilan.peer@intel.com>

As MLO link configuration is supported by mac80211, indicate
support for MLO link reconfiguration in station mode.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
----------------
depends on "wifi: ieee80211: Add some missing MLO related definitions"
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index af6644b7e95f..014777c9cc5d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -272,9 +272,10 @@ static const u8 tm_if_types_ext_capa_sta[] = {
 					__bf_shf(IEEE80211_EML_CAP_EMLSR_PADDING_DELAY) | \
 				 IEEE80211_EML_CAP_EMLSR_TRANSITION_DELAY_64US << \
 					__bf_shf(IEEE80211_EML_CAP_EMLSR_TRANSITION_DELAY))
-#define IWL_MVM_MLD_CAPA_OPS FIELD_PREP_CONST( \
+#define IWL_MVM_MLD_CAPA_OPS (FIELD_PREP_CONST( \
 			IEEE80211_MLD_CAP_OP_TID_TO_LINK_MAP_NEG_SUPP, \
-			IEEE80211_MLD_CAP_OP_TID_TO_LINK_MAP_NEG_SUPP_SAME)
+			IEEE80211_MLD_CAP_OP_TID_TO_LINK_MAP_NEG_SUPP_SAME) | \
+			IEEE80211_MLD_CAP_OP_LINK_RECONF_SUPPORT)
 
 static const struct wiphy_iftype_ext_capab add_iftypes_ext_capa[] = {
 	{
-- 
2.34.1


