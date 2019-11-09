Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7A6DF5CAF
	for <lists+linux-wireless@lfdr.de>; Sat,  9 Nov 2019 02:22:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726061AbfKIBWx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 8 Nov 2019 20:22:53 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:44627 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbfKIBWx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 8 Nov 2019 20:22:53 -0500
Received: by mail-lf1-f67.google.com with SMTP id v4so5832346lfd.11
        for <linux-wireless@vger.kernel.org>; Fri, 08 Nov 2019 17:22:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wPXyqZBACPt2T8JabE4s0igf2vH/Qf9iXz5fOc/g31A=;
        b=KaCfKXPf9tclQGg3xbw0RP8zIY19/2N7+HspE9hY+ndU+h4disr4tT5Bf0aNZolhSQ
         /mkmKrGdP45uwLYAo7glcfUp5zsMVCkXcwzx3Jdqt10N4Cvw7tyFA8ogAB9j7MnlTSZb
         MyajoVYU6YLhXDNS38lDuVj2l6W0TCRRFvJfXmAJEiM+qMpcov7zMPMRQFRXof1Z3kHH
         FbI9yoL0lCtsztv2jCASaiyumAdWzv3p1LwNo3t+zbFfwyOqx/dzVdwWYJdANEnkQIba
         kj0Ga/10Bl9C62V8e9LwreSMqBg90IH55OGLfaxJYXPqvrNRvJl31RH4+pN+yV3jFFQo
         w+dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wPXyqZBACPt2T8JabE4s0igf2vH/Qf9iXz5fOc/g31A=;
        b=krnDyjWJaEVAfx9wUMJwU44S/HAULgOa41MpfNy/RNGoR7rtnKmfKL/8NBImHvmgfz
         91XvRiN9qVXb2gFNN8RCXKbt3r6zM/AHppWMqZ8Y6Dtde8JYD7Ma/ZifbZth/PMb8ID6
         GrQAvJFcA/0bnvWBCe2fOEL4AFbD24VDh2OWVWE3ikiZxE92U14B9I61w5CnkOzlhtj4
         4Xv1OaUM9DxzCit66UFr28ncxqscEMXxOZABbWtVFz5Z75+3+hbcmEYZDLkZwYwCB8JJ
         mzsqOTxppEj7BwbCn7189lBTga27HVBO6igfAi7HXsUZcW1Jzp80bLSPX5DYeG73YsGJ
         qsWA==
X-Gm-Message-State: APjAAAVGbCkKC5zyVN1d8Rsumc2I9g6p5mTYDHLP9MPLKUmE92t5gMN5
        IpAYQamp6n2bw42hpzeXi3BMSlAfKVtvw4BOnJ6xlg==
X-Google-Smtp-Source: APXvYqzcFLo69QaprJxtW7QMFzk0LEtt8oG4AUIf8h9IGzZQ4qgLpbLfpusrfQ5D8khH8QL1egEqTvs1kOD48rXrM1Q=
X-Received: by 2002:a19:5010:: with SMTP id e16mr2851614lfb.49.1573262569148;
 Fri, 08 Nov 2019 17:22:49 -0800 (PST)
MIME-Version: 1.0
References: <157182473951.150713.7978051149956899705.stgit@toke.dk>
 <157182474287.150713.12867638269538730397.stgit@toke.dk> <1a2eb096119c9029e67caf797564d6511c8803a7.camel@sipsolutions.net>
 <87a796fxgd.fsf@toke.dk> <f395a9a971ca1a0d0438fca10dfb160c421caa7a.camel@sipsolutions.net>
 <874kzefwt3.fsf@toke.dk> <300bf0146db6c0d5890699b3911d35174d28c9c0.camel@sipsolutions.net>
In-Reply-To: <300bf0146db6c0d5890699b3911d35174d28c9c0.camel@sipsolutions.net>
From:   Kan Yan <kyan@google.com>
Date:   Fri, 8 Nov 2019 17:22:38 -0800
Message-ID: <CA+iem5saT0ntxnSV1ZatFuRRcaBzivkQ_MU66ZdV1kfb1dC6Qg@mail.gmail.com>
Subject: Re: [PATCH v6 3/4] mac80211: Implement Airtime-based Queue Limit (AQL)
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>,
        linux-wireless@vger.kernel.org,
        Make-Wifi-fast <make-wifi-fast@lists.bufferbloat.net>,
        ath10k@lists.infradead.org, John Crispin <john@phrozen.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Felix Fietkau <nbd@nbd.name>,
        Rajkumar Manoharan <rmanohar@codeaurora.org>,
        Kevin Hayes <kevinhayes@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

It is most likely just insufficient locking. active_txq_lock is per
AC, can't protect local->aql_total_pending_airtime against racing
conditions:
void ieee80211_sta_update_pending_airtime(...)
{
        spin_lock_bh(&local->active_txq_lock[ac]);
        ...
        local->aql_total_pending_airtime -=3D tx_airtime;
        ...
        spin_unlock_bh(&local->active_txq_lock[ac]);
}

After changing it to atomic_t, no more aql_total_pending_airtime
underflow so far :). Using atomic operation should also help reduce
CPU overhead due to lock contention, as
ieee80211_sta_update_pending_airtime() is often called from the tx
completion routine triggered by interrupts, often in a different core
than where __ieee80211_schedule_txq() is running.

I will post a new version a bit later if the test goes well.

Regards,
Kan


On Fri, Nov 8, 2019 at 3:17 AM Johannes Berg <johannes@sipsolutions.net> wr=
ote:
>
> On Fri, 2019-11-08 at 12:10 +0100, Toke H=C3=B8iland-J=C3=B8rgensen wrote=
:
>
> > Right, bugger. I was thinking maybe there's a case where skbs can be
> > cloned (and retain the tx_time_est field) and then released twice?
>
> They could be cloned, but I don't see how that'd be while *inside* the
> stack and then they get reported twice - unless the driver did something
> like that?
>
> I mean, TCP surely does that for example, but it's before we even get to
> mac80211.
>
> > Or
> > maybe somewhere that steps on the skb->cb field in some other way?
> > Couldn't find anything obvious on a first perusal of the TX path code,
> > but maybe you could think of something?
>
> No, sorry. But I also didn't actually look at the driver at all.
>
> > Otherwise I guess we'll be forced to go and do some actual,
> > old-fashioned debugging ;)
>
> :)
>
> johannes
>
