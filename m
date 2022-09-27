Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B97425EB798
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Sep 2022 04:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbiI0C1l (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 26 Sep 2022 22:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbiI0C1j (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 26 Sep 2022 22:27:39 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 752ACA831F
        for <linux-wireless@vger.kernel.org>; Mon, 26 Sep 2022 19:27:36 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id a5-20020a17090aa50500b002008eeb040eso262899pjq.1
        for <linux-wireless@vger.kernel.org>; Mon, 26 Sep 2022 19:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=yh4k/+se1wnprbaFwf3y9UrMWyP2Ly9Nz5pe8mFcVUc=;
        b=e6eayjyrHm5XrdIh1OcHBEJ08A4pvPm7BXZWutfJ2UN7ju3Ho7RL06qZiIqAKvih2T
         7dfyurt1vDY9nz4qYBQjDgSIfIrtr44qG9aOUe8TSt18GeG0ZRjkLNzh4f3Zk5loNYNk
         tpP8ib6hS35/vbkHmkEp5MmpSV0wVjuVb5lUs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=yh4k/+se1wnprbaFwf3y9UrMWyP2Ly9Nz5pe8mFcVUc=;
        b=cvKDWAl1EFTswjBR8EFSCI/+J08RhMKPlflD0Vnpxnadk7uuMxsGYn6JC6pVlicNz5
         D9p1eX30edWplKWMLTiM2V0tVF45XoL3rnoc6avfCt/u6pSQ8pyI5KgThWlGqAkrh1hv
         /tNQ6ZpJOiD6U/cW/X4EgeNMikVnskjCOOFtemo7YVgsjw6SlUb4a5qFA2ODI/djCSpT
         QsymE0RO1vuzIgk/iBK0HXAeDCTPBeXMj+Tnzi/cU7niSvBHZqCjeJvJgPGju0bH42Pd
         HcPJT1QeHsfMoND2iHQob7bm7VOuDR8PjCalM+8DBNqkyZu9dpT6S7gcqEoRi4lcF2+n
         +Drw==
X-Gm-Message-State: ACrzQf1Q1qZPgjZKK1ww+aVhMOVkG0nZ7tQy1L4UvjOmGnEC7yP0bSbx
        Ww11+ryey2dLShSmaauOwoXWWA==
X-Google-Smtp-Source: AMsMyM48zQ7Ab7sC5WDoRUZeJpQG6yDZPfYRxg9D0izA0fBqb8oCfTzahNCYl6stimP8gJ+EQmvElQ==
X-Received: by 2002:a17:90b:388c:b0:205:7966:c13c with SMTP id mu12-20020a17090b388c00b002057966c13cmr1936397pjb.49.1664245656015;
        Mon, 26 Sep 2022 19:27:36 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a5-20020a170902ecc500b00176acd80f69sm152371plh.102.2022.09.26.19.27.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 19:27:35 -0700 (PDT)
Date:   Mon, 26 Sep 2022 19:27:34 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] wifi: nl80211: Split memcpy() of struct
 nl80211_wowlan_tcp_data_token flexible array
Message-ID: <202209261924.BE1E0F29FA@keescook>
References: <20220927003903.1941873-1-keescook@chromium.org>
 <YzJS+wRX0nu3qE4F@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzJS+wRX0nu3qE4F@work>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Sep 26, 2022 at 08:33:47PM -0500, Gustavo A. R. Silva wrote:
> On Mon, Sep 26, 2022 at 05:39:03PM -0700, Kees Cook wrote:
> > To work around a misbehavior of the compiler's ability to see into
> > composite flexible array structs (as detailed in the coming memcpy()
> > hardening series[1]), split the memcpy() of the header and the payload
> > so no false positive run-time overflow warning will be generated.
> > 
> > [1] https://lore.kernel.org/linux-hardening/20220901065914.1417829-2-keescook@chromium.org/
> > 
> > Cc: Johannes Berg <johannes@sipsolutions.net>
> > Cc: "David S. Miller" <davem@davemloft.net>
> > Cc: Eric Dumazet <edumazet@google.com>
> > Cc: Jakub Kicinski <kuba@kernel.org>
> > Cc: Paolo Abeni <pabeni@redhat.com>
> > Cc: linux-wireless@vger.kernel.org
> > Cc: netdev@vger.kernel.org
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >  net/wireless/nl80211.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
> > index 2705e3ee8fc4..461897933e92 100644
> > --- a/net/wireless/nl80211.c
> > +++ b/net/wireless/nl80211.c
> > @@ -13171,7 +13171,8 @@ static int nl80211_parse_wowlan_tcp(struct cfg80211_registered_device *rdev,
> >  	       wake_mask_size);
> >  	if (tok) {
> >  		cfg->tokens_size = tokens_size;
> > -		memcpy(&cfg->payload_tok, tok, sizeof(*tok) + tokens_size);
> > +		cfg->payload_tok = *tok;
> > +		memcpy(cfg->payload_tok.token_stream, tok->token_stream, + tokens_size);
> 
> There is a spurious '+' here............................................^^^

HUnh. Well. I learned a new C-ism today. A leading "+" is just accepted.
I build-tested this, and it was happy. I just double-checked, and sure
enough, it is actually parsing that line. I will send a v2. Thanks for
catching that! ... That's such a weird typo we don't even have a
checkpatch rule for it. :P

-- 
Kees Cook
