Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A2CC6F031D
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Apr 2023 11:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243335AbjD0JKS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Apr 2023 05:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243357AbjD0JJv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Apr 2023 05:09:51 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F13F46B1
        for <linux-wireless@vger.kernel.org>; Thu, 27 Apr 2023 02:09:46 -0700 (PDT)
From:   Martin Kaistra <martin.kaistra@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1682586585;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uelio+zrlTU2EbZbb8dv0RQo03SNemxsFEQaYJ7ROeY=;
        b=HqzfBneNqSgF7v+xJx6uc7UWlAbU95nwEkHtDNcHNZOvAXw5j62SJ8HEQ25TJ1ObIuZTQY
        SZXE7Rznl+xiVgFLRYRopW7QLtZL2lpOWqj+czSLAOi23qGR6rHBiD1HUUu5ChUi1k5dJW
        AEnZ4BgE9fesmkfb9VBFutkEo5Cw4HC/NzmMHaFidyWW0LaQgGVYQBA4K2kTga9kE+ymiW
        vfKI3Q34fP3OxLXvAG3gkjniiFFr/tYgfOZqZl+ZNkRcmU0+QVccl2Qxaros3S78obNVeu
        1W1JvDdGdYAqD6cX44BTr4Rt9E0TFqhdQ4lJx6+sNlZH2HjEdllBm9nuRlgbwA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1682586585;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uelio+zrlTU2EbZbb8dv0RQo03SNemxsFEQaYJ7ROeY=;
        b=ch6Rp9eup+arRMG5ArGOEZD2R+XeOQIKoec/mVGEVbINgLdY2Yl/kBV9I4dV921P5lwWSz
        yfZwDbIF5NwA/UDA==
To:     linux-wireless@vger.kernel.org
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Kalle Valo <kvalo@kernel.org>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v3 04/18] wifi: rtl8xxxu: Add set_tim() callback
Date:   Thu, 27 Apr 2023 11:09:08 +0200
Message-Id: <20230427090922.165088-5-martin.kaistra@linutronix.de>
In-Reply-To: <20230427090922.165088-1-martin.kaistra@linutronix.de>
References: <20230427090922.165088-1-martin.kaistra@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Update beacon content if TIM bitmap maintained by mac80211 is changed.

Signed-off-by: Martin Kaistra <martin.kaistra@linutronix.de>
Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index a733c6856fb20..551ceb2a2b653 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -4503,6 +4503,16 @@ int rtl8xxxu_get_antenna(struct ieee80211_hw *hw, u32 *tx_ant, u32 *rx_ant)
 	return 0;
 }
 
+static int rtl8xxxu_set_tim(struct ieee80211_hw *hw, struct ieee80211_sta *sta,
+			    bool set)
+{
+	struct rtl8xxxu_priv *priv = hw->priv;
+
+	schedule_work(&priv->update_beacon_work);
+
+	return 0;
+}
+
 static void rtl8xxxu_sw_scan_start(struct ieee80211_hw *hw,
 				   struct ieee80211_vif *vif, const u8 *mac)
 {
@@ -7193,6 +7203,7 @@ static const struct ieee80211_ops rtl8xxxu_ops = {
 	.ampdu_action = rtl8xxxu_ampdu_action,
 	.sta_statistics = rtl8xxxu_sta_statistics,
 	.get_antenna = rtl8xxxu_get_antenna,
+	.set_tim = rtl8xxxu_set_tim,
 };
 
 static int rtl8xxxu_parse_usb(struct rtl8xxxu_priv *priv,
-- 
2.30.2

