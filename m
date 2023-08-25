Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECBF4789281
	for <lists+linux-wireless@lfdr.de>; Sat, 26 Aug 2023 01:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbjHYXst (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 25 Aug 2023 19:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbjHYXsm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 25 Aug 2023 19:48:42 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3E8E173F
        for <linux-wireless@vger.kernel.org>; Fri, 25 Aug 2023 16:48:40 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id 5614622812f47-3a85c5854deso1066705b6e.0
        for <linux-wireless@vger.kernel.org>; Fri, 25 Aug 2023 16:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693007320; x=1693612120;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZjHlfs7cpxTPzWjK5kXtnqDevQ39oV0w5MKpPaj0QkI=;
        b=Na5SC9cpTsa14HWvFPR9/Q9PAcgfu6ZW1QOM3uglXRKdUjuVenpbIU7kFGWSm9W88L
         /NFL/7WfrnIwmzRzDqUIhKeAr6A0KVVqakufzEZH/uZqMDjwq1S50hs30kphfakG6Yzq
         Qi/fviP9r8Y3/01aO/aHeB13nVYrQ7P0rD9kg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693007320; x=1693612120;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZjHlfs7cpxTPzWjK5kXtnqDevQ39oV0w5MKpPaj0QkI=;
        b=Xq8vFWdQgwYGlkaL9TZv0wMctfTQWT/Enx4rT/9QSLmglNCGtbkpmXU1g5uevuB5yU
         BuMIHIDif0eLA5Fdjr0dSYNbz6+q9I6JnnFgouSUwdWi/+d/LtV3ZGMuJQjjOL5a5Otn
         rGRJgOigYDWGV5zzJonUg5tJZeGpFVqg1rVTTZCT7kzUZO+X9rdUxj7xaMZx6+c2yBrL
         j6P4+e+b1BYsARAhfAjTyJNMaNlN7gi+uw4lJAdkIY4CtE2LzJdRhmiE9j2w6TQYgZyZ
         GXmBZUwrMAbTE4GI242nyf2FM+JlYHGo9tC4nhWzpxPxcJUv/Fm+QiKg/1gej1ACq6l2
         edHg==
X-Gm-Message-State: AOJu0Yzl74fySM6zNMBcVJevElQrlEuphwfXdvlT48VA5eLI/30p5AE6
        GO4pnuMybZ1yHGngqKdIJq/QoQ==
X-Google-Smtp-Source: AGHT+IFd5elNc43X/gjGHyeQJWxcScE1F4CPtm5NyDyuqxqXGv1YnHIqO72phR4W6TBYSX4zsXoRmA==
X-Received: by 2002:a05:6358:91d:b0:135:99fa:5040 with SMTP id r29-20020a056358091d00b0013599fa5040mr21048708rwi.12.1693007319841;
        Fri, 25 Aug 2023 16:48:39 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:29e0:612d:e5b9:886c])
        by smtp.gmail.com with ESMTPSA id o29-20020a637e5d000000b00565e96d9874sm2238348pgn.89.2023.08.25.16.48.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 16:48:39 -0700 (PDT)
Date:   Fri, 25 Aug 2023 16:48:37 -0700
From:   Brian Norris <briannorris@chromium.org>
To:     Dmitry Antipov <dmantipov@yandex.ru>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org
Subject: Re: [PATCH] wifi: mwifiex: cleanup struct mwifiex_sdio_mpa_rx
Message-ID: <ZOk91ahez659Wu/t@google.com>
References: <20230821115254.167552-1-dmantipov@yandex.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230821115254.167552-1-dmantipov@yandex.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Aug 21, 2023 at 02:52:50PM +0300, Dmitry Antipov wrote:
> Drop filled with NULL pointers but otherwise unused 'skb_arr'
> array of 'struct mwifiex_sdio_mpa_rx', adjust related code.
> 
> Fixes: 960d6d08e395 ("mwifiex: delay skb allocation for RX until cmd53 over")

This is not the appropriate Fixes line. These fields continued to be
used afterward, so it would be actively harmful to tell people (or bots)
to backport this patch that far.

I'm not even going to tell you what the last commit that used it was,
because that would still just be nonsense. It's better to have no Fixes
line than to conjure up a garbage one, especially for something for
trivial.

> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>

The contents look good though:

Acked-by: Brian Norris <briannorris@chromium.org>
