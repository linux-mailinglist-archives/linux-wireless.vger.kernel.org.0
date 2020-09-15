Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F80826A216
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Sep 2020 11:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbgIOJYk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 15 Sep 2020 05:24:40 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:45247 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726102AbgIOJYi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 15 Sep 2020 05:24:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600161876;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KgzAfLaizeZBqh6WYgvqowvlbuexG/f+F8PiYy1ltEs=;
        b=FZ9CtRVF3T6F6d7sJCPCGScnVXJWnzFlrUz2gfD5I6CxRoWr6v3jEl34Ne2DTcLt4fmBie
        grIuVTWFMj6yYzfLzStlfo57Sif5XUxwcSKaSCgBP9hyVenHJWsAg59xH0Qx64SVfpCd03
        UDWkhbF4JvXSXEOArSLFbfCW6fbYiFM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-534-bnrTOF5kPyiiMrXqnbIS4g-1; Tue, 15 Sep 2020 05:24:34 -0400
X-MC-Unique: bnrTOF5kPyiiMrXqnbIS4g-1
Received: by mail-wr1-f69.google.com with SMTP id v12so994621wrm.9
        for <linux-wireless@vger.kernel.org>; Tue, 15 Sep 2020 02:24:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=KgzAfLaizeZBqh6WYgvqowvlbuexG/f+F8PiYy1ltEs=;
        b=j/nK9REPPQWogyqKOPfXhZQE+2yeV56zsbwLzC/aJgTGA9UrKfZ8ZeUDK8iqWJWuIq
         iCbUUQn4DeQpeCSiSlisDq8m36aLIh7d1rQnezlalktM1yLT+tQNVS7Uvlkpi/xoJzEE
         TkxnLywB75800TnMEOtAxrsmBdgkff3dMrvJ+sKz0ExoHFKX+JOs12U7fSoIpuTVbsrR
         7J5Xoz4khiqy49mZTblfrVEpPVrRpRuN32haUkGvL6tRoFFj49mKUS+6n0r5MMPhY/nw
         IZ3C136XS/HH1XLnsqRBIzlnsZVpo29SDzw8zICe95637kfyiEDTgFKYNkG71kXLWow8
         k/4A==
X-Gm-Message-State: AOAM530qsmEuGoZOmHN/it4gn7yHUMM5cL4lC+Jpdk/kri2BN6pd19VK
        uIjTaWlvUZdAv2gy7h2/JQnjR9rHLsEydDwQdw+w21J91iFyfA9uCOBDBCS1o4mS7A3eIBLLjU6
        gCYDAj8yUmmHzFyt9xIauXS4Xass=
X-Received: by 2002:a05:600c:2257:: with SMTP id a23mr3871616wmm.102.1600161873367;
        Tue, 15 Sep 2020 02:24:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyqn50nXVAEZhfkl3Zv9tPk2SdHAR8h4lsi5bZKEWl/slz5Aw126eJa9kWCMIpLHjUA5vTyYQ==
X-Received: by 2002:a05:600c:2257:: with SMTP id a23mr3871587wmm.102.1600161873004;
        Tue, 15 Sep 2020 02:24:33 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id i11sm25856565wre.32.2020.09.15.02.24.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 02:24:32 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 0B22B1829CB; Tue, 15 Sep 2020 11:24:31 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net
Subject: Re: [PATCH 5.9 v2 1/2] mac80211: extend AQL aggregation estimation
 to HE and fix unit mismatch
In-Reply-To: <20200915085945.3782-1-nbd@nbd.name>
References: <20200915085945.3782-1-nbd@nbd.name>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 15 Sep 2020 11:24:30 +0200
Message-ID: <87d02nz92p.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Felix Fietkau <nbd@nbd.name> writes:

> The unit of the return value of ieee80211_get_rate_duration is nanosecond=
s, not
> microseconds. Adjust the duration checks to account for that.
> For higher data rates, allow larger estimated aggregation sizes, and add =
some
> values for HE as well, which can use much larger aggregates.
> Since small packets with high data rates can now lead to duration values =
too
> small for info->tx_time_est, return a minimum of 4us.
>
> Fixes: f01cfbaf9b29 ("mac80211: improve AQL aggregation estimation for lo=
w data rates")
> Signed-off-by: Felix Fietkau <nbd@nbd.name>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

