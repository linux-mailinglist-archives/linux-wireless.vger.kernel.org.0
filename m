Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3106C6F49D2
	for <lists+linux-wireless@lfdr.de>; Tue,  2 May 2023 20:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233412AbjEBSkm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 2 May 2023 14:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbjEBSkl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 2 May 2023 14:40:41 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7DEF1727
        for <linux-wireless@vger.kernel.org>; Tue,  2 May 2023 11:40:37 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3f315735514so181502675e9.1
        for <linux-wireless@vger.kernel.org>; Tue, 02 May 2023 11:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683052836; x=1685644836;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2RqeIvOgX/w6DqiZRaJT4TroB4SCoK2MbW9bOCh0Ovk=;
        b=FwlBtsogb2PBiKsgLMbGdFgMnSjFTZ0sgjBlGebrWXBHAbYwIPrx/O65Xuo0Tf/lXW
         8eCOkxVYN9q1HmeycVPo/rQglVOTFI0VQ3Tns14KaT/43O2H7iGTJB4ebBsfj8Rr+h9G
         KG0yFtOrlzl0ibgRx063zr3BzGnvKRE9HqzuW9tTAlnzTyppJKNRS15bOrcwAHlhMLs1
         +HDRFr619Au/M6jDKrF2J3ujgN2iKfoynhozPLOwwGMkkK8il1M9xUytykzac5cy+QsY
         gYHt4hCt5GgpVpWYJjvEedl/2ayDVq+4KnHvh6ssn+MdRNKfv2rSp8WxRuw6KAsCLqq7
         9eMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683052836; x=1685644836;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2RqeIvOgX/w6DqiZRaJT4TroB4SCoK2MbW9bOCh0Ovk=;
        b=W40fPy6bgCTE3UlRLtpjG9j4eeYYAvwFHjNedkkDHlhIrhCyXvdZ28L1nO35MAssYn
         UKO36yrcW+00OeOQNvT3zgjZDvV8zbmK+176WkL2wIzZOLD9gDIQXX5xctuwI0Y2cooQ
         kkzRRGyemRsAJgqMj4pag5J5WLZjjESoWd0T17DGZbpMEp+G57FsPT0IcW+4Bx36wNNc
         KpOiRxuLkc00Z1d38ga4U4zln7ECRte5yevH5K4qEc7AXjA644C5Cqnh5rj9EExwnFb1
         UeeXNkuKUHJ6IJtdnmc9C58Tz5YG/dSH5jtmPJTYoyFpECzf9rWOSYQJyY7Bl+8NRfA+
         OsxQ==
X-Gm-Message-State: AC+VfDy9q9ToMtY+5KQUKIhPtJws8P5u9283xHTM85i5cFSeCu7rA/dC
        HDyjG7o0AXpnJVRpM24jWT6iGHNqDLM=
X-Google-Smtp-Source: ACHHUZ65eE79T5iMxAQYb8FG5G+dwaw87GvaqMY9gYsQ7Eb6eKLRoHvGjdY3EPgbudDa6Y76VcljDw==
X-Received: by 2002:a5d:4d08:0:b0:306:3163:2b73 with SMTP id z8-20020a5d4d08000000b0030631632b73mr4267996wrt.27.1683052836222;
        Tue, 02 May 2023 11:40:36 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.55])
        by smtp.gmail.com with ESMTPSA id x24-20020a1c7c18000000b003f183127434sm36352486wmc.30.2023.05.02.11.40.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 May 2023 11:40:35 -0700 (PDT)
Message-ID: <1779693f-c40b-fb86-e697-fd7958ea90bd@gmail.com>
Date:   Tue, 2 May 2023 21:40:34 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: [PATCH v2 2/2] wifi: rtl8xxxu: Rename some registers
Content-Language: en-US
From:   Bitterblue Smith <rtl8821cerfe2@gmail.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Ping-Ke Shih <pkshih@realtek.com>
References: <c43d971c-21bf-6714-d852-c76e515438b0@gmail.com>
In-Reply-To: <c43d971c-21bf-6714-d852-c76e515438b0@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Give proper names:

RF6052_REG_UNKNOWN_56 -> RF6052_REG_PAD_TXG
RF6052_REG_UNKNOWN_DF -> RF6052_REG_GAIN_CCA

And fix typos:

REG_OFDM0_AGCR_SSI_TABLE -> REG_OFDM0_AGC_RSSI_TABLE
REG_BB_ACCEESS_CTRL -> REG_BB_ACCESS_CTRL

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
v2:
 - Patch is new in v2.
---
 .../realtek/rtl8xxxu/rtl8xxxu_8188f.c         | 20 +++---
 .../realtek/rtl8xxxu/rtl8xxxu_8192e.c         | 28 ++++----
 .../realtek/rtl8xxxu/rtl8xxxu_8192f.c         | 64 +++++++++----------
 .../realtek/rtl8xxxu/rtl8xxxu_8710b.c         | 36 +++++------
 .../realtek/rtl8xxxu/rtl8xxxu_8723b.c         |  4 +-
 .../wireless/realtek/rtl8xxxu/rtl8xxxu_core.c |  6 +-
 .../wireless/realtek/rtl8xxxu/rtl8xxxu_regs.h |  8 +--
 7 files changed, 83 insertions(+), 83 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c
index 6108568b4e2a..4f70507de775 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c
@@ -654,7 +654,7 @@ static void rtl8188fu_config_channel(struct ieee80211_hw *hw)
 	rtl8xxxu_write_rfreg(priv, RF_A, RF6052_REG_RX_BB2, val32);
 
 	/* RC Corner */
-	rtl8xxxu_write_rfreg(priv, RF_A, RF6052_REG_UNKNOWN_DF, 0x00140);
+	rtl8xxxu_write_rfreg(priv, RF_A, RF6052_REG_GAIN_CCA, 0x00140);
 	rtl8xxxu_write_rfreg(priv, RF_A, RF6052_REG_RX_G2, 0x01c6c);
 }
 
