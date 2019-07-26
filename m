Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65C2F75EE6
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jul 2019 08:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbfGZGTF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 26 Jul 2019 02:19:05 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:39987 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbfGZGTF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 26 Jul 2019 02:19:05 -0400
Received: by mail-vs1-f67.google.com with SMTP id a186so33752960vsd.7
        for <linux-wireless@vger.kernel.org>; Thu, 25 Jul 2019 23:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Bl7fI4eVZWffKAOz4zhIOA0eJ2D0U0DNka5Gld+y0is=;
        b=WmFtrFSw/R5Cz8UuWt8tiEoXLxFQ6BCS/F4MD7pwFOpPfJiwxzoJexVjGGjwbsbDM2
         8kGywwqi+EOUNqcAN2+vSIAEsSl/yhZDMdDmQonSWX1pUYtAwsGuFx3miJ2JcVGBs7na
         bOUfRzSLSYvBUWvbRSdvjTY1ct55yl0Iqn5yJ5tjdfz6zPsgOdAnc8TuJC4Fxt7PuTiq
         6AM60l/Fdw/kt2HG/LbYjxx1ftu9FTGK4yV8DVY1xA3Da9zgQcDfENwhQDx1YstruteQ
         q/r7kniw5cWXc/F3AtJTiR2+eVsb/myAm9vO7XDIP/hpQUaUdZ+mg1Nva++4iPrL65v/
         E2tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Bl7fI4eVZWffKAOz4zhIOA0eJ2D0U0DNka5Gld+y0is=;
        b=iVJXjwkJJcJ5PXiUO+F8ixXXcJTREU+Vcxy/TYgm14hjE5sEJS0coTuZDl9HlM3Kjz
         st4sb95skq7X740UXtow+O670QPJ7EHoNXkNIF0i7M5Y2DXWaV/n1sf58nCVnlsJVtQ/
         bQAv5+lXDA4oZa+KqeSkdirWNihtBhAHH62RoJS+0z6z3LOailoEOCdHx2hssGWkIpDl
         9thkEq2TOVoYvjB9qI0DvYcvioPOcFlDwt+gHjYhshYCOpCmVUVS2QahC0+I+EYUstlj
         2lHKMdNWYx7TPj9ERdTUAq9t9snOdstaO5qW+nnkedKBqpw3ZxSUgZJsTy9UNYVmuEcc
         MQLw==
X-Gm-Message-State: APjAAAWNqENuNMaEB41NFrtU2VfNs5J6V3GoOedKVvpqUR7qTPA8pj2K
        E/QuYKqTFOHlymVvzJGB3wOpYeYc5QboZJx+m6WRQxa12a+yQg==
X-Google-Smtp-Source: APXvYqy5de4RdPtgj97TOfRHiUta7VD2dn3FWaYfsVQWQZRVK/s1bYmGEqsu1oqBvlo5cD2KF02tErIDgh9uivkIFbI=
X-Received: by 2002:a67:eb19:: with SMTP id a25mr58320351vso.109.1564121943796;
 Thu, 25 Jul 2019 23:19:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190725080925.6575-1-jian-hong@endlessm.com> <06d713fff7434dfb9ccab32c2e2112e2@AcuMS.aculab.com>
In-Reply-To: <06d713fff7434dfb9ccab32c2e2112e2@AcuMS.aculab.com>
From:   Jian-Hong Pan <jian-hong@endlessm.com>
Date:   Fri, 26 Jul 2019 14:18:26 +0800
Message-ID: <CAPpJ_ecAAw=1X=7+MOw-VVH0ZKBr6rcRub6JnEqgNbZ6Hxt=ag@mail.gmail.com>
Subject: Re: [PATCH] rtw88: pci: Use general byte arrays as the elements of RX ring
To:     David Laight <David.Laight@aculab.com>
Cc:     Yan-Hsuan Chuang <yhchuang@realtek.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S . Miller" <davem@davemloft.net>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux@endlessm.com" <linux@endlessm.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

David Laight <David.Laight@aculab.com> =E6=96=BC 2019=E5=B9=B47=E6=9C=8825=
=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=885:21=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> From: Jian-Hong Pan
> > Sent: 25 July 2019 09:09
> > Each skb as the element in RX ring was expected with sized buffer 8216
> > (RTK_PCI_RX_BUF_SIZE) bytes. However, the skb buffer's true size is
> > 16640 bytes for alignment after allocated, x86_64 for example. And, the
> > difference will be enlarged 512 times (RTK_MAX_RX_DESC_NUM).
> > To prevent that much wasted memory, this patch follows David's
> > suggestion [1] and uses general buffer arrays, instead of skbs as the
> > elements in RX ring.
> ...
> >       for (i =3D 0; i < len; i++) {
> > -             skb =3D dev_alloc_skb(buf_sz);
> > -             if (!skb) {
> > +             buf =3D devm_kzalloc(rtwdev->dev, buf_sz, GFP_ATOMIC);
>
> You should do this allocation somewhere than can sleep.
> So you don't need GFP_ATOMIC, making the allocate (and dma map)
> much less likely to fail.
> If they do fail using a smaller ring might be better than failing
> completely.

Ok, I can tweak and try it.

> I suspect that buf_sz gets rounded up somewhat.
> Also you almost certainly want 'buf' to be cache-line aligned.
> I don't think devm_kzalloc() guarantees that at all.

Sure

> While allocating all 512 buffers in one block (just over 4MB)
> is probably not a good idea, you may need to allocated (and dma map)
> then in groups.

Thanks for reviewing.  But got questions here to double confirm the idea.
According to original code, it allocates 512 skbs for RX ring and dma
mapping one by one.  So, the new code allocates memory buffer 512
times to get 512 buffer arrays.  Will the 512 buffers arrays be in one
block?  Do you mean aggregate the buffers as a scatterlist and use
dma_map_sg?

Thank you,
Jain-Hong Pan
