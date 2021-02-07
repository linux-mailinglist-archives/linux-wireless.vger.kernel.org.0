Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56A3431235F
	for <lists+linux-wireless@lfdr.de>; Sun,  7 Feb 2021 11:09:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbhBGKIK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 7 Feb 2021 05:08:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49894 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229711AbhBGKHw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 7 Feb 2021 05:07:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612692385;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nI3CuNAhEGALCXdE3wTR7z3x3Df42xi1niQl1wqF/K4=;
        b=M558eJ5cknql1cgk0sNg1roINjs6dS25UVmUtc95c2FTxUG/BHK+d027uRZK8inEqQ3yOg
        0WfHGqwUL4KdejynRNbTLiLe4YxRqOFnMEND5EaFKYds7ixC4/V2F7vrM7HuKFpKZRjOeF
        qzJbQ1sbutyc5uLM3l0N3m5ZnH3YyT4=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-427-xrxSqaf4OTWYfu-AJAN-bw-1; Sun, 07 Feb 2021 05:06:24 -0500
X-MC-Unique: xrxSqaf4OTWYfu-AJAN-bw-1
Received: by mail-yb1-f200.google.com with SMTP id q191so13253686ybg.4
        for <linux-wireless@vger.kernel.org>; Sun, 07 Feb 2021 02:06:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nI3CuNAhEGALCXdE3wTR7z3x3Df42xi1niQl1wqF/K4=;
        b=ThkVihyHRpaqu+/Qs5dZWUC8rv1/zgX6y2cUEIUxjxxjgK8bZfruHNF21n66UF2EUF
         vArD1FMjwDcBELdj0w+m9eopM7sYYIyPOPcmx2FIdhHFJ5USIq0Gf8uBuIBGOCLyYDXC
         SL/XpR/UYZW9RJxw29/if+r0MRmxnT6yi3sTBPCr1JdrrX6JQXredy5+w9bkVlDTflzZ
         JRgNIGyZXpt07eqEXlbR++9lWCPvWQExnYFb22l4BfjxdvwTgwYROtUMQ2NuO71+7y0e
         +r92x3m75kvYE3gSapWpQZdN7KqFDugLCeIJwTuDJjKrn7NnzN6D4mcg+/Pn0/LebZ07
         pfdA==
X-Gm-Message-State: AOAM532DuqSwCASVDwU6p+mmqz/aoamvknRlirge1mjto8n9w2FgddM/
        Khami19JTYqDxXzTmfwN7sA1HcAAbrycMf2JHMjK/WgbCjO7coNyEiIxJJFTf/gzWM9TT2k7afs
        6qaUVVVOTgdG9hHVnv+BUAaMQsqR8JHw0aTO6cEpzqbA=
X-Received: by 2002:a25:aad0:: with SMTP id t74mr5995791ybi.107.1612692383796;
        Sun, 07 Feb 2021 02:06:23 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxBmqAhUy2O7xzTlMawk7rbbfe1u4MPWcHYEWQ2AVn3si3UQwS1OeW/o+Mt/cDXjNh8hxtpeXH4wMzSjonA+Cc=
X-Received: by 2002:a25:aad0:: with SMTP id t74mr5995694ybi.107.1612692383612;
 Sun, 07 Feb 2021 02:06:23 -0800 (PST)
MIME-Version: 1.0
References: <20210205163434.14D94C433ED@smtp.codeaurora.org>
 <20210206093537.0bfaf0db@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <20210206194325.GA134674@lore-desk> <87r1ls5svl.fsf@codeaurora.org>
In-Reply-To: <87r1ls5svl.fsf@codeaurora.org>
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Date:   Sun, 7 Feb 2021 11:06:12 +0100
Message-ID: <CAJ0CqmUkyKN_1MxSKejp90ONBtCTrsF1HUGRdh9+xNkdEjcwPg@mail.gmail.com>
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

[...]

>
> So what's the plan? Is there going to be a followup patch? And should
> that also go to v5.11 or can it wait v5.12?
>
> --
> https://patchwork.kernel.org/project/linux-wireless/list/
>
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
>

Hi Kalle,

I will post two followup patches later today. I think the issues are
not harmful but it will be easier to post them to wireless-drivers
tree, agree?

Regards,
Lorenzo

