Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C464D5AB23D
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Sep 2022 15:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238459AbiIBNxd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 2 Sep 2022 09:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237081AbiIBNxO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 2 Sep 2022 09:53:14 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3778413A7E9
        for <linux-wireless@vger.kernel.org>; Fri,  2 Sep 2022 06:27:34 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id bp20so1837810wrb.9
        for <linux-wireless@vger.kernel.org>; Fri, 02 Sep 2022 06:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date;
        bh=787lA2AX4qiLw/kcyzU+KU3x1ygBbIR5cMew2XSZP2Q=;
        b=CIHawhZj0FJoOvKPpvjUUCR5fCXrVMQJqInVde3yoWUEer8Dd7JaRi2KkPiNniHmod
         SlTtz+oM8MZYx/F45S7rOSad4XJJ2kI6JDnFGYKLJpMp9YiQRZF4srkpIZh/m0RKue3G
         hzQ+w/tUSOwcJW5Y8XCchEKWkvKkT+pY6xAHV0H/ePQIw38fQpr8Aa/VD+wZF82nYXKa
         THGppFuS0+qKTO8pzneU2EfoUYhtY6ZbWicMlFw7NcRYTZGOdIEvH02g36GBdw41zr1L
         MBtfxeGKbX0PF2pFjBfzJZCvOGxnd9qb+UbjliiOiMVh5AaJaSry743ZC5y/jKB6RBa0
         v+7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date;
        bh=787lA2AX4qiLw/kcyzU+KU3x1ygBbIR5cMew2XSZP2Q=;
        b=nOjALgSWTQtC6+xCowiRS4XH+rXrMe0REL8voMxi2sMyWT9S1LS6VbfQLt7jPS1O2R
         0ujeRyotKKl0WTeiIKjJlDWS+9EoV3guJG1hV9umj5K50yRBKjjh+tBWw0rDy0hCR31X
         HMtxt8f1ZByWkz1B1n2ibnN1MITiGcSz+XXliG95TienSx8P5i9k/n0tMUlzpFIRejAM
         3N1udwceZ0RqFPW/ba5rleNC++stigh0sUofFH70ALNPhduNxmfMknNTgW52Bz/0USZB
         u56Qmex7pEdxnmtzJrl4+Mhl1JkU4Pu7id0TxpbiavZWdcc0Z6xAKUEjZ0RMwbRLJ8Jo
         ni8A==
X-Gm-Message-State: ACgBeo1w0jwp/GFKp5Z2cSj0CmXJ96FFGm5hNXoj7Lt5/HdyvtkccMIC
        EGSPzFqx6cwHWoJP2YnhxkI7n5zzZD4Vqw==
X-Google-Smtp-Source: AA6agR5WVlAxVma5saQHDRcr5fbT27rUfQCcYJTjd70lxdfQGtJiKUrNE4WRTQI+TD0QqB+bQ6Dwyg==
X-Received: by 2002:a5d:678c:0:b0:226:de76:be99 with SMTP id v12-20020a5d678c000000b00226de76be99mr11970185wru.428.1662124531770;
        Fri, 02 Sep 2022 06:15:31 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.23])
        by smtp.gmail.com with ESMTPSA id w4-20020adfd4c4000000b0021badf3cb26sm1869518wrk.63.2022.09.02.06.15.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Sep 2022 06:15:31 -0700 (PDT)
Message-ID: <d5544fe8-9798-28f1-54bd-6839a1974b10@gmail.com>
Date:   Fri, 2 Sep 2022 16:15:30 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Content-Language: en-US
To:     linux-wireless@vger.kernel.org
Cc:     Jes.Sorensen@gmail.com
From:   Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: [PATCH] wifi: rtl8xxxu: Remove copy-paste leftover in
 gen2_update_rate_mask
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

It looks like a leftover from copying rtl8xxxu_update_rate_mask,
which is used with the gen1 chips.

It wasn't causing any problems for my RTL8188FU test device, but it's
clearly a mistake, so remove it.

Fixes: f653e69009c6 ("rtl8xxxu: Implement basic 8723b specific update_rate_mask() function")
Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index b4e09da1c683..acd55681a3d3 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -4440,15 +4440,14 @@ void rtl8xxxu_gen2_update_rate_mask(struct rtl8xxxu_priv *priv,
 	h2c.b_macid_cfg.ramask2 = (ramask >> 16) & 0xff;
 	h2c.b_macid_cfg.ramask3 = (ramask >> 24) & 0xff;
 
-	h2c.ramask.arg = 0x80;
 	h2c.b_macid_cfg.data1 = rateid;
 	if (sgi)
 		h2c.b_macid_cfg.data1 |= BIT(7);
 
 	h2c.b_macid_cfg.data2 = bw;
 
-	dev_dbg(&priv->udev->dev, "%s: rate mask %08x, arg %02x, size %zi\n",
-		__func__, ramask, h2c.ramask.arg, sizeof(h2c.b_macid_cfg));
+	dev_dbg(&priv->udev->dev, "%s: rate mask %08x, rateid %02x, sgi %d, size %zi\n",
+		__func__, ramask, rateid, sgi, sizeof(h2c.b_macid_cfg));
 	rtl8xxxu_gen2_h2c_cmd(priv, &h2c, sizeof(h2c.b_macid_cfg));
 }
 
-- 
2.37.2
