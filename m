Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CCA16416C5
	for <lists+linux-wireless@lfdr.de>; Sat,  3 Dec 2022 13:57:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbiLCM4A (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 3 Dec 2022 07:56:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiLCMz7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 3 Dec 2022 07:55:59 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C15041AF07
        for <linux-wireless@vger.kernel.org>; Sat,  3 Dec 2022 04:55:58 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id ay27-20020a05600c1e1b00b003d070f4060bso6424736wmb.2
        for <linux-wireless@vger.kernel.org>; Sat, 03 Dec 2022 04:55:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FoIrF7kCNUtvu8wYA9TbwcdtJkwsf3xKM7GSL38E1UY=;
        b=B/A+yde22CoSRt1erNSW9PIkw5uDNbCXjfPiWd6DgUkYxprrUD0GWDbRlPdmwKogdt
         xnv176ctbxHL+wa5NuovkgoRvGr81JimgEtVPgvGFhO9sQzcr5sWGf2QtI9/KOXgSOY7
         go7rFA1A90ed3w+OtFc8Cg/spmN0CvT20zWj60Ti1CGfDwuemjXrJo1B+/WnM1ylvak5
         6YPwneMzBadTLqnyHIf1SGyUOWNf6ElPY4EyfMmyMn0nr+uX5QJaasG9bjQR7ucRCPhM
         mGvJ7DsPfNnkZIkIMR2ATHC0sCG1XhmL+J9usIviSMIWt3w2pFpCbL9U47RDffZCmvWu
         c1SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FoIrF7kCNUtvu8wYA9TbwcdtJkwsf3xKM7GSL38E1UY=;
        b=ZQKwDzIU4hlz8iFC/JzdzhMTG8qXpgo7zvamGoxp6oc/AY3xZ4ibtbDxggxH89YpAR
         5aBYNh88g9eisFdf+g+4ukX7VmmpXqorfc4D0wyfZMcL4sYoFt7o05UiBikMvMJMhh1v
         imNoW1NdoE2P7oJN+aqsZ4AeRjm2dZQxkUI98n7S6i+2qPaH6tDCqcSSb6ANVY/M6ugV
         yPaAAxORK55GCdkxuVKn0fiBBmV2nVm9zHxK5KqR2lgtFEOTq9uiSy9nNk/Up4swLN85
         o4e5Lwlvw9sNUdf88dtGZNGBbBEXFxoTW9VQskm3Nb2/3ixMQosIqJhP3ZdYw78hzIE1
         6XZQ==
X-Gm-Message-State: ANoB5pk5SXrHQO+KYf+mhq8bAZJ6KRMC0Zn1WuH6eX3N6nbpmqtKzvxB
        EbgR25DOCNQPlwqacXWlo9E=
X-Google-Smtp-Source: AA0mqf68LQWYxzcpEE4UyZ1RNDhyoFlE9YQyZCuImQDl33nlRfA943Xd2rrT4EGiTuC72/qHAVYx4w==
X-Received: by 2002:a05:600c:3d08:b0:3cf:e84d:6010 with SMTP id bh8-20020a05600c3d0800b003cfe84d6010mr45826052wmb.197.1670072157348;
        Sat, 03 Dec 2022 04:55:57 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id j3-20020adfd203000000b002366c3eefccsm9546293wrh.109.2022.12.03.04.55.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Dec 2022 04:55:56 -0800 (PST)
Date:   Sat, 3 Dec 2022 15:55:53 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     shayne.chen@mediatek.com
Cc:     linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: [bug report] wifi: mt76: mt7996: add driver for MediaTek Wi-Fi 7
 (802.11be) devices
Message-ID: <Y4tHWWBKBU4GaMkX@kili>
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

	drivers/net/wireless/mediatek/mt76/mt7996/eeprom.c:72 mt7996_eeprom_load()
	error: uninitialized symbol 'free_block_num'.

drivers/net/wireless/mediatek/mt76/mt7996/eeprom.c
    55 static int mt7996_eeprom_load(struct mt7996_dev *dev)
    56 {
    57         int ret;
    58 
    59         ret = mt76_eeprom_init(&dev->mt76, MT7996_EEPROM_SIZE);
    60         if (ret < 0)
    61                 return ret;
    62 
    63         if (ret) {
    64                 dev->flash_mode = true;
    65         } else {
    66                 u8 free_block_num;
    67                 u32 block_num, i;
    68 
    69                 /* TODO: check free block event */
    70                 mt7996_mcu_get_eeprom_free_block(dev, &free_block_num);

free_block_num is not initialized if mt7996_mcu_get_eeprom_free_block()
fails.

    71                 /* efuse info not enough */
--> 72                 if (free_block_num >= 59)
    73                         return -EINVAL;
    74 
    75                 /* read eeprom data from efuse */
    76                 block_num = DIV_ROUND_UP(MT7996_EEPROM_SIZE, MT7996_EEPROM_BLOCK_SIZE);
    77                 for (i = 0; i < block_num; i++)
    78                         mt7996_mcu_get_eeprom(dev, i * MT7996_EEPROM_BLOCK_SIZE);
    79         }
    80 
    81         return mt7996_check_eeprom(dev);
    82 }

regards,
dan carpenter
