Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 732B217168D
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Feb 2020 12:59:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728987AbgB0L70 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Feb 2020 06:59:26 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35090 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728885AbgB0L7Z (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Feb 2020 06:59:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582804764;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tvWOj8GhzIrQBJYlKjhzfjzWLprj83uRktU1gXJnIBY=;
        b=UFKFYy9iDVlwyfKVg3XmZhBwKPu8cAWz1eQn7auK0hQPRuasKY7VN44F/0l7eSwMKWQVNk
        IypNgZfNJjROIcpRhMvgpWPMVEn3dvH3dZgkTOtupMfGStgmRSFeqUk7AFjwb28ZEDShK1
        H/bPqbLDw9xqw8/oiPnaDn8IJ61k+Aw=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-341-6KWiON5hNDKpqAs3R7NM5g-1; Thu, 27 Feb 2020 06:59:22 -0500
X-MC-Unique: 6KWiON5hNDKpqAs3R7NM5g-1
Received: by mail-lf1-f70.google.com with SMTP id l3so331379lfg.14
        for <linux-wireless@vger.kernel.org>; Thu, 27 Feb 2020 03:59:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=tvWOj8GhzIrQBJYlKjhzfjzWLprj83uRktU1gXJnIBY=;
        b=b5X6EzuEK6Xych2Ids+YIofHNh7RpkXCUnRaB9S7j3jUKgsNikEhdUr4HZZ8+3j9S3
         CHbJdVh+KwqW+CEjEN/QdIsSZwlJ1X/ceBHTKOmF1rEyF2AGz3UOgWMf584J4QbHJBNY
         3qMo2j72TyyX5KIm82kysx1RCthj4PGXKH3Kbg3qZbtND/nMydyNHog2aD/JqHK2uoNK
         JG8YW/m1GLV33umYv6KKPLpmzhsGvlzaf5W+zOFWNvAOThFv4yAJaj+Jyp6ittHImnNj
         bs5KqYeZlbTtLBhnV+4l3aAPbczCIFWrcwrsF4FkWX2c8eYTsoLlh3nkYlDgxV85m9yr
         HzAQ==
X-Gm-Message-State: ANhLgQ2shNHISlLH9ko/L1Ei1g7P1M8S88b3yXuKzfbxYv37mnGSXHZJ
        Bwr2NmQFEf0gBD8hpvqi9RLsJeJW1I0CjEbJX1LAlYJMwl9hD/t+WNjYFY8WmsrXKsf013GvV7/
        BKkm4V0nkSxuMD3N7iexwCIDlqas=
X-Received: by 2002:a19:87:: with SMTP id 129mr1970025lfa.217.1582804761166;
        Thu, 27 Feb 2020 03:59:21 -0800 (PST)
X-Google-Smtp-Source: ADFU+vscvrwvI+VIxLYFogI/O7O1aI5Y8wStH2CKVZdlGMcDvGeA15hyEByB1o6IEXSk7cmeKP/Mpg==
X-Received: by 2002:a19:87:: with SMTP id 129mr1970014lfa.217.1582804760883;
        Thu, 27 Feb 2020 03:59:20 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a28sm674276ljp.64.2020.02.27.03.59.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 03:59:20 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id BC8BC180362; Thu, 27 Feb 2020 12:59:19 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Felix Fietkau <nbd@nbd.name>, Kan Yan <kyan@google.com>,
        johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        make-wifi-fast@lists.bufferbloat.net, yiboz@codeaurora.org,
        john@phrozen.org, lorenzo@kernel.org, rmanohar@codeaurora.org,
        kevinhayes@google.com
Subject: Re: [PATCH v11 4/4] mac80211: Use Airtime-based Queue Limits (AQL) on packet dequeue
In-Reply-To: <04284fb6-4a68-8449-4105-dcf90f128ef8@nbd.name>
References: <20191119060610.76681-1-kyan@google.com> <20191119060610.76681-5-kyan@google.com> <789d592c-5b1b-b785-6d9c-86b7cc7d57f4@nbd.name> <87k149xbb4.fsf@toke.dk> <829b6b28-99cd-ea9d-fea3-603a10eae401@nbd.name> <875zfsxs0u.fsf@toke.dk> <04284fb6-4a68-8449-4105-dcf90f128ef8@nbd.name>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 27 Feb 2020 12:59:19 +0100
Message-ID: <874kvcw8a0.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Felix Fietkau <nbd@nbd.name> writes:

> On 2020-02-27 11:07, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Felix Fietkau <nbd@nbd.name> writes:
>>=20
>>> On 2020-02-26 22:56, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>>>> Felix Fietkau <nbd@nbd.name> writes:
>>>>> - We need an API that allows the driver to change the pending airtime
>>>>> values, e.g. subtract estimated tx time for a packet.
>>>>> mt76 an ath9k can queue packets inside the driver that are not curren=
tly
>>>>> in the hardware queues. Typically if the txqs have more data than what
>>>>> gets put into the hardware queue, both drivers will pull an extra fra=
me
>>>>> and queue it in its private txq struct. This frame will get used on t=
he
>>>>> next txq scheduling round for that particular station.
>>>>> If you have lots of stations doing traffic (or having driver buffered
>>>>> frames in powersave mode), this could use up a sizable chunk of the A=
QL
>>>>> budget.
>>>>=20
>>>> I'm a bit more skeptical about this. If the driver buffers a bunch of
>>>> packets that are not accounted that will hurt that station due to extra
>>>> latency when it wakes up. For ath9k, this is the retry_q you're talking
>>>> about, right? The number of packets queued on that is fairly limited,
>>>> isn't it? What kind of powersave buffering is the driver doing, and why
>>>> can't it leave the packets on the TXQ? That would allow them to be
>>>> scheduled along with any new ones that might have arrived in the
>>>> meantime, which would be a benefit for latency.
>>> For mt76 there should be max. 1 frame in the retry queue, it's just a
>>> frame that was pulled from the txq in a transmission attempt but that it
>>> couldn't put in the hw queue because it didn't fit in the current
>>> aggregate batch.
>>=20
>> Wait, if it's only a single frame that is queued in the driver, how is
>> this causing problems? We deliberately set the limit so there was a bit
>> of slack above the size of an aggregate for things like this. Could you
>> please describe in a bit more detail what symptoms you are seeing of
>> this problem? :)
> It would be a single frame per sta/txq. I don't know if it will cause
> problems in practice, it's just a potential corner case that I found
> during review. I'd imagine this would probably show up in some
> benchmarks at least.
> I'm not seeing any symptoms myself, but I also haven't run any intricate
> tests yet.

See my other reply; I'm not convinced this behaviour is wrong :)

-Toke

