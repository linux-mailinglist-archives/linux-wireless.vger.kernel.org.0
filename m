Return-Path: <linux-wireless+bounces-11914-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B889F95E44A
	for <lists+linux-wireless@lfdr.de>; Sun, 25 Aug 2024 18:18:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBC941C20963
	for <lists+linux-wireless@lfdr.de>; Sun, 25 Aug 2024 16:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF0BF3D62;
	Sun, 25 Aug 2024 16:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VlV1xbWo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CAAC2119
	for <linux-wireless@vger.kernel.org>; Sun, 25 Aug 2024 16:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724602659; cv=none; b=ll/Bg2O0iUHCxX0cx4/0ySPZg7OiXvh8Zn3vvWRHAGW99/ZPck1vTVAulh9Pkem5ijXb6tTAavSDr0dEBuYgu7de6ryHAZ4QHon6iwB/k2n4IZ6E8bHXFt8JSq0Y8PkwRESbDuyeToDHR4iwV4K0uq81BG56zJga36NvrqZTodc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724602659; c=relaxed/simple;
	bh=N1x2yGxE4fIJH00NhIsyiBIx0/JvxgU/hxZWRcA8Oos=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fD+Jk7mLp0NC1arcYaIzQBx4GcgG/LiHa5jrvoZK6cnwVXsJPsa/63gJehP04hCZ1Y8fX6rAOmwilHQjEc38nSO/+Tn4JmUgV5OS2Vy+Tn6eEvvxboa8ZwtQ0L1Fyftb7rxQjElhqg13Spr0OFgvPGtn1j1ZPslHAWZAUEmfw7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VlV1xbWo; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724602658; x=1756138658;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=N1x2yGxE4fIJH00NhIsyiBIx0/JvxgU/hxZWRcA8Oos=;
  b=VlV1xbWo2TUz72DcfibbTrzZDA5Culu4ncHUV1NmIvn6/vskxYbvKNKq
   ZgYLbbBCpTan1jfklH4UWENaLw2Pm59IZqBwAbq9WXz3FZnETNqNYmbYL
   1WtvSh+ak/5MNBdiYjbYF/jRBNQZh4nORXf6uF9IpftL803WXwYvJt2mv
   zzs9osjv+Wb6l3D7YQmn8Nrr1j/jiHb5UwHqUuCR+GDF+NoQ86qPd3CB7
   TMSGKAiTQ3zrVVftqSC4w1O2NYhbDfOvBM9fFvzSfBV+DcwRxnDwSfdQu
   0dCC8e5UDL8Vz0HQ34uxj5czIS9c0tvh5nS8gRZyhjlaISY/tWrE5pGNc
   Q==;
X-CSE-ConnectionGUID: hdCHA+5lSxWcgp0/Itahew==
X-CSE-MsgGUID: NBWVMTkoTKyIfK31fBUpQw==
X-IronPort-AV: E=McAfee;i="6700,10204,11175"; a="22544137"
X-IronPort-AV: E=Sophos;i="6.10,175,1719903600"; 
   d="scan'208";a="22544137"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2024 09:17:38 -0700
X-CSE-ConnectionGUID: AyAug1fvS36QKf6fUkruLA==
X-CSE-MsgGUID: 0YPu3TaxTjyhOg3LRu5GuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,175,1719903600"; 
   d="scan'208";a="62999764"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2024 09:17:36 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH 10/13] wifi: iwlwifi: mvm: pause TCM when the firmware is stopped
Date: Sun, 25 Aug 2024 19:17:10 +0300
Message-Id: <20240825191257.5abe71ca1b6b.I97a968cb8be1f24f94652d9b110ecbf6af73f89e@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240825161713.3547021-1-miriam.rachel.korenblit@intel.com>
References: <20240825161713.3547021-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

Not doing so will make us send a host command to the transport while the
firmware is not alive, which will trigger a WARNING.

bad state = 0
WARNING: CPU: 2 PID: 17434 at drivers/net/wireless/intel/iwlwifi/iwl-trans.c:115 iwl_trans_send_cmd+0x1cb/0x1e0 [iwlwifi]
RIP: 0010:iwl_trans_send_cmd+0x1cb/0x1e0 [iwlwifi]
Call Trace:
 <TASK>
 iwl_mvm_send_cmd+0x40/0xc0 [iwlmvm]
 iwl_mvm_config_scan+0x198/0x260 [iwlmvm]
 iwl_mvm_recalc_tcm+0x730/0x11d0 [iwlmvm]
 iwl_mvm_tcm_work+0x1d/0x30 [iwlmvm]
 process_one_work+0x29e/0x640
 worker_thread+0x2df/0x690
 ? rescuer_thread+0x540/0x540
 kthread+0x192/0x1e0
 ? set_kthread_struct+0x90/0x90
 ret_from_fork+0x22/0x30

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index d809742528af..a8590c453ab3 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -1513,6 +1513,8 @@ void iwl_mvm_stop_device(struct iwl_mvm *mvm)
 
 	clear_bit(IWL_MVM_STATUS_FIRMWARE_RUNNING, &mvm->status);
 
+	iwl_mvm_pause_tcm(mvm, false);
+
 	iwl_fw_dbg_stop_sync(&mvm->fwrt);
 	iwl_trans_stop_device(mvm->trans);
 	iwl_free_fw_paging(&mvm->fwrt);
-- 
2.34.1


