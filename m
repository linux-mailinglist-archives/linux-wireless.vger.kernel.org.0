Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EBEB241906
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Aug 2020 11:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728469AbgHKJk0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Aug 2020 05:40:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34025 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728397AbgHKJk0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Aug 2020 05:40:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597138825;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f+4E59p8WuWde9kOhT7jlCcixWnao81yirTyIde1f+0=;
        b=D/FUFCR6tD20QTfE9qdVVoNkaajAXVggG5WfGS+GoBbrqlMYaKMdcgeXbav5XVdJkoQF1p
        iKunoDb30TWhJqmsBtYA4AwnnMXzm2I2d00YNJnW6HClFtHv2QgUKWTmhEimKpo13yrYWa
        c8xbmMfUwWr0i1uJxPd8L0mTJ23zG3k=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-327-o8KGEqOdPQGrx_xDvEZ6Zw-1; Tue, 11 Aug 2020 05:40:23 -0400
X-MC-Unique: o8KGEqOdPQGrx_xDvEZ6Zw-1
Received: by mail-wm1-f71.google.com with SMTP id z10so650973wmi.8
        for <linux-wireless@vger.kernel.org>; Tue, 11 Aug 2020 02:40:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=f+4E59p8WuWde9kOhT7jlCcixWnao81yirTyIde1f+0=;
        b=lCR0Y+QSRatxtgEBaTxEaFllcYfw5mjVkPzMIPneg9Qq4ciLobu8vNzF0fXQJ0IPcE
         HPI/lL13Tk6Pd94nz+rE+Y87Z9kQu8IT4GkEVtE9crJZdb2GmJN3BWcsC52IvtUmLsN8
         NgLyzsQGcGANen74+nya3VARnLNnEh7Zcp/K395FhjUnhH4wAJ144Y1yOOhiQ+ihISuz
         i8jpOdiuYGRVwj0IOUiDsmLApb+vvPTkJPm8XzkwfLTPzjjVDOFqolX9BnRy3sQAq8cU
         8WUFbuEgCC+RPeacNE1kBdw2t08279lJ4q3BS63aUn0EkmhHoLm7T2pivif9CMnAHbp4
         jgUQ==
X-Gm-Message-State: AOAM531zah/1x1G1JWpJw4JrXv2R0KAqcaWl/fLnuzAE+snD4uwYRZWX
        G8Q3JLr4ZeKvOSzsfNKMdE4vjktf7VtbMtKycOSypC511tnKo7jsbkxLzHDleGXwEqymrJIQ3Or
        0UPkeul/KhuR0liBUjlnLnunAzGk=
X-Received: by 2002:adf:df85:: with SMTP id z5mr27782027wrl.267.1597138822524;
        Tue, 11 Aug 2020 02:40:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyua03mQqBdllzMYd8xcgIHTepHRyNHb46K2viSIV6IVgsQCG3GsXKC97aduovD1iQOoDlzqw==
X-Received: by 2002:adf:df85:: with SMTP id z5mr27782019wrl.267.1597138822380;
        Tue, 11 Aug 2020 02:40:22 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id m1sm3647501wmc.28.2020.08.11.02.40.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2020 02:40:21 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 35F7518282F; Tue, 11 Aug 2020 11:40:21 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net
Subject: Re: [PATCH 1/2] net/fq_impl: use skb_get_hash instead of skb_get_hash_perturb
In-Reply-To: <20200726130947.88145-1-nbd@nbd.name>
References: <20200726130947.88145-1-nbd@nbd.name>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 11 Aug 2020 11:40:21 +0200
Message-ID: <871rkd34hm.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Felix Fietkau <nbd@nbd.name> writes:

> This avoids unnecessary regenerating of the skb flow hash

Ah, I had been meaning to look at this, but didn't get around to it
before I went on holiday; thanks for taking care of it! :)

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

