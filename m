Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC85B0264
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Sep 2019 19:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729430AbfIKRLL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Sep 2019 13:11:11 -0400
Received: from mail-io1-f50.google.com ([209.85.166.50]:38480 "EHLO
        mail-io1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729256AbfIKRLL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Sep 2019 13:11:11 -0400
Received: by mail-io1-f50.google.com with SMTP id k5so22287348iol.5
        for <linux-wireless@vger.kernel.org>; Wed, 11 Sep 2019 10:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ygnyHLY/uFwC1kwbN8MCBbpW8iAis2gnfNllxgQCVJo=;
        b=h6+JgJpfA5H8eENjfyjcgRRWgpp+pN1ZP9i9GcpRkqlTA3gSnTFFDnFizil6025L+G
         o6cJcymeImeoKB2Lk8JEUh2HDcs5iqzcZf27t/GLb7f5OPcyNOZ9XOJ1hDyjOK1vk1gV
         u0zILcwfkf60VE34qZW60ht8dxLbanS42PHYr7bULpAswZTYmDsMUde7pqKA01k2s24C
         X4GhFqy2CF0wFEVtwss0bbepZPdVkBf7e9Gzss/2RUBU+MS69cfFkh861UcgFzGQpj/L
         KUa1aiBTrbfFQtauQZwUvgcucVOn07q9gATZE8/f8RxvpmGUqtclaJiiRdmkZvEPua8R
         JeAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ygnyHLY/uFwC1kwbN8MCBbpW8iAis2gnfNllxgQCVJo=;
        b=HkXURKSEQSRhiSwC7XSD5DMsV6XkK4y+CCtijisO9yLPKN0Do7RxgvLuWvmq5JXv5X
         MPgq1mJMOnY+fvCv/qE4J4Des1deg/jGnK3CB0YJ5jmxj4xE6VX7ADXSIoBjmr8ji+ZS
         CaIDF53jbPVAfLWPXBNHQhu/8S6Qnm3XLu/362YG8fQvvpDD2fZSbMIvsKJrlranzME0
         PKEGdMGSOEMpweG1D4V5ItlR39L9IsyBiXVQ0R74h9zD5hfitdlCIR216Eig0P/9/5QX
         8E4v9x2rCZ+BXarAwn3YM36DUBCkRwk8y5vdSjkH13TqVjiTdLIDrJsD6e0hKGs52rgN
         g2Yg==
X-Gm-Message-State: APjAAAXrGQemz0YUov/zP/C55oujgsUHW14Q81OYNOsrLi432XX02Ivv
        royuxHMqtK/HCMcKRctbd8Sgg0sa94saTtEBgfGt4w==
X-Google-Smtp-Source: APXvYqwEwaUvXGA5ncWul0NgrXKfgm/AF8a0IVn081pIIQFDo62mGfvAQ9EvY1tQt0JeArpe37wKqybZAPvOjgRXZps=
X-Received: by 2002:a6b:b593:: with SMTP id e141mr7078244iof.233.1568221870061;
 Wed, 11 Sep 2019 10:11:10 -0700 (PDT)
MIME-Version: 1.0
References: <33bd9a39-0028-2f99-f43e-5e15c9e87287@candelatech.com> <ebe5532f-f456-2534-cd5e-c44d4c43696b@timhiggins.com>
In-Reply-To: <ebe5532f-f456-2534-cd5e-c44d4c43696b@timhiggins.com>
From:   Sid Hayn <sidhayn@gmail.com>
Date:   Wed, 11 Sep 2019 13:11:01 -0400
Message-ID: <CAM0KTbDS3FpGkdTB7J5PKNyjC809d6tt1E8aQE5D8d1ya-Y78Q@mail.gmail.com>
Subject: Re: Question on Intel AX200
To:     Tim Higgins <tim@timhiggins.com>
Cc:     Ben Greear <greearb@candelatech.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

I'm pretty interested in hearing this too.

-Zero

On Wed, Sep 11, 2019 at 12:41 PM Tim Higgins <tim@timhiggins.com> wrote:
>
> On 9/11/2019 9:49 AM, Ben Greear wrote:
> > Hello,
> >
> > Does anyone know how well AX200 currently supports:
> >
> > OFDMA
> >
> > MU-MIMO (receiver)
> >
> > AP Mode
> >
> > And, can anyone suggest a good /AX AP to test against for these features?
> >
> > Thanks,
> > Ben
> >
> Hi Ben,
> I've been doing a lot of testing with the AX200 as a STA and sniffer, focusing on trying to see
> if OFDMA lives up to its advertised features. This topic is probably not of interest to this
> general list, so I'm happy to take the discussion to one-on-one.
>
> Tim
