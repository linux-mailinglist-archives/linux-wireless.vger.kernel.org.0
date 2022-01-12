Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6C7548CAC3
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jan 2022 19:15:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356105AbiALSPX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Jan 2022 13:15:23 -0500
Received: from mail-lf1-f53.google.com ([209.85.167.53]:42916 "EHLO
        mail-lf1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356134AbiALSOa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Jan 2022 13:14:30 -0500
Received: by mail-lf1-f53.google.com with SMTP id e3so8284721lfc.9
        for <linux-wireless@vger.kernel.org>; Wed, 12 Jan 2022 10:14:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nHDqqj0l+ZlSx/c+b9Uj5HY9WCevcAmcTEvd9GT91/U=;
        b=TLU9HXEyFP2pSmUNXOn1A35MbFFIikfSMjCYj7PJCoFGh3WwZcgf2bQDp5yyHNL2B+
         RwqJj8YyVAN4vn5JUtBrcSEYi5rOrTsa/RiFZB7QzNqMocMrX5eQKHkARfYIeyVNX5xV
         NA7hTfVXFbc3V2b9gj34/tLT6m5+mItLAzzEVBAhdtRXJESjeSVza5mm2LRGthDbXqVL
         UHCRkCFFcC1uoBhqVO/H1Ym+JfNMV3wcir/b5+hvgQoD+mBt/Q3izcM0xth+G1rN7Ump
         fZxhAUF2yo/qiVKrwUsOJunaww2PCbpN2ZYTo20wWD/5ZGSm7bWKphkFFXlxuvHyYVz4
         wkVA==
X-Gm-Message-State: AOAM532Ln3pjCBiX9J1orMQm9g1vlP0X0AEvfmScUWnCPkH4TaM+8PWH
        ypJpwnvo9bguD4WKbiOitB320cqeXe4BCXqkVlA=
X-Google-Smtp-Source: ABdhPJx0wRuvSTXlRmapmuyxl0ePRGXNyOyKAdeI246mRHjjWn6h6fqNmzOi3Bmeq7Tq/7bkAP/ImGtXI7HSVT4RpTY=
X-Received: by 2002:a2e:989a:: with SMTP id b26mr523861ljj.184.1642011269205;
 Wed, 12 Jan 2022 10:14:29 -0800 (PST)
MIME-Version: 1.0
References: <CAJvTdKm9PQrnyEG=b-8DbdnOHup8Ec6VqoKp3ZCQXwmvXU3FbA@mail.gmail.com>
 <0bb2a3b794c19514ad30ecc0ca60d1d6e9e438b0.camel@sipsolutions.net>
 <4c1089474bb5982aee82d58a9d300ca55e7e0c69.camel@intel.com>
 <CAJvTdKmXuzwhV+ExqPAAUTgOFk1dnU+CjnErgUgdfXp=vug_EQ@mail.gmail.com> <f917dd2fca4f4f1227d5848681ec88cdd235d4ad.camel@intel.com>
In-Reply-To: <f917dd2fca4f4f1227d5848681ec88cdd235d4ad.camel@intel.com>
From:   Len Brown <lenb@kernel.org>
Date:   Wed, 12 Jan 2022 13:14:18 -0500
Message-ID: <CAJvTdK=2z9L1j4BA2WKTtfHitj3wYKQwGipwJn5KorEVBbT9ZA@mail.gmail.com>
Subject: Re: iwlwifi 0000:3a:00.0: Microcode SW error detected. Restarting 0x2000000.
To:     "Coelho, Luciano" <luciano.coelho@intel.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "johannes@sipsolutions.net" <johannes@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

for 5.16, the no clean revert, so I'll grab your patch from e-mail shortly.

On Wed, Jan 12, 2022 at 10:42 AM Coelho, Luciano
<luciano.coelho@intel.com> wrote:
>
> On Wed, 2022-01-12 at 09:58 -0500, Len Brown wrote:
> > On Wed, Jan 12, 2022 at 4:05 AM Coelho, Luciano
> > <luciano.coelho@intel.com> wrote:
> >
> > > There was some refactoring in this area, to move the initialization to
> > > the init phase, and that must be causing this.  I suspect this patch:
> > >
> > > commit 78a19d5285d93e281b40c3b8d5a959fbbd2fe006
> > > Author:     Miri Korenblit <miriam.rachel.korenblit@intel.com>
> > > AuthorDate: Thu Aug 5 14:21:56 2021 +0300
> > > Commit:     Luca Coelho <luciano.coelho@intel.com>
> > > CommitDate: Thu Aug 26 23:36:10 2021 +0300
> > >
> > >     iwlwifi: mvm: Read the PPAG and SAR tables at INIT stage
> > >
> > > ...which was introduced in v5.15.
> >
> > good guess!
> > I have confirmed that upstream 5.14 works, and that 5.15 with the
> > commit above reverted works.
>
> Did you have a chance to test the patch I sent? I'm almost sure it
> will, but it would be nice to get a confirmation. :)
>
> --
> Cheers,
> Luca.



-- 
Len Brown, Intel Open Source Technology Center
