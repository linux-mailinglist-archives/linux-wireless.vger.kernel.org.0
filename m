Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 542D7538216
	for <lists+linux-wireless@lfdr.de>; Mon, 30 May 2022 16:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237512AbiE3OVt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 30 May 2022 10:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239668AbiE3OSy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 30 May 2022 10:18:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30C8E122B7A;
        Mon, 30 May 2022 06:49:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E0B2261013;
        Mon, 30 May 2022 13:49:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0B0AC3411F;
        Mon, 30 May 2022 13:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653918595;
        bh=6GPI7gYf07+zFN1Ol/tp6iH7PZSLrK3qLnRFMdReihY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PEl7ajDelcP/heH6+IbIHd0nPhCCRsnGxvv4jkaQFTT9++nB5ALiQF8OuXrBERtup
         8Ffn0CcZiD5neOwQ1eIiyDwZey3ORnMkADkV7OGFC8e0s3BVAbKsqfGhI7mazdbR2x
         HELluNHZnspeWUo/FfGboPP5Sq/+EnRzWApvSdIcgIE6TV1Xea2kYXfuOqt8g/RnbG
         kAydEBFQadtfGwz46POdtVl360EHwBZ37OIAoeApQ2Q1ILYZp2zkqXAb81GS1tW1IU
         04i2yuB4uGzYWgiPVwH+uV3Rj5FyMz7uopMeJ+Yj4LDWpC0PazIQ0pm3rbexjJllmU
         fC5M5lHJPDagQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     =?UTF-8?q?Thibaut=20VAR=C3=88NE?= <hacks+kernel@slashdirt.org>,
        Felix Fietkau <nbd@nbd.name>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
        Kalle Valo <quic_kvalo@quicinc.com>,
        Sasha Levin <sashal@kernel.org>, kvalo@kernel.org,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 11/38] ath9k: fix QCA9561 PA bias level
Date:   Mon, 30 May 2022 09:48:57 -0400
Message-Id: <20220530134924.1936816-11-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220530134924.1936816-1-sashal@kernel.org>
References: <20220530134924.1936816-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Thibaut VARÈNE <hacks+kernel@slashdirt.org>

[ Upstream commit e999a5da28a0e0f7de242d841ef7d5e48f4646ae ]

This patch fixes an invalid TX PA DC bias level on QCA9561, which
results in a very low output power and very low throughput as devices
are further away from the AP (compared to other 2.4GHz APs).

This patch was suggested by Felix Fietkau, who noted[1]:
"The value written to that register is wrong, because while the mask
definition AR_CH0_TOP2_XPABIASLVL uses a different value for 9561, the
shift definition AR_CH0_TOP2_XPABIASLVL_S is hardcoded to 12, which is
wrong for 9561."

In real life testing, without this patch the 2.4GHz throughput on
Yuncore XD3200 is around 10Mbps sitting next to the AP, and closer to
practical maximum with the patch applied.

[1] https://lore.kernel.org/all/91c58969-c60e-2f41-00ac-737786d435ae@nbd.name

Signed-off-by: Thibaut VARÈNE <hacks+kernel@slashdirt.org>
Acked-by: Felix Fietkau <nbd@nbd.name>
Acked-by: Toke Høiland-Jørgensen <toke@toke.dk>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
Link: https://lore.kernel.org/r/20220417145145.1847-1-hacks+kernel@slashdirt.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath9k/ar9003_phy.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath9k/ar9003_phy.h b/drivers/net/wireless/ath/ath9k/ar9003_phy.h
index a171dbb29fbb..ad949eb02f3d 100644
--- a/drivers/net/wireless/ath/ath9k/ar9003_phy.h
+++ b/drivers/net/wireless/ath/ath9k/ar9003_phy.h
@@ -720,7 +720,7 @@
 #define AR_CH0_TOP2		(AR_SREV_9300(ah) ? 0x1628c : \
 					(AR_SREV_9462(ah) ? 0x16290 : 0x16284))
 #define AR_CH0_TOP2_XPABIASLVL		(AR_SREV_9561(ah) ? 0x1e00 : 0xf000)
-#define AR_CH0_TOP2_XPABIASLVL_S	12
+#define AR_CH0_TOP2_XPABIASLVL_S	(AR_SREV_9561(ah) ? 9 : 12)
 
 #define AR_CH0_XTAL		(AR_SREV_9300(ah) ? 0x16294 : \
 				 ((AR_SREV_9462(ah) || AR_SREV_9565(ah)) ? 0x16298 : \
-- 
2.35.1

