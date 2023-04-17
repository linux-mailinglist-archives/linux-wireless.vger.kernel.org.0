Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 481006E4ECF
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Apr 2023 19:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbjDQRIu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 17 Apr 2023 13:08:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbjDQRIt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 17 Apr 2023 13:08:49 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFEBDC67A
        for <linux-wireless@vger.kernel.org>; Mon, 17 Apr 2023 10:08:23 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id dx24so22024646ejb.11
        for <linux-wireless@vger.kernel.org>; Mon, 17 Apr 2023 10:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681751302; x=1684343302;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7J/Gmt+spocMRrReMmVXHsLa3nxHGax+i2VF8ucgwDw=;
        b=k/IyznacDhrUaTh16CNg0f3q44/7HVhdLTcDshPs6dgrzkJDoPFckMiKWSeCtMPN9N
         WcyskBS6/Nt6gDjW47VQMccaHc2s9JiS+mtno/x61WZpWNV5K14rJeAY60e+ttNyAXdp
         /nJYL2G519WAUzyFFC5WdXomZUkNmTPxw0A3eWm81w8GZofOHmSY4ioAps6qIg2iA23e
         qe6slFQq20HSyJXX47OVfWvML+fTfenrx6X+ZUL8fbozo6psr+Txr5BN7c/p7NB9qymZ
         i8D1smm1ZjC8d4U6wjO5Y0RZjbd0WQZVgsSqwzqcvtscY/cqp38XEVXQmr6MUSB+nG89
         gAKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681751302; x=1684343302;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7J/Gmt+spocMRrReMmVXHsLa3nxHGax+i2VF8ucgwDw=;
        b=PkbzXODEKR3LWzYrLrNyfysal5NnH62ZXi7D268pV6+07vb/Jv+aYQNbzZsTCx+x8l
         TuPaLJfSj25CeMVckWZXsyRHQdF3wDXHAtXXwSIhGFNHWQl72+3u1WeGJvdyC3ofZnS9
         XMOaWf2fETOk37W9hCyTlf9cpOlEAQMbBsXPlWXeagVYRHddtP6glD6BxcHaU88Q6uMB
         Esx95pFBIJnuFC3pz62ijTKVS/ZFDw48J4Tn8C8pIDL3UIxK79aBazCJ/YFf/gB0QBvT
         HN2bjNfz17nsC3pIUbqMMHbw6+Y/ckwJ5DPSRNJalR+/baifqXP3NmrXXbqT+O4In9mf
         PqSw==
X-Gm-Message-State: AAQBX9fNnGhkrLKgGBCN2WkAYo3PvOjBHd0x7CaRn0TaWFQbyQsCsk9+
        mOlF6PgQiRBKAmSNdt8qQt8el7I+OjQ=
X-Google-Smtp-Source: AKy350YtAgM254g9H/SS/BQI2je5MQY8V1QHNmdPFSXTWiPMA502p96CkY8rAWFPbwZ5YIam96rYtQ==
X-Received: by 2002:a17:906:9bca:b0:94e:cfd0:ed9f with SMTP id de10-20020a1709069bca00b0094ecfd0ed9fmr7570786ejc.26.1681751301831;
        Mon, 17 Apr 2023 10:08:21 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.55])
        by smtp.gmail.com with ESMTPSA id qx11-20020a170906fccb00b0094f499257f7sm2805167ejb.151.2023.04.17.10.08.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Apr 2023 10:08:21 -0700 (PDT)
Message-ID: <cf91ca69-70e3-4c20-c0b1-e59d452356a1@gmail.com>
Date:   Mon, 17 Apr 2023 20:08:20 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: [PATCH 3/3] wifi: rtl8xxxu: Simplify setting the initial gain
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

The goal of writing 0x6954341e / 0x6955341e to REG_OFDM0_XA_AGC_CORE1
appears to be setting the initial gain, which is stored in bits 0..6.
Bits 7..31 are the same as what the phy init tables write.

Modify only bits 0..6 so that we don't have to care about the values
of the others. This way we don't have to add another "else if" for the
RTL8192FU.

Why we need to change the initial gain from the default 0x20 to 0x1e?
Not sure. Some of the vendor drivers change it to 0x1e before scanning
and then restore it to the original value after.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index 03c0aaa9141c..fd8c8c6d53d6 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -7034,10 +7034,8 @@ static int rtl8xxxu_start(struct ieee80211_hw *hw)
 	rtl8xxxu_write16(priv, REG_RXFLTMAP2, 0xffff);
 	rtl8xxxu_write16(priv, REG_RXFLTMAP0, 0xffff);
 
-	if (priv->rtl_chip == RTL8188E)
-		rtl8xxxu_write32(priv, REG_OFDM0_XA_AGC_CORE1, 0x6955341e);
-	else
-		rtl8xxxu_write32(priv, REG_OFDM0_XA_AGC_CORE1, 0x6954341e);
+	rtl8xxxu_write32_mask(priv, REG_OFDM0_XA_AGC_CORE1,
+			      OFDM0_X_AGC_CORE1_IGI_MASK, 0x1e);
 
 	return ret;
 
-- 
2.39.2
