Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89F281714BD
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Feb 2020 11:07:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728681AbgB0KHg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Feb 2020 05:07:36 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25021 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728454AbgB0KHg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Feb 2020 05:07:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582798055;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gNmqYYh8IkvOzoThAYHg0T+VuNTkTQWybQ70SZPEJMM=;
        b=S3/dJ6WgN6MhIe4KrwIQYCVyP/y83waklKdg/86UI6dTSc4tcOXc0gJYvDQlCS640PpPgg
        vVErqo6Kcl9U5Fl/XZcbj/pjNz6QbKt1ea6nz2OVCGnwYbo9qKMf2QYQeeDqCd2Gwmwq2Z
        DReOGoO615wpY1UszcKoox83F1iZjAw=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-108-2zsUyVFNN4u6sqbe3spPYA-1; Thu, 27 Feb 2020 05:07:33 -0500
X-MC-Unique: 2zsUyVFNN4u6sqbe3spPYA-1
Received: by mail-lj1-f199.google.com with SMTP id k25so729177lji.4
        for <linux-wireless@vger.kernel.org>; Thu, 27 Feb 2020 02:07:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=gNmqYYh8IkvOzoThAYHg0T+VuNTkTQWybQ70SZPEJMM=;
        b=r+sNSyYQcrGzboWn0t24nChJ+UITi3gO20Tca7tIMeRCzUaQ0KGSErNMXn03wzFjVq
         Rl2Jo+R4Ci66aX7Bau/olidvs91XoK2aIJd5NhSFrGPncvsfpE96YQu4ogrrm5m/sHnx
         YchsDe0jX6z1g70Oy51h0c0xBGqjxtyS0Kyd0mPqjSwssCD2DOVQ9FuVcAb5zHMRRB8T
         IQjM+gO0FnQufBc5gOFlHkqLBAlFw8RMlrykbiWCkCJ/wNtQy7UT4wzZyslvu6gdo03u
         ewNFrVRa4njqk7sZF4pJlcQqbWWnNVL9nx8oGhTNxnsogDhdoJxcMa4XF4qVgKNTH8J0
         e0lg==
X-Gm-Message-State: ANhLgQ3YGNVLBsOCYfAIIxeufK1+nlZ5OUi9u4YiMmxZu/0KfrxdgGew
        /WHlFoFVylFl3T93Ldest+vymPgYnjbRdPCA0nXYtEpve1sup3qheQxkDu9oT8NA2rHTlKjER3X
        uX0w+pVwwQKjHgzT1/kh+2JLCUBI=
X-Received: by 2002:ac2:4467:: with SMTP id y7mr1765208lfl.167.1582798051197;
        Thu, 27 Feb 2020 02:07:31 -0800 (PST)
X-Google-Smtp-Source: ADFU+vsgXzP7lGW2gpvb3qLFRp1BhIv/wjC1Y4iIdVaqOc7roMwNM3xAQGYBq/T/10hhj1aEUeDNsw==
X-Received: by 2002:ac2:4467:: with SMTP id y7mr1765195lfl.167.1582798050898;
        Thu, 27 Feb 2020 02:07:30 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id n132sm2974879lfd.81.2020.02.27.02.07.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 02:07:30 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 72690180362; Thu, 27 Feb 2020 11:07:29 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Felix Fietkau <nbd@nbd.name>, Kan Yan <kyan@google.com>,
        johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        make-wifi-fast@lists.bufferbloat.net, yiboz@codeaurora.org,
        john@phrozen.org, lorenzo@kernel.org, rmanohar@codeaurora.org,
        kevinhayes@google.com
Subject: Re: [PATCH v11 4/4] mac80211: Use Airtime-based Queue Limits (AQL) on packet dequeue
In-Reply-To: <829b6b28-99cd-ea9d-fea3-603a10eae401@nbd.name>
References: <20191119060610.76681-1-kyan@google.com> <20191119060610.76681-5-kyan@google.com> <789d592c-5b1b-b785-6d9c-86b7cc7d57f4@nbd.name> <87k149xbb4.fsf@toke.dk> <829b6b28-99cd-ea9d-fea3-603a10eae401@nbd.name>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 27 Feb 2020 11:07:29 +0100
Message-ID: <875zfsxs0u.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Felix Fietkau <nbd@nbd.name> writes:

> On 2020-02-26 22:56, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Felix Fietkau <nbd@nbd.name> writes:
>>> - We need an API that allows the driver to change the pending airtime
>>> values, e.g. subtract estimated tx time for a packet.
>>> mt76 an ath9k can queue packets inside the driver that are not currently
>>> in the hardware queues. Typically if the txqs have more data than what
>>> gets put into the hardware queue, both drivers will pull an extra frame
>>> and queue it in its private txq struct. This frame will get used on the
>>> next txq scheduling round for that particular station.
>>> If you have lots of stations doing traffic (or having driver buffered
>>> frames in powersave mode), this could use up a sizable chunk of the AQL
>>> budget.
>>=20
>> I'm a bit more skeptical about this. If the driver buffers a bunch of
>> packets that are not accounted that will hurt that station due to extra
>> latency when it wakes up. For ath9k, this is the retry_q you're talking
>> about, right? The number of packets queued on that is fairly limited,
>> isn't it? What kind of powersave buffering is the driver doing, and why
>> can't it leave the packets on the TXQ? That would allow them to be
>> scheduled along with any new ones that might have arrived in the
>> meantime, which would be a benefit for latency.
> For mt76 there should be max. 1 frame in the retry queue, it's just a
> frame that was pulled from the txq in a transmission attempt but that it
> couldn't put in the hw queue because it didn't fit in the current
> aggregate batch.

Wait, if it's only a single frame that is queued in the driver, how is
this causing problems? We deliberately set the limit so there was a bit
of slack above the size of an aggregate for things like this. Could you
please describe in a bit more detail what symptoms you are seeing of
this problem? :)

-Toke

