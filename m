Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5998E107292
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Nov 2019 13:56:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbfKVM4n (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 22 Nov 2019 07:56:43 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:22426 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726836AbfKVM4n (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 22 Nov 2019 07:56:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574427401;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L7iaZa3lWb/liQ3KOyt+Q/aYBEcpYpaL7KReyXpriBQ=;
        b=DVUgnKohDWw1mmXQECqIzk7302Ey7+xPr8y2gPS+tXrobtbYQ2slK0O7HAH8qnwN1ilfsb
        T0ESaLfxSmuCpWf3//Vw2m72AGWswZdhzDxPhuuMqKNA8R6AjUxuA2Fo9NK+iM68TlSTBD
        9vmLKO5qsypW90Kd6Z2Sb1o3S9ryhsI=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-106-uMbTqXMoOhq4kLkNnqwZeQ-1; Fri, 22 Nov 2019 07:56:39 -0500
Received: by mail-lf1-f69.google.com with SMTP id x23so1753998lfc.5
        for <linux-wireless@vger.kernel.org>; Fri, 22 Nov 2019 04:56:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=ztfKKq9p/dWzxUE4rOgUYoWjyWYtyvbDJUKl0X867xs=;
        b=ApFhTdvUnU7bjVv43vlJXONcG1n6MHuem4vQDDRL4ws3MagsUgUhXhbLdXisxfls2W
         sMnqcffXnShTczjhLHdSTqQ9YvftMaG4d6jrPXqvSBuTPCZne9ONJZXnV2rhuEiiU6jD
         Ehmes1q5TA1uUPDAg3lYlF94fkcuPOzdD+LLpyX80iiz8IKebVG65iY3ziVxR2edlvmR
         Jgz34iWOd8OasDpG8l/tgR3Np5D3dZMT0eYagPPLKU+nNEz8f3NWZlildap9BwEV835W
         dWBTotVqofYfEeAlrZANfvh5TBWquXlEcI5kazKGVHR59S9Jorx5L4RSNN0GikISM/xs
         XN7g==
X-Gm-Message-State: APjAAAXPiFK2TebftcFCKFun3zc0CuQjcO4/SRFFVcwZvQsA2MMERKGh
        Hlt5yAMv41yDd2t6QJ6GWWkb0zDLhLC3TOacZretM98wdMnBjR8HK16+BTWN39k+Lq2t5Sx0dB3
        DwuWjOyodAFJ7MpM9W1I/lk0Q9+Q=
X-Received: by 2002:ac2:54b1:: with SMTP id w17mr12021829lfk.128.1574427398324;
        Fri, 22 Nov 2019 04:56:38 -0800 (PST)
X-Google-Smtp-Source: APXvYqxykIhYXij1dTIeYKxDSe8XNN/wtOxQL4PwKS6gv6ZYDsmTtZv/ytTm5HBebEkq4urkt9c2YQ==
X-Received: by 2002:ac2:54b1:: with SMTP id w17mr12021817lfk.128.1574427398199;
        Fri, 22 Nov 2019 04:56:38 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk (borgediget.toke.dk. [85.204.121.218])
        by smtp.gmail.com with ESMTPSA id u184sm2950626lja.86.2019.11.22.04.56.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2019 04:56:37 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id EB1771800B9; Fri, 22 Nov 2019 13:56:36 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Johannes Berg <johannes@sipsolutions.net>,
        Kan Yan <kyan@google.com>
Cc:     linux-wireless@vger.kernel.org,
        make-wifi-fast@lists.bufferbloat.net, nbd@nbd.name,
        yiboz@codeaurora.org, john@phrozen.org, lorenzo@kernel.org,
        rmanohar@codeaurora.org, kevinhayes@google.com
Subject: Re: [PATCH v11 2/4] mac80211: Import airtime calculation code from mt76
In-Reply-To: <c6f0bd8c87375824e55dc105a78c4479683139a6.camel@sipsolutions.net>
References: <20191119060610.76681-1-kyan@google.com> <20191119060610.76681-3-kyan@google.com> <c6f0bd8c87375824e55dc105a78c4479683139a6.camel@sipsolutions.net>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 22 Nov 2019 13:56:36 +0100
Message-ID: <87r2203w8r.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: uMbTqXMoOhq4kLkNnqwZeQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Johannes Berg <johannes@sipsolutions.net> writes:

> On Mon, 2019-11-18 at 22:06 -0800, Kan Yan wrote:
>>=20
>> +#define HE_GROUP_IDX(_streams, _gi, _bw)=09=09=09=09\
>> +=09(IEEE80211_HE_GROUP_0 +=09=09=09=09=09\
>> +=09 IEEE80211_HE_MAX_STREAMS * 2 * (_bw) +=09=09=09\
>> +=09 IEEE80211_HE_MAX_STREAMS * (_gi) +=09=09=09=09\
>> +=09 (_streams) - 1)
>
> I'll also fix that to be " * 3" instead of 2, since there are 3 possible
> _gi values.

Ah yes, good catch, thanks!

-Toke

