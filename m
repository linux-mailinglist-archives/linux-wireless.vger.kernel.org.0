Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67547555D4
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jun 2019 19:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728874AbfFYR0l (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Jun 2019 13:26:41 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:38876 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726576AbfFYR0l (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Jun 2019 13:26:41 -0400
Received: by mail-lj1-f194.google.com with SMTP id r9so17069599ljg.5
        for <linux-wireless@vger.kernel.org>; Tue, 25 Jun 2019 10:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6gq84utB8K04TkFkVIjVVbqj+RReCP6QFmHdu5HDrdE=;
        b=naD61bgrphwvsuQeh7I3S2TOG7WlFTu05G05sniZdPLkEFxpVLI4QzWmwpfPA9CiN2
         ATfzx5rBs7HjKcRc1YDoStMPiGwTbE/QZWGQPVuWefMqhX47HS5O9BFNQFOGzfMmdXPX
         IVJXBGv0G6J/Vm5nvfJK/lyKs9vJ4Qmi6I9GU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6gq84utB8K04TkFkVIjVVbqj+RReCP6QFmHdu5HDrdE=;
        b=Fm/USSgJV0ILeTNNGp+u6m67bv7y4Atd4fo3R5luYHwM7rqvqhSopbxuI/dVbhe3Es
         0r+r63sIjmu4LeX5DlW4VNrXK/i74FicsUQ2tqbQ87RVI29GZG5JoCBkBBYRZQjNM9+o
         8pkVb9ygM4btdPT0d53c6bpGNh+mSpZZ6Ogg3fS3gvD4UigZyM/9WsasOVRwceDKsJF8
         fhbV55O7YKDTpRIgjyPdf6Qk4FL3fuodmmAxyGVy/EG12yEwb1g0ztBLtWhkWl+B+yZ5
         AqzZmMgk4XuoisKJnUxOXCkQchFQxxYJwxFesn956wUp9BT+6baZM34lHAhqrDaG/Knz
         9SxQ==
X-Gm-Message-State: APjAAAXcPup+ygKT3fOzsiwZOh3exQLmYl4beHmVEl8EbrvKfXwp+1Q7
        PA7Jxjvb191o9gnljcOhW4D3t+kanzs=
X-Google-Smtp-Source: APXvYqzkhYBNzgSNvfBMsTl9gydbQib6IZyjloqRfJzquDzIazGUVTLkeeYELxZVbW3z1g8Soquzug==
X-Received: by 2002:a2e:981:: with SMTP id 123mr53971235ljj.66.1561483598986;
        Tue, 25 Jun 2019 10:26:38 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id u13sm2028090lfi.4.2019.06.25.10.26.37
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Jun 2019 10:26:38 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id z15so13185775lfh.13
        for <linux-wireless@vger.kernel.org>; Tue, 25 Jun 2019 10:26:37 -0700 (PDT)
X-Received: by 2002:a19:5515:: with SMTP id n21mr22825839lfe.26.1561483597150;
 Tue, 25 Jun 2019 10:26:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190604205323.200361-2-briannorris@chromium.org> <20190625044525.846A8607DE@smtp.codeaurora.org>
In-Reply-To: <20190625044525.846A8607DE@smtp.codeaurora.org>
From:   Brian Norris <briannorris@chromium.org>
Date:   Tue, 25 Jun 2019 10:26:25 -0700
X-Gmail-Original-Message-ID: <CA+ASDXP2xY_7BXk6L25FVFf1yyhnXOZygYwreGYGVY7aK0TVkg@mail.gmail.com>
Message-ID: <CA+ASDXP2xY_7BXk6L25FVFf1yyhnXOZygYwreGYGVY7aK0TVkg@mail.gmail.com>
Subject: Re: [PATCH 1/2] mwifiex: dispatch/rotate from reorder table atomically
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Ganapathi Bhat <gbhat@marvell.com>,
        Nishant Sarmukadam <nishants@marvell.com>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Xinming Hu <huxinming820@gmail.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Doug Anderson <dianders@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Jun 24, 2019 at 9:45 PM Kalle Valo <kvalo@codeaurora.org> wrote:
> New warning:
>
> drivers/net/wireless/marvell/mwifiex/wmm.c: In function 'mwifiex_wmm_process_tx':
> drivers/net/wireless/marvell/mwifiex/wmm.c:1438:4: warning: 'flags' may be used uninitialized in this function [-Wmaybe-uninitialized]
>     mwifiex_11n_aggregate_pkt(priv, ptr, ptr_index, flags);
>     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/net/wireless/marvell/mwifiex/wmm.c:1406:16: note: 'flags' was declared here
>   unsigned long flags;
>                 ^~~~~

Yikes! Not sure how I missed that, as I *thought* I had -Werror
enabled. Maybe things got lost a bit in the shuffles from GCC to Clang
for building our kernels internally.

Anyway, "used" is a bit generous here, since these are just useless
function arguments (never *actually* used now). I should remove these
args entirely.

> 2 patches set to Changes Requested.

Will send a v2.

Thanks,
Brian
