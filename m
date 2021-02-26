Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D37B9326135
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Feb 2021 11:26:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbhBZK0Z (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 26 Feb 2021 05:26:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:23806 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230140AbhBZK0X (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 26 Feb 2021 05:26:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614335096;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GWxapydL5Hv7WpyDHAdOmUhYs2nLQBMtVYpkmlSW5HU=;
        b=jLUg/DSFNZJJowFgazowec7rp/H/RWnixrXvzhql+kciTVLlwDs+kKVziBlbSaaxatlK5l
        5qgLpvm1S/24ZFb+0shSIN8VDDMxzoYkh+/2wcYlzswLFYzJTWgOK3Qlgb6sv2w5lugYrv
        GrVXuf4hAayiT0JBxLx75bpS23xB6Lk=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-510-YomJRXfnPGmqI0-Yu-6Tqw-1; Fri, 26 Feb 2021 05:24:55 -0500
X-MC-Unique: YomJRXfnPGmqI0-Yu-6Tqw-1
Received: by mail-yb1-f198.google.com with SMTP id q77so9657181ybq.0
        for <linux-wireless@vger.kernel.org>; Fri, 26 Feb 2021 02:24:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GWxapydL5Hv7WpyDHAdOmUhYs2nLQBMtVYpkmlSW5HU=;
        b=B2phfUB0WSGWAR38QC/A8l6QiBQ6572HxC0HcLKQoR++cJE6Lm6ZtRe0AFIxdCRBbk
         dIcbCnhS2SVogeivbpITA28p/jC/F21bUzBLnCmhMV2mBtJ5xbba3SHTZPcrvL3iD1Lj
         q8meX0McEVjpPWGWM22nQcS65xYUlbt2tHkf7I7hye+E6Oovhed5e5C5SjKAwchAtdK8
         uyUWCjdhN2u6wTKPwgMD2nGIn+kzU9C0H7PJK2ETBIecmubfKZwoo3Qi9H+ue3K9xLaF
         LUST/Vo3B2p660fwPRFjoqoL75nkl+RTOGqzRzd0BqDAGZ4HX9aaU0da8uNELmWxkOob
         9aFA==
X-Gm-Message-State: AOAM530ymfjfCsEqOnNr171PK4lEjFvpQIGQpPA6WbETWTWJc3CYxl0k
        0t2O28h4Duc9JU0q2H4jG9B1hzXHsPbpGJMHmvyHtngp+Z6Jd1jczGGwzSKNiNrkVVUcmOCaitU
        juqyPovzqnjMViWj4Lu6+MF5ronbzFGiFIjkICaVRi98=
X-Received: by 2002:a25:250e:: with SMTP id l14mr3567100ybl.43.1614335094509;
        Fri, 26 Feb 2021 02:24:54 -0800 (PST)
X-Google-Smtp-Source: ABdhPJymRP+H1LkrH3cpQ/eY6LzCSV36qBKcTDxAm3F7/Akt0BQ2wpfzugRxuU5TXc48/jZl8Wvl4xPVSKlaEHqdYVY=
X-Received: by 2002:a25:250e:: with SMTP id l14mr3567072ybl.43.1614335094195;
 Fri, 26 Feb 2021 02:24:54 -0800 (PST)
MIME-Version: 1.0
References: <a03166fcc8214644333c68674a781836e0f57576.1612697217.git.lorenzo@kernel.org>
 <87mtwfkr6u.fsf@tynnyri.adurom.net> <20210208082516.GB2593@lore-desk>
 <87im735593.fsf@codeaurora.org> <20210208112035.GD2593@lore-desk> <87a6se667c.fsf@codeaurora.org>
In-Reply-To: <87a6se667c.fsf@codeaurora.org>
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Date:   Fri, 26 Feb 2021 11:24:43 +0100
Message-ID: <CAJ0CqmW_rtK0Gvo98VDtG9u730Xpt97kxNzTo61Wzc4KOsw9HQ@mail.gmail.com>
Subject: Re: [PATCH wireless-drivers] mt76: dma: do not report truncated
 frames to mac80211
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Jakub Kicinski <kuba@kernel.org>, Felix Fietkau <nbd@nbd.name>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

>
> Lorenzo Bianconi <lorenzo@kernel.org> writes:
>
> >> Lorenzo Bianconi <lorenzo@kernel.org> writes:
> >>
> >> >> Lorenzo Bianconi <lorenzo@kernel.org> writes:
> >> >>
> >> >> > If the fragment is discarded in mt76_add_fragment() since shared_info
> >> >> > frag array is full, discard truncated frames and do not forward them to
> >> >> > mac80211.
> >> >> >
> >> >> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> >> >>
> >> >> Should there be a Fixes line? I can add it.
> >> >
> >> > I am not sure it needs a Fixes tag.
> >>
> >> I think the commit log should have some kind of description about the
> >> background of the issue, for example if this is a recent regression or
> >> has been there forever etc.
> >
> > Agree. Can you please check the commit log below?
> >
> > "
> > Commit 'b102f0c522cf6 ("mt76: fix array overflow on receiving too many
> > fragments for a packet")' fixes a possible OOB access but it introduces a
> > memory leak since the pending frame is not released to page_frag_cache if
> > the frag array of skb_shared_info is full.
> > Commit '93a1d4791c10 ("mt76: dma: fix a possible memory leak in
> > mt76_add_fragment()")' fixes the issue but does not free the truncated skb that
> > is forwarded to mac80211 layer. Fix the leftover issue discarding even truncated
> > skbs.
> > "
>
> Looks good, but I think the recommended style for commit ids is not to
> use ' chararacter. So I would change it to this:
>
> ----------------------------------------------------------------------
> Commit b102f0c522cf6 ("mt76: fix array overflow on receiving too many
> fragments for a packet") fixes a possible OOB access but it introduces a
> memory leak since the pending frame is not released to page_frag_cache
> if the frag array of skb_shared_info is full. Commit 93a1d4791c10
> ("mt76: dma: fix a possible memory leak in mt76_add_fragment()") fixes
> the issue but does not free the truncated skb that is forwarded to
> mac80211 layer. Fix the leftover issue discarding even truncated skbs.
> ----------------------------------------------------------------------
>
> Should I add that to the commit log and queue the patch to be applied
> after the merge window opens?
>
> --
> https://patchwork.kernel.org/project/linux-wireless/list/
>
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
>

Hi Kalle,

any news about this patch?

Regards,
Lorenzo

