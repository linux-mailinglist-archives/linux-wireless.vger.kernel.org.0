Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3324C24C4
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Sep 2019 18:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732157AbfI3P7o (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 30 Sep 2019 11:59:44 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:36322 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731790AbfI3P7o (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 30 Sep 2019 11:59:44 -0400
Received: by mail-io1-f65.google.com with SMTP id b136so39663449iof.3
        for <linux-wireless@vger.kernel.org>; Mon, 30 Sep 2019 08:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hQWHchROlDrEeVJoMKAGXj3Nv1kqYbGMdT5gxvIirYI=;
        b=slCvcLRZ2yW57IBbF3wnF6/3FeLHod2lHfPQ7GzFmGpmirdCKFyJO3sO4y3R6Zi8L8
         7lh0Op5OBHdLE23c/ZyTvAhazAvashHf+NIY7CvwvqqhFpxbQ085xzO72MjSyygE7syq
         wFxsi7/ISrCJ4XoE5+IG+gNrUOTh5wJc/r067GQoNMqAIbX+L3plWYrq75+lmAbkShsF
         oKYEzQXqxVQOO0PFi/RUQ+8E0aFESpzkOCWO6NajlNUj6CEhUX2NhE2xxDR56xhCG79v
         +ScJm3UiwdIvyxndRi1SHbqg8H1WVc/Mri3GEZmfzheZu2069LcNw25sL+U71EjOTjaz
         QmOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hQWHchROlDrEeVJoMKAGXj3Nv1kqYbGMdT5gxvIirYI=;
        b=bNoGOoX9lSeg3m4xslIOAsghV2T7F411SdyqXv7SIwfPpC79TtxEPU5rF1cQwSnhTi
         AsoLbr3kt7sLgFMmWE7HqkHT67iTiUCZJ82l6Gg/VfU7clE+/JG+umpZAYQEvOjD8FuF
         6UyvjhSAbPHEQdJdiYAMhJO2mUjDg6+ZJGNjSzc/bHlEZ/7cTyl7wR5GEN+YPS//APmT
         bd8SHJT36nSpUdBRa2d47UnDzSKb1peC0elU4srQzHTvMpUSuag2vSzWw06qWIMNcRnd
         IWppJN9cnhwffGgFZd5ev0gBipSMfk64KGT6p43ge7H1sLmfTheK/H36r0NroFu+2m6y
         RvVQ==
X-Gm-Message-State: APjAAAVaz9wJUDE/xzg8+Kn+IHuTv7E0EVn+ITQY+G1iwlnwuzjngcMZ
        Th2x242IqM3cN4l+vfLtaIPNpGK0b2PXTNInQW32LQ==
X-Google-Smtp-Source: APXvYqypiyMJ7KYji9i2guB4Nq0aNqEEWGihtQTIClKiWuM3aI1iA4mRFFgqn+PLQu0wfUFEdpu3OZsW3rOHKrb77CA=
X-Received: by 2002:a92:98d3:: with SMTP id a80mr20960972ill.194.1569859183561;
 Mon, 30 Sep 2019 08:59:43 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8U23biuUY9hWE1NOnSbJCRtRVfdg1a27ZOkU5cbaGdzZLYEA@mail.gmail.com>
 <fa029365caf3db963b1c2ec05ae389a8c8fc20fb.camel@sipsolutions.net>
 <CAK8U23aHprXtZm2PV3sj6g4Da_ponK9L0YmSO1tb6xoFgK-ZLA@mail.gmail.com>
 <80d9c12986ec0a13c34672ca1c16f37cae0cc096.camel@sipsolutions.net>
 <CABPxzYLrTC3kS86iyfq+RY=XEgjedu2MWPtn+i+H50jPz3oh3w@mail.gmail.com>
 <39d646206446159a2b0a67ee7d8667483ade0733.camel@sipsolutions.net>
 <CABPxzYL0i+YbKh-xMXsS-xWeQvwfFUvv7vGhugM1e+OFMOSHSg@mail.gmail.com> <CAK8U23bbiGhmDg-ChDJtbRVVc_6njVdoUjfAhqM+V3yfQXTC4Q@mail.gmail.com>
In-Reply-To: <CAK8U23bbiGhmDg-ChDJtbRVVc_6njVdoUjfAhqM+V3yfQXTC4Q@mail.gmail.com>
From:   Krishna Chaitanya <chaitanya.mgit@gmail.com>
Date:   Mon, 30 Sep 2019 21:29:31 +0530
Message-ID: <CABPxzY+8Jjvjv0x79yzo+rL3nONTZSkROK1T+gMqq5nhXb=7-g@mail.gmail.com>
Subject: Re: mac80211_hwsim (kernel 4.18+): wmediumd + 2.4Ghz
To:     Ramon Fontes <ramonreisfontes@gmail.com>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sun, Sep 29, 2019 at 10:50 PM Ramon Fontes <ramonreisfontes@gmail.com> wrote:
>
> > Still doesn't explain why it should work in 4.17 and not in 4.18, there
> > aren't a lot of wifi changes there at all.
>
> I just tested it with 4.15 and it didn't work. However, It works in
> 4.15 in other PC. At first these 2 PCs have the same packages with
> apparently the same version. The only thing I can highlight about the
> difference between them is that: (i) Ubuntu has been upgraded from
> 16.04 to 18.04 (it works fine up to 4.17) and (ii) Ubuntu 18.04 has
> been installed from scratch (it doesn't work at all - tested from
> 4.15).

Based on this info, looks like hostapd/wpa_s versions might be causing
the difference,
can you please confirm the versions on both?
