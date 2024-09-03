Return-Path: <linux-wireless+bounces-12434-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E9F096A95C
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2024 23:00:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A16431C21539
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2024 21:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30C661DEFD1;
	Tue,  3 Sep 2024 20:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iV+TecI7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F8C1E7DB3;
	Tue,  3 Sep 2024 20:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725396427; cv=none; b=oncF3JIwEqPTzYt23BEHOHMDrQ8Qhew4hEF67AzLohlCa0x8HopKrnn7ZGiCXM9AXxn/THw/DMMrBNonvjmFq/ih/FvzMRKqmiINf8DPKNoy73ZnbEOD97i5XdFPCJiVINr66iRyWcdciTTXzCEWHxTEwCK2FDNsa8//iuikJgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725396427; c=relaxed/simple;
	bh=HtJOoPRm0yQyAIldEsrykRNtsHBGEZ9Ry2KbVjHKsnk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UldXgaq9fXA2FO6+lb/29EwNjjeEE0DsxrfTZi17tZa8xTOfjAZClYiY4FWzdNFv8PClP8PthN8GFJd3sXq3cJ2xoP90Mef5RuzU83q6H3qBBAbdS2T91SlU6a3r+7IEp1kA+3UxlbcpPG/tT8oWOgME82w+QVvc2YrFlHzElQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iV+TecI7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49D2EC4CEC5;
	Tue,  3 Sep 2024 20:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725396426;
	bh=HtJOoPRm0yQyAIldEsrykRNtsHBGEZ9Ry2KbVjHKsnk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iV+TecI7J3vQhUx7WMO6fBcgJUDUHyhaxqxhwIesP5DkXFrN0Jwb2hueu6KfdRmg2
	 PQngkvc0qttMTodXT+XbzN0yaKKPnqX4XNOHhaVnkoH2gR7bT9NagjPO5zG+ECjH7y
	 1qi7SeL7x1yL7P1xyYCCsUCtUNIwqlFQz9Pevl2qfH76lnamwen7nmzKghjP1Bnjvp
	 00V1oTYQ44uyckmn0Lc/M2vADJhAAT9za4KTgBbRVBjMb46UsDdFYTos7YHw7Y90BZ
	 UxOiZYwOaBut4cb3zDBS7+jcKdVZ1NJfkJKFBd27QOxhVrelNsJ4AMwmkkZoj+GzU/
	 ha4aZRIyy5Wrg==
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
Subject: [PATCH AUTOSEL 5.15 11/12] wifi: iwlwifi: mvm: don't wait for tx queues if firmware is dead
Date: Tue,  3 Sep 2024 15:26:55 -0400
Message-ID: <20240903192718.1108456-11-sashal@kernel.org>
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
index fa7de3e47b8cc..0e2841fc84dcd 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -4776,6 +4776,10 @@ static void iwl_mvm_flush_no_vif(struct iwl_mvm *mvm, u32 queues, bool drop)
 	int i;
 
 	if (!iwl_mvm_has_new_tx_api(mvm)) {
+		/* we can't ask the firmware anything if it is dead */
+		if (test_bit(IWL_MVM_STATUS_HW_RESTART_REQUESTED,
+			     &mvm->status))
+			return;
 		if (drop) {
 			mutex_lock(&mvm->mutex);
 			iwl_mvm_flush_tx_path(mvm,
@@ -4857,8 +4861,11 @@ static void iwl_mvm_mac_flush(struct ieee80211_hw *hw,
 
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


