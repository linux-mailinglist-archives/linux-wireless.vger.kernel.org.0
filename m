Return-Path: <linux-wireless+bounces-21760-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4972FA946E1
	for <lists+linux-wireless@lfdr.de>; Sun, 20 Apr 2025 09:01:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C91A3B72B7
	for <lists+linux-wireless@lfdr.de>; Sun, 20 Apr 2025 07:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AAC21C84D9;
	Sun, 20 Apr 2025 07:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q1MtV57i"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9681C863E
	for <linux-wireless@vger.kernel.org>; Sun, 20 Apr 2025 07:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745132427; cv=none; b=bk9sgKk9n8cvWsWmt9vShgjrvYywL9Hx1QnG2/uAhesrrE1/CKXWgAEYOWXTLepzOGdu39F0bSbtKbXpG6qjRHejsR6TUH+oykHIZ+IQ9n8+1nMNWPNBXgotapWPb8vZTNWnbMmTlcSdd1TU4Uh8inQEowNb6TNV4NAnsUCHtLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745132427; c=relaxed/simple;
	bh=UUBecrnkiZsXXNjt5vXlxi5J1NbnTYP465531KLqEJQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DvaZhezs+q6t11fU0a5ndAimEl76u3f4j98aTnDkcBQAroiGItJ3k7f336UH6uFkt09HTschFHD3UZm9JNeflkrVNziuC0VzRCEF1LD33a7/3ewZrM0Yjj1ohaDdELMTYQbT6cpUOpEwLuG3kIBWWBagP/fistsdi+qikAwgrqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q1MtV57i; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745132425; x=1776668425;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UUBecrnkiZsXXNjt5vXlxi5J1NbnTYP465531KLqEJQ=;
  b=Q1MtV57iLZ8n2HzO9ZpbGdLSXyNCSw4rBZMruujrd1ysC46W7YelBGUF
   uqQyNhx1uyjQnYdSIx96upBLvaWLT+oosjrOgMcFXLcfZcZuUsaeKlwY2
   z6t7CECGekKYYKUTCT6pPQVrWUsfCbuSEvG8EZMIXJkQUZE0DPr9WEosZ
   cXdCmvgTVrmWYtSVKcrJA000xa0CNrO2ImJNj2AoCleqlyoGbP/zYqkcl
   nEic1wDV3njmhvFPLmI71+DE2VL+hlRr68KKKuHRsb6wunlTVbMU/RPcE
   9OoPY+CAqk98svB8goGDrkJxwPQ8OPzcofvAsLL/bDOnQOzB0QBofRTr0
   Q==;
X-CSE-ConnectionGUID: IlE43epxS1uk5tKHoseZpg==
X-CSE-MsgGUID: ML5ZdZ72Q0Gr3jdtsgdJTA==
X-IronPort-AV: E=McAfee;i="6700,10204,11408"; a="46827940"
X-IronPort-AV: E=Sophos;i="6.15,225,1739865600"; 
   d="scan'208";a="46827940"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2025 00:00:25 -0700
X-CSE-ConnectionGUID: RLKWwjSQRVC0XCpHkNqbXw==
X-CSE-MsgGUID: FzdlX/b4QBGUGHpoqFW+dw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,225,1739865600"; 
   d="scan'208";a="154615773"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2025 00:00:23 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH wireless 7/7] wifi: iwlwifi: fix the check for the SCRATCH register upon resume
Date: Sun, 20 Apr 2025 10:00:01 +0300
Message-Id: <20250420095642.a7e082ee785c.I9418d76f860f54261cfa89e1f7ac10300904ba40@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250420070001.3406977-1-miriam.rachel.korenblit@intel.com>
References: <20250420070001.3406977-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

We can't rely on the SCRATCH register being 0 on platform that power
gate the NIC in S3. Even in those platforms, the SCRATCH register is
still returning 0x1010000.

Make sure that we understand that those platforms have powered off the
device.

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219597
Fixes: cb347bd29d0d ("wifi: iwlwifi: mvm: fix hibernation")
Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-csr.h  | 1 +
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 6 ++++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-csr.h b/drivers/net/wireless/intel/iwlwifi/iwl-csr.h
index be9e464c9b7b..3ff493e920d2 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-csr.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-csr.h
@@ -148,6 +148,7 @@
  * during a error FW error.
  */
 #define CSR_FUNC_SCRATCH_INIT_VALUE		(0x01010101)
+#define CSR_FUNC_SCRATCH_POWER_OFF_MASK		0xFFFF
 
 /* Bits for CSR_HW_IF_CONFIG_REG */
 #define CSR_HW_IF_CONFIG_REG_MSK_MAC_STEP_DASH	(0x0000000F)
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index bb7917a3aac0..b8b616cffb91 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -1759,11 +1759,13 @@ static int _iwl_pci_resume(struct device *device, bool restore)
 	 * Scratch value was altered, this means the device was powered off, we
 	 * need to reset it completely.
 	 * Note: MAC (bits 0:7) will be cleared upon suspend even with wowlan,
-	 * so assume that any bits there mean that the device is usable.
+	 * but not bits [15:8]. So if we have bits set in lower word, assume
+	 * the device is alive.
 	 * For older devices, just try silently to grab the NIC.
 	 */
 	if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_BZ) {
-		if (!iwl_read32(trans, CSR_FUNC_SCRATCH))
+		if (!(iwl_read32(trans, CSR_FUNC_SCRATCH) &
+		      CSR_FUNC_SCRATCH_POWER_OFF_MASK))
 			device_was_powered_off = true;
 	} else {
 		/*
-- 
2.34.1


