Return-Path: <linux-wireless+bounces-25043-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E08EAFDEF7
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 07:02:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 593DE1C26A36
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 05:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3DFB1E008B;
	Wed,  9 Jul 2025 05:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LuLiwrbS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3008B1CAA85
	for <linux-wireless@vger.kernel.org>; Wed,  9 Jul 2025 05:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752037349; cv=none; b=FFuvRq7zNgPWpjPHTWpKNR1sv+AF6drumXP9R0Bf6AJA/wopeN0t0n4LGdnrb/FiaObJcSa1Svqyt8Sv3e13a3plzG7N2Mb3ydk/UtbBkZh2PGmxaCh4oKOjLxRoyjCVa/hc/ju5CkCnmpdosZsPbHVcbKJQonkGtSmNZ11B6oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752037349; c=relaxed/simple;
	bh=Fh9irTQJn5fE2sT3iUro5wr8vZjhN1csDxaz4YZLqoE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C6Dvak44DyGZkmKponqkmo2SiRY+XLDz41D30MxIb2IIOa90rNzr+9sbFByQi+6rgZPc+ltRisJFlftH+voAbXcE3DceEbSfEwaI1KuuljwCV4Xt1gPZbe2CnC2dnuqEJxYBNSdxQRhswhGuLiyLVrA51nMpM1KIvnQbALPVokw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LuLiwrbS; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752037348; x=1783573348;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Fh9irTQJn5fE2sT3iUro5wr8vZjhN1csDxaz4YZLqoE=;
  b=LuLiwrbSBYaT7hlzIT/qxQnM3iHZIFK0eCekYAIYoj6rPEiefIRspgCE
   UF6JH/7+sqIk5TM9yj75gSw1VkNDPdGUI485aqYDUCwQ6lPF83ZkPZ2CC
   gd3aMi6aS1mo/d/B3LeUiJ6l7taChLaTOcorooQZ/J85SrWMnnPAR0ljk
   gjB1g+gEQFHZOnVUwc+TBm8jWkZla0QSc2rD+3QcHRjTsiOnjaO2ZzKVq
   hTgN7zZKXKnD98x+jgl/nKy2yNmV55jtedZlm209w6834WGMjWpzggfuF
   JqnSuPrqANq/TzLMKB9SIGS7EYMJ7/35FdGintxYir8GpPN0jPgGF8QKY
   g==;
X-CSE-ConnectionGUID: 48G5ZFU0Qjey9NwqxLfJqg==
X-CSE-MsgGUID: yKGUJ3jgQz6Yd0EMzEkv0g==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="53501460"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="53501460"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 22:02:28 -0700
X-CSE-ConnectionGUID: X/q6DG1+SX23yC9FH905FA==
X-CSE-MsgGUID: Eq01VRvHTdivBCsFjH3sNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="192859235"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 22:02:27 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 05/15] wifi: iwlwifi: add a reference to iwl_wowlan_info_notif_v3
Date: Wed,  9 Jul 2025 08:01:49 +0300
Message-Id: <20250709075928.e354dc6568c2.Ie5aca3f0af11cc3137c6b6862a13777bae0cb06b@changeid>
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

Mark this structure as one of the structures that represent
WOWLAN_INFO_NOTIFICATION

Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/api/offload.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/offload.h b/drivers/net/wireless/intel/iwlwifi/fw/api/offload.h
index 7d9aa8363f90..2a1c2b0f19e4 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/offload.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/offload.h
@@ -19,7 +19,8 @@ enum iwl_prot_offload_subcmd_ids {
 
 	/**
 	 * @WOWLAN_INFO_NOTIFICATION: Notification in
-	 * &struct iwl_wowlan_info_notif_v1, or &struct iwl_wowlan_info_notif
+	 * &struct iwl_wowlan_info_notif_v1, iwl_wowlan_info_notif_v3,
+	 * or &struct iwl_wowlan_info_notif
 	 */
 	WOWLAN_INFO_NOTIFICATION = 0xFD,
 
-- 
2.34.1


