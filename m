Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE3924D8A6
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Aug 2020 17:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727955AbgHUPdV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 21 Aug 2020 11:33:21 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57403 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727116AbgHUPdT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 21 Aug 2020 11:33:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598023995;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4XGmrJG0r9Gx0szSq/OR6yykw/4BlbzddO/JhuTgTas=;
        b=CN9z+WjAJ2NnGegCttWDg2VvdMe7L3JpOBzjqliBMDEWfPgtnA4HMHrToszxCgESPm8Cmd
        QCeZDBYq3waGXvTPI69wvwV+KjhoEjqOSI7HP209Ax3uDDxLxzRD2yAeUPaRInbz1MKX2D
        KjZjGMw5/o9LAGQsAmgo71VH+aiSbPs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-329-Na0eXuPIM6Kjc344L08DcQ-1; Fri, 21 Aug 2020 11:33:12 -0400
X-MC-Unique: Na0eXuPIM6Kjc344L08DcQ-1
Received: by mail-wm1-f70.google.com with SMTP id p184so1116695wmp.7
        for <linux-wireless@vger.kernel.org>; Fri, 21 Aug 2020 08:33:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=4XGmrJG0r9Gx0szSq/OR6yykw/4BlbzddO/JhuTgTas=;
        b=OTyZhgm5n70DkksCOqi+gURmCs1lDrZKdHNBhuF0cQgc/3RbwxgvbqkbOTSQBFwgRK
         W1NudXy5ut0dAtaWeOtTEO/IMIeY+eyNHxINoY+Rb3ivEwbUwwY6H7wKgzVGAoBDZSmO
         eybc5QjwJyttkTq71IjklBCWCmkh4xt1RgnYAFKZVNp2GV7ZNzyeNYfVGl82U9xO5RMc
         FYfAGfibcr3EsTWqfcEXHs8RwFE9s0uyN45g0MlpGZWU7faPG0juCtre83uSmT0o+Lu3
         BuWungQ/bK6wxsCZkjx3HugLspTYAIUXmh/LH6Yv8NfdVdC4dV1beNUDWTg2/2ILpIFQ
         13Eg==
X-Gm-Message-State: AOAM533+xvbIs+U7AaM6Eo6g2KCEYGUE2t3Hr6Xmb0HV6axXYgC7NflS
        s40T6wT0NUixeFw2c/COK38KLv1DSL5bn+hninNqGvZmqgPdiaZ8A73SzLvH6fm+XDx77e4R0Zm
        9Bt040tUzfeJDXNwbq7hwPjqPQcs=
X-Received: by 2002:a5d:464e:: with SMTP id j14mr3199137wrs.361.1598023991775;
        Fri, 21 Aug 2020 08:33:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJydywpgQoWiR8pKMH3Y2iPNZpuCPcU6Gdwufp632KCMtoUIUGiV0gF83e2vgPwSejULBAjmRw==
X-Received: by 2002:a5d:464e:: with SMTP id j14mr3199113wrs.361.1598023991512;
        Fri, 21 Aug 2020 08:33:11 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id i11sm1541448wmi.5.2020.08.21.08.33.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 08:33:10 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id A9EAF1816A2; Fri, 21 Aug 2020 17:33:09 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Sebastian Gottschall <s.gottschall@dd-wrt.com>,
        Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net
Subject: Re: [PATCH 5.9 3/3] mac80211: improve AQL aggregation estimation
 for low data rates
In-Reply-To: <61d66ec8-117e-7c75-2b4a-1de7715f0bce@dd-wrt.com>
References: <20200813155212.97884-1-nbd@nbd.name>
 <20200813155212.97884-3-nbd@nbd.name>
 <c3c5197f-17f7-4f6b-712f-d7c68f39ae38@dd-wrt.com> <87tuww2ggm.fsf@toke.dk>
 <61d66ec8-117e-7c75-2b4a-1de7715f0bce@dd-wrt.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 21 Aug 2020 17:33:09 +0200
Message-ID: <87r1s02eve.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Sebastian Gottschall <s.gottschall@dd-wrt.com> writes:

> i mean airtime fairness policy was not configured

Ah, right, that makes a lot more sense :)

Still not sure why this would affect throughput, though; maybe the
change in calculation makes AQL overestimate the airtime and throttle
too much? Or does the saving of last_rate_info on tx_status_ext() work
badly for ath10k?

-Toke

