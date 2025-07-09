Return-Path: <linux-wireless+bounces-25123-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B141AFF2AF
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 22:08:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 901ED1C82DB3
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 20:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A44C268C63;
	Wed,  9 Jul 2025 20:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZU9CblgC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE1626657D
	for <linux-wireless@vger.kernel.org>; Wed,  9 Jul 2025 20:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752091581; cv=none; b=S6FnAlO0oiYdEO7nNCu52hYfZVHPuKXOuwJx6V024Gp8JlVwxmtrLhvrjPNF3SOU2pmxmHVrHjxIjqIK5dQ3OZcjNjyQKU/8i+AM+6fRUp8nSMPndJDWnRl5uWoxu2BVnsP01kJNjjdd+cGKPfHfKT1YuTEoGbtW/5r9hGUxAeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752091581; c=relaxed/simple;
	bh=CZkdLZeRMp3xYK78tLAdoJnCzpxejN7SNqFlczVuso0=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=n3JdqZ759yujT5H6+/WHpFlCvIkT/znCqGJFNbkvNMS62/XeMDvdYK98qza5GDL2L8/+p2aZCsyw7rKXXYG58pn3UREjsCIMkh+VYmbh5HWw+fw91/jm8/dHWRZe2MOWjK38gbOXv8NmcL7Zex2J1C8ghgOxF7qGAcXQprmQg+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZU9CblgC; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752091580; x=1783627580;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=CZkdLZeRMp3xYK78tLAdoJnCzpxejN7SNqFlczVuso0=;
  b=ZU9CblgCk3t9pIrgEHuD9mNA0O8puEqG2UvHA4vP1sB9aIIzHnVTapNA
   kGYAfhLPgkrM0Z5OoycthnuMrMNsxOgSkV2JfzkiNYdQSFhcn6b0ksKFt
   YJF+0MQEWu5k2+6Kd3H0pGb9wEGqc27fSSMo8jur6Zo/JHcdiMhGU0Bq+
   Nwxdu031dF8Oj8Hdt0+rEMMt09GsPq0r1GbAUc4mU6pY9vH8OPK2jCJ4s
   aUYSuYkBjuVr1VejSCwBc5F/OkrW0w6yEvSt/fk2WNAva7whC33lXshKO
   Y7VKn1g5VeQelcdJtze8XK8ytcBpu2BMMJK5EYeRvWbfYrk7ftnKnhN9M
   A==;
X-CSE-ConnectionGUID: g83fHY2tTzO39dAzPacLrQ==
X-CSE-MsgGUID: mVj3vwimSQSSlXZvsDC0rw==
X-IronPort-AV: E=McAfee;i="6800,10657,11489"; a="54240330"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="54240330"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 13:06:20 -0700
X-CSE-ConnectionGUID: UOoEkZM2SZ6mytEr4DSxzw==
X-CSE-MsgGUID: 2JE4CW08RcCUYkHafp/G6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="160126086"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 13:06:19 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Subject: [PATCH iwlwifi-next 14/15] wifi: iwlwifi: pcie: add a missing include
Date: Wed,  9 Jul 2025 23:05:42 +0300
Message-Id: <20250709230308.716e8b54ebcb.If75c28a85b5ba4c2661bdf4ce20b97dbe7d2abb2@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250709200543.1628666-1-miriam.rachel.korenblit@intel.com>
References: <20250709200543.1628666-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

pcie/utils.h needs to include iwl-io.h for the iwl_read/iwl_write calls.
Add it.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/utils.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/utils.h b/drivers/net/wireless/intel/iwlwifi/pcie/utils.h
index 031dfdf4bba4..27437d5e099b 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/utils.h
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/utils.h
@@ -6,6 +6,8 @@
 #ifndef __iwl_pcie_utils_h__
 #define __iwl_pcie_utils_h__
 
+#include "iwl-io.h"
+
 void iwl_trans_pcie_dump_regs(struct iwl_trans *trans, struct pci_dev *pdev);
 
 static inline void _iwl_trans_set_bits_mask(struct iwl_trans *trans,
-- 
2.34.1


