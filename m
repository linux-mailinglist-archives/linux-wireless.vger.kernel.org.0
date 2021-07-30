Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B47973DB32C
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jul 2021 08:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236982AbhG3GGc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 30 Jul 2021 02:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236430AbhG3GGb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 30 Jul 2021 02:06:31 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 870C3C061796
        for <linux-wireless@vger.kernel.org>; Thu, 29 Jul 2021 23:06:27 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d1so9859384pll.1
        for <linux-wireless@vger.kernel.org>; Thu, 29 Jul 2021 23:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IesK2FI21HpbnxZx4yJeBJ/OA9fhmSX4VPo4yVAWFag=;
        b=lIobNunjbYmru1ujEnR+ElRxW3RY7/BL+bzrtIaGaicjd6cYbzyNY1lVt/hEDV779F
         ZbrOHXHwsPMJf6lzaIv/KY1TAEbtjPhi+LJR8ecSGlZrEWDd72yogtD/8w5N5E0J8E/9
         4yNGD3XauminhdNf7u1HJO8GfDs+8YlWTPmfI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IesK2FI21HpbnxZx4yJeBJ/OA9fhmSX4VPo4yVAWFag=;
        b=rC+RlklZHiy+ag3XkN3H88/HCgErcT7Seiq9SrmwCgkwcElq6yNTgYupH9MtN5wJ0J
         MTbCrU2VDA5ithbdPJgdzdd2T7qhpBt0k5waw1hfe3xCYkxaBxOBblHCZV+F0F6BF1Uh
         haXpncn2c0okrdPa8CnMxQZwMHGofWM2CCWvfwPiV6+GFY2abz0ijfi+NpSSwORkzgjM
         xkOFzcrZJIXR44NEPFQCrkBrndPmA3bRAug4ieZswTQBTLdhP9ubY5Y4rjknVUihueQ8
         8JNf9nzrC06SDWZnqrfs24HM0cLsyHAIIo66d8MeobKbUv06yt21u2rr8pmec73W+3j8
         zBgw==
X-Gm-Message-State: AOAM530tRItDT9kVOS/21mh7XDD7mYpgVfUUpGDUa3VxJgLab3sWrsSb
        LLvOADF3XXqdKlSeifeD9SPdmg==
X-Google-Smtp-Source: ABdhPJzeUonVBgQ9NzzIA7kKbTvq5SBrLVxVHXebCyU1ipbT+iV0p67058qXEDQM1C04AViV+Ahtag==
X-Received: by 2002:a17:902:aa89:b029:12c:17dc:43b0 with SMTP id d9-20020a170902aa89b029012c17dc43b0mr1167657plr.81.1627625186985;
        Thu, 29 Jul 2021 23:06:26 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id nl2sm714675pjb.10.2021.07.29.23.06.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 23:06:26 -0700 (PDT)
Date:   Thu, 29 Jul 2021 23:06:25 -0700
From:   Kees Cook <keescook@chromium.org>
To:     dsterba@suse.cz, Dan Carpenter <dan.carpenter@oracle.com>,
        linux-hardening@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Keith Packard <keithpac@amazon.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-staging@lists.linux.dev, linux-block@vger.kernel.org,
        linux-kbuild@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH 02/64] mac80211: Use flex-array for radiotap header bitmap
Message-ID: <202107292305.DB86BAC@keescook>
References: <20210727205855.411487-1-keescook@chromium.org>
 <20210727205855.411487-3-keescook@chromium.org>
 <20210728073556.GP1931@kadam>
 <20210728092323.GW5047@twin.jikos.cz>
 <202107281454.F96505E15@keescook>
 <20210729104547.GT5047@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210729104547.GT5047@suse.cz>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Jul 29, 2021 at 12:45:47PM +0200, David Sterba wrote:
> On Wed, Jul 28, 2021 at 02:54:52PM -0700, Kees Cook wrote:
> > On Wed, Jul 28, 2021 at 11:23:23AM +0200, David Sterba wrote:
> > > On Wed, Jul 28, 2021 at 10:35:56AM +0300, Dan Carpenter wrote:
> > > > @@ -372,7 +372,7 @@ ieee80211_add_rx_radiotap_header(struct ieee80211_local *local,
> > > >  			ieee80211_calculate_rx_timestamp(local, status,
> > > >  							 mpdulen, 0),
> > > >  			pos);
> > > > -		rthdr->it_present |= cpu_to_le32(1 << IEEE80211_RADIOTAP_TSFT);
> > > > +		rthdr->data.it_present |= cpu_to_le32(1 << IEEE80211_RADIOTAP_TSFT);
> > > 
> > > A drive-by comment, not related to the patchset, but rather the
> > > ieee80211 driver itself.
> > > 
> > > Shift expressions with (1 << NUMBER) can be subtly broken once the
> > > NUMBER is 31 and the value gets silently cast to a 64bit type. It will
> > > become 0xfffffffff80000000.
> > > 
> > > I've checked the IEEE80211_RADIOTAP_* defintions if this is even remotely
> > > possible and yes, IEEE80211_RADIOTAP_EXT == 31. Fortunatelly it seems to
> > > be used with used with a 32bit types (eg. _bitmap_shifter) so there are
> > > no surprises.
> > > 
> > > The recommended practice is to always use unsigned types for shifts, so
> > > "1U << ..." at least.
> > 
> > Ah, good catch! I think just using BIT() is the right replacement here,
> > yes? I suppose that should be a separate patch.
> 
> I found definition of BIT in vdso/bits.h, that does not sound like a
> standard header, besides that it shifts 1UL, that may not be necessary
> everywhere. IIRC there were objections against using the macro at all.

3945ff37d2f4 ("linux/bits.h: Extract common header for vDSO") moved it
there from linux/bits.h, and linux/bits.h now includes vdso/bits.h, so
it is still ever-present. :)

-- 
Kees Cook
