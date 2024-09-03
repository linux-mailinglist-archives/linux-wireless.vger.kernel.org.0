Return-Path: <linux-wireless+bounces-12414-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C8E96A8CC
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2024 22:46:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2BCC1C215DD
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2024 20:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E34741DCB34;
	Tue,  3 Sep 2024 20:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G34A3cw5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E2B1DCB2E;
	Tue,  3 Sep 2024 20:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725396173; cv=none; b=AH8dlGX3SlNBwrQ3NRURjJyhrdoWRqFFCCcXc3gaPytmEVJHwRwajyGPRYnH+Y0CiHweqL7zoOI+fKLVlnRwZAyBwqlc2vznfyfhkyhtxILB8uUlTnYRomPXCQslpUOXQX/qKVtqTPEjec9vbH0lsrjY9POnjisA4GH21NApiFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725396173; c=relaxed/simple;
	bh=S65ovUGVUcysBlGQk1/nIaAqBn6Zv902xJH4o8kzbYI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hav/P15VmOv7lsgtujXRIrm0TdJ8sn9NOvaqovvN6BoNw+xkmA1BqrnIXqHU9eGnvOxGdhFs+UVn9Uz88I12oFAa+7LchZG8JQda79mb8ZPsYXd13MWpc9ofVjP4oDSgZ7iW6RIcH7Wospk2J0x3Odurym16L58FtI/PgsGm0f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G34A3cw5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B54EEC4CEC4;
	Tue,  3 Sep 2024 20:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725396173;
	bh=S65ovUGVUcysBlGQk1/nIaAqBn6Zv902xJH4o8kzbYI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G34A3cw5D8x5Lfzi2uKd9hgMRusocnB0cee/oAoMpOYaFoXF/3Wh9QSCy9bX+7b5m
	 BiI80IdgDtCDkHY+8assoHqmOT4H1ML1PXH4G4U1RpPWD9cFOrM+kV3FBugdA0VMUV
	 M95r7wGDLjnHmI7z7P+fLbs/hdzFSTtPqTYah6R0RfIAUkOgCbWkO35Twae1CSyREj
	 2+vy4fqHCHKT6rJdzshC5GAPnInHjnAv+Bu0tHgk9TDMhtXAL3Y9/NakzmCfNcb2BL
	 VEpM04cc3zdjdLo0Nb/jnnwwYuBxbC05g/Jam5USS+DxKK51rO0S5HdFqkeGlaXJIv
	 OsvzC6Sgq+E3g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	kvalo@kernel.org,
	gregory.greenman@intel.com,
	ilan.peer@intel.com,
	shaul.triebitz@intel.com,
	benjamin.berg@intel.com,
	pagadala.yesu.anjaneyulu@intel.com,
	shahar.s.matityahu@intel.com,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.10 19/22] wifi: iwlwifi: mvm: pause TCM when the firmware is stopped
Date: Tue,  3 Sep 2024 15:22:06 -0400
Message-ID: <20240903192243.1107016-19-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240903192243.1107016-1-sashal@kernel.org>
References: <20240903192243.1107016-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.7
Content-Transfer-Encoding: 8bit

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

[ Upstream commit 0668ebc8c2282ca1e7eb96092a347baefffb5fe7 ]

Not doing so will make us send a host command to the transport while the
firmware is not alive, which will trigger a WARNING.

bad state = 0
WARNING: CPU: 2 PID: 17434 at drivers/net/wireless/intel/iwlwifi/iwl-trans.c:115 iwl_trans_send_cmd+0x1cb/0x1e0 [iwlwifi]
RIP: 0010:iwl_trans_send_cmd+0x1cb/0x1e0 [iwlwifi]
Call Trace:
 <TASK>
 iwl_mvm_send_cmd+0x40/0xc0 [iwlmvm]
 iwl_mvm_config_scan+0x198/0x260 [iwlmvm]
 iwl_mvm_recalc_tcm+0x730/0x11d0 [iwlmvm]
 iwl_mvm_tcm_work+0x1d/0x30 [iwlmvm]
 process_one_work+0x29e/0x640
 worker_thread+0x2df/0x690
 ? rescuer_thread+0x540/0x540
 kthread+0x192/0x1e0
 ? set_kthread_struct+0x90/0x90
 ret_from_fork+0x22/0x30

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Link: https://patch.msgid.link/20240825191257.5abe71ca1b6b.I97a968cb8be1f24f94652d9b110ecbf6af73f89e@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index d343432474db0..d60579ca00320 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -1525,6 +1525,8 @@ void iwl_mvm_stop_device(struct iwl_mvm *mvm)
 
 	clear_bit(IWL_MVM_STATUS_FIRMWARE_RUNNING, &mvm->status);
 
+	iwl_mvm_pause_tcm(mvm, false);
+
 	iwl_fw_dbg_stop_sync(&mvm->fwrt);
 	iwl_trans_stop_device(mvm->trans);
 	iwl_free_fw_paging(&mvm->fwrt);
-- 
2.43.0


