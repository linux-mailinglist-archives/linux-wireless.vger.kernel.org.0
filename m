Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A58E56416C4
	for <lists+linux-wireless@lfdr.de>; Sat,  3 Dec 2022 13:55:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbiLCMzB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 3 Dec 2022 07:55:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiLCMzA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 3 Dec 2022 07:55:00 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E80B1AF07
        for <linux-wireless@vger.kernel.org>; Sat,  3 Dec 2022 04:54:59 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id ay27-20020a05600c1e1b00b003d070f4060bso6423554wmb.2
        for <linux-wireless@vger.kernel.org>; Sat, 03 Dec 2022 04:54:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7iZLbj/0LA/5WX181I6xzw8Ag37adaCwn9reU61rJy0=;
        b=ko9o9HIjwLaWDCBC/d/OlezbL0XGt4W2ywxvuB07QWd9R4jkoGlzOL8USB8ifAgK7G
         zSvOyc0cKSPvulD+NvbYUeNw6iZu9Ck27kI3WQG1qdVCxWq1vOqabMEV1yIjht+9OJ9z
         gZqIkvUeV8obWS7vPx7Qt1OhQd6N0MXh3vq656YK4BbaZ5kJ5wtr4h0trx88gsJc2CxW
         DCfC6i2WUSFhpToLZlqZnxr3F0mou387TeU6PetuS6ChhAgw803qisgR6ef/Gp35a1yk
         Y1vJPLhHBLcWToVO7mcfENCcmlDdDPzdO/CR8H4sGYxm1JTx6YcrY1jI2Bw5uyFM9jeI
         eYyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7iZLbj/0LA/5WX181I6xzw8Ag37adaCwn9reU61rJy0=;
        b=oQaMuvTR05yU6BebOguuiE0Ojl86pQrqupZ77iZYjUA+SkC0SzgkVhhUAF7db+5nA5
         RThNyfpEMTc/KJ3GqOEW/Zqbr1Q2OVMV8HZ8+yHEbEs/FU1Q8wQy9TgT/2EFM2xzD4jg
         JU4N/hGiTATdP2gznMfVlgm8l6ey9n0oUNnIlLX9BhPuFpc0T9srzZUItElcrO301SMV
         WlA/GRPwQ/3kMw6O+dr7WDWxq3qj4zCu18O6RY/JXPs0WvmrJ++PphJBJq/drGOSa7Ir
         t8UzAr05KQVWkDNN2iDAgUIOPWelf94rdVIqHJm+Lhjl5OW43I8VTcppS9eRQUw+sodt
         6INQ==
X-Gm-Message-State: ANoB5pngRgsU+Nkj/Vr5nMC7ZHjBH1peqnGN2Fxi0tnRE1rc4GzjeCHL
        sQ04l3xn3OEk/bp6I6sjRnI=
X-Google-Smtp-Source: AA0mqf4vRyqthvBgCEePEVOfTmYEo5q8/NMcFBzFddHlvq7JwuSjiCRImSTIrtO31QXqYJjflgb8zw==
X-Received: by 2002:a05:600c:3586:b0:3cf:a3b0:df6a with SMTP id p6-20020a05600c358600b003cfa3b0df6amr57459613wmq.126.1670072097765;
        Sat, 03 Dec 2022 04:54:57 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id r10-20020a05600c458a00b003cfd4a50d5asm17320643wmo.34.2022.12.03.04.54.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Dec 2022 04:54:57 -0800 (PST)
Date:   Sat, 3 Dec 2022 15:54:53 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     shayne.chen@mediatek.com
Cc:     linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: [bug report] wifi: mt76: mt7996: add driver for MediaTek Wi-Fi 7
 (802.11be) devices
Message-ID: <Y4tHHYLPX/6x6ztK@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello Shayne Chen,

The patch 98686cd21624: "wifi: mt76: mt7996: add driver for MediaTek
Wi-Fi 7 (802.11be) devices" from Nov 22, 2022, leads to the following
Smatch static checker warning:

	drivers/net/wireless/mediatek/mt76/mt7996/debugfs.c:657 mt7996_rf_regval_set()
	warn: passing casted pointer '&val' to 'mt7996_mcu_rf_regval()' 64 vs 32.

drivers/net/wireless/mediatek/mt76/mt7996/debugfs.c
    652 static int
    653 mt7996_rf_regval_set(void *data, u64 val)
    654 {
    655         struct mt7996_dev *dev = data;
    656 
--> 657         return mt7996_mcu_rf_regval(dev, dev->mt76.debugfs_reg, (u32 *)&val, true);
                                                                        ^^^^^^^^^^^
This code only "works" on little endian systems.  You have to do
something like:

	u32 u32_val = val;

	return mt7996_mcu_rf_regval(dev, dev->mt76.debugfs_reg, &u32_val, true);

    658 }

regards,
dan carpenter
