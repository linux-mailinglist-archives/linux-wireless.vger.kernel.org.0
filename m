Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81FBB5849CA
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Jul 2022 04:32:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232456AbiG2Ccd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 Jul 2022 22:32:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231966AbiG2Ccc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 Jul 2022 22:32:32 -0400
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 993936A9E4
        for <linux-wireless@vger.kernel.org>; Thu, 28 Jul 2022 19:32:30 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id o4so3280359vsc.12
        for <linux-wireless@vger.kernel.org>; Thu, 28 Jul 2022 19:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:reply-to:mime-version:from
         :to:cc;
        bh=+D1zF2DCKf5WB+zgoPewh33B5r7wz0pan/6d9WW6hok=;
        b=Yc5D9LlEs+Sma+wPy5txRxFFC3l2e8rpqRXSQwqGm3NpcXO9vA/R8xPKxhefELo/a3
         XB9Mchrho8B53ngBnR7NwIOQnEdXJeCqGMTjU82Gfw9lqvpJVvnIZziua4dLeSXS2c9z
         LAnkKUihY4SYoqkspuYVcMuDNy+rWUETHewN8z17cyZ6NRG2mqXzT3Hg9YLgM7JJverI
         i9iBLz6d7lorjbYSP55i0WwQucPAfs7Wqk0NkxkrNTB4Bwdt9glEvjs4NphfNKXXrudP
         nl9Iq6ticauvEtRuRPPHbdPrwC6QullUtJFztu2dLOMWQtccE1uWGxvUUg6WC+TcPiAs
         8IKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:reply-to:mime-version
         :x-gm-message-state:from:to:cc;
        bh=+D1zF2DCKf5WB+zgoPewh33B5r7wz0pan/6d9WW6hok=;
        b=j3WAU8437MI7p72cYpl4rZf++zhJnutWvAJ64pZ4VwUSXGuuBG5Lz6c6czLyTK+d7t
         wi3RqybzU33bbgD48kD6wwk1mPP6XkIHGI2wGTZjLdW76pc76g5brYh/q5xWbobfEbBd
         ytI25ULW5lytqI1Z/8u7DOvZl8DRclUUOiQWtzdnXoorwrFL25FgVj47AkMNq408FBlU
         OOKCbXBVH9356oSy2zzkj8hQFlp0+PlcflDo0R0ob0wilJMKjNbC7Hvsd+8o2g/jlPOE
         M4SJR0JXCPak543ILtN7r+Wcmvd41ctRlFH4AAIrKhWV+D1BzQ6x7eGiuCXGQMQu6s93
         NwnQ==
X-Gm-Message-State: AJIora8P1Ea8UvxMrxgjTh0f0ii/90s3EjdjqKOQKhzCUtEGnRCT7Q0d
        l7uOCaAQeoNI6FaJpHuhZD3//TAYrVPntNpVZSs=
X-Google-Smtp-Source: AGRyM1uH66armppnePmFqsmxLSztiN7jnMUG3NfBryr4xDrVBI05nevovMmaySMUq6Gz0B9alMt4EU8i4uOvy4LJHos=
X-Received: by 2002:a67:f2c8:0:b0:358:3bf8:22aa with SMTP id
 a8-20020a67f2c8000000b003583bf822aamr496016vsn.56.1659061949740; Thu, 28 Jul
 2022 19:32:29 -0700 (PDT)
MIME-Version: 1.0
Reply-To: edmondpamela60@gmail.com
Sender: phillipcannon202@gmail.com
Received: by 2002:a05:6102:3137:0:0:0:0 with HTTP; Thu, 28 Jul 2022 19:32:29
 -0700 (PDT)
From:   Pamela Edmond <edmondpamela60@gmail.com>
Date:   Fri, 29 Jul 2022 02:32:29 +0000
X-Google-Sender-Auth: yYaq3iu1bOgd3R-f7wZxwcDDgOo
Message-ID: <CANLyv5hA0XFFKLNConawZ68+N6u4LdV+wqj1EEj-0guOvbTuhg@mail.gmail.com>
Subject: It concern Ukraine and Russian issue
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Good afternoon!

Recently I have forwarded you a necessary documentation.

Have you already seen it?
