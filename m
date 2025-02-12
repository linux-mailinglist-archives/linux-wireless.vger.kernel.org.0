Return-Path: <linux-wireless+bounces-18814-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCED1A31E20
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Feb 2025 06:44:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82CA016349F
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Feb 2025 05:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6253A1FAC38;
	Wed, 12 Feb 2025 05:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="doBa7chH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB771FBC9C
	for <linux-wireless@vger.kernel.org>; Wed, 12 Feb 2025 05:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739339042; cv=none; b=jFsAEtdC5wBCXhe7my0jv3Q/DHcjqfPCNFtij8mOystTgl1jHckbkq23pAaqHWmPRHd2PCZmZ5/074GbAr9E3oIiPs4eF+rTG5zTKVZUSS8Ahq01vdt8fhtpyzxvhmxSG0iHNYvPENf5bdoi8dsomsjME81p1fPgyIxk8ZRNfrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739339042; c=relaxed/simple;
	bh=quNkTcci2nCp+ZEgA7lYOn1wOWcYDzJn9I5lgRuP6YU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eMDhdRHl/TffjfAm89GZDfHIgYiSa08SfF4sXbQPmd2gQS5hTW1gEqi5WkBoNnc0Zjvkxw3vqTbt1OAgSkjGP3tJISVhccrj5hL0qxdQCXbCCifL2cfBHlEZTbJ+yoXTDcQtSvQzz3pr1V6XWVdUdTGfGPp05sds52QtxUHORCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=doBa7chH; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739339040; x=1770875040;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=quNkTcci2nCp+ZEgA7lYOn1wOWcYDzJn9I5lgRuP6YU=;
  b=doBa7chHTUd7xBN6alwtUXweOLyR14wa0wSVfWtTeuh8Y+jabBdxiivD
   f3b3DS2lVi2W9C/PVu8ClSKviMP7n+Vqj8rjbELkWb7TD97V/0Xc30ELa
   XHj2znXi7I7f5dwNECRLOJDYgGol3JSqs4V0dfh5KRLWXXE+KQaGZ/tJL
   /0QvOuat3Z+imnG+07XFrD2vh4r3oMo5uitTb3lm0nyi4tYp1r2hMl1Ku
   mANO4wFo6eb9ChNoaP/Rmb76FHupSMoCovwmoeOhbL64q3wzJUoYkm0lr
   0Us9gqdnELy8FDmHIDqLYT0atHqO/mvABiuJMwNsxjKglPpeTNWeHrIWm
   w==;
X-CSE-ConnectionGUID: XqVt4MtvSPWEigLYQSxuzg==
X-CSE-MsgGUID: xh7hC22ESo2E1CLa94ud/g==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="39172223"
X-IronPort-AV: E=Sophos;i="6.13,279,1732608000"; 
   d="scan'208";a="39172223"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 21:44:00 -0800
X-CSE-ConnectionGUID: FX1nr+lYSVSb+pllLVMSoA==
X-CSE-MsgGUID: 9ljA/kZAQJyAp7kFHIXlZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="117893884"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 21:43:59 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 09/12] wifi: iwlwifi: remove mvm prefix from iwl_mvm_d3_end_notif
Date: Wed, 12 Feb 2025 07:43:30 +0200
Message-Id: <20250212073923.c99748f63511.I5c8dcc46e992e76c82fdf7dbee65957cbdca1b43@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250212054333.376219-1-miriam.rachel.korenblit@intel.com>
References: <20250212054333.376219-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

This is not op mode specific.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/api/d3.h | 2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/d3.h b/drivers/net/wireless/intel/iwlwifi/fw/api/d3.h
index c2362bc786b2..9c271ea67155 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/d3.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/d3.h
@@ -1006,7 +1006,7 @@ struct iwl_wowlan_wake_pkt_notif {
  * struct iwl_mvm_d3_end_notif -  d3 end notification
  * @flags: See &enum iwl_d0i3_flags
  */
-struct iwl_mvm_d3_end_notif {
+struct iwl_d3_end_notif {
 	__le32 flags;
 } __packed;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index 129b6bdf9ef9..632f1a26672c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -3376,7 +3376,7 @@ static bool iwl_mvm_wait_d3_notif(struct iwl_notif_wait_data *notif_wait,
 		break;
 	}
 	case WIDE_ID(PROT_OFFLOAD_GROUP, D3_END_NOTIFICATION): {
-		struct iwl_mvm_d3_end_notif *notif = (void *)pkt->data;
+		struct iwl_d3_end_notif *notif = (void *)pkt->data;
 
 		d3_data->d3_end_flags = __le32_to_cpu(notif->flags);
 		d3_data->notif_received |= IWL_D3_NOTIF_D3_END_NOTIF;
-- 
2.34.1


