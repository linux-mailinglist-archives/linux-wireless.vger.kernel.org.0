Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09253621C88
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Nov 2022 19:54:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbiKHSyS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Nov 2022 13:54:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiKHSyO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Nov 2022 13:54:14 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E3C266C91
        for <linux-wireless@vger.kernel.org>; Tue,  8 Nov 2022 10:54:13 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id b2so41026523eja.6
        for <linux-wireless@vger.kernel.org>; Tue, 08 Nov 2022 10:54:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1TIpksv/WGV26MzZnqaXfZtNZROcwcPihFntdtgb78I=;
        b=eTEHqe/Yh3/XIzTf+EsAvzlMqNcMyMQtuK8ZWvqy4Y2J1/lk3/vbbn/FbQ64sAghg+
         21UPT6kRrjeWEoE9j7TQd6wc4tnUp4mr8RkmVZoYbIGe7kFG9l2bHbOaKBXG11zKmg7P
         3wrCA0Mk7e5vHoREISW8/hYd/V3AL3b5hODDlGDhZ5m8TCsUKKugbidJoa1MtdXK/aQT
         zIHOULQayypcPo7dobG3duwpwgK5mUhIvALZ3zrl7ZZK7F+xlrKuEu7dl4uyUP1dl75d
         IzJMxyGEsmlKdlYERIPU69UitbPoATbbOVp0m8Q9WbAVCr+MBTL1/JHU8HLiTqY4FNjA
         s6vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1TIpksv/WGV26MzZnqaXfZtNZROcwcPihFntdtgb78I=;
        b=rc4mfagLl/xe+/3Z9dvUT/Js51pwMyNnMSL/X5AdHHxjRL0mWnByoidbtx7XTB0r9g
         0ugyq7yyQO6SCEEZJnmiKj/4mVi/6NEBgAtFMVUnJo0ZOfDiH6V2d8osSV3QTUieId/2
         +c7S2DRc7lGrCZnCh9Ga8GoPJL60rIrrTcwngjHtv9Etd7L7K16MsJWmMxUzY/hle80q
         peyAA5UurPbNpE2pCoPTZ5u21bF5jxxdQe28epj+VnAjH8Sj6Qy+9HLKY9CiR+cqEPho
         zmW1r0rW5jWRcAboOPelMa/sOp0Z0AndRgvtDvRmdBiehzGpM39XzE9jfPodRVRdZYfJ
         VRpg==
X-Gm-Message-State: ACrzQf05inBe4wzK7d01hgEUp0G0av94CWFFelMPrHGbY8BqXSRpKP4d
        /Psmb407oLyxkt/ehaEAcefSU3CL/Wo=
X-Google-Smtp-Source: AMsMyM7fUdNEAdIvp0D+9OYfQ/MtRspUiKAa8xgOp+ZO8F4j2yMZ/Kmzgkqj0KMEmudBVosdvv7nmw==
X-Received: by 2002:a17:907:f9c:b0:7ae:1990:5487 with SMTP id kb28-20020a1709070f9c00b007ae19905487mr27780622ejc.293.1667933651616;
        Tue, 08 Nov 2022 10:54:11 -0800 (PST)
Received: from [192.168.1.50] ([81.196.40.23])
        by smtp.gmail.com with ESMTPSA id b18-20020a1709062b5200b00731582babcasm5033450ejg.71.2022.11.08.10.54.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Nov 2022 10:54:11 -0800 (PST)
Message-ID: <91f59414-86f7-f0ed-a138-19f0ab63bb0b@gmail.com>
Date:   Tue, 8 Nov 2022 20:54:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Content-Language: en-US
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Ping-Ke Shih <pkshih@realtek.com>
From:   Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: [PATCH 1/3] wifi: rtl8xxxu: Name some bits used in burst init
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Names provided by Ping-Ke Shih.

