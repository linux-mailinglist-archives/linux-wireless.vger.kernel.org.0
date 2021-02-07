Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B3C6312422
	for <lists+linux-wireless@lfdr.de>; Sun,  7 Feb 2021 12:55:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbhBGLxv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 7 Feb 2021 06:53:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:25886 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230038AbhBGLxl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 7 Feb 2021 06:53:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612698731;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aaAUCBAcr58sGZ9AaXinrBRzX6dEREqyHriRmijDonc=;
        b=cghm05XOlfvVR8vx8dnOAF5SmqwXhuKvBZhlAEQKPWwjynK44mTOXEzJpsHsOyP9YVh6Wa
        QUxFzKEhZvD5+xfb1ENOcI8DuWzU2YPpEV/KxJmBVf38aM5m3MLNBzBo5HKSEJA+QMadd5
        lupiJqLBVi7XyDMdDvoyezqh44LW6Qg=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-208-bFTp54uxPHGIrfQt5tmn8g-1; Sun, 07 Feb 2021 06:52:09 -0500
X-MC-Unique: bFTp54uxPHGIrfQt5tmn8g-1
Received: by mail-yb1-f199.google.com with SMTP id h192so13310263ybg.23
        for <linux-wireless@vger.kernel.org>; Sun, 07 Feb 2021 03:52:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aaAUCBAcr58sGZ9AaXinrBRzX6dEREqyHriRmijDonc=;
        b=fMaw3cidYZ4hhRGotmDzWY2/wTMFc1dOYBzsvDaugaQvriIqgU8VYVSGyN4iv/D6bS
         6/1looB+m0/tTRfk528KAOSlzQJ7aC9lQ0hl0cdqj5QHoYjXqRf4YQpZP8dUT7++w1o/
         zTfCBgsMTvjZbn+0SLHbqdeDfTkk3w/p2IBuamLgrZQeajisNUnG7LemH0zjUeKekSpW
         8Sq7AoO9lILgvk1nULZPQ98ksDYiQ31NDuaayAguVf67XygQgPyEaS06tSIvLyOqbV1u
         6EkjT61lSeOTV7rP4Y+B0d87zsv7WVTSYOt21limoeRt19Zy07c9PpD2wRY/m9eVBsID
         DaZw==
X-Gm-Message-State: AOAM5330UYcCPsI2D+U2dLClrPzXdJalhCgLkO/ed6zlqHOeVMBVEG/U
        oS7LW/ohZYi/5NFvFkBzuNd0wuIwVD2RwZsiu0zbU5YSiCLM/hbHSw5f0ebsw4Nrg+O4KYW85LZ
        e97q41DoIn8fhsKBkCaTYqcc5mO39pGwGOzJ6Scr9ItM=
X-Received: by 2002:a5b:702:: with SMTP id g2mr5454694ybq.285.1612698729067;
        Sun, 07 Feb 2021 03:52:09 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyTiyeV6aiIPFuN+mpHm4JqIlX95G+eKQuOh/PjvkfC9N2DO4W1jHGf3U24v2SBwyc0oHub2HP2D2M3LsQuZsk=
X-Received: by 2002:a5b:702:: with SMTP id g2mr5454678ybq.285.1612698728848;
 Sun, 07 Feb 2021 03:52:08 -0800 (PST)
MIME-Version: 1.0
References: <20210205163434.14D94C433ED@smtp.codeaurora.org>
 <20210206093537.0bfaf0db@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <20210206194325.GA134674@lore-desk> <87r1ls5svl.fsf@codeaurora.org> <CAJ0CqmUkyKN_1MxSKejp90ONBtCTrsF1HUGRdh9+xNkdEjcwPg@mail.gmail.com>
In-Reply-To: <CAJ0CqmUkyKN_1MxSKejp90ONBtCTrsF1HUGRdh9+xNkdEjcwPg@mail.gmail.com>
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Date:   Sun, 7 Feb 2021 12:51:58 +0100
Message-ID: <CAJ0CqmV2Qc6x_T6xQ1eBWc=9F67OWGUmH+nDLGfjSe7m0vW2bw@mail.gmail.com>
Subject: Re: pull-request: wireless-drivers-2021-02-05
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Felix Fietkau <nbd@nbd.name>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

>
> >
>
> [...]
>
> >
> > So what's the plan? Is there going to be a followup patch? And should
> > that also go to v5.11 or can it wait v5.12?
> >
> > --
> > https://patchwork.kernel.org/project/linux-wireless/list/
> >
> > https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
> >
>
> Hi Kalle,
>

Hi Kalle,

> I will post two followup patches later today. I think the issues are
> not harmful but it will be easier to post them to wireless-drivers
> tree, agree?
>

carefully reviewing the code, I do not think the second one is a real
issue, so I have only posted a fix to address Jakub's comment.

Regards,
Lorenzo


> Regards,
> Lorenzo

