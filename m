Return-Path: <linux-wireless+bounces-7527-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6929F8C3512
	for <lists+linux-wireless@lfdr.de>; Sun, 12 May 2024 06:32:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8C64B21496
	for <lists+linux-wireless@lfdr.de>; Sun, 12 May 2024 04:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6383520B0F;
	Sun, 12 May 2024 04:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fafDqpBL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64511F959
	for <linux-wireless@vger.kernel.org>; Sun, 12 May 2024 04:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715488309; cv=none; b=P3lUZgMKK0ivam/ixjq1h+7s4RxcYq1e68NGH/W+N7VgjMvQOqLbI6RrDs774EQr9L5z331Y5bA/m89tZInQUI4SLmHLfpZqOFHKyD+i8A61rq5YPf2++oV1cL4yKx6ZOy0DnFm0CV9qqjUpXSiuHGUt8uw3cONyFuFK4ttZCBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715488309; c=relaxed/simple;
	bh=3VJUCJqEs2rPcnRDSaANpvGy3JYTuwoLNHQEGLVQ0xo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AJLPUJxMjupX/vLXWGjyLvvojHsUpq9Zn+BvifF6bqTkHhkiC268r+gqM3bkzht+OI/BKCAxzDw3U56ahJGiDrY85K4ZVQzyaMFYXnBbhMBcEb+BHoBhltZZaFQE8ECDSUl5X0Izg36nMlfF6DE7nTJ6MQL2OeG71DkDtAEGFkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fafDqpBL; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715488308; x=1747024308;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3VJUCJqEs2rPcnRDSaANpvGy3JYTuwoLNHQEGLVQ0xo=;
  b=fafDqpBLLDjh9CxlCEVYpz43kH9o9NWMZy2NMSv2ehRJNS97vqOe0JdE
   PgTX+eA/RyfMWSAY86dmM00wVEX393vLsqA9E3yf9zAHZXklcjDDD2VwY
   ezyh8ZGBpy0WI5U2sq5Qh7mOgsYbsU0oo6pEhAceNYiDzIzvrfgDhbQ2h
   dVILv3zRBEJ6aS9n8KqqGx21HabOu6BIFAJBeQ2e/HAg4tI7OKiy5o//a
   RgtmhHFc/zcg17K82fvCjvojyI4pFCLZH13Lw0whZMSZ6Gbwsgm2eTTTq
   fvIGXTYoxKywnV4RHcUtWmIbu4f3PvXiGRWfFmfiH8Q1Y3rXBUcO9BnQA
   g==;
X-CSE-ConnectionGUID: z5ig2rr5QA21NYWIr17ykQ==
X-CSE-MsgGUID: N8+3WQDiSraH8TltalqE8A==
X-IronPort-AV: E=McAfee;i="6600,9927,11070"; a="11323874"
X-IronPort-AV: E=Sophos;i="6.08,155,1712646000"; 
   d="scan'208";a="11323874"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2024 21:31:48 -0700
X-CSE-ConnectionGUID: cEFgAoTRQR2hBdoKJX3N8g==
X-CSE-MsgGUID: fPZj83moR8CkJJS5bl4oug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,155,1712646000"; 
   d="scan'208";a="34532204"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2024 21:31:46 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 16/16] wifi: iwlwifi: mvm: disable dynamic EMLSR when AUTO_EML is false
Date: Sun, 12 May 2024 07:31:10 +0300
Message-Id: <20240512072733.10a0b5da6ec2.I46fd578a3ef6cdbf14fdc4dfa97b4be008fe68e3@changeid>
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

When AUTO_EML is set to false, this change ignores the exit criteria,
for testing purposes. Currently, if AUTO_EML is disabled, the
driver will not select a link or enter EMLSR, but will still exit if one
of the criteria is not fulfilled.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/link.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/link.c b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
index 14dab617c0bd..fd8a21891d26 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/link.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
@@ -966,6 +966,9 @@ void iwl_mvm_exit_esr(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 
 	lockdep_assert_held(&mvm->mutex);
 
+	if (!IWL_MVM_AUTO_EML_ENABLE)
+		return;
+
 	/* Nothing to do */
 	if (!mvmvif->esr_active)
 		return;
@@ -1013,6 +1016,9 @@ void iwl_mvm_block_esr(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 
 	lockdep_assert_held(&mvm->mutex);
 
+	if (!IWL_MVM_AUTO_EML_ENABLE)
+		return;
+
 	/* This should be called only with disable reasons */
 	if (WARN_ON(!(reason & IWL_MVM_BLOCK_ESR_REASONS)))
 		return;
@@ -1099,6 +1105,9 @@ void iwl_mvm_unblock_esr(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 
 	lockdep_assert_held(&mvm->mutex);
 
+	if (!IWL_MVM_AUTO_EML_ENABLE)
+		return;
+
 	/* This should be called only with disable reasons */
 	if (WARN_ON(!(reason & IWL_MVM_BLOCK_ESR_REASONS)))
 		return;
-- 
2.34.1


