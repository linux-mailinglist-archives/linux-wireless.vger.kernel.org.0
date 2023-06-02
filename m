Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15B5A71F7E2
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Jun 2023 03:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232216AbjFBBaO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 1 Jun 2023 21:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjFBBaM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 1 Jun 2023 21:30:12 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53BE2F2
        for <linux-wireless@vger.kernel.org>; Thu,  1 Jun 2023 18:30:11 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id 5614622812f47-39a53c7648fso1303416b6e.1
        for <linux-wireless@vger.kernel.org>; Thu, 01 Jun 2023 18:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685669410; x=1688261410;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dfrZcR6ufPlNrdXjkyEsK36vOdaNNKyFQD2SNU85+MA=;
        b=XrliOKn3FibB2MnPxXr7c2FN75Tv+e930jvKQe+AXBUJEx1D2iRnrH/KZkO4BoHVWD
         rujVvlEq6KDlXWmJBBRvxs/xyiLQ1MwFSC2ZtxOz/ckH9VmEbDwgeKyCjILaZ8oJtQrP
         wsb+3wCJugcKe1RRDnzGBruJBf/y5gedS554XsT1iNfCSPJUKn9xuquaDqmNF/R6EKeh
         yMyba1lk3ZA67fG4P1AkKAoRSMA9uZO07IHI8Api9KsY2+ejdN0I9tWMupYkahsu6ppj
         BI4ry8sgLxrlpKIHGNJUn2P11YQCTPv+mLsAziVwl6Qn1CY7vRj2XBkZrT2MUn7tFLE6
         4p2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685669410; x=1688261410;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dfrZcR6ufPlNrdXjkyEsK36vOdaNNKyFQD2SNU85+MA=;
        b=YdKEnTifZ2haVY4B2+rnZU3lYW4mHeFsNl8VfUKkAerRRClM99XT37lSJ+/G/GTI0g
         VEkL9OhDGuuxveFi+LrmdnaXO+n2CYX322s6GFSDAWbYVFILtoQje3lipCk8SaniUC4x
         s3URTUFFkr7cWKK+zCNXtakj3X/U8IMpGQ2Fqhz+HWRwfuGYpxhCaRaaxRsZlh9yyJ69
         gC6Gjvcu4gL+t7JpHFg2GdBR31B5M+F8tJWMrjCdreGqZP6jca/G6ZV3dMLETDVtoYjH
         fOHDLb52LYu5tacYw+TLQ1hYuJijMlBIk+pWEEg6joU6KJmAlVfRfy5OfhnMZNkzYuem
         hVzg==
X-Gm-Message-State: AC+VfDybCVK8t9I9L2UblDGmEBZA1r1VDWR3M+TfcaTeZpvHxwcWFL2n
        U7MphNFOjzre/3voEo4hAm9HqIQ1faHj/UFSRapX8kToDlwCnA==
X-Google-Smtp-Source: ACHHUZ7BHXeAEUzhwHUObR36C8V2Ybr0DRixEeLcDCHpSAIaQ31msH9GPJw8O2ocOau+DmcB5fxWSvLkIVXKUjnlVFU=
X-Received: by 2002:aca:f0b:0:b0:398:57ac:23fe with SMTP id
 11-20020aca0f0b000000b0039857ac23femr926613oip.10.1685669410205; Thu, 01 Jun
 2023 18:30:10 -0700 (PDT)
MIME-Version: 1.0
From:   Utkarsh Verma <utkarsh.naveen@gmail.com>
Date:   Fri, 2 Jun 2023 06:59:59 +0530
Message-ID: <CALKa4bRo2DxK56pxDhqMJtr8C08OVsJ7KpVFyaELnttZaxgguQ@mail.gmail.com>
Subject: RTL8822BE not working after suspend
To:     linux-wireless@vger.kernel.org
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

Hi everyone,

This is my first bug report on the mailing list, so please let me know
if I mess anything up.

I have an ASUS TUF FX505DT which has the RTL8822BE WiFi card. It works
fine normally without any issues. However, once I suspend my
laptop(closing the lid) for a considerable amount of time (> ~30
mins), the WiFi card doesn't work after resume and I have to reboot
every time.

This bug really undermines the portability aspect of the laptop as I
can't simply close the lid and continue my work later. The WiFi simply
dies every time I suspend, and I have to reboot.

It would be really helpful if I could get this to work in the meantime
as well with a workaround as I will be on the move soon.

Lastly, thank you for all the work put into the drivers. They work
mostly fine without any issues. This suspend issue is the only thing I
can see, and I would be glad to help to get it fixed.

My machine details:
OS: Arch Linux w/Linux 6.1.31-1-lts
Card: Realtek 8822BE WiFi
Laptop: ASUS TUF FX505DT

Please let me know if you need further information.

Regards,
Utkarsh Verma
