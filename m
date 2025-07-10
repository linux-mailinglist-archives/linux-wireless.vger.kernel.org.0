Return-Path: <linux-wireless+bounces-25214-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6D99B00B63
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jul 2025 20:29:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 137055C10B4
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jul 2025 18:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18ADB2F0E29;
	Thu, 10 Jul 2025 18:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UUk0px3u"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8A02FD582
	for <linux-wireless@vger.kernel.org>; Thu, 10 Jul 2025 18:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752172148; cv=none; b=HITlxpMOHVOokG+B3oVlHBkmL3chlcT9Fx/12fit6CUX/bRhWlpNYgW+lFUzNgZ9P++zAcoZ86WAWMnEzG4zYdP8APDEntWPJqU6QkKnJMV/Nt/CGG/37EGLSpPUHdFTR5hrXovxdQQrl5HOk0G4JHN0p05iEJB5LB783ZDqf0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752172148; c=relaxed/simple;
	bh=LmHDryUcln1yGNqcaUDZ4rlcu9VBcZfXAjvsM5C3C00=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aR6bjaulSsE12Ju+5ft5SWTJKcBeza8OiF5qmUdr21bVq19NZSh+Rfgg/ttNhIb9r5vi/sa+WXpm/1bSnH9LHhUBOPevBxweZxo54Rnj/hNzPUrTQXw0J5ZW47nt7UqheVGSFE443Rj6fnkMFrSdMf9f1MFXVa3+mcnbaraX+8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UUk0px3u; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752172146; x=1783708146;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LmHDryUcln1yGNqcaUDZ4rlcu9VBcZfXAjvsM5C3C00=;
  b=UUk0px3uogqVpq6GnIQstIHYU9ca3mqTDj6Ag4yFe2nBsumP3zg1UCE6
   E0fIA02ifKAQcAF0a9PfYLKi02BKPVZ62qyCzAx/XKtajAS9QXXNMKyNo
   ITOFxuvNXHawN5qLVxRUq/28FNkeD1cZKCeF9tNPmgisBPNqAEEttCRq0
   024e7qICol5X3YwA0QBAPgemhI1Z295PuCu+HD4jb0eo/Un+sCa+EfyUp
   wQuTHKf23zR2T++xLTtqI5T3OFoDAXXN14vq3JVJs2AUKt3YlbvnFPT73
   DsYRcIg/ck/zPiMSiHZZ0ooNY2sYVDvI+N/jVyFwQlJ8vPxkdeYgFst4A
   w==;
X-CSE-ConnectionGUID: tpKxQkMURF2LnS2qIvUBHg==
X-CSE-MsgGUID: JyUyRWK8T+SVZmeKrj5u2w==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="57077806"
X-IronPort-AV: E=Sophos;i="6.16,301,1744095600"; 
   d="scan'208";a="57077806"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 11:29:06 -0700
X-CSE-ConnectionGUID: iA6fzFb0QBuOaz/6AsaDuQ==
X-CSE-MsgGUID: 2SpzCzzxRU6WmyEikneIfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,301,1744095600"; 
   d="scan'208";a="160718739"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 11:29:05 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 10/15] wifi: iwlwifi: mvm: set gtk id also in older FWs
Date: Thu, 10 Jul 2025 21:28:27 +0300
Message-Id: <20250710212632.e91e49590414.I27d2fdbed1c54aee59929fa11ec169f07e159406@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250710182832.2615019-1-miriam.rachel.korenblit@intel.com>
References: <20250710182832.2615019-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

We use gtk[i].id, but it is not even set in older FW APIs
(iwl_wowlan_status_v6 and iwl_wowlan_status_v7).
Set it also in older FWs.

Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index d9d678fbdaab..546fda8de5de 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -2210,6 +2210,7 @@ static void iwl_mvm_convert_gtk_v2(struct iwl_wowlan_status_data *status,
 
 	status->gtk[0].len = data->key_len;
 	status->gtk[0].flags = data->key_flags;
+	status->gtk[0].id = status->gtk[0].flags & IWL_WOWLAN_GTK_IDX_MASK;
 
 	memcpy(status->gtk[0].key, data->key, sizeof(data->key));
 
@@ -2532,6 +2533,7 @@ iwl_mvm_send_wowlan_get_status(struct iwl_mvm *mvm, u8 sta_id)
 		 * currently used key.
 		 */
 		status->gtk[0].flags = v6->gtk.key_index | BIT(7);
+		status->gtk[0].id = v6->gtk.key_index;
 	} else if (notif_ver == 7) {
 		struct iwl_wowlan_status_v7 *v7 = (void *)cmd.resp_pkt->data;
 
-- 
2.34.1


