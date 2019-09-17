Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC9C3B5592
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Sep 2019 20:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727266AbfIQSoZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Sep 2019 14:44:25 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51881 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726573AbfIQSoZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Sep 2019 14:44:25 -0400
Received: by mail-wm1-f65.google.com with SMTP id 7so4760598wme.1
        for <linux-wireless@vger.kernel.org>; Tue, 17 Sep 2019 11:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ZjoHDBBadvwRyyw+M9tGmZyBWChr8xvbK/hlxQBDTY0=;
        b=ZF3c50QSHO+kq45MJ6xhAEcXjougQuCcR859hh2SKCfJs1xnUz4jzC2yVSXyap7i+E
         Nkx96JycZLYUMKJ2/YFBxRUcO7xTVgb8xfnb40IUminYSXtFmuNGzJAYOc998KE08CQK
         dpgd+BumP5qXmlqgUXnhdNKKkqI54694PkWlFxN5o12BNes+lEjeko5FeqxW3j6++akS
         EejayiwnP6KUG+p0ccwjF2gVBYby2wRpePjeoCCexJLvo/U1jP8kkUlKqzriHoMnfYSS
         CLQsVbYeBdwxpSiUlP0llDONHTquvZqbON6YavqFmBqmfKNZofbM+fXdeXAsLTPTsbCm
         AGJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZjoHDBBadvwRyyw+M9tGmZyBWChr8xvbK/hlxQBDTY0=;
        b=Netk/jC86ii3M1lCmucwzjoHGoe2OEjA9hMlmwscqxJjg4EltY9mMik+i6MmI1Ipfi
         izUOKyzX9Iu6KkQhjHj0rj3+wGEhMF3kWe3kkF1hlEm4z3OYYTFXkRW8S+BKRbdDWCcZ
         +SjU6Dz9v/2F3hAwMHs+LsmX740GQURK6m7DhGI6MhAcaJrlkGhPriI1k87Ic/9LLgaz
         7yuuuMoUDSbfLurkytnt+uaupawU0FCG7wI/ob1iRtz2V5HIpeJaYv9YiYcP/Z/ZVKkS
         849TdqD6fV49ZsAdrA2wMRvWUGYQxzMO0eAFwhya7h1M9gv65NCwWR92DkdYh5fExZ1n
         PqTw==
X-Gm-Message-State: APjAAAWZTy4QBCSIB9xXYelBIWvvJws9dKyJA68/5Rvzc2a9cnkCetS7
        zjXGF3FKNr7GDXyb0p1LVcgQMOGT
X-Google-Smtp-Source: APXvYqxa5RO4PbzT0YIi8MUJRdOVUosR/LN1K7RQO7TjOC18H9b6FAwyMMbtRpgyhGPCRmc/nd/ZiQ==
X-Received: by 2002:a1c:9a46:: with SMTP id c67mr4611628wme.115.1568745863327;
        Tue, 17 Sep 2019 11:44:23 -0700 (PDT)
Received: from smicro.local.lan (BSN-77-158-208.static.siol.net. [193.77.158.208])
        by smtp.gmail.com with ESMTPSA id y5sm1195787wma.14.2019.09.17.11.44.22
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Sep 2019 11:44:22 -0700 (PDT)
Date:   Tue, 17 Sep 2019 20:44:19 +0200
From:   Bob Marcan <bob.marcan@gmail.com>
To:     linux-wireless@vger.kernel.org
Subject: Re: [RFC 0/4] Allow live MAC address change
Message-ID: <20190917204419.41235404@smicro.local.lan>
In-Reply-To: <763f4560-ba78-b0e7-6855-fd4bc048ec13@gmail.com>
References: <20190904191155.28056-1-prestwoj@gmail.com>
        <d776271eac8b7cd24da6dbd21fb87186b30a0e7f.camel@sipsolutions.net>
        <4c43ea6a74cacc61184bc5b1387fecaa40711369.camel@gmail.com>
        <4909a428ee6fef2bf8b0e61841bc88062f534b13.camel@sipsolutions.net>
        <896183390a396e8e0508622eceb3664effcb3c30.camel@gmail.com>
        <87a7b8lciz.fsf@tynnyri.adurom.net>
        <844f1a1dc72ec73df5a86864b410bbc490c4abdd.camel@gmail.com>
        <87imprbc0j.fsf@kamboji.qca.qualcomm.com>
        <763f4560-ba78-b0e7-6855-fd4bc048ec13@gmail.com>
X-Mailer: Claws Mail 3.15.1-dirty (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 17 Sep 2019 10:40:49 -0500
Denis Kenzior <denkenz@gmail.com> wrote:

> Hi Kalle,
>=20
> > For user experience scanning and DHCP are also important, what kind of =
> numbers you get when those are included? No need to have anything> precis=
e, I would like just to get an understanding where we are> nowadays. =20
>=20
> Scanning heavily depends on the RF environment and the hardware.  In our =
testing ath9k takes stupid long to scan for example.
>=20
> But in a sort of best case scenario, using limited scan and no mac change=
, iwd connects in ~300ms.  People have reported that they have not finished=
 opening their laptop screen and they're connected, so at that level of lat=
ency, every millisecond is important and totally worth fighting for.  Rando=
mizing the MAC would penalize our connection times by 2X (300 ms at least).=
  And Android folks have reported the penalty to be as high as 3 seconds.  =
So this needs to be fixed.  And do note that this is a feature every modern=
 OS implements by default.

Randomizing the MAC is a stupid decision.
Do you realy expect that this will add something to the security?

B. Mar=C4=8Dan
