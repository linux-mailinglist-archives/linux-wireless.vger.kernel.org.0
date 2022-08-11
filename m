Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D642D58FF6D
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Aug 2022 17:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235841AbiHKP3t (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 11 Aug 2022 11:29:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235748AbiHKP3l (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 11 Aug 2022 11:29:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A643595E43;
        Thu, 11 Aug 2022 08:29:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0205161601;
        Thu, 11 Aug 2022 15:29:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ABC1C433C1;
        Thu, 11 Aug 2022 15:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660231766;
        bh=QoG2AXTUNTkgCb/Z7tMfnRQNeAn8xrjZVWaSk58MQno=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=crU4yMcOlWTFjnuFcu8m6xr+Wwg7BgDgZ7OzxYphc1qSy86i5ApBhQnbnerdjdHwm
         nr+SLinvJmy2ZcRLSP294+rp32XquvvvZmfzRaRxdT/qiTqC9O+K6OyNr4ETxXODh3
         J9gc8EtnmKXpBwkxPIzUbABW6Fcteyo1jO3p7C1BRDQT+LAmdaeyt/VzYBUPE7SO0U
         wRqVS9Unw58NF/ywY/fDtySAV1QL9RPV1t8xp5DkwSguO+J0wMAPhMBVL5/ZBc4r19
         RKXK2bYfOitLcGDMWvLzJ4MkSAtJHv2PjExirE1/lgIr9qOyvhPIWPpUr+aDYOjmPv
         3CrwW+cXOlvYQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Wen Gong <quic_wgong@quicinc.com>,
        Kalle Valo <quic_kvalo@quicinc.com>,
        Sasha Levin <sashal@kernel.org>, kvalo@kernel.org,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, ath10k@lists.infradead.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.19 009/105] ath10k: fix regdomain info of iw reg set/get
Date:   Thu, 11 Aug 2022 11:26:53 -0400
Message-Id: <20220811152851.1520029-9-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220811152851.1520029-1-sashal@kernel.org>
References: <20220811152851.1520029-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Wen Gong <quic_wgong@quicinc.com>

[ Upstream commit 8723750e2753868591ba86a57b0041c5e38047ad ]

When wlan load, firmware report the reg code with 0x6C for QCA6174,
it is world reg which checked by ath_is_world_regd(), then the reg
will be save into reg_world_copy of ath_common in ath_regd_init().
Later the regulatory of ath_common is updated to another country
code such as "US" in ath_reg_notifier_apply() by below call stack.
After that, regulatory_hint() is called in ath10k_mac_register()
and it lead "iw reg get" show two regdomain info as below.

global
country US: DFS-FCC
	(2400 - 2472 @ 40), (N/A, 30), (N/A)
	(5150 - 5250 @ 80), (N/A, 23), (N/A), AUTO-BW
	(5250 - 5350 @ 80), (N/A, 23), (0 ms), DFS, AUTO-BW
	(5470 - 5730 @ 160), (N/A, 23), (0 ms), DFS
	(5730 - 5850 @ 80), (N/A, 30), (N/A)
	(57240 - 71000 @ 2160), (N/A, 40), (N/A)

phy#0
country US: DFS-FCC
	(2400 - 2472 @ 40), (N/A, 30), (N/A)
	(5150 - 5250 @ 80), (N/A, 23), (N/A), AUTO-BW
	(5250 - 5350 @ 80), (N/A, 23), (0 ms), DFS, AUTO-BW
	(5470 - 5730 @ 160), (N/A, 23), (0 ms), DFS
	(5730 - 5850 @ 80), (N/A, 30), (N/A)
	(57240 - 71000 @ 2160), (N/A, 40), (N/A)

[ 4255.704975] Call Trace:
[ 4255.704983]  ath_reg_notifier_apply+0xa6/0xc5 [ath]
[ 4255.704991]  ath10k_reg_notifier+0x2f/0xd2 [ath10k_core]
[ 4255.705010]  wiphy_regulatory_register+0x5f/0x69 [cfg80211]
[ 4255.705020]  wiphy_register+0x459/0x8f0 [cfg80211]
[ 4255.705042]  ? ieee80211_register_hw+0x3a6/0x7d1 [mac80211]
[ 4255.705049]  ? __kmalloc+0xf4/0x218
[ 4255.705058]  ? ieee80211_register_hw+0x3a6/0x7d1 [mac80211]
[ 4255.705066]  ? ath10k_mac_register+0x70/0xaab [ath10k_core]
[ 4255.705075]  ieee80211_register_hw+0x51a/0x7d1 [mac80211]
[ 4255.705084]  ath10k_mac_register+0x8b4/0xaab [ath10k_core]
[ 4255.705094]  ath10k_core_register_work+0xa5e/0xb45 [ath10k_core]
[ 4255.705100]  ? __schedule+0x61f/0x7d3
[ 4255.705105]  process_one_work+0x1b7/0x392
[ 4255.705109]  worker_thread+0x271/0x35d
[ 4255.705112]  ? pr_cont_work+0x58/0x58
[ 4255.705116]  kthread+0x13f/0x147
[ 4255.705119]  ? pr_cont_work+0x58/0x58
[ 4255.705123]  ? kthread_destroy_worker+0x62/0x62
[ 4255.705126]  ret_from_fork+0x22/0x40

At this moment, the two regdomain info is same, when run "iw reg set KR",
the global regdomain info changed to KR, but the regdomain of phy#0
does not change again. It leads inconsistent values between global and
phy#0 as below.

global
country KR: DFS-JP
        (2402 - 2482 @ 40), (N/A, 13), (N/A)
        (5170 - 5250 @ 80), (N/A, 20), (N/A), AUTO-BW
        (5250 - 5330 @ 80), (N/A, 20), (0 ms), DFS, AUTO-BW
        (5490 - 5710 @ 160), (N/A, 30), (0 ms), DFS
        (5735 - 5835 @ 80), (N/A, 30), (N/A)
        (57000 - 66000 @ 2160), (N/A, 43), (N/A)

phy#0
country US: DFS-FCC
	(2400 - 2472 @ 40), (N/A, 30), (N/A)
	(5150 - 5250 @ 80), (N/A, 23), (N/A), AUTO-BW
	(5250 - 5350 @ 80), (N/A, 23), (0 ms), DFS, AUTO-BW
	(5470 - 5730 @ 160), (N/A, 23), (0 ms), DFS
	(5730 - 5850 @ 80), (N/A, 30), (N/A)
	(57240 - 71000 @ 2160), (N/A, 40), (N/A)

The initial reg code is 0x6C which saved in reg_world_copy of ath_common,
and the code US is updated from cfg80211 later, so ath10k should also
check the initial reg code before regulatory_hint().

After this fix, regdomain info is same between "iw reg get" and "iw reg
set xx", it does not have the regdomain info of phy#0 again.

global
country KR: DFS-JP
        (2402 - 2482 @ 40), (N/A, 13), (N/A)
        (5170 - 5250 @ 80), (N/A, 20), (N/A), AUTO-BW
        (5250 - 5330 @ 80), (N/A, 20), (0 ms), DFS, AUTO-BW
        (5490 - 5710 @ 160), (N/A, 30), (0 ms), DFS
        (5735 - 5835 @ 80), (N/A, 30), (N/A)
        (57000 - 66000 @ 2160), (N/A, 43), (N/A)

This does not effect the channel list and power which ath10k used.
When the country code for regulatory_hint() in ath10k_mac_register()
is same with the global country code, then reg_set_rd_driver() of
cfg80211 called from crda which return -EALREADY to set_regdom() and
then update_all_wiphy_regulatory() will not be called while wlan load.
When run "iw reg set xx", reg_get_regdomain() which used by function
handle_channel() in net/wirelss/reg.c always use the regdomain
returned by get_cfg80211_regdom() because the initiator of last
regulatory_request is NL80211_REGDOM_SET_BY_USER, get_cfg80211_regdom()
is the global regdomain, then all the ieee80211_channel info is updated
in handle_channel() with the global regdomain.

Tested-on: QCA6174 hw3.2 SDIO WLAN.RMH.4.4.1-00049
Tested-on: QCA9984 hw1.0 PCI 10.4-3.6-00104

Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
Link: https://lore.kernel.org/r/20220525132247.23459-1-quic_wgong@quicinc.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath10k/mac.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
index 3570a5895ea8..69da7b826387 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -10229,7 +10229,8 @@ int ath10k_mac_register(struct ath10k *ar)
 		ar->hw->wiphy->software_iftypes |= BIT(NL80211_IFTYPE_AP_VLAN);
 	}
 
-	if (!ath_is_world_regd(&ar->ath_common.regulatory)) {
+	if (!ath_is_world_regd(&ar->ath_common.reg_world_copy) &&
+	    !ath_is_world_regd(&ar->ath_common.regulatory)) {
 		ret = regulatory_hint(ar->hw->wiphy,
 				      ar->ath_common.regulatory.alpha2);
 		if (ret)
-- 
2.35.1

