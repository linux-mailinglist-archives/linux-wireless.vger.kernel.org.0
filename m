Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6278C0151
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Sep 2019 10:38:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbfI0IiE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 27 Sep 2019 04:38:04 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:33973 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725992AbfI0IiE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 27 Sep 2019 04:38:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1569573483;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Wimtw3Y315R3DNOCoFynn62O0NQDD9wdcLnPPzrls98=;
        b=iUlf9q3X7qgtwg2yzJe9n3/KYJX+1YWd5JS0MWZt/m/7Tb3Wr2NpJd1tp098FZj8hPm9wB
        6beu5fqp4rTn+G/Z3wO4qKfqN9+7Nrb4AZwo7+z59maSP/SIPD2FJ8PNROq5uDGqk3m97e
        x0SWLEClk/lh5n77wEkUnRQgrpaAIPE=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-41-Iq-6GjizMnCzHXvQazW6Cg-1; Fri, 27 Sep 2019 04:38:01 -0400
Received: by mail-lj1-f198.google.com with SMTP id p14so920496ljh.22
        for <linux-wireless@vger.kernel.org>; Fri, 27 Sep 2019 01:38:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=JNUGbB/iwn8xoyPetuC8IVNBXC877AUULxV/nS/7GP4=;
        b=TNGbD319sTv95bkymryH7cKAZ/YbM9oN+EL4P7Me0pvk41c7JMnqAQIxLD9yjUnNul
         AE1GYh3wuiBqOf1ZUofTcu9nO4JpALnIg5phgVcqnK5crpS8LCayPgUbqRwE2dzgE59a
         e4gEnTg9OLgqL39MKe524k21xjht2eC/1Kd1I+t6lJlX8MBPOlNQm0wJdnTtY2NOTjbA
         4lcVRSoxSZVe/XppXdAASu6P+xhpQS3sPfGeBRDEsjJVYvECrmrfm5EiJKeSjm/grA3f
         1OO1P4ruqsD3pZLXl4JPayu8M5LYfOZ2WX1Jzd/3czji/ocvTEmF9tPKqF2zfAynP0dT
         skVA==
X-Gm-Message-State: APjAAAVukRpHAsX3Ls4RzNJyS4Z9ZVBHSQ7qwvx2PsBBBAZIhYuP6Nzy
        fIprENZpiGJyX/3xd4k9D+PG525RKMueAgH1jpB1PPXbUxtKxUqFp3/GUYQ3grfl+7aVWizRepc
        ITlXxUrOVunTetYavgn+SRfQxkR0=
X-Received: by 2002:a2e:9a50:: with SMTP id k16mr1985623ljj.221.1569573480069;
        Fri, 27 Sep 2019 01:38:00 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxHGryRXHWa7LvdWtt8Tmg9PQbOakri386DAPHk9qlhl8x1pitkKnH9SEzdALtrIniay7xNKg==
X-Received: by 2002:a2e:9a50:: with SMTP id k16mr1985617ljj.221.1569573479897;
        Fri, 27 Sep 2019 01:37:59 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (borgediget.toke.dk. [85.204.121.218])
        by smtp.gmail.com with ESMTPSA id 6sm340845lfa.24.2019.09.27.01.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2019 01:37:59 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id A984D18063D; Fri, 27 Sep 2019 10:37:58 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org
Subject: Re: [PATCH 10/15] mt76: mt76x02: track approximate tx airtime for airtime fairness and survey
In-Reply-To: <2475938e-b82c-9924-f7db-f475ec2530b3@nbd.name>
References: <20190926174732.42375-1-nbd@nbd.name> <20190926174732.42375-10-nbd@nbd.name> <871rw218ty.fsf@toke.dk> <2475938e-b82c-9924-f7db-f475ec2530b3@nbd.name>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 27 Sep 2019 10:37:58 +0200
Message-ID: <87sgoiyw0p.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: Iq-6GjizMnCzHXvQazW6Cg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Felix Fietkau <nbd@nbd.name> writes:

> On 2019-09-27 09:45, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Felix Fietkau <nbd@nbd.name> writes:
>>=20
>>> Estimate by calculating duration for EWMA packet size + estimated A-MPD=
U
>>> length on tx status events
>>=20
>> Would it make sense to move some of this code into mac80211? If we're
>> going to do airtime estimation for queue limiting it may make sense to
>> use this instead of the simplistic estimate I used in my RFC patch?
> Sure. I mainly put it in the driver because I wanted to get it working,
> tested and merged first without having to wait for a mac80211-next ->
> wireless-drivers-next merge.

Right, OK. So that means another patch set on top of this to move it
afterwards? Don't suppose you can be convinced to take care of that as
well? :)

> If we move it to mac80211, we can also make ath9k use it. My
> implementation should be faster than the ath9k duration calculation.

SGTM!

-Toke

