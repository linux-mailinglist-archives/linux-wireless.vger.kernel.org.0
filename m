Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BBBA6E4EC5
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Apr 2023 19:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbjDQRHP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 17 Apr 2023 13:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjDQRHO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 17 Apr 2023 13:07:14 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9758846AE
        for <linux-wireless@vger.kernel.org>; Mon, 17 Apr 2023 10:07:12 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id fw30so13247984ejc.5
        for <linux-wireless@vger.kernel.org>; Mon, 17 Apr 2023 10:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681751231; x=1684343231;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mEzyh4pakPHuQ8+nKfXaL43D7FIupaCBqefoqOH9kn8=;
        b=qvd26ltX2D82to3/vTe2knMGvkgRfcZvSrFxX8Kl1TggmQvdlX549spN9HL8WTCuv4
         UHaieeXuatKHvsC7hvJ6UYiTyrd3rwcHx3yLKOh9a/SkjgjSJmE0Ep+cbhe6GFxnaMT9
         qo1jkELRXH1I133CvJSUhbnTQTxBJKSPyljVkC0I6lBdgCJ5rMG8hcERoyHkAcOTwskn
         wNhd7syZ9mGT81I0E4loFoiZzeSbVA8Cpig5fyGJn/0HCTnr9Q701ipPOVBXyaLx3Dw6
         i3LE/L4VsiNPGLjTCCrxyar5b5vj5OH/g2crt4rc9Bgxq1vDEeJuEHUbtF8cYfx7DYVW
         KJ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681751231; x=1684343231;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mEzyh4pakPHuQ8+nKfXaL43D7FIupaCBqefoqOH9kn8=;
        b=FEA1z5V9LO8MVnz6PD+olnx2ckjKy7VTKIHCr3FRQWBPMGL74WdgOP3bGVsZR4vfgY
         UniHturkLlrlWJhHw+IlSBRrqv9KljLpJcMoPqIJ2uJV6vNtr7U4spVktcIShzeeQ8Zz
         +W6cOM7p2+Bim7auW/jErgoGiCaHGEqLKkngIcQS/CA3l7MAKddtIUNWdaQa4WoMju0r
         AfnbyL8IZLx53zKMk/7SYlZYPGShz/9gJdkcaTAxtcoJHlEVwmohLfrTjKVH52XELBcM
         +HFNTzHSdOIzbh5bxVDrQL2GhIHJYXQaPntfYjCgvDwa72TU1tVZitbavH1jmrfydKRY
         qWHw==
X-Gm-Message-State: AAQBX9flByxyH2qKuYObM+4DZU67DdlmoUAUNUIksf4UczBH6vQ/URb4
        9Zj47xQQJAhov4SGYk5lxrUBQuqdAQM=
X-Google-Smtp-Source: AKy350bux4drpiVsvVkPRBM5jriDmec8TQZrh4E6wrdEVWSgRJAb1Xlhlj8tpyOzFZ6sfM9j6QObyA==
X-Received: by 2002:a17:906:eceb:b0:94a:5c6c:e19a with SMTP id qt11-20020a170906eceb00b0094a5c6ce19amr7533771ejb.19.1681751230977;
        Mon, 17 Apr 2023 10:07:10 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.55])
        by smtp.gmail.com with ESMTPSA id v16-20020a1709064e9000b0094f663bced2sm2241623eju.33.2023.04.17.10.07.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Apr 2023 10:07:10 -0700 (PDT)
Message-ID: <9430b841-1048-b27c-14ec-fca447dc32af@gmail.com>
Date:   Mon, 17 Apr 2023 20:07:09 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: [PATCH 2/3] wifi: rtl8xxxu: Add rtl8xxxu_write{8,16,32}_{set,clear}
Content-Language: en-US
From:   Bitterblue Smith <rtl8821cerfe2@gmail.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Ping-Ke Shih <pkshih@realtek.com>
References: <a2a7d9df-0529-7890-3522-48dce613753f@gmail.com>
In-Reply-To: <a2a7d9df-0529-7890-3522-48dce613753f@gmail.com>
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

Also add rtl8xxxu_write32_mask, rtl8xxxu_write_rfreg_mask.

These helper functions make it easier to modify only parts of a register
by eliminating the call to the register reading function and the bit
manipulations.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu.h  | 12 +++
 .../wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 79 +++++++++++++++++++
 2 files changed, 91 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
index 82a0290ccb29..8eafbf1cee71 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
@@ -1953,10 +1953,22 @@ u32 rtl8xxxu_read32(struct rtl8xxxu_priv *priv, u16 addr);
 int rtl8xxxu_write8(struct rtl8xxxu_priv *priv, u16 addr, u8 val);
 int rtl8xxxu_write16(struct rtl8xxxu_priv *priv, u16 addr, u16 val);
 int rtl8xxxu_write32(struct rtl8xxxu_priv *priv, u16 addr, u32 val);
