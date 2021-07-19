Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C31CE3CD4DE
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Jul 2021 14:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236849AbhGSL6c (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 19 Jul 2021 07:58:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59623 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236811AbhGSL6c (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 19 Jul 2021 07:58:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626698351;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g+eOmEdbQkObH6hPMXhWT+Mb8xLXBrD2EVNtYBpuovE=;
        b=h5bcRzYPXUoUd6QhcSEx7/tss+SoEYsoDY6L/pAmypgch4cv+SE01IYZZYNTiyIHGWBVJa
        7Gw93jCSLUb6wG5xeE+/Gva+diq+0tlwnk9c47RDwmGpZ/APPQe1pmBL7vPLpQUhCrFLrD
        y+ledJQOQzXsBTZmXhUrkg69+eEybao=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-282-o8ee_RlHOuatCQp8bFX0bA-1; Mon, 19 Jul 2021 08:39:10 -0400
X-MC-Unique: o8ee_RlHOuatCQp8bFX0bA-1
Received: by mail-ed1-f70.google.com with SMTP id v4-20020a50a4440000b02903ab1f22e1dcso9234379edb.23
        for <linux-wireless@vger.kernel.org>; Mon, 19 Jul 2021 05:39:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=g+eOmEdbQkObH6hPMXhWT+Mb8xLXBrD2EVNtYBpuovE=;
        b=iIWke6f6Zanpxlg9y+Q5B66yePXYkXFla6Xq6xp1O7NzT4ZO5uWIqkLY1iqcF9USHb
         SflssLQdJQqr704+rENsfTHihbyb+jT0MwCgRlLjtMQergSZglrXsEf6uyzb9oD21ZCm
         pl7vz3Huqj5GY+UhDJbCmFC7dLxL+CJiw++y/0gvtgHj6D0bYDxqbxp4iMgAfw09qCxF
         XMl5Gib5nQN0n7nKN1oLllAK4mBybLDm4Rj4WZVqcRuBsLipFnCJJfC7qMQA2Z7Ac+Xe
         3+DCIucWWZ9MJww6alX3cHcPZhIe8c2QrEm5PP2U3bvjhY52Xi5nGST7ZGgw45knSuTQ
         CnLw==
X-Gm-Message-State: AOAM530NClsSMThvH8ja3D7FIGlX/f6S40W/bK+PhbbBXvYAH88RlM8E
        o6ZYW0fPQosx2QEotnlcWmB69OXOI6j5LhoSa9Jju/mpgPPT26ePkNKsBMWGxmlLAol9wx//oZw
        0MN125R95LvFNTRFfX/M9ALTDCKg=
X-Received: by 2002:a17:907:3f9a:: with SMTP id hr26mr26973478ejc.110.1626698349380;
        Mon, 19 Jul 2021 05:39:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwYXJO1RO5q1E/wM7iKRo9fsJSfs2RUJQ7+tGq5ZvuPF5cKCpl+N2uVicGElXLmilHqJa8JsA==
X-Received: by 2002:a17:907:3f9a:: with SMTP id hr26mr26973461ejc.110.1626698349190;
        Mon, 19 Jul 2021 05:39:09 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id o14sm704271eds.55.2021.07.19.05.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jul 2021 05:39:08 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id CF939180065; Mon, 19 Jul 2021 14:39:07 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH] mac80211: include <linux/rbtree.h>
In-Reply-To: <a79b70607711ec53ab3197a31fea13f21d2bf2f0.camel@sipsolutions.net>
References: <20210715180234.512d64dee655.Ia51c29a9fb1e651e06bc00eabec90974103d333e@changeid>
 <8735sav61j.fsf@toke.dk>
 <a79b70607711ec53ab3197a31fea13f21d2bf2f0.camel@sipsolutions.net>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Mon, 19 Jul 2021 14:39:07 +0200
Message-ID: <87tukqtr4k.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Johannes Berg <johannes@sipsolutions.net> writes:

> On Mon, 2021-07-19 at 14:31 +0200, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Johannes Berg <johannes@sipsolutions.net> writes:
>>=20
>> > From: Johannes Berg <johannes.berg@intel.com>
>> >=20
>> > This is needed for the rbtree, and we shouldn't just rely
>> > on it getting included somewhere implicitly. Include it
>> > explicitly.
>> >=20
>> > Signed-off-by: Johannes Berg <johannes.berg@intel.com>
>>=20
>> Does this need a Fixes: tag?
>
> We seem to always get it implicitly in the current kernel, so I guess
> not really necessary to backport or anything, I'd say no.
>
> I just ran into it while preparing a new backports import to our
> internal tree.

Alright, fair enough :)

-Toke

