Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4CC1139991
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jan 2020 20:05:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728767AbgAMTFw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Jan 2020 14:05:52 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:39108 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbgAMTFv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Jan 2020 14:05:51 -0500
Received: by mail-qt1-f196.google.com with SMTP id e5so10064330qtm.6
        for <linux-wireless@vger.kernel.org>; Mon, 13 Jan 2020 11:05:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=05/r1uoo6hivI2yxFGMarKb30fMqhSdQqFht9r494DU=;
        b=G7wNaU9m/AMUsbs+yr9TA4nTqsnTHbAZf2P0+HMpnBYhT/1vFUBRdrku0imAk+yvuC
         JpDH+udqg7CQtOnxuYDTbo7CiIRqsIm9mUJxcAT9vA9Qi/plCBXhPsoyTk3SgaUPhY0o
         l8fsKDsdkSk3AIlfxfAd3Anxg1Q/T7XP7lLvg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=05/r1uoo6hivI2yxFGMarKb30fMqhSdQqFht9r494DU=;
        b=JEXA3z1wgrU9jNudDsqohq/Zz2tv6EcmXiD8F8gx9JuPq0NGHuu+k6IBm0C2Yo4pO4
         vTZfhOHoDD4dVgK2x+ChQXOAVHzuTYBJtFT2jH/yRjyEX62vqlk+DCZHGWRXKBol2IAF
         vDLbQHCmkGMkBoy0L9gnHS2AauwX0CGdOORsfStuh9upWo9tYux6uzfiaE3iefO4zYSu
         h2HP3U4YpUVY9JG/zshEWopp3Uf9cCNWjpiY35mxi8LWRRnd248wCmYPravzEMr5NIIz
         dS7sA4v9u8e9QfGYNZ5BAAo9Y5/N0eC7F/9zHOXsFYS4r0dhhUb0ec6uip1WO/aYNw6i
         WOsA==
X-Gm-Message-State: APjAAAUNR1n13Uubd8bhhk4n5uIB7Y0nfSOtbvx6Jjm5ZenRXgjuYQT4
        6S4mnYlhm78aIfq/14GxVNPqnZjnnzk=
X-Google-Smtp-Source: APXvYqyzy5mmd5YvSi165WjWXNMv2xYUdqY3hWB+lUf75Ti+5W5gHKEsaKgExgZmJC1XEAza7Rkoag==
X-Received: by 2002:aed:3c12:: with SMTP id t18mr70082qte.140.1578942350247;
        Mon, 13 Jan 2020 11:05:50 -0800 (PST)
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com. [209.85.222.179])
        by smtp.gmail.com with ESMTPSA id 2sm5414189qkv.98.2020.01.13.11.05.48
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jan 2020 11:05:48 -0800 (PST)
Received: by mail-qk1-f179.google.com with SMTP id k6so9578482qki.5
        for <linux-wireless@vger.kernel.org>; Mon, 13 Jan 2020 11:05:48 -0800 (PST)
X-Received: by 2002:a05:620a:2043:: with SMTP id d3mr13205757qka.279.1578942347632;
 Mon, 13 Jan 2020 11:05:47 -0800 (PST)
MIME-Version: 1.0
References: <20191206194535.150179-1-briannorris@chromium.org> <0101016eea4fa7f5-e04b23cd-17a0-4306-8100-7761f1161da3-000000@us-west-2.amazonses.com>
In-Reply-To: <0101016eea4fa7f5-e04b23cd-17a0-4306-8100-7761f1161da3-000000@us-west-2.amazonses.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Mon, 13 Jan 2020 11:05:36 -0800
X-Gmail-Original-Message-ID: <CA+ASDXNCzyRfZs0D6_+j0Tyqai4PaFk50HpF_LqC-GuOTYJCmA@mail.gmail.com>
Message-ID: <CA+ASDXNCzyRfZs0D6_+j0Tyqai4PaFk50HpF_LqC-GuOTYJCmA@mail.gmail.com>
Subject: Re: [PATCH] mwifiex: drop most magic numbers from mwifiex_process_tdls_action_frame()
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Ganapathi Bhat <ganapathi.bhat@nxp.com>,
        Nishant Sarmukadam <nishants@marvell.com>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Xinming Hu <huxinming820@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Solar Designer <solar@openwall.com>,
        qize wang <wangqize888888888@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Dec 9, 2019 at 2:58 AM Kalle Valo <kvalo@codeaurora.org> wrote:
>
> Brian Norris <briannorris@chromium.org> writes:
>
> > AFAICT, the existing commit (1e58252e334d) isn't wrong, per se -- just
> > very poorly styled -- so this probably doesn't need to go to -stable.
> > Not sure if it's a candidate for wireless-drivers (where the original
> > commit currently sites) vs. wireless-drivers-next.
>
> I'll try to do so that I'll put this patch to "Awaiting Upstream" state
> and apply it to w-d-next once 1e58252e334d is merged to w-d-next. Feel
> free to remind me then that happens :)

It's that time!

Brian
