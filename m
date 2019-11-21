Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8866E105004
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Nov 2019 11:05:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbfKUKFY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 21 Nov 2019 05:05:24 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:27977 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726529AbfKUKFY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 21 Nov 2019 05:05:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574330723;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PKJaj7sZjc6579dv29AEceQXePo8ctco2c9W8uoDneA=;
        b=I9EuNpwBQtQhMpVHFfDSBGULjn1fBrwDDujknEJPk1WhRMMRrV3bdjGaYpYZPl65D1OuB8
        qUt1RBQuhpExzLm6JIBkG5ocwCcDLssn2xBjy/KFlIcQ8L+xn4Fu6T3CiKG071Pg0yGqgj
        xG/zNPJpIULEQx9D7yVLt0Wc8MiciCA=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-349-8EZ2ZZ0iMW2yjXcmvsm7Dg-1; Thu, 21 Nov 2019 05:05:20 -0500
Received: by mail-lj1-f200.google.com with SMTP id e17so452015ljj.12
        for <linux-wireless@vger.kernel.org>; Thu, 21 Nov 2019 02:05:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=//BqCXRTQqZ/4bta4yIpsp57qADMVHEdiZm1YRgSpeA=;
        b=iLuQQnPib8wnF896oMbgOnKkKxO3n3i6iZn5+7TVNj6y1PXYPCyjsGTseEZ6kv97Ve
         lppZLiCWAainW1pgucdXszRKdXyZlN8bXOzP0xJZ7YdBAvCsoyMQMGpO3FJCbC3tIUDF
         0kNh+z9xtx7k9JcJAq8HxdXvwoTVllhOS9LooJuXDRCVmdYC5L0XCIn9eqC7XA65vo1d
         5kfxCywcpus0X8h2oXvgQwRY/zGOaabZjatA9nc/58ov5HxFhs2EUDOKdgSgKCzcAcse
         19P7oQ1YfGn4zRQ5oaH96vQlj6JKnUavGcAmLE7YeSXhxllsMbp5D58aw17sL0SP+/wI
         tt+g==
X-Gm-Message-State: APjAAAUCwpYDa8Pj67JVMd69AhZVoQu0agP3u+TnUVrKVVHGRFMQNDSj
        y5vPdapt7slN/lVrklX8xFUB9C8Cc9SZyhns5tFkKZDv3kdQCi/qvSzcWeytJBWqdsfgLDtyUeg
        15pfoKocHi+mpj5xD20u0rnh5M3c=
X-Received: by 2002:a2e:7204:: with SMTP id n4mr6346094ljc.139.1574330718761;
        Thu, 21 Nov 2019 02:05:18 -0800 (PST)
X-Google-Smtp-Source: APXvYqzXXZK5aQ2sI3akJsmS3V+7YzHQ/ORRUwFTYPXJDdbx7Vs18vLc8MY97Tv2U8yVbABpVGsluw==
X-Received: by 2002:a2e:7204:: with SMTP id n4mr6346072ljc.139.1574330718505;
        Thu, 21 Nov 2019 02:05:18 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk (borgediget.toke.dk. [85.204.121.218])
        by smtp.gmail.com with ESMTPSA id y5sm1078673lfg.5.2019.11.21.02.05.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2019 02:05:17 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 65D611818B9; Thu, 21 Nov 2019 11:05:16 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Kan Yan <kyan@google.com>
Cc:     Dave Taht <dave.taht@gmail.com>,
        Rajkumar Manoharan <rmanohar@codeaurora.org>,
        Kevin Hayes <kevinhayes@google.com>,
        Make-Wifi-fast <make-wifi-fast@lists.bufferbloat.net>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Yibo Zhao <yiboz@codeaurora.org>,
        John Crispin <john@phrozen.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Felix Fietkau <nbd@nbd.name>
Subject: Re: [Make-wifi-fast] [PATCH v8 0/2] Implement Airtime-based Queue Limit (AQL)
In-Reply-To: <CA+iem5tpfEmaWJ5Mw7xF9fb=XLceZpC1LM4Avo89Mn1fL7YZVw@mail.gmail.com>
References: <20191115014846.126007-1-kyan@google.com> <CA+iem5vaeLR6v_nZ1YUZhfj32wF0DrvC2nyp8nb8qYAZLQjLdw@mail.gmail.com> <CAA93jw5wTbFV51oFJ6tFHLUMo=bau8fbU65k57bQjOHGJoCkkQ@mail.gmail.com> <CA+iem5s4ZY239Q4=Gwy3WrmVhcdhesirXph6XQoOP5w-nuWcYw@mail.gmail.com> <CAA93jw5t0TwBVv7_DVkJ_-NsVn0ODNHwU0orp2-+LPB45iFVoQ@mail.gmail.com> <CA+iem5uVJFcCYpJfhker-48XPrOf3a+NWr-nKnBtGmLX2yB_Lg@mail.gmail.com> <8736eiam8f.fsf@toke.dk> <CA+iem5tpfEmaWJ5Mw7xF9fb=XLceZpC1LM4Avo89Mn1fL7YZVw@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 21 Nov 2019 11:05:16 +0100
Message-ID: <87a78p8rz7.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: 8EZ2ZZ0iMW2yjXcmvsm7Dg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kan Yan <kyan@google.com> writes:

>> It would be interesting to get some samples of the actual sojourn time
>> as seen by CoDel in mac80211. Might be doable with bpftrace...
>
> I will try to add some trace event to get the sojourn time for the
> next round of tests.

In theory, this ought to produce a histogram of sojourn times (in
microseconds):

bpftrace -e 'kretprobe:codel_skb_time_func { @sojourn =3D lhist((nsecs - (r=
etval << 10))/1000, 0, 100000, 1000); }'


Can't get the CoDel drop mechanism to trigger on my system at all,
though (a laptop running on iwl). I guess because there's queue
backpressure to userspace first?

It would be interesting to see if it works for you, assuming you can get
bpftrace to work on your test system :)

-Toke

