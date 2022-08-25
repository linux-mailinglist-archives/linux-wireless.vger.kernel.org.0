Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC775A1676
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Aug 2022 18:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242961AbiHYQOA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 25 Aug 2022 12:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242949AbiHYQN7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 25 Aug 2022 12:13:59 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D25CB56F5
        for <linux-wireless@vger.kernel.org>; Thu, 25 Aug 2022 09:13:58 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id hf17so2187808pjb.3
        for <linux-wireless@vger.kernel.org>; Thu, 25 Aug 2022 09:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc;
        bh=8f2Fip1BlF+05r+evY1pMn64UZI0754Z1RqYbeXBH2M=;
        b=guQUtO2EkLS0FfVt7XuVyGRocf241bTMYKXK3yRutmQQKPk9nKP6FHD+0IVzDD0WhT
         8sPed1tCQZB+pYZeyiChDCQ9JyV+85Xeau1pEozJoCHK0fWoY909DN31+4RmVSvvfD8c
         VrqlxBbFwvaop1WPnp5Sbld1uEpHhllTVArdcdNYZdHpfSq9m0PIhyMWv8Hcx1mMnZbH
         0uSbDzuLmw6KyRXQLl2b0Esp+d5Vs0l3l89O89rndMpQqhCt7G/JQRltSK05cLQ3CzC7
         dh3wyzrQZDkr5YyDZREKDCIYZ+XL8r/XOyAvQdysWKCi5SB5BDXFyKU/MDoOQe1Frh+K
         judQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc;
        bh=8f2Fip1BlF+05r+evY1pMn64UZI0754Z1RqYbeXBH2M=;
        b=N0oo+7SmyCiqI7pf3yywRtKhorCZg+Yf6vBSGbdzzM33hSbLZjBwHu9xJiuYpyiXtx
         f7pnGAgketeQqWop+UfaiBYVM7Q7I3NK4Ouey9OedTa6Re5VMeLHvHyD7JDZ22hEqoIA
         616CAWMAF0O3UOub9rWDJFVgelXGOGvwRQiWUdjY0fWtYr2I667YyypOeXR4EiKdi0YS
         ZMBVuVf511uJIQ5K4HtYnJeAsBNCox1OJTeBjET+rhfJKdd7nVPKDxW7oQZYxLo2GpGs
         3c+rkZsn5LMUB7oHZsuboRziY52ZOBwo9/vrKNCAcpK8CkUYTfEBlytKpv6HEVH8dl50
         UOnw==
X-Gm-Message-State: ACgBeo3lRxKmcMIBI+xhM2bWhkQmGqhyvd3KYCGmFjlm6JJEHQT9WM5F
        iv4UDRAay/ETWEJBk9TeZM7KJ1824nU=
X-Google-Smtp-Source: AA6agR7FlaFviMeRVgyKXEvQzh34t5zNSpiPBGR4KYNorHt9FK0whXJzxApkR4z7x5MPHLjwuQESsQ==
X-Received: by 2002:a17:90b:4b47:b0:1f7:2e06:5752 with SMTP id mi7-20020a17090b4b4700b001f72e065752mr5439830pjb.187.1661444037477;
        Thu, 25 Aug 2022 09:13:57 -0700 (PDT)
Received: from [192.168.254.16] ([50.39.168.145])
        by smtp.gmail.com with ESMTPSA id b16-20020a170902d51000b001730cf6f839sm4992541plg.70.2022.08.25.09.13.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 09:13:57 -0700 (PDT)
Message-ID: <1cdf35f95aca2a65d0d738544fb04079125b9581.camel@gmail.com>
Subject: Re: [PATCH v2 2/2] mac80211: Support POWERED_ADDR_CHANGE feature
From:   James Prestwood <prestwoj@gmail.com>
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
Date:   Thu, 25 Aug 2022 09:13:56 -0700
In-Reply-To: <e898282f0766bdf0bd9cbb92d2a3551ff28cdf6b.camel@sipsolutions.net>
References: <20220811231338.563794-1-prestwoj@gmail.com>
         <20220811231338.563794-3-prestwoj@gmail.com>
         <e898282f0766bdf0bd9cbb92d2a3551ff28cdf6b.camel@sipsolutions.net>
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

Hi Johannes,

On Thu, 2022-08-25 at 11:02 +0200, Johannes Berg wrote:
> On Thu, 2022-08-11 at 16:13 -0700, James Prestwood wrote:
> > @@ -217,7 +275,11 @@ static int ieee80211_change_mac(struct
> > net_device *dev, void *addr)
> >         if (ret)
> >                 return ret;
> >  
> > +       if (live)
> > +               drv_remove_interface(local, sdata);
> >         ret = eth_mac_addr(dev, sa);
> > +       if (live)
> > +               ret = drv_add_interface(local, sdata);
> >  
> >         if (ret == 0)
> >                 memcpy(sdata->vif.addr, sa->sa_data, ETH_ALEN);
> > 
> 
> I still don't like the (lack of) error checking here. As far as I know,
> eth_mac_addr() can very happily fail if the passed address is invalid,
> so we really shouldn't overwrite the ret value by drv_add_interface().

Ah yes, that was an oversight. I assume we do want to add_interface
even if eth_mac_addr fails though. So my only question is about the
return from drv_add_interface(). Is this unlikely to fail? If so would
just a WARN_ON be sufficient and return the value from eth_mac_addr()?

So something like:

	if (live)
		drv_remove_interface(local, sdata);
	ret = eth_mac_addr(dev, sa);
	if (ret == 0)
		memcpy(sdata->vif.addr, sa->sa_data, ETH_ALEN);

	if (live)
		WARN_ON(drv_add_interface(local, sdata));

	return ret;

> 
> Also, it seems like we should only add the interface again after
> updating sdata->vif.addr (last context line), so that the driver
> actually knows ... otherwise I'm not sure how this patch would have
> much
> effect (unless it updates the FW all the time like iwlwifi, which I
> guess is where you tested it, based on the rationale...)

Yes, this is where I tested it. But yeah makes sense, I'll move copying
the address to before add_interface.

Thanks,
James

> 
> johannes


