Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDE1445ED54
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Nov 2021 13:04:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377179AbhKZMHS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 26 Nov 2021 07:07:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:33244 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1377184AbhKZMFR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 26 Nov 2021 07:05:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637928124;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=84uNkci5tjJW+AczBsPC3Qa9DoGn26uDSmEJKsw5B5g=;
        b=K+vkCrh8FVafCf1wPbaXYuYwrZcp/Ou2wbpuqZsSpBAJQExIDrK+3kRLWICiYRk5m00hse
        c12EaEliqe4HYfgtbIy+En0Yoctew+X9qPMgDg/No1Q1/pieHGNBrH1sdITn+kcCnBvY+f
        N1ovVN8TkU2U3/ftbgRjP0dORWocO7w=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-319-s8RU08uNMRG84iGVuGtZkg-1; Fri, 26 Nov 2021 07:02:03 -0500
X-MC-Unique: s8RU08uNMRG84iGVuGtZkg-1
Received: by mail-ed1-f70.google.com with SMTP id k7-20020aa7c387000000b003e7ed87fb31so7938261edq.3
        for <linux-wireless@vger.kernel.org>; Fri, 26 Nov 2021 04:02:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=84uNkci5tjJW+AczBsPC3Qa9DoGn26uDSmEJKsw5B5g=;
        b=wAYH8JKJAvi1QsVHsa8OTcyzbr3e2nTCb73Z7MXoSKVSMjrW6jeqDqetow+lZmTu34
         YHCVgLQVPs5gWcu5zFcwshZgKVOb2QMoOW3ucet/VpGShi59n2QZLdepj5L59ftpLcmX
         aGYY9ATJdQXc9KjUzg5Zb16eyIjcdv/oUhFqLGmnSdw9ej30KDwtx7wUVmgr0EzBAZVV
         JvWuI7xhzWqI7J3rQZSCikBvW2g34S8WlYkQyJahqxY94MtjJeQ9HuqTi7Lu3mhKyY0z
         zDqBkeI/q5dRPMtvOO/bRA24OWhV6If7TslDkuKma/NA9LXreWAVtp7cHf/UwcV9JL6+
         r0DQ==
X-Gm-Message-State: AOAM531H0l75urFLQWkAQZfAWRuRc3vWTnq5dn2wJCy8Mizf12SX0qnk
        VmuifiRnIiDHedeydMRC7sfaV1nok1EPKcGSuq+MxcLRRwqz0x4mhGn4sVsU4rUmAsrRkQZNP0h
        GhURDwxMWAnYpuDFyRKxB6a/xRJc=
X-Received: by 2002:a17:906:1c56:: with SMTP id l22mr37676266ejg.208.1637928120855;
        Fri, 26 Nov 2021 04:02:00 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwNNSha0xwF5x4VtPmWfxME3hIBgReNfr26VtNz2+r1QD6dHgohDhhqJ+RPnOLEzOpb8ORUqg==
X-Received: by 2002:a17:906:1c56:: with SMTP id l22mr37676108ejg.208.1637928119354;
        Fri, 26 Nov 2021 04:01:59 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id m22sm3656288eda.97.2021.11.26.04.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Nov 2021 04:01:58 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id DC6BB1802A0; Fri, 26 Nov 2021 13:01:56 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Jonas Jelonek <jelonek.jonas@gmail.com>
Cc:     linux-wireless@vger.kernel.org, kvalo@codeaurora.org, nbd@nbd.name,
        Thomas Huehn <thomas.huehn@hs-nordhausen.de>
Subject: Re: [PATCH] ath9k: switch to rate table based lookup
In-Reply-To: <CAChE-vT1UMw2iadzuzsUPEcAopi=86N4GV_b4=chZbSvap3x=A@mail.gmail.com>
References: <20211125121652.6073-1-jelonek.jonas@gmail.com>
 <878rxcb4q2.fsf@toke.dk>
 <CAChE-vT1UMw2iadzuzsUPEcAopi=86N4GV_b4=chZbSvap3x=A@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 26 Nov 2021 13:01:56 +0100
Message-ID: <8735njazwr.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Jonas Jelonek <jelonek.jonas@gmail.com> writes:

>> What's the practical implication of this? Performance benefits, better
>> rates selected, or what? Got any benchmark numbers?
>
> We're planning to annotate and implement 'transmit power control' per
> packet / per MRR
> and to improve the rate control API in mac80211 to support newer
> hardware.

Ah, great!

> SKB->CB is limited in space, tx power annotation also does not fit in
> there. Future
> perspective is that rate control won't use SKB->CB anymore, neither
> for normal rate
> setting nor for probing.
>
> The new rate control API (introduced with commit
> 0d528d85c519b755b6f4e1bafa3a39984370e1c1) allows drivers to directly
> get rates from sta->rates. This is not used by every driver yet,
> ieee80211_get_tx_rates performs the
> translation/merge for the drivers.
> The call to ieee80211_get_tx_rates and subsequent calls in ath9k can
> be avoided by directly fetching rates from sta->rates. This may also
> improve performance.
> ath9k does not expect rates in SKB->CB, therefore table merge does not
> need to consider this
> (except for first rate in SKB->CB for probing).

Please put something like the above explanation in the commit message so
people can understand the context. And as Kalle pointed out, some
information on how you tested this is also needed, and can go into the
commit message as well :)

-Toke

