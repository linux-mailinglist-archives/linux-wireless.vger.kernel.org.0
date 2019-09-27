Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C2FAC01C5
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Sep 2019 11:07:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725911AbfI0JHT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 27 Sep 2019 05:07:19 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:50919 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725882AbfI0JHT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 27 Sep 2019 05:07:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1569575238;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1MCWdr3UZAx/IJlmu6bG99C2RPNYkY5L3Vfl+xVvhE8=;
        b=Kz+nBuKw2H/Q0X9CCDCftnIhDH8lAle0YzjcXb7BX5Gu91ew1o3fdTGOCxz0258H+m8gNe
        6vinXKIuPQcyv6IC4TSgf4fXxJ4ekbZoRdA53PMUBAcFlbw1LvPzoV39TLminouybCZHNF
        /7B4sK4zkxQIzFsD5Se8SAQPKZfNYjQ=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-127-UDaWo9KwOWGK8Soo3yD18A-1; Fri, 27 Sep 2019 05:07:14 -0400
Received: by mail-ed1-f70.google.com with SMTP id t13so1245919edr.2
        for <linux-wireless@vger.kernel.org>; Fri, 27 Sep 2019 02:07:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=1MCWdr3UZAx/IJlmu6bG99C2RPNYkY5L3Vfl+xVvhE8=;
        b=Jlv8XI3TV6oushxVMolUysGjnjUxk+OUTBO4K+NnEguSUDNKfezSZu+NJDyWeJO+qX
         sVpjz3vq8oBR5ShT1vifHlYMxXbwR10mLhd6T7fheYl4HYrTz/+UzeamKdJ3jopIGHrJ
         TtyNvPnYiK5WRVdcz426XNPZIsh2pTfKcwzGoC68oskD//WjPWg6fFjoLNian8UCtm82
         GTOj9wr2VeN5LcuJN1NsPeX6a+uAM6+f05AkEC3KkKuNRN2m9E5cvuyJJMhjdL1NPTJ8
         2pxImFZUdrj1DCPHLeg54lEjFyqhYYLPYdS5+NRZymTw6wIy+30gEqx1F0sMeAiAj1eR
         LbjQ==
X-Gm-Message-State: APjAAAUmEkzg/yNxyQbzI8fG7+xP7gRyWRv2UItRORb45oTAPeHpKRBQ
        Lwl/12wRPjId8+u9ntQZsJYzYRx+bugUIkSvG3ifcM/yiB1tIod7+COD66WfhTb8S/4GWKftKpF
        m9j8Q9JEUBGiCfXAMweGFO0eWW6s=
X-Received: by 2002:a17:907:441d:: with SMTP id om21mr7049350ejb.188.1569575233483;
        Fri, 27 Sep 2019 02:07:13 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwmCn5L6IdSpY+W/ZXeAp0l6OXfbk5dsfDaCfmvhbM88Za/j2Ny7xsTTrpKxAw5HpXzhqBpeQ==
X-Received: by 2002:a17:907:441d:: with SMTP id om21mr7049335ejb.188.1569575233277;
        Fri, 27 Sep 2019 02:07:13 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (borgediget.toke.dk. [85.204.121.218])
        by smtp.gmail.com with ESMTPSA id 36sm394820edz.92.2019.09.27.02.07.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2019 02:07:12 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 2F57318063D; Fri, 27 Sep 2019 11:07:12 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org
Subject: Re: [PATCH 10/15] mt76: mt76x02: track approximate tx airtime for airtime fairness and survey
In-Reply-To: <27bb95dd-1f0e-5862-3616-04452808e736@nbd.name>
References: <20190926174732.42375-1-nbd@nbd.name> <20190926174732.42375-10-nbd@nbd.name> <871rw218ty.fsf@toke.dk> <2475938e-b82c-9924-f7db-f475ec2530b3@nbd.name> <87sgoiyw0p.fsf@toke.dk> <27bb95dd-1f0e-5862-3616-04452808e736@nbd.name>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 27 Sep 2019 11:07:12 +0200
Message-ID: <87mueqyunz.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: UDaWo9KwOWGK8Soo3yD18A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Felix Fietkau <nbd@nbd.name> writes:

> On 2019-09-27 10:37, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Felix Fietkau <nbd@nbd.name> writes:
>>=20
>>> On 2019-09-27 09:45, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>>>> Felix Fietkau <nbd@nbd.name> writes:
>>>>=20
>>>>> Estimate by calculating duration for EWMA packet size + estimated A-M=
PDU
>>>>> length on tx status events
>>>>=20
>>>> Would it make sense to move some of this code into mac80211? If we're
>>>> going to do airtime estimation for queue limiting it may make sense to
>>>> use this instead of the simplistic estimate I used in my RFC patch?
>>> Sure. I mainly put it in the driver because I wanted to get it working,
>>> tested and merged first without having to wait for a mac80211-next ->
>>> wireless-drivers-next merge.
>>=20
>> Right, OK. So that means another patch set on top of this to move it
>> afterwards? Don't suppose you can be convinced to take care of that as
>> well? :)
> I could, but I don't know when I will have time for it, since my plate
> is pretty full at the moment.

Heh, I was afraid you'd say that. That makes two of us; guess we'll see
who gets around to it first, then :)

Is there anything in your new airtime.c that is mt76-specific apart from
the struct mt76_dev and struct mt76_rx_status parameters?

-Toke

