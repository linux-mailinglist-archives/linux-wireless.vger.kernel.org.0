Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB03DB027F
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Sep 2019 19:20:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729433AbfIKRUF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Sep 2019 13:20:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43532 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729130AbfIKRUF (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Sep 2019 13:20:05 -0400
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 44000C04BD33
        for <linux-wireless@vger.kernel.org>; Wed, 11 Sep 2019 17:20:05 +0000 (UTC)
Received: by mail-ed1-f70.google.com with SMTP id ca13so13046951edb.10
        for <linux-wireless@vger.kernel.org>; Wed, 11 Sep 2019 10:20:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=a5lEYwR3+gF8lf/iExjadUv4s66SOSzI/9iES5bWJ/s=;
        b=uZZhwgtFjWE2ulbARuyE8lCUSCQOxA2HlUOn6OP8/wumgfcnpP8cLaMQ3hWBQAep7n
         NEcARDgqbGoFWglyhT2l5GYQGplR3x2jQK2HymbsRXQyvZwA5Yu+u0XM2QR/3cpdwcOk
         AaVmTD2wcbRx4pzW0BgQaqWs9vYbP/IcedHERr6/OSgadVqU2835Q0aIMhD0ZQoo45+S
         EhyOxpuvctRIwqRxYCDfdpgMimNl//gAVD6sZD/oOEuG3wwvjhHCDb6QjBLVxEe1C+dt
         6j81FX9zGsRsPbkCplmLdFiRBR/Y8FYluuvjzRwMJ2gHvBzhNHn+60678/SxBa+gm63Y
         lDzA==
X-Gm-Message-State: APjAAAUTKxs8ZM9g/I8Uicahjpg7gwoCxXYPFHKHdA4a1VEjnUJnANS2
        tQvK/MZrFG5P/7/bByOnUyUV5ANKuvUOhSCsk+b40niMDZsTywgtfGYpmtUXjunyO6gPYQqVXiZ
        P85FIeAajXcZdr0VSpwWdgkfD6xk=
X-Received: by 2002:a17:906:b2d3:: with SMTP id cf19mr11711530ejb.75.1568222404032;
        Wed, 11 Sep 2019 10:20:04 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwm/39DQwYxzGNFzn2OX5kVeb+8NunrbjJu9ky57Rhr9u9JdnUYhFITtRntGorXR8KpQGV06w==
X-Received: by 2002:a17:906:b2d3:: with SMTP id cf19mr11711509ejb.75.1568222403743;
        Wed, 11 Sep 2019 10:20:03 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (borgediget.toke.dk. [85.204.121.218])
        by smtp.gmail.com with ESMTPSA id f5sm4226847edt.42.2019.09.11.10.20.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2019 10:20:03 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id B67BC1804C8; Wed, 11 Sep 2019 18:20:01 +0100 (WEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Sid Hayn <sidhayn@gmail.com>, Tim Higgins <tim@timhiggins.com>
Cc:     Ben Greear <greearb@candelatech.com>,
        "linux-wireless\@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: Question on Intel AX200
In-Reply-To: <CAM0KTbDS3FpGkdTB7J5PKNyjC809d6tt1E8aQE5D8d1ya-Y78Q@mail.gmail.com>
References: <33bd9a39-0028-2f99-f43e-5e15c9e87287@candelatech.com> <ebe5532f-f456-2534-cd5e-c44d4c43696b@timhiggins.com> <CAM0KTbDS3FpGkdTB7J5PKNyjC809d6tt1E8aQE5D8d1ya-Y78Q@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 11 Sep 2019 18:20:01 +0100
Message-ID: <871rwmu4vy.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Sid Hayn <sidhayn@gmail.com> writes:

> I'm pretty interested in hearing this too.

Me too! :)

-Toke
