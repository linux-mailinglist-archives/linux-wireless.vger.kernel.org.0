Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E65B117765
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2019 21:28:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbfLIU2P (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 Dec 2019 15:28:15 -0500
Received: from mail-il1-f172.google.com ([209.85.166.172]:38803 "EHLO
        mail-il1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726354AbfLIU2P (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 Dec 2019 15:28:15 -0500
Received: by mail-il1-f172.google.com with SMTP id u17so13976834ilq.5
        for <linux-wireless@vger.kernel.org>; Mon, 09 Dec 2019 12:28:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dsLYgrJ7e6mjvbouhqXgxQbBAlPOYr1l6/YgPUfFVVQ=;
        b=HTqBKKzRneK5+/ylJ3c6ERaTfhOmshP+Z5r7fDku1JlLHuQA+2bkpqPDsXKF9Qp727
         RObAOIiwyvj86l7QLsDJhPLkhjRzNhMTZYl8nynqnLNvUhyiNMMKPqSqkkwGUJ61CgHZ
         efckUhnSEJegAsouxTq77RwY/C1oCj+OtH7m+rWqd0RKi5LG0e8Aql4vSGJ+GokpaULY
         CnXsd6gS6MRnwvusN9+I+/9wKQ/jC+Oogwfk8pwhT48uAkesHs+2PBn9youkPxc5spOz
         msMIT7VzgkXESvKYL8b0srkAAJy5RYrlGkXRGeNlTTM84z1hYiw6oA91DpN1y30p260a
         alog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dsLYgrJ7e6mjvbouhqXgxQbBAlPOYr1l6/YgPUfFVVQ=;
        b=cQT223rLvMjaZz8dWOhzvURxh/oZGCNjFWstmBHYUMLUS1xScgdXxRoJvB6y7gE5VR
         /AWWJA/EI4SKPz9M/yTl8MKKoUSd3wk1b7SeAGvM80b02/gBraZDxIl4/iH9JGg0XSpk
         KD43SYshPmSgQgRepeZi5vKojkEskWWIRmpjqTrQA5NsDXR6UPoi4Fl949ivjEG7JPre
         i7jm2u8ganOyHoq/+noOMVXhEyUKncL+xR8bOx1Ky95EW9lrpT1D518PIbwX62KwEhcz
         Nj0I+kpclUfm7aKGkT5L6Sx0SggNg2zSzoVtB8J/vqWvpeI8Ax11s7ZBmAIo5+6R05mC
         BDmw==
X-Gm-Message-State: APjAAAVVvjisiKXX5LEYy9ddwnbq1HyNQWbXkatWbRIm+P8zV+UxqoH7
        lFBXib1K6ukFXg+59GGKzRO3igekVy2211G1gPk=
X-Google-Smtp-Source: APXvYqxR2E2tL0pNed29qhjXxwjizHbssFF7G9bxkgepR2ixL/a8rZoIIlk9mb8kmsfUQyM8lEL/fl7caYU/CxVJJ3k=
X-Received: by 2002:a92:d2cd:: with SMTP id w13mr4263889ilg.173.1575923293849;
 Mon, 09 Dec 2019 12:28:13 -0800 (PST)
MIME-Version: 1.0
References: <CAH2r5mvZ=S0FHGP+Y_r5f37TXVehv2shj9f6w67zBxfjR+Zt-Q@mail.gmail.com>
 <0101016eea3353da-835ca00e-d6c9-4e2c-aa0b-f6db8a4c518a-000000@us-west-2.amazonses.com>
 <87h829lpob.fsf@toke.dk> <87muc1io8r.fsf@toke.dk> <CAH2r5msb63LFeDZ9D9dNv8tTS1yS9oLXx8tNqmjTQfXRsKrFzg@mail.gmail.com>
 <87zhg1h10j.fsf@toke.dk>
In-Reply-To: <87zhg1h10j.fsf@toke.dk>
From:   Steve French <smfrench@gmail.com>
Date:   Mon, 9 Dec 2019 14:28:03 -0600
Message-ID: <CAH2r5msJRzdrW4ua4uSqqwKC8NnKzOVKkqLWO0+cJ-OutL6qoQ@mail.gmail.com>
Subject: Re: 5.5-rc1 oops on boot in 802.11 kernel driver
To:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>, linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Dec 9, 2019 at 11:17 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@redh=
at.com> wrote:
>
> Steve French <smfrench@gmail.com> writes:
>
> > Let me know if any additional information is needed. Reproduces with
> > default config on my Lenovo laptop with Fedora with default config on b=
oot
> > of 5.5-rc1
>
> Might be helpful to know your exact hardware model and firmware version.
> Also, when does this happen? When first connecting to a network? What
> kind of security is on that network (wpa type, etc)?

Did another yum update today and haven't seen the Wifi crash this
afternoon.   Possible that it was fixed in last few days?!  But in
case anyone still runs into it ... here are the requested details

# lspci | grep Wireless
00:14.3 Network controller: Intel Corporation Wireless-AC 9560
[Jefferson Peak] (rev 10)

Wifi is configured for WPA2

Model #: Lenovo P52 20MAS08500

--=20
Thanks,

Steve
