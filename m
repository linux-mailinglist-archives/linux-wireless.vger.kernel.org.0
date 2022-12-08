Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 834AF64763A
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Dec 2022 20:32:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbiLHTca (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 8 Dec 2022 14:32:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiLHTc3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 8 Dec 2022 14:32:29 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A7969E474
        for <linux-wireless@vger.kernel.org>; Thu,  8 Dec 2022 11:32:28 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id c66so218304edf.5
        for <linux-wireless@vger.kernel.org>; Thu, 08 Dec 2022 11:32:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4NYG9lYEZ9wsyuwGTuamr3MpqAUVMVxHSEFMBUyZQg4=;
        b=m9UY/ppuM6so+aDHm+3TIwuNG7HnrZ3nIcDPo9V1AwCuSkmep2GCi6PfDDOXcWMyjw
         GIhZjgXZTyDVsaX9chD/htfVDFQdiwd3BJP13/sQj/ELrxyQ6309pqxaUjXKq6Zr+myA
         u1fALcmv+4XVfPzadmEctOhpe7mUXDrybcQtp2+woNTAngBw33V1wUEtvjYcIcQlUkh9
         AFR+iVuyQ/Xp4rXMTKTI8AdrZoKYh3tMV/11HXQAUODiAvkK/ZQbkmmP3tvBbgPBcGDH
         2GXAcPxs+Q+75EiqwC92o4R0/IW4aff19D0AGehn6eMpyF6oGo2yUtjxWOH6L69bQiah
         4/QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4NYG9lYEZ9wsyuwGTuamr3MpqAUVMVxHSEFMBUyZQg4=;
        b=z3llIwyxQHJYroQvvO95UsaRZ+/BB0Crz34+U9VoW4bbcz9V950FrmNH0fZmGdfy6I
         FPs/SKzUqwl6dk2tZtMt08Lcl7jDqlFZYOTboPqQo4d9jxqrG85ZUKDs7u1lwxAN4wrx
         49UQh90pzNzdYlo020UpW7ZyIVlfNdttHmvbMHZCora/O0bTDYEG1AoxMXRMEjs0Fg91
         NwKb3Oau0zVcxKkXqLb6dsu+WAdq/qCg2ANQ7XbvJ3Wrub53evHog0fnYAVqUYUuWK6O
         whtMbpcZvtN94iRLb8Gm0zZg/oGe5duzr+VBR5GpJ+YsK8pFJF7zjQ1G6bTFpzeDmD9z
         mCQA==
X-Gm-Message-State: ANoB5pk0LPehpt0kJR7ejRWbGWMhTgiI+urYSpKWeD0WlLMLR3vvP2Cj
        3xuEROzPwf1j9esqcVM0UZi9YlbSm78=
X-Google-Smtp-Source: AA0mqf7s3PQBOGhiXPe+M67kdRx9kXAsTrBDKpZII3ME4oRMm0U9+AXjPkPk8ZnhiXdxUQ0+U2PD6w==
X-Received: by 2002:aa7:c844:0:b0:461:9faf:6895 with SMTP id g4-20020aa7c844000000b004619faf6895mr2710687edt.16.1670527946592;
        Thu, 08 Dec 2022 11:32:26 -0800 (PST)
Received: from [192.168.1.50] ([79.119.240.254])
        by smtp.gmail.com with ESMTPSA id g3-20020aa7c843000000b0046c5baa1f58sm3682864edt.97.2022.12.08.11.32.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Dec 2022 11:32:25 -0800 (PST)
Message-ID: <4368d585-11ec-d3c7-ec12-7f0afdcedfda@gmail.com>
Date:   Thu, 8 Dec 2022 21:32:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Content-Language: en-US
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Ping-Ke Shih <pkshih@realtek.com>
From:   Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: [PATCH 1/2] wifi: rtl8xxxu: Fix assignment to bit field
 priv->pi_enabled
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

Just because priv->pi_enabled is only one bit doesn't mean it works
like a bool. The value assigned to it loses all bits except bit 0,
so only assign 0 or 1 to it.

This affects the RTL8188FU, but fixing the assignment didn't make
a difference for my device.

Fixes: c888183b21f3 ("wifi: rtl8xxxu: Support new chip RTL8188FU")
Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c
index 2c4f403ba68f..97e7ff7289fa 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c
@@ -1122,7 +1122,7 @@ static void rtl8188fu_phy_iqcalibrate(struct rtl8xxxu_priv *priv,
 
 	if (t == 0) {
 		val32 = rtl8xxxu_read32(priv, REG_FPGA0_XA_HSSI_PARM1);
-		priv->pi_enabled = val32 & FPGA0_HSSI_PARM1_PI;
+		priv->pi_enabled = u32_get_bits(val32, FPGA0_HSSI_PARM1_PI);
 	}
 
 	/* save RF path */
-- 
2.38.0
