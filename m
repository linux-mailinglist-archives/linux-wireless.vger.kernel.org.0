Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57BB7B8250
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Sep 2019 22:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392383AbfISUPj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Sep 2019 16:15:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40949 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2390489AbfISUPi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Sep 2019 16:15:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1568924137;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7W+pePXqkmz7RHiezawqQ5L2NT1eFDJiMsNkFVGn840=;
        b=g6SQJKv7dFdnWiIzSrvPsZiIm8jbLojJDtt8DCU488r2sgFf978cNbKhkiEbkN9pC0D+wP
        B4r3B1jfO6wcd5wrg4UtlNlcYGL8vx40OOhQrbV3w4WAu9BwJzZRtGz53wOEqvFL0neu79
        mT4duI5QOWnX6MvxnGpdToZTzAyOuI8=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-149-r8PWDHF_NY6032RfVXzlnw-1; Thu, 19 Sep 2019 16:15:33 -0400
Received: by mail-ed1-f70.google.com with SMTP id n14so2079989edt.3
        for <linux-wireless@vger.kernel.org>; Thu, 19 Sep 2019 13:15:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=KJ6OYNkYsFvAA8jzLzx1h6hbKWVfzECU10Vac2aXn1k=;
        b=sudbs84AmKTyWE7uGqkBQIcImXdKc/z1vtxJ1IlFFmiBxTIhoNS71yWvP6JSKuZw8Q
         oeP94FccMBe9ucVxZsOrxvAd4X/tyUoj0PpAAVBo75QKHaqo/f/bToUYxOY+ruVuz5NW
         9ix7bpNvQhz+5mURuAFxFN46PvGU7Z0XNr9IaR68NrnDbWAtPrUB9gqkpwQnncHGanSx
         T1FCawHba5ex9aoYJ8FHiQ7q2s49mfJiW/sL2Wu/jnpFDL8/6YC5U2Mr4dK5ExuX7nAw
         5HcUPYE3GcHJB09KzcBHYzEoMhViRC5KdlOO21K6/2q21cOZkcnTa3+UcpFViScImJN6
         CwpQ==
X-Gm-Message-State: APjAAAUXhvqJ3uGtVid/jPXP3LevJtjPpa+0oL1n6FWrnYrHMnG8ZfWH
        NSoUcrCemRQK6IVOPQW0DVjM6lDVE6kQyn/dTvmPGCrl2Pd/gJ1vv4q5tIT+yV+N7YNleOCLyBS
        f7nSNOdW1oikOX6FZPl0r6mB5YnY=
X-Received: by 2002:aa7:c5c2:: with SMTP id h2mr18524073eds.260.1568924132273;
        Thu, 19 Sep 2019 13:15:32 -0700 (PDT)
X-Google-Smtp-Source: APXvYqz8soLaGsdDseJsMCceyYyFJLhNLJY/QOJgQxukBUxaRYwRD2X9fKT8p7ofyoHZZFJaMKG7SA==
X-Received: by 2002:aa7:c5c2:: with SMTP id h2mr18524054eds.260.1568924132103;
        Thu, 19 Sep 2019 13:15:32 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (borgediget.toke.dk. [85.204.121.218])
        by smtp.gmail.com with ESMTPSA id b53sm1830580ede.96.2019.09.19.13.15.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2019 13:15:31 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id EF5FC18063E; Thu, 19 Sep 2019 22:15:30 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     John Yates <john@yates-sheets.org>, Dave Taht <dave.taht@gmail.com>
Cc:     Make-Wifi-fast <make-wifi-fast@lists.bufferbloat.net>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Peter Oh <peter.oh@eero.com>, John Crispin <john@phrozen.org>,
        Ben Greear <greearb@candelatech.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Felix Fietkau <nbd@nbd.name>
Subject: Re: [Make-wifi-fast] [PATCH RFC/RFT 4/4] mac80211: Apply Airtime-based Queue Limit (AQL) on packet dequeue
In-Reply-To: <CAJnXXoj_jinaOhxxJP3EpfWsTuaLCR_gREXxqtktPbEAginLjg@mail.gmail.com>
References: <156889576422.191202.5906619710809654631.stgit@alrua-x1> <156889576869.191202.510507546538322707.stgit@alrua-x1> <f21b10fd-02ae-af59-8e2f-88f654627ab3@eero.com> <879913e9-4254-1381-07f6-d860fb0b8de0@candelatech.com> <f9b224a0-305f-9715-f627-7a5fae0988d3@eero.com> <df105ac6-833b-4a22-9ecc-484513a2eb9c@eero.com> <CAA93jw4F4vuXdWOne_A=h6x-ERMshw5B5UqxU1-ZrnD74nAavw@mail.gmail.com> <CAJnXXoj_jinaOhxxJP3EpfWsTuaLCR_gREXxqtktPbEAginLjg@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 19 Sep 2019 22:15:30 +0200
Message-ID: <875zlodov1.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: r8PWDHF_NY6032RfVXzlnw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

John Yates <john@yates-sheets.org> writes:

> On Thu, Sep 19, 2019 at 2:18 PM Dave Taht <dave.taht@gmail.com> wrote:
>>
>> For the record, this was the google report on their implementation in 3.=
18.
>>
>> http://flent-newark.bufferbloat.net/~d/Airtime%20based%20queue%20limit%2=
0for%20FQ_CoDel%20in%20wireless%20interface.pdf
>
> From skimming that paper it sounds like this is shipping in the
> current Google WiFi product. Is that correct?

I believe so, yeah. The chromiumos patch tracker is here:
https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/=
588190/13

-Toke

