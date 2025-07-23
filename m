Return-Path: <linux-wireless+bounces-25906-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3A78B0EAE5
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Jul 2025 08:46:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F430188C0FD
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Jul 2025 06:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C058E272E7E;
	Wed, 23 Jul 2025 06:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ddTmrlZt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B302737EC
	for <linux-wireless@vger.kernel.org>; Wed, 23 Jul 2025 06:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753253159; cv=none; b=JYO+StSVHrUoVApJm0XzRPmy7hGUiftJLlbjUF0Nk9Vf4GioYKxufEvlYlSpmBTR8jJIeJRx3yle3JogCzNrcGjOjFVFt1QMKsU7Q/Co4i3MSMh6DqFptF8YfdsvJIMCDNN+KimkFlIFq/iP3pyLV3mUUovKtLDtSgfsBCc8pog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753253159; c=relaxed/simple;
	bh=JgxjcevpNvUIv/5VxzmGMBbHHgQrXOaCeCTMtvaTI90=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FsIEP8GnCp+myYPKG59pEK3Uw4KxYLLE7lNpVEtMSczzbMjS+9PBHYYPxSpFfoV3XZ1qkxGa/T6IUAifAFauwk46ZoATMKAQiFUqTz2HDIskBXiKJ1Cd4mcO0b8N63b1Vr6FStfU0jYZb/k97owmrzo8sskPeaWBRHyzQD/3Uy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ddTmrlZt; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753253158; x=1784789158;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JgxjcevpNvUIv/5VxzmGMBbHHgQrXOaCeCTMtvaTI90=;
  b=ddTmrlZtKsn85OHhfcDlVlYHN6KpBnTVkqKM99WnRUKD1gslaQZZ2op/
   i5sY/AG3KOLW+KrTNaWjdBSd8kd8ubMoCc5aKl3oEwLdmREXVAlRutRgA
   W3BqQKyCHg/RP0LPPearjfICaLQbeB3l3N5R9pCwXD/p92/Y5KFr54L/D
   qM1js5W7BTGyIP9CGpokpnXE7U3ehEgbfvgoTw5xMrbku4XKrfSg8RWJj
   jgKtdG/TuQwHIsomkAeXtbYZy+qXE5wuemC51yo+zco176wdLfIYNowUT
   Eo1GbqXWJ93H/QMRr7zQaXOzOfUwCVLjjYlZhRe603IEocO7eTr/wUhTU
   w==;
X-CSE-ConnectionGUID: AvBbXx2XRqiiMiWXSUbypQ==
X-CSE-MsgGUID: m54qKg3cQ12/yat+zwx3CA==
X-IronPort-AV: E=McAfee;i="6800,10657,11500"; a="59340790"
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="59340790"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 23:45:55 -0700
X-CSE-ConnectionGUID: q1QgJmEZQWq4aNIcEM4vnw==
X-CSE-MsgGUID: 3Ctmtas4T8CuOj47HMUUEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="159918116"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 23:45:53 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 13/14] wifi: iwlwifi: check validity of the FW API range
Date: Wed, 23 Jul 2025 09:45:14 +0300
Message-Id: <20250723094230.66502f3f4345.I661f347d3bb29994d8b2ec1d3f31f3383422d68a@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250723064515.2084903-1-miriam.rachel.korenblit@intel.com>
References: <20250723064515.2084903-1-miriam.rachel.korenblit@intel.com>
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


