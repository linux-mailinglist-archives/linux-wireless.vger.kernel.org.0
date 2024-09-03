Return-Path: <linux-wireless+bounces-12424-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 753E496A910
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2024 22:52:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EB341F257ED
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2024 20:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB8CA1DA62E;
	Tue,  3 Sep 2024 20:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IqHM5ZpU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3AE51DA62A;
	Tue,  3 Sep 2024 20:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725396282; cv=none; b=FNGNlZ93f5hJ/sjUpA39thSzRMSrMZIPsCtKcAp7W+sy4UBJcD9gObxVjVjPgEkom5HDkL/Pa5IcTgEaOQ08VREapq7ELO6PuPp0cJbxkxRmnjuyyTQbC7H+D8nS1nC6p0Wa0LpbHzfyV/vZP7msEH1aNK92A3HSZ8UHXHKY8JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725396282; c=relaxed/simple;
	bh=QhEjdKuSVvUPDTFS1QSJFkWBGO04f8qBHIiFo9Xuoag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XDpsHgMJ7ly9cmp+MApFW5L6BpB4Ehbe5NBCv88humUDLjMjvbytzeXvXTcFKOdqWFQIbRjdMMLyeXo9M8OXl4/o2DDMwvdrVR5kUNwf7ncCqVmOh98jrvXKZ2V33IjA5fB3AxdDaKFG1ClEdWFzSylGaRYNedz560yQ7oFH4nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IqHM5ZpU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2607FC4CECB;
	Tue,  3 Sep 2024 20:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725396282;
	bh=QhEjdKuSVvUPDTFS1QSJFkWBGO04f8qBHIiFo9Xuoag=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IqHM5ZpU102o5Z9z4CYWpYdgZCovhvj7XKYhOuYMom7ztLVFqWm9pkLFeuTZALlpF
	 WH7FnMXPXUJitk7ygWPUWjLLZCPe4i8M9FD6GWy0X7p3Iz0soIrpj47E73yB2HeYaY
	 VJNLxzGESnr8MgXIIpXdwLPRViG8yYJbB1XyJs9/zfLKTELEB7OfsHQMO+B7ckW5Ds
	 hU0zrUr8O8OcBsyN0PYmTTGslQ3sT8Q+x5n4PTsmabgT0ghB1KNpyjG34UzMBHaP/X
	 RFZwwpX0vGhXK0T1vAptY2+5Xm6EIWQhoyOe1oI9yL+TcAhESfz8HAyPH1ugLFIpOS
	 Rwp9d7FRv4XeQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	kvalo@kernel.org,
	gregory.greenman@intel.com,
	daniel.gabay@intel.com,
	justinstitt@google.com,
	yedidya.ben.shimol@intel.com,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 20/20] wifi: iwlwifi: clear trans->state earlier upon error
Date: Tue,  3 Sep 2024 15:23:52 -0400
Message-ID: <20240903192425.1107562-20-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240903192425.1107562-1-sashal@kernel.org>
References: <20240903192425.1107562-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.48
Content-Transfer-Encoding: 8bit

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

[ Upstream commit 094513f8a2fbddee51b055d8035f995551f98fce ]

When the firmware crashes, we first told the op_mode and only then,
changed the transport's state. This is a problem if the op_mode's
nic_error() handler needs to send a host command: it'll see that the
transport's state still reflects that the firmware is alive.

Today, this has no consequences since we set the STATUS_FW_ERROR bit and
that will prevent sending host commands. iwl_fw_dbg_stop_restart_recording
looks at this bit to know not to send a host command for example.

To fix the hibernation, we needed to reset the firmware without having
an error and checking STATUS_FW_ERROR to see whether the firmware is
alive will no longer hold, so this change is necessary as well.

Change the flow a bit.
Change trans->state before calling the op_mode's nic_error() method and
check trans->state instead of STATUS_FW_ERROR. This will keep the
current behavior of iwl_fw_dbg_stop_restart_recording upon firmware
error, and it'll allow us to call iwl_fw_dbg_stop_restart_recording
safely even if STATUS_FW_ERROR is clear, but yet, the firmware is not
alive.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Link: https://patch.msgid.link/20240825191257.9d7427fbdfd7.Ia056ca57029a382c921d6f7b6a6b28fc480f2f22@changeid
[I missed this was a dependency for the hibernation fix, changed
 the commit message a bit accordingly]
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c    | 2 +-
 drivers/net/wireless/intel/iwlwifi/iwl-trans.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index 62aee4965021d..2a408e1ce06ec 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -3206,7 +3206,7 @@ void iwl_fw_dbg_stop_restart_recording(struct iwl_fw_runtime *fwrt,
 {
 	int ret __maybe_unused = 0;
 
-	if (test_bit(STATUS_FW_ERROR, &fwrt->trans->status))
+	if (!iwl_trans_fw_running(fwrt->trans))
 		return;
 
 	if (fw_has_capa(&fwrt->fw->ucode_capa,
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index 9dcc1506bd0b0..e8f48cb8d2da1 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -1554,8 +1554,8 @@ static inline void iwl_trans_fw_error(struct iwl_trans *trans, bool sync)
 
 	/* prevent double restarts due to the same erroneous FW */
 	if (!test_and_set_bit(STATUS_FW_ERROR, &trans->status)) {
-		iwl_op_mode_nic_error(trans->op_mode, sync);
 		trans->state = IWL_TRANS_NO_FW;
+		iwl_op_mode_nic_error(trans->op_mode, sync);
 	}
 }
 
-- 
2.43.0


