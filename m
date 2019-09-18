Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24741B60E8
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Sep 2019 11:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727268AbfIRJ7e (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Sep 2019 05:59:34 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:25113 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbfIRJ7e (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Sep 2019 05:59:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1568800773;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P9WqcH2Kq+9XpONyBW69IEnKIdCefcbhq4jZ2yFV0Kk=;
        b=HBVIlyCAfkEupV9YiN8XGp4/MuwVTPj9nGje8qe9s09NjWYucSfBAHv+z4+dQKbN/LPsxa
        6JoH83Mkumrne4mBIHTvOFxgI5tHEDOhhCO7exS6XehgniL2w+mpKLQh6EIFQWfXxfaJ9c
        XgRZQm02/myh4/JRgyt1J4L21r0eDcA=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-22-l7L2lRt1N0i52AyQ1Ci2LA-1; Wed, 18 Sep 2019 05:59:31 -0400
Received: by mail-ed1-f72.google.com with SMTP id y66so4054416ede.16
        for <linux-wireless@vger.kernel.org>; Wed, 18 Sep 2019 02:59:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=ZD8uA0HGF7NCYNdZxFWIEW/HS+gtn7eLpXQdH0FQyJo=;
        b=e9bCZm/r1tO5hMwDATlZtJ0nlWYcq1T84VgDZal+OF9cAJJiqz7BZgJhMT1x/xnJ+5
         rbqT1NzU2dzMN4S/36n0H4yBFh4TlxF7awi4EMCctm4z0n5mxK8QvKhn5alSFwQsXUoU
         1SFxIFsUqqc6YB3F/0yA3dwL5L2CkqeFpoUeFyasfTuZ6dyMHhYRrZLAkTPlZqkUpRy4
         TqkRyfX64V3H4lxB10ZY5RAmfOMep8n2GCO8+ahwKHpFaeWYU8bBTYIECv+IWUHS10oT
         RJ9mNnBX+xAeNX8EziUi5Qr0QJOK8TGyIY9YxIn7RvPDbUA/a7d0+GzxioFXwJY9XIeQ
         uo4Q==
X-Gm-Message-State: APjAAAVDLINBnH5Sdg5ICVsON76My5c3bgo99o6+61oEQGsQkGlog/rG
        VVzg0Ogm3FnlG5VL2WauzhZOfxVvCoG3iIK3a2OZOI8rwbvSQEerTNuXDM3rXUhHGBlF3+aWzvk
        giOOzyS2qhedHHOCVXWVfDZRW4vU=
X-Received: by 2002:aa7:c743:: with SMTP id c3mr2800704eds.241.1568800770653;
        Wed, 18 Sep 2019 02:59:30 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxSAT4/blEd1fCDSc8brt8jBNV6q/lz7K4YCcjE3EOT0gfkud9Iv/moo/hX+IrNDXuI1fvGFg==
X-Received: by 2002:aa7:c743:: with SMTP id c3mr2800691eds.241.1568800770529;
        Wed, 18 Sep 2019 02:59:30 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a00:7660:6da:443::2])
        by smtp.gmail.com with ESMTPSA id a11sm951945edf.73.2019.09.18.02.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2019 02:59:29 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 5A39818063E; Wed, 18 Sep 2019 11:59:28 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Yibo Zhao <yiboz@codeaurora.org>, ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, Yibo Zhao <yiboz@codeaurora.org>
Subject: Re: [PATCH V2 3/4] mac80211: fix low throughput in multi-clients situation
In-Reply-To: <1568800033-17297-3-git-send-email-yiboz@codeaurora.org>
References: <1568800033-17297-1-git-send-email-yiboz@codeaurora.org> <1568800033-17297-3-git-send-email-yiboz@codeaurora.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 18 Sep 2019 11:59:28 +0200
Message-ID: <874l19j56n.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: l7L2lRt1N0i52AyQ1Ci2LA-1
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
> .=09.=09.=09=09=09.=09=09.
> .=09.=09.=09=09=09.=09=09.
> .=09.=09.=09=09=09.=09=09.
>
> After this round, all the stations are not valid for next transmission du=
e
> to accumulative deviation.
>
> And if we add a new #51,
> Round 2:
> STA=09weight=09Tx_time_round=09wt_sum  s_vt=09g_vt  valid_for_next_Tx
> .=09.=09.=09=09=09.=09=09.
> .=09.=09.=09=09=09.=09=09.
> .=09.=09.=09=09=09.=09=09.
>
> Sync is done by:
> max(g_vt of last round - grace period, s_vt)
> and s_vt of #51 =3D max(2000 - 500, 0) + 1024 =3D 2524, and it is more th=
an the
> final g_vt of this round.
>
> After this round, no more station is valid for transmission.

I'm not sure I understand this. Was there supposed to be numbers in
those tables above?

-Toke

