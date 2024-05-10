Return-Path: <linux-wireless+bounces-7470-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 417B18C2662
	for <lists+linux-wireless@lfdr.de>; Fri, 10 May 2024 16:09:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B50F0B2350E
	for <lists+linux-wireless@lfdr.de>; Fri, 10 May 2024 14:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2F00171E41;
	Fri, 10 May 2024 14:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fnvFeQqE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E96A171E54
	for <linux-wireless@vger.kernel.org>; Fri, 10 May 2024 14:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715350031; cv=none; b=FqdVFGtIaTOntdyZAa4nKYsqanSQ65t/9qZKSyW6T3Q1bMic8xm2vNBMEB7wcMlUynxSPnfahdbd66HMr28Wfxa7D1yspVKVX2d8s5fDsK/h1qIwl9Vl0EUelAocaUySJJU1EnzUfJWeZUHUbozBLY4xD4z1/PRKH78bFVaC9UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715350031; c=relaxed/simple;
	bh=cVl7xL+li1upr2/hoHaQWEvNvL3sO6aaPXd7UJLwUPY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uuZ/QK4EPFXxCWwpHqMl4eKWQd9wv/mwVOpkzaPUzs7osnOYkcT+82hmF2yGrzWaU/DlE5/d2XiuG+nnBsK/iifJN9vqdpe19vsmRWj1uH9jGjOwMQcH/f2MfpdguJlrIo4MIH5A5yxpIPp7QF89Aku7b9SSjtUjf2fjuOKyy7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fnvFeQqE; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715350030; x=1746886030;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cVl7xL+li1upr2/hoHaQWEvNvL3sO6aaPXd7UJLwUPY=;
  b=fnvFeQqElQhw5vvTf/KPSvGi/4rzgmPUF0tiHmdHeeQ+sXeOQ9yP3io2
   KnWokuSdS2vxZdxRxlQy0ponGOAmP4ycPLIBq7gdnAUdJPbnoH1HlR0Gg
   HXlSabIoJVFeOObaQkp5TTqg2Vh37wLx+pnyj9lG68Xa9eLRJsNQaUMY7
   lbJ/gYoJsD8sBePFkeMvK12tU+17DBOsI56p+wWh1+tRCloKZanzFWODu
   DaGjpd0hryfKyAkztkDll+xcKNiTCnRTHzyZeU/SPFb5pj84+UgdE1QjE
   mGZRLwHNsTA6AWuKC4eeX8yJGLzJ8KWgffn5lfqaHz74xFt/dTUfV7u+d
   w==;
X-CSE-ConnectionGUID: zrPibQ5USAK2TIbYY2Vcpw==
X-CSE-MsgGUID: cRGx41aYT/itM2sEjwookw==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="15125587"
X-IronPort-AV: E=Sophos;i="6.08,151,1712646000"; 
   d="scan'208";a="15125587"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 07:07:09 -0700
X-CSE-ConnectionGUID: BugP9L5eRzGDk4Do97H+tg==
X-CSE-MsgGUID: d0Ru8/UMTH6GCg3MzX6hmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,151,1712646000"; 
   d="scan'208";a="67101881"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 07:07:09 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 10/14] wifi: iwlwifi: mvm: call ieee80211_sta_recalc_aggregates on amsdu size update
Date: Fri, 10 May 2024 17:06:37 +0300
Message-Id: <20240510170500.632ee6612a79.Ice3a536a4cbfe60d0edfa231fcb79ee7ab9495dd@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240510140641.1895860-1-miriam.rachel.korenblit@intel.com>
References: <20240510140641.1895860-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

The driver needs to call this function when the amsdu size changes.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
index 031b5e70d181..05715e5af6ab 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
@@ -514,6 +514,8 @@ void iwl_mvm_tlc_update_notif(struct iwl_mvm *mvm,
 				link_sta->agg.max_tid_amsdu_len[i] = 1;
 		}
 
+		ieee80211_sta_recalc_aggregates(sta);
+
 		IWL_DEBUG_RATE(mvm,
 			       "AMSDU update. AMSDU size: %d, AMSDU selected size: %d, AMSDU TID bitmap 0x%X\n",
 			       le32_to_cpu(notif->amsdu_size), size,
@@ -654,6 +656,7 @@ void iwl_mvm_rs_fw_rate_init(struct iwl_mvm *mvm,
 	 * that only vht/ht is used and also set it as station max amsdu
 	 */
 	link_sta->agg.max_amsdu_len = max_amsdu_len;
+	ieee80211_sta_recalc_aggregates(sta);
 
 	cfg_cmd.max_tx_op = cpu_to_le16(mvmvif->max_tx_op);
 
-- 
2.34.1


