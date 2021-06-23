Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1CDE3B16CF
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Jun 2021 11:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbhFWJ3l (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 23 Jun 2021 05:29:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57816 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229920AbhFWJ3k (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 23 Jun 2021 05:29:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624440443;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RLlcIADNVEZrtAcHj2h6w/jm4njSCgcno22R31dePUE=;
        b=bIcqYq8/YRX37mUMf/SjrfIQrPB+rknuyZcDvIUaGelvJMgEDfzjodxLO6Vs/evihlW65u
        DGRsp42c37X2CmE9KF7C+Jl/RLnvSdXj4q9He/E1qkrjSAC9rwU/9u5I2R2rC+C1hkCtvC
        SuknjALlWUqrtXdNTFjRZtAFa+vt+w8=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-307-wpHMlcnNOsK4DE5zN9qcnA-1; Wed, 23 Jun 2021 05:27:21 -0400
X-MC-Unique: wpHMlcnNOsK4DE5zN9qcnA-1
Received: by mail-ed1-f69.google.com with SMTP id j19-20020aa7c4130000b029039497d5cdbeso957333edq.15
        for <linux-wireless@vger.kernel.org>; Wed, 23 Jun 2021 02:27:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=RLlcIADNVEZrtAcHj2h6w/jm4njSCgcno22R31dePUE=;
        b=j/63pFyOgdAhDmeWQ4BNdT7jvPaPl8LtoQrbdZTxAF4f9SXHlHMZgFfgJx1T/41xCX
         dgFHwm6HE/XdDzYJDt94Een7tJHt/7NRNKzh+eI2SyPr9jN+KRecbLdISAWzlm5RN+y+
         IDsRJfHvIBGzQnGMH03M2DaciWc0F/Nv3GHMigheGYLZewJ82qLth8U2PGRSrhniUCpx
         q2mmNRLqsKTGY3zVBYZcsF6VmmVbAKI2FpXJWCqBNqYJtNuEdYCo1QOwdl6NaZURgd+b
         XJPVx6capmAXNVdHv3izkKfRXnctEOdqMQBYjAIeZZBHMlahr+sWWXfarxqkit4FFI7V
         GtqQ==
X-Gm-Message-State: AOAM530nNIBMFX3THVaV/z+NIvFQg4GGydIjVn9BHRgJ1C8UOvfnX829
        Kw1Exk2Psvuy0wYJEDh5PsBLKwRLB0mWfKgLlIv2Z4rsUpE9Kf3IukttDo2PPhvQWe864b/zZf7
        PuJBWgXlY1SoVNAtOPOrzgkFBVjs=
X-Received: by 2002:aa7:cf0a:: with SMTP id a10mr10888219edy.329.1624440440651;
        Wed, 23 Jun 2021 02:27:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw6DsQmKva0GCajbr1weRZMN61141xYEHht9jWO04YwA1uVzAskmfRAvJxDiHT4AjDAEC/JMQ==
X-Received: by 2002:aa7:cf0a:: with SMTP id a10mr10888201edy.329.1624440440477;
        Wed, 23 Jun 2021 02:27:20 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id g15sm7016179ejb.103.2021.06.23.02.27.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 02:27:19 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 07522180730; Wed, 23 Jun 2021 11:27:17 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
Cc:     make-wifi-fast@lists.bufferbloat.net, Felix Fietkau <nbd@nbd.name>,
        Rajkumar Manoharan <rmanohar@codeaurora.org>,
        Kan Yan <kyan@google.com>, Yibo Zhao <yiboz@codeaurora.org>
Subject: Re: [PATCH mac80211-next v8] mac80211: Switch to a virtual
 time-based airtime scheduler
In-Reply-To: <e1798568decc6df9b44ce97f48be523bdc92bdc4.camel@sipsolutions.net>
References: <20210507094851.180838-1-toke@redhat.com>
 <e1798568decc6df9b44ce97f48be523bdc92bdc4.camel@sipsolutions.net>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 23 Jun 2021 11:27:16 +0200
Message-ID: <87tulpnd6z.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Johannes Berg <johannes@sipsolutions.net> writes:

> On Fri, 2021-05-07 at 11:48 +0200, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> This switches the airtime scheduler in mac80211 to use a virtual time-ba=
sed
>
> Generally, we prefer <=3D72 columns in commit messages ... I started
> reformatting, but then your code also has a lot of places that go over
> 80 columns, so I gave up ... Can you please do that?

I thought the new limit was 100? :)

But sure, I can take a look and remove the unnecessary ones...

> Some refactoring, e.g. in sta_apply_parameters(), may also be in order.

Will take a look!

-Toke

