Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CD6B7116D7
	for <lists+linux-wireless@lfdr.de>; Thu, 25 May 2023 21:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243252AbjEYTBc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 25 May 2023 15:01:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243658AbjEYS7l (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 25 May 2023 14:59:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 012D559FE;
        Thu, 25 May 2023 11:49:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3B69364914;
        Thu, 25 May 2023 18:45:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9460C4339C;
        Thu, 25 May 2023 18:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685040356;
        bh=K0DHSQSZVAT8N8ouP5wZ7sV+pKaXBbvB5JzNzqtza14=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EyPbOm1ZW8q9BfDUXvNVfPoFPgEgR6XQeVjZoJMjuitWJVz0VWV8oYd1XAZJBNBk+
         OlGhvkxe2f8UL38OjgtxqprkVMSQ5QNSj+MXZ6xZshz+nvMPrAF77waoEOQiYCjyhN
         ViXNvmOMVn2f7Oc/PF88KCeK6kyuo90AzequT9c/qU7UW2sZIFb9EhcP2BKjX12RT7
         ZXecXGkqszXHKxm2q7Bom8mqZD1qqpb/kyUytDBK43fZbdwQRZgkVRJSpADsixWsF5
         TfO3nj0dQ0TzfUWbPutoK9NLF5DQKXECwvnVvwgeKPNcrEPZv/3nueaT2zlo84NP7x
         PqIirsoTgYGyg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yun Lu <luyun@kylinos.cn>, Kalle Valo <kvalo@kernel.org>,
        Sasha Levin <sashal@kernel.org>, Jes.Sorensen@gmail.com,
        linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 13/20] wifi: rtl8xxxu: fix authentication timeout due to incorrect RCR value
Date:   Thu, 25 May 2023 14:45:09 -0400
Message-Id: <20230525184520.2004878-13-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230525184520.2004878-1-sashal@kernel.org>
References: <20230525184520.2004878-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Yun Lu <luyun@kylinos.cn>

[ Upstream commit 20429444e653ee8242dfbf815c0c37866beb371b ]

When using rtl8192cu with rtl8xxxu driver to connect wifi, there is a
probability of failure, which shows "authentication with ... timed out".
Through debugging, it was found that the RCR register has been inexplicably
modified to an incorrect value, resulting in the nic not being able to
receive authenticated frames.

To fix this problem, add regrcr in rtl8xxxu_priv struct, and store
the RCR value every time the register is written, and use it the next
time the register need to be modified.

Signed-off-by: Yun Lu <luyun@kylinos.cn>
Link: https://lore.kernel.org/all/20230427020512.1221062-1-luyun_611@163.com
Signed-off-by: Kalle Valo <kvalo@kernel.org>
Link: https://lore.kernel.org/r/20230512012055.2990472-1-luyun_611@163.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h      | 1 +
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
index c1163f2a09251..1913b51c1e809 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
@@ -1268,6 +1268,7 @@ struct rtl8xxxu_priv {
 	u32 rege9c;
 	u32 regeb4;
 	u32 regebc;
+	u32 regrcr;
 	int next_mbox;
 	int nr_out_eps;
 
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index 1c9f7e1f63cfd..bfd704b17a447 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -4051,6 +4051,7 @@ static int rtl8xxxu_init_device(struct ieee80211_hw *hw)
 		RCR_ACCEPT_MGMT_FRAME | RCR_HTC_LOC_CTRL |
 		RCR_APPEND_PHYSTAT | RCR_APPEND_ICV | RCR_APPEND_MIC;
 	rtl8xxxu_write32(priv, REG_RCR, val32);
+	priv->regrcr = val32;
 
 	/*
 	 * Accept all multicast
@@ -5591,7 +5592,7 @@ static void rtl8xxxu_configure_filter(struct ieee80211_hw *hw,
 				      unsigned int *total_flags, u64 multicast)
 {
 	struct rtl8xxxu_priv *priv = hw->priv;
-	u32 rcr = rtl8xxxu_read32(priv, REG_RCR);
+	u32 rcr = priv->regrcr;
 
 	dev_dbg(&priv->udev->dev, "%s: changed_flags %08x, total_flags %08x\n",
 		__func__, changed_flags, *total_flags);
@@ -5637,6 +5638,7 @@ static void rtl8xxxu_configure_filter(struct ieee80211_hw *hw,
 	 */
 
 	rtl8xxxu_write32(priv, REG_RCR, rcr);
+	priv->regrcr = rcr;
 
 	*total_flags &= (FIF_ALLMULTI | FIF_FCSFAIL | FIF_BCN_PRBRESP_PROMISC |
 			 FIF_CONTROL | FIF_OTHER_BSS | FIF_PSPOLL |
-- 
2.39.2

