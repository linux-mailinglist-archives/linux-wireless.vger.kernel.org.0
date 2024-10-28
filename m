Return-Path: <linux-wireless+bounces-14596-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D6919B2F64
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Oct 2024 12:56:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C52DE28214E
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Oct 2024 11:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0CC91D3648;
	Mon, 28 Oct 2024 11:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jt3XKl4x"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D39B1D95B4
	for <linux-wireless@vger.kernel.org>; Mon, 28 Oct 2024 11:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730116533; cv=none; b=KEiBRnI8SFDsdyQ+rwZPM5G56TXuVFp0GQ0jO98Hgcqo49LykXq8R3+iA/y94oEUSF9zpDMnpzk0QnPPkO3nBhE8g5GxKkN/jp2WQOecTRDDpnEMpHpfPIRRzqpemAyIshIoFgc6pOHYBeLdANFACWoSJkAmMaGe4+6qfNtmFGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730116533; c=relaxed/simple;
	bh=WRJZpF5A5eUrCuEU9xDW89LFZxB0+ZB7R6/PehSCnbk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZVzg+mtjOWThqTuaKPyuMOqbf6XcUdHZrliCbOdT35iVwxdVaEwGZdtkU7z18eBTc52zou91PiFxG4+VD+cO8e92sPBokU+BHkjyYTBL3T3fXEJZFEpM0y0aS1wq2iNFEcyc/xfXKIqkhb6x5iWAR6C2D+fc7pcVZUVnW3TtCjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jt3XKl4x; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730116532; x=1761652532;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WRJZpF5A5eUrCuEU9xDW89LFZxB0+ZB7R6/PehSCnbk=;
  b=jt3XKl4x+uHlLhG/2jcZsFiRIoRrJEyNrI3cHUeB3oRM245VlhW0aqz3
   ORdGXCJH+oTITQLeYCkW1K3h+bhSOLcfvpI9bloXfRLHy52u06wra2Aa1
   rEzXpE91MSfiY4/tzFXPNxXtCHbbuFc7PvR/P02COercY/bOGStxVauP1
   MmNXeXDAj6F4NkiMN6RU29FJL+nmOXiQAaQaZY07PikQE0wVaOuS3r55v
   SLoA1myClK5aA4L/c+RZ7U6ncMOpP+34cd2W+noLfjZSd5Yw+WOTFSR5S
   m9idsHz6oO711gzoAqxlpEodZ6YX0SqxAp8cG2xYzmHIQHnL1FuS0jJ+1
   w==;
X-CSE-ConnectionGUID: eNqBM00KQsyWpuqto8KZ6A==
X-CSE-MsgGUID: dkMgoa8oT/SfkWHV70+urA==
X-IronPort-AV: E=McAfee;i="6700,10204,11238"; a="29813904"
X-IronPort-AV: E=Sophos;i="6.11,239,1725346800"; 
   d="scan'208";a="29813904"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 04:55:29 -0700
X-CSE-ConnectionGUID: iBlvIbZ0SzOwjRpo0gGJKQ==
X-CSE-MsgGUID: 0ceOzdIGR3C/VgkhCjio1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,239,1725346800"; 
   d="scan'208";a="112432595"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 04:55:27 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH 08/15] wifi: iwlwifi: allow fast resume on ax200
Date: Mon, 28 Oct 2024 13:54:53 +0200
Message-Id: <20241028135215.514efe0ce4c7.I60061277526302a75cadbba10452e94c54763f13@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241028115500.351123-1-miriam.rachel.korenblit@intel.com>
References: <20241028115500.351123-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

This feature can be used on ax200 as well. It'll avoid to restart the
firmware upon suspend / resume flow. Doing so also avoids releasing and
re-allocating all the device related memory which makes the memory's
subsystem task easier.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 7c6051990569..4616a5b394c0 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -1371,7 +1371,7 @@ void __iwl_mvm_mac_stop(struct iwl_mvm *mvm, bool suspend)
 		iwl_mvm_rm_aux_sta(mvm);
 
 	if (suspend &&
-	    mvm->trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_AX210)
+	    mvm->trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_22000)
 		iwl_mvm_fast_suspend(mvm);
 	else
 		iwl_mvm_stop_device(mvm);
-- 
2.34.1


