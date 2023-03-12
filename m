Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ADA36B6AC0
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Mar 2023 20:43:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbjCLTnD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 12 Mar 2023 15:43:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230309AbjCLTnC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 12 Mar 2023 15:43:02 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD1E44C28
        for <linux-wireless@vger.kernel.org>; Sun, 12 Mar 2023 12:43:00 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id d36so13127879lfv.8
        for <linux-wireless@vger.kernel.org>; Sun, 12 Mar 2023 12:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vtremblay.dev; s=google; t=1678650179;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aoWDm6ZvoLUF7S3MwvjvsZ9EtvnX0w1eA+1a4fAYPFo=;
        b=MRUo+6uH6ZRSO6/0ST6hEl8hFEHL+/Jlt/VITXca/2FVm/4cxI0W1u1DZJlbQ73Id5
         3wU1T45GxE6PdWyx8K2NssDthOHNQGZ6LMCfPjDETu14Q66QpeTqF74EknyrXsv5mrUd
         T3f5tDVZnMEm6fCmaiRXdXGC959bpLU5PKzg7m93YNSqg2iaywKKCkzwXR9QjjAPAMQZ
         5nXphPs9wgpOPaspqMxBW/76eBSgtFxBVEZiQ+rXdoFtrHLz6VkOwUKMaoUUoY/6Tjay
         u99Ijp7sb8YkgJJRGCTI3DCj1fAsd2TZT/Q2Vx0NY5kA0JzVA/Te7Z+CQhn19oux1pVJ
         LUEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678650179;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aoWDm6ZvoLUF7S3MwvjvsZ9EtvnX0w1eA+1a4fAYPFo=;
        b=0GRkgexreDgMDUopjmbPm130Qu6Lmh1ix+vmpEGdShSoRjWfAnN77rkb9r0+6rkU7g
         1p9OqLHqPJ/Mwzu7QUwS61x92IFSkeULm9sTeKy+CvZnCHGlnyLDxkCZDdYF4wHUJn1L
         AzYSPH5eQEIsTQsEMe0TUYX4Rld/nQ4qERGID2/JGdBtlHCDZRKMQ6BRr0GWLwuKo3dF
         aboD20LvHklBndJIib1xAXL2EjCkx76YWO7mefofTx1pmWZSAKzikNkMcf1KZNlPvU0r
         FJaZ9uBz2HoCbI9s+OsZOlEFRUDie3wawt5KuBFVuN6k3lZkpP/vAwbdfxz1kJ/YMX30
         LI2Q==
X-Gm-Message-State: AO0yUKXTYzwxd/h03tH9oHpWRfNCWZALovgrOXkjD1R9lMp0LqEx1fS5
        TJchnvqSfkzNhgbkZUPUd6Xjdk1xQgd4QzonxRxl23UhQTxad1xwRSDOaA==
X-Google-Smtp-Source: AK7set/JdhbmCYvzyVHpzDGiI6rd4IlV2eKMxhAp0xPqIhwVaAo0QYAyMSMBQ6DaHVbP4yZQyldvidpcE5x2Bn7Zdz4=
X-Received: by 2002:ac2:51aa:0:b0:4dc:807a:d14a with SMTP id
 f10-20020ac251aa000000b004dc807ad14amr9784883lfk.9.1678650178750; Sun, 12 Mar
 2023 12:42:58 -0700 (PDT)
MIME-Version: 1.0
From:   Vincent Tremblay <vincent@vtremblay.dev>
Date:   Sun, 12 Mar 2023 15:42:47 -0400
Message-ID: <CA+RD57MwUfAzF2u31Ews4uT0+A6uhjwwd40O=9uyZihap4nxdA@mail.gmail.com>
Subject: [PATCH v2] wifi: ath10k: read qcom,coexist-support as a u32
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Vincent Tremblay <vincent@vtremblay.dev>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Read qcom,coexist-support as a u32 instead of a u8

When we set the property to <1> in the DT (as specified in the doc),
"of_property_read_u8" read 0 instead of 1. This is because of the data format.

By default <1> is written with 32 bits.
The problem is that the driver is trying to read a u8.

The difference can be visualized using hexdump in a running device:
Default 32 bits output:
=======================
0000000 0000 0100
0000004

8 bits output:
==============
0000000 0001
0000001

By changing "of_property_read_u8" by "of_property_read_u32", the driver
is aligned with the documentation and is able to read the value without
modifying the DT.

The other solution would be to force the value in the DT to be saved as
an 8 bits value (qcom,coexist-support = /bits/ 8 <1>),
which is against the doc and less intuitive.

Validation:
===========
The patch was tested on a real device and we can see in the debug logs
that the feature is properly initialized:

[  109.102097] ath10k_ahb a000000.wifi: boot coex_support 1 coex_gpio_pin 52

Signed-off-by: Vincent Tremblay <vincent@vtremblay.dev>
---
 drivers/net/wireless/ath/ath10k/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/core.c
b/drivers/net/wireless/ath/ath10k/core.c
index 5eb131ab916f..802d6a12dc1e 100644
--- a/drivers/net/wireless/ath/ath10k/core.c
+++ b/drivers/net/wireless/ath/ath10k/core.c
@@ -2355,14 +2355,14 @@ static int ath10k_download_cal_data(struct ath10k *ar)
 static void ath10k_core_fetch_btcoex_dt(struct ath10k *ar)
 {
        struct device_node *node;
-       u8 coex_support = 0;
+       u32 coex_support = 0;
        int ret;

        node = ar->dev->of_node;
        if (!node)
                goto out;

-       ret = of_property_read_u8(node, "qcom,coexist-support", &coex_support);
+       ret = of_property_read_u32(node, "qcom,coexist-support", &coex_support);
        if (ret) {
                ar->coex_support = true;
                goto out;
