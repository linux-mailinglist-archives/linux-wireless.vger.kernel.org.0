Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED12711671
	for <lists+linux-wireless@lfdr.de>; Thu, 25 May 2023 21:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243243AbjEYS4T (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 25 May 2023 14:56:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242857AbjEYSyl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 25 May 2023 14:54:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AD4E3C0A;
        Thu, 25 May 2023 11:46:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 814586495E;
        Thu, 25 May 2023 18:43:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E997C433A0;
        Thu, 25 May 2023 18:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685040210;
        bh=vGusgwOX6Umpfa6plaVkDQjKp9M4Jvnt/hMZudB1+rY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JHDHzwbkUbEFrADpuMOtgfE/arM+mRD1uCKwB8mpGS20FErK2pwcoWczxC3KWgDH+
         4mDq0Xf+DgVEt8ypdUChw/xupuPG76IrJPML+2hFKXALihtFF25td+8gditnH2LNRL
         IZjlDXhH0YPGnnGs1E8oCthbfaW7z/leYKbYOPFF53uJyFJrDd51xWaz5Ci66u7rSr
         N22X5buhj3ulf0W4Da7QrQYTAwuTHqjHSOm+TzATgmwTeuH3b0dlxXMT8W0rrJKB9t
         qxHet4AI49HeSnpNLdnqcMMGLMS1zdNQFwSR5DHYBm3KuMnpKvRHXQn/McKLTAykq2
         DPnDoSdqfdFvw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yun Lu <luyun@kylinos.cn>, Kalle Valo <kvalo@kernel.org>,
        Sasha Levin <sashal@kernel.org>, Jes.Sorensen@gmail.com,
        linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 18/27] wifi: rtl8xxxu: fix authentication timeout due to incorrect RCR value
Date:   Thu, 25 May 2023 14:42:27 -0400
Message-Id: <20230525184238.1943072-18-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230525184238.1943072-1-sashal@kernel.org>
References: <20230525184238.1943072-1-sashal@kernel.org>
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
index 2a02d4d72dec9..b7da89ba1e7d5 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
@@ -1255,6 +1255,7 @@ struct rtl8xxxu_priv {
 	u32 rege9c;
 	u32 regeb4;
 	u32 regebc;
+	u32 regrcr;
 	int next_mbox;
 	int nr_out_eps;
 
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index bdccc84278d85..2648b30aab76a 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -4048,6 +4048,7 @@ static int rtl8xxxu_init_device(struct ieee80211_hw *hw)
 		RCR_ACCEPT_MGMT_FRAME | RCR_HTC_LOC_CTRL |
 		RCR_APPEND_PHYSTAT | RCR_APPEND_ICV | RCR_APPEND_MIC;
 	rtl8xxxu_write32(priv, REG_RCR, val32);
+	priv->regrcr = val32;
 
 	/*
 	 * Accept all multicast
@@ -5585,7 +5586,7 @@ static void rtl8xxxu_configure_filter(struct ieee80211_hw *hw,
 				      unsigned int *total_flags, u64 multicast)
 {
 	struct rtl8xxxu_priv *priv = hw->priv;
-	u32 rcr = rtl8xxxu_read32(priv, REG_RCR);
+	u32 rcr = priv->regrcr;
 
 	dev_dbg(&priv->udev->dev, "%s: changed_flags %08x, total_flags %08x\n",
 		__func__, changed_flags, *total_flags);
@@ -5631,6 +5632,7 @@ static void rtl8xxxu_configure_filter(struct ieee80211_hw *hw,
 	 */
 
 	rtl8xxxu_write32(priv, REG_RCR, rcr);
+	priv->regrcr = rcr;
 
 	*total_flags &= (FIF_ALLMULTI | FIF_FCSFAIL | FIF_BCN_PRBRESP_PROMISC |
 			 FIF_CONTROL | FIF_OTHER_BSS | FIF_PSPOLL |
-- 
2.39.2

