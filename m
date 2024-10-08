Return-Path: <linux-wireless+bounces-13673-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 682AC993DF9
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Oct 2024 06:26:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6458B24A26
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Oct 2024 04:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 045F81369B6;
	Tue,  8 Oct 2024 04:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GJxWIp5Z"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C2113BC0C
	for <linux-wireless@vger.kernel.org>; Tue,  8 Oct 2024 04:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728361556; cv=none; b=eKVc8RuB3HyWVoYfr/jpW1OEE05ybJPfVml22a3ORYqtJ6ObF6KZUNcLf76qWByOANt6wKPlpU3/Y34n2cD08dMNeeN/WYjvEwSXw/D8wMrPAIO5RxcBb6oteCtS1I2cooiP3Hizfu8yz8jWU1g2rNlK6JI356PCTFX8qEiKAhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728361556; c=relaxed/simple;
	bh=TO+aTwMIcUqjh+EKnRCdgKiGFBelOoT6X+JWnz2BnXA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ivdoQhM6DBuOigq/o8XMMJBQRB0ELoneumu++aKJQeYIZOKQ3O0Lc/f4aSeZYfMM1gUaYGKcO0F8ZSViKcxaVGPENpqJnoelPwgMoncmR2g854oajcn8i4LRZLsNS5IlQnVNsWXgjjX0ECYY1Wf56PrhL/j0oZAoutS7z6G0qLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GJxWIp5Z; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728361556; x=1759897556;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TO+aTwMIcUqjh+EKnRCdgKiGFBelOoT6X+JWnz2BnXA=;
  b=GJxWIp5ZLgZAvdxoSEA6ExVRi5xQHFpOrj/ixfmvznBsCBqS8G8mPVek
   ryA/W2/QRKlOMmBgTUR9IL/kqHQeJJFD2dVKu/gRyLwnyqOY6fPnSbuuo
   vuv9lKk7Lpuk1y8VR3lR4TsljzxX+DzI2pIlhiNrFsL1jCzozAZlrwCw9
   o3FO8SvpOkc57/CYfzrclKjYdWmxRhls1gDv0Yv9hC3Vvorrz89NxJsZi
   GykJUBrvU1xjaemZeknO2kiCcyLYhYmV+MFSOG9PqTZqPI0CAt0yQeRKt
   yRA8/SrLns6xwFioeyJaUcDQEcIAEVjHhe9i69nMEpKyhxWqoGQr9YacH
   A==;
X-CSE-ConnectionGUID: nLTqKCyHQlG8Ws3JqTuGUw==
X-CSE-MsgGUID: GacoyC74SPm1WvxHKSgDDw==
X-IronPort-AV: E=McAfee;i="6700,10204,11218"; a="27024294"
X-IronPort-AV: E=Sophos;i="6.11,185,1725346800"; 
   d="scan'208";a="27024294"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 21:25:55 -0700
X-CSE-ConnectionGUID: JQ+lW+jYTgGkxfOlOVmedA==
X-CSE-MsgGUID: oo33RpIbSUSB/bvoPecs0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,185,1725346800"; 
   d="scan'208";a="80486368"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 21:25:55 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 10/14] wifi: iwlwifi: mvm: remove IWL_MVM_HW_CSUM_DISABLE
Date: Tue,  8 Oct 2024 07:25:24 +0300
Message-Id: <20241008072037.e1b6ab87c969.Ic623ab87cb2a22285cdbed99325fdfcfe439c7d4@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241008042528.2549752-1-miriam.rachel.korenblit@intel.com>
References: <20241008042528.2549752-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

This is always set to 0.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/constants.h | 1 -
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h       | 3 +--
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/constants.h b/drivers/net/wireless/intel/iwlwifi/mvm/constants.h
index fdccdea918bf..795a166ed63a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/constants.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/constants.h
@@ -58,7 +58,6 @@
 #define IWL_MVM_RS_RSSI_BASED_INIT_RATE         0
 #define IWL_MVM_RS_80_20_FAR_RANGE_TWEAK	1
 #define IWL_MVM_TOF_IS_RESPONDER		0
-#define IWL_MVM_HW_CSUM_DISABLE			0
 #define IWL_MVM_ADWELL_ENABLE			1
 #define IWL_MVM_ADWELL_MAX_BUDGET		0
 #define IWL_MVM_TCM_LOAD_MEDIUM_THRESH		10 /* percentage */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 475e781e166a..5aa48c77b054 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1589,8 +1589,7 @@ static inline bool iwl_mvm_bt_is_rrc_supported(struct iwl_mvm *mvm)
 static inline bool iwl_mvm_is_csum_supported(struct iwl_mvm *mvm)
 {
 	return fw_has_capa(&mvm->fw->ucode_capa,
-			   IWL_UCODE_TLV_CAPA_CSUM_SUPPORT) &&
-		!IWL_MVM_HW_CSUM_DISABLE;
+			   IWL_UCODE_TLV_CAPA_CSUM_SUPPORT);
 }
 
 static inline bool iwl_mvm_is_mplut_supported(struct iwl_mvm *mvm)
-- 
2.34.1


