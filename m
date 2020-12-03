Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D0A42CD741
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Dec 2020 14:35:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437074AbgLCNcr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 3 Dec 2020 08:32:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:47918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436921AbgLCNbQ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 3 Dec 2020 08:31:16 -0500
From:   Sasha Levin <sashal@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sara Sharon <sara.sharon@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 3/9] iwlwifi: mvm: fix kernel panic in case of assert during CSA
Date:   Thu,  3 Dec 2020 08:30:25 -0500
Message-Id: <20201203133031.931763-3-sashal@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201203133031.931763-1-sashal@kernel.org>
References: <20201203133031.931763-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sara Sharon <sara.sharon@intel.com>

[ Upstream commit fe56d05ee6c87f6a1a8c7267affd92c9438249cc ]

During CSA, we briefly nullify the phy context, in __iwl_mvm_unassign_vif_chanctx.
In case we have a FW assert right after it, it remains NULL though.
We end up running into endless loop due to mac80211 trying repeatedly to
move us to ASSOC state, and we keep returning -EINVAL. Later down the road
we hit a kernel panic.

Detect and avoid this endless loop.

Signed-off-by: Sara Sharon <sara.sharon@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Link: https://lore.kernel.org/r/iwlwifi.20201107104557.d64de2c17bff.Iedd0d2afa20a2aacba5259a5cae31cb3a119a4eb@changeid
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index ec2ecdd1cc4ec..9aab9a0269548 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -2654,7 +2654,7 @@ static int iwl_mvm_mac_sta_state(struct ieee80211_hw *hw,
 
 	/* this would be a mac80211 bug ... but don't crash */
 	if (WARN_ON_ONCE(!mvmvif->phy_ctxt))
-		return -EINVAL;
+		return test_bit(IWL_MVM_STATUS_HW_RESTART_REQUESTED, &mvm->status) ? 0 : -EINVAL;
 
 	/*
 	 * If we are in a STA removal flow and in DQA mode:
-- 
2.27.0

