Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F63420F892
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2020 17:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389627AbgF3Plh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 30 Jun 2020 11:41:37 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:20103 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729105AbgF3Plh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 30 Jun 2020 11:41:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593531695;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fJeitk7xPgCyLURlMWoLLHG07eLqn+tEUmVh7gZOoK8=;
        b=CcC0gr6pDassWRUS6G1MzNTQ/lJPPYdHhw3d5zvMYtYi43np0O/+/9kw1G1dVRioH443kn
        pT9Ps8H4uFI5Tm3F5XGWkp0X/Kr/CM6MxZiu+oe/Md+MUdYEFS8ddlivXaGgVgslt5Exlf
        P4puMvIuXuL7ZmdsPqRux58kEGF8Q+Q=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-368-NyGizVihOQuBmmkQksT5_g-1; Tue, 30 Jun 2020 11:41:33 -0400
X-MC-Unique: NyGizVihOQuBmmkQksT5_g-1
Received: by mail-qt1-f200.google.com with SMTP id y5so14700573qto.10
        for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2020 08:41:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=fJeitk7xPgCyLURlMWoLLHG07eLqn+tEUmVh7gZOoK8=;
        b=svdoYo0Y+Zf5m9FXk2dsJwhwBRMCPLedjR7zlh2yhOgW+MLk2WuMwAzvTxlzDayd2X
         va429Seqj/9nhOCk5e9f5fQQ0kpMihyIforv6iQKF+9mzbrWOD5bbX2vwMVn3VB0hrmq
         o3dYfq/mIneOoVqV5EsQ5XpjvEs1l4ddZzJL9F7Hdw0WpmhfrEfSZn9TE/X/c8h5TK8Y
         bt2zlahVh3MKuDQ/ablYUV21cOSsHmti2BsHnCl7/G92byMYnug4bj2t5Z/Y69rMBjhj
         pah50GybmWrBCXmtexiiPRr8KzKq6+ZxnZbFBJYvzNifYUaauXzBZ1LselJdCR0U1Vef
         ee0Q==
X-Gm-Message-State: AOAM5310gArRQNXCQDWn8fdStPZvrXIc0i3XWWKAh0M8IK1RCx9XyB6m
        WXTcxfRR6KxzYVMFOh2kyI4fqAkgfB5mkcmXcck/qfLmIb2h1Fd/IDVcktWBJwiKqANEbyI4kFH
        t5bplJFdMQOBmV75e+prNh01oDXA=
X-Received: by 2002:a37:a543:: with SMTP id o64mr14126714qke.247.1593531692295;
        Tue, 30 Jun 2020 08:41:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxBCHpEjPBrjexbop5ljxRpC1CiQ/Lz3Vl3EMp3RBoj1bdyJsMLEBgScw/Ni76LuKVTv3nAQw==
X-Received: by 2002:a37:a543:: with SMTP id o64mr14126685qke.247.1593531692037;
        Tue, 30 Jun 2020 08:41:32 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id s71sm3498040qke.0.2020.06.30.08.41.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 08:41:31 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id CFFD01808CF; Tue, 30 Jun 2020 17:41:27 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Miguel Catalan Cid <miguel.catalan@i2cat.net>
Cc:     make-wifi-fast@lists.bufferbloat.net,
        linux-wireless@vger.kernel.org
Subject: Re: [Make-wifi-fast] Support for airtime scheduling using ath10k
In-Reply-To: <CAMHmoovWrXhMheEPapgEw9b_7S-jOZdJDRvAp-1Cb_i0=pBfEw@mail.gmail.com>
References: <CAMHmoovK_m=Yd4uUPhsdHZ588+d1DF-fyS+uGKdRWvd33Q2u+A@mail.gmail.com> <87zh8uruou.fsf@toke.dk> <CAMHmoouFjdOSBAq00SMeauO2GvEnXMvJG+vEMwhYUD4rdW9rxg@mail.gmail.com> <87366ei2x7.fsf@toke.dk> <CAMHmoovWrXhMheEPapgEw9b_7S-jOZdJDRvAp-1Cb_i0=pBfEw@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 30 Jun 2020 17:41:27 +0200
Message-ID: <87lfk4ftnc.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Miguel Catalan Cid <miguel.catalan@i2cat.net> writes:

> Hi,
>
> Do we need to use a specific firmware? It's ok to use the last one from
> kvalo, or should we use the one from candelatech?

Shouldn't matter, I think; the airtime scheduler tries to do its thing
in software. It does have to work around the firmware, to a certain
extent, though, which I suspect is why it doesn't work quite so well as
on ath9k.

Incidentally, this "impedance mismatch" between scheduler and firmware
is what this patch was supposed to fix:

https://lore.kernel.org/linux-wireless/20191222172423.131033-1-toke@redhat.com/

Never did get around to respinning it, so not sure if it still applies.
If it does, you could try taking it for a spin; otherwise I can try
updating it so you can apply it and test :)

-Toke

