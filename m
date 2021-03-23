Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8707A346997
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Mar 2021 21:09:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbhCWUJV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 23 Mar 2021 16:09:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:24602 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230247AbhCWUJQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 23 Mar 2021 16:09:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616530156;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6Om2p+kPeYPvnkQ8vfOjPZ4l1VBq5sa41LLRVTOu8XQ=;
        b=BNvpEU0/HEeMFsm1/zgJvT2uXL3Kic3sdG7rgMU04KofNhKAukcq5zbwXLxaFGN4X+xmma
        EHNx93+uentz0rVukBiiy0XLyin76XIeEBurrUo1Vm3OnkcWdfq+esZRXWhG2xxVf4u7hT
        yOHBKYfAd1JrpZQz3VoZrZ8UtpUrqCE=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-524-HK84A7_aMOay-v19oiutog-1; Tue, 23 Mar 2021 16:09:14 -0400
X-MC-Unique: HK84A7_aMOay-v19oiutog-1
Received: by mail-ed1-f70.google.com with SMTP id i6so1512910edq.12
        for <linux-wireless@vger.kernel.org>; Tue, 23 Mar 2021 13:09:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=6Om2p+kPeYPvnkQ8vfOjPZ4l1VBq5sa41LLRVTOu8XQ=;
        b=ex6hAuExVI064Re4Bzk0z8FCm49Kpb6+SfuiJxEx6s5rKkHhwV7Itw/nV/aEBzkQfe
         xbnLVMwCGflS0Cac3LQSzmvQ+otux9LLw5QJG8I3zMQDrWegaxPMdD4rE+I7BpEAe39W
         X0vXgQD3RarWfL7JfxsfA1F6jUxh/6vn66GvgWAvBenPPmGltiEc3GI6vgbmkzWfpP/H
         Q/mgpH2sI0GDZzzbYgZuTWjJtwsB2V60vxMlgUSzyRUe+VU+bxWbsiYfsrDhyg+Rd6zw
         fjoqv9duG8nuEuM5x9RsccxNAYm0Wo21l9gDFyM42aoBy0NoG322akzaGY7rk4HnIldW
         oTmg==
X-Gm-Message-State: AOAM533iipE5Gkyl89xJTr9DtptGY5fPe3wV/bl4mAjWAyncMhPu3TqY
        mAnfcnh+065DoQSEckUevwHd2npLrWrTDuP3brAjnimqUYxh+uHn7cG2RZNcGmIoXS+jHxnUFOR
        T56PkxOdfpJq3ZPpYT0Iesq6pfv4=
X-Received: by 2002:a17:906:f6ce:: with SMTP id jo14mr6730430ejb.476.1616530153155;
        Tue, 23 Mar 2021 13:09:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxcepEBZXmtx3sGJ0gUkKMVcC8fA3++ZlXtkIo7r19rKkZaGSuVq6e7Ds6QQ6fJ5tztTSo/hA==
X-Received: by 2002:a17:906:f6ce:: with SMTP id jo14mr6730423ejb.476.1616530152988;
        Tue, 23 Mar 2021 13:09:12 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id h22sm11580411eji.80.2021.03.23.13.09.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 13:09:12 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id C255B180281; Tue, 23 Mar 2021 21:09:11 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH] mac80211: fix TXQ AC confusion
In-Reply-To: <20210323210500.bf4d50afea4a.I136ffde910486301f8818f5442e3c9bf8670a9c4@changeid>
References: <20210323210500.bf4d50afea4a.I136ffde910486301f8818f5442e3c9bf8670a9c4@changeid>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 23 Mar 2021 21:09:11 +0100
Message-ID: <87v99h63a0.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Johannes Berg <johannes@sipsolutions.net> writes:

> From: Johannes Berg <johannes.berg@intel.com>
>
> Normally, TXQs have
>
>   txq->tid =3D tid;
>   txq->ac =3D ieee80211_ac_from_tid(tid);
>
> However, the special management TXQ actually has
>
>   txq->tid =3D IEEE80211_NUM_TIDS; // 16
>   txq->ac =3D IEEE80211_AC_VO;
>
> This makes sense, but ieee80211_ac_from_tid(16) is the same
> as ieee80211_ac_from_tid(0) which is just IEEE80211_AC_BE.
>
> Now, normally this is fine. However, if the netdev queues
> were stopped, then the code in ieee80211_tx_dequeue() will
> propagate the stop from the interface (vif->txqs_stopped[])
> if the AC 2 (ieee80211_ac_from_tid(txq->tid)) is marked as
> stopped. On wake, however, __ieee80211_wake_txqs() will wake
> the TXQ if AC 0 (txq->ac) is woken up.
>
> If a driver stops all queues with ieee80211_stop_tx_queues()
> and then wakes them again with ieee80211_wake_tx_queues(),
> the ieee80211_wake_txqs() tasklet will run to resync queue
> and TXQ state. If all queues were woken, then what'll happen
> is that _ieee80211_wake_txqs() will run in order of HW queues
> 0-3, typically (and certainly for iwlwifi) corresponding to
> ACs 0-3, so it'll call __ieee80211_wake_txqs() for each AC in
> order 0-3.
>
> When __ieee80211_wake_txqs() is called for AC 0 (VO) that'll
> wake up the management TXQ (remember its tid is 16), and the
> driver's wake_tx_queue() will be called. That tries to get a
> frame, which will immediately *stop* the TXQ again, because
> now we check against AC 2, and AC 2 hasn't yet been marked as
> woken up again in sdata->vif.txqs_stopped[] since we're only
> in the __ieee80211_wake_txqs() call for AC 0.
>
> Thus, the management TXQ will never be started again.
>
> Fix this by checking txq->ac directly instead of calculating
> the AC as ieee80211_ac_from_tid(txq->tid).
>
> Fixes: adf8ed01e4fd ("mac80211: add an optional TXQ for other PS-buffered=
 frames")
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

