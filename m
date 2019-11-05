Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42178F01F7
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Nov 2019 16:56:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389843AbfKEP4N (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 5 Nov 2019 10:56:13 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:47774 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389032AbfKEP4N (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 5 Nov 2019 10:56:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572969372;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fgir0jgRg7UKL4cew79oeBinTKG4LuK45c+jWnr1pgE=;
        b=gmbqqk+OlJl2Of0PxcbEr8NIOQNtIsr2zQ26eIkt9u1EO60JHAR9MtjIwanoTrCHmulQ1x
        6iWc93Q/Zu4odygokzm4cKE0XClka+AC4FtMY7y2GptAEbv+iZYYBQdIO/xmKBOnXuvtSz
        x+i2qfnOIIxyctEhglnfGoQmsEbc5Mw=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-255-gbhYdlqaPPq5IlEIVLf8nw-1; Tue, 05 Nov 2019 10:56:10 -0500
Received: by mail-lj1-f197.google.com with SMTP id l12so1774726lji.10
        for <linux-wireless@vger.kernel.org>; Tue, 05 Nov 2019 07:56:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=DeDeJD6GQcKUW773Fo5lYMtFDOBhsAWEDNESasTe0XA=;
        b=G7kq40zL36JwNhkeMdUzLW9xPDK8hedJ6fH+kHwmZrwItfU4/wQkPLDDoXODY6C9IN
         wHwmV/hW4R46n6klq0Tbz0iSI1pS9ncacVCZ7XHn6IgbGenjViPSw/EGpKCsLDebYuVR
         D9wdxVoOmn6doJCPOAXjPjmKDvA1EB8F6S4iTCk0piBmzWlMBcue+GqyC9h/02Yn6fSv
         c22kbSTV66KrXCCX0gVmEzrzf1viYHHjJBn/s1tloKv9MLuAVvu7d++9XoSIe0Htdtxs
         jTqCKO1C0n9tZcqeVW7NGeBVsvMOV183UieVgl3ydv/Co/ZCE7Vw97gtenbx6KOUmMXc
         KtCQ==
X-Gm-Message-State: APjAAAWtqZADmghw1NABytdXgkEqUbioga+9/KyhAukPXx3TTlX6rt2Q
        AGsRXYiDywTXCWKgdMtGvuhUQpqopy+Z/tH0fodfNDnpKe4X/eqG24E+R/1gFeC2IAmWIDWKT9r
        HEPKJ//N3tJvVepJgjNQbiOD7ysU=
X-Received: by 2002:ac2:563c:: with SMTP id b28mr7001187lff.149.1572969369185;
        Tue, 05 Nov 2019 07:56:09 -0800 (PST)
X-Google-Smtp-Source: APXvYqyP/cD/tvDlWRUZ1xQozGpZvMnsajopDyl4GNAmeCSq5XnpbubeBOuj2N1SpKucS97mb7uhRQ==
X-Received: by 2002:ac2:563c:: with SMTP id b28mr7001182lff.149.1572969369012;
        Tue, 05 Nov 2019 07:56:09 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a00:7660:6da:443::2])
        by smtp.gmail.com with ESMTPSA id p24sm8513722lfc.96.2019.11.05.07.56.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 07:56:08 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 83C741818B5; Tue,  5 Nov 2019 16:56:07 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH] net/fq_impl: Switch to kvmalloc() for memory allocation
In-Reply-To: <0690b548e233fba3758df0ce1eeca1c0803a62c4.camel@sipsolutions.net>
References: <20191105154951.546285-1-toke@redhat.com> <0690b548e233fba3758df0ce1eeca1c0803a62c4.camel@sipsolutions.net>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 05 Nov 2019 16:56:07 +0100
Message-ID: <8736f2jp0o.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: gbhYdlqaPPq5IlEIVLf8nw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Johannes Berg <johannes@sipsolutions.net> writes:

> On Tue, 2019-11-05 at 16:49 +0100, Toke H=C3=B8iland-J=C3=B8rgensen wrote=
:
>> The FQ implementation used by mac80211 allocates memory using kmalloc(),
>> which can fail; and Johannes reported that this actually happens in
>> practice.
>>=20
>> To avoid this, switch the allocation to kvmalloc() instead; this also
>> brings fq_impl in line with all the FQ qdiscs.
>>=20
>> Fixes: 557fc4a09803 ("fq: add fair queuing framework")
>> Reported-by: Johannes Berg <johannes@sipsolutions.net>
>> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>> ---
>>  include/net/fq_impl.h | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git a/include/net/fq_impl.h b/include/net/fq_impl.h
>> index 107c0d700ed6..d3873db91c71 100644
>> --- a/include/net/fq_impl.h
>> +++ b/include/net/fq_impl.h
>> @@ -313,7 +313,7 @@ static int fq_init(struct fq *fq, int flows_cnt)
>>  =09fq->limit =3D 8192;
>>  =09fq->memory_limit =3D 16 << 20; /* 16 MBytes */
>> =20
>> -=09fq->flows =3D kcalloc(fq->flows_cnt, sizeof(fq->flows[0]), GFP_KERNE=
L);
>> +=09fq->flows =3D kvcalloc(fq->flows_cnt, sizeof(fq->flows[0]), GFP_KERN=
EL);
>
> You need a corresponding kvfree(), no?

Oh, right, of course; silly me. Guess I was a bit too trigger-happy on
the nice one-character patch ;)

Will send a v2

-Toke

