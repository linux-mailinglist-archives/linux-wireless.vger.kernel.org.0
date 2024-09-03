Return-Path: <linux-wireless+bounces-12433-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2B4696A959
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2024 22:59:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88E801F23D8A
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2024 20:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 128E01E7DB7;
	Tue,  3 Sep 2024 20:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SinAFrot"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8ACB1E7DB3;
	Tue,  3 Sep 2024 20:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725396422; cv=none; b=fRlhUtZ11yjNCLo3lKWlZxhFPiSB8KMJF6kIKJBigQu2sKskt3nkBLOAJq13wLK+TDTCXthp9Fz7PzYCYxYREmquaEafCyJtiT0JEhsQzsDztcK5/Thw7VBHzYnzZv4hEqtM5QMS5X7r0JaN0HrHNM3CN0E7b7pbaqcfN/LWB30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725396422; c=relaxed/simple;
	bh=kJZvjfyzTd0pGlxxJR5Pya+DK6nDcVXiYOQZEnJ/bCA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bon9Paot1p1tbG0/VHNUW7sMmXDl2Pj8EOpswUBdPW6ZNzMGYT0ufnOtrcn3p+iIHH3I+yy1giWAGMY42+ZdpOOL1q6Ld1nOjGc8TAA15yLWurK2jyKvtXTn1h7zwuNFPHOOQ5WM/+Ev/94t5E3UtJds6hsRs3BkwF30wZT67co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SinAFrot; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CA80C4CEC4;
	Tue,  3 Sep 2024 20:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725396422;
	bh=kJZvjfyzTd0pGlxxJR5Pya+DK6nDcVXiYOQZEnJ/bCA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SinAFrotXb+6FOk9h0SDooUSfS/HRz66G/ic2Atrcg43AfAPkMQCt/SubkFK9KHUq
	 GmATp91nRvpLsMRZwWvpKmokQ7xrsOMWOpCTUKMpwSNuC4toCkj9Dk0VtUAuMPLAC4
	 EYnqmZkC20afRkO3VsQLt2BXtIrUtl+FJpd6NC5OtdPyoLX1lbCenBYXNfTEerA6uP
	 KXx3rekS7I3QS+tasGeKCSv8eThSQNsK4GNbK/Q5wxPWRW9GtprqMm5yaxUXczp5Iq
	 vzOZXsRI0UI1oM4FOquWrYZfWdvFr2nv6WH9X3x1V3kfFR2OgSTIIBqx2YcK46+6XU
	 KjBnN2eV5YYYA==
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
Subject: [PATCH AUTOSEL 5.15 10/12] wifi: iwlwifi: mvm: pause TCM when the firmware is stopped
Date: Tue,  3 Sep 2024 15:26:54 -0400
Message-ID: <20240903192718.1108456-10-sashal@kernel.org>
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
index 01f65c9789e72..be5b8aacf35b7 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -1024,6 +1024,8 @@ void iwl_mvm_stop_device(struct iwl_mvm *mvm)
 
 	clear_bit(IWL_MVM_STATUS_FIRMWARE_RUNNING, &mvm->status);
 
+	iwl_mvm_pause_tcm(mvm, false);
+
 	iwl_fw_dbg_stop_sync(&mvm->fwrt);
 	iwl_trans_stop_device(mvm->trans);
 	iwl_free_fw_paging(&mvm->fwrt);
-- 
2.43.0


