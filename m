Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBCB4BB27A
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Sep 2019 12:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbfIWKzN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Sep 2019 06:55:13 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33941 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732113AbfIWKzN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Sep 2019 06:55:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1569236112;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qgSd5XyhrTBCh6mH0xPVPxKjNLWCTpEGm8lvV82pLjQ=;
        b=SfoyQyyen6sKpbE80TBqx+saWSpTfT6Nz1cCdZN55ZA9EHH3/P5lTwEnYcEWLSSSsbGAyS
        Rk2zg+YR2JTKCdYTXGQ/c9AeAfinJ/Xc3KoRhac85GOEJFocGfh1yQ4bcwjbmaVbCPe9Xp
        FcwSqEz0NThvRqrk9vDggjvCxKDe9C8=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-17-dHrMdVX2MwSAXUnImxaw5g-1; Mon, 23 Sep 2019 06:55:09 -0400
Received: by mail-lj1-f200.google.com with SMTP id m8so2878904ljb.3
        for <linux-wireless@vger.kernel.org>; Mon, 23 Sep 2019 03:55:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=dp/8v1kY8WibzgYAotpvlGIts7++DL5I4lUP8JdBwZM=;
        b=WM8QUJW/fRLq0O1GsECg9v3CTgcnGA4/k8LCkY3dR2l8n4I8eiYLGlYjdQg4v+KVsx
         6IV/luZdMfc8+3MV3HxmjxPdOLMluWxEQPc7eCQ3sT3LOfDv+NMgfRWjmeAxqNqWRjEH
         Uhk9YrhbYmVqLisfeCiniBkenWes1eKnA+60DcKh9dcYDMaqBzftZCEaU12s2ZT5cjfz
         dVgSDy0fCUTd/lwwzSFIbFYEoM3nb5GsgmpDsAfPSfNwPpPe+j7ad2ZZ8eEvrZx7+LeT
         Pqa0cFmTGa36kpGt7uYMxUr1bEI68bs2TuKdgdUMrgAA20Ay0UZmDOp+7K+d9goXbiNY
         bAOg==
X-Gm-Message-State: APjAAAUZJwDQAHC4b24B6TylhMwR8NSv8x9oIlch9GIkroz0DW4vrqp/
        dQrbMIjXkrmQgDutxX66NzJGYhm0O4vW+NnK8tORYn8isNmgVACmcSIApQtfYruiRaewtJYyi+R
        QzwyEPWCWI7h9uVL7+25B+px/UN8=
X-Received: by 2002:a19:488f:: with SMTP id v137mr15820081lfa.26.1569236108460;
        Mon, 23 Sep 2019 03:55:08 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzG5rXvdXpKnrY4+X9uf6+n/TDpVH/AImywvrkEdQ134pOr6fM53G1QHsMmwsDTwPYdJM6Euw==
X-Received: by 2002:a19:488f:: with SMTP id v137mr15820075lfa.26.1569236108308;
        Mon, 23 Sep 2019 03:55:08 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (borgediget.toke.dk. [85.204.121.218])
        by smtp.gmail.com with ESMTPSA id f21sm2333132lfm.90.2019.09.23.03.55.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2019 03:55:07 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id F1E3E1804C8; Mon, 23 Sep 2019 12:55:05 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Yibo Zhao <yiboz@codeaurora.org>, linux-wireless@vger.kernel.org
Cc:     ath10k@lists.infradead.org, Yibo Zhao <yiboz@codeaurora.org>
Subject: Re: [PATCH V3 3/4] mac80211: fix low throughput in multi-clients situation
In-Reply-To: <1569223201-1490-4-git-send-email-yiboz@codeaurora.org>
References: <1569223201-1490-1-git-send-email-yiboz@codeaurora.org> <1569223201-1490-4-git-send-email-yiboz@codeaurora.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Mon, 23 Sep 2019 12:55:05 +0200
Message-ID: <87impj5lkm.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: dHrMdVX2MwSAXUnImxaw5g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Yibo Zhao <yiboz@codeaurora.org> writes:

> Not long after the start of multi-clients test, not a single station is
> an eligible candidate for transmission since global virtual time(g_vt) is
> smaller than the virtual airtime(s_vt) of all the stations. As a result,
> the Tx has been blocked and throughput is quite low.
>
> This may mainly due to sync mechanism and accumulative deviation from the
> devision calculation of g_vt.
>
> For example:
> Suppose we have 50 clients in first round.
> Round 1:
> STA=09weight=09Tx_time_round  wt_sum=09s_vt=09g_vt  valid_for_next_Tx
> 1=09256=092048=09=0912800=092048=092000=09N
> 2=09256=092048=09=09=092048=09=09N
> .=09.=09.=09=09=09.=09=09.
> .=09.=09.=09=09=09.=09=09.
> .=09.=09.=09=09=09.=09=09.
> 50=09256=092048=09=09=092048=09=09N
>
> After this round, all the stations are not valid for next transmission du=
e to
> accumulative deviation.
>
> And if we add a new #51,
> STA=09weight=09Tx_time_round  wt_sum=09s_vt=09g_vt  valid_for_next_Tx
> 1=09256=092048=09=0913056=092048=092020=09N
> 2=09256=092048=09=09=092048=09=09N
> .=09.=09.=09=09=09.
> .=09.=09.=09=09=09.
> .=09.=09.=09=09=09.
> 50=09256=092048=09=09=092048=09=09N
> 51=09256=091024=09=09=092524=09=09N

That's better :)

> Sync is done by:
> max(g_vt of last round - grace period, s_vt)
> and s_vt of #51 =3D max(2000 - 500, 0) + 1024 =3D 2524, and it is more th=
an the final
> g_vt of this round.
>
> After this round, no more station is valid for transmission.
>
> The real situation can be more complicate, above is one of the extremely =
case.
>
> To avoid this situation to occur, the new proposal is:
>
> - Increase the airtime grace period a little more to reduce the
>   unexpected sync
>
> - If global virtual time is less than the virtual airtime of any station,
>   sync it to the airtime of first station in the red-black tree
>
> - Round the division result

I can see why we need the second part (basically, this happens because I
forgot to add a check for "no eligible stations" in may_transmit(), like
the one in next_txq()). And rounding up the division result doesn't
hurt, I guess. But why does it help to change the grace period if we're
doing all the other stuff?

-Toke

