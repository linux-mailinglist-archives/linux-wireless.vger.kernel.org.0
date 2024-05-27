Return-Path: <linux-wireless+bounces-8131-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 369C68D088F
	for <lists+linux-wireless@lfdr.de>; Mon, 27 May 2024 18:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54F5AB327BA
	for <lists+linux-wireless@lfdr.de>; Mon, 27 May 2024 16:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0284F16A399;
	Mon, 27 May 2024 16:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HMGlzbU1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA1F16ABE7
	for <linux-wireless@vger.kernel.org>; Mon, 27 May 2024 16:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716826009; cv=none; b=Bw+2preU8gPrDOMXwswifKgyyfnIQEYBhsIRv3gZBfM7U/5Ygceijbwx4a2d7XQf4APagX7RLHs3IwgNH/78r99sfe/h0raQhXmvi1V5MePlAoEL81ZEVv/BbV7VBTVyVcpH5Lg+sUBnQAKlPqwUGGIJ7iRXIT4gBqjXarKSDUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716826009; c=relaxed/simple;
	bh=FLvfxp0U7BqlC8Yq/Rt+MPI38+vRUIWVRlWfWcdOyXA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pYiu+8WId2ZxGmqezJKgf8gv3WichxwGJ52gbFxhbwEUeW8is00tHfLoBC+iA17lL9OJxF9Z1HVJ2W8SqPCZ1l3TWET2aPn/H4Yno1JWKF5g/Tx7DQ4gsojOPqfdGJe6vbnOVtpzwdEEFqXJBpWiyW4B+iMj9DdWCSTgg0t5JwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HMGlzbU1; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716826009; x=1748362009;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FLvfxp0U7BqlC8Yq/Rt+MPI38+vRUIWVRlWfWcdOyXA=;
  b=HMGlzbU1X68RP68HaQIzxexD5WH1VMhDpq38Efvjr3fG/qdWMmlHQgtC
   LoAkCrMIHN8G8WABh3fElnpZM+HiZm3SQgAKB5jG2wFUAJX9HIlNeZIl8
   3o3B9TXVFKp6KQsMC4irTv2LknHBekoR9Xv1s4ajwEINOY+hpbfRfMKuV
   qpGcvjk8KORCh6rL53q467plXhkOGP/QcnO2yg878TgMrDVnoUr9cB4u7
   tU4Sp591VsDzwXpqyXOK8Kqrbec6O2ZHAvombdyoUWBQQv/afJTuVLs1f
   lrduM3AEzUR5Oz9r9ehLhqfVof9R/CSt1Gaf4VPQyXNym29+rrQLfuTEZ
   A==;
X-CSE-ConnectionGUID: cgu5JvOaTfqCdSVFzLVosg==
X-CSE-MsgGUID: Rpa5xgJLQfOliPCqxoT0Qw==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="13002119"
X-IronPort-AV: E=Sophos;i="6.08,193,1712646000"; 
   d="scan'208";a="13002119"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 09:06:49 -0700
X-CSE-ConnectionGUID: iktxY+hjTqO4PO7vTe8mIw==
X-CSE-MsgGUID: SA8ZSMpnSUSfOriTyUiuJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,193,1712646000"; 
   d="scan'208";a="35407135"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 09:06:48 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 17/20] wifi: iwlwifi: mvm: fix a wrong comment
Date: Mon, 27 May 2024 19:06:12 +0300
Message-Id: <20240527190228.2105ffcf747d.Ic838959b812b6cb4cbb856e8c0bcaad2f46ac71b@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240527160615.1549563-1-miriam.rachel.korenblit@intel.com>
References: <20240527160615.1549563-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
index 0e88629f695a..d5a204e52076 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
@@ -241,7 +241,7 @@ int iwl_mvm_mld_add_bcast_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 				       IWL_MAX_TID_COUNT, &wdg_timeout);
 }
 
-/* Allocate a new station entry for the broadcast station to the given vif,
+/* Allocate a new station entry for the multicast station to the given vif,
  * and send it to the FW.
  * Note that each AP/GO mac should have its own multicast station.
  */
-- 
2.34.1


