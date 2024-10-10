Return-Path: <linux-wireless+bounces-13844-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D408B998467
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Oct 2024 13:05:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93C5E284F43
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Oct 2024 11:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA42A1C231C;
	Thu, 10 Oct 2024 11:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BGfi5BfX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61261C2428
	for <linux-wireless@vger.kernel.org>; Thu, 10 Oct 2024 11:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728558326; cv=none; b=QP4LJwhusBaHnCjzhjZ0v3PCRsGWyxxGrhzJ3F25TW+i8yHmTRrGwFCc6B9sSqUQ+Px8xBerTTckYTAYh1LOu6AQKkT7CQtznGwblfTEyAgTAIRM7DJLm1iYP8Zj6+MfTqEL22xY5Q951AH3OPrbwTKaLqYyT34Vr0WT1SZcywQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728558326; c=relaxed/simple;
	bh=xOIWEtfCId3yQ8Qxta5NwSgzYE+Rr9i+2UFx7xRR9+k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=owT97kt3eE7ZH6Q8qcMXg4dCx3ANO+gSiUYeRFtbBpeTybwcGzJz0yGVFhnF2IHV1IkDZrNfhcmnO5Xq2U16kF95fdvc/WDZrWDdotI4Xx4mbQmTcrki+Q1g9NdAyOUuF/PazvAbj4GUzYB0wqyHaa17GEoGnoUQn5pSO8BJBvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BGfi5BfX; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728558325; x=1760094325;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xOIWEtfCId3yQ8Qxta5NwSgzYE+Rr9i+2UFx7xRR9+k=;
  b=BGfi5BfXUnhacEpVRPLvqyz3SOLyaJ2hL60Y5L6TF9zN9Q3FvfDBLPp6
   X+mBi4fDhpg6OQzJBV/fuKBSR/Cu7+PmrbZj9YxakTMpLVHNBZpkw7kgj
   nh6jsUSQqo5MQfS0+H2aL3Td1wKf5A44834B/crKyAWaldrKZzoTeRWj7
   /Ro+zamdFmgw3N6e7XomVN1VmrN9ie+1RSj732CKQXrpN+twY7tJDUZwS
   /awFp0aEE6S6TUeXtv16lcUhQosVMaR6MjKB07N53A7NCOIps55b4j7ci
   Ypipj69NQYoFa6RiRVxwZTaDnKMyVqEdDZyuB6YnJUcpYmFROcCo5iPB8
   g==;
X-CSE-ConnectionGUID: 42D/jRH7QbGeljNM42FH4w==
X-CSE-MsgGUID: /sMdW1txRhqOGyC9S9ZBHw==
X-IronPort-AV: E=McAfee;i="6700,10204,11220"; a="31697731"
X-IronPort-AV: E=Sophos;i="6.11,192,1725346800"; 
   d="scan'208";a="31697731"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 04:05:24 -0700
X-CSE-ConnectionGUID: 97Ya7RnSRKGIsR+35MWKHg==
X-CSE-MsgGUID: iHJi0ZarSd24iWXTMHVL7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,192,1725346800"; 
   d="scan'208";a="81362312"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 04:05:24 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH 2/9] wifi: iwlwifi: allow fast resume on ax200
Date: Thu, 10 Oct 2024 14:05:00 +0300
Message-Id: <20241010140328.a60d6303c027.I60061277526302a75cadbba10452e94c54763f13@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241010110507.1006209-1-miriam.rachel.korenblit@intel.com>
References: <20241010110507.1006209-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

This feature can be used on ax200 as well. It'll avoid to restart the
firmware upon suspend / resume flow. Doing so also avoids releasing and
re-allocating all the device related memory which makes the memory's
subsystem task easier.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 39b815904501..62d55864b5df 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -1369,7 +1369,7 @@ void __iwl_mvm_mac_stop(struct iwl_mvm *mvm, bool suspend)
 		iwl_mvm_rm_aux_sta(mvm);
 
 	if (suspend &&
-	    mvm->trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_AX210)
+	    mvm->trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_22000)
 		iwl_mvm_fast_suspend(mvm);
 	else
 		iwl_mvm_stop_device(mvm);
-- 
2.34.1


