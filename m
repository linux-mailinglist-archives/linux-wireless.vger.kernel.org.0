Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D3FA30C40B
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Feb 2021 16:39:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235520AbhBBPjQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 2 Feb 2021 10:39:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:40434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235286AbhBBPPe (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 2 Feb 2021 10:15:34 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3D9FA64F9A;
        Tue,  2 Feb 2021 15:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612278457;
        bh=qBK8EU4JAefFvhki8iDbOot/1PmqCmXPmJcli0nNqJE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s0K8e2DL9+MeMKmtL9Y6KG2VsMv7y6BqUw7VH+TuaKMhuQgfAslfqXC2cLOCSlxzi
         aJyM4enPF2XSsNZhz7nJzmNsAsEEcU3EFg7yEIUy0IBxjlqejonVUWcu2sPCoSSP6/
         ayvLowUyX3IK4hYHMHYl+nfK8Ov6NKI3rv12ytwjFlLP6IZ7EonSCTvgDY/B+jxtSS
         VKPd3rZYGGONSPPrOuR5iiyyYV1JF4gLLWZnJu2Rn/WBvXK//zr+QivZz/vewYqgBw
         oyjM8S0aOwVqMsfuIYX0N7VHhVhG4g1bkc3Kf8fJGAPHTCsLmAyD1BYyvxqmFB1g2/
         u7KfB/s73FEUQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 5/7] iwlwifi: mvm: guard against device removal in reprobe
Date:   Tue,  2 Feb 2021 10:07:27 -0500
Message-Id: <20210202150730.1864745-5-sashal@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210202150730.1864745-1-sashal@kernel.org>
References: <20210202150730.1864745-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit 7a21b1d4a728a483f07c638ccd8610d4b4f12684 ]

If we get into a problem severe enough to attempt a reprobe,
we schedule a worker to do that. However, if the problem gets
more severe and the device is actually destroyed before this
worker has a chance to run, we use a free device. Bump up the
reference count of the device until the worker runs to avoid
this situation.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Link: https://lore.kernel.org/r/iwlwifi.20210122144849.871f0892e4b2.I94819e11afd68d875f3e242b98bef724b8236f1e@changeid
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index 54f411b83beae..dc0bc57767390 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -1169,6 +1169,7 @@ static void iwl_mvm_reprobe_wk(struct work_struct *wk)
 	reprobe = container_of(wk, struct iwl_mvm_reprobe, work);
 	if (device_reprobe(reprobe->dev))
 		dev_err(reprobe->dev, "reprobe failed!\n");
+	put_device(reprobe->dev);
 	kfree(reprobe);
 	module_put(THIS_MODULE);
 }
@@ -1219,7 +1220,7 @@ void iwl_mvm_nic_restart(struct iwl_mvm *mvm, bool fw_error)
 			module_put(THIS_MODULE);
 			return;
 		}
-		reprobe->dev = mvm->trans->dev;
+		reprobe->dev = get_device(mvm->trans->dev);
 		INIT_WORK(&reprobe->work, iwl_mvm_reprobe_wk);
 		schedule_work(&reprobe->work);
 	} else if (mvm->fwrt.cur_fw_img == IWL_UCODE_REGULAR &&
-- 
2.27.0

