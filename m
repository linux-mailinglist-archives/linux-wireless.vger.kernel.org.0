Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 105EC5B40FD
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Sep 2022 22:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231624AbiIIUp4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 9 Sep 2022 16:45:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbiIIUpc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 9 Sep 2022 16:45:32 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94D73F02A9
        for <linux-wireless@vger.kernel.org>; Fri,  9 Sep 2022 13:45:28 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id g4so2676029pgc.0
        for <linux-wireless@vger.kernel.org>; Fri, 09 Sep 2022 13:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=NJjZ4eOtgXbqttVZvevxLR3sE5cnZGbqx020g2HmRH0=;
        b=nwiDGHccuAS9X86d0iYzB0nqPH3wbyYG+jnQlX8PCdHoSweB5tOjRvxzzjpLyuJLvI
         ekCfonLF7cwmj1rxBkgLHXS2lp1mDfxUlFG4ar7jhLAuDVIgt8Nrzb1NPGePEok7J264
         s17IyDdhkc1L7JKGFWwNP4BGufs/cXr8ZHsBw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=NJjZ4eOtgXbqttVZvevxLR3sE5cnZGbqx020g2HmRH0=;
        b=Z1W5lLJ9LmiSaCPDn90t32lE9ePl2IWM1JicaqA6xQc+qbIxpxPBHWHJcZgqkZwjCl
         iKYfHgysBxMRUTy/8rVsw52O+jN+7hok3onMY4aX9aZxVTJ/dUmZXCDMp68uuTqjp4PL
         3i8/HIIuFsC16k/UxeHJ15a+yI9tH5Q61MXfSFtpJSRPtk5piXOK3T7VVx1k4JZApRko
         4wz2EktiZABYScLJjNHolsjn60X4SAzBmnjwGXzxrJfSHTAhuUOa21spq64dlPXDTVjU
         W/NByRa6SCXvpfK1vntdKHYm6eCeRH1Tut4slZS7ElyUUzobo4ugFT9jlwSw3iXYIUj8
         jrWQ==
X-Gm-Message-State: ACgBeo2F7gIGmC/c0Z6hGuwt/PxYPWBbacbHZ7O2lxzu4ITHvVaYHpyr
        rZbtQGAl8su9KNy5fxzlr+Mzd3V1nnmguQ==
X-Google-Smtp-Source: AA6agR43hBqa7/QNbHL24lNReEjl7LiW28DlyAh6oXO2yPw68vD6MJjhi01ZdQ0AVoBK3TId7x/CEw==
X-Received: by 2002:a63:e118:0:b0:438:7603:8d6e with SMTP id z24-20020a63e118000000b0043876038d6emr6424308pgh.72.1662756327334;
        Fri, 09 Sep 2022 13:45:27 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:9a56:cfb8:a1f9:85b5])
        by smtp.gmail.com with ESMTPSA id e16-20020a170903241000b0017532e01e3fsm827101plo.276.2022.09.09.13.45.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 13:45:26 -0700 (PDT)
Date:   Fri, 9 Sep 2022 13:45:24 -0700
From:   Brian Norris <briannorris@chromium.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH 07/12] wifi: mwifiex: fix array of flexible structures
 warnings
Message-ID: <Yxul5PfKtIL6tHVA@google.com>
References: <20220904212910.8169e8c9090c.I0357e80cc86be2d4ac6205d1f53568444dcf7c9b@changeid>
 <20220904212910.2c885310ebee.If7177ea588b56c405eee6e6df595e9efccdfb99a@changeid>
 <YxfHwxuwEP1rQoAU@google.com>
 <b6f5ad5b9a50fd26838c019921f3ace1e739f9b8.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6f5ad5b9a50fd26838c019921f3ace1e739f9b8.camel@sipsolutions.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Sep 07, 2022 at 08:57:28AM +0200, Johannes Berg wrote:
