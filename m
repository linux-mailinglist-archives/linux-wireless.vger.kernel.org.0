Return-Path: <linux-wireless+bounces-7513-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D3C88C3504
	for <lists+linux-wireless@lfdr.de>; Sun, 12 May 2024 06:31:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EE0F1C20ECA
	for <lists+linux-wireless@lfdr.de>; Sun, 12 May 2024 04:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54E93F510;
	Sun, 12 May 2024 04:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ealu3xfE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D749CA62
	for <linux-wireless@vger.kernel.org>; Sun, 12 May 2024 04:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715488290; cv=none; b=ezTf5RdwIt0MFVRDOdSUfc2qDEuATKihKi3fxxnZAw3jZIs9mB9CElLUG3UrrQ2EsRkHA5lfsUE/x67a/1BQBCmudWBi5xjhxCG/WPaEVDHVXPj06j+SMlg47BWRiXT4IdO/5g2/LQMUVgw5y3erLD1NBc3Z5y+GFSj33IVh4fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715488290; c=relaxed/simple;
	bh=RgKQaIO5oUvr9SguXC1vzmIPGzuwaTQqlUeVClg3Cbk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mDh3MgWt87wDMHpmoU6EA+Far6aY+crjoeGWK/l+MMvFUWsjcUgegGSU+62oyszx4rQl0VbCsWshcfAhScWHKM3D0GkJmHqjsGnKHJKQumYrTEWSZ6E7hQ1/wfmOyet8+iJy/zRtFkIrDz+hhB0Zh+1WxSoUZmu0OoD/bJZPQW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ealu3xfE; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715488288; x=1747024288;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RgKQaIO5oUvr9SguXC1vzmIPGzuwaTQqlUeVClg3Cbk=;
  b=ealu3xfEQ09f4Y0AQYDpbHjuoesN5CwCL2iN2vKI6luWwRk4aDK+8a2i
   Hm/uZNS9o7X3w5I0r2Z6/KxBVL1Qm6ggdWqeTdkt6DztFcgZcSbuJXt+P
   X+fQQNYOnQfDcyUhz8B36kfbDkYY9tCU5aQWwbcYrvvwiOY3APSPehhPq
   QF4EnBFpTR7D496qEavQVLvl5tQ1HxRcrXUslsSkoGWk2vsms/TiTjP9f
   suYNtYpH+1BKrEqZgqRdMC7iCpR8KF+lhOpxrVYLUMluvWRV+yLBkehft
   hV8XNYhF4a1rWNaN+NleyAwVhruFcsch+ct/llkdD5eY2vhwicyokZG6G
   w==;
X-CSE-ConnectionGUID: dUHIs2ddQgaWOo6at7cqjw==
X-CSE-MsgGUID: 1iNzks8KSUCtP2MrVMbRJA==
X-IronPort-AV: E=McAfee;i="6600,9927,11070"; a="11323836"
X-IronPort-AV: E=Sophos;i="6.08,155,1712646000"; 
   d="scan'208";a="11323836"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2024 21:31:28 -0700
X-CSE-ConnectionGUID: FaR1NimXQZqrV8ffzZ4v1g==
X-CSE-MsgGUID: kkyrKoqKQfyzv4ZscmlJZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,155,1712646000"; 
   d="scan'208";a="34532146"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2024 21:31:27 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 02/16] wifi: iwlwifi: mvm: Use the SMPS cfg of the correct link
Date: Sun, 12 May 2024 07:30:56 +0300
Message-Id: <20240512072733.f3e2834e78f5.Ie24b431a6ad0dbf977afbbd4d2116bfe2426a0d5@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240512043110.3413383-1-miriam.rachel.korenblit@intel.com>
References: <20240512043110.3413383-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

The exiting code is checking the SMPS mode of deflink.
Use the SMPS mode of the link_sta function parameter.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
index b7a461dba41e..3b2875f2cab7 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
@@ -470,7 +470,7 @@ static int iwl_mvm_mld_cfg_sta(struct iwl_mvm *mvm, struct ieee80211_sta *sta,
 		break;
 	}
 
-	switch (sta->deflink.smps_mode) {
+	switch (link_sta->smps_mode) {
 	case IEEE80211_SMPS_AUTOMATIC:
 	case IEEE80211_SMPS_NUM_MODES:
 		WARN_ON(1);
-- 
2.34.1


