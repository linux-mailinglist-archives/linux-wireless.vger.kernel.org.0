Return-Path: <linux-wireless+bounces-2880-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23BAE8438F4
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jan 2024 09:26:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3340B26D3A
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jan 2024 08:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 633095DF22;
	Wed, 31 Jan 2024 08:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O19BTvDf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792EF633F5
	for <linux-wireless@vger.kernel.org>; Wed, 31 Jan 2024 08:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706689540; cv=none; b=C8CB2z8Jdg+WK+5BD3cobKPtegU+OPn6a1h0RBv3psbbMGs2V05svd1MX7V0122IKDZAqu3qmHMeHEjh+roJ65uViCYE07U4K6bAxaTWcTVVPv2UFotdTqQYaOhF1nzzM1Zj/IHRqUJzvvddUIJARHtzZWZcCf1gemHE9eFisww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706689540; c=relaxed/simple;
	bh=xs7D+gO7sLzlSFD9cdvHxbARiS5la/VDPJpC9q4XsoE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MHTePLORRjFSpyCjVYRaO+DpEqA2M2iIxYgpNQD9+721W62SGwmat0bd/4ixdCVK8t+6RiQ8BNFCsALzbqyOj9X7O0VAcroPJptP8ZA6I+F/I4TAA9X+Mqk1765okGa6xabh2POJPRSxR9W14CMmQUJUwvmJt7jxjCm4vWZ/+og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O19BTvDf; arc=none smtp.client-ip=134.134.136.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706689528; x=1738225528;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xs7D+gO7sLzlSFD9cdvHxbARiS5la/VDPJpC9q4XsoE=;
  b=O19BTvDfYFPruBeR19Y0QZFLQI1cbUooLAjeVqLSvVoSebBlLHTAMezB
   jJM32gDhrZGfiEY5HAvv22b4dXqweY+RxLiuM1n2yfzX6X/Qq3ScjvQhW
   11yCFQU8j2ibbEs99q8gTNMO6+G8iiW7EXqoZM9Tdk881nN45Q3YsyEph
   8r5oas9NbZJC6fKOY/QnjxKToyuAMDOtg+qchEVwTMK+dMbDokL7NaqKO
   HeECwQVZ0ksVA2xt9Hb7L3F+9kQTRSyvC8al+3aIjfASockAnyoq20HAU
   wkHrDugMyPOR9TXQdihwLS/kRBgYMZWEj0B9Fmi/jHUWx9Z/L/MKyfKMT
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="407249963"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="407249963"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 00:25:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="3968955"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 00:25:24 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 11/14] wifi: iwlwifi: don't check TAS block list size twice
Date: Wed, 31 Jan 2024 10:24:44 +0200
Message-Id: <20240131091413.2234490624c4.I6399b652a3c83afff1b0b5f114604d15892ee01e@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240131082447.1372353-1-miriam.rachel.korenblit@intel.com>
References: <20240131082447.1372353-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

Currenltly we check the validity of this variable twice.
Remove the second check.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
index c150a66eed07..d88a9df20abe 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
@@ -317,12 +317,6 @@ int iwl_acpi_get_tas(struct iwl_fw_runtime *fwrt,
 	cmd->v4.block_list_size = cpu_to_le32(block_list_size);
 
 	IWL_DEBUG_RADIO(fwrt, "TAS array size %u\n", block_list_size);
-	if (block_list_size > APCI_WTAS_BLACK_LIST_MAX) {
-		IWL_DEBUG_RADIO(fwrt, "TAS invalid array size value %u\n",
-				block_list_size);
-		ret = -EINVAL;
-		goto out_free;
-	}
 
 	for (i = 0; i < block_list_size; i++) {
 		u32 country;
-- 
2.34.1


