Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D48FD64763F
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Dec 2022 20:34:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbiLHTeK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 8 Dec 2022 14:34:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiLHTeJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 8 Dec 2022 14:34:09 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D70A60340
        for <linux-wireless@vger.kernel.org>; Thu,  8 Dec 2022 11:34:05 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id z92so245478ede.1
        for <linux-wireless@vger.kernel.org>; Thu, 08 Dec 2022 11:34:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j0fIvmWIXC/bOWAKQkQKVKw+6yE449NOWkc6VNjsFKQ=;
        b=aXQVFP6hoFx2chr6GTNTGHbeOTUJowiTyysxXQxi7gLi8ZDZCuk3FQ9PiW2B30utlN
         0gwoPuGa2NW13giRAd0GOK0YugbVy4K2V8Do6ErbJF/etWlqa95KE3OAzsGP9xnKaw80
         ZKUvByM04F1h7c+DkMJBFsTVZaxzhSPoAF/7CV8jF9lKhsRsAaS69GboyJ0mVcGih7dr
         ikacTvgua9EAKHOQc6qnRU59pkvg8yE104CI0n8dXuoVsSWWfRXYYQaaPf3H6HhnafiE
         RzIifMGNwsxDq1hEdMqyRZQY9YZXBCtZKnFSmX4O7cHJmHLJNBIURe4V1GD+BuRxR11h
         0tCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j0fIvmWIXC/bOWAKQkQKVKw+6yE449NOWkc6VNjsFKQ=;
        b=6YDLAlr28/HCybZwIoRLvopkC1UZBtqepB02SlpicmP+nXwM2uz7RVOlBQ2Y5O/eC7
         KQzzJ+KL/exVu5O4G9V/meev6LXLCBlQXNwl/29KdEMSly7V9sSM8yLGhmy1w/Fqzj0i
         xmiZF+fpYEkPNmIl0Eb82tzvqOhmHC46bP7u8qqDERKHJkN3r50BwEamKPlcEQShX0S5
         hMkjUlDixVBnUtruohF9KY2fKdAgpOWJrK3FEctLjwQkfap4rh7U2W95xlHgnJVjK7JX
         S45qNdDictOdMpg9SH2J37pStL7xLwZJsVHd0b1RySU/nMNNJfgKu+HjKird5u5YK6Vy
         KTCQ==
X-Gm-Message-State: ANoB5pkijfHTygr+dC0ED7EMHvd4bN3V/X1WZ3eYKmGHOhu6nfWLlLYm
        AjKGBTboRh/n2PM5m9UHiLn6Azhpsmk=
X-Google-Smtp-Source: AA0mqf7M2Fw1iYOL+dYIX0HQMbfysgASvFt+XX+XQpLWkNqeSHt+OoBKn2RV0BFJYSMUlpyt/8Up3g==
X-Received: by 2002:a05:6402:289c:b0:461:bf47:ba43 with SMTP id eg28-20020a056402289c00b00461bf47ba43mr3527749edb.28.1670528043857;
        Thu, 08 Dec 2022 11:34:03 -0800 (PST)
Received: from [192.168.1.50] ([79.119.240.254])
        by smtp.gmail.com with ESMTPSA id dk21-20020a0564021d9500b0045723aa48ccsm3716598edb.93.2022.12.08.11.34.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Dec 2022 11:34:03 -0800 (PST)
Message-ID: <7bb4858c-5cef-9cae-5e08-7e8444e8ba89@gmail.com>
Date:   Thu, 8 Dec 2022 21:34:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: [PATCH 2/2] wifi: rtl8xxxu: Fix assignment to bit field
 priv->cck_agc_report_type
Content-Language: en-US
From:   Bitterblue Smith <rtl8821cerfe2@gmail.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Ping-Ke Shih <pkshih@realtek.com>
References: <4368d585-11ec-d3c7-ec12-7f0afdcedfda@gmail.com>
In-Reply-To: <4368d585-11ec-d3c7-ec12-7f0afdcedfda@gmail.com>
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

Just because priv->cck_agc_report_type is only one bit doesn't mean
it works like a bool. The value assigned to it loses all bits except
bit 0, so only assign 0 or 1 to it.

This affects the RTL8192EU, but rtl8xxxu already can't connect to any
networks with this chip, so it probably didn't bother anyone.

Fixes: 2ad2a813b803 ("wifi: rtl8xxxu: Fix the CCK RSSI calculation")
Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index 3ed435401e57..799b03ec1980 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -4208,10 +4208,12 @@ static int rtl8xxxu_init_device(struct ieee80211_hw *hw)
 		 * should be equal or CCK RSSI report may be incorrect
 		 */
 		val32 = rtl8xxxu_read32(priv, REG_FPGA0_XA_HSSI_PARM2);
-		priv->cck_agc_report_type = val32 & FPGA0_HSSI_PARM2_CCK_HIGH_PWR;
+		priv->cck_agc_report_type =
+			u32_get_bits(val32, FPGA0_HSSI_PARM2_CCK_HIGH_PWR);
 
 		val32 = rtl8xxxu_read32(priv, REG_FPGA0_XB_HSSI_PARM2);
-		if (priv->cck_agc_report_type != (bool)(val32 & FPGA0_HSSI_PARM2_CCK_HIGH_PWR)) {
+		if (priv->cck_agc_report_type !=
+		    u32_get_bits(val32, FPGA0_HSSI_PARM2_CCK_HIGH_PWR)) {
 			if (priv->cck_agc_report_type)
 				val32 |= FPGA0_HSSI_PARM2_CCK_HIGH_PWR;
 			else
-- 
2.38.0
