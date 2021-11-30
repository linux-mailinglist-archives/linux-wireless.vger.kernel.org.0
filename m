Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDDA946335C
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Nov 2021 12:50:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232022AbhK3Lxz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 30 Nov 2021 06:53:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:21310 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231616AbhK3Lxx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 30 Nov 2021 06:53:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638273034;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5GsdCAAOLzkmUmHN0yHPl3DVTDfUTRTiliCMWVUhYL0=;
        b=NhpS1gwzfd0skaLVzOleni0LhIAiyJYQxAYFx18/Iu5AspWxnnaVqgaUr7uGRXDVFYZByF
        ojCQzpWFmsHtKi2ghnhdF8zW5cXp65tbnH4B6BO2J2HlG+J3JXVWnhd9ru+xIOYQg/+auh
        LWEd2M8HHO3u0Iu4///3OX78aqehmh8=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-498-xD4DGcpkOzCTmmd9uQZuxA-1; Tue, 30 Nov 2021 06:50:33 -0500
X-MC-Unique: xD4DGcpkOzCTmmd9uQZuxA-1
Received: by mail-ed1-f69.google.com with SMTP id d13-20020a056402516d00b003e7e67a8f93so16757500ede.0
        for <linux-wireless@vger.kernel.org>; Tue, 30 Nov 2021 03:50:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=5GsdCAAOLzkmUmHN0yHPl3DVTDfUTRTiliCMWVUhYL0=;
        b=Dk2EkqWaEJwaeq8X/xSHPV2ONklDCugPFDfK+/QsPVnuEpi5tA0O9Xr5jaPKn1e76d
         eq7qrgLKs0EJRxWJGePBIhPBxGS/tgaV8j6A3EfS/05LwSGiO35HGEVyhhjxazqML1QS
         IhxvLDJe14dkaoAkylwxcmn8H/HY3WwJeOjCRVI9QNKmfCmsVBJYX5LDf7f0XqEgw92z
         zGIb0gnKMXuWpyK7rpVViP4bJ7qYyulBk3Yl7IrqVLJCA/xqrYjJHP16R2PrRRAHYyEB
         3hiBWfbcWmkKx8r72PHW4okF+Mlm1VG24kYlcSh0Iw+WTDJvZMP3L8k9sP47Cky2yzFJ
         k49Q==
X-Gm-Message-State: AOAM530rjM9nuyQBx9obIObFihBY2FCmJTJPJu9470VD9misfrVKu4O0
        TG6z+nwei9DSW3smIxlSsP365igwe9uX/MfkCihy05sStbD5pLTlbIepbl5fQPJK4okmhu2Y8ne
        hbEShVyYmYC1YkO+8tRWQYrJ0Vhk=
X-Received: by 2002:a17:906:54e:: with SMTP id k14mr65329470eja.268.1638273031388;
        Tue, 30 Nov 2021 03:50:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxKrywvIV3sRlwsoExU+pWxqJP1HULOpmk9hF9TZL0EnjKhSfw7wCy9ajnRHpSgMsOrfyZaOA==
X-Received: by 2002:a17:906:54e:: with SMTP id k14mr65329447eja.268.1638273031097;
        Tue, 30 Nov 2021 03:50:31 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id f17sm11303772edq.39.2021.11.30.03.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 03:50:30 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 748F61802A0; Tue, 30 Nov 2021 12:32:31 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Luca Coelho <luca@coelho.fi>, johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH 15/16] mac80211: agg-tx: don't schedule_and_wake_txq()
 under sta->lock
In-Reply-To: <e947923fbeefd81d3b24acf009212d61864fac2c.camel@coelho.fi>
References: <20211129133248.83829-1-luca@coelho.fi>
 <iwlwifi.20211129152938.d5fceeb7e166.I555fef8e67d93fff3d9a304886c4a9f8b322e591@changeid>
 <8735nf9ieg.fsf@toke.dk>
 <e947923fbeefd81d3b24acf009212d61864fac2c.camel@coelho.fi>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 30 Nov 2021 12:32:31 +0100
Message-ID: <87ilw998vk.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Coelho <luca@coelho.fi> writes:

> On Mon, 2021-11-29 at 14:54 +0100, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Luca Coelho <luca@coelho.fi> writes:
>>=20
>> > From: Johannes Berg <johannes.berg@intel.com>
>> >=20
>> > When we call ieee80211_agg_start_txq(), that will in turn call
>> > schedule_and_wake_txq(). Called from ieee80211_stop_tx_ba_cb()
>> > this is done under sta->lock, which leads to certain circular
>> > lock dependencies, as reported by Chris Murphy:
>> > https://lore.kernel.org/r/CAJCQCtSXJ5qA4bqSPY=3DoLRMbv-irihVvP7A2uGutE=
bXQVkoNaw@mail.gmail.com
>> >=20
>> > In general, ieee80211_agg_start_txq() is usually not called
>> > with sta->lock held, only in this one place. But it's always
>> > called with sta->ampdu_mlme.mtx held, and that's therefore
>> > clearly sufficient.
>> >=20
>> > Change ieee80211_stop_tx_ba_cb() to also call it without the
>> > sta->lock held, by factoring it out of ieee80211_remove_tid_tx()
>> > (which is only called in this one place).
>> >=20
>> > This breaks the locking chain and makes it less likely that
>> > we'll have similar locking chain problems in the future.
>> >=20
>> > Reported-by: Chris Murphy <lists@colorremedies.com>
>> > Signed-off-by: Johannes Berg <johannes.berg@intel.com>
>> > Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
>>=20
>> Does this need a fixes: tag?
>
> Hi Toke,
>
> Neither Johannes nor Chris pointed to any specific patch that this
> commit is fixing.  If you know the exact commit that broke this, I can
> add the tag and send v2.

Well, it looks like the code you're changing comes all the way back from:
ba8c3d6f16a1 ("mac80211: add an intermediate software queue implementation")

Maybe Johannes can comment on whether it's appropriate to include this,
or if the code changed too much in the meantime...

-Toke

