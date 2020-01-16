Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86FD213D827
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Jan 2020 11:46:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726088AbgAPKqc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 16 Jan 2020 05:46:32 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:33567 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbgAPKqc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 16 Jan 2020 05:46:32 -0500
Received: by mail-oi1-f195.google.com with SMTP id q81so3647419oig.0
        for <linux-wireless@vger.kernel.org>; Thu, 16 Jan 2020 02:46:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hwO58jYqJWd4485WomANp/1uz2KxQ5qFL1JRbgWMqMI=;
        b=eijnvBbjgtedCrYcaaSMAuKRkeX78HWpb2+6YHaP7Fs3kTBwXRS4LnZ5ihx6dgMKX3
         FiTgyugOcjaLeocCwcr53ratetX1zvmvyhh+X1sohrSHlcGBf7RVTi7qaZcKGzgiPQmT
         QmeDYxEJxRWP2xazXo8raUKaTi3mPvD8gh+ywaB9qN4I8E/AhEudIVTqENu4OEdSgjlG
         J4t3OcuA3cb/tP1WyLydwEuxS4CqHHpnnJWCGqlj/fBYbHgpHp4xhPMvR0+95PE6SlHL
         p7epfX4b5JAjMAOBfUUM9XRWcCrrTgWFhZjtvbjpQeAExO2pJRFFdxb0aV3bYDX54jb+
         JDzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hwO58jYqJWd4485WomANp/1uz2KxQ5qFL1JRbgWMqMI=;
        b=Y6f+Nq+QlK0Ea1uOtPtPlFhgf5WB4FoTHzUSfJ7eNRjVn5VEce9WxaO87041RdZv2Q
         v04fjkQXJ4dmbImEa7ITyhxeHP1IzqZL66awJdohqeONsvbXLSgAELg55h23EK8UVKti
         k77y9niDfGy3NGRH8ASOzmkgV2TFGkrjHTvP7kA8NymHqTLmbWX6gDUAKkC7YtRT8Qbq
         yXp3CEyJcPoHBI6RRCHxScIel7ONhUzbNcslkIrUI/dGH8iNXdZDL0Nyr9HuvEv4DM5w
         rfmSiE+I5G6CxuZAIwpUcN4Qr0B/TfPG5OlAJ9+d/WNCwJ+IERvoDOK9Gux3DVYSpAhR
         +EuQ==
X-Gm-Message-State: APjAAAV9fd5xWLGQTEWaRsymoyf+tmR3TWsprSdxg4bN3+wyTSDrl6RI
        IJPyZ7RMLB875+bq/aWRWR2Hsv3TSSorNkTd0bg=
X-Google-Smtp-Source: APXvYqw3R9xesNCywQ47W57F3QNZAfZglNvkrnxK8L8rJ6RA+Cena1KlWsenzDl1nfYTEsdCCXfM0LrHKNjnrTFLhLU=
X-Received: by 2002:aca:1e0f:: with SMTP id m15mr3738694oic.58.1579171591378;
 Thu, 16 Jan 2020 02:46:31 -0800 (PST)
MIME-Version: 1.0
References: <20200110132142.7737-1-denis281089@gmail.com> <aab66c75-49ae-0955-03a8-f817685b0925@nbd.name>
 <CAKoLU8P3MyauCUevcRHtzMj8HSZQLD-hYyEaZyRH9OfLye6knQ@mail.gmail.com>
 <CAKR_QVKb21WWbUup-O9nsDvfVO7-c_+Kpxx3n8=b1e4X5pkmkw@mail.gmail.com>
 <CAKoLU8MRzBaB9AS0--vCG01hKhBrdzB8=42A+vMv9X39ZAPZLQ@mail.gmail.com>
 <28f78f20-b415-4046-674f-070ad6c43f44@newmedia-net.de> <CAKR_QV++azTZKi0dodYXDEgXbkUcUhBqezzMtGc0=dh_ngOqOQ@mail.gmail.com>
 <18634217-2e93-83fd-ec40-9b2a1bf28f56@newmedia-net.de> <CAKR_QVLXTYsBztSH2wU3FDfwV5vaaUa0JzN=aQtMGd+CeEKE-w@mail.gmail.com>
 <324ec6fe-4212-a78a-dd48-8e08566719c6@newmedia-net.de>
In-Reply-To: <324ec6fe-4212-a78a-dd48-8e08566719c6@newmedia-net.de>
From:   Denis Kalashnikov <denis281089@gmail.com>
Date:   Thu, 16 Jan 2020 13:44:43 +0300
Message-ID: <CAKoLU8Pk_6kmi-8NnhD4gvJfa8YQMKf4TwdgKG8Y19K=WNFSLQ@mail.gmail.com>
Subject: Re: [PATCH v3] ath9k: fix firmware bug in some Mikrotik R11e-2HPnD cards
To:     Sebastian Gottschall <s.gottschall@newmedia-net.de>
Cc:     Tom Psyborg <pozega.tomislav@gmail.com>,
        Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org,
        Kalle Valo <kvalo@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

These cards have a very strange eeprom (we compared their eeprom with
eeprom of the same Mikrotik cards but without these problems). Now we
are discussing with our supplier how this is possible.

=D1=87=D1=82, 16 =D1=8F=D0=BD=D0=B2. 2020 =D0=B3. =D0=B2 11:50, Sebastian G=
ottschall
<s.gottschall@newmedia-net.de>:
>
>
> Am 16.01.2020 um 08:46 schrieb Tom Psyborg:
> > On 16/01/2020, Sebastian Gottschall <s.gottschall@newmedia-net.de> wrot=
e:
> >>>> checking subvendor and subdevice id is usefull. mikrotik has special
> >>>> values here
> >>>>
> >>>> the R11e-2HPnD card has
> >>>>
> >>>> subvendor 0x19b6
> >>>>
> >>>> subdevice 0xd016
> >>>>
> >>>>
> >>> that i already suggested but it appears his units have zeroed sub fie=
lds
> >> if it has zero subfields it has no original eeprom but a modified one.
> >> all mikrotik cards with no exception have the subvendor and subdevice =
id
> >> set.
> >> the subvendor and subdevice is is stored in the eeprom. or the eeprom
> >> could be also broke, but in this case the values should be 0xffff
> >> i have several original mikrotik cards of this type and this is where =
i
> >> got these values from. are you sure that your card is no immitation?
> >> can he send me a picture of this card?
> >>
> > oh really? probably some fools then tampered with his cards and tried
> > to screw him. your units work without this patch, and tx/rx chain
> > reads out 0x3 ?
> yes. i have about 20 - 25 of them in use and the chaininfo is correct
> and also the subdevice and subvendor id
> is correct but i'm highly interesting finding out more about this case
> here. so do we have just have
> a fake mikrotik card here of a known chinese marketplace or is it a real
> one. and more interesting
>
> if you install this card on a mikrotik board, what does routeros show
>
> Sebastian
>
> >
> >
