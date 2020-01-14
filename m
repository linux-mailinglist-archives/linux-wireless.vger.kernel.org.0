Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9A4413A337
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jan 2020 09:48:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726044AbgANIsh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Jan 2020 03:48:37 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:33016 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbgANIsh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Jan 2020 03:48:37 -0500
Received: by mail-ot1-f65.google.com with SMTP id b18so11911715otp.0
        for <linux-wireless@vger.kernel.org>; Tue, 14 Jan 2020 00:48:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IiimFPCUzsK/NSQS4nOZMqHnFPciGIS4RhFAyHEBZo4=;
        b=Iu5ZLr9RvDzqgIKD/DBCtNgWLF2vMJzIHxtJSFD+Kbwi8tUIrewhkf+EcSWMxB6H5B
         wEM3068URxITA1a4/u+ScfFnl7Ep0Q9dT7FFxxKimDGsqmCICq5p+Ua+t0oRsN0ol/az
         PIUQEQTC8+XNzA04TUj9ExoIyJ5lbCOdd+byAYm5XzGSGKoNkPCII0JQDAhMPfmXB1wB
         B4jRk0lVpYZT52zj/6Z2NZt78MgI3z+im91+kKxVzOyUDsZd8/6KE8ERQu7dsQF5kyBZ
         iTG2Kc8UNJ70YdU6Ok1KjQ/P2LHUzqNwgz89+1GPIdrWEjy15Lj53TRZ+aicp37CDHgm
         JA1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IiimFPCUzsK/NSQS4nOZMqHnFPciGIS4RhFAyHEBZo4=;
        b=VKfs6g9TH4o/7rbrmL0Mk8KEsOfY0gi/BsMZ5xVqBGylyJrn4CedsmhXzQCQb7xtB8
         yA0giqot3FX3twmXxQVzyWtYDzuwlw9LQlzj/ASidLZt27FsqcZdrq6kuaYWuBPeI/Ce
         fd8QD2TieMIn6qJq+EmMbZScgBdHAFAxUeiRAoB+TlLRsQAUGXQ34SDprJjMjkUnnDfo
         NQP4e0hbfXAFDLiQdtN4Epy2d/xESaYZWZK+1iiuaxMzlvFWP9PlMg9ONlIwSsixyZH0
         4vo3Pk8pJJ1bELGJcYmRUp4VEQAVag2wuC//v09YENT9rYDuW7ZgJw+lTSPakfUagKS6
         qMoA==
X-Gm-Message-State: APjAAAUPaLnfEpZP+nVlBs+YqCDurFK0Lmk10czYMEZQbv9E9bCqgi1t
        ig29qJ7DWxNzqbbhWwP6/BaZIN+XWRukSpIwGZU8SGyCSPI=
X-Google-Smtp-Source: APXvYqzP93eCbKOuAfQharz4nsJrv905pzzhwarQpZGFCD2CjbTk8Ykrz0ABFLox8a28N9ap5aFDKL8RmSTp9gYiAXU=
X-Received: by 2002:a05:6830:1607:: with SMTP id g7mr16278280otr.320.1578991716702;
 Tue, 14 Jan 2020 00:48:36 -0800 (PST)
MIME-Version: 1.0
References: <20200110132142.7737-1-denis281089@gmail.com> <aab66c75-49ae-0955-03a8-f817685b0925@nbd.name>
 <CAKoLU8P3MyauCUevcRHtzMj8HSZQLD-hYyEaZyRH9OfLye6knQ@mail.gmail.com> <CAKR_QVKb21WWbUup-O9nsDvfVO7-c_+Kpxx3n8=b1e4X5pkmkw@mail.gmail.com>
In-Reply-To: <CAKR_QVKb21WWbUup-O9nsDvfVO7-c_+Kpxx3n8=b1e4X5pkmkw@mail.gmail.com>
From:   Denis Kalashnikov <denis281089@gmail.com>
Date:   Tue, 14 Jan 2020 11:46:49 +0300
Message-ID: <CAKoLU8MRzBaB9AS0--vCG01hKhBrdzB8=42A+vMv9X39ZAPZLQ@mail.gmail.com>
Subject: Re: [PATCH v3] ath9k: fix firmware bug in some Mikrotik R11e-2HPnD cards
To:     Tom Psyborg <pozega.tomislav@gmail.com>
Cc:     Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org,
        Kalle Valo <kvalo@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Using MAC address for distinguishing these cards is a good idea for
local/ad-hoc solution. Thanks guys for participating in the question
and help. We decided to send these cards back to Mikrotik.

=D0=B2=D1=82, 14 =D1=8F=D0=BD=D0=B2. 2020 =D0=B3. =D0=B2 05:52, Tom Psyborg=
 <pozega.tomislav@gmail.com>:
>
> On 13/01/2020, Denis Kalashnikov <denis281089@gmail.com> wrote:
> > I read value from the SREV register of AR9582 -- got 0x001c04ff. I
> > looked through the code of ath9k and found out that in this case the
> > revision is 4. So, since AR_SREV_REVISION_9580_10 is defined as 4, I
> > logically concluded that AR_SREV_9580_10 would do the job. But you
> > suspicions turned to be right. I tested AR9580 now and it has the same
> > value as AR9582 in the SREV register -- 0x001c04ff. PCI Subsystem ID
> > is zero on those Mikrotik cards, so it is not useful. Felix, guys, may
> > be somebody have any thoughts how we can distinguish AR9582? Or that a
> > chip has only 2 chains? May be values from other registers?
> >
>
> read MAC OUI any apply only to mikrotik ones?
