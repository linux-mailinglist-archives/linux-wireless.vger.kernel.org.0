Return-Path: <linux-wireless+bounces-24320-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25B4CAE321F
	for <lists+linux-wireless@lfdr.de>; Sun, 22 Jun 2025 22:56:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FC573A264D
	for <lists+linux-wireless@lfdr.de>; Sun, 22 Jun 2025 20:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E93D220D4FD;
	Sun, 22 Jun 2025 20:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nASJAp/s"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35160209F46
	for <linux-wireless@vger.kernel.org>; Sun, 22 Jun 2025 20:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750625812; cv=none; b=IaxRtxOFReGmM/acjo8+qwuYwWR5RCdLb/jP/vWAhd68ki/LQvnAICR1VzfcDgWsF4wjx9UrPCyu8/Q+BqeeuYzmZ6HNsVV8SzcQ2njRfoH0iKJ+5XL/1VKO/6JBZh3y/3mE+HLe1Lk+zv+cI5HG6Ej+cWyqsosu5e7AcabMdZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750625812; c=relaxed/simple;
	bh=fwr+8ShB8Zi7khmOMFLwvZtxIp+Utk4Zk2t5+vkUnE8=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=MYIXkOQYqzHa3aQYogb0bqLA7u7+C+HGbgFmJvY5Z87KYYwK4ZYhyXXnalLgI8TzZhOypjLRbX4MVThhVJ93urwTjwgNMKPv3VPJ+x4gmViLd5hG1DmLzKEi+OQwQgwryV9oQHerSWObqAZVb++GqC8LhffYTtTneaIiUUMnfxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nASJAp/s; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750625810; x=1782161810;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=fwr+8ShB8Zi7khmOMFLwvZtxIp+Utk4Zk2t5+vkUnE8=;
  b=nASJAp/sjIdt85E0KgmwqEizdOaCs4gh1fU1j3+GXUUihuUtDmpf4N2E
   A6qZAWhhusjkCMqmKRKSCQji6g3mh73RIzt7LOh3RUHoW9u2gw+jzDosG
   73v0ISOUtz4s7AWIgZWXA5DUDS6GeSt1G6KUtu1Dwnd4PjbJMOAoHG/TA
   YmL9jxBbxMLRlzng+AfVEbTq8qEpiBLUZzlkQJPQWFzYDeUf3kklKUpgC
   Qc2taX9X4iSqgwb5Kue9BHgiMpblU9B/HJVAhIYeM2wylKbAHzuEIq0tk
   ZzfK6OHWcRb5n/8lIc4+EV+E3HKmIlGIDiR7r5h5MkDxGplVzEA8gejd4
   Q==;
X-CSE-ConnectionGUID: zcCU9ZwTTQmaapbPDxhTCQ==
X-CSE-MsgGUID: ZSuP/rX1RNyOrhzgYycvBw==
X-IronPort-AV: E=McAfee;i="6800,10657,11472"; a="52912983"
X-IronPort-AV: E=Sophos;i="6.16,257,1744095600"; 
   d="scan'208";a="52912983"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2025 13:56:50 -0700
X-CSE-ConnectionGUID: Nvui9/GuTnW/2/ICJj0gEg==
X-CSE-MsgGUID: Qqk7jIVwTJKVNVUXvSm0Ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,257,1744095600"; 
   d="scan'208";a="151928754"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2025 13:56:48 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Subject: [PATCH iwlwifi-fixes] wifi: iwlwifi: mvm: assume '1' as the default mac_config_cmd version
Date: Sun, 22 Jun 2025 23:56:31 +0300
Message-Id: <20250622235542.66160fc997da.Iba487b3addfad95e51c7d5ad79c962be3eab046f@changeid>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

Unfortunately, FWs of some devices don't have the version of the
iwl_mac_config_cmd defined in the TLVs. We send 0 as the 'def argument
to  iwl_fw_lookup_cmd_ver, so for such FWs, the return value will be 0,
leading to a warning, and to not sending the command.

Fix this by assuming that the default version is 1.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mld-mac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac.c
index 3c255ae916c8..48ab6a2a98cc 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac.c
@@ -32,7 +32,7 @@ static void iwl_mvm_mld_mac_ctxt_cmd_common(struct iwl_mvm *mvm,
 	unsigned int link_id;
 	int cmd_ver = iwl_fw_lookup_cmd_ver(mvm->fw,
 					    WIDE_ID(MAC_CONF_GROUP,
-						    MAC_CONFIG_CMD), 0);
+						    MAC_CONFIG_CMD), 1);
 
 	if (WARN_ON(cmd_ver < 1 || cmd_ver > 3))
 		return;
-- 
2.34.1