@@ -854,8 +854,8 @@ static int rtl8188fu_iqk_path_a(struct rtl8xxxu_priv *priv, u32 *lok_result)
 	rtl8xxxu_write_rfreg(priv, RF_A, RF6052_REG_TXPA_G2, 0x07ff7);
 
 	/* PA,PAD gain adjust */
-	rtl8xxxu_write_rfreg(priv, RF_A, RF6052_REG_UNKNOWN_DF, 0x980);
-	rtl8xxxu_write_rfreg(priv, RF_A, RF6052_REG_UNKNOWN_56, 0x5102a);
+	rtl8xxxu_write_rfreg(priv, RF_A, RF6052_REG_GAIN_CCA, 0x980);
+	rtl8xxxu_write_rfreg(priv, RF_A, RF6052_REG_PAD_TXG, 0x5102a);
 
 	/* enter IQK mode */
 	val32 = rtl8xxxu_read32(priv, REG_FPGA0_IQK);
@@ -886,7 +886,7 @@ static int rtl8188fu_iqk_path_a(struct rtl8xxxu_priv *priv, u32 *lok_result)
 	val32 &= 0x000000ff;
 	rtl8xxxu_write32(priv, REG_FPGA0_IQK, val32);
 
-	rtl8xxxu_write_rfreg(priv, RF_A, RF6052_REG_UNKNOWN_DF, 0x180);
+	rtl8xxxu_write_rfreg(priv, RF_A, RF6052_REG_GAIN_CCA, 0x180);
 
 	/* save LOK result */
 	*lok_result = rtl8xxxu_read_rfreg(priv, RF_A, RF6052_REG_TXM_IDAC);
@@ -927,8 +927,8 @@ static int rtl8188fu_rx_iqk_path_a(struct rtl8xxxu_priv *priv, u32 lok_result)
 	rtl8xxxu_write_rfreg(priv, RF_A, RF6052_REG_TXPA_G2, 0xf1173);
 
 	/* PA,PAD gain adjust */
-	rtl8xxxu_write_rfreg(priv, RF_A, RF6052_REG_UNKNOWN_DF, 0x980);
-	rtl8xxxu_write_rfreg(priv, RF_A, RF6052_REG_UNKNOWN_56, 0x5102a);
+	rtl8xxxu_write_rfreg(priv, RF_A, RF6052_REG_GAIN_CCA, 0x980);
+	rtl8xxxu_write_rfreg(priv, RF_A, RF6052_REG_PAD_TXG, 0x5102a);
 
 	/*
 	 * Enter IQK mode
@@ -967,7 +967,7 @@ static int rtl8188fu_rx_iqk_path_a(struct rtl8xxxu_priv *priv, u32 lok_result)
 	val32 &= 0x000000ff;
 	rtl8xxxu_write32(priv, REG_FPGA0_IQK, val32);
 
-	rtl8xxxu_write_rfreg(priv, RF_A, RF6052_REG_UNKNOWN_DF, 0x180);
+	rtl8xxxu_write_rfreg(priv, RF_A, RF6052_REG_GAIN_CCA, 0x180);
 
 	/* Check failed */
 	reg_eac = rtl8xxxu_read32(priv, REG_RX_POWER_AFTER_IQK_A_2);
@@ -1002,8 +1002,8 @@ static int rtl8188fu_rx_iqk_path_a(struct rtl8xxxu_priv *priv, u32 lok_result)
 	/*
 	 * PA, PAD setting
 	 */
-	rtl8xxxu_write_rfreg(priv, RF_A, RF6052_REG_UNKNOWN_DF, 0x980);
-	rtl8xxxu_write_rfreg(priv, RF_A, RF6052_REG_UNKNOWN_56, 0x51000);
+	rtl8xxxu_write_rfreg(priv, RF_A, RF6052_REG_GAIN_CCA, 0x980);
+	rtl8xxxu_write_rfreg(priv, RF_A, RF6052_REG_PAD_TXG, 0x51000);
 
 	/*
 	 * Enter IQK mode
@@ -1041,7 +1041,7 @@ static int rtl8188fu_rx_iqk_path_a(struct rtl8xxxu_priv *priv, u32 lok_result)
 	val32 &= 0x000000ff;
 	rtl8xxxu_write32(priv, REG_FPGA0_IQK, val32);
 
-	rtl8xxxu_write_rfreg(priv, RF_A, RF6052_REG_UNKNOWN_DF, 0x180);
+	rtl8xxxu_write_rfreg(priv, RF_A, RF6052_REG_GAIN_CCA, 0x180);
 
 	/* reload LOK value */
 	rtl8xxxu_write_rfreg(priv, RF_A, RF6052_REG_TXM_IDAC, lok_result);
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192e.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192e.c
index fcc2926ea938..f673aa9ba15a 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192e.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192e.c
@@ -716,7 +716,7 @@ static int rtl8192eu_iqk_path_a(struct rtl8xxxu_priv *priv)
 	 * PA/PAD controlled by 0x0
 	 */
 	rtl8xxxu_write32(priv, REG_FPGA0_IQK, 0x00000000);
-	rtl8xxxu_write_rfreg(priv, RF_A, RF6052_REG_UNKNOWN_DF, 0x00180);
+	rtl8xxxu_write_rfreg(priv, RF_A, RF6052_REG_GAIN_CCA, 0x00180);
 
 	rtl8xxxu_write_rfreg(priv, RF_A, RF6052_REG_WE_LUT, 0x800a0);
 	rtl8xxxu_write_rfreg(priv, RF_A, RF6052_REG_RCK_OS, 0x20000);
@@ -776,8 +776,8 @@ static int rtl8192eu_rx_iqk_path_a(struct rtl8xxxu_priv *priv)
 	rtl8xxxu_write_rfreg(priv, RF_B, RF6052_REG_TXPA_G2, 0xf1173);
 
 	/* PA/PAD control by 0x56, and set = 0x0 */
