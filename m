Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1098E112232
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Dec 2019 05:47:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbfLDErN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 3 Dec 2019 23:47:13 -0500
Received: from a27-10.smtp-out.us-west-2.amazonses.com ([54.240.27.10]:54682
        "EHLO a27-10.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726835AbfLDErN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 3 Dec 2019 23:47:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1575434832;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
        bh=XQopT6az1fhWqK9lODCmlfvuxZoA+ornaljxnXikdhM=;
        b=VtAkSCpiqgdQRtbukxHBxCC+f7OqJOITJhclocLqQY6dkVo9FcZYU6D7HcznjTxg
        SOoVje68kCOZCGU1AR6xLO26WhhMHD7OCQLhvAaZM17kLbo6wGFtFz3E50zdNa532XU
        SrZc821OGz8dXchNS7F3xjwa42RJ8w6M0WcFcSbc=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1575434832;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Feedback-ID;
        bh=XQopT6az1fhWqK9lODCmlfvuxZoA+ornaljxnXikdhM=;
        b=MbBmwP5Vg1meyeoV7BJDCGvyNWHeTp34EsnQ/Bu64o6ZBuWurjEQKVDmtbaam3W2
        MIj8SWDzGFkPdgpVdzWl1RBv/nkrb2KXi2Yyr63D2rCmRPS6R44Yoho58TqPNsUgMcT
        W0s5SbcBDm3qFs7D7RW3akzAuCo+fPzVC9KSekEc=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 92B22C433A2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Kan Yan <kyan@google.com>
Cc:     Dave Taht <dave@taht.net>,
        Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
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
References: <20191115014846.126007-1-kyan@google.com>
        <CA+iem5vaeLR6v_nZ1YUZhfj32wF0DrvC2nyp8nb8qYAZLQjLdw@mail.gmail.com>
        <CAA93jw5wTbFV51oFJ6tFHLUMo=bau8fbU65k57bQjOHGJoCkkQ@mail.gmail.com>
        <CA+iem5s4ZY239Q4=Gwy3WrmVhcdhesirXph6XQoOP5w-nuWcYw@mail.gmail.com>
        <CAA93jw5t0TwBVv7_DVkJ_-NsVn0ODNHwU0orp2-+LPB45iFVoQ@mail.gmail.com>
        <CA+iem5uVJFcCYpJfhker-48XPrOf3a+NWr-nKnBtGmLX2yB_Lg@mail.gmail.com>
        <8736eiam8f.fsf@toke.dk>
        <CA+iem5tpfEmaWJ5Mw7xF9fb=XLceZpC1LM4Avo89Mn1fL7YZVw@mail.gmail.com>
        <87a78p8rz7.fsf@toke.dk>
        <CA+iem5tNz2jjEOVmbh3aPTXLLZfkRjZ60-+bon1vDEJ8D4hQJw@mail.gmail.com>
        <87muco5gv5.fsf@toke.dk>
        <CA+iem5sBPq0mfz+Qx+uJqCZ6t-Cjru+GCBcYExdu6JueUbBXyw@mail.gmail.com>
        <87eexvyoy8.fsf@toke.dk> <878so2m5gp.fsf@nemesis.taht.net>
        <CA+iem5vVGSJXeB8k2n32f=TvqncEj+bOjVbunWS0G8sm_MEosw@mail.gmail.com>
Date:   Wed, 4 Dec 2019 04:47:12 +0000
In-Reply-To: <CA+iem5vVGSJXeB8k2n32f=TvqncEj+bOjVbunWS0G8sm_MEosw@mail.gmail.com>
        (Kan Yan's message of "Tue, 3 Dec 2019 11:02:44 -0800")
Message-ID: <0101016ecf3bc9c2-fe85d3a0-29d8-4854-b227-42552a4f064f-000000@us-west-2.amazonses.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-SES-Outgoing: 2019.12.04-54.240.27.10
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kan Yan <kyan@google.com> writes:

> Dave Taht <dave@taht.net> writes:
>
>> I hope to take a close look at the iwl ax200 chips soon. Unless
>> someone beats me to it. Can we get these sort of stats out of it?
>
> Here is a patch for the trace event I used to get the sojourn time:
> https://drive.google.com/open?id=3D1Mq8BO_kcneXBqf3m5Rz5xhEMj9jNbcJv
>
> Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com> writes:
>
>> While you're running tests, could you do one with the target changed to
>> 10ms, just to see what it looks like? Both sojourn time values and
>> throughput would be interesting here, of course.
>
> Apologize for the late reply. Here is the test results with target set to=
 10ms.
> The trace for the sojourn time:
> https://drive.google.com/open?id=3D1MEy_wbKKdl22yF17hZaGzpv3uOz6orTi
>
> Flent test for 20 ms target time vs 10 ms target time:
> https://drive.google.com/open?id=3D1leIWe0-L0XE78eFvlmRJlNmYgbpoH8xZ
>
> The sojourn time measured during throughput test with a relative good
> 5G connection has mean value around 11 ms, pretty close to the 10 ms
> target.
>
> A smaller CoDel "target" time could help reduce latency, but it may
> drop packets too aggressively for stations with low data rate and
> hurts throughput, as shown in one of the tests with 2.4 GHz client.
>
> Overall, I think AQL and fq_codel works well, at least with ath10k.
> The current target value of 20 ms is a reasonable default.  It is
> relatively conservative that helps stations with weak signal to
> maintain stable throughput. Although, a debugfs entry that allows
> runtime adjustment of target value could be useful.

Why not make it configurable via nl80211? We should use debugfs only for
testing and debugging, not in production builds, and to me the use case
for this value sounds like more than just testing.

--=20
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes
