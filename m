Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C05F5C36DD
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Oct 2019 16:17:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388825AbfJAORH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Oct 2019 10:17:07 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:39187 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388898AbfJAORH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Oct 2019 10:17:07 -0400
Received: by mail-ot1-f65.google.com with SMTP id s22so11659667otr.6
        for <linux-wireless@vger.kernel.org>; Tue, 01 Oct 2019 07:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=V8Ovfrmd9Zy/EmVmcIBDSkZhTGDOxYcQ2By3bCQClGY=;
        b=Ateh8h5sPaCIt4vZg66zEzwRwII6ZC3cwAyvfTob7XOTgfF2xbA1zOIUB353xrLPsh
         CrEHWvjzEoNFwmNRZSCQAKpIRaE6rXAHpRJ2Ftc9vqP8xIDYKB2TV+BCLOlK0ZMg+/5C
         eyYlfjO9d/cgsMv+u2mbgcMVEJP8LPU0g5XBNk6pbc3dtIgbaNW2q6pUoXH31scUsOr/
         sRffCnzkug2GLV9WhaekXownziApPHjUkgL3qyGAYLt2BYBBdulUT+CfJpy/ex4bNRNP
         JlvViIv36mA671fvPGZrz/T8VRLa/Lve1phTcXqBknSJERUrgg4i2061eRmUwXX1UYCK
         B/Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=V8Ovfrmd9Zy/EmVmcIBDSkZhTGDOxYcQ2By3bCQClGY=;
        b=b2eCZVwzlr8fDxs9lJmtRnwg7o9C7e+2HjctkirseKfkiJLAuCna+RFlMC0mQTvli6
         6Il/cHVnIDuSpFaSNMnDtq3QttdLIQ/Hj/XH+6sx4GjDt/RNBD8p89v/z+Z18E89PyUG
         lCMJve+KN7B+gIisMvXxh0wWiy+d4UzuhFVfrJdSwcaq/42YksngEEf5rbEphfWPNmUn
         x0g5wA2KZMGLjDTSehuRZmPogxVkJwPsocb/jxH81nti4rpdx8XJKXoAY5l+AVLIKP7K
         Xv96lGiCRfrwwrSNo6hCmcSNR/vo+IJoGDd0x4UJTvU9mDknKVhhC5GPwfIyqgR4LXws
         ILHg==
X-Gm-Message-State: APjAAAWzr5w4fHEtRzXonQZ4CvcB4hUiIdd3hPuz2URo1KRP29FxZ1vQ
        z6qW0/MA8JNtsH2Sk2GKu9kfQUAVvdQmlhDkESE1UizI
X-Google-Smtp-Source: APXvYqwwo57gGZdyFYVWff1jy8W/vBFcWGcpBZeT2vcMwvt/9tqebd0I+bUaMoI2/hDTkJryLZJptMM+sqUUSVKt9Ww=
X-Received: by 2002:a9d:5f9a:: with SMTP id g26mr17435383oti.27.1569939426613;
 Tue, 01 Oct 2019 07:17:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:2286:0:0:0:0:0 with HTTP; Tue, 1 Oct 2019 07:17:05 -0700 (PDT)
In-Reply-To: <87imp84nzn.fsf@kamboji.qca.qualcomm.com>
References: <20190906215423.23589-1-chunkeey@gmail.com> <20190917064412.C2E0D61572@smtp.codeaurora.org>
 <2099574.gZacamft7q@debian64> <87imp84nzn.fsf@kamboji.qca.qualcomm.com>
From:   Tom Psyborg <pozega.tomislav@gmail.com>
Date:   Tue, 1 Oct 2019 16:17:05 +0200
Message-ID: <CAKR_QVKVFLacWA+qS1=Tyaew-r_J1y--9N2V+eTCOvn3g=5iUg@mail.gmail.com>
Subject: Re: [PATCH] ath10k: restore QCA9880-AR1A (v1) detection
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Christian Lamparter <chunkeey@gmail.com>,
        =?UTF-8?Q?Micha=C5=82_Kazior?= <kazikcz@gmail.com>,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hey Lamperter, I'm sorry if you feel like I hijacked this thread but
it was in an obvious attempt to prove more can be done than just
returning unsupported message.

However, as the company itself is unwilling to provide firmware and
everybody mention this chip variant in such a negative context there
are obviously some internal reasons to keep it unsupported with
silicon bug or two being used as an excuse. Most chips have some hw
bugs and workarounds for the same are available, but this didn't
result in dropping support for their drivers. So, you can go with this
change, but it won't be that useful or required as few others who
switch to different card in their router won't need it. For the rest
of us 700Mbps with factory TP-Link firmware will suffice.
