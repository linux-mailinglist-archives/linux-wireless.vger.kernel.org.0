Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A120DC1675
	for <lists+linux-wireless@lfdr.de>; Sun, 29 Sep 2019 19:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726198AbfI2RUl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 29 Sep 2019 13:20:41 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:34864 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbfI2RUl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 29 Sep 2019 13:20:41 -0400
Received: by mail-lf1-f67.google.com with SMTP id w6so5295457lfl.2
        for <linux-wireless@vger.kernel.org>; Sun, 29 Sep 2019 10:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XuZfwRpj0slj2H0CJEZsO0qlG9bzSRsoYyMiZVOwgew=;
        b=M2fznb7Q+VqAaO83zrkR0zi9jNndHMkIB0lg5mMlNCKbY2Uq/RtU/5dh9gGyF1eq2e
         NSpLJXoeKUH7RpFZ/Z1nR3a1mGWeRVRZ/DhUeaCznyDmvPqPeE7PxMhzcHLR3PnckH2j
         FksVVfKbvjqSr6vncGbxZAjl0C0z1xccJ7axW6BQOdjhC0XLz5E6eFwA9DS61X+dLZUP
         rKm7dV9jjISwL1fW8p8GEEWg8xiDKr2AEemNz49zoltUeB7TNbSY/5WHrX4FzoB2DTYy
         8peLSG3IsEVDoAA4jcidkcNB1Pd7f/xL3p9YMgUcfe9lP1XLZz8GWTEAtSpxZqNc5MqI
         U+BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XuZfwRpj0slj2H0CJEZsO0qlG9bzSRsoYyMiZVOwgew=;
        b=QXvRr43UmnvVK5zgveXp8rlJnuDzSwxncyclK0OCCf8icfDAct8CifxuMu9IO1FCJw
         PxFtQIXkxh0kSltSpWhxhaCfA/BjU2JaSMbKCp15Af7arn1mRhF7/RF4BjpfKt+00ntU
         6YLM1ZSAa7hnXpoLO1t+WycjMh+Jn9fWFIYjlHhH+s24649+8RJlrylB0SlPyJhLF325
         5Z5QSt8LwuMuC/np+UHwjWpsBCmzz8HGCgJdYSqSiQGV+MQYk6r/nuZ1YXxOxZ26cBth
         VZq3wggNitImZVvcYLDswg+yypwvHSKaqd4+Nv5B95cbzbJgHtIju5odoCc4P9nSbom5
         eWZQ==
X-Gm-Message-State: APjAAAUOL6StbHs8Mm5z8Gzg2nltOA/iDwRv8JkHN6wbIAoC/o37CMbe
        cCNDJSQS/K0gBNZT3dyBgHwxu15fVphtVPpvn2g=
X-Google-Smtp-Source: APXvYqy75Hhl2+J0fq830GxTxA5THtxBqnYAHERITyHEVEVfPkfllcVAT2nte0qd6IuNxnge2LyOr/RuorXB9OK3k/A=
X-Received: by 2002:ac2:551d:: with SMTP id j29mr8495456lfk.7.1569777637514;
 Sun, 29 Sep 2019 10:20:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8U23biuUY9hWE1NOnSbJCRtRVfdg1a27ZOkU5cbaGdzZLYEA@mail.gmail.com>
 <fa029365caf3db963b1c2ec05ae389a8c8fc20fb.camel@sipsolutions.net>
 <CAK8U23aHprXtZm2PV3sj6g4Da_ponK9L0YmSO1tb6xoFgK-ZLA@mail.gmail.com>
 <80d9c12986ec0a13c34672ca1c16f37cae0cc096.camel@sipsolutions.net>
 <CABPxzYLrTC3kS86iyfq+RY=XEgjedu2MWPtn+i+H50jPz3oh3w@mail.gmail.com>
 <39d646206446159a2b0a67ee7d8667483ade0733.camel@sipsolutions.net> <CABPxzYL0i+YbKh-xMXsS-xWeQvwfFUvv7vGhugM1e+OFMOSHSg@mail.gmail.com>
In-Reply-To: <CABPxzYL0i+YbKh-xMXsS-xWeQvwfFUvv7vGhugM1e+OFMOSHSg@mail.gmail.com>
From:   Ramon Fontes <ramonreisfontes@gmail.com>
Date:   Sun, 29 Sep 2019 14:20:25 -0300
Message-ID: <CAK8U23bbiGhmDg-ChDJtbRVVc_6njVdoUjfAhqM+V3yfQXTC4Q@mail.gmail.com>
Subject: Re: mac80211_hwsim (kernel 4.18+): wmediumd + 2.4Ghz
To:     Krishna Chaitanya <chaitanya.mgit@gmail.com>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

> Still doesn't explain why it should work in 4.17 and not in 4.18, there
> aren't a lot of wifi changes there at all.

I just tested it with 4.15 and it didn't work. However, It works in
4.15 in other PC. At first these 2 PCs have the same packages with
apparently the same version. The only thing I can highlight about the
difference between them is that: (i) Ubuntu has been upgraded from
16.04 to 18.04 (it works fine up to 4.17) and (ii) Ubuntu 18.04 has
been installed from scratch (it doesn't work at all - tested from
4.15).

On Fri, Aug 30, 2019 at 5:22 AM Krishna Chaitanya
<chaitanya.mgit@gmail.com> wrote:
>
> On Fri, Aug 30, 2019 at 1:02 PM Johannes Berg <johannes@sipsolutions.net> wrote:
> >
> > On Fri, 2019-08-30 at 00:35 +0530, Krishna Chaitanya wrote:
> > >
> > > Is this supposed to work at all? AFAICS, in hwsim channel matching
> > > checks are only done in non-mediumd path (no_nl), and wmediumd also
> > > doesn't have any checks? So, hostapd responds to all probe requests in all
> > > channels. Am I missing something?
> >
> > Hmm. Interesting observation, I wasn't aware of that.
> >
> > That certainly explains the situation though - on 2.4 GHz we'd prefer
> > using the DS Element, and thus not use the scan result, while on 5 GHz
> > we assume that the reported RX frequency is correct (there's no channel
> > overlap).
> >
> > Still doesn't explain why it should work in 4.17 and not in 4.18, there
> > aren't a lot of wifi changes there at all.
> Yes the git log also doesn't show any changes in this area.
> >
> > I guess we should fix that in hwsim, anyone esle want to? :-)
> I can give it a try to move the channel matching logic to common
> code for both nl and no_nl.
