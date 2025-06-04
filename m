Return-Path: <linux-wireless+bounces-23669-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 741D2ACD65D
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 05:14:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40290188AA00
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 03:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD6EB1F9406;
	Wed,  4 Jun 2025 03:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JQPYEpse"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25FEA238C04
	for <linux-wireless@vger.kernel.org>; Wed,  4 Jun 2025 03:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749006824; cv=none; b=mOvfNR32jvO4w85spj+1Ns/xJdUVPmGoABvJTcB7LBoo3rMA0pDbBnLE0+8HGnLGvloJhSGAvfJcvUKQB2DGeDtWu60dCA/VYS4wttTDMnHKgIWwiimKZgBFDOy4EvD2lzbY0FeCirxE2ZsiOs1ubf/2rqVAL1ZYMk5neywxndE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749006824; c=relaxed/simple;
	bh=0iG1Arvo65NrBfE7+zxgNQGPBpXlzaOoDGtpO54okoE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rg10DhYNMypR6Aub7xAgETeBVM+XBz56cKVmd/TtRbQaOE0zFgw0Bi4LveX4Ln21l45ZKgOaVPYr0IGmicGs63caMBJd+V5SERDOrEkdyDWMUdI90PjzpFPi6JYHi5953XrFti18AzQe03XLcGnsGDU+8Md8qmkJyhRSlbi/dp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JQPYEpse; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749006823; x=1780542823;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0iG1Arvo65NrBfE7+zxgNQGPBpXlzaOoDGtpO54okoE=;
  b=JQPYEpseGpROnTgAsFzmLvUd80DCQOGnABnHkxymluWNHvcNn/a65jXZ
   LK5wkX10RN3XVX9UtmUYEADRW5J9xPMaYp711gamot0M0eXe5QwY5x6SH
   Q9NHdG7gpS1pccFa00mFxN1D+O1iX/BDBl3b35RIecRlf9TJKfLZRNsxr
   euQlJ0BVIdLzNZeGkGYklYfPoeaJWW9PJ4h82m/8mMn4TjXx8XKoElWsa
   sfQHOr6Gwx69CdI5/7+oZET6ON3AgCku7XMVPODRSOmQ2Z7dJoZYKFQOv
   imA7N55RWk9e1aEmIzQeUwub8YK8A4oYvgP23xOmCRgzKGyGHQ4GqXdyA
   w==;
X-CSE-ConnectionGUID: 5eB5kWfZRl+WeDH2V2/uEg==
X-CSE-MsgGUID: twxMEZMRTY+nt36EeEjl4Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11453"; a="68504620"
X-IronPort-AV: E=Sophos;i="6.16,208,1744095600"; 
   d="scan'208";a="68504620"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 20:13:43 -0700
X-CSE-ConnectionGUID: VLE1e4+uSRKClAo7PgjT3Q==
X-CSE-MsgGUID: HtwzcWTESDy9OBLSssoBng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,208,1744095600"; 
   d="scan'208";a="182227390"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 20:13:42 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Ilan Peer <ilan.peer@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-fixes 4/4] wifi: iwlwifi: mld: Move regulatory domain initialization
Date: Wed,  4 Jun 2025 06:13:21 +0300
Message-Id: <20250604061200.f138a7382093.I2fd8b3e99be13c2687da483e2cb1311ffb4fbfce@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250604031321.2277481-1-miriam.rachel.korenblit@intel.com>
References: <20250604031321.2277481-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Ilan Peer <ilan.peer@intel.com>

The regulatory domain information was initialized every time the
FW was loaded and the device was restarted. This was unnecessary
and useless as at this stage the wiphy channels information was
not setup yet so while the regulatory domain was set to the wiphy,
the channel information was not updated.

In case that a specific MCC was configured during FW initialization
then following updates with this MCC are ignored, and thus the
wiphy channels information is left with information not matching
the regulatory domain.

This commit moves the regulatory domain initialization to after the
operational firmware is started, i.e., after the wiphy channels were
configured and the regulatory information is needed.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/fw.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/fw.c b/drivers/net/wireless/intel/iwlwifi/mld/fw.c
index 73ed8d5cab43..9d2c087360e7 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/fw.c
@@ -349,10 +349,6 @@ int iwl_mld_load_fw(struct iwl_mld *mld)
 	if (ret)
 		goto err;
 
-	ret = iwl_mld_init_mcc(mld);
-	if (ret)
-		goto err;
-
 	mld->fw_status.running = true;
 
 	return 0;
@@ -546,6 +542,10 @@ int iwl_mld_start_fw(struct iwl_mld *mld)
 	if (ret)
 		goto error;
 
+	ret = iwl_mld_init_mcc(mld);
+	if (ret)
+		goto error;
+
 	return 0;
 
 error:
-- 
2.34.1


