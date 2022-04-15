Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04E6A502885
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Apr 2022 12:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352431AbiDOK4B (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 15 Apr 2022 06:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348531AbiDOK4A (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 15 Apr 2022 06:56:00 -0400
X-Greylist: delayed 491 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 15 Apr 2022 03:53:31 PDT
Received: from vps.slashdirt.org (vps.slashdirt.org [144.91.108.218])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8720DAACA8
        for <linux-wireless@vger.kernel.org>; Fri, 15 Apr 2022 03:53:31 -0700 (PDT)
Received: from supercopter.milliways.lan (82-64-212-153.subs.proxad.net [82.64.212.153])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vps.slashdirt.org (Postfix) with ESMTPSA id BBB246021A;
        Fri, 15 Apr 2022 12:45:16 +0200 (CEST)
DMARC-Filter: OpenDMARC Filter v1.4.0 vps.slashdirt.org BBB246021A
Authentication-Results: vps.slashdirt.org; dmarc=fail (p=quarantine dis=none) header.from=slashdirt.org
DKIM-Filter: OpenDKIM Filter v2.11.0 vps.slashdirt.org BBB246021A
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=slashdirt.org; s=mail;
        t=1650019517; bh=lkrm3ROjHkqcg0OsziAkJPqgkECGkh89TmnGlT8fS+o=;
        h=From:To:Cc:Subject:Date:From;
        b=rJEMmm9TZ3B9sju4UTc+4bfwx8ZCrgdRmvPzUxthk4l/rGtl2hzsr7ebhGUmS7cv+
         Zp9UWKQ/u/8CAtDyuUyvYzaJD/34H0xclHt6CVf8QvVYuVOjGlvUPfp+zpaSBZMgDE
         jpQ4kdCZqX9l4wOePkRfHLWZUTa7LLox4gZx5JiY=
From:   =?UTF-8?q?Thibaut=20VAR=C3=88NE?= <hacks+kernel@slashdirt.org>
To:     =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
        Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org
Cc:     =?UTF-8?q?Thibaut=20VAR=C3=88NE?= <hacks+kernel@slashdirt.org>,
        =?UTF-8?q?Petr=20=C5=A0tetiar?= <ynezz@true.cz>,
        Clemens Hopfer <openwrt@wireloss.net>
Subject: [PATCH] ath9k: fix QCA9561 PA bias
Date:   Fri, 15 Apr 2022 12:44:19 +0200
Message-Id: <20220415104419.22749-1-hacks+kernel@slashdirt.org>
X-Mailer: git-send-email 2.30.2
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

ath9k is setting the TX PA DC bias level differently on QCA9561 and
QCA9565 although they have the same radio IP-core, which results in a
very low output power and very low throughput as devices are further
away from the AP (compared to other 2.4GHz APs).

In real life testing, without this patch the 2.4GHz throughput on
Yuncore XD3200 is around 10Mbps sitting next to the AP, and close to
practical maximum with the patch applied.

Tested-by: Petr Štetiar <ynezz@true.cz>
Signed-off-by: Clemens Hopfer <openwrt@wireloss.net>
Signed-off-by: Thibaut VARÈNE <hacks+kernel@slashdirt.org>
---
 drivers/net/wireless/ath/ath9k/ar9003_eeprom.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/ar9003_eeprom.c b/drivers/net/wireless/ath/ath9k/ar9003_eeprom.c
index b0a4ca355..8f8682f25 100644
--- a/drivers/net/wireless/ath/ath9k/ar9003_eeprom.c
+++ b/drivers/net/wireless/ath/ath9k/ar9003_eeprom.c
@@ -3606,9 +3606,10 @@ static void ar9003_hw_xpa_bias_level_apply(struct ath_hw *ah, bool is2ghz)
 	int bias = ar9003_modal_header(ah, is2ghz)->xpaBiasLvl;
 
 	if (AR_SREV_9485(ah) || AR_SREV_9330(ah) || AR_SREV_9340(ah) ||
-	    AR_SREV_9531(ah) || AR_SREV_9561(ah))
+	    AR_SREV_9531(ah))
 		REG_RMW_FIELD(ah, AR_CH0_TOP2, AR_CH0_TOP2_XPABIASLVL, bias);
-	else if (AR_SREV_9462(ah) || AR_SREV_9550(ah) || AR_SREV_9565(ah))
+	else if (AR_SREV_9462(ah) || AR_SREV_9550(ah) || AR_SREV_9561(ah) ||
+		 AR_SREV_9565(ah))
 		REG_RMW_FIELD(ah, AR_CH0_TOP, AR_CH0_TOP_XPABIASLVL, bias);
 	else {
 		REG_RMW_FIELD(ah, AR_CH0_TOP, AR_CH0_TOP_XPABIASLVL, bias);
-- 
2.30.2

