Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E62CD5ECBBD
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Sep 2022 19:55:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233421AbiI0RzS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 27 Sep 2022 13:55:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233205AbiI0RzF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 27 Sep 2022 13:55:05 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 710E7B7E8
        for <linux-wireless@vger.kernel.org>; Tue, 27 Sep 2022 10:55:02 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-3529c491327so12505557b3.13
        for <linux-wireless@vger.kernel.org>; Tue, 27 Sep 2022 10:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=tWpS4cEqVjCvAbrEpDrZ5jq3lmCtX8OGRlYF/P9XNV8=;
        b=aI81aKFW+4dgqcToZisPeA4jtrgtLI5hDy+Cm0Mwnw3Ejr8SR4V2xB/zjlqPLSLI2Q
         czwtAffY37UauybiIJFHhsz/Toihy02bT6l/NDNpcOrPHizj7QfEjRvtYM5GIhXfuqX7
         GCOZ+7yIYsMcp4/5JBvMq3XLkL6ChR0Q/HorJVS6N5ATSLg3tdHQyLFx0mEa7QvC5VoQ
         mQqawFfbMWUfJhyCjDqvj3AfkYWn72DQdJIGk0Pq3N8z5bGS3XbAEPubNAt4VLiwWiFC
         Fa4ckKxIoZLKNol9BC9Lo4/0gIu93WgzTQio99Bb6BY8IDW2G97+eEkk/w8o97vUwz1C
         gQbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=tWpS4cEqVjCvAbrEpDrZ5jq3lmCtX8OGRlYF/P9XNV8=;
        b=FMGkck3UnN6UTI+wsEBX9AJZUBoagpJ1TwABckxA+IIZ+dfZK3ooh4pBdjBOhBcyun
         KSfENg0LIN/m+cWyBPcrqMHakpxTH2b/aIHrfEfw7iuDuPaBR04id+8PrdeiRcWqqp94
         I9HMyAooTo6H72j3thQHFtd/PlMu2S8c45zxPC+QHr6D0aWG7KNHURMtivmFzybs837w
         qpH7x1bl61PGkda418e5oU11vi8X9zbOmwIsZ2mj87dJusa8llSKMds2oZIeqd+XbKVQ
         W2P+9aWFuKXEf3DnRNji096l4o2VvQEWKcOqzc8jP5Dt/vP2xnuTSf0mzXzfs7RrRtK0
         OItQ==
X-Gm-Message-State: ACrzQf2za8wudEepzYmDODTFhhcOupEz/091gWm+YYtV4/ME8xmKAPS+
        /Kqy9SWHN2cLPXK6Q0Del0gngpELw42h9oS4/TES9g==
X-Google-Smtp-Source: AMsMyM52wMIxhgYM5ELWXtaWymd9neNz5hZdppDIvfylJWmhZCtnT2YZ8QouamPa8ksX5z3a0GGPERJkDnkuiW0UTkU=
X-Received: by 2002:a81:98d:0:b0:352:b79c:4cc6 with SMTP id
 135-20020a81098d000000b00352b79c4cc6mr1557441ywj.467.1664301301055; Tue, 27
 Sep 2022 10:55:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220927132753.750069-1-kuba@kernel.org>
In-Reply-To: <20220927132753.750069-1-kuba@kernel.org>
From:   Eric Dumazet <edumazet@google.com>
Date:   Tue, 27 Sep 2022 10:54:49 -0700
Message-ID: <CANn89iL4m=aMjZ1XWFNWDyyyDBF1uhNocN0OFqhm2VMm_JQOog@mail.gmail.com>
Subject: Re: [PATCH net-next] net: drop the weight argument from netif_napi_add
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     David Miller <davem@davemloft.net>,
        netdev <netdev@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        kvalo@kernel.org, Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-can@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Sep 27, 2022 at 6:28 AM Jakub Kicinski <kuba@kernel.org> wrote:
>
> We tell driver developers to always pass NAPI_POLL_WEIGHT
> as the weight to netif_napi_add(). This may be confusing
> to newcomers, drop the weight argument, those who really
> need to tweak the weight can use netif_napi_add_weight().
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Sure, but this kind of patch makes backports harder.
Not sure how confused are newcomers about this NAPI_POLL_WEIGHT....
