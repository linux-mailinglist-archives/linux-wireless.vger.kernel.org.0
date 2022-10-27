Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E2DB610277
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Oct 2022 22:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236800AbiJ0UPp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Oct 2022 16:15:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236076AbiJ0UPm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Oct 2022 16:15:42 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AF4552816
        for <linux-wireless@vger.kernel.org>; Thu, 27 Oct 2022 13:15:41 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id i10so1817210qkl.12
        for <linux-wireless@vger.kernel.org>; Thu, 27 Oct 2022 13:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PkxtUHaGFDycP6D2luIHLSXJkXOzlvpiMUNbGq0VIDw=;
        b=AiYRsbNPUrZt3HPq+xtJfDrvafoV3sgbBvDsYvDt8alNybjtz3OkR1xymRkE3QILqj
         mmJ4n9e+K/PVts3cQ2eJ5htk2mJ+mPxzhWMdsaeW6GINZP2CIccvVT49FekPjg7PRFXI
         92WGHwoPAVqBkaMzcdjnmCw5MEE1uFvTm34eA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PkxtUHaGFDycP6D2luIHLSXJkXOzlvpiMUNbGq0VIDw=;
        b=Zjcq09XkWW2BXlau+YSbXAq/wPiryz3wDBc7pHCaEO16/rgS2ceJz6dioWoIwR6l+h
         sEHvxkEvPI+8WgSoH+4RkSz5J4p2YcMCe7/c/lcA0tP7Bvar9wsoonnCFCm0L7c219PJ
         mTUbJjYqQZ82n7TiaDMdd+d5S0jm3LXIj6eCYcmu0Cy4YfXtLQp6TdDh2Ay/gw1mAAa7
         +2PB+OgvgvUyGePRLwJGRoshHQBSVfYguD++l/a5ODF6mOLjcTzf3TnQtl0RhWEsF6uM
         EV4xh2Y0blq+4p23aGGjpVodp62aoCwwVes5RQvzzcWcmXx4OAM03PPSP0BSqpZLJrmL
         YTAQ==
X-Gm-Message-State: ACrzQf34I5pYXUaP0vgMxlbIctZgHoc+RqPAlde0SeMBu3gkS7r8r4et
        u3aErCg/9TfC1Ty54mqhByZiwiwZrHFgJQ==
X-Google-Smtp-Source: AMsMyM4mBzZX6/9G+sJyvpYigTKsUUS+dJcWwgOeQTVhFz/8vQpCau8mD24J1Vq76+XrJJEpJJyqTQ==
X-Received: by 2002:a05:620a:8014:b0:6ee:b0ed:face with SMTP id ee20-20020a05620a801400b006eeb0edfacemr35620075qkb.374.1666901740663;
        Thu, 27 Oct 2022 13:15:40 -0700 (PDT)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com. [209.85.128.182])
        by smtp.gmail.com with ESMTPSA id w7-20020ac84d07000000b0039d02911555sm1348548qtv.78.2022.10.27.13.15.40
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Oct 2022 13:15:40 -0700 (PDT)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-3691e040abaso27588307b3.9
        for <linux-wireless@vger.kernel.org>; Thu, 27 Oct 2022 13:15:40 -0700 (PDT)
X-Received: by 2002:a81:d34c:0:b0:349:1e37:ce4e with SMTP id
 d12-20020a81d34c000000b003491e37ce4emr46057341ywl.112.1666901739776; Thu, 27
 Oct 2022 13:15:39 -0700 (PDT)
MIME-Version: 1.0
References: <20221027150525.753064657@goodmis.org> <20221027150928.780676863@goodmis.org>
 <20221027155513.60b211e2@gandalf.local.home>
In-Reply-To: <20221027155513.60b211e2@gandalf.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 27 Oct 2022 13:15:23 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjAjW2P5To82+CAM0Rx8RexQBHPTVZBWBPHyEPGm37oFA@mail.gmail.com>
Message-ID: <CAHk-=wjAjW2P5To82+CAM0Rx8RexQBHPTVZBWBPHyEPGm37oFA@mail.gmail.com>
Subject: Re: [RFC][PATCH v2 19/31] timers: net: Use del_timer_shutdown()
 before freeing timer
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Mirko Lindner <mlindner@marvell.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Kuniyuki Iwashima <kuniyu@amazon.com>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Menglong Dong <imagedong@tencent.com>,
        linux-usb@vger.kernel.org, linux-wireless@vger.kernel.org,
        bridge@lists.linux-foundation.org, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, lvs-devel@vger.kernel.org,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        tipc-discussion@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Oct 27, 2022 at 12:55 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> I think we need to update this code to squeeze in a del_timer_shutdown() to
> make sure that the timers are never restarted.

So the reason the networking code does this is that it can't just do
the old 'sync()' thing, the timers are deleted in contexts where that
isn't valid.

Which is also afaik why the networking code does that whole "timer
implies a refcount to the socket" and then does the

    if (del_timer(timer))
           sock_put()

thing (ie if the del_timer failed - possibly because it was already
running - you leave the refcount alone).

So the networking code cannot do the del_timer_shutdown() for the same
reason it cannot do the del_timer_sync(): it can't afford to wait for
the timer to stop running.

I suspect it needs something like a new "del_timer_shutdown_async()"
that isn't synchronous, but does that

 - acts as del_timer in that it doesn't wait, and returns a success if
it could just remove the pending case

 - does that "mark timer for shutdown" in that success case

or something similar.

But the networking people will know better.

               Linus
