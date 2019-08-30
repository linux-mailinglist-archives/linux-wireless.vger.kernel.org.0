Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58160A320C
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Aug 2019 10:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727620AbfH3IWM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 30 Aug 2019 04:22:12 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:35718 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbfH3IWM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 30 Aug 2019 04:22:12 -0400
Received: by mail-io1-f65.google.com with SMTP id b10so12435603ioj.2
        for <linux-wireless@vger.kernel.org>; Fri, 30 Aug 2019 01:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qq6EAlFKMJcuMERrqHY66EaQdSKnkQVIcIy9zFhZOFE=;
        b=OC1s1opO7bpKYXP52a8jaiIoDssAce2v2FhJ1on2Jcpl/xWfNggBYSm9h57VhXRBcd
         QQ5b8Ib0wU9ezgQmnPtYF0BhkyMKoBQtntKGPoUjBoGUDnQ04LvhXBNy44/hqz0qRPAd
         N+qxNZ3wiab0PbyliPSjNxemKuAh5/KcNLzdCg9kH7xcOzUMVv52junEbuuthYX47n1j
         HmKr9n83P8Ha9mQ6ASUTyPVmB2ZfLk1TPN4vgL7bsoYb0CzDizhuBaTblM/XfSTzZQRY
         DGTr5YZL6Wz5zhMCOP8LgVEPEnVdTQrnXxdGFxQm4y2rT0qN/4vzwwgWvkdsAghRCOlO
         ttmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qq6EAlFKMJcuMERrqHY66EaQdSKnkQVIcIy9zFhZOFE=;
        b=jefDKqBrOJnbzSo3jNmjMlXDOq2q5g7BubcDEkBwxfjP77M4ciR+aLTGoxZg/mPUlD
         INjnfPlb6s1x90vjBEX1ZyGzqassG1kvGLzdnxydN6v0LDsh5PG8RzMrwgHSFqbd75j4
         jwsQSqnI37WYCAFAAGfUR3ngzkGd3h3uqLczGdQjElChnLVW+1kSQshEqAqexBKXBxbu
         V0pQlBPeTMDM15guLnSIzcqU0rKunjJWv28saA+y692NjO9Ldnr31ycM0cbVAo/b+JwL
         5YS4aExfOyA52XoEQOhEAp84hKS9pXoWilp/mE7W8lXnKUEPYDZGkNGPiLznlpKD6Lua
         DRXg==
X-Gm-Message-State: APjAAAWLHEXuYtzvmjVwJfTAPUuGD+A+c6XyIhw5y2mnvKq4iPF3HX3n
        jaWZSa/arO0mDCd6UHHCP4Vsf2UuRWzzaQNHKIPR/Flb
X-Google-Smtp-Source: APXvYqwxhmbivhOI3ys9QkWM0bcchhtBEjeM76xb2AChMYEB1DH84dtMpESfdWDYUYMUBacij3Oas0vl7ZfmggOjcgQ=
X-Received: by 2002:a5d:91c8:: with SMTP id k8mr945616ior.232.1567153331057;
 Fri, 30 Aug 2019 01:22:11 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8U23biuUY9hWE1NOnSbJCRtRVfdg1a27ZOkU5cbaGdzZLYEA@mail.gmail.com>
 <fa029365caf3db963b1c2ec05ae389a8c8fc20fb.camel@sipsolutions.net>
 <CAK8U23aHprXtZm2PV3sj6g4Da_ponK9L0YmSO1tb6xoFgK-ZLA@mail.gmail.com>
 <80d9c12986ec0a13c34672ca1c16f37cae0cc096.camel@sipsolutions.net>
 <CABPxzYLrTC3kS86iyfq+RY=XEgjedu2MWPtn+i+H50jPz3oh3w@mail.gmail.com> <39d646206446159a2b0a67ee7d8667483ade0733.camel@sipsolutions.net>
In-Reply-To: <39d646206446159a2b0a67ee7d8667483ade0733.camel@sipsolutions.net>
From:   Krishna Chaitanya <chaitanya.mgit@gmail.com>
Date:   Fri, 30 Aug 2019 13:51:59 +0530
Message-ID: <CABPxzYL0i+YbKh-xMXsS-xWeQvwfFUvv7vGhugM1e+OFMOSHSg@mail.gmail.com>
Subject: Re: mac80211_hwsim (kernel 4.18+): wmediumd + 2.4Ghz
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Ramon Fontes <ramonreisfontes@gmail.com>,
        linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Aug 30, 2019 at 1:02 PM Johannes Berg <johannes@sipsolutions.net> wrote:
>
> On Fri, 2019-08-30 at 00:35 +0530, Krishna Chaitanya wrote:
> >
> > Is this supposed to work at all? AFAICS, in hwsim channel matching
> > checks are only done in non-mediumd path (no_nl), and wmediumd also
> > doesn't have any checks? So, hostapd responds to all probe requests in all
> > channels. Am I missing something?
>
> Hmm. Interesting observation, I wasn't aware of that.
>
> That certainly explains the situation though - on 2.4 GHz we'd prefer
> using the DS Element, and thus not use the scan result, while on 5 GHz
> we assume that the reported RX frequency is correct (there's no channel
> overlap).
>
> Still doesn't explain why it should work in 4.17 and not in 4.18, there
> aren't a lot of wifi changes there at all.
Yes the git log also doesn't show any changes in this area.
>
> I guess we should fix that in hwsim, anyone esle want to? :-)
I can give it a try to move the channel matching logic to common
code for both nl and no_nl.
