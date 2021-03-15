Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7634533C572
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Mar 2021 19:21:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232299AbhCOSVN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 15 Mar 2021 14:21:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:57969 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232079AbhCOSVE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 15 Mar 2021 14:21:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615832464;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7dHd3VnSNg5KZMgkWTLAFsTuSg1qebri+zbtU6jQyuU=;
        b=UPyDWkaXyWSHajQrY5/r6UzvqKruO0jBDALURt0m6moaCIsAw+uLnEM/e43R786HElcklT
        LBgLyH9Hp45BLGW95o3leWn27I4BijqWN7jAO23wp9p91Pa1c/qsbx+qImq9rS/PSlr/Er
        n+FG2pgGDZgd96TQKyC7vl1hjEnTfoE=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-14-CU9G4SouPrKyb2_t79ewFw-1; Mon, 15 Mar 2021 14:21:02 -0400
X-MC-Unique: CU9G4SouPrKyb2_t79ewFw-1
Received: by mail-oo1-f72.google.com with SMTP id l19so16384602oov.19
        for <linux-wireless@vger.kernel.org>; Mon, 15 Mar 2021 11:21:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7dHd3VnSNg5KZMgkWTLAFsTuSg1qebri+zbtU6jQyuU=;
        b=e6pU2yNDlg2jDLWHM/zDdTMB0DndcE+dCtgBuhjufh0atAy0PDR7wVilJzQLfIj9xC
         1+RAcIt3FyiXYLUfFHEHD+1XXbUepUfHLOSldInZgA5iBBP7te1L1xLQvGquq6OwkmnX
         VaC9LluI9NN53vVrHjDyExsGDsSpFdkGTYAWDyX4PeBGfR7sARJ0Uo2vMtLZOALxzefI
         qhEEsMzCUFcTW3E5AimqX2nxhBZCND4ukJV2aq7nvsia6l/j+e3uHNPq4bthu2HnlCzb
         on3IEt/2P0siPqQV+BKLxyFsjMdavX9D3AcJgB1YBNI3LtvzlSVqNFZdYShoTnIIl6kl
         0vSA==
X-Gm-Message-State: AOAM533wEU7npsohyV2XFDMDKMLKlNIwGP1s20ZzQqplEYKazPl8YNHj
        ZH6n4D+elEm7oLqLIy+oWs69FiAIXq29wWCfZKd0ZB42z6GceYXhHzYTMSghB2HAvheZDF6/hhs
        6Wcm7A7p4AThvP6OQk5dkhWvt+5pgb46/59YGq8fzO84=
X-Received: by 2002:a9d:73d0:: with SMTP id m16mr362909otk.172.1615832461723;
        Mon, 15 Mar 2021 11:21:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwVJssCDoY55USWssvJyU86yNNw2WpQFj9SiVdSP0Y2mvll4hM27bXDMQqbstEwl1PW7d/raazUUy8m/dvDXqU=
X-Received: by 2002:a9d:73d0:: with SMTP id m16mr362889otk.172.1615832461458;
 Mon, 15 Mar 2021 11:21:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210312163651.1398207-1-jarod@redhat.com> <87lfasaxug.fsf@tynnyri.adurom.net>
In-Reply-To: <87lfasaxug.fsf@tynnyri.adurom.net>
From:   Jarod Wilson <jarod@redhat.com>
Date:   Mon, 15 Mar 2021 14:20:49 -0400
Message-ID: <CAKfmpSfJ-t6pPC+Bwu0UrWH9w9edgcM-Y+qKAXBNx0NSXw_ZEQ@mail.gmail.com>
Subject: Re: [PATCH net] wireless/nl80211: fix wdev_id may be used uninitialized
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-wireless@vger.kernel.org, Netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Mar 12, 2021 at 4:04 PM Kalle Valo <kvalo@codeaurora.org> wrote:
>
> Jarod Wilson <jarod@redhat.com> writes:
>
> > Build currently fails with -Werror=maybe-uninitialized set:
> >
> > net/wireless/nl80211.c: In function '__cfg80211_wdev_from_attrs':
> > net/wireless/nl80211.c:124:44: error: 'wdev_id' may be used
> > uninitialized in this function [-Werror=maybe-uninitialized]
>
> Really, build fails? Is -Werror enabled by default now? I hope not.

Don't think so. But we (Red Hat) build all our kernels with a fair
amount of extra error-checking enabled.

-- 
Jarod Wilson
jarod@redhat.com

