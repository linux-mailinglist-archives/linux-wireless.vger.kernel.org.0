Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68E526243BE
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Nov 2022 14:58:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbiKJN6V (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Nov 2022 08:58:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231283AbiKJN6V (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Nov 2022 08:58:21 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31F077019D
        for <linux-wireless@vger.kernel.org>; Thu, 10 Nov 2022 05:58:20 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id y14so5136736ejd.9
        for <linux-wireless@vger.kernel.org>; Thu, 10 Nov 2022 05:58:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OPA4/BHM5mWGZAGUL4tFe00eB1HaHi/U7muTCPGJQII=;
        b=Cupq99lMU20urfJUjgi3jjD0mKOmTezWmDUPmyARurKqnRyK/d8+KDSiIe0yDjz4MQ
         YJ2f47cm1STtAhYYx/ZS6WfLs7/YtA0kWeDCbNRnAZPOSNPSsmkvQ7LSX93Lc+TCqNUF
         Zi++pjW5PfGegqtOMOCmRqbp/yi4Mkop4hhUPt4DMs3l0VFsfK5jKffB1t+LhziC8pb+
         KynhCoB8IpT5gfjJkGsKbRzu81LJcj06091Sk3TqBMou0NoIGxeqqhubaB41c9ksCZRE
         Kx1wzw+wm2AHvT2PSdSHmXQhfh934k4HYROHp0bOCLbsaNraZDpfUVC6aBs0sPoRcHdk
         uMHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OPA4/BHM5mWGZAGUL4tFe00eB1HaHi/U7muTCPGJQII=;
        b=i6GNGJKt3kZvWbn5KPiIjCdkX3/uCGtjJE+Vnecl8wxXyIq8WOOCZqAdbxyYT6ITu9
         zUCrhZR6O+VwsnxLavPyoMPdcnQlAWQWxj9c0fvxuzVunhWtPYcdFJDG4lBIO1RZfgwK
         b205lFL7ZSjfCcG4xOS6VtZ3Qh7/l19LTFQftZrG7FeJSgesxvpkDkcLCgTnIAun+r0K
         QuR7XrUOi1Hx3lX0NYZfIoSNucJzkfiq/Z+1EL0C4A36pi+zZT+5FKcmllGj7EUGeCrW
         5Rt1gMRbk/c18IrcAoBUjzOePHEQRioUDUOyYUQoakZCtub3hBLxFbC/Ap4htuXrd4ku
         ywbg==
X-Gm-Message-State: ACrzQf3sYORpSuL6JKTf7TpnWb9rlRiOBm8y72cYVXcp78EUFO/s8m1j
        GBt8FZoMKWdFSJEjS6mBgAgMejw0Opo=
X-Google-Smtp-Source: AMsMyM5z8nL8gxeT2DDJ26P7E/dQ2O4D3IS8VKwOtMFynSO6bNYFDbnMXaRzopp2wuCglG89/ueWEQ==
X-Received: by 2002:a17:906:11d3:b0:782:2d3e:6340 with SMTP id o19-20020a17090611d300b007822d3e6340mr2871840eja.234.1668088698626;
        Thu, 10 Nov 2022 05:58:18 -0800 (PST)
Received: from [192.168.1.50] ([81.196.40.23])
        by smtp.gmail.com with ESMTPSA id es11-20020a056402380b00b0045bd257b307sm8436131edb.22.2022.11.10.05.58.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Nov 2022 05:58:18 -0800 (PST)
Message-ID: <e7d05bd9-e096-8361-f1b4-3c8b8599a7eb@gmail.com>
Date:   Thu, 10 Nov 2022 15:58:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Content-Language: en-US
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Ping-Ke Shih <pkshih@realtek.com>
From:   Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: [PATCH v2 1/3] wifi: rtl8xxxu: Name some bits used in burst init
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Use descriptive names instead of magic numbers.

Suggested-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
v2:
 - Change the commit message.
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
