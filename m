Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2781363FBB
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Apr 2021 12:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232313AbhDSKnz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 19 Apr 2021 06:43:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:42020 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233511AbhDSKnr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 19 Apr 2021 06:43:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618828997;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iPxRq6tf+R8MaCgylaofFpQ5l/lc5BCj0UpGfgKO004=;
        b=WOeONsTBSqKI9QHkmqifdI3BT6iPgsi96C/8YQyJksUsf40a0dG1PGrgKbCWsQ7nU24m+V
        VslVyg7FWxfritSa9+DTNhlNyt2CK6oUejqx16WQ3gaVFz9tVtdsahyx14Vnzvof0tBUuK
        Hup3GXvliytYmNufLp+SBV6foFcSu3c=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-512-bKvVxS8vPOW5E-sITq6SUw-1; Mon, 19 Apr 2021 06:43:16 -0400
X-MC-Unique: bKvVxS8vPOW5E-sITq6SUw-1
Received: by mail-ed1-f71.google.com with SMTP id f9-20020a50fe090000b02903839889635cso8980306edt.14
        for <linux-wireless@vger.kernel.org>; Mon, 19 Apr 2021 03:43:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=iPxRq6tf+R8MaCgylaofFpQ5l/lc5BCj0UpGfgKO004=;
        b=iKU1M8AHJlDi41yiqnk3UM57e3O0v72HyzJN7YZFPvMgtAMvml3Ljv6S99yG9zWgG6
         fWqZ2/o+YgnE04GL8bhm2s/LT3ArJNWq/kvoXMQnlmz6ktA/aDJPSB8GBmTub3rdDgbl
         /T+hLtMCU1R574gODHfVKPTe5OPWuhA85DyJ3EY9fHxgctT1H3MKjSNRmnT2KMMx6YQq
         JALk75iv4ylvIXo8btBm4TCjXXhAVM/qUBgu6n84shVEreLl8tERTyfJobUS4OL0HdZC
         lSfOA0s7cm5PW/YVb6thGsQsUeqKb2SkM3+1+lvjKVCxAEq9M6EmY5IMCFDzQNd10bF6
         7aqg==
X-Gm-Message-State: AOAM533UO+7Od5m0VCOK0xxI7/kKKMlgGnUFjRKe9MRxBgju6cnVJkxk
        QyWCgGuRFsXqnxBdL1s2UmXKUv/ugA1JwYOegZNCFK+c1+tm/o+3z9iolm7jaGB0pjrfGTzRk8C
        zS8bzLbyyKqq3KvLr3VHLuft5cNk=
X-Received: by 2002:a17:906:5f95:: with SMTP id a21mr21070041eju.456.1618828994709;
        Mon, 19 Apr 2021 03:43:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwh5n3CHBwCdGWhmyIVUU/azR1dFpTnbtOfNqpiGwukL5enz5rI9MDFV3Yv/D6Nnsr2hJcYTA==
X-Received: by 2002:a17:906:5f95:: with SMTP id a21mr21070033eju.456.1618828994589;
        Mon, 19 Apr 2021 03:43:14 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id e16sm12656652edu.94.2021.04.19.03.43.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 03:43:14 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 709D2180002; Mon, 19 Apr 2021 12:43:13 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH] ath9k: Fix error check in ath9k_hw_read_revisions() for
 PCI devices
In-Reply-To: <20210326180819.142480-1-toke@redhat.com>
References: <20210326180819.142480-1-toke@redhat.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Mon, 19 Apr 2021 12:43:13 +0200
Message-ID: <87a6puimgu.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

> When the error check in ath9k_hw_read_revisions() was added, it checked f=
or
> -EIO which is what ath9k_regread() in the ath9k_htc driver uses. However,
> for plain ath9k, the register read function uses ioread32(), which just
> returns -1 on error. So if such a read fails, it still gets passed through
> and ends up as a weird mac revision in the log output.
>
> Fix this by changing ath9k_regread() to return -1 on error like ioread32()
> does, and fix the error check to look for that instead of -EIO.
>
> Fixes: 2f90c7e5d094 ("ath9k: Check for errors when reading SREV register")
> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

Hi Kalle

This patch is merged as "deferred" in patchwork - what's up with that?

-Toke

