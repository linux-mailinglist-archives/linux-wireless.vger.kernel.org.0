Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D933478B4F
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Dec 2021 13:22:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235553AbhLQMW6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Dec 2021 07:22:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:55403 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233060AbhLQMW5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Dec 2021 07:22:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639743777;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7EeMKeeOfgBqA1Pr7lJgvUFgsrZxsfQDZdLOvAz1mvg=;
        b=AmbMqSSMSWXzGmVCHUU881E50KbTaITx9wCyEr27HthKbo74GnxU0v+vrJmd9OFvgZqVPC
        oWLyVPJ3PQoh8+vTeab8yleuJ9VIYFqQLFs5ddGeqDUYzs+6KIzFjUAyhWhUYQXhGIOMDk
        Y17wMVVuW3wg8jMMs6yCeGqyE2H0Zdg=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-114-CbKMPApgMZ6n7Qn4Hnfpjg-1; Fri, 17 Dec 2021 07:22:56 -0500
X-MC-Unique: CbKMPApgMZ6n7Qn4Hnfpjg-1
Received: by mail-ed1-f71.google.com with SMTP id eg23-20020a056402289700b003f80a27ca2bso1771559edb.14
        for <linux-wireless@vger.kernel.org>; Fri, 17 Dec 2021 04:22:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=7EeMKeeOfgBqA1Pr7lJgvUFgsrZxsfQDZdLOvAz1mvg=;
        b=rKWSs7SDL0s67d4uO/6fDkcO7/sBNS5Zuq+GRd3cpAHUhPimo7Q8PI6Tz+7Ep/NACF
         9byiEpgHDNNqK1+Hejq68quvGEXCIiMZbFMuycWVDcdVV7v5MjpZC3Yluf5HfCXoCyk8
         Nh8f2GuTUCmfSJlrCLWRJVS6xt5tVQSStDc7+N5CUmAZE+gqJsCAJoYPvqpHMObEcYKx
         LYwfjSdDa7ATqJ82LJL1mtiAoA5Aycd7nNLGDK/QZgPm2GQkH0JfB4nvK7Y1V1KPULKE
         Bp70Dee2P2qaFOaeUZBqoFQJhN7l5QM89ogIIRmTV2LRA2q4Qv837h5edktD6LxpWmTB
         SYOQ==
X-Gm-Message-State: AOAM5337RJVa+o5RdFEnQ9NhFy+DOnLztRq5z1W5V4JAZPd3nNhRTZFG
        9rAuXVgxYHdbv7KfO+GnBQ2KNJrWnL1VsDZlqdYkyz3KJ+hjDObqkyiHf+0da7ggSAOs8Zl7ccl
        mD71aLrdf5BehEThOXsoTRqX+61Q=
X-Received: by 2002:a17:907:1b01:: with SMTP id mp1mr2398419ejc.683.1639743774587;
        Fri, 17 Dec 2021 04:22:54 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwxcCJpcE8Ork4sW9I39vYBkRWtgunhNyV+sG7uk/iCwCFK04lfaSyJr7sMtSVTko+8NKZ/gg==
X-Received: by 2002:a17:907:1b01:: with SMTP id mp1mr2398403ejc.683.1639743774216;
        Fri, 17 Dec 2021 04:22:54 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id b73sm1334756edf.37.2021.12.17.04.22.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Dec 2021 04:22:53 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 154D01802E8; Fri, 17 Dec 2021 13:22:53 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net
Subject: Re: [PATCH] mac80211: use coarse boottime for airtime fairness code
In-Reply-To: <20211217114258.14619-1-nbd@nbd.name>
References: <20211217114258.14619-1-nbd@nbd.name>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 17 Dec 2021 13:22:53 +0100
Message-ID: <87y24jbeua.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Felix Fietkau <nbd@nbd.name> writes:

> The time values used by the airtime fairness code only need to be accurate
> enough to cover station activity detection.
> Using ktime_get_coarse_boottime_ns instead of ktime_get_boottime_ns will
> drop the accuracy down to jiffies intervals, but at the same time saves
> a lot of CPU cycles in a hot path
>
> Signed-off-by: Felix Fietkau <nbd@nbd.name>

Makes sense for the activity detection stuff!

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