> On Tue, 2022-09-06 at 15:20 -0700, Brian Norris wrote:
> > On Sun, Sep 04, 2022 at 09:29:07PM +0200, Johannes Berg wrote:
> > > From: Johannes Berg <johannes.berg@intel.com>
> > > 
> > > There are two, just change them to have a "u8 data[]" type
> > > member, and add casts where needed. No binary changes.
> > 
> > Hmm, what exact warning are you looking at? This one?
> > https://clang.llvm.org/docs/DiagnosticsReference.html#wflexible-array-extensions
> > 
> 
> I think gcc also has one with W=1 now?
> 
> But yes, it's similar to that one. I was looking at Jakub's netdev test
> builds here:
> 
> https://patchwork.hopto.org/static/nipa/673828/12964988/build_32bit/stderr
> 
> ../drivers/net/wireless/marvell/mwifiex/fw.h:2107:46: warning: array of flexible structures
> ../drivers/net/wireless/marvell/mwifiex/fw.h:2257:47: warning: array of flexible structures

I think you're actually looking at a sparse warning:

https://lore.kernel.org/linux-sparse/20200930231828.66751-12-luc.vanoostenryck@gmail.com/

I can convince clang to enable the warning I mentioned, but it's not on
by default, even with W=1. When enabled, it complains similarly, as well
as about a ton of other code too.

> > > @@ -2104,7 +2104,7 @@ struct mwifiex_fw_mef_entry {
> > >  struct host_cmd_ds_mef_cfg {
> > >  	__le32 criteria;
> > >  	__le16 num_entries;
> > > -	struct mwifiex_fw_mef_entry mef_entry[];
> > > +	u8 mef_entry_data[];
> > 
> > Do you actually need this part of the change? The 'mef_entry' (or
> > 'mef_entry_data') field is not actually used anywhere now, but I can't
> > tell what kind of warning is involved.
> 
> But it itself is variable, so the compiler is (rightfully, IMHO) saying
> that you can't have an array of something that has a variable size, even
> if it's a variable array.

OK.

I suppose this warning makes sense when you're truly treating these as
arrays (of size more than 1). And in this case (mwifiex_cmd_mef_cfg()
and mwifiex_cmd_append_rpn_expression()), the code to (mostly?) properly
handle the flexible array is pretty ugly anyway, and doesn't really use
the type safety much (lots of casting through u8* and similar). So this
isn't really the best example to try to retain.

(mwifiex_cmd_coalesce_cfg() has some similarly ugly casting and math.)

But if the "array" is just an optional extension to a struct, and we
expect at most a single element, then I don't think the construct is
fundamentally wrong. It might still be hard to get correct in all cases
(e.g., ensuring the right buffer size), but it still feels like a decent
way to describe things.

> > >  struct host_cmd_ds_coalesce_cfg {
> > >  	__le16 action;
> > >  	__le16 num_of_rules;
> > > -	struct coalesce_receive_filt_rule rule[];
> > > +	u8 rule_data[];
> > 
> > These kinds of changes seem to be losing some valuable information. At a
> > minimum, it would be nice to leave a comment that points at the intended
> > struct; but ideally, we'd be able to still get the type safety from
> > actually using the struct, instead of relying on casts and/or u8/void.
> 
> All fair points. This was the way we typically do this in e.g.
> ieee80211.h ("u8 variable[]", not "struct element elems[]"), but YMMV.
> 
> I thought later after Kalle asked about making it a single entry such as
> 
>   struct coalesce_receive_filt_rule first_rule;
> 
> but then the sizeof() is messed up and then the change has to be much
> more careful.
> 
> Anyway, I was mostly trying to remove some warnings in drivers that
> don't really have a very active maintainer anymore, since we have so
> many in wireless it sometimes makes it hard to see which ones are new.

Sure, I guess it's good to clean some of these up.

Looking around, I don't see a great alternative, and per some of my
above notes, I don't think these are beautiful as-is.

> No particular feelings about this patch :-)

After a little more look, I'm fine with this patch. I'd probably
appreciate it better if there was a comment of some kind in the struct
definition, and perhaps mention sparse's -Wflexible-array-array. But
either way:

Reviewed-by: Brian Norris <briannorris@chromium.org>

Thanks.
