Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3813E4DB58C
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Mar 2022 17:02:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357501AbiCPQDS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 16 Mar 2022 12:03:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357443AbiCPQDC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 16 Mar 2022 12:03:02 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04EF63E5F6
        for <linux-wireless@vger.kernel.org>; Wed, 16 Mar 2022 09:01:48 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id s25so3753828lji.5
        for <linux-wireless@vger.kernel.org>; Wed, 16 Mar 2022 09:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sfyn51iMEtZOW1VvGz9/zKro/mJL/U+AGtoyS/q05lk=;
        b=IxJzMGVBQ3dqOjwnT0kNvGBM1q4ToNrQ8MnPmSDiP9yfNiOStXUVcBRVnxaULD6+qQ
         iDehTRiYAMHSCxlwKAHGVWuwY43EtSG7VmF2E+DrfhETaC+kwkg1Zw7nn0Mt77iaYVPS
         eI5jjYFFkS7OLX94NFKpBzVwOSR3Cj742b3BY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sfyn51iMEtZOW1VvGz9/zKro/mJL/U+AGtoyS/q05lk=;
        b=pYzVrsW2GnWaUwnJ/e/XXy7CUM6Pj9OunpfGa6+i9lvIjUxkyrLsh9fFuvibzIj87x
         JoKAyzagIfzTWTIjE7mqmdHZrjFKhCBKpoSuSkc0JIvArm3jM1OdQKh/9zAPG+Wboy+W
         hXUZmMVvAGIdXUyFYX82e/Q5DrmXniaIf1t7BXcjgP89LOywoLjk/0CrQHjFhhTGHk6Z
         oUk3qalrNyIepJvo5IlrKtdCJei3JSyiFWDiGUYYJiv+3Syo7Q2Xg2Acp50tc+ehP2Oi
         Ybv90NgWRxENtMHco5socraneiXML+mbmDjzSA1X9hgf7YFEou7doYHGgb6ddu4mjf/t
         GMmA==
X-Gm-Message-State: AOAM532vRQ2lt3s+VwGAxPfCNT8tzu4oKJ0A8nxjIBQy0ORpMuweDD7I
        Ng65I5iVTi37W07r73ZNtMSmG1dQfErIhwDXngY=
X-Google-Smtp-Source: ABdhPJzmtdtDlnfBhKPr7o/N7HBWZ4YO6sGrMHXuNYWlj7D0LS5k8WyvFKM/E5qbS7OfztgEGhJI0Q==
X-Received: by 2002:a2e:88d6:0:b0:245:f22e:5125 with SMTP id a22-20020a2e88d6000000b00245f22e5125mr152025ljk.529.1647446505991;
        Wed, 16 Mar 2022 09:01:45 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id m5-20020a2eb6c5000000b002480545ebfesm206863ljo.138.2022.03.16.09.01.36
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Mar 2022 09:01:37 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id s29so4457231lfb.13
        for <linux-wireless@vger.kernel.org>; Wed, 16 Mar 2022 09:01:36 -0700 (PDT)
X-Received: by 2002:ac2:4f92:0:b0:448:7eab:c004 with SMTP id
 z18-20020ac24f92000000b004487eabc004mr184326lfs.27.1647446495212; Wed, 16 Mar
 2022 09:01:35 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000009e7a1905b8295829@google.com> <00000000000003887a05da3e872c@google.com>
 <CAHk-=wj4HBk7o8_dbpk=YiTOFxvE9LTiH8Gk=1kgVxOq1jaH7g@mail.gmail.com> <CACT4Y+atgbwmYmiYqhFQT9_oHw5cD5oyp5bNyCJNz34wSaMgmg@mail.gmail.com>
In-Reply-To: <CACT4Y+atgbwmYmiYqhFQT9_oHw5cD5oyp5bNyCJNz34wSaMgmg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 16 Mar 2022 09:01:18 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj270g1sHyvvMz99d5x5A_2BXJExzKGNhF1Ch8Y2Mi0pA@mail.gmail.com>
Message-ID: <CAHk-=wj270g1sHyvvMz99d5x5A_2BXJExzKGNhF1Ch8Y2Mi0pA@mail.gmail.com>
Subject: Re: [syzbot] KASAN: out-of-bounds Read in ath9k_hif_usb_rx_cb (3)
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+3f1ca6a6fec34d601788@syzkaller.appspotmail.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        ath9k-devel@qca.qualcomm.com, chouhan.shreyansh630@gmail.com,
        David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:USB GADGET/PERIPHERAL SUBSYSTEM" 
        <linux-usb@vger.kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Netdev <netdev@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Zekun Shen <bruceshenzk@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Mar 16, 2022 at 12:45 AM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> But the bug looks to be fixed by something anyway. git log on the file
> pretty clearly points to:
>
> #syz fix: ath9k: Fix out-of-bound memcpy in ath9k_hif_usb_rx_stream

Yeah, that commit 6ce708f54cc8 looks a lot more likely to have any
effect on this than my version bump that the syzbot bisection pointed
to.

But kernels containing that commit still have that

  run #0: crashed: KASAN: use-after-free Read in ath9k_hif_usb_rx_cb

so apparently it isn't actually fully fixed. ;(

                 Linus
