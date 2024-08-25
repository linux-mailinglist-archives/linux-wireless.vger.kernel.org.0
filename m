Return-Path: <linux-wireless+bounces-11906-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21FA895E442
	for <lists+linux-wireless@lfdr.de>; Sun, 25 Aug 2024 18:17:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6D2828194A
	for <lists+linux-wireless@lfdr.de>; Sun, 25 Aug 2024 16:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFC202119;
	Sun, 25 Aug 2024 16:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lOFMyQUg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA343D62
	for <linux-wireless@vger.kernel.org>; Sun, 25 Aug 2024 16:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724602647; cv=none; b=Z+s2LdUbmX5YU58DPY/9fwdWRg3pRqlgYaHIARphT2fRwSVaU2d4j2b1QBZdN7C6v3MlqC1OZpuZLeTGVDVgddthk+seh1wK2MnnKK8vUKnVMeEOTINRvI97UCWvVsLQwBJjX4OD6QQRFjNQm8nGPC1q3Q0aKLv4lCM3Yq9iXFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724602647; c=relaxed/simple;
	bh=bIY3OQaAg60s4nl8POxPLxdBAv21lmsQr+rSfG+Z0Xc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jrB2rrw9ISn1fO0/z0mcjhF6BV//Pm87oyEmsmF0kIKAOKEo1hktIkjzIVbuML0l91rZXRDfvFJfOyLgzzzK1kIH0tFlojoyNyS8/SzeE3RjPsBZFX6ymPcfmsCAh5URDZihkY8DqX7vmeZxQDsswhCoPByRxD8UoyI9Wnp3dyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lOFMyQUg; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724602645; x=1756138645;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bIY3OQaAg60s4nl8POxPLxdBAv21lmsQr+rSfG+Z0Xc=;
  b=lOFMyQUgoH45GRq8jjkFpM77gqtkGR4+0dneHbbecHKpj+Kz6Q4ep8kr
   mFAmwhxBboUfVX+ZJccAerXu8q92pSUNfaX1q/xKEBHvTAKBYQTr61o0K
   COSeCUJ16reCHq2mjdHOJPgKcAXekMnkY9KJJeZ9cqmWPkCzSDVGDYsla
   ykwoTGqxC51q7/cjWOpQcjP4MjWO+LSv15K0Bi64+WtULk6mTIpkcnAGu
   qaAOjnEg/OMM0C8TfBHo3me7lJlAO0Dqt9GG1+2iWwo6kqNHgDQn2MCZP
   p9/yWoPys6KfaK13d+euDr1zStgXDFyN37e3NgSJiSEcKJsRsIZyJCKax
   A==;
X-CSE-ConnectionGUID: LDc7lwIsQsW9FgnrqnsTHQ==
X-CSE-MsgGUID: qwi3wqhnTaKlLQzNgEA+bg==
X-IronPort-AV: E=McAfee;i="6700,10204,11175"; a="22544116"
X-IronPort-AV: E=Sophos;i="6.10,175,1719903600"; 
   d="scan'208";a="22544116"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2024 09:17:25 -0700
X-CSE-ConnectionGUID: smoCX8MeTmGXUK3F905Pww==
X-CSE-MsgGUID: hzC/a5FtRbOdtnGQRXVYow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,175,1719903600"; 
   d="scan'208";a="62999725"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2024 09:17:23 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH 01/13] wifi: iwlwifi: clear trans->state earlier upon error
Date: Sun, 25 Aug 2024 19:17:01 +0300
Message-Id: <20240825191257.9d7427fbdfd7.Ia056ca57029a382c921d6f7b6a6b28fc480f2f22@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240825161713.3547021-1-miriam.rachel.korenblit@intel.com>
References: <20240825161713.3547021-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

When the firmware crashes, we first told the op_mode and only then,
changed the transport's state. This is a problem if the op_mode's
nic_error() handler needs to send a host command: it'll see that the
transport's state still reflects that the firmware is alive.

Today, this has no consequences since we set the STATUS_FW_ERROR bit and
that will prevent sending host commands. iwl_fw_dbg_stop_restart_recording
looks at this bit to know not to send a host command for example.

In the next patch, we will need to reset the firmware without having an
error and checking STATUS_FW_ERROR to see whether the firmware is alive
will no longer hold.

Change the flow a bit.
Change trans->state before calling the op_mode's nic_error() method and
check trans->state instead of STATUS_FW_ERROR. This will keep the
current behavior of iwl_fw_dbg_stop_restart_recording upon firmware
error, and it'll allow us to call iwl_fw_dbg_stop_restart_recording
safely even if STATUS_FW_ERROR is clear, but yet, the firmware is not
alive.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c    | 2 +-
 drivers/net/wireless/intel/iwlwifi/iwl-trans.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index fa57df336785..fb2ea38e89ac 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -3348,7 +3348,7 @@ void iwl_fw_dbg_stop_restart_recording(struct iwl_fw_runtime *fwrt,
 {
 	int ret __maybe_unused = 0;
 
-	if (test_bit(STATUS_FW_ERROR, &fwrt->trans->status))
+	if (!iwl_trans_fw_running(fwrt->trans))
 		return;
 
 	if (fw_has_capa(&fwrt->fw->ucode_capa,
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index 6148acbac6af..0ef48effeefb 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -1128,8 +1128,8 @@ static inline void iwl_trans_fw_error(struct iwl_trans *trans, bool sync)
 
 	/* prevent double restarts due to the same erroneous FW */
 	if (!test_and_set_bit(STATUS_FW_ERROR, &trans->status)) {
-		iwl_op_mode_nic_error(trans->op_mode, sync);
 		trans->state = IWL_TRANS_NO_FW;
+		iwl_op_mode_nic_error(trans->op_mode, sync);
 	}
 }
 
-- 
2.34.1


