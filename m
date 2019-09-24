Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 719A6BC294
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Sep 2019 09:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726097AbfIXH1W (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 Sep 2019 03:27:22 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28579 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729331AbfIXH1W (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 Sep 2019 03:27:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1569310040;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VrS9VEE8wj7I9sF1sYK3hSJa0lvG+UB1EqYemHawqgU=;
        b=CzwByyJcIuxDX3+TvHKEnOGMnc9M6HGQuUyP3FKZqFyOgRTTz4dEP/WTvDDP5WFrIDRfKn
        O1hOW6AiRebYCYspmuSAXTNeRR/MtdJZMXPVVPystB/5Fwt4dwlrzEfrCIIf8oXUdmQOuH
        yRbL/MGgHde5txR69nqJFH8JnBbGhv0=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-112-nI70fbjNMQ2gn1I-uWGPQQ-1; Tue, 24 Sep 2019 03:27:19 -0400
Received: by mail-ed1-f71.google.com with SMTP id l5so503140edr.10
        for <linux-wireless@vger.kernel.org>; Tue, 24 Sep 2019 00:27:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=/1VLA+e9xRwyWnJC8ZSrc5rL/HXsWpwr1W6f6XJFn7s=;
        b=HkqVlVPo08krPgMpqXo4CsifP0tWzT3edArYM2hDV+dNyHMCeVNY/JY2bf9GfQ00Ii
         mE5B8FEAIgie/5cOEllP7wXiRST0U1/g3V1iZ5a2woS5gNSvf2k8SRq6neRM3o4VIEwT
         nPCYFIWBnX0PgcjjoWdA8M6yuQPnnlwsKKNQ5U5sCdXnowtc9B04+prUvmIeP9COwGQY
         HVZmZG9VbDI9XOuf+sX85sjfgg79KXhbN7C1kLaYzeDL0QbzwXQ15eaYgeGhGZ8jXRpf
         A0W5O19z+ZZ/cjCdJwMs+LD6tvNB+nxDslo/6arTsYOFAOq6OtcF1OUZn+JoCqoxEh6V
         V0Hw==
X-Gm-Message-State: APjAAAV42aTab+1JeQFeni+C/9ZkYWkOfZx3fZcOrpna4nSIj+zN/IrU
        hMP71wtliDm7fyTy4GqP+BMsNte3yjnWJRCa2DVNktPjpTWEeLPT0mMVsG/MTp7T9S8Dxok+gYL
        SOrN/W5LUZJWfwb1jMNeuf55VgxE=
X-Received: by 2002:aa7:c5c1:: with SMTP id h1mr1185691eds.10.1569310037884;
        Tue, 24 Sep 2019 00:27:17 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwGDjw/G0kxoR0PSfhHk+XP+1yQUVrQ7UOQQZUCO75G11wlytFb9omISqHRvF9miV+baqh0TQ==
X-Received: by 2002:aa7:c5c1:: with SMTP id h1mr1185688eds.10.1569310037768;
        Tue, 24 Sep 2019 00:27:17 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a00:7660:6da:443::2])
        by smtp.gmail.com with ESMTPSA id t30sm197870edt.91.2019.09.24.00.27.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2019 00:27:17 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id D858218063F; Tue, 24 Sep 2019 09:27:16 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Yibo Zhao <yiboz@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        linux-wireless-owner@vger.kernel.org
Subject: Re: [PATCH V3 4/4] mac80211: Sync airtime weight sum with per AC synced sta airtime weight together
In-Reply-To: <ffe79f35d4dcb50aa31dc04035855f79@codeaurora.org>
References: <1569223201-1490-1-git-send-email-yiboz@codeaurora.org> <1569223201-1490-5-git-send-email-yiboz@codeaurora.org> <87blvb5lb9.fsf@toke.dk> <ffe79f35d4dcb50aa31dc04035855f79@codeaurora.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 24 Sep 2019 09:27:16 +0200
Message-ID: <87o8za40iz.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: nI70fbjNMQ2gn1I-uWGPQQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Yibo Zhao <yiboz@codeaurora.org> writes:

> On 2019-09-23 19:00, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>
>>> -=09if (params->airtime_weight)
>>> -=09=09sta->airtime_weight =3D params->airtime_weight;
>>> +=09if (params->airtime_weight &&
>>> +=09    params->airtime_weight !=3D sta->airtime_weight) {
>>=20
>> This check doesn't work I think? You're not using the array-based
>> sta->airtime_weight[], and there are locking issues by just checking
>> like this; so maybe just keep the if() on params->airtime_weight, and=20
>> do
>> the checking inside the loop while holding the lock?
>
> It should be array-based sta->airtime_weight[] and I am missing that=20
> part during the porting. But you are right about we should check it=20
> inside the loop with the lock.
>
>>=20
>> Or could we just turn the weights into atomics to avoid the locking
>> entirely?
>
> Actually, we still need the active txq locking to make sure the txq is=20
> on the rbtree. Otherwise, no need to change airtime weight sum.

True. Just moving the check inside the locking will be the right thing
to do, then.

-Toke

