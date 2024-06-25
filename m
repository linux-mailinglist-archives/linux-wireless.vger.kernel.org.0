Return-Path: <linux-wireless+bounces-9537-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35916916E74
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jun 2024 18:52:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0F9C1F22A07
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jun 2024 16:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3BC017622B;
	Tue, 25 Jun 2024 16:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MjUDJrLn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E65B172BB4
	for <linux-wireless@vger.kernel.org>; Tue, 25 Jun 2024 16:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719334298; cv=none; b=ccxlHSKIOZOEbGjjcB+TEFdTna7v9RvrNhcftoY56ZKiPXGy0OXfppTCUR5DRIb7JRXW2YlAwliLcu480Ur27u579kAtUAu92NY3uD3Yujxf9hc0COeox6sPIy+A5SiABA04nQXcuyylARXJOQ3IGcaBGkS8YpQnB4XOkYDCPBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719334298; c=relaxed/simple;
	bh=31APgIriBk1fN5qtnInzQu9SHVUF5UTSXdyO4JMpMHk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B/GEG/rgxgPCOQq2iVgfpSyqRkDpRLKArs3Q8QliklCA7MQMwRDfLpWlvXnJZ0IIifutAzPc/09My3lZXOx8cwZuZElIT3G6suO/UNCMGtcwkGow1plNK8K3KAOVXGer/wIPMUmEi9c4TdiiwBUhU4Kx4m63xL7RbPyCN45BzJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MjUDJrLn; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719334297; x=1750870297;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=31APgIriBk1fN5qtnInzQu9SHVUF5UTSXdyO4JMpMHk=;
  b=MjUDJrLnN8ApaDGe9bq/qKocGgnL55u7kVW7KtrqSsFm9Q8UTX0d/ohy
   E9lEBXRNRawDe61tcpc6osw4Svx7sEtvMgFwjCgNdqlumRjb2o0MKb+4w
   sHxxHpshVKB9TKDZ12uhtpnKcu+hTVJPbyI2j9xDwWEZA+ykyh96PhcaO
   T+P3U4azOSaE0/59SOE+jZha9J+BxKSSAWQvQ5pX6oC+NLe7IvyIbZQGB
   /AEHaQv00mxhuIKZfqnwJtqfox/yXg+0AbW7Sg+wB1jTCDgOiNJzAiO3G
   Vfly938ibgLLXfSywdDQqLDRLlwB6Zmquvh7hewB1Qg44GUe7SoQQHmZd
   Q==;
X-CSE-ConnectionGUID: DEgvcxRMQP26pRN62xyPXA==
X-CSE-MsgGUID: EBxiUXKSRuKKLjdrektHyQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11114"; a="16594695"
X-IronPort-AV: E=Sophos;i="6.08,264,1712646000"; 
   d="scan'208";a="16594695"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 09:51:36 -0700
X-CSE-ConnectionGUID: jP5YFY+ORf22lSHA8n2dUg==
X-CSE-MsgGUID: Li2ZHlaCRNKfvqgaVFVisQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,264,1712646000"; 
   d="scan'208";a="48632477"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 09:51:35 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 03/17] wifi: iwlwifi: mvm: use IWL_FW_CHECK for link ID check
Date: Tue, 25 Jun 2024 19:51:09 +0300
Message-Id: <20240625194805.4ea8fb7c47d4.I1c22af213f97f69bfc14674502511c1bc504adfb@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240625165123.1624974-1-miriam.rachel.korenblit@intel.com>
References: <20240625165123.1624974-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

The lookup function iwl_mvm_rcu_fw_link_id_to_link_conf() is
normally called with input from the firmware, so it should use
IWL_FW_CHECK() instead of WARN_ON().

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index e51e834902a9..8eeb405e4326 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1460,7 +1460,8 @@ iwl_mvm_rcu_dereference_vif_id(struct iwl_mvm *mvm, u8 vif_id, bool rcu)
 static inline struct ieee80211_bss_conf *
 iwl_mvm_rcu_fw_link_id_to_link_conf(struct iwl_mvm *mvm, u8 link_id, bool rcu)
 {
-	if (WARN_ON(link_id >= ARRAY_SIZE(mvm->link_id_to_link_conf)))
+	if (IWL_FW_CHECK(mvm, link_id >= ARRAY_SIZE(mvm->link_id_to_link_conf),
+			 "erroneous FW link ID: %d\n", link_id))
 		return NULL;
 
 	if (rcu)
-- 
2.34.1


