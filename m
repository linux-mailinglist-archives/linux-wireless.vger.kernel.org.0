Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90E24C31CF
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Oct 2019 12:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731342AbfJAKxI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Oct 2019 06:53:08 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:57503 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726885AbfJAKxI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Oct 2019 06:53:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1569927186;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5gJYpb2hs/H6MOmJ4HQdouDhL55RKqY1jLEDoXv6ZNw=;
        b=M1tIb8Tfr7xR88wvV7Sf91KNFu28Yk5WkQ5s4645IxooLsVoFrvHu4N0JNt+KZRVmwp23T
        zIwPw6geGI+pykOQTihyBnl0vz7H8xHimN+0pFLPPMj1wd+g+UQLaYmimKikkVyxWNz8Q4
        fga9Yyx6qRzkFPXog+t7scAOiF4zbFQ=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-131-zXTii9snNDqTtFYu7tjgpQ-1; Tue, 01 Oct 2019 06:53:03 -0400
Received: by mail-ed1-f72.google.com with SMTP id n14so8374883edt.3
        for <linux-wireless@vger.kernel.org>; Tue, 01 Oct 2019 03:53:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=aM58yx80a+FhIQLxLs41jbjNWFaNvGrL/FnYLUpnwoo=;
        b=FS5iM+EKO4qAD72J6ed1mxG1WZrjzKQyWis1G7st0yKW8b6c8oRFZ+hfE6j38sdr4i
         hywWFDdcO18K2YB4UX88+03ga1XqdbiGZQtxUq3/zvy3C/Z0aOU2TET4XlLjS+S5NwiK
         F0uViUNy3c7JV+g54SM4IXJlmfvpSXq9P3zQ66W1oDtI5i/20P4vGnQkRZEWPPclYMUS
         5mLJxwhcTCOzf9iORADAom5cMRM9kbZLpm8ytW7Zu0JUPM2gCHktigYWpUUIOSOu8byy
         5JxSkZMv/90GhZmqv4KktLjlGEnscIGaZZ+qm/oNkn2R9uluRNkZRmKX+7y2SEiObkRQ
         kGJg==
X-Gm-Message-State: APjAAAWgogJVvjD3TNfNGvkhKsrRxkN2hzxjt97ZVtT20qcA1PwIywOf
        XzzAIiIxl5squ9laJffkCybsFMfyyQjTKCDf/I/j+lxh2UUbaNimPUdPNbLQ1jUV+vH73jb4pWj
        03aBflQwl43ApmuGcAu1qoki4YTg=
X-Received: by 2002:a17:906:f08:: with SMTP id z8mr23869908eji.18.1569927182077;
        Tue, 01 Oct 2019 03:53:02 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxnIoj5ckN+rO0BdjtEQ9NmKbAWRTIG/XmTn1ASqZJ3SjubM7+D8gnRTE3ov7Q+YR3YMGl+yg==
X-Received: by 2002:a17:906:f08:: with SMTP id z8mr23869888eji.18.1569927181830;
        Tue, 01 Oct 2019 03:53:01 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (borgediget.toke.dk. [85.204.121.218])
        by smtp.gmail.com with ESMTPSA id a36sm3069038edc.58.2019.10.01.03.53.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2019 03:53:01 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 8AB0B18063D; Tue,  1 Oct 2019 12:53:00 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>,
        Jiri Kosina <jikos@kernel.org>,
        Aaron Hill <aa1ronham@gmail.com>,
        Lukas Redlinger <rel+kernel@agilox.net>,
        Oleksii Shevchuk <alxchk@gmail.com>
Subject: Re: [PATCH] mac80211: keep BHs disabled while calling drv_tx_wake_queue()
In-Reply-To: <1569924485-I3e8838c5ecad878e59d4a94eb069a90f6641461a@changeid>
References: <1569924485-I3e8838c5ecad878e59d4a94eb069a90f6641461a@changeid>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 01 Oct 2019 12:53:00 +0200
Message-ID: <87blv0visz.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: zXTii9snNDqTtFYu7tjgpQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Johannes Berg <johannes@sipsolutions.net> writes:

