Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28CC3509BA0
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Apr 2022 11:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382042AbiDUJE5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 21 Apr 2022 05:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345407AbiDUJE5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 21 Apr 2022 05:04:57 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 154C51FCFE;
        Thu, 21 Apr 2022 02:02:08 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 21so5664619edv.1;
        Thu, 21 Apr 2022 02:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K6EZ7wsWI5y8UAAAGRQmR1xNFdJPl4DdgJFZp25DwRE=;
        b=O1hZi3IGLAN5IQCn+JjFH/2oHhCsW3/cgFtEPYCdOUFvSwDHuW33xXHSdHnq78zYf2
         9Dzb8CutasJJgN+m7fv4Fl+vd1T3JqfYQvdUbEYQQ7vVvLtxpxY2q1v5GyqdGL5XgHnk
         chDETEMsMLm+R1iabmPqcwGUF5vQtFpFff658AhYsoL+0j1Rbt7hPJ/WKs3n8diq+FSq
         f2tusAfkYm1ZKQyDIgbGD1sha5Qbiu/vxjS+0t+WhN/1Dp1gL+a0Y2N92KXw/m7s5UGM
         yjjCAxR74M37zmjDxB33PRK4H800PP59uGS7uOQLWrL1F5MwEOWQpVfbJCVx1CB8kxrW
         jtsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K6EZ7wsWI5y8UAAAGRQmR1xNFdJPl4DdgJFZp25DwRE=;
        b=W7YbLaNKwXGaCM0xyVLC1I+43U3j/wTQqlzIeGUvIIN5QDln8UN3OzuvpceAu/p7P4
         p2rcTwDKqqZZnILpMpLZ95ZQqYXRsYsVHmVueaxpN2e1U1PL8IR5RM3lS2cM+JYLdp1+
         u/v7lY3iM01Vfpv7vBVi1sNjOCc/I5PmAjYsmlZy7GzVzU24l/jBj6TlAfCCylhHiQlL
         RvdXdWVvRIBBkv86DBdBvjAJ0XOlJYC+i850FJlvTzyxO9Sxug82hCQ+QPaoUyCt/4J/
         aaVvrYT/lNE7Iqsf1LcLQ+ASlodxsgElzBIAsl87UUc2d9cmCq7i4IAIbh8gpvI+jsoY
         nM7A==
X-Gm-Message-State: AOAM533gwYNuPx5W5Ahipk+w/0gsji/MrsW81bAqRTONDUHgkHLBILV4
        lbyw8szfD1vkwttQefKE+hFFpmEKVwsL1VZTYkkP9Wi4Wtg=
X-Google-Smtp-Source: ABdhPJx4guVtJCUodnfDDJjHz9fHaung5eLfba2XvwbduoSETDjq9IF429gakqBk5vx9H2Hm9o7NLrGzw2whII55WoY=
X-Received: by 2002:a05:6402:11c7:b0:423:f7f1:e718 with SMTP id
 j7-20020a05640211c700b00423f7f1e718mr15858549edw.279.1650531726500; Thu, 21
 Apr 2022 02:02:06 -0700 (PDT)
MIME-Version: 1.0
References: <CAGm1_ktEim1vGOf5i=H_sqrPvg=dT50790YYwXgYKgAut-a=ng@mail.gmail.com>
 <YmDpTAu9wmlLijDA@atomide.com>
In-Reply-To: <YmDpTAu9wmlLijDA@atomide.com>
From:   Yegor Yefremov <yegorslists@googlemail.com>
Date:   Thu, 21 Apr 2022 11:01:54 +0200
Message-ID: <CAGm1_kv+b1h1OuWr4w5jS_mqfQpXF7UexiWFsOSs+MJK546=ew@mail.gmail.com>
Subject: Re: wl18xx: NVS file handling
To:     Tony Lindgren <tony@atomide.com>
Cc:     Linux-OMAP <linux-omap@vger.kernel.org>,
        linux-wireless@vger.kernel.org, sebastian.reichel@collabora.co.uk,
        Eyal Reizer <eyalr@ti.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Tony,

On Thu, Apr 21, 2022 at 7:19 AM Tony Lindgren <tony@atomide.com> wrote:
>
> Hi,
>
> * Yegor Yefremov <yegorslists@googlemail.com> [220420 13:58]:
> > Hi all,
> >
> > using the 5.18.x kernel, I get the following warning:
> >
> > wlcore: WARNING Detected unconfigured mac address in nvs, derive from
> > fuse instead.
> > wlcore: WARNING This default nvs file can be removed from the file system
> >
> > removing the /lib/firmware/ti-connectivity/wl127x-nvs.bin file, I get
> > this warning:
> >
> > wl18xx_driver wl18xx.0.auto: Direct firmware load for
> > ti-connectivity/wl1271-nvs.bin failed with error -2
> >
> > What's the best way to get rid of these warnings when I don't want to
> > handle WLAN's MAC address via the wl127x-nvs.bin?
>
> See commit d382b9c00782 ("wlcore: add missing nvs file name info for
> wilink8"), to me looks like the the second warning should be just removed
> for wl18xx.
>
> > According to this discussion [1], NVS file is the last resort for
> > handling the MAC address.
> >
> > [1] https://patchwork.kernel.org/project/linux-wireless/patch/8665E2433BC68541A24DFFCA87B70F5B363E1A3D@DFRE01.ent.ti.com/
>
> Yes the NVS file does not work at all for NFSroot for multiple devices.
>
> To me it seems we should have the option for the MAC address to be
> populated by the bootloader for the devicetree property like Ethernet
> adapters typically do. Not sure what that might take, maybe it
> already works. I guess the first step would be to make the nvs file
> completely optional for wlcore.

I'll try to create a patch for making nvs file optional.

P.S. a TI maintainer for wlcore would be great .... WPA3 and mesh are
still not really there [1].

[1] https://software-dl.ti.com/ecs/WiLink8/R8_8/change_log_R8_8.html

Regards,
Yegor
