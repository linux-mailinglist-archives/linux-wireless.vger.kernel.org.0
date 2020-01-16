Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3741813D54F
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Jan 2020 08:47:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbgAPHq7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 16 Jan 2020 02:46:59 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:34723 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727005AbgAPHq7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 16 Jan 2020 02:46:59 -0500
Received: by mail-il1-f194.google.com with SMTP id s15so17363906iln.1
        for <linux-wireless@vger.kernel.org>; Wed, 15 Jan 2020 23:46:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=1pjl2ZsCt0UbUg8esDB/zX8N9uxotuFxEgz8ENSEiBU=;
        b=A2s2HIir+OqnjmfNVNRcbSW6co6/8Mn9EJN4R5niyQ3YHvldqi6l5ut2Q6p0aa+0jY
         VUZm9v/TULUf/Aa77fyIomg6CweBGiVSK4ixbFEyTyIX8N3NSy/RBoBTJ1+fxUDckfE/
         QOs+tbS+9F0tHb7hR1ry4hIgX9dV/X3yM2Gd6HxM/ipX6HAYXV32fujohulLSwIjKAVa
         tWqnKNAKOm0Zht58bA391VKURb/3AvaVeuFOfvt+Azbn+oiRJPNQ8r4RwcHC1EP58gLi
         H165jkFEMtLHdr1ymAKW+xM5NCNfqjLzYV3IvYaw+KkvUW1tZFvsj24uPPKf4jdXJIc6
         lI4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=1pjl2ZsCt0UbUg8esDB/zX8N9uxotuFxEgz8ENSEiBU=;
        b=GoJnIR8ckG7VzRm95O0zzzWokWTS27gkRGTixTCUeyqXpBnJJvuTOHkOoyzOYw2tTV
         QPixpKg9G65zFI32pSLSQyWQot3p5Q2XtYhTTb3JFAl4Xt0Y7pnEs63VZq8mehkt2Lsp
         oxO38mraRZEIrZRIexc8uIL9tjZKGwkvITK2EfvajiyiC6FC/TzcyrGHr+F9WmTEVqTU
         Sr9XNYZUTf3IODU0MrVPGK65x+eXHQUemxkcphvzUtHP5lRsowrvu5g8ORJssIu4ReVA
         25rVkPRfV3mRP12pVDnI6edg+5VeB/vf2net8+oxpex5qp7VMUrPOobhodNbMrdtWe46
         dxWQ==
X-Gm-Message-State: APjAAAXwkXHCspLbyc/ERRZl+Tu5Te1cHK+WiEQ+GX1OPOsJX//ZMJZW
        4vg5zirPnavCWs0dMUdBB3R1B3qSIvKmcBhX1bk=
X-Google-Smtp-Source: APXvYqx5TtZNbR4N6HrXZctbTt/77Tsu61h6oEUM4MknJIEoeoJYe4FeQGrYOu26nUeDALHwzMIR2EosHOkkkdFcDi4=
X-Received: by 2002:a92:9885:: with SMTP id a5mr2366845ill.107.1579160818515;
 Wed, 15 Jan 2020 23:46:58 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a6b:a0b:0:0:0:0:0 with HTTP; Wed, 15 Jan 2020 23:46:57 -0800 (PST)
In-Reply-To: <18634217-2e93-83fd-ec40-9b2a1bf28f56@newmedia-net.de>
References: <20200110132142.7737-1-denis281089@gmail.com> <aab66c75-49ae-0955-03a8-f817685b0925@nbd.name>
 <CAKoLU8P3MyauCUevcRHtzMj8HSZQLD-hYyEaZyRH9OfLye6knQ@mail.gmail.com>
 <CAKR_QVKb21WWbUup-O9nsDvfVO7-c_+Kpxx3n8=b1e4X5pkmkw@mail.gmail.com>
 <CAKoLU8MRzBaB9AS0--vCG01hKhBrdzB8=42A+vMv9X39ZAPZLQ@mail.gmail.com>
 <28f78f20-b415-4046-674f-070ad6c43f44@newmedia-net.de> <CAKR_QV++azTZKi0dodYXDEgXbkUcUhBqezzMtGc0=dh_ngOqOQ@mail.gmail.com>
 <18634217-2e93-83fd-ec40-9b2a1bf28f56@newmedia-net.de>
From:   Tom Psyborg <pozega.tomislav@gmail.com>
Date:   Thu, 16 Jan 2020 08:46:57 +0100
Message-ID: <CAKR_QVLXTYsBztSH2wU3FDfwV5vaaUa0JzN=aQtMGd+CeEKE-w@mail.gmail.com>
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

On 16/01/2020, Sebastian Gottschall <s.gottschall@newmedia-net.de> wrote:
>>> checking subvendor and subdevice id is usefull. mikrotik has special
>>> values here
>>>
>>> the R11e-2HPnD card has
>>>
>>> subvendor 0x19b6
>>>
>>> subdevice 0xd016
>>>
>>>
>> that i already suggested but it appears his units have zeroed sub fields
> if it has zero subfields it has no original eeprom but a modified one.
> all mikrotik cards with no exception have the subvendor and subdevice id
> set.
> the subvendor and subdevice is is stored in the eeprom. or the eeprom
> could be also broke, but in this case the values should be 0xffff
> i have several original mikrotik cards of this type and this is where i
> got these values from. are you sure that your card is no immitation?
> can he send me a picture of this card?
>

oh really? probably some fools then tampered with his cards and tried
to screw him. your units work without this patch, and tx/rx chain
reads out 0x3 ?
