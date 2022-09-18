Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 422D65BBDC6
	for <lists+linux-wireless@lfdr.de>; Sun, 18 Sep 2022 14:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbiIRM1X (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 18 Sep 2022 08:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiIRM1W (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 18 Sep 2022 08:27:22 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6807B1CB00
        for <linux-wireless@vger.kernel.org>; Sun, 18 Sep 2022 05:27:21 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id lh5so16956814ejb.10
        for <linux-wireless@vger.kernel.org>; Sun, 18 Sep 2022 05:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date;
        bh=VdeDVxn0a+SyVtWfx8XXum9Q8ADr3NnzZNxxbIAS59E=;
        b=jvKaI8SuVkJgRwuvcCWYBYGuc6rbAnTzaqCePZWD8Kd7rC3XD5rCWND7gogWQwrsum
         fBq5qMmo91JNfu4rYKHS4T4xOpNZy/MeO3AmnTuIe9+qj5UFENwVPocyHDBqG6oihb3y
         lsZy8bscabFzbGPijv/tPNNTYlwbz+eekB0TjoGqkAg//emiLDIixioqebrp9TaYIpkE
         /k6V6L2DTHxmpdtXwROarFxlvPvU+sR4TlPTzjGF+TJ1c313i5kfLf5mUy29uegsJ96x
         DBZUq3gQEdo+UOx8UyKqIj/QdgSEvv1i1xY/ESeMDzhZx4MurISBb09tTk36WBa5V5Tp
         Bg3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date;
        bh=VdeDVxn0a+SyVtWfx8XXum9Q8ADr3NnzZNxxbIAS59E=;
        b=U4kdNzZdFF4dcCd2c7sTwNrIqe1odoY3MmHesnvpa+R0k1XGGvmvrBALwm0UIRjQ1q
         uqjPaK7x4pJVqmn2/UaWItjJ2MGKIrOOkj+sR8qbaiddr5ewgWsgYyosaN4E2gpnHpe8
         gMVNfuH/Aeb+Hz72Wfi5lsXpecwvBVRad70rw569+FcZhHPoQ7mGDiJHuW9DJUwFfuL4
         PLpfzTYjG3VvqZqEBcmbLQ/TEiUAfdnMHo1mIMv0+6m5lk5RkkhggcabOPlNuuSZRp3l
         wVPsf+vTMipc4M4J05bed4XH5hageVjvIKEasfk+qD1JAl5Z3Am1SD4bljNuVi8MXag0
         AhXQ==
X-Gm-Message-State: ACrzQf3ddkztJ2DlOPr9Rq7kYjUgvuTFIrAfSHHKK8CFd2e/Sp8w23vq
        kKHDt7U/FlVse4RKsIgjLJKYHRU4EvQ=
X-Google-Smtp-Source: AMsMyM4Dvgl7YImvPTwjLhUOZ5v4shtW/7eiL9x+Vmz+qcOyqz37Lqfxe3NQqdku16MmrbqDZ6EaWQ==
X-Received: by 2002:a17:907:da0:b0:772:6e9a:8ff9 with SMTP id go32-20020a1709070da000b007726e9a8ff9mr9832159ejc.111.1663504039924;
        Sun, 18 Sep 2022 05:27:19 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.23])
        by smtp.gmail.com with ESMTPSA id ee52-20020a056402293400b00453995b4c20sm4061702edb.73.2022.09.18.05.27.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Sep 2022 05:27:19 -0700 (PDT)
Message-ID: <56712d04-1505-2cbb-b6ac-3af4e73de108@gmail.com>
Date:   Sun, 18 Sep 2022 15:26:56 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Content-Language: en-US
To:     linux-wireless@vger.kernel.org
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>, chris.chiu@canonical.com
From:   Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: [PATCH 0/4] wifi: rtl8xxxu: A few improvements
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

I found these problems in my quest to make rtl8xxxu as fast as the
rtl8188fu driver. With these changes at least the download speed is
almost as good. The upload speed gets better but it's not there yet,
possibly because there is no MSDU aggregation.

Bitterblue Smith (4):
  wifi: rtl8xxxu: gen2: Turn on the rate control
  wifi: rtl8xxxu: gen2: Enable 40 MHz channel width
  wifi: rtl8xxxu: Fix AIFS written to REG_EDCA_*_PARAM
  wifi: rtl8xxxu: Improve rtl8xxxu_queue_select

 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu.h  |  6 +-
 .../wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 92 ++++++++++++++++---
 2 files changed, 82 insertions(+), 16 deletions(-)

-- 
2.37.2
