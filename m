Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D54C0763F79
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Jul 2023 21:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbjGZTY5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 26 Jul 2023 15:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjGZTY4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 26 Jul 2023 15:24:56 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2550212D
        for <linux-wireless@vger.kernel.org>; Wed, 26 Jul 2023 12:24:55 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-686efb9ee3cso161951b3a.3
        for <linux-wireless@vger.kernel.org>; Wed, 26 Jul 2023 12:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1690399495; x=1691004295;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GIW24nrwOqSlnAWNBpH/nlZsEj1eHKJjh/nPMks2pRg=;
        b=NBFFDkUR/jJVUjCZDIf3B1ojJs3rzQChwIJdYHrNdruSc6Kfb5mUiyGba4j+f0O9Iy
         +BR0Z2xW7cc3nVESsgoFzwv0JlXas7/qx4FMtc7sCc35x8SbEJ1IXUDbb25YqF7u2iJ8
         uJBi7lOedXpH7RPn1qX9AWdeqZBCAqW5Q5pzI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690399495; x=1691004295;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GIW24nrwOqSlnAWNBpH/nlZsEj1eHKJjh/nPMks2pRg=;
        b=fZiNCSOOzagvY3WV+woQyJ+7jwEOiMPFCIsEJ1Rm15muuzd+IAiUsErhOEdKtke5CD
         XR2qVH128bFMf5fpkooC2lvoF+ouBRyZ1cs6W9RtfVHI4wZaJTC+GtAdY1Nfac5fyXw3
         gbGFCtNgGIaO+w0NJKTibzjhZsPMxKXBYuxtO4ppoeZfTP+sb5KV6/BxychWNp666uhZ
         BvXo0vSP5Gy4j50P23ieqpxn9M8ym8+NqjlF5MZbIrQ1oEREnPA7rOWNA9opoWmz1kLh
         mWx9DQMnYUzcqhWKBYK3dmr33b2ZhE5ikxg2G6TYJ0hc4yYE4PCxfOpoER7me4ErPEaS
         4gbA==
X-Gm-Message-State: ABy/qLbIcxqs7LIeXNW5ypGte3+LpvUS3R3Db4SrYdhtNwtQiBmSWHKa
        BN362VwD/YBGA9BDvcVj2cMLQw==
X-Google-Smtp-Source: APBJJlH2dnXVL4h77pli4cVL+7nCuKYTIgs9Sh+E4vtDZbGXmyQYfXmY4JjNo+1B5NHVpvHCEJ9eYQ==
X-Received: by 2002:a05:6a20:1612:b0:135:4858:683 with SMTP id l18-20020a056a20161200b0013548580683mr3761391pzj.48.1690399495218;
        Wed, 26 Jul 2023 12:24:55 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:cf94:79ce:7d48:984a])
        by smtp.gmail.com with ESMTPSA id k11-20020a637b4b000000b0054fa8539681sm13150387pgn.34.2023.07.26.12.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 12:24:54 -0700 (PDT)
Date:   Wed, 26 Jul 2023 12:24:53 -0700
From:   Brian Norris <briannorris@chromium.org>
To:     Dmitry Antipov <dmantipov@yandex.ru>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        lvc-project@linuxtesting.org
Subject: Re: [PATCH 1/5] wifi: mwifiex: fix memory leak in
 mwifiex_histogram_read()
Message-ID: <ZMFzBStAKemf+dLL@google.com>
References: <20230726072114.51964-1-dmantipov@yandex.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230726072114.51964-1-dmantipov@yandex.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Jul 26, 2023 at 10:20:52AM +0300, Dmitry Antipov wrote:
> Always free the zeroed page on return from 'mwifiex_histogram_read()'.
> 
> Fixes: cbf6e05527a7 ("mwifiex: add rx histogram statistics support")
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> ---
> NOTE: this series supersedes all of the previous mwifiex patches not
> yet accepted into wireless-next tree.

I had comments for patch 2. Patch 1, 3, 4, 5 look good:

Acked-by: Brian Norris <briannorris@chromium.org>
