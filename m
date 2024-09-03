Return-Path: <linux-wireless+bounces-12435-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43FA696A960
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2024 23:00:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9AEE6B23733
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2024 21:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 288AC1E8404;
	Tue,  3 Sep 2024 20:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f4GQIO5o"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6EC1E8403;
	Tue,  3 Sep 2024 20:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725396431; cv=none; b=eVESsD0qUzrZiTkjCms4cJGzKbSpZZ1mq080c/PS+QKmpa9v1XfgCZlL8jKcL4kOIJjB1yHwybBB4bGVzVu4coRuBik/H3ljs5Qgc2Db2CfFT2GuXQhZhJ0F2kKzB/tkYtwlIergBuI6pL6H/qY4dVLyczuw/3UdzUa4UGucnQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725396431; c=relaxed/simple;
	bh=n6eaSCxbSbkY42Jzi/5kjdbj6pXsgPDGUtNNCIwqb9w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nuDyBJ0TwacW3Kvd7uMJfL7Tm/Ggn557DIfEZrgATgIz0ZZ9udLd8OkX7dXarrxvshVirpsRQYL/P3ao//fx7Ltdcw28+enlYxZO3cKG5dXM/pLiqwtB3Iy/O6+WpTMHRcG4Uh44g83KVKjra4LQXf3kE+j4cP4Nrd/XFtbs744=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f4GQIO5o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A7B6C4CEC5;
	Tue,  3 Sep 2024 20:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725396430;
	bh=n6eaSCxbSbkY42Jzi/5kjdbj6pXsgPDGUtNNCIwqb9w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f4GQIO5osfwxXFfMMXdOXa7Vsy/kxp/KCsWrM1RS42ZiQMXn/AUNlxytSV8r2YlAR
	 g3cywVUibFYRaKEdOCn7IaK+QSxp0VG6rhSaapFXvRHHvTv5T0Ono4Y8xWV3tuLcp7
	 vBnpxyx5T2TyfIDQFirrZA8yPE/qGS+ZXAmu4ynFwAIIEotTZLRvkSvWTxfS8qrh74
	 xYo30IJZG4A0Bil5+WiZpHpWFrwKA5ckAL/+DIJnT7J9SEd8dtrdCSH3yvKsuGADrH
	 FXVcCaDz11/lHwSBj678/iAg5vxW/8caTwxFdvvBFz+1u5civSxiL8TCjw1B59Wi/K
	 fOMTvmRzCbphg==
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
	yedidya.ben.shimol@intel.com,
	justinstitt@google.com,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 12/12] wifi: iwlwifi: clear trans->state earlier upon error
Date: Tue,  3 Sep 2024 15:26:56 -0400
Message-ID: <20240903192718.1108456-12-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240903192718.1108456-1-sashal@kernel.org>
References: <20240903192718.1108456-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.165
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
index f34a02b33ccd4..fc630a0d9c83c 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -2862,7 +2862,7 @@ void iwl_fw_dbg_stop_restart_recording(struct iwl_fw_runtime *fwrt,
 {
 	int ret __maybe_unused = 0;
 
-	if (test_bit(STATUS_FW_ERROR, &fwrt->trans->status))
+	if (!iwl_trans_fw_running(fwrt->trans))
 		return;
 
 	if (fw_has_capa(&fwrt->fw->ucode_capa,
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index a2919a32d7081..d2b31599340fc 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -1393,8 +1393,8 @@ static inline void iwl_trans_fw_error(struct iwl_trans *trans, bool sync)
 
 	/* prevent double restarts due to the same erroneous FW */
 	if (!test_and_set_bit(STATUS_FW_ERROR, &trans->status)) {
-		iwl_op_mode_nic_error(trans->op_mode, sync);
 		trans->state = IWL_TRANS_NO_FW;
+		iwl_op_mode_nic_error(trans->op_mode, sync);
 	}
 }
 
-- 
2.43.0