-	rtl8xxxu_write_rfreg(priv, RF_A, RF6052_REG_UNKNOWN_DF, 0x00980);
-	rtl8xxxu_write_rfreg(priv, RF_A, RF6052_REG_UNKNOWN_56, 0x511e0);
+	rtl8xxxu_write_rfreg(priv, RF_A, RF6052_REG_GAIN_CCA, 0x00980);
+	rtl8xxxu_write_rfreg(priv, RF_A, RF6052_REG_PAD_TXG, 0x511e0);
 
 	/* Enter IQK mode */
 	rtl8xxxu_write32(priv, REG_FPGA0_IQK, 0x80800000);
@@ -816,7 +816,7 @@ static int rtl8192eu_rx_iqk_path_a(struct rtl8xxxu_priv *priv)
 	} else {
 		/* PA/PAD controlled by 0x0 */
 		rtl8xxxu_write32(priv, REG_FPGA0_IQK, 0x00000000);
-		rtl8xxxu_write_rfreg(priv, RF_A, RF6052_REG_UNKNOWN_DF, 0x180);
+		rtl8xxxu_write_rfreg(priv, RF_A, RF6052_REG_GAIN_CCA, 0x180);
 		goto out;
 	}
 
@@ -838,8 +838,8 @@ static int rtl8192eu_rx_iqk_path_a(struct rtl8xxxu_priv *priv)
 	rtl8xxxu_write_rfreg(priv, RF_B, RF6052_REG_TXPA_G2, 0xf7ff2);
 
 	/* PA/PAD control by 0x56, and set = 0x0 */
-	rtl8xxxu_write_rfreg(priv, RF_A, RF6052_REG_UNKNOWN_DF, 0x00980);
-	rtl8xxxu_write_rfreg(priv, RF_A, RF6052_REG_UNKNOWN_56, 0x510e0);
+	rtl8xxxu_write_rfreg(priv, RF_A, RF6052_REG_GAIN_CCA, 0x00980);
+	rtl8xxxu_write_rfreg(priv, RF_A, RF6052_REG_PAD_TXG, 0x510e0);
 
 	/* Enter IQK mode */
 	rtl8xxxu_write32(priv, REG_FPGA0_IQK, 0x80800000);
@@ -869,7 +869,7 @@ static int rtl8192eu_rx_iqk_path_a(struct rtl8xxxu_priv *priv)
 	reg_ea4 = rtl8xxxu_read32(priv, REG_RX_POWER_BEFORE_IQK_A_2);
 
 	rtl8xxxu_write32(priv, REG_FPGA0_IQK, 0x00000000);
-	rtl8xxxu_write_rfreg(priv, RF_A, RF6052_REG_UNKNOWN_DF, 0x180);
+	rtl8xxxu_write_rfreg(priv, RF_A, RF6052_REG_GAIN_CCA, 0x180);
 
 	if (!(reg_eac & BIT(27)) &&
 	    ((reg_ea4 & 0x03ff0000) != 0x01320000) &&
@@ -889,7 +889,7 @@ static int rtl8192eu_iqk_path_b(struct rtl8xxxu_priv *priv)
 	int result = 0;
 
 	rtl8xxxu_write32(priv, REG_FPGA0_IQK, 0x00000000);
-	rtl8xxxu_write_rfreg(priv, RF_B, RF6052_REG_UNKNOWN_DF, 0x00180);
+	rtl8xxxu_write_rfreg(priv, RF_B, RF6052_REG_GAIN_CCA, 0x00180);
 
 	rtl8xxxu_write_rfreg(priv, RF_B, RF6052_REG_WE_LUT, 0x800a0);
 	rtl8xxxu_write_rfreg(priv, RF_B, RF6052_REG_RCK_OS, 0x20000);
@@ -952,8 +952,8 @@ static int rtl8192eu_rx_iqk_path_b(struct rtl8xxxu_priv *priv)
 	rtl8xxxu_write_rfreg(priv, RF_A, RF6052_REG_TXPA_G2, 0xf1173);
 
 	/* PA/PAD control by 0x56, and set = 0x0 */
-	rtl8xxxu_write_rfreg(priv, RF_B, RF6052_REG_UNKNOWN_DF, 0x00980);
-	rtl8xxxu_write_rfreg(priv, RF_B, RF6052_REG_UNKNOWN_56, 0x511e0);
+	rtl8xxxu_write_rfreg(priv, RF_B, RF6052_REG_GAIN_CCA, 0x00980);
+	rtl8xxxu_write_rfreg(priv, RF_B, RF6052_REG_PAD_TXG, 0x511e0);
 
 	/* Enter IQK mode */
 	rtl8xxxu_write32(priv, REG_FPGA0_IQK, 0x80800000);
@@ -995,7 +995,7 @@ static int rtl8192eu_rx_iqk_path_b(struct rtl8xxxu_priv *priv)
 		 * Vendor driver restores RF_A here which I believe is a bug
 		 */
 		rtl8xxxu_write32(priv, REG_FPGA0_IQK, 0x00000000);
-		rtl8xxxu_write_rfreg(priv, RF_B, RF6052_REG_UNKNOWN_DF, 0x180);
+		rtl8xxxu_write_rfreg(priv, RF_B, RF6052_REG_GAIN_CCA, 0x180);
 		goto out;
 	}
 
@@ -1017,8 +1017,8 @@ static int rtl8192eu_rx_iqk_path_b(struct rtl8xxxu_priv *priv)
 	rtl8xxxu_write_rfreg(priv, RF_A, RF6052_REG_TXPA_G2, 0xf7ff2);
 
 	/* PA/PAD control by 0x56, and set = 0x0 */
-	rtl8xxxu_write_rfreg(priv, RF_B, RF6052_REG_UNKNOWN_DF, 0x00980);
-	rtl8xxxu_write_rfreg(priv, RF_B, RF6052_REG_UNKNOWN_56, 0x510e0);
+	rtl8xxxu_write_rfreg(priv, RF_B, RF6052_REG_GAIN_CCA, 0x00980);
+	rtl8xxxu_write_rfreg(priv, RF_B, RF6052_REG_PAD_TXG, 0x510e0);
 
 	/* Enter IQK mode */
 	rtl8xxxu_write32(priv, REG_FPGA0_IQK, 0x80800000);
