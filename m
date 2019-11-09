Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32322F5F9D
	for <lists+linux-wireless@lfdr.de>; Sat,  9 Nov 2019 15:56:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbfKIO4I (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 9 Nov 2019 09:56:08 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:42495 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbfKIO4H (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 9 Nov 2019 09:56:07 -0500
Received: by mail-ot1-f68.google.com with SMTP id b16so7738482otk.9
        for <linux-wireless@vger.kernel.org>; Sat, 09 Nov 2019 06:56:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B1uUBCiNUZwSJIuzJOuEQTdp7wnRXchp8b90kvnXGGE=;
        b=cicgqtjkBCS6S4xZPGy0wpAF85jBk4Q8xVKsbKir5qXueTMGvkls1YH+0xZvvZ8KNi
         u2XI3Sl5tmoUIf6pUU15nt+w7/Vz0i9iDfdotlIPOYRTGus19KFmKkBl4xyn3O6Zv/it
         X6XZggVGMDuNjSGottV7DS0QP4+5JGjpD0ARCjWAifC347SKCHgEwhFheVkB90LpP2Ax
         tVfxWUwq154ZzZdshLRzre6PIYvg1kfq2gwaWOhKNbQNaZuWuGBI85Ym3Jem7BCeepoR
         1VfdKyUImC5gZFfDUv48ASuPft61+9YZkv8zdNDxsUsp/v81CHkw3MUEhd8TQBU0+1/y
         elFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B1uUBCiNUZwSJIuzJOuEQTdp7wnRXchp8b90kvnXGGE=;
        b=fpZNo1ko4PGn6PKYz2i5jeteivr9HtCM/mBwUp+/7zv40g0K+A+dv7v8SdM6lP0Qrz
         dtzyhmj63mL56vCst49AxIzWH3mMzb7FbHPdFJd63CuDdgpJpXFtQMZDdzp9MMNp121L
         Zh9OdXVfsT2Ido6yvSxMvACDiYEtl6U7go8Co292obZGbmVbGL5jm0/Sxth5X+XGdp+5
         IAiYrwP4wzwRk0dhEgz/ltaFdDo/x+5/ywOwQyIwdI6UiakVYYi/fvRhFymTJclJK87A
         ytW87gVuTB0ipovD8/IEtZ9s2riQ2XQM3X662yDIEnRN3dEuIbEEdmIpUEj8kjgmj72b
         uSbQ==
X-Gm-Message-State: APjAAAVMoDX7whwu7DKzG0wK5n+kkZwWg7aZsPwle5ecRmAv0PmJs4rU
        BVE2Os3PVCmIl0CMd8VopWUq+Yo+vcy6uXnc2RGILD2ca84=
X-Google-Smtp-Source: APXvYqx9P9jsndxPsd1W9aGkO/be65JODvCEcDhZEqhleXSsvddnLzi5ukfHNS7R2TOW73Kaj1jR19YghPcRq9Ih/wY=
X-Received: by 2002:a9d:5e1a:: with SMTP id d26mr12710534oti.96.1573311366706;
 Sat, 09 Nov 2019 06:56:06 -0800 (PST)
MIME-Version: 1.0
References: <CAFBinCAbmvUJym2KD5Y4DcF_iGUwB6SrQSGd7qU6qmuctJ06Cg@mail.gmail.com>
In-Reply-To: <CAFBinCAbmvUJym2KD5Y4DcF_iGUwB6SrQSGd7qU6qmuctJ06Cg@mail.gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 9 Nov 2019 15:55:55 +0100
Message-ID: <CAFBinCD8TXZD6q662kFm_ZNe+kUi74q=SaEz_PHUev=AnWZSBw@mail.gmail.com>
Subject: Re: BCM4335 SDIO firmware crash/problem
To:     linux-wireless@vger.kernel.org
Cc:     arend.vanspriel@broadcom.com, franky.lin@broadcom.com,
        hante.meuleman@broadcom.com, chi-hsien.lin@cypress.com,
        wright.feng@cypress.com, brcm80211-dev-list.pdl@broadcom.com,
        brcm80211-dev-list@cypress.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sun, Nov 3, 2019 at 12:49 PM Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
[...]
> The Android installation that my device came with ships a newer
> firmware version: "BCM4335/1 wl0: May 18 2014 16:56:54 version
> 6.34.171.58.2". This is also available in CoreELEC's repository: [2].
> I went ahead and used this newer on my Arch Linux ARM installation and
> it seems to have fixed my problem
I am now at 12 days of uptime and wifi is still working with that firmware


Martin
