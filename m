Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C8B4F5EB5
	for <lists+linux-wireless@lfdr.de>; Sat,  9 Nov 2019 12:22:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbfKILW4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 9 Nov 2019 06:22:56 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40597 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726281AbfKILWz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 9 Nov 2019 06:22:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573298574;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ygt9ehkmdDMxdmk4kMVpOxO+qyc90ZiyWuvotbEdwzQ=;
        b=BGGO1W1yhi4PUN7lepeE4WUiG47PeFO0apnH/nQLsT9lCw1FVkZ5oExrC6VI2D5sAx5byD
        7ioZP/BM8XWnm0Lb7KZNlFUW88LyDJ02jMg7rBL1RErfTLy13PBxFnvaUjAlXd+3hn9cv5
        haO9AoO50lPruiuEPXx5ZQt3+BSNf+g=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-47-uh3wY1LMOHiipDOk3ifcQQ-1; Sat, 09 Nov 2019 06:22:52 -0500
Received: by mail-lj1-f198.google.com with SMTP id e12so1010403ljk.19
        for <linux-wireless@vger.kernel.org>; Sat, 09 Nov 2019 03:22:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=LMrVkbjMH7hPzH5T4kkvtcS+8ogevDtCcANls+17jFo=;
        b=FQhK6NtE1KvXnLna0DYtOXF02RTRVb5tNgOwrLdapl18pYaZez9O5FYHSAPJc7gd0f
         6wPzEu8inRrtkMzvTP2cYPhi50OFc+tMYjSgzU99H/gzi4/WpKv72RamirnH3JKWR9Gv
         cr2pMFhAdTrmmR60aJfJ8xSXzWccojEQOJxyE+1SXpZUahFnISHrOdy2ESCFHwxbV0VS
         tY9TNd0dKXXj5Z6/FkOrSHU2kYYdB1l7YVFA3Tr2Db0GzgwCgCm4dXuzz6uC1w0VEfgC
         h84g5Vd9AfY48rlqawx/t1K53Orm3nxYgkX07v9/A0CvAyCGC0bQ4b9738VRUnlbbnDE
         SGug==
X-Gm-Message-State: APjAAAXco+QA7Nejg3KifjXZpEIOGp0+ZT6Dxep6wPcaUf6GyWAht2qf
        6S86tfr30EvUi9aF1x9NA5TE00SDOvacKpZ3zsurQkQ2s09F9Idax54rZ+fB9jywkCw8Tuj+JSC
        wXYDihl7XAbXvRY/8N+POFkdeDDo=
X-Received: by 2002:a19:ec16:: with SMTP id b22mr10517158lfa.74.1573298571133;
        Sat, 09 Nov 2019 03:22:51 -0800 (PST)
X-Google-Smtp-Source: APXvYqz9Bw/mpsvE1bxpMagaaC8U31L/+lxFJA0jz6rY1xP5NdI110zv41vIFbwH9MLhnKK8I31y9g==
X-Received: by 2002:a19:ec16:: with SMTP id b22mr10517148lfa.74.1573298570999;
        Sat, 09 Nov 2019 03:22:50 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a00:7660:6da:443::2])
        by smtp.gmail.com with ESMTPSA id r12sm6449887lfp.63.2019.11.09.03.22.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Nov 2019 03:22:50 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 960BE1800CC; Sat,  9 Nov 2019 12:22:49 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Kan Yan <kyan@google.com>,
        Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        Make-Wifi-fast <make-wifi-fast@lists.bufferbloat.net>,
        ath10k@lists.infradead.org, John Crispin <john@phrozen.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Felix Fietkau <nbd@nbd.name>,
        Rajkumar Manoharan <rmanohar@codeaurora.org>,
        Kevin Hayes <kevinhayes@google.com>
Subject: Re: [PATCH v6 3/4] mac80211: Implement Airtime-based Queue Limit (AQL)
In-Reply-To: <CA+iem5saT0ntxnSV1ZatFuRRcaBzivkQ_MU66ZdV1kfb1dC6Qg@mail.gmail.com>
References: <157182473951.150713.7978051149956899705.stgit@toke.dk> <157182474287.150713.12867638269538730397.stgit@toke.dk> <1a2eb096119c9029e67caf797564d6511c8803a7.camel@sipsolutions.net> <87a796fxgd.fsf@toke.dk> <f395a9a971ca1a0d0438fca10dfb160c421caa7a.camel@sipsolutions.net> <874kzefwt3.fsf@toke.dk> <300bf0146db6c0d5890699b3911d35174d28c9c0.camel@sipsolutions.net> <CA+iem5saT0ntxnSV1ZatFuRRcaBzivkQ_MU66ZdV1kfb1dC6Qg@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Sat, 09 Nov 2019 12:22:49 +0100
Message-ID: <87k189qoom.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: uh3wY1LMOHiipDOk3ifcQQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kan Yan <kyan@google.com> writes:

> It is most likely just insufficient locking. active_txq_lock is per
> AC, can't protect local->aql_total_pending_airtime against racing
> conditions:
> void ieee80211_sta_update_pending_airtime(...)
> {
>         spin_lock_bh(&local->active_txq_lock[ac]);
>         ...
>         local->aql_total_pending_airtime -=3D tx_airtime;
>         ...
>         spin_unlock_bh(&local->active_txq_lock[ac]);
> }

Ohh, right; didn't even realise those were not per-AC as well...

> After changing it to atomic_t, no more aql_total_pending_airtime
> underflow so far :). Using atomic operation should also help reduce
> CPU overhead due to lock contention, as
> ieee80211_sta_update_pending_airtime() is often called from the tx
> completion routine triggered by interrupts, often in a different core
> than where __ieee80211_schedule_txq() is running.
>
> I will post a new version a bit later if the test goes well.

Awesome! :)

-Toke

