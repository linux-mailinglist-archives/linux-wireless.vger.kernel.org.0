Return-Path: <linux-wireless+bounces-22816-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F40A4AB2506
	for <lists+linux-wireless@lfdr.de>; Sat, 10 May 2025 20:49:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44BCEA01669
	for <lists+linux-wireless@lfdr.de>; Sat, 10 May 2025 18:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E613D2686AA;
	Sat, 10 May 2025 18:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BiUbzLXV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7BD82820A8
	for <linux-wireless@vger.kernel.org>; Sat, 10 May 2025 18:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746902927; cv=none; b=jfRlxb/iUCdD95OfFRIfZbeEMfOIjmrugIv3mSo3yr3638rdRu7vDlPvQ2qMrAP9oAsDqlZXD3m5dEJbDZBQukcL7wbLcQpFr30hneES0i6k7z29fTqTX9cMS/5FofkyRBUBlmc/vflo+Q8yn5uPW30vCS7ZUrEU2QX4M690s0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746902927; c=relaxed/simple;
	bh=XWjrHa2+5qHjPDHjlsN8mfQpU2G+KtrlF1gnnwXw46k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Yk8TpOrbb7K4c9SdkGKfBtX3UywhtHNtv+q/UrNiKcm0eaPmjBBwEt9nutby1ht6ppgC8t35JAHTUABqthaqyGL78Z0x6AXiTMLH3QRLt2iKigtznv5bq9yA9IvEAuLEn7llwJMXThC3bseC4Hh9ZvZiD2sf6c5Xsrr7B2HqAJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BiUbzLXV; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746902926; x=1778438926;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XWjrHa2+5qHjPDHjlsN8mfQpU2G+KtrlF1gnnwXw46k=;
  b=BiUbzLXVAUXYHsZ8W2T8ErF3cAJQVWw5dGVEbP8grovXzw9UOYad1Tuy
   qubbNe81XI329lKOvju0TSy8EN3y9tC7oesKawEnQR3RN4lQAzJ7RG0Gb
   c91Iybsrq3YMg0QZ1n9nXaJsMCrcoEuBaeL9G9bBNKz5HlTS2hArNsv78
   66cgAsCpYo7Nt3DVPmmIx1SoidbsahdV2xYNOEYxloVN4G9noaIecI4g1
   r92qPnfhgMMBxw6ng5KuJ0SttU2dJmrgoo0SOlQvyUZ6GfxFqb93gYzhy
   aajb+uhJOUL71J+WsOZwigDV2l4kqpclVD9Lw6LTNHxXyVM3f6lCuC8vb
   A==;
X-CSE-ConnectionGUID: Quq+U8VeRyG9ntwLVO4rsg==
X-CSE-MsgGUID: vG0koKigT4G+FMewqtqEMQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11429"; a="48880876"
X-IronPort-AV: E=Sophos;i="6.15,278,1739865600"; 
   d="scan'208";a="48880876"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2025 11:48:46 -0700
X-CSE-ConnectionGUID: MVAhtvYBTo2cnfh6uzEWHQ==
X-CSE-MsgGUID: /A2HlkQaQH+h0bl66UHHNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,278,1739865600"; 
   d="scan'208";a="142033417"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2025 11:48:45 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 03/15] wifi: iwlwifi: cfg: remove some unused names
Date: Sat, 10 May 2025 21:48:15 +0300
Message-Id: <20250510214621.1ed5fc197ba0.I52d7bb49db24523ad93ad83a89c8e846d9a43241@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250510184827.3800322-1-miriam.rachel.korenblit@intel.com>
References: <20250510184827.3800322-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

There are a couple of old names that don't actually get used.
Remove them.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/cfg/7000.c   | 3 ---
 drivers/net/wireless/intel/iwlwifi/iwl-config.h | 3 ---
 2 files changed, 6 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/7000.c b/drivers/net/wireless/intel/iwlwifi/cfg/7000.c
index b6068dfcbd76..74b8ca55fba2 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/7000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/7000.c
@@ -126,9 +126,6 @@ const char iwl3168_2ac_name[] = "Intel(R) Dual Band Wireless AC 3168";
 const char iwl7265_2ac_name[] = "Intel(R) Dual Band Wireless AC 7265";
 const char iwl7265_2n_name[] = "Intel(R) Dual Band Wireless N 7265";
 const char iwl7265_n_name[] = "Intel(R) Wireless N 7265";
-const char iwl7265d_2ac_name[] = "Intel(R) Dual Band Wireless AC 7265";
-const char iwl7265d_2n_name[] = "Intel(R) Dual Band Wireless N 7265";
-const char iwl7265d_n_name[] = "Intel(R) Wireless N 7265";
 
 const struct iwl_rf_cfg iwl7260_cfg = {
 	.fw_name_pre = IWL7260_FW_PRE,
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index 031c68fbf8b1..719986ccf316 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -593,9 +593,6 @@ extern const char iwl3168_2ac_name[];
 extern const char iwl7265_2ac_name[];
 extern const char iwl7265_2n_name[];
 extern const char iwl7265_n_name[];
-extern const char iwl7265d_2ac_name[];
-extern const char iwl7265d_2n_name[];
-extern const char iwl7265d_n_name[];
 extern const char iwl8260_2n_name[];
 extern const char iwl8260_2ac_name[];
 extern const char iwl8265_2ac_name[];
-- 
2.34.1


