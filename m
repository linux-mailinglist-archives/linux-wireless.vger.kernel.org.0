Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64E6F504819
	for <lists+linux-wireless@lfdr.de>; Sun, 17 Apr 2022 16:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234251AbiDQOyy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 17 Apr 2022 10:54:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiDQOyx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 17 Apr 2022 10:54:53 -0400
Received: from vps.slashdirt.org (vps.slashdirt.org [144.91.108.218])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 726789FD5
        for <linux-wireless@vger.kernel.org>; Sun, 17 Apr 2022 07:52:17 -0700 (PDT)
Received: from supercopter.milliways.lan (82-64-212-153.subs.proxad.net [82.64.212.153])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vps.slashdirt.org (Postfix) with ESMTPSA id 8EF3D60140;
        Sun, 17 Apr 2022 16:52:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 vps.slashdirt.org 8EF3D60140
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=slashdirt.org; s=mail;
        t=1650207135; bh=nietznB6ZgTnFg0C9cBqE28wMNc+jFjgA4EF0khtlIs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lzHZ7+umWyAIt1hLdMGBuneJSjQgHn7ubFcB8kuQT/b/DANXamUh/j2nHs42ap+Mu
         kFpbOIMDpqUxTcCHICPQ6V21mhP+8RBWjzvrBckZe7FW9mrBksq6jIn7UKupOtJicl
         aiuSQ0+LpvSCzZfgtKM+ZSAEuZlv65mNjQArD9k4=
From:   =?UTF-8?q?Thibaut=20VAR=C3=88NE?= <hacks+kernel@slashdirt.org>
To:     =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
        Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org
Cc:     Felix Fietkau <nbd@nbd.name>,
        =?UTF-8?q?Petr=20=C5=A0tetiar?= <ynezz@true.cz>,
        Clemens Hopfer <openwrt@wireloss.net>,
        =?UTF-8?q?Thibaut=20VAR=C3=88NE?= <hacks+kernel@slashdirt.org>
Subject: [PATCH v2] ath9k: fix QCA9561 PA bias level
Date:   Sun, 17 Apr 2022 16:51:45 +0200
Message-Id: <20220417145145.1847-1-hacks+kernel@slashdirt.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <EC4F8380-4725-441D-B3FF-8CD7048F2236@slashdirt.org>
References: <EC4F8380-4725-441D-B3FF-8CD7048F2236@slashdirt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NO_DNS_FOR_FROM,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

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
---
v2: Adjust #define per Felix's suggestion
---
 drivers/net/wireless/ath/ath9k/ar9003_phy.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath9k/ar9003_phy.h b/drivers/net/wireless/ath/ath9k/ar9003_phy.h
index a171dbb29..ad949eb02 100644
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
2.30.2