@@ -1049,7 +1049,7 @@ static int rtl8192eu_rx_iqk_path_b(struct rtl8xxxu_priv *priv)
 	reg_ecc = rtl8xxxu_read32(priv, REG_RX_POWER_AFTER_IQK_B_2);
 
 	rtl8xxxu_write32(priv, REG_FPGA0_IQK, 0x00000000);
-	rtl8xxxu_write_rfreg(priv, RF_B, RF6052_REG_UNKNOWN_DF, 0x180);
+	rtl8xxxu_write_rfreg(priv, RF_B, RF6052_REG_GAIN_CCA, 0x180);
 
 	if (!(reg_eac & BIT(30)) &&
 	    ((reg_ec4 & 0x03ff0000) != 0x01320000) &&
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192f.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192f.c
index 57a0cd9210e6..6449c8a05956 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192f.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192f.c
@@ -569,7 +569,7 @@ static void rtl8192fu_config_kfree(struct rtl8xxxu_priv *priv, u8 channel)
 					  BIT(18), 1);
 
 		/* enter power_trim debug mode */
-		rtl8xxxu_write_rfreg_mask(priv, rfpath, RF6052_REG_UNKNOWN_DF,
+		rtl8xxxu_write_rfreg_mask(priv, rfpath, RF6052_REG_GAIN_CCA,
 					  BIT(7), 1);
 
 		/* write enable */
@@ -589,7 +589,7 @@ static void rtl8192fu_config_kfree(struct rtl8xxxu_priv *priv, u8 channel)
 					  0x3f, bb_gain_for_path);
 
 		/* leave power_trim debug mode */
