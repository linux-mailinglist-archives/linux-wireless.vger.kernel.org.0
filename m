Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E19833035C9
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Jan 2021 06:55:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388870AbhAZFx1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 26 Jan 2021 00:53:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:46005 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727964AbhAYMVE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 Jan 2021 07:21:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611577144;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EkySjmyy5bV42XAMy1/nKNEVTl7EAWsq5w4RqirjjF0=;
        b=C8jaTRnvXZJP4TefcwGGRdn4UzpDUU9bCQhEDiHT8BIQtX+0jHFCpM8G+oAft4PAhPL+lq
        sm+SdIMvv9ATR3Zyixcxk/BveiH+D+ZrnEOAobRLGVOEt3fuDYtePPOXt0bgICXdO17nd3
        4PW41TVTGAiGd8+bAt/48pPXTX0NJBo=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-582-f2fwulGJNayQEJo9XInjRw-1; Mon, 25 Jan 2021 06:56:30 -0500
X-MC-Unique: f2fwulGJNayQEJo9XInjRw-1
Received: by mail-ej1-f72.google.com with SMTP id n18so3652709ejc.11
        for <linux-wireless@vger.kernel.org>; Mon, 25 Jan 2021 03:56:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=EkySjmyy5bV42XAMy1/nKNEVTl7EAWsq5w4RqirjjF0=;
        b=mY/orPQhUJBSoj1r7R4vIv+oK10ihPCFmWHGht04+Md3xfxSbsD6ZSuv1N3fK1Cyex
         cPKl+K883tYFZ7UeG74tPX+SR0QKvry4Yb7IApN6vn/ELF8Ukg84WLERmHaYHDmWO9g1
         kX/o8/YuX4NkazK+mu7IgiP/oEFqTRqItwEHDK8kVdHUuaIRgzHUo2q7lWpnhPhH3W20
         MU+8W0hAaqC8mFFuX0slozJBDd07++mYJCac5DrYsNQYoCGlWwAWPW+Dl14up9zUxnQz
         Jg5KLSLwfSXF3L024/40JhZlsFykLRzuhEQIfpVOEMHCOT4BkBop6OyDHO/F6bWfffTp
         cdRg==
X-Gm-Message-State: AOAM532IHFxlHj7+fu4ap3TsURlF6xanQzu5Ho6W2OxQjf68kV7sHGww
        /QbyhAKrDlG+BLRFB29NcFygLiyWuZXzLsAMV0prFvvsyWlcpBAbDSumBuZUmdUtTiScIoK0OMa
        aL9kA42+qs5UEvZPUD6097CD1z3Q=
X-Received: by 2002:a17:906:28d6:: with SMTP id p22mr115658ejd.365.1611575789409;
        Mon, 25 Jan 2021 03:56:29 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw32TbIOVmFixRg2hrecc/z8+5ezjOWo20hjLhh8ao7DjXSozSpHP9cH+EHiw7dhQqtyMRb2A==
X-Received: by 2002:a17:906:28d6:: with SMTP id p22mr115654ejd.365.1611575789279;
        Mon, 25 Jan 2021 03:56:29 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id ce7sm8177313ejb.100.2021.01.25.03.56.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 03:56:28 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 643D518033D; Mon, 25 Jan 2021 12:56:27 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net
Subject: Re: [PATCH 4/6] mac80211: minstrel_ht: significantly redesign the
 rate probing strategy
In-Reply-To: <20210124122812.49929-4-nbd@nbd.name>
References: <20210124122812.49929-1-nbd@nbd.name>
 <20210124122812.49929-4-nbd@nbd.name>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Mon, 25 Jan 2021 12:56:27 +0100
Message-ID: <87o8hdmdqs.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Felix Fietkau <nbd@nbd.name> writes:

> The biggest flaw in current minstrel_ht is the fact that it needs way too
> many probing packets to be able to quickly find the best rate.
> Depending on the wifi hardware and operating mode, this can significantly
> reduce throughput when not operating at the highest available data rate.
>
> In order to be able to significantly reduce the amount of rate sampling,
> we need a much smarter selection of probing rates.
>
> The new approach introduced by this patch maintains a limited set of
> available rates to be tested during a statistics window.
>
> They are split into distinct categories:
> - MINSTREL_SAMPLE_TYPE_INC - incremental rate upgrade:
>   Pick the next rate group and find the first rate that is faster than
>   the current max. throughput rate
> - MINSTREL_SAMPLE_TYPE_JUMP - random testing of higher rates:
>   Pick a random rate from the next group that is faster than the current
>   max throughput rate. This allows faster adaptation when the link changes
>   significantly
> - MINSTREL_SAMPLE_TYPE_SLOW - test a rate between max_prob, max_tp2 and
>   max_tp in order to reduce the gap between them
>
> In order to prioritize sampling, every 6 attempts are split into 3x INC,
> 2x JUMP, 1x SLOW.
>
> Available rates are checked and refilled on every stats window update.

Very cool!

> With this approach, we finally get a very small delta in throughput when
> comparing setting the optimal data rate as a fixed rate vs normal rate
> control operation.

Can you quantify this "very small delta"? Would love to see some
benchmark data :)

-Toke

