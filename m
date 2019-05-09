Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CCBF3188DE
	for <lists+linux-wireless@lfdr.de>; Thu,  9 May 2019 13:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbfEILYW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 9 May 2019 07:24:22 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:44788 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726078AbfEILYV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 9 May 2019 07:24:21 -0400
Received: by mail-qk1-f196.google.com with SMTP id w25so1156221qkj.11
        for <linux-wireless@vger.kernel.org>; Thu, 09 May 2019 04:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dCnlS/Os4iGWNFisP3kaeJDg2CdWLlxOhgRwG4awIx4=;
        b=KBD05kY1U/p8AkeRQqKt9DacXyP8UQYpamDfplN6tJcVhL/BskcqjpJI9Nopif++ln
         bp1FlfXIu8sfMMqXBcXLve4fnRhSRUjJw/wPFLvYitGGT1+TRgYKozqzpubNShKAbV5P
         9zIQes4kTP21dtL/wRF0nXGdfu5gTNqTuJKJs2UAz9QDlakBRfufoA1CAGd3JuwOpsiq
         s2kn+hhcPuBieVnK+qRtC+5klBsrzieeJ+fqVhPKTL16hVVMQ2b6oIEDnALx0rwClPPz
         J3TO+t9Jswjux3vYA0ITXSMbulWyT2Ba8FLklcVDli1sSV6a9Y8IyoRGs6AYClviOoo2
         ffTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dCnlS/Os4iGWNFisP3kaeJDg2CdWLlxOhgRwG4awIx4=;
        b=tHMVwOpzLsUrvUQ3BFJuwxOS4klais7bZwd1VruLPx0AfVfMHd4NPEjDhItg+PcdD4
         P0HDjwHigGpBd7p0mGGviPJKffrX3D4wJCqOKsTAz20/ZmgFr6W1yvXqy3a2PMz6ul+I
         Kdd17cn7+TRbuf+EDraA0JjMnzJWmLb0RBEaO43GdpSK2fkOrMk4rMGB/mkGu/9zYuMc
         n+WhRduE8Blu2IVWl8IDYJz0OZ7FDpgeGtG2qVNu2KZgmFtqkO8FqVaQljFlcycVxhC4
         WVBC5zXaDGiXylVwezhx4c2Fxs7+waq/FroX6S1nKniMHzigRZdh7yvsLMQcGtcsNQC7
         KOEA==
X-Gm-Message-State: APjAAAUwsYTMy4LoSSjvmCNzPRxTN76L11J1md1L4iWzRGdc2KncjXA8
        eChyX3ZMM41fZf2N185a8rcSKzJQi1ntbwb5cfAJvQ==
X-Google-Smtp-Source: APXvYqzwIaznoFAT/zWqbH4CeaZXP5SqI/lPwmVbnP/H/Hxa5P/Zsau6AOS0KHx/uOaaP009y/M2WPeFkeEbu4pxRZo=
X-Received: by 2002:a37:f50c:: with SMTP id l12mr2768120qkk.175.1557401060787;
 Thu, 09 May 2019 04:24:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190503072146.49999-1-chiu@endlessm.com> <20190503072146.49999-3-chiu@endlessm.com>
 <CAD8Lp47_-6d2wCAs5QbuR6Mw2w91TyJ9W3kFiJHH4F_6dXqnHg@mail.gmail.com> <CAB4CAweQXz=wQGA5t7BwWYdwbRrHCji+BWc0G52SUcZFGc8Pnw@mail.gmail.com>
In-Reply-To: <CAB4CAweQXz=wQGA5t7BwWYdwbRrHCji+BWc0G52SUcZFGc8Pnw@mail.gmail.com>
From:   Daniel Drake <drake@endlessm.com>
Date:   Thu, 9 May 2019 19:24:09 +0800
Message-ID: <CAD8Lp46hcx0ZHFMUdXdR6unbeMQJsfyuEQ7hUFpHY2jU9R7Gcw@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] rtl8xxxu: Add watchdog to update rate mask by
 signal strength
To:     Chris Chiu <chiu@endlessm.com>
Cc:     Jes Sorensen <jes.sorensen@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        David Miller <davem@davemloft.net>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>,
        Larry Finger <Larry.Finger@lwfinger.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, May 9, 2019 at 5:17 PM Chris Chiu <chiu@endlessm.com> wrote:
> I need the vif because there's seems no easy way to get RSSI. Please
> suggest if there's any better idea for this. I believe multiple vifs is for AP
> mode (with more than 1 virtual AP/SSIDs) and the Station+AP coexist
> mode. But the rtl8xxxu driver basically supports only Station mode.

Yes, the driver only lets you create station interfaces, but it lets
you create several of them.
I'm not sure if that is intentional (and meaningful), or if its a bug.
Maybe you can experiment with multiple station interfaces and see if
it works in a meaningful way?

Daniel
