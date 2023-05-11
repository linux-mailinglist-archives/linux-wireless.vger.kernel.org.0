Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20BFF6FEA1A
	for <lists+linux-wireless@lfdr.de>; Thu, 11 May 2023 05:19:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbjEKDT3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 10 May 2023 23:19:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbjEKDT1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 10 May 2023 23:19:27 -0400
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 503BAE63;
        Wed, 10 May 2023 20:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=fqTZe
        yYMGiYuy99yTw2mCq9WCFqKj4kqAdwg8UFHt8I=; b=Noh2+cJ8cwYOLyIEmBYU9
        gdnHcKuLA69Ptt1PGNH+/iHZwRJDd2iGWglLOvs3ssW+UyY2XKxl4XctSNLN94d1
        dq0M/4BuSsZD64Lg70pjYNmQqLc/DRHbyI57fap7yotVJSHt97/s7nwCLGzUbIRV
        bisNf6LPZ7Dc8Pnch6J52I=
Received: from localhost.localdomain (unknown [116.128.244.169])
        by zwqz-smtp-mta-g1-4 (Coremail) with SMTP id _____wD3_0eCXlxkoDwhBA--.34445S2;
        Thu, 11 May 2023 11:18:26 +0800 (CST)
From:   Yun Lu <luyun_611@163.com>
To:     Jes.Sorensen@gmail.com, Larry.Finger@lwfinger.net
Cc:     kvalo@kernel.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH v2] wifi: rtl8xxxu: fix authentication timeout due to incorrect RCR value
Date:   Thu, 11 May 2023 11:18:25 +0800
Message-Id: <20230511031825.2125279-1-luyun_611@163.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wD3_0eCXlxkoDwhBA--.34445S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxAryDKw4kJF4UAw4fGw1UGFg_yoW5Xr1Upr
        WDCa4FyF1UJr1kWw48Xa17CF1rX3WSqrs3uFyfJ34Svrs5Z34S9F1F9F90yF4kurWkJFWa
        qrZYyrsrG3Z8W37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jjPfQUUUUU=
X-Originating-IP: [116.128.244.169]
X-CM-SenderInfo: pox130jbwriqqrwthudrp/1tbiWwdszmI0Z+svngAAsV
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Yun Lu <luyun@kylinos.cn>

When using rtl8192cu with rtl8xxxu driver to connect wifi, there is a
probability of failure, which shows "authentication with ... timed out".
Through debugging, it was found that the RCR register has been inexplicably
modified to an incorrect value, resulting in the nic not being able to
receive authenticated frames.

To fix this problem, add regrcr in rtl8xxxu_priv struct, and store
the RCR value every time the register is writen, and use it the next
time the register need to be modified.

Signed-off-by: Yun Lu <luyun@kylinos.cn>
Link: https://lore.kernel.org/all/20230427020512.1221062-1-luyun_611@163.com
---
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h      | 1 +
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
index c8cee4a24755..4088aaa1c618 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
@@ -1518,6 +1518,7 @@ struct rtl8xxxu_priv {
 	u32 rege9c;
 	u32 regeb4;
 	u32 regebc;
+	u32 regrcr;
 	int next_mbox;
 	int nr_out_eps;
 
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index 620a5cc2bfdd..2fe71933ba08 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -4053,6 +4053,7 @@ static int rtl8xxxu_init_device(struct ieee80211_hw *hw)
 		RCR_ACCEPT_MGMT_FRAME | RCR_HTC_LOC_CTRL |
 		RCR_APPEND_PHYSTAT | RCR_APPEND_ICV | RCR_APPEND_MIC;
 	rtl8xxxu_write32(priv, REG_RCR, val32);
+	priv->regrcr = val32;
 
 	if (priv->rtl_chip == RTL8188F) {
 		/* Accept all data frames */
@@ -6273,7 +6274,7 @@ static void rtl8xxxu_configure_filter(struct ieee80211_hw *hw,
 				      unsigned int *total_flags, u64 multicast)
 {
 	struct rtl8xxxu_priv *priv = hw->priv;
-	u32 rcr = rtl8xxxu_read32(priv, REG_RCR);
+	u32 rcr = priv->regrcr;
 
 	dev_dbg(&priv->udev->dev, "%s: changed_flags %08x, total_flags %08x\n",
 		__func__, changed_flags, *total_flags);
@@ -6319,6 +6320,7 @@ static void rtl8xxxu_configure_filter(struct ieee80211_hw *hw,
 	 */
 
 	rtl8xxxu_write32(priv, REG_RCR, rcr);
+	priv->regrcr = rcr;
 
 	*total_flags &= (FIF_ALLMULTI | FIF_FCSFAIL | FIF_BCN_PRBRESP_PROMISC |
 			 FIF_CONTROL | FIF_OTHER_BSS | FIF_PSPOLL |
-- 
2.25.1


No virus found
		Checked by Hillstone Network AntiVirus

