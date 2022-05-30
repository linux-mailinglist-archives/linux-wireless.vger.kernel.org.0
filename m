Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32995537D99
	for <lists+linux-wireless@lfdr.de>; Mon, 30 May 2022 15:42:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237536AbiE3Ngv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 30 May 2022 09:36:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237881AbiE3Nfw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 30 May 2022 09:35:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7270C95DD1;
        Mon, 30 May 2022 06:29:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 70DEF60ECB;
        Mon, 30 May 2022 13:29:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85DB6C36AE3;
        Mon, 30 May 2022 13:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653917351;
        bh=KcMfdVrPS5sBaTos33sAmjiggMA4Goon5JHj92fmjP8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RMN9UHn4BGmIGAE85Xj9/BnQv9g0D0vWOQ2bLR9AD5TR9W6zr380OV7YvLTAuM7WX
         U1BGsDv9PESe8aA4HQXbucFyXFwHtL6OXrAtTYXoagrL7Gu4FermYlTRa0kufUbfqL
         uqxQ3q56qH7DDKKSYQV+zEvrXO6dyxh9ZpfUV6W4hyYj7WWTxGXrIUhV+9ovGu4ozd
         l9px7Tkd8VVjdLD1bGlhQHZkzZAt6ukaB93oawsanZog5skbz4wYn1k85V5x8Jv96g
         FkFDJjlV37V4lwqAgyJMYUHbZu0diW5U/JOlVaw8a/aERB/R2COJIaAPT44M2rAHdJ
         4OquQf7s5sOGQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dongliang Mu <mudongliangabcd@gmail.com>,
        syzkaller <syzkaller@googlegroups.com>,
        Kalle Valo <kvalo@kernel.org>, Sasha Levin <sashal@kernel.org>,
        pkshih@realtek.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.18 108/159] rtlwifi: Use pr_warn instead of WARN_ONCE
Date:   Mon, 30 May 2022 09:23:33 -0400
Message-Id: <20220530132425.1929512-108-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220530132425.1929512-1-sashal@kernel.org>
References: <20220530132425.1929512-1-sashal@kernel.org>
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

From: Dongliang Mu <mudongliangabcd@gmail.com>

[ Upstream commit ad732da434a2936128769216eddaece3b1af4588 ]

This memory allocation failure can be triggered by fault injection or
high pressure testing, resulting a WARN.

Fix this by replacing WARN with pr_warn.

Reported-by: syzkaller <syzkaller@googlegroups.com>
Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
Signed-off-by: Kalle Valo <kvalo@kernel.org>
Link: https://lore.kernel.org/r/20220511014453.1621366-1-dzm91@hust.edu.cn
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/realtek/rtlwifi/usb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/usb.c b/drivers/net/wireless/realtek/rtlwifi/usb.c
index 86a236873254..a8eebafb9a7e 100644
--- a/drivers/net/wireless/realtek/rtlwifi/usb.c
+++ b/drivers/net/wireless/realtek/rtlwifi/usb.c
@@ -1014,7 +1014,7 @@ int rtl_usb_probe(struct usb_interface *intf,
 	hw = ieee80211_alloc_hw(sizeof(struct rtl_priv) +
 				sizeof(struct rtl_usb_priv), &rtl_ops);
 	if (!hw) {
-		WARN_ONCE(true, "rtl_usb: ieee80211 alloc failed\n");
+		pr_warn("rtl_usb: ieee80211 alloc failed\n");
 		return -ENOMEM;
 	}
 	rtlpriv = hw->priv;
-- 
2.35.1

