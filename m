Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D67C2529CA6
	for <lists+linux-wireless@lfdr.de>; Tue, 17 May 2022 10:37:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238468AbiEQIhv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 May 2022 04:37:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232605AbiEQIht (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 May 2022 04:37:49 -0400
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com [IPv6:2607:f8b0:4864:20::a33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A83636151
        for <linux-wireless@vger.kernel.org>; Tue, 17 May 2022 01:37:48 -0700 (PDT)
Received: by mail-vk1-xa33.google.com with SMTP id e144so8681714vke.9
        for <linux-wireless@vger.kernel.org>; Tue, 17 May 2022 01:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d9Asr0SeltTw/PH/mfYIRVg4glPFZ1rj4w1tcUD07rs=;
        b=PIYIRnb82+X/4SqmLtRLy7keWVP2YyhMzpyh9YAKvbSGIIACp3IurgVNVgMpFh3cRo
         y7iHeZ7/vfQt/kEaAHdq45GTyzvSPoxboGVuLozgy/VyzG1LID+3VCdZIiei2y0W07pC
         o0WzSsGYaJwTGceJg3nMuh6hGG+RoytIKdztWMSnC3JMzHioRNGR3s9LDLaVIDfckDA0
         0cSxjpsqs8x0RyMLeKnhPe04lsGbrIwx8HnhprF+ZF16Nj9rwr4M0+6T0Sv8UNNrjlkw
         gdcxGEJcWiC/+mRpXsbn44FM1v3QeYubU6Znziqj71tAPxysaNGX5rmqhI58DpX2Dhv4
         fdYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d9Asr0SeltTw/PH/mfYIRVg4glPFZ1rj4w1tcUD07rs=;
        b=e5sPlkCb/1+NH1UnqMzDZKDDGqvH6dG7aw5y+KWqAa3WbC3eney53GLt4/k+TGfevt
         Pn52fUi1oY2X/7q833ZvL1kH7fjWKQUfn8LXMBuMGu6uVhmIAZyxird17SWaOZ7RDHAD
         3kiAODExjH6XPsNG6NxrbEGr01uazuCIqfx61IehF9RzZmyRrhekqosaURr5b3gpWXkT
         eu5n4aP9Z2Hy3w9UZjZfdXqTuPKGLka+f/+fSwTRnsjxyUNm0ubPW43qxTYTEexp8cZN
         ZAjUBiPAcJOYNPQdYZqro/AjpaH/LD0wDGuV2dL77aO+D2d0JG/vnnZDkAb4oWjwUo9r
         6AdA==
X-Gm-Message-State: AOAM5308KS2OLjGysIJmbjmru3rM29eGZLmGh3DireEwFHa6LC1g8qB2
        vOv2xso5QWVkUKtz8eglv01CvF6yiDbNrmg6ne6Djt+IgZw=
X-Google-Smtp-Source: ABdhPJz1VBgB0+0+lF8vdD2fAqckoVwXjPs32pRcGWWJu3JLt4+yvqqO3vM9ugzS91PuNTenkRJRAc2813RR0OA0L7c=
X-Received: by 2002:a05:6122:890:b0:352:b096:d44b with SMTP id
 16-20020a056122089000b00352b096d44bmr8021401vkf.41.1652776667432; Tue, 17 May
 2022 01:37:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220516032519.29831-1-ryazanov.s.a@gmail.com> <CAByNJ6qDgqwxqGe0+uKSGCFKLULqEQ+NeBr-dAP=2Maov9ynqA@mail.gmail.com>
In-Reply-To: <CAByNJ6qDgqwxqGe0+uKSGCFKLULqEQ+NeBr-dAP=2Maov9ynqA@mail.gmail.com>
From:   Sergey Ryazanov <ryazanov.s.a@gmail.com>
Date:   Tue, 17 May 2022 11:37:36 +0300
Message-ID: <CAHNKnsRx0VWDVsP_KOKaPrU=eODOUCmpyBbYsN1rYEBXvRdaGA@mail.gmail.com>
Subject: Re: [PATCH 0/4] ath10k: add encapsulation offloading support
To:     Edward Matijevic <motolav@gmail.com>
Cc:     Kalle Valo <kvalo@kernel.org>, ath10k@lists.infradead.org,
        linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello Edward,

On Tue, May 17, 2022 at 5:37 AM Edward Matijevic <motolav@gmail.com> wrote:
> Hello,
> I confirm now my QCA9377 pci module has no regressions in either modes
> with these patches
> I was able to test it as an AP and it worked under ETHERNET mode
> without any obvious regressions but I'm unable to check maximum
> throughput
>
> My hardware info from dmesg and tested on kernel 5.17.7
> qca9377 hw1.0 target 0x05020000 chip_id 0x003820ff sub 11ad:0806
> firmware ver WLAN.TF.2.1-00021-QCARMSWP-1 api 6 features
> wowlan,ignore-otp crc32 42e41877
>
> My quoted statement of a possible regression seems to have been my old
> CPU acting up and is ok to remove

Thank you for the update.

-- 
Sergey
