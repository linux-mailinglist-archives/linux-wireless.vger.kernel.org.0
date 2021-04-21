Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDF3B366833
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Apr 2021 11:37:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238420AbhDUJiA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Apr 2021 05:38:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53384 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238481AbhDUJhx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Apr 2021 05:37:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618997840;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QQ/oN78pwE6YFm8TpVb2QhRE5dd8heRRoUH8QeszxhE=;
        b=F1D5vec2r7ty1LC4OUfRpl6k7cABsV3l/iOEKUBAwb2YvXi675g/F1Oox8PcwIBVzA19Zi
        NRymuGRkG0yETy7xupc7H0N3y+vWm/pv5V9Aj66CA9vwczzpPhUbeufuJdvnkyqeGuQjqg
        KHBhyQ2WV8fXw0AV0GgHYVgg7vg1Gcw=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-397-RrETDCchOpGUNomIvGFIdw-1; Wed, 21 Apr 2021 05:36:55 -0400
X-MC-Unique: RrETDCchOpGUNomIvGFIdw-1
Received: by mail-ed1-f69.google.com with SMTP id l7-20020aa7c3070000b029038502ffe9f2so8933167edq.16
        for <linux-wireless@vger.kernel.org>; Wed, 21 Apr 2021 02:36:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=QQ/oN78pwE6YFm8TpVb2QhRE5dd8heRRoUH8QeszxhE=;
        b=lkpvGPoDKwS1+D+IYlOkluG3gQMbVtV+UODJhZDU03Z70kE3e/9XLC5paA1k50ItZf
         cSIOoETFn3+KCFFEMWhLyy2sPz1yTDG6Cr6DB2nZHuhFfWlbmqECDP7XssrpqZ0V7f8F
         vk+Ly5VAfPOBYNx4Vm9y31OF+RZJimCgGcrBILDSpOIUd8/JcmZkqNanH1c5sbKBRI/C
         pP6sL2bHdaGBCfd7lYLjfqX/5TH++Sp+zeuCaP/fzBI+94ntnuojPLDWu0UlnoLtIThQ
         s2bT0Z3qcj09ER+iOIELHPB0GzOSAcakgLWt57rwiwcKXTYNWxkAEhg5y5Dd1rP9TrOc
         dlew==
X-Gm-Message-State: AOAM531GfCcT5bgGwCjdn0RqIl5EMC/NPwbzsE4P/4rUjbAxb7LnGkjN
        GmTlfbugSgrRzbzL1Avg7bWO83mWHqbwyI8bwBq67d4aw23ujme/UYjHUBZc9VsHzIVbPBm9SQj
        mHfC79G8M2Tmnv5UOCd62XQwHthc=
X-Received: by 2002:a50:e702:: with SMTP id a2mr38245794edn.3.1618997813770;
        Wed, 21 Apr 2021 02:36:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwvhCejG1DrIwnRgxc1FZStgBq5K53/nGMs5fkxMS5fB3JQ8m8hB/NJersw6m4gvBiuSHafog==
X-Received: by 2002:a50:e702:: with SMTP id a2mr38245780edn.3.1618997813596;
        Wed, 21 Apr 2021 02:36:53 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id v1sm2518872eds.17.2021.04.21.02.36.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 02:36:53 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 719BC1804E5; Wed, 21 Apr 2021 11:36:52 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH] ath9k: Fix error check in ath9k_hw_read_revisions() for
 PCI devices
In-Reply-To: <87lf9cj969.fsf@codeaurora.org>
References: <20210326180819.142480-1-toke@redhat.com>
 <87a6puimgu.fsf@toke.dk> <87lf9cj969.fsf@codeaurora.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 21 Apr 2021 11:36:52 +0200
Message-ID: <87lf9cdlmz.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kalle Valo <kvalo@codeaurora.org> writes:

> Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com> writes:
>
>>> When the error check in ath9k_hw_read_revisions() was added, it checked=
 for
>>> -EIO which is what ath9k_regread() in the ath9k_htc driver uses. Howeve=
r,
>>> for plain ath9k, the register read function uses ioread32(), which just
>>> returns -1 on error. So if such a read fails, it still gets passed thro=
ugh
>>> and ends up as a weird mac revision in the log output.
>>>
>>> Fix this by changing ath9k_regread() to return -1 on error like ioread3=
2()
>>> does, and fix the error check to look for that instead of -EIO.
>>>
>>> Fixes: 2f90c7e5d094 ("ath9k: Check for errors when reading SREV registe=
r")
>>> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>>
>> Hi Kalle
>>
>> This patch is merged as "deferred" in patchwork - what's up with that?
>
> Just lack of time on my part. Reviewed-by tags would help a lot :)

Right, gotcha - will see if I can find someone to review :)

-Toke

