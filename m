Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4693037AF1D
	for <lists+linux-wireless@lfdr.de>; Tue, 11 May 2021 21:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232054AbhEKTMQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 May 2021 15:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231439AbhEKTMQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 May 2021 15:12:16 -0400
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FCAFC061574
        for <linux-wireless@vger.kernel.org>; Tue, 11 May 2021 12:11:09 -0700 (PDT)
Received: by mail-oo1-xc36.google.com with SMTP id l25-20020a4a35190000b029020a54735152so463215ooa.4
        for <linux-wireless@vger.kernel.org>; Tue, 11 May 2021 12:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IFnrqDxgmbDsaVUtrV/oF1WpAJvkWaxKP9Bq2K33Wvo=;
        b=b09ytGyivhbI8K/zbZcp9sDKhGmjau2pkv/7ypBP4Mp/rl0wCKVXl3JpZuLmU/YOpp
         2ZcXFsCdRAOVBfwYE/0j2kmsvLb44az0BQXzaAB4ZATnjMVIwwh4sVG1rwwqGZD42t/D
         Oux/pXwt6aTWiW+7uplshgZg7Bwd4csK1oJIo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IFnrqDxgmbDsaVUtrV/oF1WpAJvkWaxKP9Bq2K33Wvo=;
        b=nn3+098i1O7u9rq9igjubXwvXdiFsO8xnuTY3+a7URGQidulfCWE+uuvVJGyqjz0Qb
         BTJuQlzSgVgMp0fEqVRkP1Ta4/yE8XJDUs3UkEYGqStNFAaaTBJe5201HAfBOFpPNf6/
         jRSKy9xMDnrHeZKieLzU0xBCNhCcaDkIGcc8QN3PRGOip7/5qD0ItokF2hoQ6GD8mP9n
         qUaxa8ag84SulX8QRfz1oGzkRg/iQNusxYndvJj+9AuAZCS/uPqzAHVT+yroFEAoV8Pn
         fsQJnbTXORsynngDpW61EZzHldxuqu/A90OUpEzir+MNooZNui1henC4erN0FxZCDGuo
         mdgA==
X-Gm-Message-State: AOAM532+BY7rYVOs3KhIaX9xMjwteGkL7olN4zLdYMMDG6GVt3C/cKXY
        OMaeTaUHlm1aY+HCs4ZptG0pRD9fXt/N2Q==
X-Google-Smtp-Source: ABdhPJy/jlr8qg8GG0pOHutqmEOXU5XCJxQCt5kxsBR/CQ7TECykxqqSyXhPAhXefh68hWIgHjIRrw==
X-Received: by 2002:a4a:e934:: with SMTP id a20mr24802030ooe.27.1620760268325;
        Tue, 11 May 2021 12:11:08 -0700 (PDT)
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com. [209.85.210.48])
        by smtp.gmail.com with ESMTPSA id y191sm2496763oia.50.2021.05.11.12.11.07
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 May 2021 12:11:07 -0700 (PDT)
Received: by mail-ot1-f48.google.com with SMTP id d3-20020a9d29030000b029027e8019067fso18404081otb.13
        for <linux-wireless@vger.kernel.org>; Tue, 11 May 2021 12:11:07 -0700 (PDT)
X-Received: by 2002:a05:6830:1bd8:: with SMTP id v24mr27430126ota.203.1620760267068;
 Tue, 11 May 2021 12:11:07 -0700 (PDT)
MIME-Version: 1.0
References: <57e9f582340545c79a9ab3433e2a4a7d@realtek.com> <87cztx87tr.fsf@tynnyri.adurom.net>
In-Reply-To: <87cztx87tr.fsf@tynnyri.adurom.net>
From:   Brian Norris <briannorris@chromium.org>
Date:   Tue, 11 May 2021 12:10:55 -0700
X-Gmail-Original-Message-ID: <CA+ASDXM9YmhMWmttkrCxB0_tf6Kf6Sz=7Yc26CmjZmMUxyxAfw@mail.gmail.com>
Message-ID: <CA+ASDXM9YmhMWmttkrCxB0_tf6Kf6Sz=7Yc26CmjZmMUxyxAfw@mail.gmail.com>
Subject: Re: Request to update 8852a firmware of rtw89 to v0.13.8.0
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Pkshih <pkshih@realtek.com>,
        "linux-firmware@kernel.org" <linux-firmware@kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, May 11, 2021 at 11:05 AM Kalle Valo <kvalo@codeaurora.org> wrote:
>
> Pkshih <pkshih@realtek.com> writes:
>
> > Please help to update 8852a firmware.
> > This is first time I send a pull request. If anything is wrong, please let me know.
>
> rtw89 driver is not in upstream yet, and it has not been reviewed
> either. I recommend holding off pulling the firmware until the driver is
> reviewed.

FWIW, preliminary rtw89 firmware was already merged. This is just an update.

I also wonder, what's the harm? People like me are actively testing
the early versions, and I've done a very barebones amount of review (I
hope to do more). It really helps me to have up-to-date firmware
published somewhere central -- I guess I can take GitHub instead, but
again, why not kernel.org? If anyone else is looking at testing, they
know where to get the pieces too, and we can compare results.

Brian
