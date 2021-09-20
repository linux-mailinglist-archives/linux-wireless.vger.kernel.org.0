Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8E82411488
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Sep 2021 14:33:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238239AbhITMei (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Sep 2021 08:34:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49772 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236558AbhITMeh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Sep 2021 08:34:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632141190;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2vJrXASLpqv5MPw9nDPvbKgZidlNL0K8nW5EYGI6slE=;
        b=AZE5GClZfbgGFJ3mQfXor2ajUcyyOa2MwwgndI+D8JlMvDchgKEii2W1q337oqpSABObDa
        QW+va7UyZ08OserVfcEI+WxdHpqbeM6R1UADA0l1qxt2c2ZyBguM6aaQki0Qs1bX46wKWj
        mLA43gqw2tKWOC+jFeSjanavCD+zRRg=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-287-095r2IRmNdu3QL--xarTaw-1; Mon, 20 Sep 2021 08:33:09 -0400
X-MC-Unique: 095r2IRmNdu3QL--xarTaw-1
Received: by mail-qv1-f71.google.com with SMTP id r18-20020a056214069200b0037a291a6081so183261808qvz.18
        for <linux-wireless@vger.kernel.org>; Mon, 20 Sep 2021 05:33:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2vJrXASLpqv5MPw9nDPvbKgZidlNL0K8nW5EYGI6slE=;
        b=7ARaE6YaDZfRhE2DPSz7goBtLJ7cmBt4QZ75OhRGNjOGSeOQc7nr6ONYBrpV6sYpNG
         GBa1nzNzSTfJyAuuHtvwEADEDm9NzVp59V8qoNaKpMRrK+f3Uxz8tm0otY+BluGxZunY
         CO2R5k7YHPQROGtRy3Mri2pOyBrKDiaqiZvMneamJNqgkWcJk8WDNq+HAihSkOf6RGK/
         N5ZDRs6LyrNLKfENmeqZ+2hK96mn1WpWC57QsFWKtm4zjrAlmZz9o/ghrX2lZONlzGK2
         UfCkFy4HTtk+3q14Gif524lULZcJ/esao4yrJ+qf96uGKQJwgqi51JzKhz7I3Vr+RZv9
         LuOw==
X-Gm-Message-State: AOAM5313vqG3ef/wEutNiTZjksZLMVTBrh7xCAufU2W4KqMICxFB0UZU
        4KQoAKeCKacAGKF0JZpfl6iZ459sol3LdSmYxPeRXC5z1Rui2gfWLb3MbuMMbSSPm8bwiVzef0R
        5C0r47jnngQUhb72V33lFh2dJUi0emU43OpYlpJqTlsM=
X-Received: by 2002:a25:6788:: with SMTP id b130mr24364202ybc.496.1632141188615;
        Mon, 20 Sep 2021 05:33:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJznnSdDXzcrqoEBWAz8O3DcU4CFlCKHnpQTb9t4F02epVL+MO8iqPOS08R3+N5qs3BJZPdY1I+cv4LA0q9dCXc=
X-Received: by 2002:a25:6788:: with SMTP id b130mr24364164ybc.496.1632141188225;
 Mon, 20 Sep 2021 05:33:08 -0700 (PDT)
MIME-Version: 1.0
References: <0529e19e583be780ba2488e891c50dcfcf2ce4c1.1632128258.git.lorenzo@kernel.org>
 <e848121b-c0ee-d8e4-8f4b-dc9b64210261@broadcom.com> <CAJ0CqmW1c0Zs61yF9d3QJevBenB2B9TNWLADFTpH7cBGbjhbgw@mail.gmail.com>
 <e4f49325610cae6148ad15eb823584df88f0c1ba.camel@sipsolutions.net>
In-Reply-To: <e4f49325610cae6148ad15eb823584df88f0c1ba.camel@sipsolutions.net>
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Date:   Mon, 20 Sep 2021 14:32:57 +0200
Message-ID: <CAJ0CqmUbAOq0R=9CUnjbbkkJV1Dj191bDkp8UsKMYffS0qKP-A@mail.gmail.com>
Subject: Re: [PATCH mac80211] mac80211: limit mcs/nss to spec values in ieee80211_parse_tx_radiotap
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Arend van Spriel <arend.vanspriel@broadcom.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

>
> On Mon, 2021-09-20 at 14:20 +0200, Lorenzo Bianconi wrote:
> > >
> >
> > AFAIK mcs10 and mcs11 are not part of 802.11ac standard but I am fine
> > allowing them since they are already managed in the code.
> > @Johannes: Do you agree?
>
> For sure it'll still fix the warning, whether or not it's then useful
> for the driver is kind of a different issue I guess, but it should be
> OK.
>
> johannes
>

ack, I will post v2 allowing mcs till 11.

Regards,
Lorenzo

