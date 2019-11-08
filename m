Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5929CF4542
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Nov 2019 12:01:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728513AbfKHLBm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 8 Nov 2019 06:01:42 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:53498 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727459AbfKHLBl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 8 Nov 2019 06:01:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573210900;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2pehBU8sSxfSfaE4NqFPdAzFqvrsYq1VRgTX8hc2G1Y=;
        b=dR06IUwKBtq3AFVwDqG1pO/zDk9B65i3Aaqp5hLJVns935k5B4nTyFHGgk96W4WvU+f6Vx
        GH+TzEbE3B9eLN+gF825haxozdaAgAthaEzvpfaCvZoR/DpXsEt1rBo6MFwuQjSysko74n
        Ps0MA/HmOg3TwWPNf8Xry9ju6LNuZiQ=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-218-07gpfuThPf-JzCVdzbV3vg-1; Fri, 08 Nov 2019 06:01:35 -0500
Received: by mail-ed1-f71.google.com with SMTP id h51so4159079ede.9
        for <linux-wireless@vger.kernel.org>; Fri, 08 Nov 2019 03:01:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=ZyyhMUlU9R9fEWMycrsCOqhiWueP8mUiq2raZisldTk=;
        b=I3hYeBazcDOFjsiHX4T+iQ8/4Q6Fihpy2AXREm+uHs9FYzYd+acBnpgT+9Lx6y13CG
         dRLAWUdnLv0KFwJAGHg3HqplJYJSyuqNliicHS35sRFmNGoQMOH5LNw2kJPQf16bPYrU
         XwEnP4449jgKM5us4ekKzEzoHA2k0QG2EG+TI5LwER/7HrkYqhipRWZPhR3BQDIWd8MC
         6xeLIQ5n6ra9fsjOqXUhVHqMQtZxvmDZTFyr5skvGy3soWsG7hI/Zy0nmOZlbeYbDrL4
         3vbnsOQKeZnXXTWbWAv3W37EnEQp6zmVc8XbsGOm3SzhdJVgNaSSkwwl1ll4FUGmR/P9
         T07g==
X-Gm-Message-State: APjAAAU7apWpCezUDftH9DMB3WqEkW45SXHZtIrRtwxJlnr2xV4GqxHg
        mqVOHMtQxb5/B6rsG3107nuJv8hAHMC4jfA6FR008KfOX5kxmkFaZ+hCKUOJol27P234VvRMeUp
        GYEXMEutggEQH+V/HXibJkMHgfbw=
X-Received: by 2002:a50:8969:: with SMTP id f38mr9359906edf.211.1573210894460;
        Fri, 08 Nov 2019 03:01:34 -0800 (PST)
X-Google-Smtp-Source: APXvYqwWTp/rmoroMCiYVUg5skGWAlRu+PZp2l3Gpm6XBlHO+OWpIgcFnaYBh6CItZidwf+cGQInqg==
X-Received: by 2002:a50:8969:: with SMTP id f38mr9359892edf.211.1573210894274;
        Fri, 08 Nov 2019 03:01:34 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a00:7660:6da:443::2])
        by smtp.gmail.com with ESMTPSA id v17sm117797edt.76.2019.11.08.03.01.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2019 03:01:33 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 09BC21818B5; Fri,  8 Nov 2019 12:01:33 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        make-wifi-fast@lists.bufferbloat.net, ath10k@lists.infradead.org,
        John Crispin <john@phrozen.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Felix Fietkau <nbd@nbd.name>, Kan Yan <kyan@google.com>,
        Rajkumar Manoharan <rmanohar@codeaurora.org>,
        Kevin Hayes <kevinhayes@google.com>
Subject: Re: [PATCH v6 4/4] mac80211: Use Airtime-based Queue Limits (AQL) on packet dequeue
In-Reply-To: <0b43c4822ab83ea4d33a5a32d8ff6c7a56eff6c5.camel@sipsolutions.net>
References: <157182473951.150713.7978051149956899705.stgit@toke.dk> <157182474399.150713.16380222749144410045.stgit@toke.dk> <0b43c4822ab83ea4d33a5a32d8ff6c7a56eff6c5.camel@sipsolutions.net>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 08 Nov 2019 12:01:32 +0100
Message-ID: <877e4afx83.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: 07gpfuThPf-JzCVdzbV3vg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Johannes Berg <johannes@sipsolutions.net> writes:

> On Wed, 2019-10-23 at 11:59 +0200, Toke H=C3=B8iland-J=C3=B8rgensen wrote=
:
>>=20
>> +=09if (info->tx_time_est) {
>> +=09=09struct sta_info *sta =3D NULL, *s;
>> +=09=09struct rhlist_head *tmp;
>> +
>> +=09=09rcu_read_lock();
>> +
>> +=09=09for_each_sta_info(local, hdr->addr1, s, tmp) {
>> +=09=09=09/* skip wrong virtual interface */
>> +=09=09=09if (!ether_addr_equal(hdr->addr2, s->sdata->vif.addr))
>> +=09=09=09=09continue;
>> +
>> +=09=09=09sta =3D s;
>> +=09=09=09break;
>> +=09=09}
>
> I guess that is better than looking up the sdata and then using
> sta_info_get(), but I think I'd like to see this wrapped into a function
> (even if it's an inline) in sta_info.{c,h}.

OK, can do.

>> +=09=09airtime =3D ieee80211_calc_expected_tx_airtime(hw, vif, txq->sta,
>> +=09=09=09=09=09=09=09     skb->len);
>> +=09=09if (airtime) {
>> +=09=09=09/* We only have 10 bits in tx_time_est, so store airtime
>> +=09=09=09 * in increments of 4us and clamp the maximum to 2**12-1
>> +=09=09=09 */
>> +=09=09=09airtime =3D min_t(u32, airtime, 4095) & ~3U;
>> +=09=09=09info->tx_time_est =3D airtime >> 2;
>> +=09=09=09ieee80211_sta_update_pending_airtime(local, tx.sta,
>> +=09=09=09=09=09=09=09     txq->ac, airtime,
>> +=09=09=09=09=09=09=09     false);
>
> I wonder if it'd be better to pass the shifted value to
> ieee80211_sta_update_pending_airtime() to avoid all the shifting in all
> places?
>
> You could even store the shifted value in "aql_tx_pending" and
> "aql_total_pending_airtime" etc., it's completely equivalent, and only
> shift it out for people looking at debugfs.

My reasoning for doing it this way was that we have another set of APIs
dealing with airtime which doesn't do any shifting; so keeping the APIs
in the same unit (straight airtime) seemed less confusing.

We could add (inline) setter and getter functions for the tx_time_est
field instead to avoid sprinkling shifts all over the place? :)

-Toke

