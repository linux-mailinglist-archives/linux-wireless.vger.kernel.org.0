Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CDA6531916
	for <lists+linux-wireless@lfdr.de>; Mon, 23 May 2022 22:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231699AbiEWTn0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 May 2022 15:43:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234729AbiEWTnA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 May 2022 15:43:00 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B672B220
        for <linux-wireless@vger.kernel.org>; Mon, 23 May 2022 12:42:59 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id v66so19051709oib.3
        for <linux-wireless@vger.kernel.org>; Mon, 23 May 2022 12:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Vr6T/UqgVGLQWoul1vnNoytTWzJsPkn14WICohkLY7I=;
        b=Fs0S3Msok1ksTRe7NGFi2Ry+axura59LsvHOsYFwgudYlyVCr2tTvaiG818YWZuDf0
         IZZwL+wqiL6MtCfFD0gPzV0afDz9zib5f4lVh48rMdFUVgj+K3yQKYmuvHWZ98c1Knvk
         jDLi+BFuargstaoHS5pNBPjYIKTiAaoOaD3CI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vr6T/UqgVGLQWoul1vnNoytTWzJsPkn14WICohkLY7I=;
        b=kP/bZFeVYzk/qzwLNQsSfWnH5KiBZQODp1cVsiOUlCelp0MjouTCpWExgvSGfGPEkU
         MdfW26/st9MOOdD5pRsf+EP0q61tB9nb6XRmiTG2y8bPCfZdMjdyJ6wgubFVZ+5xFDJc
         v/Z4CEpz1AG9ywBPd9YWQcwrfzLs096DQRbe/dohWuoqmAjMjN0NCtd3+CZWQGAy+taR
         4FFb/YHipuqyk/nGQK8GuP/JdUFu8Fq31dGszmSX5n5M0NfaOt2qNlYljmZbqmaY6Rp2
         MD0tsVTbiiOPc8SHFoBBv+iwNR9tJFP7/2XVcHbRLttZIG+36tGup7cEcRdUZnrxXYh8
         62/A==
X-Gm-Message-State: AOAM532LAOiUv9ZX+NP9Q0kujJCpn4NnSiRM9BRbzYSjgVOGxfLiYvs6
        JYdP635UEFeTtf1w1lKTj+y1mHp9aHD51g==
X-Google-Smtp-Source: ABdhPJwGSqRBAIbno4I0dMKI9nBEDRgJCn5QnU59Cag9Q6H2VfrePMR/d9hjGRGxZ3R3taS5vLDk7w==
X-Received: by 2002:a05:6808:238f:b0:326:d4e1:a4b6 with SMTP id bp15-20020a056808238f00b00326d4e1a4b6mr355086oib.241.1653334978720;
        Mon, 23 May 2022 12:42:58 -0700 (PDT)
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com. [209.85.167.181])
        by smtp.gmail.com with ESMTPSA id g18-20020a056870c15200b000f17905320esm4364143oad.13.2022.05.23.12.42.55
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 May 2022 12:42:56 -0700 (PDT)
Received: by mail-oi1-f181.google.com with SMTP id y66so12993195oia.1
        for <linux-wireless@vger.kernel.org>; Mon, 23 May 2022 12:42:55 -0700 (PDT)
X-Received: by 2002:a05:6808:140c:b0:326:cd8f:eb71 with SMTP id
 w12-20020a056808140c00b00326cd8feb71mr341566oiv.257.1653334975556; Mon, 23
 May 2022 12:42:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220523052810.24767-1-duoming@zju.edu.cn> <87o7zoxrdf.fsf@email.froward.int.ebiederm.org>
 <6a270950.2c659.180f1a46e8c.Coremail.duoming@zju.edu.cn>
In-Reply-To: <6a270950.2c659.180f1a46e8c.Coremail.duoming@zju.edu.cn>
From:   Brian Norris <briannorris@chromium.org>
Date:   Mon, 23 May 2022 12:42:44 -0700
X-Gmail-Original-Message-ID: <CA+ASDXNBeN6k6y+eY06FkheNTNWN02P2uT9bB09KtBok0LVFfQ@mail.gmail.com>
Message-ID: <CA+ASDXNBeN6k6y+eY06FkheNTNWN02P2uT9bB09KtBok0LVFfQ@mail.gmail.com>
Subject: Re: [PATCH v3] mwifiex: fix sleep in atomic context bugs caused by dev_coredumpv
To:     Duoming Zhou <duoming@zju.edu.cn>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        amit karwar <amitkarwar@gmail.com>,
        Ganapathi Bhat <ganapathi017@gmail.com>,
        Sharvari Harisangam <sharvari.harisangam@nxp.com>,
        Xinming Hu <huxinming820@gmail.com>, kvalo@kernel.org,
        "David S. Miller" <davem@davemloft.net>, edumazet@google.com,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "<netdev@vger.kernel.org>" <netdev@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

(I think people generally agreed on this approach, but please submit a
new series, with separate patches)

On Mon, May 23, 2022 at 12:27 PM <duoming@zju.edu.cn> wrote:
> What's more, I move the operations that may sleep into a work item and use
> schedule_work() to call a kernel thread to do the operations that may sleep.

You end up with a timer that just exists to kick a work item. Eric
suggested you just use a delayed_work, and then you don't need both a
timer and a work struct.

Brian
