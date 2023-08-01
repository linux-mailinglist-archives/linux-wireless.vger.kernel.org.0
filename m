Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD03976BBBE
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Aug 2023 19:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbjHARz2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Aug 2023 13:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231535AbjHARz0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Aug 2023 13:55:26 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B6601BF5
        for <linux-wireless@vger.kernel.org>; Tue,  1 Aug 2023 10:55:25 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-686d8c8fc65so4234032b3a.0
        for <linux-wireless@vger.kernel.org>; Tue, 01 Aug 2023 10:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1690912525; x=1691517325;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7kvJipiJm4drOxOZm699VKRr56S8cOAzV6/ee/B4/5U=;
        b=K3zQ7iOXXRY/O6Je5T8A+386W1kh3c/66Brr8SLz3suokfJIGTiKqrpZ+/u7XrvuSc
         gP/XKxlT1caTxh+sCMljqVy71LYYnldBHXX21UjxC5Wur3vP057R2GcMArnbtf/4u3b9
         UPq5qGOeXD6CAKwGL0Om5Z5JcOPfpH/Xv3zGI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690912525; x=1691517325;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7kvJipiJm4drOxOZm699VKRr56S8cOAzV6/ee/B4/5U=;
        b=Keqo8yapRlWhAImzF/bMc6tONoEruPgQXU5ZPYNUZkfMKkcK79JsjscZhzg8h5JNth
         zLheX79iu+ebFLoMrJEJ3D5d2ku+L6FjK3PHe05ocDN8N3OYNgyMR78hcSe8Gv5OgwCM
         yRDOJMbaVmcre2r3KjsiXPU03ozZxtEQ8Dawz0MqYdMM43s7b1G5FOvihPlW5WceyDKY
         S8LGYpLljtHs7vT5KrAIIf96ZMPEZGQbmh1N+pILtCfLXEFf+sFSFOY0P6B/jsW7G9gC
         SszKhiujZ7OEs6ml6CzT9GUcXpoYj81NS4HWqUv0MgBtCtjm/+1aBNQxuqep/Sh7IJF8
         O7gw==
X-Gm-Message-State: ABy/qLZ6I/p93UH7nOcodkUgFkgEQrUCwcs+igNwEmM+HacGRZh0abgE
        6AOwK17/W7NxHZqhd0CptEsoCg==
X-Google-Smtp-Source: APBJJlH4uUoy4jCeyD2GTf5NS0k1TNV7pqrr7rKzthP9FicYELRbJaEHlAbNmL3ZuH09H65xzZpzQQ==
X-Received: by 2002:a05:6a00:2442:b0:686:ec1d:18e5 with SMTP id d2-20020a056a00244200b00686ec1d18e5mr13503945pfj.28.1690912525050;
        Tue, 01 Aug 2023 10:55:25 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:1c1f:af3f:7a1e:7fc2])
        by smtp.gmail.com with ESMTPSA id m1-20020aa79001000000b00686940bfb77sm9591858pfo.71.2023.08.01.10.55.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 10:55:24 -0700 (PDT)
Date:   Tue, 1 Aug 2023 10:55:22 -0700
From:   Brian Norris <briannorris@chromium.org>
To:     Dmitry Antipov <dmantipov@yandex.ru>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        lvc-project@linuxtesting.org
Subject: Re: [PATCH 2/2] [v2] wifi: mwifiex: cleanup TX error handling
Message-ID: <ZMlHCmjf2ZovExsP@google.com>
References: <ZMFzBStAKemf+dLL@google.com>
 <20230728084407.101930-1-dmantipov@yandex.ru>
 <20230728084407.101930-2-dmantipov@yandex.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230728084407.101930-2-dmantipov@yandex.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Jul 28, 2023 at 11:43:43AM +0300, Dmitry Antipov wrote:
> Since 'mwifiex_process_tx()' is the only place from where both
> 'mwifiex_process_sta_txpd()' and 'mwifiex_process_uap_txpd()'
> are called, these functions may be converted to 'void' after
> moving skb layout check to the caller, which may be simplified
> as well. Also adjust somewhat obfuscating error messages and
> add 'mwifiex_interface_name()' to make them a bit more useful.

Do you actually run this driver on anything, or are you just compile
testing / running static analysis? Because IIUC, all these messages are
perfectly clear when using the mwifiex_dbg() macro, which usually ends
up in dev_info(), and includes things like "mwifiex_pcie",
"mwifiex_sdio", and "mwifiex_usb" already. So the
mwifiex_interface_name() stuff just seems superfluous. I'd suggest
removing that.

At the same time, it seems like you're working hard on trying *not* to
get your stuff merged in a timely manner, as you shift the goalposts
every time you refactor your series. Specifically, you're now violating
basic guidelines like these:

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches#commit_messages

"If you find yourself listing out a number of changes in the commit
message as a bulleted list or similar, consider splitting up the patch
into discrete changes that each do one thing. Similarly, if one of the
additional considerations is refactoring, try to shift that into a
separate patch."

This started out as "avoid BUG_ON()", which is a great goal on its own.
But now you haven't even mentioned that in your laundry list of
refactors. This seems like you have at least two patch candidates here:
refactoring the error handling, and dropping the BUG_ON(). (If the
refactoring becomes extremely trivial, maybe this is OK as 1 patch. But
in its current form, it's not.)

Before you resubmit, please read the patch submission guidelines again.
I'd also suggest sticking this (as multiple patches) at the end of the
series, so the other patches (which have been reviewed/ack'd multiple
times) can land cleanly.

Brian

> Suggested-by: Brian Norris <briannorris@chromium.org>
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> ---
> v2: some redesign in attempt to integrate Brian's feedback
[...]
