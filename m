Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4C62CDA2B
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Dec 2020 16:36:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730706AbgLCPey (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 3 Dec 2020 10:34:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726610AbgLCPey (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 3 Dec 2020 10:34:54 -0500
Received: from mail-vk1-xa44.google.com (mail-vk1-xa44.google.com [IPv6:2607:f8b0:4864:20::a44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF99C061A4F
        for <linux-wireless@vger.kernel.org>; Thu,  3 Dec 2020 07:34:08 -0800 (PST)
Received: by mail-vk1-xa44.google.com with SMTP id a129so488937vki.5
        for <linux-wireless@vger.kernel.org>; Thu, 03 Dec 2020 07:34:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h6bUmmhNs5Vo0iuri/gifDqZRZWxy1kGAo1J9lB1K5k=;
        b=D0ie8/h3FBLr6GsJocONE1JbQgocKTLMtMzcvLZ4m0y7cnANQLWYb2PicTVkU3CHWU
         0xhY3CUtX4DW0z+8e0aqlOnA0qQynUINmANChrlAvRpPTKilDW7S8pl1Ya7o5kR9BFVg
         gJdorF74HsyAZkpPn12nGzaqdkO24ic6ate64=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h6bUmmhNs5Vo0iuri/gifDqZRZWxy1kGAo1J9lB1K5k=;
        b=VtZcofZqKiAj3I3BKlbDqfqDaUwQIRI0L8fXkRISrYSgogHOMNv0mFCJqfW1YzT6nZ
         Z038H2W6vBjL3KdqSqJRvV+GwqXzsel+P8Ntxs8ViVVymzqnMYfQKq0I7/QFkMnQ63Pl
         w8VmWxABtBLwj3OCOomI88uzx0lRjlKHgXXWld/1bPYujQevQatdf6uBUZlzFmZfDzct
         NQAWjXnssLopJuWpbdUxuiefPmZcnINS3jPdvLzJ3PmC6fbjRGFAbvoahaLJUG5EzKl5
         PCqeGjamBhjNYw6TApjt57rHKeZdVwp9+XltsYRMskreMYDJ9mNPOeNGwtFvwq1ygGiJ
         mmcw==
X-Gm-Message-State: AOAM5331gDHUIhojLXyTDe4b2Hr+t1/ddMahpwyFp9l2vhUmZI9WLRgb
        Waml8MOiF3PAD/LDGWmCpE37Q9dST4iIng==
X-Google-Smtp-Source: ABdhPJzFLRbFd4lw7DxYO61UanDc38phuIkqUDMvS8gtBO3uJT/0cJIAFl5Nn1ouUb9VU4BHKkw93Q==
X-Received: by 2002:a1f:2d90:: with SMTP id t138mr2249921vkt.23.1607009646859;
        Thu, 03 Dec 2020 07:34:06 -0800 (PST)
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com. [209.85.217.54])
        by smtp.gmail.com with ESMTPSA id b66sm189024vke.8.2020.12.03.07.34.05
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Dec 2020 07:34:05 -0800 (PST)
Received: by mail-vs1-f54.google.com with SMTP id x4so1450454vsp.7
        for <linux-wireless@vger.kernel.org>; Thu, 03 Dec 2020 07:34:05 -0800 (PST)
X-Received: by 2002:a67:8c41:: with SMTP id o62mr2741810vsd.49.1607009645158;
 Thu, 03 Dec 2020 07:34:05 -0800 (PST)
MIME-Version: 1.0
References: <20201112200906.991086-1-kuabhs@chromium.org> <20201112200856.v2.1.Ia526132a366886e3b5cf72433d0d58bb7bb1be0f@changeid>
 <CAD=FV=XKCLgL6Bt+3KfqKByyP5fpwXOh6TNHXAoXkaQJRzjKjQ@mail.gmail.com>
 <002401d6c242$d78f2140$86ad63c0$@codeaurora.org> <CAD=FV=UnecON-M9eZVQePuNpdygN_E9OtLN495Xe1GL_PA94DQ@mail.gmail.com>
 <002d01d6c2dd$4386d880$ca948980$@codeaurora.org> <CAD=FV=WQPMnor3oTefDHd6JP6UmpyBo7UsOJ1Sg4Ly1otxr6hw@mail.gmail.com>
 <004301d6c968$12ef1b10$38cd5130$@codeaurora.org>
In-Reply-To: <004301d6c968$12ef1b10$38cd5130$@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 3 Dec 2020 07:33:52 -0800
X-Gmail-Original-Message-ID: <CAD=FV=VCbjRUxUsmyk=64FLDGU=W41EXh5tdfQr1Lg83T8jiEA@mail.gmail.com>
Message-ID: <CAD=FV=VCbjRUxUsmyk=64FLDGU=W41EXh5tdfQr1Lg83T8jiEA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] ath10k: add option for chip-id based BDF selection
To:     Rakesh Pillai <pillair@codeaurora.org>
Cc:     Abhishek Kumar <kuabhs@chromium.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        LKML <linux-kernel@vger.kernel.org>,
        ath10k <ath10k@lists.infradead.org>,
        Brian Norris <briannorris@chromium.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

On Thu, Dec 3, 2020 at 3:33 AM Rakesh Pillai <pillair@codeaurora.org> wrote:
>
> > What I'm trying to say is this.  Imagine that:
> >
> > a) the device tree has the "variant" property.
> >
> > b) the BRD file has two entries, one for "board-id" (1) and one for
> > "board-id + chip-id" (2).  It doesn't have one for "board-id + chip-id
> > + variant" (3).
> >
> > With your suggestion we'll see the "variant" property in the device
> > tree.  That means we'll search for (1) and (3).  (3) isn't there, so
> > we'll pick (1).  ...but we really should have picked (2), right?
>
> Do we expect board-2.bin to not be populated with the bdf with variant field (if its necessary ?)

The whole fact that there is a fallback to begin with implies that
there can be a mismatch between the board-2.bin and the device tree
file.  Once we accept that there can be a mismatch, it seems good to
try all 3 fallbacks in order.


> Seems fine for me, if we have 2 fallback names if that is needed.

OK, sounds good.  So hopefully Abhishek can post a v3 based on what's
in <https://crrev.com/c/2556437> and you can confirm you're good with
it there?

-Doug
