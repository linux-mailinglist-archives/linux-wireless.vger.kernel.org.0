Return-Path: <linux-wireless+bounces-12427-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F8896A933
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2024 22:56:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6D63284301
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2024 20:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE2D1E575A;
	Tue,  3 Sep 2024 20:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CRLMU2nc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41EA41E5759;
	Tue,  3 Sep 2024 20:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725396359; cv=none; b=Uw+2Dxg5TVFF4xPsD6OU0a7ADnpjLyH2OvS/9NJCB9hLoUlqFXGqg+lI32FhkhlDupXYdExglwveon+3tTXB2Xq1IGIiXEijPkcgCfGoWsV4lJO7nmolmvx0w3qhLP6DZOs8LIdu2eUKUgAkqGOxnRB3Nsy/MVIsYEf3A4qt6tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725396359; c=relaxed/simple;
	bh=bhyytRlKjeHWFN3YoXbtW8Ss/wlbz0MFSlYUomeaW4I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lT8aJGKR0ihEEDAcL04ScG8wfnyz3OyeXYxIqrqcOKHzXkyG02GJlSyLpY17eDd5jKGVoKnxIDjyKICV1cc3SiuT+BCuaSUwzytBxmp9Vr4Ch6y0X0sPB4HK05fqQI47l19qKTHIjbE2XSoJoCn84LZLQPkMIpG8RW6Ss3Ashf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CRLMU2nc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EC87C4CEC4;
	Tue,  3 Sep 2024 20:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725396358;
	bh=bhyytRlKjeHWFN3YoXbtW8Ss/wlbz0MFSlYUomeaW4I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CRLMU2ncookNgGAcjAaOlzx6KCCwKu+nSdnpTmN7KnhT63FlTCyIKRp60Ia1MvtiS
	 AsQ+xWBoMYIof+Xx2hGCO1uvelcZtyLOllpZ/8QyvkGMOrJ+uYhz67E3ntghHFQsIG
	 iPFSEWiXgdSnSs469/tUMgvzrHHcl6IGqbtbmmgBdgP4D2cSnT63+ckvGEitFSa9Zg
	 tf+dnUZtY8sfuLrCg2qJ2dQJ5NODnDxKBz62yOn+68X5UW3Ui2O5XaktZo/Tn172My
	 cHXs8BZ+8sYtow84Q7WYs8YgOEaW95L2NIUd/yTJcSqnXetxIXV3ER/v5P+RF1Dm4P
	 fPj8BB7MVdGrw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	kvalo@kernel.org,
	gregory.greenman@intel.com,
	shaul.triebitz@intel.com,
	benjamin.berg@intel.com,
	ilan.peer@intel.com,
	pagadala.yesu.anjaneyulu@intel.com,
	shahar.s.matityahu@intel.com,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 14/17] wifi: iwlwifi: mvm: pause TCM when the firmware is stopped
Date: Tue,  3 Sep 2024 15:25:28 -0400
Message-ID: <20240903192600.1108046-14-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240903192600.1108046-1-sashal@kernel.org>
References: <20240903192600.1108046-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.107
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
index 864f5fb260409..e5fa499effb1e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -1372,6 +1372,8 @@ void iwl_mvm_stop_device(struct iwl_mvm *mvm)
 
 	clear_bit(IWL_MVM_STATUS_FIRMWARE_RUNNING, &mvm->status);
 
+	iwl_mvm_pause_tcm(mvm, false);
+
 	iwl_fw_dbg_stop_sync(&mvm->fwrt);
 	iwl_trans_stop_device(mvm->trans);
 	iwl_free_fw_paging(&mvm->fwrt);
-- 
2.43.0