Suggested-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
This patch should be applied after my older patch:
"[PATCH v2 1/3] wifi: rtl8xxxu: Move burst init to a function​"
---
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 10 +++++-----
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_regs.h |  6 ++++++
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index 839e0546f5ec..e4eb17d03cd7 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -3786,16 +3786,16 @@ void rtl8xxxu_init_burst(struct rtl8xxxu_priv *priv)
 	 * For USB high speed set 512B packets
 	 */
 	val8 = rtl8xxxu_read8(priv, REG_RXDMA_PRO_8723B);
-	val8 &= ~(BIT(4) | BIT(5));
-	val8 |= BIT(4);
-	val8 |= BIT(1) | BIT(2) | BIT(3);
+	u8p_replace_bits(&val8, 1, RXDMA_PRO_DMA_BURST_SIZE);
+	u8p_replace_bits(&val8, 3, RXDMA_PRO_DMA_BURST_CNT);
+	val8 |= RXDMA_PRO_DMA_MODE;
 	rtl8xxxu_write8(priv, REG_RXDMA_PRO_8723B, val8);
 
 	/*
 	 * Enable single packet AMPDU
 	 */
 	val8 = rtl8xxxu_read8(priv, REG_HT_SINGLE_AMPDU_8723B);
-	val8 |= BIT(7);
+	val8 |= HT_SINGLE_AMPDU_ENABLE;
 	rtl8xxxu_write8(priv, REG_HT_SINGLE_AMPDU_8723B, val8);
 
 	rtl8xxxu_write16(priv, REG_MAX_AGGR_NUM, 0x0c14);
@@ -3820,7 +3820,7 @@ void rtl8xxxu_init_burst(struct rtl8xxxu_priv *priv)
 
 	/* to prevent mac is reseted by bus. */
 	val8 = rtl8xxxu_read8(priv, REG_RSV_CTRL);
-	val8 |= BIT(5) | BIT(6);
+	val8 |= RSV_CTRL_WLOCK_1C | RSV_CTRL_DIS_PRST;
 	rtl8xxxu_write8(priv, REG_RSV_CTRL, val8);
 }
 
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_regs.h b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_regs.h
index 04bf77959fba..5d4cac4f4c06 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_regs.h
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_regs.h
@@ -68,6 +68,8 @@
 #define REG_SPS_OCP_CFG			0x0018
 #define REG_8192E_LDOV12_CTRL		0x0014
 #define REG_RSV_CTRL			0x001c
+#define  RSV_CTRL_WLOCK_1C		BIT(5)
+#define  RSV_CTRL_DIS_PRST		BIT(6)
 
 #define REG_RF_CTRL			0x001f
 #define  RF_ENABLE			BIT(0)
@@ -472,6 +474,9 @@
 /* Presumably only found on newer chips such as 8723bu */
 #define REG_RX_DMA_CTRL_8723B		0x0286
 #define REG_RXDMA_PRO_8723B		0x0290
+#define  RXDMA_PRO_DMA_MODE		BIT(1)		/* Set to 0x1. */
+#define  RXDMA_PRO_DMA_BURST_CNT	GENMASK(3, 2)	/* Set to 0x3. */
+#define  RXDMA_PRO_DMA_BURST_SIZE	GENMASK(5, 4)	/* Set to 0x1. */
 
 #define REG_RF_BB_CMD_ADDR		0x02c0
 #define REG_RF_BB_CMD_DATA		0x02c4
@@ -577,6 +582,7 @@
 #define REG_STBC_SETTING		0x04c4
 #define REG_QUEUE_CTRL			0x04c6
 #define REG_HT_SINGLE_AMPDU_8723B	0x04c7
+#define  HT_SINGLE_AMPDU_ENABLE		BIT(7)
 #define REG_PROT_MODE_CTRL		0x04c8
 #define REG_MAX_AGGR_NUM		0x04ca
 #define REG_RTS_MAX_AGGR_NUM		0x04cb
-- 
2.38.0
