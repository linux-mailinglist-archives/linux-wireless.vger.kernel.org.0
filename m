Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4A133026A6
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Jan 2021 16:04:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729906AbhAYPAw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 Jan 2021 10:00:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729834AbhAYO7g (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 Jan 2021 09:59:36 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 330BDC06174A
        for <linux-wireless@vger.kernel.org>; Mon, 25 Jan 2021 06:58:42 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id n2so27039227iom.7
        for <linux-wireless@vger.kernel.org>; Mon, 25 Jan 2021 06:58:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EFCAA5Id8bmVV9fN/X5XQQlbGV8duN9nje4zmsdy5mo=;
        b=Di/STkxHcCb/n+PaUsKpvjoEW+4RrOFQeBsMEiVkDJQnh/5QQM0QFo5iwNKUG0SIKZ
         JIRGpM+dftdN5A6YVpFudZ/QI+RJogzc01SiS+s0dDK619K19Jhj6FPdfVdcU5AegqQW
         woeon0coprgs8/cROnKG3cBu1bYHW8NPBfcEqZMlSYJyPRjOHgHMC0m1h9kqRXN6Wm7O
         hpRKDsXB/lq/1UpIYLmG5u9SHPSgihwc0KoLLGXodzI1D/UKnG+Fpx705DRS9j5czNvi
         xtdlp2sr88C/zCjzz9aX8r29I3SPMGE2kw2FbSKAOIzovWdu9JJEl2OtmRaLi7XupKUQ
         LMMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EFCAA5Id8bmVV9fN/X5XQQlbGV8duN9nje4zmsdy5mo=;
        b=cNTJJetsOhkg+XyRFibFD30irGX1iVsgVJfe9SiUePMNnny8Wx1WPys/+RqQS7u+0q
         IJEJw1P0SGS70q7lSXD2wiGHfHZbzNqPC56wZ5FCg2mAzEHKnb8NIDEZIoE2siE3COJh
         vq43+N5zexlxVVVgh4PDPzXp6G0Bq0MiIXBPdFCR1leyVlv5nt5HewJJmcvgw4ZGEdej
         G3RQOsag4M6E+owAUkR/7dlpj4RxlxB+nYB/GAVKX7zRPGZ4vRDUi0FCLytScxwUu8A8
         2VqYBGByCYL/Vi6lBSHfZbdPCgd88M9+tfNlZY/Bg7shcEwoMxKQOnsw9Ut71qxZjf8Z
         YpzA==
X-Gm-Message-State: AOAM532+2R+hvtpeugdbTen/iq1JrMRrp1h3Pe8B0KZE1ZGgO1eNoh3P
        fseZr+MUpd3BqnhNMNFry1S5NJykoH85NaE92u0/4Q==
X-Google-Smtp-Source: ABdhPJw9RiocdV74E/NHazJ2oIaKEOnK/FeLfp9t6jqq/GfpTvO8/4daIHD953JGj84uEHCeYfXQ2AjyQg93Uae2Ojc=
X-Received: by 2002:a6b:216:: with SMTP id 22mr709645ioc.145.1611586721362;
 Mon, 25 Jan 2021 06:58:41 -0800 (PST)
MIME-Version: 1.0
References: <5664fa0f-aef2-c336-651a-093c9eed23ab@candelatech.com>
 <765f370d-ce2d-b75a-2dde-87f69ae7c185@candelatech.com> <CANn89iKpa1y2SKJuR9kRi=AZs94sj+-tzRs+2D0vmxh+ahEcGA@mail.gmail.com>
 <adbee2ec-c6ba-7a17-eb98-1c53365fa911@candelatech.com> <CANn89iJQnSVZFp2XDgREN1QMtU4exOsnJq=5VzJ6tqTCJ7MH-g@mail.gmail.com>
 <c4bcee7d-b2eb-759c-c659-d65f3e7daec9@candelatech.com> <CANn89i++Kgkj57ms70a5GDOQ-Cpewx3NQkzP3EmZmLYQ4eHzww@mail.gmail.com>
 <5d89fd24-f00a-7e70-00ce-83529f13b05e@candelatech.com> <20201218121627.603329b2@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <9003ea3720a03b4bd1b8abf3d8f645563a58f953.camel@sipsolutions.net>
 <43a5b45c-955a-22d4-2bf9-dbab852dbb5f@candelatech.com> <CANn89iJBO13s9fOVRnDyfj5HXt9wjnRpbh2_f5SuyNkNAfjzJQ@mail.gmail.com>
 <CANn89iJTCDof6ypxCkiGaPo+y0Bngg0NX5cLPWisTEZaFo1BQw@mail.gmail.com>
 <CANn89iJWG2n1s3j7EdpwkQQv-9dOY02V+FGYHAWguO4JiqWuJA@mail.gmail.com>
 <d75b2c43a416d4bb84185aab4005d42e49962e36.camel@sipsolutions.net>
 <CANn89iLZ9Y0fMk8X1a4=J7Xf2H=M0oLK_SekOLZypN+2-8a0yw@mail.gmail.com> <86b59e50756f63db9734d9a786271956d26b63ee.camel@sipsolutions.net>
In-Reply-To: <86b59e50756f63db9734d9a786271956d26b63ee.camel@sipsolutions.net>
From:   Eric Dumazet <edumazet@google.com>
Date:   Mon, 25 Jan 2021 15:58:29 +0100
Message-ID: <CANn89i+vLkPTth5xtx9ofR8XqZr3jiPD49PXaf4jfs1SJYS81w@mail.gmail.com>
Subject: Re: net: tso: add UDP segmentation support: adds regression for ax200 upload
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Ben Greear <greearb@candelatech.com>,
        Rainer Suhm <automat@posteo.de>,
        Jakub Kicinski <kuba@kernel.org>,
        Luca Coelho <luciano.coelho@intel.com>,
        netdev <netdev@vger.kernel.org>, linux-wireless@vger.kernel.org,
        Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Jan 25, 2021 at 3:57 PM Johannes Berg <johannes@sipsolutions.net> wrote:
>
> Hi Eric,
>
> On Tue, 2021-01-19 at 11:02 +0100, Eric Dumazet wrote:
> >
> > > This does fix the problems reported on iwlwifi, were you planning to
> > > submit it as a proper patch?
> >
> > Sure, I will do, thanks !
>
> Did you do that and I missed it? Or would you prefer we did?
>
> Thanks,
> Johannes
>

Oh right, let me do it :)
