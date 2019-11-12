Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC8EFF9062
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Nov 2019 14:17:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727402AbfKLNRm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 12 Nov 2019 08:17:42 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:50237 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726995AbfKLNRm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 12 Nov 2019 08:17:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573564660;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AliItwfw4YWRWjQtWK/GvH7UKlLTomUA43q3p0WZDlM=;
        b=iJeanaE48RkIqdQiJugv2uwG/YXFGljBM1RtvrnTyIvEg45uQgL56+ZBYVVnXBIegfnC/f
        TZQT/6vfn6PAfWG0BuJEJKRTsLokY9/zPMH4LAW8NUuaP7CAAKfNzqEgAbPHbI2s5Nx6Hd
        dpICex436c+PC+T19l7KMDNm+33IJXs=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-290-NnuDufDZNkyxlAJPfGnlrg-1; Tue, 12 Nov 2019 08:17:39 -0500
Received: by mail-lf1-f69.google.com with SMTP id p4so3836286lfo.10
        for <linux-wireless@vger.kernel.org>; Tue, 12 Nov 2019 05:17:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=K0FZD4LytkF64adc6Lv+uFZa0BGm426AM3JcwYl6rd8=;
        b=Czfm4kIQDWvaPeUwAG3DBBCvq5TAncchgz9cItXQCTqNAUogqL/7PL9iyuXgT7TnqN
         QD1v81CscrkKCCLYtNxEH3TFrjGdC4fcXzGkjRuUhp4rcT4Oq6MY5JyZZUNC1gjnxJa0
         qgf6LGHcU+ft/7oFjLPzo8MurOqkTNarnZPgmBr1MKtwNZHSmuR2HEq5K1Kjcz3mzJ9g
         PUV+WC/LW04eCE4VHJ103GYldsZizIC7cowR8ORaZLmOdnX0SVKvNUspsMiIEy1M23fv
         t/WRYgxYGKXMdACgFJNS7LNiqOmX52zc62iiClmvKtp20QfDQFO1yHXNjX8DkT2SnsA8
         DwgQ==
X-Gm-Message-State: APjAAAUhkSE2EjkVNVdz248bOYo/mmVHSAUVUFwVWni92yXGYC2JGTGO
        EIQ77Dlx3vQdJxd7ERbaLKeIpq/wgnnhPctnzuuke6Here+EF/XP9JQPZfo6T5Kn+Xp6WcinKMy
        PuJLM/ao6vOAwH2mKotFNDUb3+aw=
X-Received: by 2002:a19:c386:: with SMTP id t128mr10407244lff.7.1573564658259;
        Tue, 12 Nov 2019 05:17:38 -0800 (PST)
X-Google-Smtp-Source: APXvYqx2jcwj6koSUx0du+XhuPt1y+3un6XDcB3zArxOgsVOE+z4bVEO3NPyFSCaYosok/3MoUoc6A==
X-Received: by 2002:a19:c386:: with SMTP id t128mr10407229lff.7.1573564657940;
        Tue, 12 Nov 2019 05:17:37 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a00:7660:6da:443::2])
        by smtp.gmail.com with ESMTPSA id h16sm10588566ljb.10.2019.11.12.05.17.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 05:17:37 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 5175A1803C7; Tue, 12 Nov 2019 14:17:36 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, Kan Yan <kyan@google.com>
Subject: Re: [PATCH] mac80211: Add new sta_info getter by sta/vif addrs
In-Reply-To: <20191112130835.382062-1-toke@redhat.com>
References: <20191112130835.382062-1-toke@redhat.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 12 Nov 2019 14:17:36 +0100
Message-ID: <87sgmtp72n.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: NnuDufDZNkyxlAJPfGnlrg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com> writes:

> In ieee80211_tx_status() we don't have an sdata struct when looking up th=
e
> destination sta. Instead, we just do a lookup by the vif addr that is the
> source of the packet being completed. Factor this out into a new sta_info
> getter helper, since we need to use it for accounting AQL as well.
>
> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

This was another self-contained change that is a pre-requisite for the
AQL patch, but I figured I could just send on its own while we iterate
on the main patch.

Johannes, do feel free to tell me if it is annoying to do it this way;
I'm just trying to speed things up a bit (while eyeing the fast
approaching merge window :)).

-Toke

