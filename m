Return-Path: <linux-wireless+bounces-25039-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD41BAFDEF3
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 07:02:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A91EF1C26A32
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 05:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91C6F22D4DD;
	Wed,  9 Jul 2025 05:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UeD7tJo7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF2B13957E
	for <linux-wireless@vger.kernel.org>; Wed,  9 Jul 2025 05:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752037344; cv=none; b=b08YR4mwqoh8ujFvKGKBuq5UbefvHTS6oof8SuFSBXE1tWsMIQHuI3lg3D+jyOZ7KSvEh3yNulXn6cK1deyXxqzfTDDt5cyFU8qORZpmBuzxPDxrfeNQYglxdXPdM5F1jJcmpl/n7VXEt3r7CgmtwGg04hVE50N4VBl8SwhZex8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752037344; c=relaxed/simple;
	bh=MsmdQNvN0gUcNvjzbg/LZxInH4Z4CndcmN8P3R3djRM=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bYHTWpz7+lZ0/aeND+v/OsTqvjiF4rFhzhBDfo+sDJpvGYVx1nckbtPdu4LCLmJVf37WPwFKHPeE0d0uZSYauJwgF+JtVjun8Oi0quO87b7m0Cu4Yk1LB4p8LmmDHQovqPWHjiLFy3Xz1jjB9wpcewFTUSKNrU2I1VUiNIniyI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UeD7tJo7; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752037343; x=1783573343;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=MsmdQNvN0gUcNvjzbg/LZxInH4Z4CndcmN8P3R3djRM=;
  b=UeD7tJo74wbTx9mLnusE3bf3bcqgQYiCZSbWrv996quFkh9s/G1xD1qh
   Xm0FTwfyLsMjhi9Bh+TnAVnlZGy80cmETRtK2PCTmXgslslnRLNRXCjx6
   jBhVo0aIT5dNBuYAQShBggkQ2bE0hCOI8KA3zc0MEMbPKfMnMdeqUijEi
   SBZNe/E+Py4BEsaDE5HCvBIRbRfW6PePo+oACxb72GzN8fqHYZEKeUJkE
   6Tqe0x1rSQFbOpo+Ikz/pivuI1sGyxDx1mFMdb556lNjumDWUPg0lsuf8
   tyohbdr+WL/DfZVj7TuYc8ezBtyVaI+SJUqHi8qDbDJKib895l0XSDEbe
   w==;
X-CSE-ConnectionGUID: tZBpEmvBSf+9ureNNdrUsw==
X-CSE-MsgGUID: lKs1O27BSvW3cNZ8h56M8Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="53501449"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="53501449"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 22:02:22 -0700
X-CSE-ConnectionGUID: t9vhck/cQrGobc4eAp7bsA==
X-CSE-MsgGUID: TVifE5+uT++4/UNM0LVWPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="192859214"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 22:02:21 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Subject: [PATCH iwlwifi-next 01/15] wifi: iwlwifi: handle non-overlapping API ranges
Date: Wed,  9 Jul 2025 08:01:45 +0300
Message-Id: <20250709050159.854432-2-miriam.rachel.korenblit@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250709050159.854432-1-miriam.rachel.korenblit@intel.com>
References: <20250709050159.854432-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

The option to set an api_version_min/max also to the RF was added.
In the case that both the MAC and the RF has a range defined, we take
the narrower range of both.

This doesn't work for non-overlapping ranges. In this case, we should
just take the lower range of both.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
index f62f7c7ee7f3..2dff87c07512 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
@@ -301,13 +301,17 @@ static void iwl_get_ucode_api_versions(struct iwl_trans *trans,
 	const struct iwl_family_base_params *base = trans->mac_cfg->base;
 	const struct iwl_rf_cfg *cfg = trans->cfg;
 
-	if (!base->ucode_api_max) {
+	/* if the MAC doesn't have range or if its range it higher than the RF's */
+	if (!base->ucode_api_max ||
+	    (cfg->ucode_api_max && base->ucode_api_min > cfg->ucode_api_max)) {
 		*api_min = cfg->ucode_api_min;
 		*api_max = cfg->ucode_api_max;
 		return;
 	}
 
-	if (!cfg->ucode_api_max) {
+	/* if the RF doesn't have range or if its range it higher than the MAC's */
+	if (!cfg->ucode_api_max ||
+	    (base->ucode_api_max && cfg->ucode_api_min > base->ucode_api_max)) {
 		*api_min = base->ucode_api_min;
 		*api_max = base->ucode_api_max;
 		return;
-- 
2.34.1


