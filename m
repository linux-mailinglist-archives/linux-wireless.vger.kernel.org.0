Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1A1758A1A6
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Aug 2022 22:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234194AbiHDUAW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 4 Aug 2022 16:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230363AbiHDUAT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 4 Aug 2022 16:00:19 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EF9C6566
        for <linux-wireless@vger.kernel.org>; Thu,  4 Aug 2022 13:00:16 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id z2so1031781edc.1
        for <linux-wireless@vger.kernel.org>; Thu, 04 Aug 2022 13:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:reply-to:mime-version:from
         :to:cc;
        bh=+D1zF2DCKf5WB+zgoPewh33B5r7wz0pan/6d9WW6hok=;
        b=Z2x85pMNKGFNJyUFEcfoWWcpJaKd44A2ovR68T88gWRm5BMMpqgh+uBathE8w9hg8u
         /bBzcpsweVK8AoAQ560IJlmptOOuXr0AfIretPO5H0EIkQFUWf2IZB7pICAk/DCR/rKC
         TfYZnAdPO12daMrIOgZ8yB+CrGzvYBuJXHFhsHTS8xkEcVc/eyGQl0ZPkSQFb08MfeC9
         XRGcpvKwWdyEdgyNwCTay6Pku+v8o+zXuNNVe8RVF6rtFMZOXlkU5ub2Hqva3ZAMX21V
         xc+BCWLxDnEnM0XpNsBOfhEOTEVYcoBlLcyJAU2M0IYF14us7pydDQFCqDfVMWiNTLk3
         kTFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:reply-to:mime-version
         :x-gm-message-state:from:to:cc;
        bh=+D1zF2DCKf5WB+zgoPewh33B5r7wz0pan/6d9WW6hok=;
        b=M49gZMuAP77OmchrE7z3OmwTDc1JGsPB5A0j2Xzyxbw7gzSRAo3DTh0YIvyiaBYyRF
         b3//K2clP1fUzh+gD8Uav+7b/QmZlbBc3sZaLUWcAvWByOYWwuzK228/G/vi5ArxwdC4
         LjcXelWLo4fCBAW/OF8RPStd7kaItUEYE7Go8Nd3o9u5MvBObJSsew6Rt2HYK3Gu33Xu
         yRqeYJV4iq0PMrKmB/dpF9kbTxWUmNDS6XItztm8X5dKKMN8B2su9hjsr/6hGW54e+X/
         xa7LPqBMTM2GCqxwZfPWwPnFbq9TyhGgfykORU1WRj1ElTd+Fz7tKi3s0QY7bk8HaJUP
         OkAw==
X-Gm-Message-State: ACgBeo1JRTFwAtwGBnV+DuVt5Q7jRsu7PABVAodEwLmyC5tyBe0OLTaJ
        s+3m8d/MIoFG4+HDm0loXAPIeJS99EKcvg5dGmM=
X-Google-Smtp-Source: AA6agR5BmrT1X1C4UAtheBMgGlZ+uwkY/6UuRxMij+r8fs/ACnRm1O6rW8qyg0x4pg8zUXJEiixafbczSaU6oLW7f0k=
X-Received: by 2002:a05:6402:2070:b0:43d:2ad0:cfec with SMTP id
 bd16-20020a056402207000b0043d2ad0cfecmr3577371edb.300.1659643214966; Thu, 04
 Aug 2022 13:00:14 -0700 (PDT)
MIME-Version: 1.0
Reply-To: mrs.mercykelvin1982@gmail.com
Sender: 553450897dy@gmail.com
Received: by 2002:a17:906:7d18:b0:72f:a2e7:487d with HTTP; Thu, 4 Aug 2022
 13:00:14 -0700 (PDT)
From:   Mercy Kelvin <mrs.mercykelvin1982@gmail.com>
Date:   Thu, 4 Aug 2022 20:00:14 +0000
X-Google-Sender-Auth: yvBoJQtqPqq3SihhyMVVPJky6Ig
Message-ID: <CAMSAxkWuha=XnKbBUGhMQ7HGA10XdSJGOi19r1EBfMTLOdTXjg@mail.gmail.com>
Subject: Se
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Good afternoon!

Recently I have forwarded you a necessary documentation.

Have you already seen it?
