Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 724522427A0
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Aug 2020 11:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbgHLJc2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Aug 2020 05:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726971AbgHLJc2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Aug 2020 05:32:28 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5827EC06174A
        for <linux-wireless@vger.kernel.org>; Wed, 12 Aug 2020 02:32:28 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id t13so1028211ile.9
        for <linux-wireless@vger.kernel.org>; Wed, 12 Aug 2020 02:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xj/ubkdJERhQPvDwlfvptcYbp5gMyLZDCpjDc4VbvFY=;
        b=WCSwOJMX6FOHgDkuvLbRuUheMGEKE9xROE6dE+dUHGVf9pyq6pY3Dl8A4e7Q2RTdbs
         e7YHBzIdzdIutyq3NVnOdZuJl1Yw3hNijaRD8rM0gFHZQa/XLy57bh+qM+El02uzWSdV
         R4IrdUOC0XTH+7+vTGU47eRGE/4zenvv4rmI80Ju1atxTvALbTLUIZsI2tEt2YEiPpwC
         3nngrSfSqY72bCYXYNZkihWQ9aRqhQO02YpIOeVwBkaUkmfnYCvWAoEGhKaiOGABvMzB
         AU865AJthaqR80q160W91W7ME2XDAwfA+FI2a2ib78vJo7NURiwUzUvFvWI0yUwJRb2t
         C40A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xj/ubkdJERhQPvDwlfvptcYbp5gMyLZDCpjDc4VbvFY=;
        b=Kp3KkMZAD1WCxGlvMwq5AyVrggSTuLwHmjZy9T7CUDxYJ76XhbrBm5XMOhr/ap9DXA
         ftOt5vc0pat2lK7irRzvxET8peD1RHYnMKJ8pih71+3tDCKQvzjqBLae9WxrA0iBB6Fz
         9C/dV/Rw+AMy9h/MUTxqrQWskGOA9PSm2AgEd1jhrHXALAqGtuYjrXsXt3JakGIIuLhi
         4GOzufOvrJw9uiIGpAYtAzYhPL19BHGG5ByJbD8x/b9CtO0peUa5pSbNT+FjdMdRkqzi
         r/1gB6otG8+AJ7yzLvrPIzWtGxZLpMqqf1Ibn1cEJEY1kGfNFnxROJ+gcnV+601abXbr
         9D/w==
X-Gm-Message-State: AOAM533OeYts1A7Ru5o3zHOEm5WokTLy1l/35rd9wKtz5oPviM3L7bbo
        y3Ps/TiWp1tf8/nqY38mTXnoty3N8oJl+H1Pf5M=
X-Google-Smtp-Source: ABdhPJzdh3wJ7jfIQSQEpXZn8uON6MzQ7OTMnG3pHVMAKtR1IVR9/mnCxgnnbcRynaMyNEzA4JAtWi0EEXfprhX9dQQ=
X-Received: by 2002:a92:ba17:: with SMTP id o23mr27694871ili.198.1597224747521;
 Wed, 12 Aug 2020 02:32:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200810090126.mtu3uocpcjg5se5e@pali> <20200812083600.6zxdf5pfktdzggd6@pali>
 <87lfik1av8.fsf@toke.dk> <20200812092334.GA17878@w1.fi>
In-Reply-To: <20200812092334.GA17878@w1.fi>
From:   =?UTF-8?Q?Micha=C5=82_Kazior?= <kazikcz@gmail.com>
Date:   Wed, 12 Aug 2020 11:32:16 +0200
Message-ID: <CABvG-CVvPF++0vuGzCrBj8+s=Bcx1GwWfiW1_Somu_GVncTAcQ@mail.gmail.com>
Subject: Re: CVE-2020-3702: Firmware updates for ath9k and ath10k chips
To:     Jouni Malinen <j@w1.fi>
Cc:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        ath10k@lists.infradead.org, ath9k-devel@qca.qualcomm.com,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Kalle Valo <kvalo@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 12 Aug 2020 at 11:26, Jouni Malinen <j@w1.fi> wrote:
>
> On Wed, Aug 12, 2020 at 11:17:47AM +0200, Toke H=C3=B8iland-J=C3=B8rgense=
n wrote:
> > Pali Roh=C3=A1r <pali@kernel.org> writes:
> > > Could somebody react and provide some details when fixes would be
> > > available for ath9k and ath10k Linux drivers? And what is current sta=
te
> > > of this issue for Linux?
> > >
> > > I'm looking at ath9k and ath10k git trees [1] [2] [3] and I do not se=
e
> > > there any change which could be related to CVE-2020-3702.
> >
> > How about these, from March:
> >
> > a0761a301746 ("mac80211: drop data frames without key on encrypted link=
s")
> > ce2e1ca70307 ("mac80211: Check port authorization in the ieee80211_tx_d=
equeue() case")
> > b16798f5b907 ("mac80211: mark station unauthorized before key removal")
>
> Those cover most of the identified issues for drivers using mac80211
> (e.g., ath9k and ath10k; though, I don't remember whether I actually
> ever managed to reproduce this with ath10k in practice). I have couple
> of additional ath9k-specific patches that cover additional lower layer
> paths for this. I hope to get those out after confirming they work with
> the current kernel tree snapshot.

As far as I understand the problem can manifest on partial in-hw ampdu
retransmits if a key was removed in between. Not exactly an easy thing
to reproduce. The actual drivers (ath9k, ath10k) or their microcodes
may need to be fixed as well since mac80211 can only do so much.


Michal
