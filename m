Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 249A6B6EDA
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Sep 2019 23:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732215AbfIRVao (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Sep 2019 17:30:44 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:34111 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727737AbfIRVan (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Sep 2019 17:30:43 -0400
Received: by mail-oi1-f196.google.com with SMTP id 83so957309oii.1
        for <linux-wireless@vger.kernel.org>; Wed, 18 Sep 2019 14:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=yM5Syc3VnAc9IR5XhYvLeJT9r7yth9/BSoIvBzcggVU=;
        b=AUI17j1pRCtj8Ooa2DEm59w1qpc+NRc9fjIHApG0XLkU1/YdGkO1EF6rHS4CGifq8j
         06vuZILbaG029vRbhT8ZUeO/tmMr6b0o/vJ0WCeI4R9RzZJj1Ha8i22QgVffSfa/9A9e
         HL5ffrprLmkeEgaG1zSvKbt2r9Izi7O81uo194a3eM7zNGDBIeNHrp74gDcUkS1BR7C3
         Eb7Z9jKQfeRotQMYh0z8oh9PPmrza9pjS7jKTuB5vtatfj6wTQrxTk1c3c2oUnvSKgWp
         3dhHnP7HlwOYwq+o9PyM1Yx8f5OAcoXvw7G2ujBEQPYnzikpU1+F9ZPx1KiYAb7EB4O+
         rm4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=yM5Syc3VnAc9IR5XhYvLeJT9r7yth9/BSoIvBzcggVU=;
        b=a4pOrxTzl8pKf0bXlBs2R4dxYY12weqBX6/6SPnF7+yZplwPsq3QGt3BlbaNoFaBpo
         316yG7fcHXphoJoVHQ2AUX5TDONQf3g2To0x2RMgZIKZHC/v/pGcSbCn41o9lXC3ImBY
         PL4cLqckz5TFqInBNZQk6yhOwHySaZEu6GF0G4sszF5+9Otis4HsImzA/i56CKjk6dus
         9USx2Q6G29yuttH2MbMHaKjJUMXBoYWDGagF9a0LbXPBn3xFkkbOYiHX00h8Xv8pIcTM
         5TgyZPEiofFtUPNidIKu1o1GlLbvp6L/FNmLbOYJGQjfJr/povwPhmJTGydC5buIHWQ1
         h1SQ==
X-Gm-Message-State: APjAAAWO/lZ1ZVJqdGnO0twHZF57lEefVl8MjIlOpmZmkgHy/kUks+l7
        lxu56Mi/Fke1aWwZP3TlOvg83pc+aGgANLDPoOM=
X-Google-Smtp-Source: APXvYqwkk/N7ggoZ0ODVVJWifcmyxSkjLHCFK0jOwg0LUZzoshNVCDO8KY3FCHMz6mxJgNBROjC2LFduVgVwzigOeW0=
X-Received: by 2002:aca:d841:: with SMTP id p62mr14431oig.128.1568842242887;
 Wed, 18 Sep 2019 14:30:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:2286:0:0:0:0:0 with HTTP; Wed, 18 Sep 2019 14:30:42
 -0700 (PDT)
In-Reply-To: <20190917064412.E237C61577@smtp.codeaurora.org>
References: <20190906215423.23589-1-chunkeey@gmail.com> <20190917064412.E237C61577@smtp.codeaurora.org>
From:   Tom Psyborg <pozega.tomislav@gmail.com>
Date:   Wed, 18 Sep 2019 23:30:42 +0200
Message-ID: <CAKR_QVJ09gsbvvutDjDU4tR3VdkQRyYveCnAZ-gU9qByERb-=g@mail.gmail.com>
Subject: Re: [PATCH] ath10k: restore QCA9880-AR1A (v1) detection
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Christian Lamparter <chunkeey@gmail.com>,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 17/09/2019, Kalle Valo <kvalo@codeaurora.org> wrote:
> Christian Lamparter <chunkeey@gmail.com> wrote:
>
>> This patch restores the old behavior that read
>> the chip_id on the QCA988x before resetting the
>> chip. This needs to be done in this order since
>> the unsupported QCA988x AR1A chips fall off the
>> bus when resetted. Otherwise the next MMIO Op
>> after the reset causes a BUS ERROR and panic.
>>
>> Cc: stable@vger.kernel.org
>> Fixes: 1a7fecb766c8 ("ath10k: reset chip before reading chip_id in
>> probe")
>> Signed-off-by: Christian Lamparter <chunkeey@gmail.com>
>
> I'll drop this as there's no plan to support QCA988X hw1.0.
>
> --
> https://patchwork.kernel.org/patch/11136089/
>
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
>
>

Maybe the whole subject on QCA988X cards should be re-evaluated? Since
at this point it's not for certain whether the card is difficult to
support or whether it is damaged.
There was at least one report of QCA988X hw2.0 failing in an identical
way as QCA988X hw1.0. In case it turns out to be hw damage, a fallback
driver mechanism could provide extended lifetime for these cards. A
link to the hw2.0 failure:
https://forum.openwrt.org/t/is-it-possible-to-brick-the-wireless-card-qca988x-irreversibly/32615
