Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DEB2B50EE
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Sep 2019 17:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728917AbfIQPDY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Sep 2019 11:03:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23745 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726183AbfIQPDY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Sep 2019 11:03:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1568732601;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=39CxzmaLHz+D7ZHqUHBYncwyADZWR/ZBJ8QLgYTPZ5c=;
        b=YvgUKQo4yJxTCqcwrjrY1JoLvdjCYqiwakAbBRxI6o7dK07c6YKIq4w4kIDDlT97yeN+Zp
        gcUHWpSQqEZ6+Xb9+wnYz5k2sLgaAD05n+VtQtg7NtpSyCYQgNUEvaWNDfWTHotnywdZV+
        9rWSz2dXiVjVvjZwpUNsNXoVgNM4Jtg=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-115-CkiVhOi5OdyFZXjnxYtvJA-1; Tue, 17 Sep 2019 11:03:15 -0400
Received: by mail-ed1-f69.google.com with SMTP id d7so2380980edv.3
        for <linux-wireless@vger.kernel.org>; Tue, 17 Sep 2019 08:03:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=39CxzmaLHz+D7ZHqUHBYncwyADZWR/ZBJ8QLgYTPZ5c=;
        b=GtWtvmmRCUv5lbJivxrubCqVjf3bZmr5GxotKbEc02svCwzWnkF27QljWq9J4VZaJi
         ++Oo35rameLJygz7U6Ave5Ri4bctEd82T7RSP940i6tdZ2//QWCmejg4GDbtZWXf8pFH
         XfU5l2ukjrXJlBsOKnL2sbGv3IiBZSoVennY8TNl4/tcAJFNJ5tTIW3bjolxDSRc/XvL
         h4zapo5qKixJ2XT6e0REDwbbwzVlQjHqcdfIhSHfpizZkwOaqEcqkdDEu321pW1pu6RO
         IANrCdfFQTqmTDRFUbFKB1nHKZCtdemwS5XduFYhfB3u+YOoN2lUNUqVKIztLuznF32l
         SLmQ==
X-Gm-Message-State: APjAAAUJ/Pq9mHc99Qk/UoF+QM7qjmLFY8bZ1PU17SwsP3wp/Vc2rwoo
        vL2FLgnF1ryVsAO5QeqVgYr3FZEQK+sTRGYVfwXhJHMtaluMero4oixZwSNG+tkyTO43+x8+GQ+
        3P+Qh/QKV/6YVuKbXe6XOvkUzkpU=
X-Received: by 2002:a50:9f42:: with SMTP id b60mr5270485edf.192.1568732594558;
        Tue, 17 Sep 2019 08:03:14 -0700 (PDT)
X-Google-Smtp-Source: APXvYqx/E887Tte6e2oBD2MkVPvI8rpiPAdKjjBr+LaXcr+16wXfYbi4NwaiBprYRSL89rNdw5LFLw==
X-Received: by 2002:a50:9f42:: with SMTP id b60mr5270470edf.192.1568732594384;
        Tue, 17 Sep 2019 08:03:14 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a00:7660:6da:443::2])
        by smtp.gmail.com with ESMTPSA id w21sm479000eda.90.2019.09.17.08.03.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2019 08:03:12 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 4A3C21800EA; Mon, 16 Sep 2019 16:51:37 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Yibo Zhao <yiboz@codeaurora.org>, ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH 1/4] mac80211: Switch to a virtual time-based airtime scheduler
In-Reply-To: <1568639388-27291-1-git-send-email-yiboz@codeaurora.org>
References: <1568639388-27291-1-git-send-email-yiboz@codeaurora.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Mon, 16 Sep 2019 16:51:37 +0200
Message-ID: <877e68l2fa.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: CkiVhOi5OdyFZXjnxYtvJA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Yibo Zhao <yiboz@codeaurora.org> writes:

> From: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>
> This switches the airtime scheduler in mac80211 to use a virtual time-bas=
ed
> scheduler instead of the round-robin scheduler used before. This has a
> couple of advantages:

Thank you for keeping at this! I'll take a look at the series in detail
tomorrow.

While you're testing things related to this, I've also prototyped a port
of the "airtime queue limit" feature from chromeos into mainline. It's
currently in my tree here:
https://git.kernel.org/pub/scm/linux/kernel/git/toke/linux.git/log/?h=3Dmac=
80211-aql-01

If you have time to test it at some point, that would be awesome. I'm
planning to submit it as an RFC, but it needs a bit more work first.
Also, it's completely untested, but it does compile :)

-Toke

