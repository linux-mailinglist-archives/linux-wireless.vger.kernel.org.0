Return-Path: <linux-wireless+bounces-20081-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3B4FA580A9
	for <lists+linux-wireless@lfdr.de>; Sun,  9 Mar 2025 06:37:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D9F33AF4E3
	for <lists+linux-wireless@lfdr.de>; Sun,  9 Mar 2025 05:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D97115749F;
	Sun,  9 Mar 2025 05:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MAVoDldu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56F614B086
	for <linux-wireless@vger.kernel.org>; Sun,  9 Mar 2025 05:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741498635; cv=none; b=kb7jVFq3ANChR9YGYY3EsPF4Z/hd66T8EM/QYXTCcfndmb1t+vHvc0a7GPxZapwjZ/6N/RmWbzrQE4VcQh7MW2UszKsRg7X7nMfu6JoCJCVaw9MjWnrVvzCth9YCEcQMK0toKs7SjfkYgdAtBjQ9d2Kl/WedK517qYWikMqEwvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741498635; c=relaxed/simple;
	bh=REAIoendfzQyX6wyUdJhIUsemDKdtguPeCQcl/KPyos=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uSnCapPZHo7EzlVmenvpF1kHWXA9sIQo1U/7DB5Ek74cf52DkVGCFEV2KYLerII3rHWQUC7KUmCgdumlxh9gNgdN7OMwKZf/YbMjNK6P2MKwBVhJ8JoWiUydNwP33LkWOYqzQsBRfKIinyVOUz9reh61SZMxn0Ly6E8aGUEga1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MAVoDldu; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741498634; x=1773034634;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=REAIoendfzQyX6wyUdJhIUsemDKdtguPeCQcl/KPyos=;
  b=MAVoDlduZrccRaNkEnx/XYSqHa8H2csaBQeOEnNatAivl158F+R2rHST
   i/nLwKz8phlkdy9VVfcCbtR16EKQI6tf9STpb0YBpY/iCtmJTerRpYeu8
   PjujeG+Gq4aXcP+gf83g+t5cfBtUVeGa1tVpEWQsuKRIduqYBvDZFmi6y
   3h5J5Begniq76gt57nTFrTBoFSDqChEuurvmuqs9SFwlMePehOol9gWFi
   RIzCzOgcVmF3Za3x+zGeohtCRPskHUK+ejuMky5iCaA0ndFUCU8impV0T
   KaKh/XjoVdretzqGQdxfMueKi9po5k4w5cb/Gv1ykDto0UAnsHpogY2Bl
   Q==;
X-CSE-ConnectionGUID: kCi+aVAAR9KDnIEGmFVn7A==
X-CSE-MsgGUID: 2wMo5zaMSbiee6PdehyGRA==
X-IronPort-AV: E=McAfee;i="6700,10204,11367"; a="41671691"
X-IronPort-AV: E=Sophos;i="6.14,233,1736841600"; 
   d="scan'208";a="41671691"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2025 21:37:14 -0800
X-CSE-ConnectionGUID: GblgaQWKS1GEZlKbfotauQ==
X-CSE-MsgGUID: Dq/jZIplSLuXfSv5zcBGww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,233,1736841600"; 
   d="scan'208";a="150470618"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2025 21:37:12 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH v2 wireless-next 05/15] wifi: iwlwifi: mld: assume wiphy is locked when getting BSS ifaces
Date: Sun,  9 Mar 2025 07:36:43 +0200
Message-Id: <20250309073442.6ce298d6a44f.Ibc862dfdd6cb2da63781c791b9dc601bd5ce4bdc@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250309053653.2697525-1-miriam.rachel.korenblit@intel.com>
References: <20250309053653.2697525-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Benjamin Berg <benjamin.berg@intel.com>

The code was calling ieee80211_iterate_interfaces, however that
takes a lock of iflist_mtx, which must not be taken recursively. Fix
this by using the appropriate _mtx version that asserts that the wiphy
mutex is already held.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/iface.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/iface.c b/drivers/net/wireless/intel/iwlwifi/mld/iface.c
index 691062b44461..e49e2260ac05 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/iface.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/iface.c
@@ -465,10 +465,10 @@ u8 iwl_mld_get_fw_bss_vifs_ids(struct iwl_mld *mld)
 {
 	u8 fw_id_bitmap = 0;
 
-	ieee80211_iterate_interfaces(mld->hw,
-				     IEEE80211_IFACE_SKIP_SDATA_NOT_IN_DRIVER,
-				     iwl_mld_get_fw_id_bss_bitmap_iter,
-				     &fw_id_bitmap);
+	ieee80211_iterate_active_interfaces_mtx(mld->hw,
+						IEEE80211_IFACE_SKIP_SDATA_NOT_IN_DRIVER,
+						iwl_mld_get_fw_id_bss_bitmap_iter,
+						&fw_id_bitmap);
 
 	return fw_id_bitmap;
 }
-- 
2.34.1


