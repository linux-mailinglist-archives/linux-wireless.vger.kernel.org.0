Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 652825A1C48
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Aug 2022 00:26:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244356AbiHYW0d (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 25 Aug 2022 18:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243657AbiHYW0c (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 25 Aug 2022 18:26:32 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B450A9DF84
        for <linux-wireless@vger.kernel.org>; Thu, 25 Aug 2022 15:26:31 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d12so37602plr.6
        for <linux-wireless@vger.kernel.org>; Thu, 25 Aug 2022 15:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc;
        bh=ad9fOLQAMebFp6PwoqJFTyuYh4kwz9z5DvCu2sr6Gew=;
        b=SgwcjkR+hK+N+Px3xA4ytwTACQR4PVr/0w5g6oH9fnnmA3jpgWavVu6OwAYHcQGeBJ
         RN5Vac7lZlF4/1s8FuI4xBc1gmPru7DTC/h6tcIukkQ9xq8nmrhTrlCOVXzrunrd6Lyo
         jm9VFMC4OZjdCEGMometjPEFeW823GeQ7WvP+2gKEGbkB73fgCLLaS78JezJKMcmD7BI
         Et4ap8XPwGwbz2cM02U6wDAGPezdKve2d+NTE0RPmTc2YLqmiy+YGDiLYSKQcOh91NTR
         VcPlbe9jRCTK62skxIsW0+K6enSZkwLS1AUtaqaxwmFXhidMLkUYyFWz7xVAx7wOctgx
         fszA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc;
        bh=ad9fOLQAMebFp6PwoqJFTyuYh4kwz9z5DvCu2sr6Gew=;
        b=ZEEKznJG5Uwa7lXtNBLWpdzngNwjDxI5JthQ6lL+wupNcJ+yyKGcgMiKcYyn6RmuRj
         nkBod3dYQ/+sqKYPPL3nHi64+lZLxNGGlfviOXlpB3CW2O+DfV3lWLW0f8b8ni652ttb
         oshyhBKp6RDwGygxkJ9NjJvM8PiwTJKcc9xhGtgcFxchwgHGORRptZjsrWugibu12Cpq
         /WCtJa0s0AzUxET8e9g9SKkIssg/J/CTOUz0v0qz55cQp9Yx0ksQQgU0KHMnGtT+ofdf
         MvwzjvFIAhcB2kivuvmkRBGjsv5+j3qaUQWkjJe8XGZ5tspoE4W5/ATKMLUUMbdAcQpe
         MWsQ==
X-Gm-Message-State: ACgBeo0IjQb5qxDXU8rRbhR9rjYY4pOaKKL/rnPfx4VSbvX/EahwXd9u
        0XmD62cpT+o/nljDdFVyEg7O7+YA+wE=
X-Google-Smtp-Source: AA6agR4UGpZ8kD5+AiqHI/TEUW386cQgB+/VbuApEe5a96Bpbzz4+YJFNfZxhM96444PrmtxqlPgWQ==
X-Received: by 2002:a17:90b:4ad1:b0:1fb:eba:9977 with SMTP id mh17-20020a17090b4ad100b001fb0eba9977mr1178466pjb.182.1661466391213;
        Thu, 25 Aug 2022 15:26:31 -0700 (PDT)
Received: from [192.168.254.16] ([50.39.168.145])
        by smtp.gmail.com with ESMTPSA id q16-20020a170902dad000b0017154ae6265sm59446plx.211.2022.08.25.15.26.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 15:26:30 -0700 (PDT)
Message-ID: <a424a23753eb922c980d54414a0ad0f015f84e94.camel@gmail.com>
Subject: Re: [PATCH v2 2/2] mac80211: Support POWERED_ADDR_CHANGE feature
From:   James Prestwood <prestwoj@gmail.com>
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
Date:   Thu, 25 Aug 2022 15:26:29 -0700
In-Reply-To: <6fa6b1b62f6a1bc945708cca9e27136f1737386f.camel@sipsolutions.net>
References: <20220811231338.563794-1-prestwoj@gmail.com>
         <20220811231338.563794-3-prestwoj@gmail.com>
         <e898282f0766bdf0bd9cbb92d2a3551ff28cdf6b.camel@sipsolutions.net>
         <1cdf35f95aca2a65d0d738544fb04079125b9581.camel@gmail.com>
         <6fa6b1b62f6a1bc945708cca9e27136f1737386f.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-5.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 2022-08-25 at 20:42 +0200, Johannes Berg wrote:
> Hi,
>  
> > > > +       if (live)
> > > > +               drv_remove_interface(local, sdata);
> > > >         ret = eth_mac_addr(dev, sa);
> > > > +       if (live)
> > > > +               ret = drv_add_interface(local, sdata);
> > > >  
> > > >         if (ret == 0)
> > > >                 memcpy(sdata->vif.addr, sa->sa_data, ETH_ALEN);
> > > > 
> > > 
> > > I still don't like the (lack of) error checking here. As far as I
> > > know,
> > > eth_mac_addr() can very happily fail if the passed address is
> > > invalid,
> > > so we really shouldn't overwrite the ret value by
> > > drv_add_interface().
> > 
> > Ah yes, that was an oversight. I assume we do want to add_interface
> > even if eth_mac_addr fails though.
> 
> Right.
> 
> > So my only question is about the
> > return from drv_add_interface(). Is this unlikely to fail? If so
> > would
> > just a WARN_ON be sufficient and return the value from
> > eth_mac_addr()?
> 
> Hm, yeah, I guess it really ought to not fail here.
> 
> > So something like:
> > 
> >         if (live)
> >                 drv_remove_interface(local, sdata);
> >         ret = eth_mac_addr(dev, sa);
> >         if (ret == 0)
> >                 memcpy(sdata->vif.addr, sa->sa_data, ETH_ALEN);
> > 
> >         if (live)
> >                 WARN_ON(drv_add_interface(local, sdata));
> > 
> >         return ret;
> 
> Seems reasonable. We could do something like
> 
>   err = drv_add_interface(...);
>   if (err) {
>      dev_close(...);
>      ret = ret ?: err;
>   }
> 
> or something, but not sure that's worth it, it really shouldn't fail
> at
> this point.
> 
> But I guess we could leave setting
> NL80211_EXT_FEATURE_AUTH_TX_RANDOM_TA
> to the driver if we think it'd be less risky that way?

(I assume you meant this new POWERED_ADDR_CHANGE feature)

Anyways, is this something all mac80211 drivers _should_ be able to do
(I thought I remember you indicating this was the case)? I'd hate to
introduce (expose) a bug for some driver I couldn't test... but also
the WARN_ON would be very easy to pinpoint what happened.

IMO if mac80211-based drivers should be able to handle this, I think we
should keep it in mac80211. Any issues that arise would be a driver bug
that was exposed, and needs to be fixed anyways.

Ultimately its up to you. I would like to avoid doing it per-driver but
at the same time address randomization is completely broken on 6GHz so
if we can only do it for iwlwifi so be it.

Thanks,
James

> 
> johannes


