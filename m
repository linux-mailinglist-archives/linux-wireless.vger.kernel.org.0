Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC034C33F3
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Feb 2022 18:45:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232287AbiBXRp5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 24 Feb 2022 12:45:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbiBXRpz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 24 Feb 2022 12:45:55 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24080279469
        for <linux-wireless@vger.kernel.org>; Thu, 24 Feb 2022 09:45:25 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id u11so3990335lju.4
        for <linux-wireless@vger.kernel.org>; Thu, 24 Feb 2022 09:45:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pOBmVUTfu7dJw7T0At09LeWpqEdb7Gx94oz8UfcdCXs=;
        b=AILmembZ985YYL0f4wZ5s11RyKgR5u6qiQrV7RZNkT9G5n/SUdL4Vhrq9B5bX8IAIQ
         Y6nGnLQuOzkqFVDrilbDkVYSx1GL7mMY7i0oqQFQ167eDMte/SkF8KYTQPuW8ZBUYD0I
         S+wsm+vFqKevBhVyTZaq6iuYgrlCFfQmfxWN4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pOBmVUTfu7dJw7T0At09LeWpqEdb7Gx94oz8UfcdCXs=;
        b=SYambQJ+XiYk1DujfzdZlrADTNhDKD/M8LPPpKmM0ZtBDXqQ6cjOGiGrvyQ7Pwp07K
         Om/+g6/QR0WiX10SoKnqoV0RUcpdkqP/3HSE5UnsynQAPOhFtp6JwTFdK4Sqx9i/yw1L
         zNaLxbRxwhspd3WfXqeOBFNGimENghoxfegEb7OPbxv8x1dXPilcMXP9w8V/IM/ab0IJ
         MDQ4iD2q1qgo89jgvTsdxIvILHwPTrSAN2QV54KhBRibY5guWDFlYcBjrTRWxKwLMS8k
         L/fuJ/SApqaKZ8vkjQoXjzMHWlYaO0HV0KfcvaT7ytyILGXYh0lwYzb67usxlH8LSK2o
         /dIw==
X-Gm-Message-State: AOAM531HMBlQqHpf7W26putt8Le50XsW26z8c6ElmstAwVPJWko2NrQg
        c25p3R27gMyA5pKzsGE30PXriDiEtiakOJK2AFI=
X-Google-Smtp-Source: ABdhPJyWVVep6vQKxRqIiWSU7KALjH2nhXdAK+4LtpjMAk2yeXrNDyEpLeGEgTWggxI/vUNsZh78hw==
X-Received: by 2002:a2e:9c82:0:b0:23a:eea8:cd0f with SMTP id x2-20020a2e9c82000000b0023aeea8cd0fmr2773149lji.218.1645724722809;
        Thu, 24 Feb 2022 09:45:22 -0800 (PST)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id k5-20020a2e6f05000000b00245de81bb0esm28987ljc.13.2022.02.24.09.45.22
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Feb 2022 09:45:22 -0800 (PST)
Received: by mail-lj1-f169.google.com with SMTP id o6so3992204ljp.3
        for <linux-wireless@vger.kernel.org>; Thu, 24 Feb 2022 09:45:22 -0800 (PST)
X-Received: by 2002:a2e:80c6:0:b0:246:3334:9778 with SMTP id
 r6-20020a2e80c6000000b0024633349778mr2640059ljg.443.1645724721879; Thu, 24
 Feb 2022 09:45:21 -0800 (PST)
MIME-Version: 1.0
References: <20220221122638.7971-1-franciman12@gmail.com> <e32de43c-e00a-5766-e988-fe192d36d719@quicinc.com>
 <CAH4F6utmtAM3CzX2_Fbn94Sb-X8m0patPh8yWwbuBB0t1VYH=g@mail.gmail.com>
 <87o82wvhtk.fsf@kernel.org> <20220224075346.GL3943@kadam> <87fso8vb3w.fsf_-_@kernel.org>
In-Reply-To: <87fso8vb3w.fsf_-_@kernel.org>
From:   Linus Torvalds <torvalds@linuxfoundation.org>
Date:   Thu, 24 Feb 2022 09:45:05 -0800
X-Gmail-Original-Message-ID: <CAHk-=whFKYMrF6euVvziW+drw7-yi1pYdf=uccnzJ8k09DoTXA@mail.gmail.com>
Message-ID: <CAHk-=whFKYMrF6euVvziW+drw7-yi1pYdf=uccnzJ8k09DoTXA@mail.gmail.com>
Subject: Re: Use of void pointer arithmetic?
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Francesco Magliocca <franciman12@gmail.com>,
        Jeff Johnson <quic_jjohnson@quicinc.com>,
        ath10k@lists.infradead.org, rmanohar@qti.qualcomm.com,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Feb 24, 2022 at 1:59 AM Kalle Valo <kvalo@kernel.org> wrote:
>
> > What does -Wpointer-arith buy us?
>
> A good question. I have always just thought we should avoid void pointer
> arithmetic due to the C standard, but now that you mention it void
> pointers can indeed simplify the code. So I'm not so sure anymore.
>
> Any opinions? Is there a kernel wide recommendation for this?

We consciously use arithmetic on 'void *' in some places, although
it's not exactly _hugely_ common.

It's much more common to turn a pointer into an 'unsigned long' and
then doing basic operations on that.

The advantage of 'void *' is that it does avoid the need to cast the
pointer back.

But at the same time it will never replace the 'cast to an actual
integer type', because the 'void *' arithmetic only does simple
addition and subtraction, and many pointer operations need more (ie
alignment needs to do the bitops).

So I think it's mostly a personal preference. I *do* think that doing
arithmetic on 'void *' is generally superior to doing it the
old-fashioned C way on 'char *' - unless, of course, 'char *' is
simply the native type in question.

So if 'char *' casts (and casting back) is the alternative, then by
all means use 'void *' as a kind of generic and type-independent "byte
pointer". That is how it is meant to be used in the gcc extension.

And no, nobody should ever use -Wpointer-arith on the kernel in
general. Our use of it is not _hugely_ common, but it's does exist,
and it's not really frowned upon.

                    Linus
