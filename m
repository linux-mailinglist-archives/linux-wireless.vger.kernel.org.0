Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 113316E7706
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Apr 2023 12:02:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231741AbjDSKCb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 19 Apr 2023 06:02:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232659AbjDSKCR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 19 Apr 2023 06:02:17 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63BAA40EE
        for <linux-wireless@vger.kernel.org>; Wed, 19 Apr 2023 03:02:15 -0700 (PDT)
From:   Martin Kaistra <martin.kaistra@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1681898531;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/IcqGDAf6SRQuUK8yLvYZYjJ1wvcwdftC4hnhgYc6TM=;
        b=chhkwflrd0x0HJN+Kod2cDKPJAtECU0yneCO04/2FvxdHDmYTL8p6FYqNoDHHTFXC41Ivb
        ZT8vnq6FFZhZ9Z902pZuhDJ5nZCSF4jQZYk5zaKU+r/PASDlYEi/+MwzTOg4RgDM+jKuo8
        r4Yd7H4g5ZUrDfaGwlNt9AvcroPJFxc0c9sOyMoKMZ/PlGCN+CfBLznGiz0TSb4XYR1RoP
        R7vUU/sQ5kb/7YIO2Vl8Xu614ERDbNFTLd8lyNFNceUlZa2Sb6OfJMI4mmKq6H8169sh9d
        mmNhidtPAh4MSgvZ/fOCyEYPCrVeVNKVUW/W122xbTBoHn6ZnyNkLkvULJeW4Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1681898531;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/IcqGDAf6SRQuUK8yLvYZYjJ1wvcwdftC4hnhgYc6TM=;
        b=4qv8Z7fpaONixnS+23PljquJKy0V8DeLe1fU7iJxLpmkS7eb721m/81IAWtf65luZghxue
        0aQgTYghb00ER1Cg==
To:     linux-wireless@vger.kernel.org
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Kalle Valo <kvalo@kernel.org>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v2 05/18] wifi: rtl8xxxu: Allow setting rts threshold to -1
Date:   Wed, 19 Apr 2023 12:01:32 +0200
Message-Id: <20230419100145.159191-6-martin.kaistra@linutronix.de>
In-Reply-To: <20230419100145.159191-1-martin.kaistra@linutronix.de>
References: <20230419100145.159191-1-martin.kaistra@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The default setting in hostapd.conf for rts threshold is -1, which means
disabled. Allow to set it.

Signed-off-by: Martin Kaistra <martin.kaistra@linutronix.de>
Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index 6a354165224a8..60b50a57da284 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -6585,7 +6585,7 @@ static void rtl8xxxu_configure_filter(struct ieee80211_hw *hw,
 
 static int rtl8xxxu_set_rts_threshold(struct ieee80211_hw *hw, u32 rts)
 {
-	if (rts > 2347)
+	if (rts > 2347 && rts != (u32)-1)
 		return -EINVAL;
 
 	return 0;
-- 
2.30.2

