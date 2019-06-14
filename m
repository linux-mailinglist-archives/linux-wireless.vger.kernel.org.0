Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EAA0E464D8
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Jun 2019 18:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbfFNQqM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Jun 2019 12:46:12 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:42573 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbfFNQqM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Jun 2019 12:46:12 -0400
Received: by mail-vs1-f66.google.com with SMTP id 190so2161546vsf.9
        for <linux-wireless@vger.kernel.org>; Fri, 14 Jun 2019 09:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TdEh8Hj2Clq+kDMcSVX4CedsJJo6mgn0qth+pnhpxfk=;
        b=MPl9AGMjmoNFxoC+q/LqmrAuv03V+OnvpDb1T2jOEFfQr1ybdUYboQYZPsQk7BPBH5
         wpwjgQmzEr+uSKzyd5eykA2lnqJFEWo4AqFqsNv+kwS/HoGFi3WWX5tU1iHIzcRPsiF5
         ERXHdmkt3SQzDx2AtHIxbcJeIEQ0DyJvFUU/U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TdEh8Hj2Clq+kDMcSVX4CedsJJo6mgn0qth+pnhpxfk=;
        b=MHSpKeeDhE9wB6PC9Udzp23J8n5HwDHqj3uwnnPC2oOe4q5oImjHiDYxh9WvUz9vTd
         mT/K5ezoSx/q060jkJMrZIm+BxuDNQZ8eJCxeL/6DbdVv7LsmG4mEMUzA2Ql1Fq+Vcxt
         ZUvVb13nvfQqeEaqL0r9R9ZZtfMjwEEJQKUlSoydN2JZx+45YiKyMjzCik9j7GEyIewu
         W6/4caKfFUcjCKUVn9GbkDZm4njjdqrj0444t3joG3sDbyJLHNWuoc5SbdxKfiVEW+AB
         avjdcs7T8aPB/ka7bdVzl42w8JLbWQ17ykGVaZryOsINWpKsYwFy+PSo0zbgrE98+MJi
         FD0Q==
X-Gm-Message-State: APjAAAXxczKTgA2G59V1tFxuiVK2cZxc3EYsZb6/Q4YhpioJVlB7I+MW
        AvMBMT/kpFbkx+sGByqa1Jbsuw8Wzsg=
X-Google-Smtp-Source: APXvYqywkD8AbJNDmpLs+Lz4VlTA7yCYdSdIeUrDgTWEwvqnwikPfY+arW0S5A/4eA8tTFB39z+j7g==
X-Received: by 2002:a67:ca0a:: with SMTP id z10mr37905279vsk.94.1560530770933;
        Fri, 14 Jun 2019 09:46:10 -0700 (PDT)
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com. [209.85.222.53])
        by smtp.gmail.com with ESMTPSA id e125sm970094vsc.28.2019.06.14.09.46.10
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Jun 2019 09:46:10 -0700 (PDT)
Received: by mail-ua1-f53.google.com with SMTP id s4so1174842uad.7
        for <linux-wireless@vger.kernel.org>; Fri, 14 Jun 2019 09:46:10 -0700 (PDT)
X-Received: by 2002:ab0:2a49:: with SMTP id p9mr2181727uar.0.1560530327904;
 Fri, 14 Jun 2019 09:38:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190613234153.59309-1-dianders@chromium.org> <20190613234153.59309-5-dianders@chromium.org>
 <CAPDyKFrJ4+zn7Ak0tYHkBfXUtH3N7erb5R7Q+hgugchZmCRGrw@mail.gmail.com>
In-Reply-To: <CAPDyKFrJ4+zn7Ak0tYHkBfXUtH3N7erb5R7Q+hgugchZmCRGrw@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 14 Jun 2019 09:38:26 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Wuj=gANR2im_o4ZnoLEB+U6FqzKe4noLdQyi1vw+K2xw@mail.gmail.com>
Message-ID: <CAD=FV=Wuj=gANR2im_o4ZnoLEB+U6FqzKe4noLdQyi1vw+K2xw@mail.gmail.com>
Subject: Re: [PATCH v4 4/5] mmc: core: Add sdio_retune_hold_now() and sdio_retune_release()
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        brcm80211-dev-list.pdl@broadcom.com,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Double Lo <double.lo@cypress.com>,
        Brian Norris <briannorris@chromium.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Naveen Gupta <naveen.gupta@cypress.com>,
        Madhan Mohan R <madhanmohan.r@cypress.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Wright Feng <wright.feng@cypress.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        netdev <netdev@vger.kernel.org>,
        brcm80211-dev-list <brcm80211-dev-list@cypress.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Avri Altman <avri.altman@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

On Fri, Jun 14, 2019 at 5:10 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Fri, 14 Jun 2019 at 01:42, Douglas Anderson <dianders@chromium.org> wrote:
> >
> > We want SDIO drivers to be able to temporarily stop retuning when the
> > driver knows that the SDIO card is not in a state where retuning will
> > work (maybe because the card is asleep).  We'll move the relevant
> > functions to a place where drivers can call them.
> >
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
>
> This looks good to me.
>
> BTW, seems like this series is best funneled via my mmc tree, no? In
> such case, I need acks for the brcmfmac driver patches.

For patch #1 I think it could just go in directly to the wireless
tree.  It should be fine to land the rest of the patches separately.

For patch #2 - #5 then what you say makes sense to me.  I suppose
you'd want at least a Reviewed-by from Arend and an Ack from Kalle on
the Broadcom patches?

I'd also suggest that we Cc stable explicitly when applying.  That's
easy for #2 and #3 since they have a Fixes tag.  For #4 and #5 I guess
the question is how far back to go.  Maybe Adrian has an opinion here
since I think he's the one who experienced these problems.


Thanks!
-Doug
