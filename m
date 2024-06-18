Return-Path: <linux-wireless+bounces-9217-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74AC090DA31
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Jun 2024 19:03:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34E3C28501C
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Jun 2024 17:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D0CC39AEC;
	Tue, 18 Jun 2024 17:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fyQUCP3f"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69465446DE
	for <linux-wireless@vger.kernel.org>; Tue, 18 Jun 2024 17:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718730196; cv=none; b=YoaoUmnbqRmFXhS7jpKDWT5Takwiq52LILNeXxEiCyJrPL5K0Sok0GjdH1opKK5tFWHOxtCjzf09rsdotA4pWsj6QpmsS9p3jWrBE7tBhfSa6QR1wGKKxk+SjWL1GkDnCdomJhpRm4bH/s5BJHAAVQ++TYyYyvoX1I+WPmdMLJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718730196; c=relaxed/simple;
	bh=WvFpU/C0Qq9GwBQ3eESwpgR+YsjyPi9QjqJhJJJsFCE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ANTbHjQbjq/dAks5uBLrsZgkUQH4WfsFmHGp7+I3gOpYBs+WS9sU6v9xHBTPUR2ibWIZzAlDvDuRMNg57O49wqofqWP7ABfoioN7x1YBtfVG5T2Lr33TTrU5CebJgnN0ReJIhZtVhY5L4Fo1v3kIDsztmDoTSbdKc3zgGzqmnPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fyQUCP3f; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718730194; x=1750266194;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WvFpU/C0Qq9GwBQ3eESwpgR+YsjyPi9QjqJhJJJsFCE=;
  b=fyQUCP3fyWu2iN3QS//sk4DlBtIdPG45f7xcNg0xjqTONockoT8mx7d/
   Ke6JO+negQK28G5ZNMVCvGbaxmZhwAhcQvP+ADwjtozXFflRCyAuFImoh
   bsBHnVpv+p3FAe3S4ROt9PIGMTNAw8yBvGznbkeANMtUOvMoD5c38DmpC
   CcZd3BHIpx/XY+rpd1usU7ySVm23iuJrapjyPggesVq2Ujm3nuzi979h1
   FOPRlDnOKnxwYpuZj6F3yD3morPbxkLOPD1Zdv/bu9M1QnX0lrEPM7xwY
   6D4pqcZNPSwXHyc+3sG47seaV+gFBk0s9VKuSdiYuexuZ1SQe3abUaWGZ
   Q==;
X-CSE-ConnectionGUID: 5kCuuDpuS9KZjxC0jfVh4Q==
X-CSE-MsgGUID: 0aM/EnosSE+BlOYVGsD68w==
X-IronPort-AV: E=McAfee;i="6700,10204,11107"; a="33094005"
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="33094005"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 10:03:14 -0700
X-CSE-ConnectionGUID: hMg44sTPTTuZoATv7F9Iew==
X-CSE-MsgGUID: ueZNVs52R8S97LIpMDb86g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="46541785"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 10:03:13 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH 2/3] wifi: iwlwifi: mvm: unify and fix interface combinations
Date: Tue, 18 Jun 2024 20:03:02 +0300
Message-Id: <20240618200104.3213638262ef.I2a0031b37623d7763fd0c5405477ea7206a3e923@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240618170303.2438911-1-miriam.rachel.korenblit@intel.com>
References: <20240618170303.2438911-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

AP interfaces fundamentally cannot leave the channel, so multi-
channel operation with them isn't really possible. We shouldn't
advertise support for such, at least not as long as we don't
have full multi-radio support. Thus, remove the AP bit from the
interface combinations for two channels and add another set for
just one channel that has it.

Also, to avoid duplicating everything even more, unify the NAN
and non-NAN cases.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 43 ++++++++++++-------
 1 file changed, 28 insertions(+), 15 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 18ce060df9b5..eeec425dc4d5 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -30,21 +30,28 @@
 #include "iwl-nvm-parse.h"
 #include "time-sync.h"
 
+#define IWL_MVM_LIMITS(ap)					\
+	{							\
+		.max = 1,					\
+		.types = BIT(NL80211_IFTYPE_STATION),		\
+	},							\
+	{							\
+		.max = 1,					\
+		.types = ap |					\
+			 BIT(NL80211_IFTYPE_P2P_CLIENT) |	\
+			 BIT(NL80211_IFTYPE_P2P_GO),		\
+	},							\
+	{							\
+		.max = 1,					\
+		.types = BIT(NL80211_IFTYPE_P2P_DEVICE),	\
+	}
+
 static const struct ieee80211_iface_limit iwl_mvm_limits[] = {
-	{
-		.max = 1,
-		.types = BIT(NL80211_IFTYPE_STATION),
-	},
-	{
-		.max = 1,
-		.types = BIT(NL80211_IFTYPE_AP) |
-			BIT(NL80211_IFTYPE_P2P_CLIENT) |
-			BIT(NL80211_IFTYPE_P2P_GO),
-	},
-	{
-		.max = 1,
-		.types = BIT(NL80211_IFTYPE_P2P_DEVICE),
-	},
+	IWL_MVM_LIMITS(0)
+};
+
+static const struct ieee80211_iface_limit iwl_mvm_limits_ap[] = {
+	IWL_MVM_LIMITS(BIT(NL80211_IFTYPE_AP))
 };
 
 static const struct ieee80211_iface_combination iwl_mvm_iface_combinations[] = {
@@ -52,7 +59,13 @@ static const struct ieee80211_iface_combination iwl_mvm_iface_combinations[] = {
 		.num_different_channels = 2,
 		.max_interfaces = 3,
 		.limits = iwl_mvm_limits,
-		.n_limits = ARRAY_SIZE(iwl_mvm_limits),
+		.n_limits = ARRAY_SIZE(iwl_mvm_limits) - 1,
+	},
+	{
+		.num_different_channels = 1,
+		.max_interfaces = 3,
+		.limits = iwl_mvm_limits_ap,
+		.n_limits = ARRAY_SIZE(iwl_mvm_limits_ap) - 1,
 	},
 };
 
-- 
2.34.1


