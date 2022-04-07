Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 329014F76D6
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Apr 2022 09:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240865AbiDGHKf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 7 Apr 2022 03:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241447AbiDGHKc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 7 Apr 2022 03:10:32 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8CAF22517
        for <linux-wireless@vger.kernel.org>; Thu,  7 Apr 2022 00:08:33 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id a16-20020a17090a6d9000b001c7d6c1bb13so5324455pjk.4
        for <linux-wireless@vger.kernel.org>; Thu, 07 Apr 2022 00:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=suJEW3/On+Zn2x/MEl50Wo/0BjWr9SjdMRE33VsVZrU=;
        b=jGXZG2OICENcaDJSCzs1725uotNrZHWMMmOlNoW69+Q7ryzUJap1rljRXsMdZ3WE3A
         KFnEfHYHeVF0glB924YncBPrQyhA5RzAB/w8mARMzBYXgxIBeOpG4z7WMsR0gQYvjsg/
         7xCkZgiKX/arBIXlwf52yLHgOYgXo4J6OwHV1Jj5yb4DHxK4mygqbT7SBTPo9uxFwvmr
         ZXcaJbmjoDjPqdkpC9OMun4I3JUZUUB5z1NGUtlBdfcpAq2sVI2xyWyx5dfl13xqkH+Q
         GduvNN9j6UP+0kacfAvVOHEHBkwtlSZ1s2fmEVfdIcX0DMi7wGADDnlfKOzqL6p4J5y1
         elXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=suJEW3/On+Zn2x/MEl50Wo/0BjWr9SjdMRE33VsVZrU=;
        b=Ic/oaCBfD/RMLpg4CeCyO7mPLqaK52ol0aMJYsOVavg5O3YhsMG9YQrDUGs0tTlbTl
         YS7S9bunU+b9iyEjhvWnUm0BllSCJkf7RItLKhIEhIjh+wv1tJpWzz0oXuXOPCAC8VIe
         26+/nKsZZ0ayFNgg2oBzGXcAm8gV3yYNm2R9Wjht13gt/rTiP2+vcaOX17pj+ko7mF8O
         Dld+eW8PYDXTdD08u0XiLigPPWJR9DN/PMeUvr/iCdo8/tRaopuRVqAYf7a6++KGBqt6
         B+H4JObxZ7toXkfdR3XMb/FY2/moVtpONzgrUZplhNPRpyEMYX4QaIQiCCu9m2pza2YY
         b2jA==
X-Gm-Message-State: AOAM531nAZWsFuLGOrYFdCi8qaXxZeosu43CT92gUIV0oTtZtpPssljs
        mUHvZOGiMvvAm6miBFCqFQFzx6OESP20mIEzzuI=
X-Google-Smtp-Source: ABdhPJw1eouw8hhHA8zNdwdzXqLDCsWjWoDTVlThZYXIVroJ463SfJsaqGKEDt6UfKqv8RjHyT2zK4OKcNTFmEDxg6I=
X-Received: by 2002:a17:90b:1b4e:b0:1c6:fff4:34dc with SMTP id
 nv14-20020a17090b1b4e00b001c6fff434dcmr14370777pjb.76.1649315312985; Thu, 07
 Apr 2022 00:08:32 -0700 (PDT)
MIME-Version: 1.0
References: <CAA=hcWQFNOeycXFPhrtHcQG3V8fWSShNRuAi49jtv8h1fPVUuQ@mail.gmail.com>
 <8ef5d73a-6293-a6c5-6bbb-b130266a8f0b@broadcom.com> <CAA=hcWQ_FVTVfRe91z1yHXMBLkkhi0eTq-9Lw3Tg=X6OS5Ku-Q@mail.gmail.com>
 <CA+ASDXPXCLjSL+mKKn-vh0fx0jdGBN-HOSDh4Dvy+93HSdRfBg@mail.gmail.com>
In-Reply-To: <CA+ASDXPXCLjSL+mKKn-vh0fx0jdGBN-HOSDh4Dvy+93HSdRfBg@mail.gmail.com>
From:   Jupiter <jupiter.hce@gmail.com>
Date:   Thu, 7 Apr 2022 17:07:56 +1000
Message-ID: <CAA=hcWS7w+EGZUnTJhLFEoOa78abBXLbGRHDz+BFYvR0n9c+sA@mail.gmail.com>
Subject: Re: Support for bcm43364 wireless chipset in brcm80211/brcmfmac
To:     Brian Norris <briannorris@chromium.org>
Cc:     Arend van Spriel <arend.vanspriel@broadcom.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sean Lanigan <sean@lano.id.au>,
        Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Brian,

Thanks for your response and comments.

> Despite what corporations tell you, mainline Linux shouldn't be
> dropping support for things just because the corporation moved on. If
> you can track down the mwifiex regression (e.g., with bisection),
> there's a chance we can fix it. I still see
> SDIO_DEVICE_ID_MARVELL_8801 listed in the upstream driver, FWIW.

As an open source advocate, I am keen to debug and to track it down,
but to be honest, we have a very small embedded development team here,
no one has deep knowledge and skill for kernel work, nor is anyone
familiar with git bisect for debugging an embedded device. We can run
our embedded board on console to debug the issue, but we do need
experienced kernel developers to guide us to run git bisect, we tried
last time, it did not work, if you are willing to help and if you are
patient, we can start a new debug thread to work it out.

Another issue, it is not just kernel 5.10 mwifiex driver has been
changed, the version of sd8801_uapsta.bin was also updated to
W14.68.36.p204 by Ganapathi Bhat <gbhat@marvell.com> who moved to NXP
but soon resigned from NXP we could not contact to Ganapathi. We don't
believe Ganapathi tested the new version firmware with kernel 5.10
driver well, we don't know if it is a driver issue or firmware issue,
it is very hard to debug two moving targets broken in protocol,
especially we could not see the source of firmware. We did test
5.10.81 mwifiex driver with different versions of sd8801_uapsta.bin,
then just found out that different versions of firmware have different
communication issues, so we had no choice but to give up the debug
efforts. In that sense, we don't know if the git bisect would be
effective to resolve this problem.

> Unfortunately, without anyone paying attention (Marvell, NXP, ... or
> you) that has the hardware, it can be hard to guarantee things stay
> working. Hint: while I have (and care about) several Marvell chips, I
> don't have that one.

We did spend a large amount of resources and time debugging and we
raised mwifiex issues many times to this list, unfortunately we did
not get any response until now. If anyone is interested in debugging
it, I'll devote myself to working it out, we are in downunder in
different time zones.

Thank you very much.

Kind regards,

Jupiter
