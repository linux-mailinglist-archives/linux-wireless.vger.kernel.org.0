Return-Path: <linux-wireless+bounces-8543-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1262E8FC9B0
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Jun 2024 13:06:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88E881C20E04
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Jun 2024 11:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C570192B61;
	Wed,  5 Jun 2024 11:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VVNjqoKK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1388A1922F8
	for <linux-wireless@vger.kernel.org>; Wed,  5 Jun 2024 11:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717585531; cv=none; b=jVq9tEPablzyDwi9r5lSO0R41y+DA6ltdpBHXw5j1x0fI8PZyqfTy5I8qmpIvKo9tyKHjxAOSI4sK9a/RXp1OgQBfP/Ys6uGcX+kG8sJmrcYRVhiqK6beRUxH4jrHPC1AerAE7ogpieRrq2hw7G/h0LU7ueOTwGZIIbtVvJVc8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717585531; c=relaxed/simple;
	bh=kUnXg//oZmZU4rpOmUbkiZiRpfWXlQ6Fy8QCYLOtomI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ejH1U8Nv7+40CEay0U3oMypXrlCCLDknPHOxA3csgRelKxXjf8jUzjnFRyQPZtaFQLqpXoT/uaHQ0oxkWxoIj6Ie8607oTV6QiINjbYqBchWELE4IIIYhJi0Xjx2fldcSmau9X/fFpBb7dJ7SpZ5K0rbKiKOR9D0ztA5bTqfng8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VVNjqoKK; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717585529; x=1749121529;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kUnXg//oZmZU4rpOmUbkiZiRpfWXlQ6Fy8QCYLOtomI=;
  b=VVNjqoKKUvfltTsvfC62jXS8Y21ffaKlt8mIWschWGIsssM3F/HK9jkb
   Zii5Ht0n5G9gMWs4ySrOcdLIkwccUsbQjkAyzA70fyj9ZPBc7vFJs01E0
   NH8mhjY8Sbq4YWECD4uJHHplCecRNXRaLZygWb+dbBaPqshu7LigU2PsX
   xvxlICBAbMk9zYcVy1gofHmQsBV+I03fu44mm2iva/glmyOzrn/fCwgA2
   PKKa+lUH07z1zsruN/rQZHBMX3AUWINHmM4coVogbBGcIuo4S1PmeANNU
   0BYMRKkwy9fZuqRxTbW8l+gg3z5WIoU2RArPL1baZ2Amc7mlyy5o1Lbys
   Q==;
X-CSE-ConnectionGUID: BstJ5BvQROOmxh14Xqv2jQ==
X-CSE-MsgGUID: gP8l17TVQPmU8Nkc0WoZiQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="14402196"
X-IronPort-AV: E=Sophos;i="6.08,216,1712646000"; 
   d="scan'208";a="14402196"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 04:05:28 -0700
X-CSE-ConnectionGUID: cfM/Sfo5TASkOJnfJ/7Phw==
X-CSE-MsgGUID: OWL7Y3PbT9SuCqFyW1Va+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,216,1712646000"; 
   d="scan'208";a="41997403"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 04:05:27 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Shaul Triebitz <shaul.triebitz@intel.com>
Subject: [PATCH wireless 09/11] wifi: iwlwifi: mvm: fix ROC version check
Date: Wed,  5 Jun 2024 14:05:05 +0300
Message-Id: <20240605140327.93d86cd188ad.Iceadef5a2f3cfa4a127e94a0405eba8342ec89c1@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240605110507.2044059-1-miriam.rachel.korenblit@intel.com>
References: <20240605110507.2044059-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Shaul Triebitz <shaul.triebitz@intel.com>

For using the ROC command, check that the ROC version
is *greater or equal* to 3, rather than *equal* to 3.
The ROC version was added to the TLV starting from
version 3.

Fixes: 67ac248e4db0 ("wifi: iwlwifi: mvm: implement ROC version 3")
Signed-off-by: Shaul Triebitz <shaul.triebitz@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 727047d5ddb2..a2a0409672c3 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -4723,7 +4723,7 @@ static int iwl_mvm_roc_station(struct iwl_mvm *mvm,
 
 	if (fw_ver == IWL_FW_CMD_VER_UNKNOWN) {
 		ret = iwl_mvm_send_aux_roc_cmd(mvm, channel, vif, duration);
-	} else if (fw_ver == 3) {
+	} else if (fw_ver >= 3) {
 		ret = iwl_mvm_roc_add_cmd(mvm, channel, vif, duration,
 					  ROC_ACTIVITY_HOTSPOT);
 	} else {
-- 
2.34.1


