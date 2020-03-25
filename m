Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6634219302E
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2020 19:15:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727439AbgCYSPG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 25 Mar 2020 14:15:06 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39456 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727279AbgCYSPG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 25 Mar 2020 14:15:06 -0400
Received: by mail-lj1-f195.google.com with SMTP id i20so3557525ljn.6
        for <linux-wireless@vger.kernel.org>; Wed, 25 Mar 2020 11:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CN/jGkDFewEhK4kLuF7IJJzT1GvrV70P1Bm6K0ng+Yc=;
        b=geD7Cjf6W8588DDu7mcqREkoLQmxAdGk0uB2KBv2XSkiR0n9FjIa5RRyNZtt1kPPVx
         xQYRVuOwVsiDazXCpkjvZPi9Z6KJC2y92qt9+0/ola5PMVhMiFfChEmTcyO+8XT2Ad6S
         a70UjcT3JlMj7/9MYGZmdg0pQZzm96vBpcWVs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CN/jGkDFewEhK4kLuF7IJJzT1GvrV70P1Bm6K0ng+Yc=;
        b=E4emyXP9oTcChAhzIfPtY6CZGtFFtcziGfKDb4o0R6T9vNUZlPmRAad+9rOe16rmng
         9elKpZ6CIlTamZuWEbGzvcJ4ju3ztmt4vpCqxEZxkwoeWH1VSDG3UYrpMmsu4pdwVjnl
         eMdOGKVKAybf3FptRvincpOCdjvxWYy2ZOAhN8S2NZKB1JnB+aaJhGrriqdMvTabvW6A
         Ie5WclqwRw02I4r+VAmN37DwlewIOJatnNEdXDEwZR0dwJWWk1K8ELC98Nsm/7LnksQJ
         wjMbLzgBM3Cw3mc4T8WF4GJQqNm58t0cym/J8sjplaPnDAjPQaD9Izf7mQef9Cwx3EOu
         dbUA==
X-Gm-Message-State: ANhLgQ3xujY9OS/YMn0up20cvL8bxiDVv/PVW9Y5liAvhy48Af/J//SO
        UNuXvLELd9gxcX++WT2+UMJq3N4yH3I=
X-Google-Smtp-Source: APiQypLxcH47bMYOgGbPsQvuAvH+nHgYlBGJzxdTTndv9xSVXPGI5R/W/wErVg5tIb6CNJE/j5HzDw==
X-Received: by 2002:a2e:9099:: with SMTP id l25mr2829921ljg.157.1585160102451;
        Wed, 25 Mar 2020 11:15:02 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id q8sm5456718ljj.77.2020.03.25.11.15.00
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Mar 2020 11:15:01 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id g12so3579585ljj.3
        for <linux-wireless@vger.kernel.org>; Wed, 25 Mar 2020 11:15:00 -0700 (PDT)
X-Received: by 2002:a05:651c:50e:: with SMTP id o14mr2672414ljp.241.1585160100264;
 Wed, 25 Mar 2020 11:15:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200313065114.23433-1-yhchuang@realtek.com> <87eetwo87q.fsf@kamboji.qca.qualcomm.com>
 <2e492e530d744713871f885e324106ef@realtek.com> <87eetrlanb.fsf@kamboji.qca.qualcomm.com>
 <ce990869ebf0478d98cd7e8416b36289@realtek.com> <875zf3kn05.fsf@kamboji.qca.qualcomm.com>
 <f4e7401c-c86b-8b2f-9e93-865322f71945@candelatech.com> <fbab3328d183406c923b30381389841f@realtek.com>
 <d45e2002e97c28acc1f9c7b9c41b5a3ba1d69452.camel@sipsolutions.net>
 <CA+ASDXM5tSmeE72+fn5K2vgR6kPE3OUbHJ_T_DVV63rFrPzv2w@mail.gmail.com>
 <3894907ca6bf4566b8716731492a869b@realtek.com> <CA+ASDXMi8BqccHdVXVXb0JOj4y0vcFBGdL6BB0YuzB78qzgQuQ@mail.gmail.com>
 <efa8c2f3-8254-8d36-20ec-9afb8ffb2339@candelatech.com>
In-Reply-To: <efa8c2f3-8254-8d36-20ec-9afb8ffb2339@candelatech.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Wed, 25 Mar 2020 11:14:48 -0700
X-Gmail-Original-Message-ID: <CA+ASDXNQxea+83+h87OQwDV-n_Sb8ENyEGx=BsJbMa3G9kkEVQ@mail.gmail.com>
Message-ID: <CA+ASDXNQxea+83+h87OQwDV-n_Sb8ENyEGx=BsJbMa3G9kkEVQ@mail.gmail.com>
Subject: Re: [PATCH] rtw88: add debugfs to fix tx rate
To:     Ben Greear <greearb@candelatech.com>
Cc:     Tony Chuang <yhchuang@realtek.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Kalle Valo <kvalo@codeaurora.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Mar 25, 2020 at 8:52 AM Ben Greear <greearb@candelatech.com> wrote:
> On 03/24/2020 10:16 PM, Brian Norris wrote:
> > Sure, but if you mask out all but 1 bitrate...voila! A fixed rate!
>
> So, see this thread from a while back.  Has anyone even *tried* to use
> this API you are proposing?

Yes, in fact, I have! Which is why I noted:

> > Now, there are other problems, like the others that Ben mentioned: the
> > rest of the mac80211 framework doesn't like it too much if you really
> > disable all but 1 rate (arguably a mac80211 bug -- but not a nl80211
> > bug)

> http://lists.infradead.org/pipermail/ath10k/2017-October/010291.html

I hadn't seen that thread. So it sounds like maybe Johannes isn't
quite on the same page as Johannes ;)

If we're going to be particular about matching the AP's basic rates,
then this API is indeed probably not useful for the "single fixed rate
[for debugging/testing]" use case.

>      mac80211: Revert some of e8e4f5, fixes setting single rate in ath10k.

Commit e8e4f5 was an unfortunate consequence of the stuff I mentioned
earlier about how Chrome OS used to use SET_TX_BITRATE_MAX -- we
weren't nuanced about it at all, so we might configure a set of
bitrates that doesn't intersect at all with the AP's BasicRates. That
does make it hard for the driver/framework to decide what to do: do we
listen to the user, or to the AP? Incidentally, that's also one reason
why Chrome OS no longer uses the API; it was too big of a hammer for
what we want (initial-connection reliability), and required us to be
more delicate about {Supported,Basic}Rates than we really wanted to.

Brian
