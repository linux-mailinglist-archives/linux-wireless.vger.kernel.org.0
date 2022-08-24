Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EB4F5A02F3
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Aug 2022 22:47:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240532AbiHXUr2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 24 Aug 2022 16:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236263AbiHXUrZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 24 Aug 2022 16:47:25 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12581786C9
        for <linux-wireless@vger.kernel.org>; Wed, 24 Aug 2022 13:47:24 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id v125so20825882oie.0
        for <linux-wireless@vger.kernel.org>; Wed, 24 Aug 2022 13:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=KduZjIEyBxkzWgXFN93eLdrigURNo60WLuJ3gbVZ7XY=;
        b=HzD4lZ/6vc6C1WbqLgNeBjsTawvUPrh+Xj9kvCaukUs4HQ4qPkl3iXv/4oz9z8HwXo
         ECVxp5rH4cZomOeGqhdJQD8ko317eSJ1CyxlRlohPXJiVaA5x1hshUDuqSdO4cmtUGMW
         CNqIz6REQRw99lwDp8gd7kPHARUS2DCtzdD4A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=KduZjIEyBxkzWgXFN93eLdrigURNo60WLuJ3gbVZ7XY=;
        b=eeYCWq6VWeFqoL/89FZ/rhpgC5ny9yCW6xWhniJfNuo0KpXmVgHFpmK5f1fuR/M5Mz
         sAgEKS1XbqinTVS6RlGx+zsLw56TPDmdIfUNXEnVTgcKlQsDE4ywbVGynoEKaZJwB8l8
         v7vPEnlG/zYEDUjTesDboa/Zg3Lhv6jZI9EaaZOytUDb4fVAdimgfdmE53aqKqJHZYA6
         5lI/KnN8Tdf50IWWnlyHyg6yzBz66DT4BPFpWQzbssT6aJvPtXRBttzeQjyW7ehCbp4v
         BtVhWf3BZyefeAIQvqOu/3jcaAzKTb5IXjpKQVdQ8HLtWYhKLmcDFZRSdB9sdMZMV408
         dKqg==
X-Gm-Message-State: ACgBeo22mIhi/KlDmF0TkgJMMWdrvYUxLEJb9YBSw4BpKyUw4ALnXnQ6
        TFBKvVhweWBbemAt3fueEhCucqdg9DVfkQ==
X-Google-Smtp-Source: AA6agR7Tew/jNBWI0QFX23JOaC/YZLqV59+ljHTHIDBrwq6mKSD0Bruh8pq+vtWyefPBk5HgQ/odiw==
X-Received: by 2002:a05:6808:f0d:b0:343:8cf1:770a with SMTP id m13-20020a0568080f0d00b003438cf1770amr4166736oiw.3.1661374043101;
        Wed, 24 Aug 2022 13:47:23 -0700 (PDT)
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com. [209.85.167.172])
        by smtp.gmail.com with ESMTPSA id l14-20020a4ad9ce000000b0044b125e5dabsm3124392oou.35.2022.08.24.13.47.22
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Aug 2022 13:47:22 -0700 (PDT)
Received: by mail-oi1-f172.google.com with SMTP id r10so14976070oie.1
        for <linux-wireless@vger.kernel.org>; Wed, 24 Aug 2022 13:47:22 -0700 (PDT)
X-Received: by 2002:a05:6808:23c4:b0:344:e426:d2a7 with SMTP id
 bq4-20020a05680823c400b00344e426d2a7mr4087711oib.232.1661373740120; Wed, 24
 Aug 2022 13:42:20 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1661252818.git.duoming@zju.edu.cn>
In-Reply-To: <cover.1661252818.git.duoming@zju.edu.cn>
From:   Brian Norris <briannorris@chromium.org>
Date:   Wed, 24 Aug 2022 13:42:09 -0700
X-Gmail-Original-Message-ID: <CA+ASDXNf5JV9mj8mbm1OGZ_zd4d8srFc=E++Amg4MoQjqjS_TA@mail.gmail.com>
Message-ID: <CA+ASDXNf5JV9mj8mbm1OGZ_zd4d8srFc=E++Amg4MoQjqjS_TA@mail.gmail.com>
Subject: Re: [PATCH v8 0/2] Add new APIs of devcoredump and fix bugs
To:     Duoming Zhou <duoming@zju.edu.cn>
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        amit karwar <amitkarwar@gmail.com>,
        Ganapathi Bhat <ganapathi017@gmail.com>,
        Sharvari Harisangam <sharvari.harisangam@nxp.com>,
        Xinming Hu <huxinming820@gmail.com>, kvalo@kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        "<netdev@vger.kernel.org>" <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Aug 23, 2022 at 4:21 AM Duoming Zhou <duoming@zju.edu.cn> wrote:
>
> The first patch adds new APIs to support migration of users
> from old device coredump related APIs.
>
> The second patch fix sleep in atomic context bugs of mwifiex
> caused by dev_coredumpv().
>
> Duoming Zhou (2):
>   devcoredump: add new APIs to support migration of users from old
>     device coredump related APIs
>   mwifiex: fix sleep in atomic context bugs caused by dev_coredumpv

I would have expected a third patch in here, that actually converts
existing users. Then in the following release cycle, clean up any new
users of the old API that pop up in the meantime and drop the old API.

But I'll defer to the people who would actually be merging your code.
Technically it could also work to simply provide the API this cycle,
and convert everyone in the next.

Brian
