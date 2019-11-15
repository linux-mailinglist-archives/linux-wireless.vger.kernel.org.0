Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 195C8FDE6C
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Nov 2019 13:56:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727329AbfKOM4L (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 15 Nov 2019 07:56:11 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:37388 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727223AbfKOM4L (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 15 Nov 2019 07:56:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573822570;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=95KCD774oTBhtPAun5LFxt7PQ5lOqiqNZiBq+HVC7WI=;
        b=RmzeKqDpL6ZLTRVqEqB2Mcu4DCufqG6DIQQdyyOlxsNohPG2V/mFTD/TLbv9gkAueJUydf
        br3NrwpsMl2pplwh6+IhQ9USqGql+DHH5OMoRkiZJAOUuD5hBNLHgXEaFuP5z0qHBgCR7u
        RwGZTE3ckuJDQ7WBFRz7omrD72+0N5Q=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-19-KAcZdrXPMpugYrCYwas3Jw-1; Fri, 15 Nov 2019 07:56:07 -0500
Received: by mail-lf1-f72.google.com with SMTP id t6so3044125lfd.13
        for <linux-wireless@vger.kernel.org>; Fri, 15 Nov 2019 04:56:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=6a+NU/C31nl6e5FCe8WL5WTU7WvA118zrjXjtwzD8E0=;
        b=uXjr9fA/dSZdeAsREaCBWmaJKgQ6IFUvO9Yfs9nFP8VMPSEqBG402vNt3878SBRuAC
         pijy+EmLsqz/WuwV5DQbLLybc2+BTCQbC7OS51Tu0uyrl3KCc5fEUabpqV6qSXPVsFGT
         anAF9ocoy+T2AhYnoCfyT3AJ1U3AH40Qgkb63ZcNKXouhHUwg4apKSvP/o/CnJsdgHjs
         luN2g3hmXY/0ytYtfxkEVm4pxlFh1Yjh8kxEONEAeXqbJluK7AAVOmUA+YbFaSliisD5
         mzAJQt0cQ+xt11RiiSmnWNocUN49mB/yisQ2I+gbwzFrZE56g5HELkDpuVaLre/fv34D
         UN5g==
X-Gm-Message-State: APjAAAW98KuezpuTbVZyNb3j2sxA8vGV3zc1ynzMaNg6FSApjMyqAacW
        Pi1+Kw5gbDZ/kA/ZOBfWsK2JfyZVsRiqk5+B7fS1QmTI3FbDtLI7lW9/QNn6rUx3zP0R3irOTH0
        5sZJMPzcfQIGv3YTZkQ7eJZ6QygE=
X-Received: by 2002:a2e:9097:: with SMTP id l23mr11205507ljg.103.1573822565816;
        Fri, 15 Nov 2019 04:56:05 -0800 (PST)
X-Google-Smtp-Source: APXvYqz7I67ctwzPxNDc7tNLEE71a8hkkTT8O7kW3O9+UMjFqJcaX8XCSvR/UcDmLGKgz+qm81NA5w==
X-Received: by 2002:a2e:9097:: with SMTP id l23mr11205487ljg.103.1573822565564;
        Fri, 15 Nov 2019 04:56:05 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk (borgediget.toke.dk. [85.204.121.218])
        by smtp.gmail.com with ESMTPSA id q11sm3870857ljm.107.2019.11.15.04.56.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2019 04:56:04 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 1C92B1818C5; Fri, 15 Nov 2019 13:56:04 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Kan Yan <kyan@google.com>, johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        make-wifi-fast@lists.bufferbloat.net, nbd@nbd.name,
        yiboz@codeaurora.org, john@phrozen.org, lorenzo@kernel.org,
        rmanohar@codeaurora.org, kevinhayes@google.com,
        Kan Yan <kyan@google.com>
Subject: Re: [v8 PATCH 2/2] mac80211: Implement Airtime-based Queue Limit (AQL)
In-Reply-To: <20191115014846.126007-3-kyan@google.com>
References: <20191115014846.126007-1-kyan@google.com> <20191115014846.126007-3-kyan@google.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 15 Nov 2019 13:56:04 +0100
Message-ID: <87k181mh7f.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: KAcZdrXPMpugYrCYwas3Jw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kan Yan <kyan@google.com> writes:

> In order for the Fq_CoDel algorithm integrated in mac80211 layer to opera=
te
> effectively to control excessive queueing latency, the CoDel algorithm
> requires an accurate measure of how long packets stays in the queue, AKA
> sojourn time. The sojourn time measured at the mac80211 layer doesn't
> include queueing latency in the lower layer (firmware/hardware) and CoDel
> expects lower layer to have a short queue. However, most 802.11ac chipset=
s
> offload tasks such TX aggregation to firmware or hardware, thus have a de=
ep
> lower layer queue.
>
> Without a mechanism to control the lower layer queue size, packets only
> stay in mac80211 layer transiently before being sent to firmware queue.
> As a result, the sojourn time measured by CoDel in the mac80211 layer is
> almost always lower than the CoDel latency target, hence CoDel does littl=
e
> to control the latency, even when the lower layer queue causes excessive
> latency.
>
> The Byte Queue Limits (BQL) mechanism is commonly used to address the
> similar issue with wired network interface. However, this method cannot b=
e
> applied directly to the wireless network interface. "Bytes" is not a
> suitable measure of queue depth in the wireless network, as the data rate
> can vary dramatically from station to station in the same network, from a
> few Mbps to over Gbps.
>
> This patch implements an Airtime-based Queue Limit (AQL) to make CoDel wo=
rk
> effectively with wireless drivers that utilized firmware/hardware
> offloading. AQL allows each txq to release just enough packets to the low=
er
> layer to form 1-2 large aggregations to keep hardware fully utilized and
> retains the rest of the frames in mac80211 layer to be controlled by the
> CoDel algorithm.
>
> Signed-off-by: Kan Yan <kyan@google.com>
> [ Toke: Keep API to set pending airtime internal, fix nits in commit msg =
]
> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> ---
[...]

> +=09if (sta) {
> +=09=09atomic_sub(tx_airtime, &sta->airtime[ac].aql_tx_pending);
> +=09=09tx_pending =3D atomic_read(&sta->airtime[ac].aql_tx_pending);

This is still racy, since you're splitting it over two calls; you'll
need to use atomic_sub_return() instead.

I figure we've converged now to the point where it actually makes sense
to collect everything back into a single series; so I can just fix this
and re-send the full series.

> +=09=09if (WARN_ONCE(tx_pending < 0,
> +=09=09=09      "STA %pM AC %d txq pending airtime underflow: %u, %u",
> +=09=09=09      sta->addr, ac, tx_pending, tx_airtime))
> +=09=09=09atomic_cmpxchg(&sta->airtime[ac].aql_tx_pending,
> +=09=09=09=09       tx_pending, 0);

This could still fail if there's a concurrent modification (and you're
not checking the return of the cmpxchg). But at least it won't clobber
any updated value, so I guess that is acceptable since we're in "should
never happen" territory here :)

-Toke

