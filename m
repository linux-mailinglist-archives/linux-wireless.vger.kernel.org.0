Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29D0A2E14B3
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Dec 2020 03:48:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730267AbgLWCm2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Dec 2020 21:42:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:52610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729938AbgLWCXO (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Dec 2020 21:23:14 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E13FA22525;
        Wed, 23 Dec 2020 02:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608690153;
        bh=GvdPXwAxjrwZ6pzYg3dzpzNecKbXMvojGuj8CGZjYr4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lhB7ywrj9hVxrFSV5pB8UE8FXIVZZCyyf0FDOgFnFRKkEQL2PV8Iz6Sc6mO+Xjwhg
         v+vkbklEYLUQec1n+NN0epepRz6WzVMkGcuXKOq7e3VkqqwiC7KccEc2pjOh63iT1Z
         yZ56gaggVNpxd0ZK6McjdX3dmun8L1eVM5ecmTkFP5h4mzr7pv+r+cLzqdvaZybXPR
         dRLrSrcvHWrGx8WY6So6nPd9oDy/xF2Pw+eOBm6OjIFW5HWMB61WOg2/HkbheTI5ch
         t/Fe4uMl6A5BavVlYeuzxPh3KeHLf508a+7ntEWbdofCv4Xre8Y91SjCePWT8Rtyv5
         O1OrPQTyvZnuA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 73/87] iwlwifi: trans: consider firmware dead after errors
Date:   Tue, 22 Dec 2020 21:20:49 -0500
Message-Id: <20201223022103.2792705-73-sashal@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201223022103.2792705-1-sashal@kernel.org>
References: <20201223022103.2792705-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit 152fdc0f698896708f9d7889a4ba4da6944b74f7 ]

If we get an error, no longer consider the firmware to be
in IWL_TRANS_FW_ALIVE state.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Link: https://lore.kernel.org/r/iwlwifi.20201209231352.a9d01e79c1c7.Ib2deb076b392fb516a7230bac91d7ab8a9586d86@changeid
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/iwl-trans.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index 0b8cf7f3af933..675fffb39b729 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -1189,8 +1189,10 @@ static inline void iwl_trans_fw_error(struct iwl_trans *trans)
 		return;
 
 	/* prevent double restarts due to the same erroneous FW */
-	if (!test_and_set_bit(STATUS_FW_ERROR, &trans->status))
+	if (!test_and_set_bit(STATUS_FW_ERROR, &trans->status)) {
 		iwl_op_mode_nic_error(trans->op_mode);
+		trans->state = IWL_TRANS_NO_FW;
+	}
 }
 
 /*****************************************************
-- 
2.27.0

