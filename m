Return-Path: <linux-wireless+bounces-22299-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA1EAA5CDC
	for <lists+linux-wireless@lfdr.de>; Thu,  1 May 2025 12:00:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 625A83BB1DF
	for <lists+linux-wireless@lfdr.de>; Thu,  1 May 2025 10:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F414265631;
	Thu,  1 May 2025 10:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WtmBdxne"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B077325E450
	for <linux-wireless@vger.kernel.org>; Thu,  1 May 2025 10:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746093604; cv=none; b=UF58C5UYyBbkPfA6EtFkW8rfFjcr+JUy19WBXpMgL7uy9ze5VtXrLTtmP2jIPiv6B1TJlQitLlinfoE9dbwFguRHQXrRLv9/D8wrGNW8pN3IpSxIMuGSnGBD9wdmXvQZTPcB33g6saRJyCCfuEPN9D80PYIhv6aK401UoxQh9UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746093604; c=relaxed/simple;
	bh=tS9mU6qcuPMqIRrnlvkLEnUmL4r2znERDyOmAQiA3Fg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=khWp4V5cg6VzR5VBt+EoLOtk4alM+DY60IsNx7J5GbXALgP4vgMwZq0O4CjWw+L/4456+bUBYkJ6wz+4XSg4pis+jKcc+c6H2C/OHHH6mlvDlnfC3FuaN3QEtyojh4KEpQBniwro3shQX8p23+8y96AG9Ws3GsSr0nOh2G3rlB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WtmBdxne; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746093603; x=1777629603;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tS9mU6qcuPMqIRrnlvkLEnUmL4r2znERDyOmAQiA3Fg=;
  b=WtmBdxneljfyTKgXRVJng4Vyi4F82BeU0WsdlBIfD6w45jubiLcjEJah
   4RvdXAdbjcb7PFvm4JDcrW/mixSBFnzooE8dQu6x7sQeGH+yaPo6J67Js
   NNXLR4sZM69O9MwWZT49OebzwovTBNjGSyO+zNDyxpBSh1SBqSiE4diUC
   dBkw/D2IMQ697FUJNNuqwCdCuDgn6qy3U7bD6zjMuJ4/6vjkNS4dxIONN
   hS84jYWqJaHj9ymzfAS0Azsu/R49LmnWkPhEkG4e8eSJ4OE7m1Guarf3+
   DFfYA5gRajK/pWBDNr0P3yafeua8M4btyAyC4N30nQghPSjAs9bkpBR9r
   Q==;
X-CSE-ConnectionGUID: 2Zc2hxrQRE6t8yITqjI52w==
X-CSE-MsgGUID: cDvLEkUoQ02vKe2ZvWMImQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11419"; a="57962825"
X-IronPort-AV: E=Sophos;i="6.15,254,1739865600"; 
   d="scan'208";a="57962825"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2025 03:00:02 -0700
X-CSE-ConnectionGUID: aMTEwbN7TniJJfIwgnuZQQ==
X-CSE-MsgGUID: nPObZPM/QwyAN3SK7kcShQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,254,1739865600"; 
   d="scan'208";a="135317966"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2025 03:00:01 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: miriam.rachel.korenblit@intel.com
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 07/15] wifi: iwlwifi: tests: check for device names
Date: Thu,  1 May 2025 12:59:29 +0300
Message-Id: <20250501125731.72bd63f6f731.Iedc7c05a41dc8bfe04dc8b95fea38543513eac2d@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250501095937.2097123-1-miriam.rachel.korenblit@intel.com>
References: <20250501095937.2097123-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Add a unit test that checks that each device has a name,
either via the specific name entry or the config's name.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/tests/devinfo.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/tests/devinfo.c b/drivers/net/wireless/intel/iwlwifi/tests/devinfo.c
index 7ef5e89c6af2..a64880fd3398 100644
--- a/drivers/net/wireless/intel/iwlwifi/tests/devinfo.c
+++ b/drivers/net/wireless/intel/iwlwifi/tests/devinfo.c
@@ -47,6 +47,17 @@ static void devinfo_table_order(struct kunit *test)
 	}
 }
 
+static void devinfo_names(struct kunit *test)
+{
+	int idx;
+
+	for (idx = 0; idx < iwl_dev_info_table_size; idx++) {
+		const struct iwl_dev_info *di = &iwl_dev_info_table[idx];
+
+		KUNIT_ASSERT_TRUE(test, di->name || di->cfg->name);
+	}
+}
+
 static void devinfo_pci_ids(struct kunit *test)
 {
 	struct pci_dev *dev;
@@ -71,6 +82,7 @@ static void devinfo_pci_ids(struct kunit *test)
 
 static struct kunit_case devinfo_test_cases[] = {
 	KUNIT_CASE(devinfo_table_order),
+	KUNIT_CASE(devinfo_names),
 	KUNIT_CASE(devinfo_pci_ids),
 	{}
 };
-- 
2.34.1


