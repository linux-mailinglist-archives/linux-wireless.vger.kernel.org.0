Return-Path: <linux-wireless+bounces-8553-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4692B8FCA2D
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Jun 2024 13:18:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBCBE2846EB
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Jun 2024 11:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2BA4194158;
	Wed,  5 Jun 2024 11:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aYRalFHd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEFAC194131
	for <linux-wireless@vger.kernel.org>; Wed,  5 Jun 2024 11:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717586247; cv=none; b=bVroPQy+mm4BP8fQGSma5KHJm2F335YHbotK7mr7Qj5ZFjCmPDetBwgZMZikG81SJQ3QMXNLhFqqHuneW3dRtz7uMYaqFRGvI/QYjMFg1bpEx65ZJ7G1ghVR/XL1yEAMt9P9c62PCWSbZjRHxQmhjlWdYVzOySlY8alaEpNzTWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717586247; c=relaxed/simple;
	bh=L/gBlK7If2EttVgOwJIRAx7n48UUcg0EPj79tOCQTqY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qLSZ0jQ7Qvbs1cbMMu42pgVRHjO8MkCiznBg+5uhGj7HQPk+K0FTH2HC1btDxJs8zRuJcFBWMwMzoWRaZIFYXtiTWBzDy6FhfXnG60zVD/ojp78KPo5ZJAb7kjDHH8MtZP9rcZ3qX++kmrihDywwGCqo6r+T5iWFWWyuyhCVlio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aYRalFHd; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717586246; x=1749122246;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=L/gBlK7If2EttVgOwJIRAx7n48UUcg0EPj79tOCQTqY=;
  b=aYRalFHdLYYzZiPMbOMYXUsS8dcRXKmfI4yAxRntTd4fWDx9mo7Fk9GU
   pkain/SupbUi/vu+BsjFWpcZ7dJlJqa3toZzDxoxk/e4lnRkF1eJwW9D9
   zFlXA/da0Pe3vQ9FD0VDVMPQEHQ6leBVJFA2kplS/MhsFk1rp1u2MIn7R
   QvDxynatr1G5wJW5pZnCH2t6Hwn2QGzMLoPa3+5NNj3DCIJaM6Ooezi4l
   /wnFw0jHM6NML5m8LdHCNy1xoeegISiYq8HMpTpkFAa+qJyF2S9CY4338
   qhac7WEAXwRSK2kvaT+idGoBTl0nxFPVHQmrYsoq4MfnHCLXwgI79D6cp
   Q==;
X-CSE-ConnectionGUID: 4gYGRy3kRNe+Q5LeHrQ0kA==
X-CSE-MsgGUID: vwdXbg35SEWjgBPQ+7WMOg==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="36718056"
X-IronPort-AV: E=Sophos;i="6.08,216,1712646000"; 
   d="scan'208";a="36718056"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 04:07:51 -0700
X-CSE-ConnectionGUID: VqNV0kbzSaW3Fe4poytHZg==
X-CSE-MsgGUID: bp2k7d1BRs+Fqpw5vU7jAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,216,1712646000"; 
   d="scan'208";a="37433786"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 04:07:49 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Ayala Beker <ayala.beker@intel.com>,
	Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH wireless 3/5] wifi: iwlwifi: scan: correctly check if PSC listen period is needed
Date: Wed,  5 Jun 2024 14:07:38 +0300
Message-Id: <20240605140556.291c33f9a283.Id651fe69828aebce177b49b2316c5780906f1b37@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240605110740.2046411-1-miriam.rachel.korenblit@intel.com>
References: <20240605110740.2046411-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Ayala Beker <ayala.beker@intel.com>

The flags variable is incorrectly checked while it is still cleared and
has not been assigned any value yet.
Fix it.

Fixes: a615323f7f90 ("wifi: iwlwifi: mvm: always apply 6 GHz probe limitations")
Signed-off-by: Ayala Beker <ayala.beker@intel.com>
Reviewed-by: Benjamin Berg <benjamin.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
index 695b5ba3d023..31e014b66161 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
@@ -1827,7 +1827,7 @@ iwl_mvm_umac_scan_cfg_channels_v7_6g(struct iwl_mvm *mvm,
 		 */
 		if (!iwl_mvm_is_scan_fragmented(params->type)) {
 			if (!cfg80211_channel_is_psc(params->channels[i]) ||
-			    flags & IWL_UHB_CHAN_CFG_FLAG_PSC_CHAN_NO_LISTEN) {
+			    psc_no_listen) {
 				if (unsolicited_probe_on_chan) {
 					max_s_ssids = 2;
 					max_bssids = 6;
-- 
2.34.1


