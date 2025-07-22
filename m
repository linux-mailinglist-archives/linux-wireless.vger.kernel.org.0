Return-Path: <linux-wireless+bounces-25794-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13663B0D07B
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 05:42:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39C40188DF2F
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 03:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1A7B28C2D2;
	Tue, 22 Jul 2025 03:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LtIJAiTT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679F028B3FD
	for <linux-wireless@vger.kernel.org>; Tue, 22 Jul 2025 03:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753155730; cv=none; b=Ahb6tLplpGGN9Mu+NfS6aFRbbZWikSjj7JHW6opsH4Gv+x7t+7hbe7HMLoLBKSfFQKmfE0cPCdC1bsfIHqREJqf5O2pmH4uwnrLkm57m9d+newgoTbgSSiBxzA4VsXosxPA4GWju3OmgdX+YRI2XTXT2hw6T3a0g/lJfVH+LpJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753155730; c=relaxed/simple;
	bh=JgxjcevpNvUIv/5VxzmGMBbHHgQrXOaCeCTMtvaTI90=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CQct/azgCB7xFhCB42O1PubxCjTfD4JxFqipVGbIaTRgDdBvPC3ogjhMr7KuWoOgYcmt7ve+Pnmr9myYiMgqYwCx5wd626ipQqHH2VJho8KT02gNmDu+CpPSYq/vezfosCY8VcXXm+eDaSiOxCvowug9/Gwx6sjI6xtgp8NW7hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LtIJAiTT; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753155729; x=1784691729;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JgxjcevpNvUIv/5VxzmGMBbHHgQrXOaCeCTMtvaTI90=;
  b=LtIJAiTTAKq7KWrR15CzYqglg3hBQMYn6UFK3thzfjEjAepEGjqmAdiD
   Du9UWkbccs8M4d8NZ4ls0j5XY7w5B68ri5rNPJIwLUr845SJifNmCDiHx
   WatJKXlEY/DJNRiajLtcLkM3G5NbttkQeo0dFiaNMZ0tbZZMxn4pQIBEb
   h1yWpjnELMOAq78tQyD3nFMpYTNvmg/cy0yFKVkH99EFEnfJla/S/J39Z
   9G7pdRN6X71XfKzChrqUuDNIikSM07uEUqdHD/gSYl4HdnHZruZbZr4Aw
   12vP3PIW0+6v8iOH5UKLUWv6WTt/w3KMN9FFs/bXUmf2G7hV0D8vL5V1A
   g==;
X-CSE-ConnectionGUID: x3L3xaGnTIyl9TgkcrFDJw==
X-CSE-MsgGUID: YIDa57KzQB2ZREMRB4zInw==
X-IronPort-AV: E=McAfee;i="6800,10657,11499"; a="43006171"
X-IronPort-AV: E=Sophos;i="6.16,330,1744095600"; 
   d="scan'208";a="43006171"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 20:42:09 -0700
X-CSE-ConnectionGUID: VRwixY6aSl66aYyrRRKU/w==
X-CSE-MsgGUID: UiFOZ0mATMeh7fd+KidNCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,330,1744095600"; 
   d="scan'208";a="159338171"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 20:42:08 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 15/15] wifi: iwlwifi: check validity of the FW API range
Date: Tue, 22 Jul 2025 06:41:25 +0300
Message-Id: <20250722063923.f838312a46d9.I661f347d3bb29994d8b2ec1d3f31f3383422d68a@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250722034125.1017387-1-miriam.rachel.korenblit@intel.com>
References: <20250722034125.1017387-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

We assume that iwl_mac_cfg and iwl_rf_cfg instances has either
both ucode_api_min and ucode_api_max set, or neither.
Validate this assumption with a Kunit test.

Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../wireless/intel/iwlwifi/tests/devinfo.c    | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/tests/devinfo.c b/drivers/net/wireless/intel/iwlwifi/tests/devinfo.c
index 4d660cef3de9..c31bbd4e7a4a 100644
--- a/drivers/net/wireless/intel/iwlwifi/tests/devinfo.c
+++ b/drivers/net/wireless/intel/iwlwifi/tests/devinfo.c
@@ -238,6 +238,33 @@ static void devinfo_no_mac_cfg_dups(struct kunit *test)
 	}
 }
 
+static void devinfo_api_range(struct kunit *test)
+{
+	/* Check that all iwl_mac_cfg's have either both min and max set, or neither */
+	for (int i = 0; iwl_hw_card_ids[i].vendor; i++) {
+		const struct iwl_mac_cfg *mac_cfg =
+			(void *)iwl_hw_card_ids[i].driver_data;
+		const struct iwl_family_base_params *base = mac_cfg->base;
+
+		KUNIT_EXPECT_EQ_MSG(test, !!base->ucode_api_min,
+				    !!base->ucode_api_max,
+				    "%ps: ucode_api_min (%u) and ucode_api_min (%u) should be both set or neither.\n",
+				    base, base->ucode_api_min,
+				    base->ucode_api_max);
+	}
+
+	/* Check the same for the iwl_rf_cfg's */
+	for (int i = 0; i < iwl_dev_info_table_size; i++) {
+		const struct iwl_rf_cfg *rf_cfg = iwl_dev_info_table[i].cfg;
+
+		KUNIT_EXPECT_EQ_MSG(test, !!rf_cfg->ucode_api_min,
+				    !!rf_cfg->ucode_api_max,
+				    "%ps: ucode_api_min (%u) and ucode_api_min (%u) should be both set or neither.\n",
+				    rf_cfg, rf_cfg->ucode_api_min,
+				    rf_cfg->ucode_api_max);
+	}
+}
+
 static struct kunit_case devinfo_test_cases[] = {
 	KUNIT_CASE(devinfo_table_order),
 	KUNIT_CASE(devinfo_discrete_match),
@@ -248,6 +275,7 @@ static struct kunit_case devinfo_test_cases[] = {
 	KUNIT_CASE(devinfo_check_killer_subdev),
 	KUNIT_CASE(devinfo_pci_ids),
 	KUNIT_CASE(devinfo_no_mac_cfg_dups),
+	KUNIT_CASE(devinfo_api_range),
 	{}
 };
 
-- 
2.34.1


