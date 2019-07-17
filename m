Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6FB26B91E
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jul 2019 11:23:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725948AbfGQJWm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 17 Jul 2019 05:22:42 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:36025 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbfGQJWm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 17 Jul 2019 05:22:42 -0400
Received: by mail-vs1-f65.google.com with SMTP id y16so15957145vsc.3
        for <linux-wireless@vger.kernel.org>; Wed, 17 Jul 2019 02:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IWOzFxdV4ugSBwBKRnKJqzX4+JkPED6nPOg1E26yFjU=;
        b=Zvtn+Urvpb0OGvBC9o5Cd3AQl0tFTTLspXzQ+EY6wr7Kuzwl6uk7QefgQHW6TPn/ri
         OkqNPIdUaptfv4DcX1UBlpeR2EjluwG7RRCWEF7qJrzNk3dtfYgsEh/03VMtxBXDIEEK
         yz4Ttzt1MKiFfEqiQC5j2NRwYkCSzGZGde1AOayiuVoIDCTxV9onlN0QfN4pzjMXEtf2
         ARX9AknVVGZYoDg+3fCtthnYQLdrQEAwegSo+zvP2DuRxhfcpI4HHpumYWnRnFytussZ
         oQhaGSYFT4fc57PNtmMulNP+NW8k8/3y1yDp72CY2p/ruSLpv1wKLZHFl99IneVAXQZU
         Z1aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IWOzFxdV4ugSBwBKRnKJqzX4+JkPED6nPOg1E26yFjU=;
        b=Opx9wOSMWbqjvjX/TL2V5OVelCQtxgZ9EiJH6CnJaNS50OvpKEHmkaxFG6SGANngbO
         FRSNoXOzQ3RYqyJk91RpeQm81EfHFJx/gZugH5/LNU+k1aulzmJtgs2kA05GnoBrLr45
         dU3UojZKlKYm/ySctKC3dPfhCoh0ByGcuN8cZycskaTI8rurrXHQxEpBpcakC96a/Uah
         lTDMyouJcCbHJtZFveJt0HChiIbREuX5vb2RAm+gXDG5GpYUNHlhjL6Z5s6ncmtBxDF2
         mE/lJ15YJ9HF0xszGbPK2VAmrT0+5Mvb3nwgrjeb4hK5on6/XqXhLFONyAUztDwBpT7S
         3yyA==
X-Gm-Message-State: APjAAAVvgR55/Da0HjFHldpvhQh6jemrX4eQjmeH0KQcE2oRhkkUxaFO
        1/tTvWTpal4xMfgpE27u4ftT2gFr4NQ4Et0+42nerA==
X-Google-Smtp-Source: APXvYqzEaxdccX3xrSr1eOl7II4tIxxIUCQjH622OS4+ym8P1iUcVHIgrIujLWZUzhmB8dlSf7EgIdOURAhw6Gwz7OI=
X-Received: by 2002:a67:dc1:: with SMTP id 184mr24388603vsn.164.1563355361728;
 Wed, 17 Jul 2019 02:22:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190620130148.1674-1-yegorslists@googlemail.com>
 <90ccc515bb26b212b537fc1b0287afaa0f86fdf8.camel@sipsolutions.net>
 <CAGm1_ksic4xcVdaPAObwwNdaQ19E3ZiK97SkmVmp8kz6H2KpOw@mail.gmail.com>
 <693753473768100f07de573dd74bf4033618aed8.camel@sipsolutions.net>
 <CAGm1_kvK3eWnZk7eDOoqoAiedReJLunKfb4tvhqXU-hriO3itg@mail.gmail.com> <d47994158f5460104f36999f5f1c6251885af102.camel@sipsolutions.net>
In-Reply-To: <d47994158f5460104f36999f5f1c6251885af102.camel@sipsolutions.net>
From:   Yegor Yefremov <yegorslists@googlemail.com>
Date:   Wed, 17 Jul 2019 11:22:05 +0200
Message-ID: <CAGm1_ku2Aicv1+k4PY+QkywsCAMWPDhsFWmy653+4ygGDQAdDg@mail.gmail.com>
Subject: Re: [PATCH] Add SPDX identifiers
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Jun 28, 2019 at 3:58 PM Johannes Berg <johannes@sipsolutions.net> wrote:
>
> On Mon, 2019-06-24 at 22:32 +0200, Yegor Yefremov wrote:
> >
> > I have asked SPDX and this is their answer:
> > https://lists.spdx.org/g/Spdx-legal/message/2631
>
> Alright, thanks. I guess I can apply that then.

Should I change the patch or are you OK with it?

Regards,
Yegor
