Return-Path: <linux-wireless+bounces-5055-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 37D63881915
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 22:28:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC341B23249
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 21:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A17F85951;
	Wed, 20 Mar 2024 21:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mHs9Xk5G"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE71485C65
	for <linux-wireless@vger.kernel.org>; Wed, 20 Mar 2024 21:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710970036; cv=none; b=D5IiqkRAROjpwXruQb28JZb3hOaZ+AjSm1NBEXMtnW/RlbnL0OtrhxwtT7jv1sMNZuCsZBKBf0i/9whWLjDlGi8FkFBmpoPioWVqQXnL/YpRvoZcrHwcYn9XmyKWbItrmOaWaBWwrHRdgok26GbHXWX8BGEULzLUCXqsP2RNdek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710970036; c=relaxed/simple;
	bh=YSBUIhPrA7wrXcRXy005UgiygbYmj01MsO26cVHOwMg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f5GXQVv6SKRPvJmeTAYoMNct/rD72UOxu1BsnUENXq7VXS8Hn5i5ewVWWDeuOTqslk/iqo52jR9YTOUAl9updZ4Aa/R+xY1yVXqxtL8gIhjJhBKc4+oL9c1IMKW9it88i+M+0Rq3VtcX1crqlS8PSsdercpsJ3zkGZD7lid7LQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mHs9Xk5G; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710970034; x=1742506034;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YSBUIhPrA7wrXcRXy005UgiygbYmj01MsO26cVHOwMg=;
  b=mHs9Xk5GfHtn5EyqFZtxst89vk0qsybFA/1iQ2dyNTo57RL86BOUEeJk
   d7eYLmRwDBIK8RtruaS6vt91FehvRjd2V6NJtgIHnv4ZO90UtW2LVx4fJ
   p8iFxfyuGsrPgQuzYjaDBejExswcAwlzHPhyx1wSFljXTiqRIgLw75ckj
   VaNg6ZJC9j6+8AJhv2rGAk5Uz+TnaC13CTnFHFlnfHFaO3frw2JBWrx+S
   x0aXRyAkAowyZpuk7kYko9o5zi9QNEQ4D5hJzL5kmLbeYdVLvUDOmtgYj
   GHwS6s1dX8L+hv6D648YwPAzV8+lJrlStFFs5TTaldxMSM5Xw2pyPCDQ3
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11019"; a="9698118"
X-IronPort-AV: E=Sophos;i="6.07,141,1708416000"; 
   d="scan'208";a="9698118"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 14:27:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,141,1708416000"; 
   d="scan'208";a="14184184"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 14:27:13 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH 12/17] wifi: iwlwifi: mvm: Declare HE/EHT capabilities support for P2P interfaces
Date: Wed, 20 Mar 2024 23:26:33 +0200
Message-Id: <20240320232419.37fdea8e55a3.If074bdc6c6cd55b76c3421417a987d21ab6bb041@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240320212638.1446082-1-miriam.rachel.korenblit@intel.com>
References: <20240320212638.1446082-1-miriam.rachel.korenblit@intel.com>
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
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
index 03ff6ee546ce..149903f52567 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
@@ -599,7 +599,8 @@ static const u8 iwl_vendor_caps[] = {
 
 static const struct ieee80211_sband_iftype_data iwl_he_eht_capa[] = {
 	{
-		.types_mask = BIT(NL80211_IFTYPE_STATION),
+		.types_mask = BIT(NL80211_IFTYPE_STATION) |
+			      BIT(NL80211_IFTYPE_P2P_CLIENT),
 		.he_cap = {
 			.has_he = true,
 			.he_cap_elem = {
@@ -755,7 +756,8 @@ static const struct ieee80211_sband_iftype_data iwl_he_eht_capa[] = {
 		},
 	},
 	{
-		.types_mask = BIT(NL80211_IFTYPE_AP),
+		.types_mask = BIT(NL80211_IFTYPE_AP) |
+			      BIT(NL80211_IFTYPE_P2P_GO),
 		.he_cap = {
 			.has_he = true,
 			.he_cap_elem = {
@@ -908,7 +910,8 @@ iwl_nvm_fixup_sband_iftd(struct iwl_trans *trans,
 			 u8 tx_chains, u8 rx_chains,
 			 const struct iwl_fw *fw)
 {
-	bool is_ap = iftype_data->types_mask & BIT(NL80211_IFTYPE_AP);
+	bool is_ap = iftype_data->types_mask & (BIT(NL80211_IFTYPE_AP) |
+						BIT(NL80211_IFTYPE_P2P_GO));
 	bool no_320;
 
 	no_320 = (!trans->trans_cfg->integrated &&
-- 
2.34.1


