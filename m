Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6B9C1227D8
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Dec 2019 10:44:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbfLQJoh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Dec 2019 04:44:37 -0500
Received: from mail-ot1-f44.google.com ([209.85.210.44]:33543 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbfLQJoh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Dec 2019 04:44:37 -0500
Received: by mail-ot1-f44.google.com with SMTP id b18so4466080otp.0
        for <linux-wireless@vger.kernel.org>; Tue, 17 Dec 2019 01:44:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g/qguDxvFvzNBOwL2qfRDxQL/6VOarJET/K2+iott5s=;
        b=UQfRfMgq8D0QlABiXc2ewcwqzUvCsRUvyxJdjm2CctkT+sDwKKWMa3qG08AalaXPgD
         Csgl4eI0NU6m26EPFsaePe5aVYVS6gRxusx7H5PO0OEWOLhwRgc1n7pvoWFuAazFPdY4
         bXgB0DlBtRaYq0qPybDMSXPO6bfn+AJ0jfwfMdMvP7Bz+puLiy1jumH52m/vpSNkwBvF
         JGRbu3GtXUz6moeFd924PnXknqfLfU4MxOxB93r4dK1Re8D1eF6H8KAsQND/ivLMfUMp
         NiA1uk5R403ftawwXqyKXX907NJaB1frtlcNH/Mi7Xj7khnmPXcunA8CqyStWgELOyrC
         wprA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g/qguDxvFvzNBOwL2qfRDxQL/6VOarJET/K2+iott5s=;
        b=c9Za6eXwEtI7dTfNqTjnWmTZQRWgqUyUcGEhECD7fr5JbQ9565UAOdkEuFX1mLwj6D
         /YkDZUmbCuXHPmyko0kgLxB5C7xyYC9mWdrjA2N01GhTv7xBP0udq9SXFQidm4KIj2/R
         wHCanW7IoxcwxbHzClT4z8ceJU/6T/gd82UU4MEDDwxqe+qCdfwPMwivGxoRhHiXVVsq
         Z+mBKA0wq/Hz7XyUcwFP+OmIIGFJeTEIxWU6KlHkcWGuWZGat79vfMt6Gi/wbO+N+V1j
         XJASrTND1KvVlepI4gb5o9fVITnmMyR/FfVu5iT3R/ef0d6f2L+F9ZS9q8Ns7pI50HFm
         QAAw==
X-Gm-Message-State: APjAAAUfeNn/OKfSrUk0m2GsKj/JkI4RaVjymuBkqJrOTQR6Wlf6V7OH
        Xury4REMes3zyuFd6TwT2ZAS79GSiJLRbbRZecQ4PSRmylKGYg==
X-Google-Smtp-Source: APXvYqytlXHwuACxkh5UdzTMIAWvy7fhbrLaSLD1SELEmdNEgEmMXZgiWk4WZ4bZf7jmor5Og2xs0jvKH0fTyvnwDTs=
X-Received: by 2002:a9d:6c81:: with SMTP id c1mr37633129otr.39.1576575876661;
 Tue, 17 Dec 2019 01:44:36 -0800 (PST)
MIME-Version: 1.0
References: <20191213230334.27631-1-greearb@candelatech.com> <9ff2afcfb6590e92d8e73656e657414ec2c71b3d.camel@sipsolutions.net>
In-Reply-To: <9ff2afcfb6590e92d8e73656e657414ec2c71b3d.camel@sipsolutions.net>
From:   Justin Capella <justincapella@gmail.com>
Date:   Tue, 17 Dec 2019 01:44:24 -0800
Message-ID: <CAMrEMU8hXeqA__0smnKc502-ZpXKpQV4wTqygMvcQ9h=4CRyBQ@mail.gmail.com>
Subject: Re: [RFC] mac80211: Fix setting txpower to zero.
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Ben Greear <greearb@candelatech.com>,
        linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

So this may be silly to point out but I noticed the value is
multiplied by 2 later in txpower setup, which introduces the
possibility that of overflow/wrapping. min(power_limit, int_min) would
maybe run into trouble there.

Since the behavior is to assume 2/5g tx power, I think it would be
nice to set to those values (limits), then it would display sanely.
But I don't have a good grasp on this stuff, I imagine regdom plays a
role someplace too

On Mon, Dec 16, 2019 at 11:58 PM Johannes Berg
<johannes@sipsolutions.net> wrote:
>
> On Fri, 2019-12-13 at 15:03 -0800, greearb@candelatech.com wrote:
> >
> > So, instead initialize the txpower to -1 in mac80211, and let drivers know that
> > means the power has not been set and so should be ignored.
>
> Technically (or maybe just physically?), even -1 is a sort of valid TX
> power.
>
> I know all of this is pretty messed up, but wouldn't it make more sense
> to go with some kind of tx_power_valid bit, or perhaps something that
> certainly will never make sense like MIN_INT instead of -1?
>
> johannes
>
