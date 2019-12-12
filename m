Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8DE711C5C8
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Dec 2019 07:05:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727675AbfLLGFb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 12 Dec 2019 01:05:31 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:39323 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726784AbfLLGFb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 12 Dec 2019 01:05:31 -0500
Received: by mail-ot1-f65.google.com with SMTP id 77so441335oty.6
        for <linux-wireless@vger.kernel.org>; Wed, 11 Dec 2019 22:05:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1XjwAkCKDxttRFF8kGyPFQ5AwyuSz+YAMDyZWuFxC0k=;
        b=Emyj4H1riaOG8w5uF0c4Joi+R3q7h0pP+8PjkimB+vYa89pmuwK+dNm091p4GU/gRN
         q0uYvARfwolsExfuct2elfTd+FCPA5Dkw1jzZSJLEJe2XQuM/w31Luzpl5YQjMNIMH+x
         DRgfmRWtTvHu5Jiopknw/g28g0CZ/E14pxcUY3pjKE5XIcz2xUxR1Qebp+3drcjQ1IF7
         vhcqINcQ6DZIdL2/4CS023C3tbON47XeMg16MZJ1doWEteZwwgtPjLy7ShrlRp8eUP7b
         FXnwEIpNysoscX4oSHjAuelNtO5bY4zOFgX0bPjlrMpIuWhwc12HAH6CdXHj4Qf4Yrcr
         J6/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1XjwAkCKDxttRFF8kGyPFQ5AwyuSz+YAMDyZWuFxC0k=;
        b=tue4RP9uWhaRd7ts4pYUt0nqLC9vCoT9cG/oS8Wl0XIx8kl5c8OKGg7SJ4C5oUNSYu
         my7iDQ2dUjEehOsLkwx5czGeJTYx5ebixcS7yK6tJUOQoJXIMpihucySGMkFf+/13fKF
         LzfXE19xLByWV3NOxNXPLnvpXm881PQZchMQAadhsMM57bqRm0W5ZmL7+z5T950IwXYI
         t94g7w3dwFMFCrV1i/GaiDm+QnZDLuw6IVhN0mGgJm8QtOAmIqqAk+88xgs0eWa5bV2P
         Cem0wgRlV3q9ihohGGCOmjahsU3gyaXjjYM2sXQbpGQlgA3U4JCMJDoh8wbnvL04MLYO
         5jtA==
X-Gm-Message-State: APjAAAXgf92WdhJhRrXKMW50e3TQCUbRZG0ZFfNSDeFKyVKuQQuib9fj
        XnlIBkVGjp9wP2GzwnzZFVZr4PYCIPIYnIaVzBgscqGG
X-Google-Smtp-Source: APXvYqyXPM7mjYZUh3jsH5Xxi8scvGi6lG835YwBa1v4DsU9tACr/PGwdTdu2M9ozkZGUTt/+2vO+XFTZXxhSc1ZPx8=
X-Received: by 2002:a05:6830:10c9:: with SMTP id z9mr6245002oto.200.1576130730399;
 Wed, 11 Dec 2019 22:05:30 -0800 (PST)
MIME-Version: 1.0
References: <20191211145230.200132-1-toke@redhat.com> <20191211145230.200132-2-toke@redhat.com>
 <df7eb0b71dc9cfdc7d9b5f7abdbcce0d42fa4a1e.camel@sipsolutions.net>
In-Reply-To: <df7eb0b71dc9cfdc7d9b5f7abdbcce0d42fa4a1e.camel@sipsolutions.net>
From:   Justin Capella <justincapella@gmail.com>
Date:   Wed, 11 Dec 2019 22:05:19 -0800
Message-ID: <CAMrEMU9t-Ed9ASyjGcJvpKM=Japiy0fv_cd1_3D5Sy_UMte_9A@mail.gmail.com>
Subject: Re: [PATCH 1/2] mac80211: Turn AQL into an NL80211_EXT_FEATURE
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>,
        linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Disclaimer: I'm new, so don't assume my questions are rhetorical...

sta =3D container_of(txq->sta, struct sta_info, sta); // Is this correct?

I see the use of IEEE80211_NUM_ACS seems to be standard, is that AC
specific? I learned today that different devs have different numbers
of queues...

What are the units of the THRESHOLD, iirc there was some bit shifting/maski=
ng?

Is there supposed to be a queue per station, or just per interface? It
seemed like the threshold was meant to pick a higher or lower queue,
this seems to maybe just reject if not within the bounds?

Sorry for all the questions, I'm still on the gradual side of the learning =
curve


On Wed, Dec 11, 2019 at 1:22 PM Johannes Berg <johannes@sipsolutions.net> w=
rote:
>
> On Wed, 2019-12-11 at 15:52 +0100, Toke H=C3=B8iland-J=C3=B8rgensen wrote=
:
> >
> > diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.=
h
> > index 341e0e8cae46..1e6f435c709c 100644
> > --- a/include/uapi/linux/nl80211.h
> > +++ b/include/uapi/linux/nl80211.h
> > @@ -5563,6 +5563,7 @@ enum nl80211_ext_feature_index {
> >       NL80211_EXT_FEATURE_STA_TX_PWR,
> >       NL80211_EXT_FEATURE_SAE_OFFLOAD,
> >       NL80211_EXT_FEATURE_VLAN_OFFLOAD,
> > +     NL80211_EXT_FEATURE_AQL,
>
> This is missing kernel-doc.
>
> johannes
>
