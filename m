Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDD432418DE
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Aug 2020 11:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728413AbgHKJ1o (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Aug 2020 05:27:44 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:30422 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728224AbgHKJ1o (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Aug 2020 05:27:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597138062;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oFp0w80D29dDA0ZQ5YLJE5EDG9qzXJ98aRgcFxaoijM=;
        b=OjF6pRHWjyk/PkW1tCBda5FchJ+oLsYbdUrAphlipSRdaNfDwYwQNBKOypy/Ixxvb6fVsh
        4cumg4MhbIpYtmA6hkFAWppda4cupm749+j0xV/zMxBf+aSQL9HyON3KdTnwHF3TPIlM5R
        85TN25gnhQzYSXR/fWPiqGuKEUsUe4c=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-554-8huPqE39O4GHwtUP-O72Cw-1; Tue, 11 Aug 2020 05:27:41 -0400
X-MC-Unique: 8huPqE39O4GHwtUP-O72Cw-1
Received: by mail-wr1-f71.google.com with SMTP id t12so5382321wrp.0
        for <linux-wireless@vger.kernel.org>; Tue, 11 Aug 2020 02:27:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=oFp0w80D29dDA0ZQ5YLJE5EDG9qzXJ98aRgcFxaoijM=;
        b=tradiCi5QYDk0AfKqRlbTi06CAqOhP1n2uIxQqLBKke6pa5PqxfAg5YuhSIFO+ZcIC
         aWU3kFtDpfwVcbALFJGujnlzuDeP1HP2jzOWlfiyQpx1PdUUj47GHrI0vBWyCtGOzFUG
         BOld597V8uJQ3ANXKRMBI8SIosBqHYjp5QMd8FOoPxCjaVPiWu7PxATYI42NE99XdVft
         lZKlt9mSNOqGvqN4hl/TxiS3n3w4leXY2oOxpNtIMWdgA7W+V3nQYdEhSqiV90bWq9em
         ATuboaFKeEpPSk7YbzutsKT0pRdQefTZVwbT98c7IP7b41kTNqUZzef9G+WIYy5Ihsii
         O6+Q==
X-Gm-Message-State: AOAM531nxuM17rQE1xes2rVFGYEc5DB5B04b815rI54Gk0qdKcxOTWoZ
        umUW7sMEvGbJuojst2PzOrixPlSxGxy1yxVzlB5SrUYBJoyVVZMCmw9O0UnNWDlhTQZoQ8ETIKZ
        Syx34AM4t5tD+z1HB6K2oRe0hzBk=
X-Received: by 2002:adf:de91:: with SMTP id w17mr28315628wrl.108.1597138059726;
        Tue, 11 Aug 2020 02:27:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwa/R7aReQB/tZPo8lMtEVx8lUNsOmr8lt8xXAHCvCRkzmUYeqwY3xukryCk+pMKLOWCK9PuQ==
X-Received: by 2002:adf:de91:: with SMTP id w17mr28315618wrl.108.1597138059578;
        Tue, 11 Aug 2020 02:27:39 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 145sm4558692wma.20.2020.08.11.02.27.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2020 02:27:39 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id A26E518282F; Tue, 11 Aug 2020 11:27:37 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net
Subject: Re: [PATCH] mac80211: improve AQL tx airtime estimation
In-Reply-To: <20200724182816.18678-1-nbd@nbd.name>
References: <20200724182816.18678-1-nbd@nbd.name>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 11 Aug 2020 11:27:37 +0200
Message-ID: <87d03x352u.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Felix Fietkau <nbd@nbd.name> writes:

> AQL does not take into account that most HT/VHT/HE traffic is A-MPDU aggr=
egated.
> Because of that, the per-packet airtime overhead is vastly overestimated.
> Improve it by assuming an average aggregation length of 16 for non-legacy
> traffic if not using the VO AC queue.
> This should improve performance with high data rates, especially with mul=
tiple
> stations

This seems reasonable!

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

