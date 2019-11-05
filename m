Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C0E1F024D
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Nov 2019 17:08:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390123AbfKEQIS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 5 Nov 2019 11:08:18 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:56410 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390125AbfKEQIR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 5 Nov 2019 11:08:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572970096;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BBtC4wx9lH61Ec616GSt/IEqhhvk+uVpWKqDt5axrQY=;
        b=RfRVT80+s84iHco+vsq2xLqNBhs3zcK/gmeLORc8KJTPTofE2uylYb0CWPRXOvyFmBo2Hp
        xCPL5v0NL8pWYvl5UT2sFNU+cuoRb126Co5BPthCEDhks6hHIh9G0kWEpx64JDfNMRSC1T
        tMtIh0EIFvhd1RAMtVFmXgpKD8fh3JI=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-249-PFfbHToJMg-xafpEpjeqPw-1; Tue, 05 Nov 2019 11:08:15 -0500
Received: by mail-lj1-f198.google.com with SMTP id d5so4381444ljj.2
        for <linux-wireless@vger.kernel.org>; Tue, 05 Nov 2019 08:08:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=yScEydMevhBmtDjojQRQxGwIEmJv9l6s1srbmHp5ERM=;
        b=FsIHs5S+CNxqeF6YAFtjlgvOwXoYtW0QaD7iaf1oRdivUlXlVy9KneUJFAKkviKvwr
         JlxBoMTo0ru6Q6cZTsThKTEEUIciolUL+cvEokA3YyLXaox7yar2JmaWYvGv6TBk/VFH
         56CwFySdHqgiuR1CQmLUu+zG1qSdYKcoMXx59iZXJeULxZ7NW1OrCxSyralhfMZeybXB
         eYK9Ag7Wr9sNsn5buIyEsGR6uMWp38QOdssH7RiY1AD6R3B3ArG/ZvAZ/BC+YrP633U4
         ufyBaf1GwFx70z5YWvHoWL0NibcWrRlYgYxTvoBm+NFztO8i/lFtU3T1RMSiBT5uQ0uR
         s5lA==
X-Gm-Message-State: APjAAAXSQw94CA8qH3COZB+83i4yj4aZjbihUXBjeI8QuuK0q6Z3r/o+
        avQ/opjZU0qiSFrnKsgSq4n0tWrC29A72fAL+ACe+zL0sH22fvYCABTrqP460Sx63N5wd55MKIk
        nA7TJnoElNYMPeoGHhLYSlRaTuiE=
X-Received: by 2002:a2e:9a9a:: with SMTP id p26mr18422445lji.164.1572970093790;
        Tue, 05 Nov 2019 08:08:13 -0800 (PST)
X-Google-Smtp-Source: APXvYqxOmHtccuQt8rjZZDgZ0XYw7bjRBvkX0yVh8IrfhQBAsjoqvZROV/wAl5mrIyouL7SbDAqdzA==
X-Received: by 2002:a2e:9a9a:: with SMTP id p26mr18422438lji.164.1572970093673;
        Tue, 05 Nov 2019 08:08:13 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a00:7660:6da:443::2])
        by smtp.gmail.com with ESMTPSA id n1sm3620901ljg.44.2019.11.05.08.08.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 08:08:13 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 580F61818B5; Tue,  5 Nov 2019 17:08:12 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH] net/fq_impl: Switch to kvmalloc() for memory allocation
In-Reply-To: <6db5847262bce0691dbe3e0c4df04a4996770e0e.camel@sipsolutions.net>
References: <20191105154951.546285-1-toke@redhat.com> <0690b548e233fba3758df0ce1eeca1c0803a62c4.camel@sipsolutions.net> <8736f2jp0o.fsf@toke.dk> <6db5847262bce0691dbe3e0c4df04a4996770e0e.camel@sipsolutions.net>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 05 Nov 2019 17:08:12 +0100
Message-ID: <87v9ryi9w3.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: PFfbHToJMg-xafpEpjeqPw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Johannes Berg <johannes@sipsolutions.net> writes:

> On Tue, 2019-11-05 at 16:56 +0100, Toke H=C3=B8iland-J=C3=B8rgensen wrote=
:
>>=20
>> Oh, right, of course; silly me. Guess I was a bit too trigger-happy on
>> the nice one-character patch ;)
>>=20
>
> I guess two characters is still pretty good ;)

Hehe, yeah, I can live with that ;)

-Toke

