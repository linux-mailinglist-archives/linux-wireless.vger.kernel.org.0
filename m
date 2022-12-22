Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9C21653A68
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Dec 2022 02:54:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234779AbiLVByO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Dec 2022 20:54:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234761AbiLVByN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Dec 2022 20:54:13 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B48F22B01
        for <linux-wireless@vger.kernel.org>; Wed, 21 Dec 2022 17:54:10 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id g13so612695lfv.7
        for <linux-wireless@vger.kernel.org>; Wed, 21 Dec 2022 17:54:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j6c6RloR1f1meVJL/BrGR4Y0ez6uzlYlKHhaiRNYhs0=;
        b=JCmDKEfbWzDVEXrR2086ZQWQkcMLCBS+40YlPKWGT7slRxiF/7dl2rbibbZL/RmVze
         lqLiFZ5SDxNMjQIIyeqlSrqJhrgZRnihUCJyS6vthogRaoNhroaLSmpeEjAJedH2va/O
         oLuoSqShtESJYX5aFyLWTDEKJcStfrgnDROW2tuiHogABxBD1DvFEF3ShN32+d4CelzT
         hcKt53Ppv/z9aB9vR8fQvit5h66NC7VHUGaraX7gYFl+I4IV1VaJXfRNfrNrD/SQUgg5
         QINrIyYG6X5jtmyxMILXr5TQAaQ68csgIdcGQIQm/IyK36JAsiMjDBNnaYuKppKv4IO0
         m7YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j6c6RloR1f1meVJL/BrGR4Y0ez6uzlYlKHhaiRNYhs0=;
        b=WodfiM3sQGTjEvBzTIGQDpDFhHplkwfqjAgH4yqmNoKnziFvZAgB56B8piwgeVrMgI
         Pbc1iQ/IzgTOoS3JmW5IyCz37am92UOZsMGFSJ+z3sG/NVGBkP6dCbvKPYDd3Nv2OeWi
         WKcnZFlRIZn31uY6lHcpcM4jMYFSLSFCNKE9/9u4ATlnEG2hc7y4Muwk0PlRiOmy1v1h
         6Mkb8+hmlOB3H0SRDac/Oe2JVFLoHjKKa5aoW+ZRApipg6+jDpEI4zmD2YbW/pQjr7zO
         ySG+1z9lST9pL66psCrCdwDBSjnb1Al5eoCAbmzJE0huT7KWml9tplsM4Bobeu5eYGyO
         3H+g==
X-Gm-Message-State: AFqh2kpxU+nCOESvIjXrLk053goXmy9ivUd/Q5JC/t1LGzhhZaYY5umY
        /xgsr2/L2uoyrbC/h+iDz3auT2h4lipA7LuNH+Y=
X-Google-Smtp-Source: AMrXdXtJ8Ycat60aD/4+InyM4Sa1Xv5r8Jvxgx4e1qUvhG1U0NVXIGOVmsOYkAiQwp2zRzrryDcjBZ/RVsEnmbcS3+Q=
X-Received: by 2002:a05:6512:78e:b0:4b6:ee97:36c0 with SMTP id
 x14-20020a056512078e00b004b6ee9736c0mr209327lfr.512.1671674048228; Wed, 21
 Dec 2022 17:54:08 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6500:ca0:b0:171:402:ac0e with HTTP; Wed, 21 Dec 2022
 17:54:07 -0800 (PST)
Reply-To: mmrstephen16@gmail.com
From:   "Mr. Stephen Melvin" <mr.bruceross22@gmail.com>
Date:   Wed, 21 Dec 2022 17:54:07 -0800
Message-ID: <CAKeG-03TaicxEf2Rc6r=NAtaFKmavpJObmnEOEq8CQJNxG_3jQ@mail.gmail.com>
Subject: Reply and let me know if you received this email?!
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,PLING_QUERY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello Dear, How are you today and your family? Want to believe you are
all doing great.

Please reply to me as fast as possible. I have important information for you.

Kind Regards,
Mr. Stephen Melvin.
