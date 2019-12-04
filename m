Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37C87112D83
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Dec 2019 15:34:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728011AbfLDOen (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Dec 2019 09:34:43 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36823 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727867AbfLDOen (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Dec 2019 09:34:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575470082;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gUM078+h5giMXoWVhy0lp59z8XTgxUGEf6h7jHk5+CA=;
        b=QSZTx6u5KL7bC28WPIkf9QnFSa7I3tVprN7Ajl8t8LEjhGV7Xq7E6T6pc3O7cTqeLgLC3W
        JJHuS2KSeLeNoo1QoH2PwOYR4eq0m8QFTiBX0s6CSxlC97raTaXB9/1gFvKItVFd1LtA2F
        li//Ot2H2NsrTAYir5J97+J7UM3PNHg=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-217-xqpHOeXiP0yZS02QsiqQIA-1; Wed, 04 Dec 2019 09:34:41 -0500
Received: by mail-lf1-f70.google.com with SMTP id q17so1961116lfo.14
        for <linux-wireless@vger.kernel.org>; Wed, 04 Dec 2019 06:34:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=mlXaGuV5BihlPPhn0yVGmPDI+Nzcq6DL6sF883ku91g=;
        b=eIF/SWrWMv/3s1gKitWxBEfq70kIMxoiTsU/of5jhwKgjElo6PXQgkB/Gb7LtV7nYO
         zlF0sJucLVmxktT7UOVRwmjqB9ZKgeJeKRUrIoo6YHaaMmc7NBsECa8Kq+IjnThA9bZ/
         ZRDgJPi+eaU7VobWa0FbZysup0S24yrhmooQaEVC2Vv0HQz25NfCVWocaQFi9LMRKLeW
         XGlqLyIOrsrIKWHNHwU1L8S4jnC3q+PZjYaWBuEa0bT4hP+V0fEJSyLxwMq20+Ta6J2S
         GI2hJN+EzZIyDK2udI7QSoMAn+pMM3/v8DCcPg3cPMVsq/9xGZ2qzt/q/iN6ZFVsbcZ7
         c8Kw==
X-Gm-Message-State: APjAAAWFBmg547ddIMoCElX7QT823r/EOuy/HhiBj7BOemOHCpQ25LZL
        WmWDcn/iV2uVowQMo55HOxrYS1yyjshhLkLZBnSBjk26SUN/tA8xNDA43/hRr2i9RPqxAq/Jjt3
        8lIPEdpNYgPmCXx6j6nWNbWTXzGs=
X-Received: by 2002:a2e:144b:: with SMTP id 11mr2215667lju.216.1575470079588;
        Wed, 04 Dec 2019 06:34:39 -0800 (PST)
X-Google-Smtp-Source: APXvYqzVbSSdamWizvDg0lqfLewdrkKbeuz6FOXWSpvaW7AcIZIH14ENB7bqe2Q6uhM78A9KZt76mw==
X-Received: by 2002:a2e:144b:: with SMTP id 11mr2215647lju.216.1575470079217;
        Wed, 04 Dec 2019 06:34:39 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id z5sm3234924lji.32.2019.12.04.06.34.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 06:34:38 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 50F0318193A; Wed,  4 Dec 2019 15:34:36 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Johannes Berg <johannes@sipsolutions.net>,
        Kalle Valo <kvalo@codeaurora.org>, Kan Yan <kyan@google.com>
Cc:     Dave Taht <dave@taht.net>,
        Rajkumar Manoharan <rmanohar@codeaurora.org>,
        Kevin Hayes <kevinhayes@google.com>,
        Make-Wifi-fast <make-wifi-fast@lists.bufferbloat.net>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Yibo Zhao <yiboz@codeaurora.org>,
        John Crispin <john@phrozen.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Felix Fietkau <nbd@nbd.name>
Subject: Re: [Make-wifi-fast] [PATCH v8 0/2] Implement Airtime-based Queue Limit (AQL)
In-Reply-To: <fa98f3b62454370ef6c1951571ba1789ac2679c3.camel@sipsolutions.net>
References: <20191115014846.126007-1-kyan@google.com> <CA+iem5vaeLR6v_nZ1YUZhfj32wF0DrvC2nyp8nb8qYAZLQjLdw@mail.gmail.com> <CAA93jw5wTbFV51oFJ6tFHLUMo=bau8fbU65k57bQjOHGJoCkkQ@mail.gmail.com> <CA+iem5s4ZY239Q4=Gwy3WrmVhcdhesirXph6XQoOP5w-nuWcYw@mail.gmail.com> <CAA93jw5t0TwBVv7_DVkJ_-NsVn0ODNHwU0orp2-+LPB45iFVoQ@mail.gmail.com> <CA+iem5uVJFcCYpJfhker-48XPrOf3a+NWr-nKnBtGmLX2yB_Lg@mail.gmail.com> <8736eiam8f.fsf@toke.dk> <CA+iem5tpfEmaWJ5Mw7xF9fb=XLceZpC1LM4Avo89Mn1fL7YZVw@mail.gmail.com> <87a78p8rz7.fsf@toke.dk> <CA+iem5tNz2jjEOVmbh3aPTXLLZfkRjZ60-+bon1vDEJ8D4hQJw@mail.gmail.com> <87muco5gv5.fsf@toke.dk> <CA+iem5sBPq0mfz+Qx+uJqCZ6t-Cjru+GCBcYExdu6JueUbBXyw@mail.gmail.com> <87eexvyoy8.fsf@toke.dk> <878so2m5gp.fsf@nemesis.taht.net> <CA+iem5vVGSJXeB8k2n32f=TvqncEj+bOjVbunWS0G8sm_MEosw@mail.gmail.com> <0101016ecf3bc899-6e391bba-96ed-4495-a7be-1aa8dd8f1bf2-000000@us-west-2.amazonses.com> <fa98f3b62454370ef6c1951571ba1789ac2679c3.camel@sipsolutions.net>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 04 Dec 2019 15:34:36 +0100
Message-ID: <87a788noqr.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: xqpHOeXiP0yZS02QsiqQIA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Johannes Berg <johannes@sipsolutions.net> writes:

> On Wed, 2019-12-04 at 04:47 +0000, Kalle Valo wrote:
>>=20
>> > Overall, I think AQL and fq_codel works well, at least with ath10k.
>> > The current target value of 20 ms is a reasonable default.  It is
>> > relatively conservative that helps stations with weak signal to
>> > maintain stable throughput. Although, a debugfs entry that allows
>> > runtime adjustment of target value could be useful.
>>=20
>> Why not make it configurable via nl80211? We should use debugfs only for
>> testing and debugging, not in production builds, and to me the use case
>> for this value sounds like more than just testing.
>
> On the other hand, what application/tool or even user would be able to
> set this correctly?

Well, it's not inconceivable that someone might write a tool to
dynamically tune this; we do allow it to be changed at the qdisc layer
after all.

But until such a time as someone does that, I agree that it's not
terribly likely such a knob is going to see much use. As Kan's results
show, for inter-flow latency (like what the separate ping in his test is
showing), the FQ part takes care of the latency, and what's left there
is the AQL buffering. So I'm a little bit "meh" about this; wouldn't
object to making it a knob, but don't think I'm going to spend the time
writing that patch myself :)

-Toke

