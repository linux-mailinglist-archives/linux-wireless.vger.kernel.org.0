Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC64C5962F7
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Aug 2022 21:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235558AbiHPTTB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 16 Aug 2022 15:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236979AbiHPTS7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 16 Aug 2022 15:18:59 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E90E45A145
        for <linux-wireless@vger.kernel.org>; Tue, 16 Aug 2022 12:18:57 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id m2so10080451pls.4
        for <linux-wireless@vger.kernel.org>; Tue, 16 Aug 2022 12:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20210112.gappssmtp.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc;
        bh=sU8ZxCPFvp+/PqA1iqhL2xMs/rjmRkssshJ3eEemqU4=;
        b=uR1SvDcXE4+u3n7P4wq8Yle/nFDJZkXXrSJsNiiCMwlj69mNbLjgT8LGqe2Ln/yfOz
         DPzY6qIxywUpJaaA7/IBsFC2eoSzDC2ibolfG1ETt/WMvrQkOFhElRZlBwWXI0j+Q5zK
         0SLe3vrOLZo19QcehV3jc1wIxlV2ccVzFKtuICrxvjAVfmQlMMDeShsDO2IAKdn13ljN
         E2JI+/fosViPGrAQyMphi54nVJ+9oHhPNBL3K82gWm8Mkw0UDex5sVi+ASu9pi7DdY3x
         LDsJ/pe5Adenn/kT5/JVlNEpxzmn5C1/4qUAF6Kn+ZiQ/M6U5DiKsce/3coegTJ81j5E
         jNbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc;
        bh=sU8ZxCPFvp+/PqA1iqhL2xMs/rjmRkssshJ3eEemqU4=;
        b=lA64ttiXjWCu4fEmg7wCTvFyJZ5dLW+a2VhmP+y01dMHNh21OGutm8thI6iLZ54QVE
         QWTL1e9ID8U2RgXoMwserM/yZb4hFEP4yzK1jTOuGu03lqdau0Jggb2qzwEcSdDmda8g
         RqZsCnwZBP0cQTjCCRnWeb7TD2L4p2j+zoja6QDj1VH6pSa0UUtYfIGAYO8I1y+7x9wS
         yUV4BRfElZIauKHaHtlX5e8VJpRmDvFNsIZLMPprJMih7xOFWyKCOyX8nA4c1ihYBIZV
         2gIw4BqL+qkszQiNOuH+EWioX494vjb6k4GApOfPOxkBFjIy2Ag0EEmNH4W5o6n0GIwK
         4JvA==
X-Gm-Message-State: ACgBeo0xI5mX0GjU4ccZLfG5Zl0NjGS9BKDyxXao7SmvlBUi+50KHVcI
        RAmlZ9TONOofoOp7cn+cram8UAWEmB46F/mnu+vYlOFAaqM=
X-Google-Smtp-Source: AA6agR45/sbSna6j1y+jek9+r48p+1An6pkLYROZ1pigqzL9fxUFXwTSa/tOizYUVOEttSKajHDqgMARia4BdcmoC5M=
X-Received: by 2002:a17:90a:1b65:b0:1f7:4725:aa6e with SMTP id
 q92-20020a17090a1b6500b001f74725aa6emr21703pjq.179.1660677536946; Tue, 16 Aug
 2022 12:18:56 -0700 (PDT)
MIME-Version: 1.0
From:   Tim Harvey <tharvey@gateworks.com>
Date:   Tue, 16 Aug 2022 12:18:45 -0700
Message-ID: <CAJ+vNU31b+ytaCDzomW-iLAds6Pp_n4LQgANETvHnQaaPGgSTA@mail.gmail.com>
Subject: brcmfmac driver with CYW4373E, MCS rate table, statistics, and performance
To:     linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Greetings,

Is there a way to get the MCS rate table and stats from the brcmfmac driver?

I have a CYW4373E based 802.11ac SDIO module and am wondering what
others have gotten for infrastructure throughput on this chip. I'm
seeing about 270mbps in AP mode with MCS9 (MCS rate verified by client
side device). I'm guessing the much lower than (theoretical) 433mbps
rate I'm getting is a factor of the SDIO bus (which is running at
208MHz SDR104).

Best Regards,

Tim