+int rtl8xxxu_write8_set(struct rtl8xxxu_priv *priv, u16 addr, u8 bits);
+int rtl8xxxu_write8_clear(struct rtl8xxxu_priv *priv, u16 addr, u8 bits);
+int rtl8xxxu_write16_set(struct rtl8xxxu_priv *priv, u16 addr, u16 bits);
+int rtl8xxxu_write16_clear(struct rtl8xxxu_priv *priv, u16 addr, u16 bits);
+int rtl8xxxu_write32_set(struct rtl8xxxu_priv *priv, u16 addr, u32 bits);
+int rtl8xxxu_write32_clear(struct rtl8xxxu_priv *priv, u16 addr, u32 bits);
+int rtl8xxxu_write32_mask(struct rtl8xxxu_priv *priv, u16 addr,
+			  u32 mask, u32 val);
+
 u32 rtl8xxxu_read_rfreg(struct rtl8xxxu_priv *priv,
 			enum rtl8xxxu_rfpath path, u8 reg);
 int rtl8xxxu_write_rfreg(struct rtl8xxxu_priv *priv,
 			 enum rtl8xxxu_rfpath path, u8 reg, u32 data);
+int rtl8xxxu_write_rfreg_mask(struct rtl8xxxu_priv *priv,
+			      enum rtl8xxxu_rfpath path, u8 reg,
+			      u32 mask, u32 val);
 void rtl8xxxu_save_regs(struct rtl8xxxu_priv *priv, const u32 *regs,
 			u32 *backup, int count);
 void rtl8xxxu_restore_regs(struct rtl8xxxu_priv *priv, const u32 *regs,
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index 6106b47d0c37..03c0aaa9141c 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -786,6 +786,85 @@ int rtl8xxxu_write32(struct rtl8xxxu_priv *priv, u16 addr, u32 val)
 	return ret;
 }
 
+int rtl8xxxu_write8_set(struct rtl8xxxu_priv *priv, u16 addr, u8 bits)
+{
+	u8 val8;
+
+	val8 = rtl8xxxu_read8(priv, addr);
+	val8 |= bits;
+	return rtl8xxxu_write8(priv, addr, val8);
+}
+
+int rtl8xxxu_write8_clear(struct rtl8xxxu_priv *priv, u16 addr, u8 bits)
+{
+	u8 val8;
+
+	val8 = rtl8xxxu_read8(priv, addr);
+	val8 &= ~bits;
+	return rtl8xxxu_write8(priv, addr, val8);
+}
+
+int rtl8xxxu_write16_set(struct rtl8xxxu_priv *priv, u16 addr, u16 bits)
+{
+	u16 val16;
+
+	val16 = rtl8xxxu_read16(priv, addr);
+	val16 |= bits;
+	return rtl8xxxu_write16(priv, addr, val16);
+}
+
+int rtl8xxxu_write16_clear(struct rtl8xxxu_priv *priv, u16 addr, u16 bits)
+{
+	u16 val16;
+
+	val16 = rtl8xxxu_read16(priv, addr);
+	val16 &= ~bits;
+	return rtl8xxxu_write16(priv, addr, val16);
+}
+
+int rtl8xxxu_write32_set(struct rtl8xxxu_priv *priv, u16 addr, u32 bits)
+{
+	u32 val32;
+
+	val32 = rtl8xxxu_read32(priv, addr);
+	val32 |= bits;
+	return rtl8xxxu_write32(priv, addr, val32);
+}
+
+int rtl8xxxu_write32_clear(struct rtl8xxxu_priv *priv, u16 addr, u32 bits)
+{
+	u32 val32;
+
+	val32 = rtl8xxxu_read32(priv, addr);
+	val32 &= ~bits;
+	return rtl8xxxu_write32(priv, addr, val32);
+}
+
+int rtl8xxxu_write32_mask(struct rtl8xxxu_priv *priv, u16 addr,
+			  u32 mask, u32 val)
+{
+	u32 orig, new, shift;
+
+	shift = __ffs(mask);
+
+	orig = rtl8xxxu_read32(priv, addr);
+	new = (orig & ~mask) | ((val << shift) & mask);
+	return rtl8xxxu_write32(priv, addr, new);
+}
+
+int rtl8xxxu_write_rfreg_mask(struct rtl8xxxu_priv *priv,
+			      enum rtl8xxxu_rfpath path, u8 reg,
+			      u32 mask, u32 val)
+{
+	u32 orig, new, shift;
+
+	shift = __ffs(mask);
+
+	orig = rtl8xxxu_read_rfreg(priv, path, reg);
+	new = (orig & ~mask) | ((val << shift) & mask);
+	return rtl8xxxu_write_rfreg(priv, path, reg, new);
+}
+
 static int
 rtl8xxxu_writeN(struct rtl8xxxu_priv *priv, u16 addr, u8 *buf, u16 len)
 {
-- 
2.39.2
