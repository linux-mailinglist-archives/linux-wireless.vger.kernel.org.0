Return-Path: <linux-wireless+bounces-12441-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD7DE96A999
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2024 23:06:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FE961F2512A
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2024 21:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DA141EBFFF;
	Tue,  3 Sep 2024 20:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uB3e1+81"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84AF1EBFEF;
	Tue,  3 Sep 2024 20:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725396548; cv=none; b=UQyx9Yt2aggJs/tS92Q7rmJ3c3yQ0Nw7S9l0y7zI10cDsSlW9nvcdKnDTy7xuK7TAYk9o3d2E3LjAOgObFfl0pGw6o0VKdIBX7JkWrS5iRG1O9VXDIGBgTl2Qw11WYRQ40VaSHmX2wO0oOnJBAO7AuRxOH4sKWh4NN44GJuvR90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725396548; c=relaxed/simple;
	bh=koPg4FsuJLXLOj/LyBsLg9vfenIvI4R3R2Piew6V4Cw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D9UdlYSC7zZiqO3/ANfCzVBG4/w1Fi0wdrSCKX86F8EtNwB51epfF/ZEibsIxBZ1h69JWohu7q/TVvmPEXZ8FztVrOSURUlNnqnKPSg3bF6hKZLmz56CMUKUjqFl6QS1bPk/R1qUoQMMMpcHcnTNY8v125pDDN8TGEmiluNbEYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uB3e1+81; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AB3CC4CEC5;
	Tue,  3 Sep 2024 20:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725396547;
	bh=koPg4FsuJLXLOj/LyBsLg9vfenIvI4R3R2Piew6V4Cw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uB3e1+81Yb1alysHIbSSBoPf50Q4dXGhJ3dWYHdItn/Z0IAw+TtoIPavfMWfnyro8
	 4xfWq9IulpIAkNqIx4C3k/6klkuNT5jqolRDAwiWWKeVJF3fnPtRMCAF8P4M+K0wbD
	 yfb6lwloBW3o8rjpuYn5dRtWhcj1Xzs1MA244YuV1CE957+X2q1PSYNbpvOlvYw4xO
	 dOXtUexNzwHMXkyuBUJg+gPB6MQP+Er1nmh8e3lIBoNvz51bqyipBZLDmJ7qH2DK/V
	 gKDGd3iDwfWdljyvyq9V5JCHitVDWhpl91w6sq4PaRHy7m8uJ3lHNi9iWWJVp5xVAf
	 QdKvt26nI0ZKA==
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
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 6/6] wifi: iwlwifi: mvm: don't wait for tx queues if firmware is dead
Date: Tue,  3 Sep 2024 15:29:26 -0400
Message-ID: <20240903192937.1109185-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240903192937.1109185-1-sashal@kernel.org>
References: <20240903192937.1109185-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.320
Content-Transfer-Encoding: 8bit

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

[ Upstream commit 3a84454f5204718ca5b4ad2c1f0bf2031e2403d1 ]

There is a WARNING in iwl_trans_wait_tx_queues_empty() (that was
recently converted from just a message), that can be hit if we
wait for TX queues to become empty after firmware died. Clearly,
we can't expect anything from the firmware after it's declared dead.

Don't call iwl_trans_wait_tx_queues_empty() in this case. While it could
be a good idea to stop the flow earlier, the flush functions do some
maintenance work that is not related to the firmware, so keep that part
of the code running even when the firmware is not running.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Link: https://patch.msgid.link/20240825191257.a7cbd794cee9.I44a739fbd4ffcc46b83844dd1c7b2eb0c7b270f6@changeid
[edit commit message]
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 3f37fb64e71c2..3c00a737c4b34 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -4326,6 +4326,10 @@ static void iwl_mvm_flush_no_vif(struct iwl_mvm *mvm, u32 queues, bool drop)
 	int i;
 
 	if (!iwl_mvm_has_new_tx_api(mvm)) {
+		/* we can't ask the firmware anything if it is dead */
+		if (test_bit(IWL_MVM_STATUS_HW_RESTART_REQUESTED,
+			     &mvm->status))
+			return;
 		if (drop) {
 			mutex_lock(&mvm->mutex);
 			iwl_mvm_flush_tx_path(mvm,
@@ -4407,8 +4411,11 @@ static void iwl_mvm_mac_flush(struct ieee80211_hw *hw,
 
 	/* this can take a while, and we may need/want other operations
 	 * to succeed while doing this, so do it without the mutex held
+	 * If the firmware is dead, this can't work...
 	 */
-	if (!drop && !iwl_mvm_has_new_tx_api(mvm))
+	if (!drop && !iwl_mvm_has_new_tx_api(mvm) &&
+	    !test_bit(IWL_MVM_STATUS_HW_RESTART_REQUESTED,
+		      &mvm->status))
 		iwl_trans_wait_tx_queues_empty(mvm->trans, msk);
 }
 
-- 
2.43.0


