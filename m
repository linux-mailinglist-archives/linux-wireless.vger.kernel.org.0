Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB1553EB9C8
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Aug 2021 18:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232482AbhHMQJQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Aug 2021 12:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbhHMQJQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Aug 2021 12:09:16 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 470CEC0617AE
        for <linux-wireless@vger.kernel.org>; Fri, 13 Aug 2021 09:08:49 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id w13-20020a17090aea0db029017897a5f7bcso16638854pjy.5
        for <linux-wireless@vger.kernel.org>; Fri, 13 Aug 2021 09:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Zb6hESOPAPpsYQTxj6uunL70me57Ohn5RtlRGa2hRIU=;
        b=bt0deawY8VgLg78fejbazYxtQGqnJJ+YkSz5IoTYnQ5LuF//jd0UR5Pt6RCob2ruwg
         L7XvtJcs+LMzfCUDh81Ba+1wBbHDlsnlh6IiZoditm2+zMGPr5c1K/absUN+/4ZuN2lB
         hqNu9nLcRyjmucoSbEUpC/VFf1vXe3dcafsIk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Zb6hESOPAPpsYQTxj6uunL70me57Ohn5RtlRGa2hRIU=;
        b=ubdNhW3s8Go+0yEaKqlkDqoxYj7B08oUC/3t9vtOIWjw9sB+0PCmGsFO5Xv22A960q
         IN/gPI9pTPL1nkzT2vmtQ49YRv2lAcYBa/7cacSycZwzKoWNP5j8SsnxQcufbV6/DVhJ
         ymV6zHguKyg2envXbE2bHdWxP+439VSutO+3+JLzuK4FUBydyJhzlv4WjmCS4Gjol1ub
         MgjLm9emki4GvaLIUJA3g6mnzZxM/wyw8nUs0SxWkOsh9+3NQW4jVgJWV6sxDTHGXItZ
         Dq+xkxXbLe1O6T1LTAuoB16MZMdHjzygDae7ytaEoYJctxle6EXXF1qbWc4F9v9wzm5C
         9oNA==
X-Gm-Message-State: AOAM532UFc8ipAXKdTIQbPsrGaT3vplJb1rJTAx6Kl0H7bJaUdoMTcZr
        YCO/zAL2k099cEa+1KofWaN/ew==
X-Google-Smtp-Source: ABdhPJzO/EBStKGp8NBzLlcdP5+lTA2rI0q06EsQcV9US+8Rtvv2vMu7llrU0u1jr9BMG5zMLdkcVQ==
X-Received: by 2002:a05:6a00:1803:b029:3cd:d5c1:f718 with SMTP id y3-20020a056a001803b02903cdd5c1f718mr3121899pfa.22.1628870928766;
        Fri, 13 Aug 2021 09:08:48 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y64sm3224461pgy.32.2021.08.13.09.08.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Aug 2021 09:08:48 -0700 (PDT)
Date:   Fri, 13 Aug 2021 09:08:47 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Keith Packard <keithpac@amazon.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-staging@lists.linux.dev, linux-block@vger.kernel.org,
        linux-kbuild@vger.kernel.org, clang-built-linux@googlegroups.com,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 39/64] mac80211: Use memset_after() to clear tx status
Message-ID: <202108130907.FD09C6B@keescook>
References: <20210727205855.411487-1-keescook@chromium.org>
 <20210727205855.411487-40-keescook@chromium.org>
 <202107310852.551B66EE32@keescook>
 <bb01e784dddf6a297025981a2a000a4d3fdaf2ba.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb01e784dddf6a297025981a2a000a4d3fdaf2ba.camel@sipsolutions.net>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Aug 13, 2021 at 09:40:07AM +0200, Johannes Berg wrote:
> On Sat, 2021-07-31 at 08:55 -0700, Kees Cook wrote:
> > On Tue, Jul 27, 2021 at 01:58:30PM -0700, Kees Cook wrote:
> > > In preparation for FORTIFY_SOURCE performing compile-time and run-time
> > > field bounds checking for memset(), avoid intentionally writing across
> > > neighboring fields.
> > > 
> > > Use memset_after() so memset() doesn't get confused about writing
> > > beyond the destination member that is intended to be the starting point
> > > of zeroing through the end of the struct.
> > > 
> > > Note that the common helper, ieee80211_tx_info_clear_status(), does NOT
> > > clear ack_signal, but the open-coded versions do. All three perform
> > > checks that the ack_signal position hasn't changed, though.
> > 
> > Quick ping on this question: there is a mismatch between the common
> > helper and the other places that do this. Is there a bug here?
> 
> Yes.
> 
> The common helper should also clear ack_signal, but that was broken by
> commit e3e1a0bcb3f1 ("mac80211: reduce IEEE80211_TX_MAX_RATES"), because
> that commit changed the order of the fields and updated carl9170 and p54
> properly but not the common helper...

It looks like p54 actually uses the rates, which is why it does this
manually. I can't see why carl9170 does this manually, though.

> It doesn't actually matter much because ack_signal is normally filled in
> afterwards, and even if it isn't, it's just for statistics.
> 
> The correct thing to do here would be to
> 
> 	memset_after(&info->status, 0, rates);

Sounds good; I will adjust these (and drop the BULID_BUG_ONs, as you
suggest in the next email).

Thanks!

-Kees

-- 
Kees Cook
