Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CBCC59C5F9
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Aug 2022 20:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237403AbiHVSV6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 22 Aug 2022 14:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237395AbiHVSV4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 22 Aug 2022 14:21:56 -0400
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5993C474F8
        for <linux-wireless@vger.kernel.org>; Mon, 22 Aug 2022 11:21:55 -0700 (PDT)
Received: by mail-oo1-xc31.google.com with SMTP id z23-20020a4ad1b7000000b0044931ffdcafso2073274oor.4
        for <linux-wireless@vger.kernel.org>; Mon, 22 Aug 2022 11:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=KxeXKUeRuVUgo6T1WQOko+Q6K9NOCAx+pcM9TQPoDKY=;
        b=emDZmyCuj4uPG4Bgx/jCNx3nI+rZTnqfKonJwV+kryOTW3PkTafUzA44hv7DwATmP9
         OVVB9s3lcyJLsx9o8Qvumz4rXuUpC/OQn6ReZ2/4zq5vJciV/wtkLZQPyZV4zLwmGPWM
         4KcwuzMZ8QzvcN6krVs1/S0uO/WgHkx0mv2I8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=KxeXKUeRuVUgo6T1WQOko+Q6K9NOCAx+pcM9TQPoDKY=;
        b=JgAbH0xlyb9wiZ6P7cSBm4vLvcHCCs3Q2zaz5KAvhJbivYot0EPdlhhs2FRHrB+Sc4
         gYEqSqN+haBt4iCfdf6tBFPiKrP+kMOqZGge5P4lijQYIOp9XP9mQTy6k0yPmdBLiPxR
         DrVMjsrAPw2VjBChlrTvX0dmilw0ebruMoD/UCTXvLc9XGUVE1GUDwUh/hULBgbUMDdW
         1x5V+BX1dVeqP2mz3Lx6a9PnBbPhFAP8F4iAZc0zlPRJXa0VcL71P2jhas6wo7aySHgm
         0gJxVMBfSIYN1anoz+Rn9snTPP8TU3FIwB64Xt4oMThwM+Q02AwL9rF0zonZ7nELgaKD
         YS+g==
X-Gm-Message-State: ACgBeo0342ZYwnVwRnOeO4/nttSmnKfjB9mQ1ohZvEW0CYHr9BDK+h9u
        hfrHkjX+OoYIaY9cuzLpxivzKvIsigppNg==
X-Google-Smtp-Source: AA6agR7g62Z/N0CVy91jAOTVwThiJZNXKXYj5KdJESXUClQNK/B5o/U4ViAKcxSbDS0p0/rzLInpCw==
X-Received: by 2002:a4a:b688:0:b0:448:69c6:2216 with SMTP id v8-20020a4ab688000000b0044869c62216mr7016597ooo.3.1661192514249;
        Mon, 22 Aug 2022 11:21:54 -0700 (PDT)
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com. [209.85.160.44])
        by smtp.gmail.com with ESMTPSA id x18-20020a05683000d200b00636e9a0cce5sm3041261oto.60.2022.08.22.11.21.51
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Aug 2022 11:21:51 -0700 (PDT)
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-11d2dcc31dbso5755188fac.7
        for <linux-wireless@vger.kernel.org>; Mon, 22 Aug 2022 11:21:51 -0700 (PDT)
X-Received: by 2002:a05:6870:d0d4:b0:10d:4a2:2c0e with SMTP id
 k20-20020a056870d0d400b0010d04a22c0emr13587797oaa.232.1661192510574; Mon, 22
 Aug 2022 11:21:50 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1660739276.git.duoming@zju.edu.cn> <b861ce56ba555109a67f85a146a785a69f0a3c95.1660739276.git.duoming@zju.edu.cn>
 <YvzicURy8t2JdQke@kroah.com> <176e7de7.8a223.182ac1fbc47.Coremail.duoming@zju.edu.cn>
 <Yv5TefZcrUPY1Qjc@kroah.com> <5108e03b.8c156.182b1a2973f.Coremail.duoming@zju.edu.cn>
In-Reply-To: <5108e03b.8c156.182b1a2973f.Coremail.duoming@zju.edu.cn>
From:   Brian Norris <briannorris@chromium.org>
Date:   Mon, 22 Aug 2022 11:21:36 -0700
X-Gmail-Original-Message-ID: <CA+ASDXNN81VczMTUt8=AyeytbMjy2vAGi_aVW_MNha9D99Z5VA@mail.gmail.com>
Message-ID: <CA+ASDXNN81VczMTUt8=AyeytbMjy2vAGi_aVW_MNha9D99Z5VA@mail.gmail.com>
Subject: Re: [PATCH v7 1/2] devcoredump: remove the useless gfp_t parameter in
 dev_coredumpv and dev_coredumpm
To:     Duoming Zhou <duoming@zju.edu.cn>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        amit karwar <amitkarwar@gmail.com>,
        Ganapathi Bhat <ganapathi017@gmail.com>,
        Sharvari Harisangam <sharvari.harisangam@nxp.com>,
        Xinming Hu <huxinming820@gmail.com>, kvalo@kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "<netdev@vger.kernel.org>" <netdev@vger.kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

On Thu, Aug 18, 2022 at 8:47 AM <duoming@zju.edu.cn> wrote:
> On Thu, 18 Aug 2022 16:58:01 +0200 Greg KH wrote:
> > No, that is not necessary.  Do the work now so that there is no flag day
> > and you don't have to worry about new users, it will all "just work".
>
> Do you mean we should replace dev_set_name() in dev_coredumpm() to some other
> functions that could work both in interrupt context and process context?

No.

I believe the suggestion is that rather than change the signature for
dev_coredumpv() (which means everyone has to agree on the new
signature on day 1), you should introduce a new API, like
dev_coredumpv_noatomic() (I'm not good at naming [1]) with the
signature you want, and then migrate users over. Once we have a
release with no users of the old API, we drop it.

There are plenty of examples of the kernel community doing similar
transitions. You can search around for examples, but a quick search of
my own shows something like this:
https://lwn.net/Articles/735887/
(In particular, timer_setup() was introduced, and all setup_timer()
users were migrated to it within a release or two.)

Brian

[1] Seriously, dev_coredumpv_noatomic() is not a name I want to see
last very long. Maybe some other trivial modification? Examples:

dev_core_dumpv()
dev_coredump_v()
device_coredumpv()
...
