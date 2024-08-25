Return-Path: <linux-wireless+bounces-11916-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 815D395E44B
	for <lists+linux-wireless@lfdr.de>; Sun, 25 Aug 2024 18:18:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B39C01C20A51
	for <lists+linux-wireless@lfdr.de>; Sun, 25 Aug 2024 16:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB3421714B4;
	Sun, 25 Aug 2024 16:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="COPdr7XU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076741684A5
	for <linux-wireless@vger.kernel.org>; Sun, 25 Aug 2024 16:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724602661; cv=none; b=hPd9RR3Vx+AC1FshHsqxcEHMoQKzHgIadGn351XmQi93FNZRr3GokSQqozMlovTA6NLfA+m2iIa2Lh8aMKxq4XZI1KrUQIltZ67aJ9bTo3atzOpcSe16UwPJw+S/GVJoXy274azDvh3mQX/tBHlTDaR0TY6sWLOg/zYErwrHIjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724602661; c=relaxed/simple;
	bh=OTD20n4QXpcTpqMfiY0mToN8nzrgchIfV9FgB7V//Qg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HS1QD9VcFx4tRSjsubyRqJMzyD4FNg0BCv93XrvweAkXKek3wQAMorpp1QK39Mhsx1PW9q44dwyGqRe2zzB6U5emN4sOnsg0ex1C3zMdJQhfE+pb5D3TDFZsY12QqwPqcqI3BENfWl4d+qxPoHXga/m9yLiKC+QJYmAyx9AlKnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=COPdr7XU; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724602660; x=1756138660;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OTD20n4QXpcTpqMfiY0mToN8nzrgchIfV9FgB7V//Qg=;
  b=COPdr7XU6ip3wOasXWhLR5+hddHhLj9ITRlrx26mh7sg0rQL+aI851vN
   iJ3ow/9X6AiwbHiFpFI69UEReH2TpKyY3q2isFwDAWYIugDjyga5si5IL
   BvaUnY2esyUmcYtbQ3ASv8SFIfWA9CFUwuExKNSLRAAqNQcptxvj2e/c3
   auvEPZ9ATwrF8khYtAmgImhxjwfIIP8ZQ2htisZM81ze+QfMEwN5raKnl
   awUqiA0OTUuZCVgzA9lF5MlletOHT5BANRYHKK4ujgppLHX7QVBK9vjaL
   hzqUBDjOLEQrfUECLXxBgvvYkjOZOs5PsPFHg4nQO9JJXjlgiDM18x5LS
   Q==;
X-CSE-ConnectionGUID: L7c5w1iTQseZ9JBlMlgUrw==
X-CSE-MsgGUID: Nikdf4fwQTKX5T+RYXfNAQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11175"; a="22544140"
X-IronPort-AV: E=Sophos;i="6.10,175,1719903600"; 
   d="scan'208";a="22544140"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2024 09:17:39 -0700
X-CSE-ConnectionGUID: A0q0/0PSRoiJMoI+JEiYCg==
X-CSE-MsgGUID: TKOnKOC6RMSj5iD1/SNjpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,175,1719903600"; 
   d="scan'208";a="62999768"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2024 09:17:38 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH 11/13] wifi: iwlwifi: mvm: allow ESR when we the ROC expires
Date: Sun, 25 Aug 2024 19:17:11 +0300
Message-Id: <20240825191257.8f8765f359cc.I16fcd6198072d422ff36dce68070aafaf011f4c1@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240825161713.3547021-1-miriam.rachel.korenblit@intel.com>
References: <20240825161713.3547021-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

We forgot to release the ROC reason for ESR prevention when the remain
on channel expires.
Add this.

Fixes: a1efeb823084 ("wifi: iwlwifi: mvm: Block EMLSR when a p2p/softAP vif is active")
Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/mvm/time-event.c    | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c b/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
index a8c42ce3b630..72fa7ac86516 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
@@ -114,16 +114,14 @@ static void iwl_mvm_cleanup_roc(struct iwl_mvm *mvm)
 		iwl_mvm_flush_sta(mvm, mvm->aux_sta.sta_id,
 				  mvm->aux_sta.tfd_queue_msk);
 
-		if (mvm->mld_api_is_used) {
-			iwl_mvm_mld_rm_aux_sta(mvm);
-			mutex_unlock(&mvm->mutex);
-			return;
-		}
-
 		/* In newer version of this command an aux station is added only
 		 * in cases of dedicated tx queue and need to be removed in end
-		 * of use */
-		if (iwl_mvm_has_new_station_api(mvm->fw))
+		 * of use. For the even newer mld api, use the appropriate
+		 * function.
+		 */
+		if (mvm->mld_api_is_used)
+			iwl_mvm_mld_rm_aux_sta(mvm);
+		else if (iwl_mvm_has_new_station_api(mvm->fw))
 			iwl_mvm_rm_aux_sta(mvm);
 	}
 
-- 
2.34.1


