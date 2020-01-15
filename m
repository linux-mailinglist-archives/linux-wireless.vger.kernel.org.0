Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6336313C1AA
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jan 2020 13:51:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbgAOMvh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Jan 2020 07:51:37 -0500
Received: from mail-il1-f181.google.com ([209.85.166.181]:32981 "EHLO
        mail-il1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbgAOMvh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Jan 2020 07:51:37 -0500
Received: by mail-il1-f181.google.com with SMTP id v15so14758561iln.0
        for <linux-wireless@vger.kernel.org>; Wed, 15 Jan 2020 04:51:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=eXE0KiOlxY0Uth1XV5hLVq+qgsaEnpk+GUXUFstquE0=;
        b=iTNYJ9YAUy6Y3MF+Aa0/HL/3Ot8BK1+ns0inFfI1B2DVginZ6E2WWFf8MW4IRxtmDB
         3b/h0BWRfvI3YuuczSU2gDf/z+rrv8fpHiMsXGoryA1NWCBffD2x9b+vey2o2DneDweI
         INxewGpzwpXvktpkNa3GUTE8HiBGcWD2kDSuA0FxuJsYErs4cuxqZcIZuGYcITiPWrHV
         OMFIvYL+cmAO25S3kle2ZLe78EBTFigUtFfdZ1imsji99LrY5UsZnrAOG0XYdRP5lZAJ
         0NGNBden49O7k4Lt0W4pqjTKC6jahtYyk6I/8Nd+EeVtRiF1wZAp9PWFiqdvdDKfbVDB
         h1xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=eXE0KiOlxY0Uth1XV5hLVq+qgsaEnpk+GUXUFstquE0=;
        b=G8BsLPIhhA2ZkmJfNHsIg8WzvmfKqI1pRB70QEt/cqp9h0sJ0KhboJ/qTSdi626orZ
         PSmScGoAeNGysowFvqvzfARyKqNWjj8TLgIB+GuFIBuo1pmoSPQXPj4HUzuNRZB4zmbG
         trW65Y8+JaQ5sGf50Wac8tfthfP2bfwrs/JZyxQbI0gBHwz2wjqQuC3CzcYajvQX+rOr
         H8y3aJKT1NYW8SkYznD+0LX183nNzKX3W//3JplmWELfN6I6pGJ2sCcW3WzX3y7qiHbT
         1gMyg1GoKPSW97H4bX4bWJaBkc9cXv4lfJobYp7K2deJK5CgiwPYQLw71dEBHHHyMYEC
         j91A==
X-Gm-Message-State: APjAAAXBlI+SWNy+cwiEr63I9Q7XrxfncLULTxbM/KDkNo2paerZLDPy
        Vs9QwTxj6ZwXqiqrutptKJjsDL66XLL5+i6h6cj3gg==
X-Google-Smtp-Source: APXvYqxccV+aSIPQJ2PPLIJcxf0MGfGg5XHdr3AzfRxLnak/oRhAnZr2kFFmAigJPS8pSjMnl6UHZFOw6Ra57heZqxE=
X-Received: by 2002:a92:b712:: with SMTP id k18mr3370101ili.259.1579092696931;
 Wed, 15 Jan 2020 04:51:36 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a6b:a0b:0:0:0:0:0 with HTTP; Wed, 15 Jan 2020 04:51:36 -0800 (PST)
In-Reply-To: <28f78f20-b415-4046-674f-070ad6c43f44@newmedia-net.de>
References: <20200110132142.7737-1-denis281089@gmail.com> <aab66c75-49ae-0955-03a8-f817685b0925@nbd.name>
 <CAKoLU8P3MyauCUevcRHtzMj8HSZQLD-hYyEaZyRH9OfLye6knQ@mail.gmail.com>
 <CAKR_QVKb21WWbUup-O9nsDvfVO7-c_+Kpxx3n8=b1e4X5pkmkw@mail.gmail.com>
 <CAKoLU8MRzBaB9AS0--vCG01hKhBrdzB8=42A+vMv9X39ZAPZLQ@mail.gmail.com> <28f78f20-b415-4046-674f-070ad6c43f44@newmedia-net.de>
From:   Tom Psyborg <pozega.tomislav@gmail.com>
Date:   Wed, 15 Jan 2020 13:51:36 +0100
Message-ID: <CAKR_QV++azTZKi0dodYXDEgXbkUcUhBqezzMtGc0=dh_ngOqOQ@mail.gmail.com>
Subject: Re: [PATCH v3] ath9k: fix firmware bug in some Mikrotik R11e-2HPnD cards
To:     Sebastian Gottschall <s.gottschall@newmedia-net.de>
Cc:     Denis Kalashnikov <denis281089@gmail.com>,
        Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org,
        Kalle Valo <kvalo@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 15/01/2020, Sebastian Gottschall <s.gottschall@newmedia-net.de> wrote:
>
>>> read MAC OUI any apply only to mikrotik ones?
>
> checking subvendor and subdevice id is usefull. mikrotik has special
> values here
>
> the R11e-2HPnD card has
>
> subvendor 0x19b6
>
> subdevice 0xd016
>
>

that i already suggested but it appears his units have zeroed sub fields
