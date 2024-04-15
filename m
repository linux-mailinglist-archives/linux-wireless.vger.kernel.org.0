Return-Path: <linux-wireless+bounces-6318-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E70A58A4AF4
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Apr 2024 10:55:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74C1CB258EC
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Apr 2024 08:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2010D4E1D0;
	Mon, 15 Apr 2024 08:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TROGp1mZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28D54E1B5
	for <linux-wireless@vger.kernel.org>; Mon, 15 Apr 2024 08:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713171316; cv=none; b=kfuNrW6yrDjpGg1oWJKKCGHr0x/Czd0K5KgV64TjHAVBss8GtOmzo/UsIO4OdFeBVtqBDSzYzeXlqO5yOfagL9cc8hY752uSXc7cLwscPJPktRc+pv1sfnGvVhyf3QJaNfJ3nZmJndJ5np7yWihc1Ff7kqyddI6GabMbQAWfWM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713171316; c=relaxed/simple;
	bh=WeA4zqfyZ8408rk6eFpJ7tPBSBNJTmtTmnCjEn6XiYc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mZ7XDVg9PzH1GdQ+Vc5hshzJf+LqGKxNXZs53JKalB3gPlngX2zFef5xoP+OKlWLQO0JaQLdB5CirSUAXr5Mxnva7j8zP62OI1ptdPrBO/a6GnXEZMr9snjgfQe7G0xnXBgzBQI5bUNvKZ0ga8G7dHck3td57Q6lQdfz+TbhahQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TROGp1mZ; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713171315; x=1744707315;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WeA4zqfyZ8408rk6eFpJ7tPBSBNJTmtTmnCjEn6XiYc=;
  b=TROGp1mZMm29kSnEQDhIMgfa/prOp8oDsWqzAkJ77wH08/UGrlB4PyG3
   1WMXPclT3b2s302ijWMyHQkIxdr1kQs1IAKaJm9h+cD3LGDcFoVyJipJI
   D06eh4oMFWILF+VwUVmEY+DfCdiS+DG35HtUxk3WArSddhJ3jaYksyLVN
   kt3lp1V/qqp9Ed4tCfo99PXGkhzniUnsNeCicjYWoSHskGRPD2omsrgo2
   Zhh1O3qYMgdGxNLpe8G0dVnUUv7r5P7hCwb/alGnZ4WG26LQ7OoqA8hj7
   339HBA0hMkLMj7sqBBGPFU4uermuoJnsIxD6lM8T8VoaLbXwW2mFfJMmS
   A==;
X-CSE-ConnectionGUID: psCEj5PqSNeK9POdBJBaRA==
X-CSE-MsgGUID: xVYECm+1R1aF8ThWcM1o4w==
X-IronPort-AV: E=McAfee;i="6600,9927,11044"; a="9100625"
X-IronPort-AV: E=Sophos;i="6.07,202,1708416000"; 
   d="scan'208";a="9100625"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 01:55:15 -0700
X-CSE-ConnectionGUID: MdmfT+EbR4GxDJhEP4cbcw==
X-CSE-MsgGUID: TYzEqKJTSsSf99XL7W33NA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,202,1708416000"; 
   d="scan'208";a="21768088"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 01:55:13 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Avraham Stern <avraham.stern@intel.com>
Subject: [PATCH 10/11] wifi: iwlwifi: mvm: remove old PASN station when adding a new one
Date: Mon, 15 Apr 2024 11:54:43 +0300
Message-Id: <20240415114847.ef3544a416f2.I4e8c7c8ca22737f4f908ae5cd4fc0b920c703dd3@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240415085444.3840884-1-miriam.rachel.korenblit@intel.com>
References: <20240415085444.3840884-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Avraham Stern <avraham.stern@intel.com>

If a PASN station is added, and an old PASN station already exists
for the same mac address, remove the old station before adding the
new one. Keeping the old station caueses old security context to
be used in measurements.

Fixes: 0739a7d70e00 ("iwlwifi: mvm: initiator: add option for adding a PASN responder")
Signed-off-by: Avraham Stern <avraham.stern@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c b/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c
index c9000c878005..72a3d71f46f0 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c
@@ -53,6 +53,8 @@ int iwl_mvm_ftm_add_pasn_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	if (!pasn)
 		return -ENOBUFS;
 
+	iwl_mvm_ftm_remove_pasn_sta(mvm, addr);
+
 	pasn->cipher = iwl_mvm_cipher_to_location_cipher(cipher);
 
 	switch (pasn->cipher) {
-- 
2.34.1