-		rtl8xxxu_write_rfreg_mask(priv, rfpath, RF6052_REG_UNKNOWN_DF,
+		rtl8xxxu_write_rfreg_mask(priv, rfpath, RF6052_REG_GAIN_CCA,
 					  BIT(7), 0);
 
 		/* write disable */
@@ -831,13 +831,13 @@ static int rtl8192fu_iqk_path_a(struct rtl8xxxu_priv *priv)
 	rtl8xxxu_write32(priv, REG_FPGA0_XCD_RF_SW_CTRL, 0x04203400);
 	rtl8xxxu_write32(priv, REG_FPGA0_XA_HSSI_PARM1, 0x01000100);
 
-	rtl8xxxu_write_rfreg_mask(priv, RF_A, RF6052_REG_UNKNOWN_DF, BIT(4), 1);
-	rtl8xxxu_write_rfreg_mask(priv, RF_A, RF6052_REG_UNKNOWN_DF, BIT(11), 1);
+	rtl8xxxu_write_rfreg_mask(priv, RF_A, RF6052_REG_GAIN_CCA, BIT(4), 1);
+	rtl8xxxu_write_rfreg_mask(priv, RF_A, RF6052_REG_GAIN_CCA, BIT(11), 1);
 	if (rfe == 7 || rfe == 8 || rfe == 9 || rfe == 12)
 		val32 = 0x30;
 	else
 		val32 = 0xe9;
-	rtl8xxxu_write_rfreg_mask(priv, RF_A, RF6052_REG_UNKNOWN_56, 0x003ff, val32);
+	rtl8xxxu_write_rfreg_mask(priv, RF_A, RF6052_REG_PAD_TXG, 0x003ff, val32);
 
 	rtl8xxxu_write32_mask(priv, REG_FPGA0_IQK, 0xffffff00, 0x808000);
 
@@ -893,7 +893,7 @@ static int rtl8192fu_iqk_path_a(struct rtl8xxxu_priv *priv)
 
 	rtl8xxxu_write_rfreg_mask(priv, RF_A, RF6052_REG_AC, BIT(14), 0);
 	rtl8xxxu_write_rfreg_mask(priv, RF_A, RF6052_REG_WE_LUT, BIT(4), 0);
-	rtl8xxxu_write_rfreg_mask(priv, RF_A, RF6052_REG_UNKNOWN_DF, 0x00810, 0);
+	rtl8xxxu_write_rfreg_mask(priv, RF_A, RF6052_REG_GAIN_CCA, 0x00810, 0);
 
 	if (!(reg_eac & BIT(28)) &&
 	    ((reg_e94 & 0x03ff0000) != 0x01420000) &&
@@ -913,10 +913,10 @@ static int rtl8192fu_rx_iqk_path_a(struct rtl8xxxu_priv *priv)
 	rtl8xxxu_write32_mask(priv, REG_FPGA0_IQK, 0xffffff00, 0);
 
 	/* PA/PAD control by 0x56, and set = 0x0 */
-	rtl8xxxu_write_rfreg_mask(priv, RF_A, RF6052_REG_UNKNOWN_DF, BIT(1), 1);
+	rtl8xxxu_write_rfreg_mask(priv, RF_A, RF6052_REG_GAIN_CCA, BIT(1), 1);
 	rtl8xxxu_write_rfreg(priv, RF_A, RF6052_REG_GAIN_P1, 0);
-	rtl8xxxu_write_rfreg_mask(priv, RF_A, RF6052_REG_UNKNOWN_DF, BIT(11), 1);
-	rtl8xxxu_write_rfreg_mask(priv, RF_A, RF6052_REG_UNKNOWN_56, 0x003ff, 0x27);
+	rtl8xxxu_write_rfreg_mask(priv, RF_A, RF6052_REG_GAIN_CCA, BIT(11), 1);
+	rtl8xxxu_write_rfreg_mask(priv, RF_A, RF6052_REG_PAD_TXG, 0x003ff, 0x27);
 
 	/* Enter IQK mode */
 	rtl8xxxu_write32_mask(priv, REG_FPGA0_IQK, 0xffffff00, 0x808000);
@@ -962,7 +962,7 @@ static int rtl8192fu_rx_iqk_path_a(struct rtl8xxxu_priv *priv)
 		/* PA/PAD controlled by 0x0 */
 		rtl8xxxu_write32_mask(priv, REG_FPGA0_IQK, 0xffffff00, 0);
 
-		rtl8xxxu_write_rfreg_mask(priv, RF_A, RF6052_REG_UNKNOWN_DF,
+		rtl8xxxu_write_rfreg_mask(priv, RF_A, RF6052_REG_GAIN_CCA,
 					  BIT(11), 0);
 
 		return result;
@@ -975,10 +975,10 @@ static int rtl8192fu_rx_iqk_path_a(struct rtl8xxxu_priv *priv)
 	rtl8xxxu_write32_mask(priv, REG_FPGA0_IQK, 0xffffff00, 0);
 
 	/* PA/PAD control by 0x56, and set = 0x0 */
-	rtl8xxxu_write_rfreg_mask(priv, RF_A, RF6052_REG_UNKNOWN_DF, BIT(1), 1);
+	rtl8xxxu_write_rfreg_mask(priv, RF_A, RF6052_REG_GAIN_CCA, BIT(1), 1);
 	rtl8xxxu_write_rfreg(priv, RF_A, RF6052_REG_GAIN_P1, 0);
-	rtl8xxxu_write_rfreg_mask(priv, RF_A, RF6052_REG_UNKNOWN_DF, BIT(11), 1);
-	rtl8xxxu_write_rfreg_mask(priv, RF_A, RF6052_REG_UNKNOWN_56, 0x003ff, 0x1e0);
+	rtl8xxxu_write_rfreg_mask(priv, RF_A, RF6052_REG_GAIN_CCA, BIT(11), 1);
+	rtl8xxxu_write_rfreg_mask(priv, RF_A, RF6052_REG_PAD_TXG, 0x003ff, 0x1e0);
 
 	rtl8xxxu_write32(priv, REG_FPGA0_ANALOG4, 0xccf000c0);
 	rtl8xxxu_write32(priv, REG_ANAPWR1, 0x44ffbb44);
@@ -1025,7 +1025,7 @@ static int rtl8192fu_rx_iqk_path_a(struct rtl8xxxu_priv *priv)
 	/* Leave IQK mode */
 	rtl8xxxu_write32_mask(priv, REG_FPGA0_IQK, 0xffffff00, 0);
 
-	rtl8xxxu_write_rfreg_mask(priv, RF_A, RF6052_REG_UNKNOWN_DF, BIT(11), 0);
+	rtl8xxxu_write_rfreg_mask(priv, RF_A, RF6052_REG_GAIN_CCA, BIT(11), 0);
 	rtl8xxxu_write_rfreg(priv, RF_A, RF6052_REG_GAIN_P1, 0x02000);
 
 	if (!(reg_eac & BIT(27)) &&
@@ -1055,13 +1055,13 @@ static int rtl8192fu_iqk_path_b(struct rtl8xxxu_priv *priv)
 	rtl8xxxu_write32(priv, REG_FPGA0_XCD_RF_SW_CTRL, 0x04203400);
 	rtl8xxxu_write32(priv, REG_FPGA0_XA_HSSI_PARM1, 0x01000000);
 
-	rtl8xxxu_write_rfreg_mask(priv, RF_B, RF6052_REG_UNKNOWN_DF, BIT(4), 1);
-	rtl8xxxu_write_rfreg_mask(priv, RF_B, RF6052_REG_UNKNOWN_DF, BIT(11), 1);
+	rtl8xxxu_write_rfreg_mask(priv, RF_B, RF6052_REG_GAIN_CCA, BIT(4), 1);
+	rtl8xxxu_write_rfreg_mask(priv, RF_B, RF6052_REG_GAIN_CCA, BIT(11), 1);
 	if (rfe == 7 || rfe == 8 || rfe == 9 || rfe == 12)
-		rtl8xxxu_write_rfreg_mask(priv, RF_B, RF6052_REG_UNKNOWN_56,
+		rtl8xxxu_write_rfreg_mask(priv, RF_B, RF6052_REG_PAD_TXG,
 					  0x003ff, 0x30);
 	else
-		rtl8xxxu_write_rfreg_mask(priv, RF_B, RF6052_REG_UNKNOWN_56,
+		rtl8xxxu_write_rfreg_mask(priv, RF_B, RF6052_REG_PAD_TXG,
 					  0x00fff, 0xe9);
 
 	rtl8xxxu_write32_mask(priv, REG_FPGA0_IQK, 0xffffff00, 0x808000);
@@ -1118,7 +1118,7 @@ static int rtl8192fu_iqk_path_b(struct rtl8xxxu_priv *priv)
 
 	rtl8xxxu_write_rfreg_mask(priv, RF_B, RF6052_REG_AC, BIT(14), 0);
 	rtl8xxxu_write_rfreg_mask(priv, RF_B, RF6052_REG_WE_LUT, BIT(4), 0);
-	rtl8xxxu_write_rfreg_mask(priv, RF_B, RF6052_REG_UNKNOWN_DF, 0x00810, 0);
+	rtl8xxxu_write_rfreg_mask(priv, RF_B, RF6052_REG_GAIN_CCA, 0x00810, 0);
 
 	if (!(reg_eac & BIT(31)) &&
 	    ((reg_eb4 & 0x03ff0000) != 0x01420000) &&
@@ -1140,10 +1140,10 @@ static int rtl8192fu_rx_iqk_path_b(struct rtl8xxxu_priv *priv)
 	/* Leave IQK mode */
 	rtl8xxxu_write32_mask(priv, REG_FPGA0_IQK, 0xffffff00, 0);
 
-	rtl8xxxu_write_rfreg_mask(priv, RF_B, RF6052_REG_UNKNOWN_DF, BIT(1), 1);
+	rtl8xxxu_write_rfreg_mask(priv, RF_B, RF6052_REG_GAIN_CCA, BIT(1), 1);
 	rtl8xxxu_write_rfreg(priv, RF_B, RF6052_REG_GAIN_P1, 0);
-	rtl8xxxu_write_rfreg_mask(priv, RF_B, RF6052_REG_UNKNOWN_DF, BIT(11), 1);
-	rtl8xxxu_write_rfreg_mask(priv, RF_B, RF6052_REG_UNKNOWN_56, 0x003ff, 0x67);
+	rtl8xxxu_write_rfreg_mask(priv, RF_B, RF6052_REG_GAIN_CCA, BIT(11), 1);
+	rtl8xxxu_write_rfreg_mask(priv, RF_B, RF6052_REG_PAD_TXG, 0x003ff, 0x67);
 
 	rtl8xxxu_write32(priv, REG_FPGA0_ANALOG4, 0xccf000c0);
 	rtl8xxxu_write32(priv, REG_ANAPWR1, 0x44ffbb44);
@@ -1192,7 +1192,7 @@ static int rtl8192fu_rx_iqk_path_b(struct rtl8xxxu_priv *priv)
 		/* PA/PAD controlled by 0x0 */
 		rtl8xxxu_write32_mask(priv, REG_FPGA0_IQK, 0xffffff00, 0);
 
-		rtl8xxxu_write_rfreg_mask(priv, RF_B, RF6052_REG_UNKNOWN_DF,
+		rtl8xxxu_write_rfreg_mask(priv, RF_B, RF6052_REG_GAIN_CCA,
 					  BIT(11), 0);
 
 		return result;
@@ -1204,10 +1204,10 @@ static int rtl8192fu_rx_iqk_path_b(struct rtl8xxxu_priv *priv)
 	/* Modify RX IQK mode table */
 	rtl8xxxu_write32_mask(priv, REG_FPGA0_IQK, 0xffffff00, 0);
 
-	rtl8xxxu_write_rfreg_mask(priv, RF_B, RF6052_REG_UNKNOWN_DF, BIT(1), 1);
+	rtl8xxxu_write_rfreg_mask(priv, RF_B, RF6052_REG_GAIN_CCA, BIT(1), 1);
 	rtl8xxxu_write_rfreg(priv, RF_B, RF6052_REG_GAIN_P1, 0);
-	rtl8xxxu_write_rfreg_mask(priv, RF_B, RF6052_REG_UNKNOWN_DF, BIT(11), 1);
-	rtl8xxxu_write_rfreg_mask(priv, RF_B, RF6052_REG_UNKNOWN_56, 0x003ff, 0x1e0);
+	rtl8xxxu_write_rfreg_mask(priv, RF_B, RF6052_REG_GAIN_CCA, BIT(11), 1);
+	rtl8xxxu_write_rfreg_mask(priv, RF_B, RF6052_REG_PAD_TXG, 0x003ff, 0x1e0);
 
 	rtl8xxxu_write32(priv, REG_FPGA0_ANALOG4, 0xccf000c0);
 	rtl8xxxu_write32(priv, REG_ANAPWR1, 0x44ffbb44);
@@ -1253,8 +1253,8 @@ static int rtl8192fu_rx_iqk_path_b(struct rtl8xxxu_priv *priv)
 	rtl8xxxu_write32_mask(priv, REG_FPGA0_IQK, 0xffffff00, 0);
 	rtl8xxxu_write32(priv, REG_FPGA0_XA_HSSI_PARM1, 0x01000100);
 
-	rtl8xxxu_write_rfreg_mask(priv, RF_B, RF6052_REG_UNKNOWN_DF, BIT(11), 0);
-	rtl8xxxu_write_rfreg_mask(priv, RF_B, RF6052_REG_UNKNOWN_DF, BIT(1), 0);
+	rtl8xxxu_write_rfreg_mask(priv, RF_B, RF6052_REG_GAIN_CCA, BIT(11), 0);
+	rtl8xxxu_write_rfreg_mask(priv, RF_B, RF6052_REG_GAIN_CCA, BIT(1), 0);
 	rtl8xxxu_write_rfreg(priv, RF_B, RF6052_REG_GAIN_P1, 0x02000);
 
 	if (!(reg_eac & BIT(30)) &&
@@ -1472,9 +1472,9 @@ static void rtl8192fu_phy_iq_calibrate(struct rtl8xxxu_priv *priv)
 
 	rfe_path_select = rtl8xxxu_read32(priv, REG_RFE_PATH_SELECT);
 
-	path_a_0xdf = rtl8xxxu_read_rfreg(priv, RF_A, RF6052_REG_UNKNOWN_DF);
+	path_a_0xdf = rtl8xxxu_read_rfreg(priv, RF_A, RF6052_REG_GAIN_CCA);
 	path_a_0x35 = rtl8xxxu_read_rfreg(priv, RF_A, RF6052_REG_GAIN_P1);
-	path_b_0xdf = rtl8xxxu_read_rfreg(priv, RF_B, RF6052_REG_UNKNOWN_DF);
+	path_b_0xdf = rtl8xxxu_read_rfreg(priv, RF_B, RF6052_REG_GAIN_CCA);
 	path_b_0x35 = rtl8xxxu_read_rfreg(priv, RF_B, RF6052_REG_GAIN_P1);
 
 	memset(result, 0, sizeof(result));
@@ -1550,9 +1550,9 @@ static void rtl8192fu_phy_iq_calibrate(struct rtl8xxxu_priv *priv)
 						   candidate, (reg_ec4 == 0));
 	}
 
-	rtl8xxxu_write_rfreg(priv, RF_A, RF6052_REG_UNKNOWN_DF, path_a_0xdf);
+	rtl8xxxu_write_rfreg(priv, RF_A, RF6052_REG_GAIN_CCA, path_a_0xdf);
 	rtl8xxxu_write_rfreg(priv, RF_A, RF6052_REG_GAIN_P1, path_a_0x35);
-	rtl8xxxu_write_rfreg(priv, RF_B, RF6052_REG_UNKNOWN_DF, path_b_0xdf);
+	rtl8xxxu_write_rfreg(priv, RF_B, RF6052_REG_GAIN_CCA, path_b_0xdf);
 	rtl8xxxu_write_rfreg(priv, RF_B, RF6052_REG_GAIN_P1, path_b_0x35);
 
 	if (rfe == 7 || rfe == 8 || rfe == 9 || rfe == 12) {
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8710b.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8710b.c
index 2990475100ec..f0d17b75c5f1 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8710b.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8710b.c
@@ -1031,12 +1031,12 @@ static int rtl8710bu_iqk_path_a(struct rtl8xxxu_priv *priv, u32 *lok_result)
 	rtl8xxxu_write_rfreg(priv, RF_A, RF6052_REG_TXPA_G2, 0x07ff7);
 
 	/* PA,PAD gain adjust */
-	val32 = rtl8xxxu_read_rfreg(priv, RF_A, RF6052_REG_UNKNOWN_DF);
+	val32 = rtl8xxxu_read_rfreg(priv, RF_A, RF6052_REG_GAIN_CCA);
 	val32 |= BIT(11);
-	rtl8xxxu_write_rfreg(priv, RF_A, RF6052_REG_UNKNOWN_DF, val32);
-	val32 = rtl8xxxu_read_rfreg(priv, RF_A, RF6052_REG_UNKNOWN_56);
+	rtl8xxxu_write_rfreg(priv, RF_A, RF6052_REG_GAIN_CCA, val32);
+	val32 = rtl8xxxu_read_rfreg(priv, RF_A, RF6052_REG_PAD_TXG);
 	u32p_replace_bits(&val32, 0x1ed, 0x00fff);
-	rtl8xxxu_write_rfreg(priv, RF_A, RF6052_REG_UNKNOWN_56, val32);
+	rtl8xxxu_write_rfreg(priv, RF_A, RF6052_REG_PAD_TXG, val32);
 
 	/* enter IQK mode */
 	val32 = rtl8xxxu_read32(priv, REG_FPGA0_IQK);
@@ -1068,9 +1068,9 @@ static int rtl8710bu_iqk_path_a(struct rtl8xxxu_priv *priv, u32 *lok_result)
 	u32p_replace_bits(&val32, 0, 0xffffff00);
 	rtl8xxxu_write32(priv, REG_FPGA0_IQK, val32);
 
-	val32 = rtl8xxxu_read_rfreg(priv, RF_A, RF6052_REG_UNKNOWN_DF);
+	val32 = rtl8xxxu_read_rfreg(priv, RF_A, RF6052_REG_GAIN_CCA);
 	val32 &= ~BIT(11);
-	rtl8xxxu_write_rfreg(priv, RF_A, RF6052_REG_UNKNOWN_DF, val32);
+	rtl8xxxu_write_rfreg(priv, RF_A, RF6052_REG_GAIN_CCA, val32);
 
 	/* save LOK result */
 	*lok_result = rtl8xxxu_read_rfreg(priv, RF_A, RF6052_REG_TXM_IDAC);
@@ -1113,12 +1113,12 @@ static int rtl8710bu_rx_iqk_path_a(struct rtl8xxxu_priv *priv, u32 lok_result)
 	rtl8xxxu_write_rfreg(priv, RF_A, RF6052_REG_TXPA_G2, 0xf1173);
 
 	/* PA,PAD gain adjust */
-	val32 = rtl8xxxu_read_rfreg(priv, RF_A, RF6052_REG_UNKNOWN_DF);
+	val32 = rtl8xxxu_read_rfreg(priv, RF_A, RF6052_REG_GAIN_CCA);
 	val32 |= BIT(11);
-	rtl8xxxu_write_rfreg(priv, RF_A, RF6052_REG_UNKNOWN_DF, val32);
-	val32 = rtl8xxxu_read_rfreg(priv, RF_A, RF6052_REG_UNKNOWN_56);
+	rtl8xxxu_write_rfreg(priv, RF_A, RF6052_REG_GAIN_CCA, val32);
+	val32 = rtl8xxxu_read_rfreg(priv, RF_A, RF6052_REG_PAD_TXG);
 	u32p_replace_bits(&val32, 0xf, 0x003e0);
-	rtl8xxxu_write_rfreg(priv, RF_A, RF6052_REG_UNKNOWN_56, val32);
+	rtl8xxxu_write_rfreg(priv, RF_A, RF6052_REG_PAD_TXG, val32);
 
 	/*
 	 * Enter IQK mode
@@ -1170,9 +1170,9 @@ static int rtl8710bu_rx_iqk_path_a(struct rtl8xxxu_priv *priv, u32 lok_result)
 		u32p_replace_bits(&val32, 0, 0xffffff00);
 		rtl8xxxu_write32(priv, REG_FPGA0_IQK, val32);
 
-		val32 = rtl8xxxu_read_rfreg(priv, RF_A, RF6052_REG_UNKNOWN_DF);
+		val32 = rtl8xxxu_read_rfreg(priv, RF_A, RF6052_REG_GAIN_CCA);
 		val32 &= ~BIT(11);
-		rtl8xxxu_write_rfreg(priv, RF_A, RF6052_REG_UNKNOWN_DF, val32);
+		rtl8xxxu_write_rfreg(priv, RF_A, RF6052_REG_GAIN_CCA, val32);
 
 		return result;
 	}
@@ -1197,12 +1197,12 @@ static int rtl8710bu_rx_iqk_path_a(struct rtl8xxxu_priv *priv, u32 lok_result)
 	/*
 	 * PA, PAD setting
 	 */
-	val32 = rtl8xxxu_read_rfreg(priv, RF_A, RF6052_REG_UNKNOWN_DF);
+	val32 = rtl8xxxu_read_rfreg(priv, RF_A, RF6052_REG_GAIN_CCA);
 	val32 |= BIT(11);
-	rtl8xxxu_write_rfreg(priv, RF_A, RF6052_REG_UNKNOWN_DF, val32);
-	val32 = rtl8xxxu_read_rfreg(priv, RF_A, RF6052_REG_UNKNOWN_56);
+	rtl8xxxu_write_rfreg(priv, RF_A, RF6052_REG_GAIN_CCA, val32);
+	val32 = rtl8xxxu_read_rfreg(priv, RF_A, RF6052_REG_PAD_TXG);
 	u32p_replace_bits(&val32, 0x2a, 0x00fff);
-	rtl8xxxu_write_rfreg(priv, RF_A, RF6052_REG_UNKNOWN_56, val32);
+	rtl8xxxu_write_rfreg(priv, RF_A, RF6052_REG_PAD_TXG, val32);
 
 	/*
 	 * Enter IQK mode
@@ -1241,9 +1241,9 @@ static int rtl8710bu_rx_iqk_path_a(struct rtl8xxxu_priv *priv, u32 lok_result)
 	u32p_replace_bits(&val32, 0, 0xffffff00);
 	rtl8xxxu_write32(priv, REG_FPGA0_IQK, val32);
 
-	val32 = rtl8xxxu_read_rfreg(priv, RF_A, RF6052_REG_UNKNOWN_DF);
+	val32 = rtl8xxxu_read_rfreg(priv, RF_A, RF6052_REG_GAIN_CCA);
 	val32 &= ~BIT(11);
-	rtl8xxxu_write_rfreg(priv, RF_A, RF6052_REG_UNKNOWN_DF, val32);
+	rtl8xxxu_write_rfreg(priv, RF_A, RF6052_REG_GAIN_CCA, val32);
 
 	/* reload LOK value */
 	rtl8xxxu_write_rfreg(priv, RF_A, RF6052_REG_TXM_IDAC, lok_result);
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723b.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723b.c
index a7ad62a8a7c6..13ad5d5b73f4 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723b.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723b.c
@@ -824,7 +824,7 @@ static int rtl8723bu_rx_iqk_path_a(struct rtl8xxxu_priv *priv)
 	/*
 	 * PA, PAD setting
 	 */
-	rtl8xxxu_write_rfreg(priv, RF_A, RF6052_REG_UNKNOWN_DF, 0xf80);
+	rtl8xxxu_write_rfreg(priv, RF_A, RF6052_REG_GAIN_CCA, 0xf80);
 	rtl8xxxu_write_rfreg(priv, RF_A, RF6052_REG_UNKNOWN_55, 0x4021f);
 
 	/*
@@ -888,7 +888,7 @@ static int rtl8723bu_rx_iqk_path_a(struct rtl8xxxu_priv *priv)
 	reg_eac = rtl8xxxu_read32(priv, REG_RX_POWER_AFTER_IQK_A_2);
 	reg_ea4 = rtl8xxxu_read32(priv, REG_RX_POWER_BEFORE_IQK_A_2);
 
-	rtl8xxxu_write_rfreg(priv, RF_A, RF6052_REG_UNKNOWN_DF, 0x780);
+	rtl8xxxu_write_rfreg(priv, RF_A, RF6052_REG_GAIN_CCA, 0x780);
 
 	val32 = (reg_eac >> 16) & 0x3ff;
 	if (val32 & 0x200)
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index 812afe2641ed..9b165260f018 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -643,7 +643,7 @@ const u32 rtl8xxxu_iqk_phy_iq_bb_reg[RTL8XXXU_BB_REGS] = {
 	REG_OFDM0_XA_RX_IQ_IMBALANCE,
 	REG_OFDM0_XB_RX_IQ_IMBALANCE,
 	REG_OFDM0_ENERGY_CCA_THRES,
-	REG_OFDM0_AGCR_SSI_TABLE,
+	REG_OFDM0_AGC_RSSI_TABLE,
 	REG_OFDM0_XA_TX_IQ_IMBALANCE,
 	REG_OFDM0_XB_TX_IQ_IMBALANCE,
 	REG_OFDM0_XC_TX_AFE,
@@ -2867,10 +2867,10 @@ void rtl8xxxu_fill_iqk_matrix_b(struct rtl8xxxu_priv *priv, bool iqk_ok,
 	if (priv->rtl_chip == RTL8192F) {
 		rtl8xxxu_write32_mask(priv, REG_RXIQB_EXT, 0x000000f0, reg);
 	} else {
-		val32 = rtl8xxxu_read32(priv, REG_OFDM0_AGCR_SSI_TABLE);
+		val32 = rtl8xxxu_read32(priv, REG_OFDM0_AGC_RSSI_TABLE);
 		val32 &= ~0x0000f000;
 		val32 |= (reg << 12);
-		rtl8xxxu_write32(priv, REG_OFDM0_AGCR_SSI_TABLE, val32);
+		rtl8xxxu_write32(priv, REG_OFDM0_AGC_RSSI_TABLE, val32);
 	}
 }
 
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_regs.h b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_regs.h
index 64eda6330758..953c4e8b8188 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_regs.h
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_regs.h
@@ -449,7 +449,7 @@
 #define  LLT_OP_READ			(0x2 << 30)
 #define  LLT_OP_MASK			(0x3 << 30)
 
-#define REG_BB_ACCEESS_CTRL		0x01e8
+#define REG_BB_ACCESS_CTRL		0x01e8
 #define REG_BB_ACCESS_DATA		0x01ec
 
 #define REG_HMBOX_EXT0_8723B		0x01f0
@@ -1072,7 +1072,7 @@
 
 #define REG_OFDM0_AGC_PARM1		0x0c70
 
-#define REG_OFDM0_AGCR_SSI_TABLE	0x0c78
+#define REG_OFDM0_AGC_RSSI_TABLE	0x0c78
 
 #define REG_OFDM0_XA_TX_IQ_IMBALANCE	0x0c80
 #define REG_OFDM0_XB_TX_IQ_IMBALANCE	0x0c88
@@ -1351,11 +1351,11 @@
 #define RF6052_REG_T_METER_8723B	0x42
 #define RF6052_REG_UNKNOWN_43		0x43
 #define RF6052_REG_UNKNOWN_55		0x55
-#define RF6052_REG_UNKNOWN_56		0x56
+#define RF6052_REG_PAD_TXG		0x56
 #define RF6052_REG_TXMOD		0x58
 #define RF6052_REG_RXG_MIX_SWBW		0x87
 #define RF6052_REG_S0S1			0xb0
-#define RF6052_REG_UNKNOWN_DF		0xdf
+#define RF6052_REG_GAIN_CCA		0xdf
 #define RF6052_REG_UNKNOWN_ED		0xed
 #define RF6052_REG_WE_LUT		0xef
 #define RF6052_REG_GAIN_CTRL		0xf5
-- 
2.39.2
