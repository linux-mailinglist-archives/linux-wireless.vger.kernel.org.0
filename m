Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E2B34D6C69
	for <lists+linux-wireless@lfdr.de>; Sat, 12 Mar 2022 05:04:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbiCLEFK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 11 Mar 2022 23:05:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiCLEFI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 11 Mar 2022 23:05:08 -0500
X-Greylist: delayed 52328 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 11 Mar 2022 20:04:01 PST
Received: from out162-62-57-87.mail.qq.com (out162-62-57-87.mail.qq.com [162.62.57.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7400EF2133
        for <linux-wireless@vger.kernel.org>; Fri, 11 Mar 2022 20:04:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1647057835;
        bh=5Gh8uHr65PqLYoBFksWJLnND9wqXJVTURpKW+sw7jk8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=NLIKPHJsHeaXA7JkbWwKsgfdcukKA1okEAB0Vjv5RDfoZpVzwOTv7DxFlVcfLB9wX
         XAS09Li5ky3P3eRA71DKwF27PxkBidn89UZi3/lMMDcXGyonsaABC6iBVIRArlhJet
         nNLD9VDxIscun0jkvgr9FtTa8tD8pv+Fbd3TEs/g=
Received: from localhost.localdomain ([111.193.130.237])
        by newxmesmtplogicsvrszb7.qq.com (NewEsmtp) with SMTP
        id A433E09; Sat, 12 Mar 2022 12:02:36 +0800
X-QQ-mid: xmsmtpt1647057756t3jodr1rz
Message-ID: <tencent_3C231C222B316D3C32A7C311303ADFDF1308@qq.com>
X-QQ-XMAILINFO: OdIVOfqOaVcrCuHh5E9XNi2iHgLfhkYjvo8gfoINkWboqHxHq/eEqyVil8lwhe
         PHJwsWytYjCa4tK7XAKb9SFm5k5eyBoiXV21vZKKAx60Z3TaXcO2iNScmP1/v7UQv2h9Q80aLmu2
         F8hMi0DbyzxowlXFJZOAHWYkXMPIs9GhPKdeFHGBfFWmfENKprvLSLIJDqoIYShsXhUD3bt7vEQ/
         16R1+R/CdLjLiuAEHRnbswfD+gVxDOWUZJhjGUH4uxdOeqP4yrqasEGCLE+REF4SfpYvjDUI8h5S
         7rXZYqOBANO17nK2OPT20bilCLuftNazLxZLc0oejkmunAV2luX1aHj/a3LpUPSie9b2NQ9m1VQF
         FjpmdZ8PyhsI83cXNHp5F/T100/5ZxPay9XMF2WLRD9s3U6CaiHJy1HqVpOYSI8KKaQJO6nE2rAz
         9r1S9GQ8EUWc/Xzv94k7wtUlk0lpYbDiASgtdwqFwDosX5bVImtYCsvmPd6/FRVZ1LFJFX10T27E
         WBaOSDzoG76bF9+PI1T2Bxfu54ioLNsY1/BXFt0baRFLXtmiGUavMBUeBjgdJ7mCKE9C+6CrG+b5
         I0PLtXia1CFs6/KcNTBYQpvT6qLkKxY/vGMZmY8MGxWtkatM6g0SqSbPETOU3Lj1XzB2Atpz4goK
         pmTz6T3Hkp/QnuNTi8ZBYysR4fiAkoab7emreBXGdTvsRKO2Kl2yC/eiayRlqURHwK0cvjHqkK8s
         vnkPN1FqkOT5FOvtWtOvSCYazmNBkzcnaTUsbV9uNyLFeXNtiRWpGOoOM6zuubBCs9GVXwR2qClp
         l2H7FcuWChKaBFh5agrh67jrMy5OEEadgiuVqo1hdsYAxQ+L75y/5BHv+aXFzB2g6EqmLOa4wzdQ
         vjZHtsAo7ZvMrXMkxrM5nUp5b0JPHtDg==
From:   Weiguo Li <liwg06@foxmail.com>
To:     johannes@sipsolutions.net, imitsyanko@quantenna.com
Cc:     kvalo@codeaurora.org, geomatsi@gmail.com,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH] qtnfmac: fix null check
Date:   Sat, 12 Mar 2022 12:02:36 +0800
X-OQ-MSGID: <20220312040236.268951-1-liwg06@foxmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <23914231f7ec66a5552ff6cb3fb6ec91a7c6cc61.camel@sipsolutions.net>
References: <23914231f7ec66a5552ff6cb3fb6ec91a7c6cc61.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 11 Mar 2022 19:04:10 +0100, Johannes Berg wrote:
> On Fri, 2022-03-11 at 21:30 +0800, Weiguo Li wrote:
> > We did a null check after "mac_info->if_comb = kcalloc(...)", but we checked
> > "mac->macinfo.if_comb" instead of "mac_info->if_comb".
> 
> Yeah well:
> 
> mac_info = &mac->macinfo;
> 
> johannes

Ha, I didn't notice this... So it's not a problem.

Thanks johannes!

-weiguo
