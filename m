Return-Path: <linux-wireless+bounces-18524-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 036F2A28AFC
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Feb 2025 13:56:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38D4A3A00F2
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Feb 2025 12:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1236D199B9;
	Wed,  5 Feb 2025 12:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cV1OYz/O"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14D612B94
	for <linux-wireless@vger.kernel.org>; Wed,  5 Feb 2025 12:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738760177; cv=none; b=nZk7nvaADt41klBRVC7aRvu8++/wbJ+jOC7q67VgD6BB/FACv20Vwdzr88Vh25AKvl6z+3mvu3a13Na+lqFMjnYJGYQJJxmXnVJb6jYKmCZ2gh2b1jQCla8Mx6bZ8NdaVy6fesT9WbUd63ydE8j+WdH/GQk+otfQNOgWZmezeUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738760177; c=relaxed/simple;
	bh=oaEJlJYJdPwB7fLpRjY+KWVl/b11cKJdGvAwOzJEjNc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FWsU0kpUEnXElmHl46BywDoI7Nd53nwc2KaupKebhI7E99+1E+Sp1e9++qlMGZM2VYGwqAso93jDQC75hfSMExIbx7xZk2PHaKje2BaK+3m78Ll0Kud069Rqxp5Y2q4ZHNntExXSJSrif086RYJIoFHp6NkYj0s33uNOz/+8W/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cV1OYz/O; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738760175; x=1770296175;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oaEJlJYJdPwB7fLpRjY+KWVl/b11cKJdGvAwOzJEjNc=;
  b=cV1OYz/OQi/p+uChvle1UqW7uEF7A5bu4I6jWjmHVyZopkejoxiOipmL
   klPtWhjD0rLIkq1fQemR38gSmYXRBPjwNesZzlEtIWxUw57u1ELNJ2qXc
   2oaBjoFKkqNWat+V9XejqSp8CS6dNqGeWn7NWJKeJwuLR6WBfuD+ZKy2w
   sSXydpvt435Wqnj8fZkZKV/WMOOYQWVaESs68RkSrW3gd71ds0bt0K6eT
   mkwlZ7gTEhs4nVE3gYXqaOmtAKedQbK3bd2n2Co2aqi8eEBWHOGvfdagh
   68PpSgkTjW50av4zBdRf5mwwHhk+cDEXHeTR/Ba905jhwjBYjgJW8BhwX
   g==;
X-CSE-ConnectionGUID: CzDh+33qQlm+pw+OztntmQ==
X-CSE-MsgGUID: 7I+34TugR+e38ZgyOM7CGA==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="42159180"
X-IronPort-AV: E=Sophos;i="6.13,261,1732608000"; 
   d="scan'208";a="42159180"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 04:56:14 -0800
X-CSE-ConnectionGUID: w/sehM+ZQCikCTB0cHw5sw==
X-CSE-MsgGUID: cB0wlffPQRy/IthAb//nSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="110745460"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 04:56:13 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 06/19] wifi: iwlwifi: don't warn during reprobe
Date: Wed,  5 Feb 2025 14:55:35 +0200
Message-Id: <20250205145347.76425b10e5a0.I3bf0de2eb090a8b94c4e36d93dd91df61fadb808@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250205125548.1963070-1-miriam.rachel.korenblit@intel.com>
References: <20250205125548.1963070-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

During reprobe, the sw state is being destroyd, and so is the
connection. When the peer STA is being removed, the opmode sends a
command to flush the TXQs of the STA and uses iwl_trans_wait_txq_empty.

This one warns if the FW is not alive, but it really shouldn't if
there is a FW error - and return silently instead, just like we do when
sending a hcmd.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-trans.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.c b/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
index 49c8507d1a6b..8ba24903a870 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
@@ -671,6 +671,9 @@ IWL_EXPORT_SYMBOL(iwl_trans_txq_enable_cfg);
 
 int iwl_trans_wait_txq_empty(struct iwl_trans *trans, int queue)
 {
+	if (unlikely(test_bit(STATUS_FW_ERROR, &trans->status)))
+		return -EIO;
+
 	if (WARN_ONCE(trans->state != IWL_TRANS_FW_ALIVE,
 		      "bad state = %d\n", trans->state))
 		return -EIO;
-- 
2.34.1