> From: Johannes Berg <johannes.berg@intel.com>
>
> Drivers typically expect this, as it's the case for almost all cases
> where this is called (i.e. from the TX path). Also, the code in mac80211
> itself (if the driver calls ieee80211_tx_dequeue()) expects this as it
> uses this_cpu_ptr() without additional protection.
>
> This should fix various reports of the problem:
> https://bugzilla.kernel.org/show_bug.cgi?id=3D204127
> https://lore.kernel.org/linux-wireless/CAN5HydrWb3o_FE6A1XDnP1E+xS66d5kiE=
uhHfiGKkLNQokx13Q@mail.gmail.com/
> https://lore.kernel.org/lkml/nycvar.YFH.7.76.1909111238470.473@cbobk.fhfr=
.pm/
>
> Reported-by: Jiri Kosina <jikos@kernel.org>
> Reported-by: Aaron Hill <aa1ronham@gmail.com>
> Reported-by: Lukas Redlinger <rel+kernel@agilox.net>
> Reported-by: Oleksii Shevchuk <alxchk@gmail.com>
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>  net/mac80211/util.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/net/mac80211/util.c b/net/mac80211/util.c
> index 051a02ddcb85..ad1e88958da2 100644
> --- a/net/mac80211/util.c
> +++ b/net/mac80211/util.c
> @@ -273,9 +273,9 @@ static void __ieee80211_wake_txqs(struct ieee80211_su=
b_if_data *sdata, int ac)
>  =09=09=09=09=09=09&txqi->flags))
>  =09=09=09=09continue;
> =20
> -=09=09=09spin_unlock_bh(&fq->lock);
> +=09=09=09spin_unlock(&fq->lock);
>  =09=09=09drv_wake_tx_queue(local, txqi);
> -=09=09=09spin_lock_bh(&fq->lock);
> +=09=09=09spin_lock(&fq->lock);

Okay, so this will mean that the drv_wake_tx_queue() entry point will be
called with bhs disabled. But there are lots of uses of
spin_{,un}lock_bh() in tx.c:

$ git grep lock_bh tx.c
tx.c:   spin_lock_bh(&fq->lock);
tx.c:   spin_unlock_bh(&fq->lock);
tx.c:   spin_lock_bh(&fq->lock);
tx.c:   spin_unlock_bh(&fq->lock);
tx.c:   spin_lock_bh(&fq->lock);
tx.c:   spin_unlock_bh(&fq->lock);
tx.c:   spin_lock_bh(&local->active_txq_lock[txqi->txq.ac]);
tx.c:   spin_unlock_bh(&local->active_txq_lock[txqi->txq.ac]);
tx.c:           spin_lock_bh(&fq->lock);
tx.c:           spin_unlock_bh(&fq->lock);
tx.c:   spin_lock_bh(&fq->lock);
tx.c:   spin_unlock_bh(&fq->lock);
tx.c:   spin_lock_bh(&sta->lock);
tx.c:   spin_unlock_bh(&sta->lock);
tx.c:   spin_lock_bh(&sta->lock);
tx.c:   spin_unlock_bh(&sta->lock);
tx.c:   spin_lock_bh(&fq->lock);
tx.c:   spin_unlock_bh(&fq->lock);
tx.c:   spin_lock_bh(&fq->lock);
tx.c:   spin_unlock_bh(&fq->lock);
tx.c:                   spin_lock_bh(&fq->lock);
tx.c:                   spin_unlock_bh(&fq->lock);
tx.c:   spin_unlock_bh(&fq->lock);
tx.c:   spin_lock_bh(&local->active_txq_lock[ac]);
tx.c:   spin_unlock_bh(&local->active_txq_lock[ac]);
tx.c:   spin_lock_bh(&local->active_txq_lock[txq->ac]);
tx.c:   spin_unlock_bh(&local->active_txq_lock[txq->ac]);
tx.c:   spin_lock_bh(&local->active_txq_lock[ac]);
tx.c:   spin_unlock_bh(&local->active_txq_lock[ac]);
tx.c:   spin_unlock_bh(&local->active_txq_lock[ac]);
tx.c:   spin_lock_bh(&local->active_txq_lock[ac]);
tx.c:   spin_unlock_bh(&local->active_txq_lock[ac]);
tx.c:           spin_lock_bh(&local->tim_lock);
tx.c:           spin_unlock_bh(&local->tim_lock);

so won't that mean that the driver still gets bhs re-enabled after (for
instance) the first call to ieee80211_tx_dequeue()?

I must admit that I'm a bit fuzzy on this whole bh/not-bh thing; I've
mostly been cargo-culting the _bh variant of the locking... :)

-Toke

