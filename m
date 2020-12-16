Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F41C2DC7EE
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Dec 2020 21:50:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729032AbgLPUtI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 16 Dec 2020 15:49:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38003 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726979AbgLPUtI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 16 Dec 2020 15:49:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608151662;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mHJsL1L4MctILcbkxLdua4BQQ4ZxieEQfL3WC6XpD68=;
        b=AzhqijTzmGndJyCiKM4+sVOnk+m37YPHVtG/SP94lpV9TBvLhOPmXGOfJLJKjCrxZJ8kfo
        zImzsWvAkOSiSj22iZ6xNIAlKf5H1WRVbEMwPMIlwQ6VbJw+Y1nLUwUv8oVj/PVGpqEnRJ
        3mIWnY3RVFHYUxOcAbRl3SBv49/OAdg=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-571-JbCYQ4wLP4mdjguIB8tDWQ-1; Wed, 16 Dec 2020 15:47:40 -0500
X-MC-Unique: JbCYQ4wLP4mdjguIB8tDWQ-1
Received: by mail-yb1-f197.google.com with SMTP id z62so31864491yba.23
        for <linux-wireless@vger.kernel.org>; Wed, 16 Dec 2020 12:47:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mHJsL1L4MctILcbkxLdua4BQQ4ZxieEQfL3WC6XpD68=;
        b=tLE4+C0u9SskoX4n4tmeUcpJVMryDBsMeGvL5/vQ1YtnQdIH1QwzfoJzCWb4eyG325
         39v536Xea0TMS6p6uwZ68/hNumDsGPrlpTZdKDK57eBed/Q4e4ulELpZVXUhpP7UEeJE
         X6W3JFIgdylmw5ek/JB9nsMczAIafkQ/6djk04XRCTU7t5rj+e3SoV4yrWW0b0eyyEUC
         t4flkU9mYu5TQ5yTL89GN4TRfBPS3ZNT9X0VIopmnpeiRrmzEvjZyFVT92MoLU+dewSM
         RRtbH0HIhSS/ylwrL3DDu4rydYkUZqgzgjTPG/zrRs0JijhjDE9G5aFNPAYvm7IsZneJ
         A9dw==
X-Gm-Message-State: AOAM533cd9sy1kMRpqEQH0oPU5yQAIRhoTMvKojeJZ6b4Fx2kmuqkN9w
        ivafxJL29plrLjGYqxRK9gne7v+9ozlJTyjkgV6iqXK50G6Kz/zE2IfRZ4TJ5Dze7iNSH/8s63x
        7jthu2d6nRxCYHOftKrW+9HgC3AKglftB0xQAoH0aX7I=
X-Received: by 2002:a25:b94c:: with SMTP id s12mr55497319ybm.498.1608151659771;
        Wed, 16 Dec 2020 12:47:39 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz0WzHOJHPkfIm0ep2FcJ6nKJahEqK6dIvuUb4m2ME6ccVlVE2X8osvk7FCYV/kXXx+FDmGkafF5OAp9H+E6cw=
X-Received: by 2002:a25:b94c:: with SMTP id s12mr55497303ybm.498.1608151659613;
 Wed, 16 Dec 2020 12:47:39 -0800 (PST)
MIME-Version: 1.0
References: <20201216184429.GG2036@lore-desk> <87pn39vadr.fsf@codeaurora.org>
In-Reply-To: <87pn39vadr.fsf@codeaurora.org>
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Date:   Wed, 16 Dec 2020 21:47:28 +0100
Message-ID: <CAJ0CqmWrhu6eN8TP8D6AwmTShpxR8R0Yp7qbRVMP8140udZNCA@mail.gmail.com>
Subject: Re: Fwd: [PATCH] mt76: mt76u: fix NULL pointer dereference in mt76u_status_worker
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Felix Fietkau <nbd@nbd.name>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

>
> Lorenzo Bianconi <lorenzo.bianconi@redhat.com> writes:
>
> > Since net-next is closed now I guess we can consider this patch for
> > wireless-drivers
>
> Ok, I assigned the two patches to me in patchwork. Felix, is this ok? I
> hope you have not applied these to your tree yet.

ack, thx.

>
> Lorenzo, please don't forward patches as patchwork when creates a new
> patch and the discussion is not visible in the original patch. Instead
> reply normally to the original patch, this way patchwork stays clean.
>

ack, thx. I will put more attention next time.

Regards,
Lorenzo

> --
> https://patchwork.kernel.org/project/linux-wireless/list/
>
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
>

