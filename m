Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A375113934A
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jan 2020 15:15:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728757AbgAMOPB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Jan 2020 09:15:01 -0500
Received: from mail-ot1-f49.google.com ([209.85.210.49]:34132 "EHLO
        mail-ot1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726505AbgAMOPB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Jan 2020 09:15:01 -0500
Received: by mail-ot1-f49.google.com with SMTP id a15so9053508otf.1
        for <linux-wireless@vger.kernel.org>; Mon, 13 Jan 2020 06:15:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ktlpbV8JhpEQtpBOTtFZIp0QxeG75WOzqkK9rMrTWc0=;
        b=ptzDp+9d+5NbquVcbbEdsdvRXdUqRT67MONrI/360oZ4pkyvqGV7AymhFKBUI/+UHl
         nd/haMRkw2QYzUrzoxg1aCodRZMtJ/ZVavfk/66LlZgG4nx8szSGdLIFTPpVSfbYO0IC
         KPbXjce7ThMm0/Hzl6gOjWkoYce9DaA/AC1zQYOyIZ30ZRcKzcn8ryN+KvDu6WJUJyKI
         HwAzkKsXfAVQaXx+rRGHKtdPGGpUNYMn08wpht9ljR55149fBbglhxFpODJkDqOZHWWh
         L/+HxDFssW6Aao8n2WpyB/hKNAszmbVB9+YtRknLeNls4dm0xcO+OnTym5iWINZ37qxd
         TP7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ktlpbV8JhpEQtpBOTtFZIp0QxeG75WOzqkK9rMrTWc0=;
        b=eO+vZMP98GcBYODThxSXp1kSF7K21jYSJuQVQTvienceh52DftxQLDl7GW0BY6bSmu
         r9sqznTNYyrti3gUe8FJjAdSz9LiklTzbEMDM24ObeGzOMRZzBSi6BgIgRsN+SsgT3Io
         cWsTbThuCITe8ejixKTRHLtqL57nkQbOwZSpZl24CTHo68yFQ9vJiZpwtMpapydM+UsM
         0vOsYVI6XZT253C5V/2AlcAb4oW5THJZXibThu+gMdLJiOKCAjKPFayb+OCP/zcdAeAT
         VRU3ermsUjVQUs74yV5YWrtxAsIi1Adlfk2wv2beABBRI3Axo30vnyGQkyfHEb41taIw
         K8lw==
X-Gm-Message-State: APjAAAWAfVsGgasODtG/6cn4nxr8SF2DknLOqMKr8ra2IjUx9rILlpDH
        hpBcR8THgVtLvPbsHJeXLzMdHZzLvJc542TTdNw=
X-Google-Smtp-Source: APXvYqwoeM6MgvmrRgLVeFxPKGEtT7juRnkXH2oYE/XMIzYxs50Ch86YnrjQbu3ZswlD4YNls82F2eDE8mTM2ZUy+7I=
X-Received: by 2002:a05:6830:145:: with SMTP id j5mr12628144otp.242.1578924900340;
 Mon, 13 Jan 2020 06:15:00 -0800 (PST)
MIME-Version: 1.0
References: <20200110132142.7737-1-denis281089@gmail.com> <aab66c75-49ae-0955-03a8-f817685b0925@nbd.name>
In-Reply-To: <aab66c75-49ae-0955-03a8-f817685b0925@nbd.name>
From:   Denis Kalashnikov <denis281089@gmail.com>
Date:   Mon, 13 Jan 2020 17:13:12 +0300
Message-ID: <CAKoLU8P3MyauCUevcRHtzMj8HSZQLD-hYyEaZyRH9OfLye6knQ@mail.gmail.com>
Subject: Re: [PATCH v3] ath9k: fix firmware bug in some Mikrotik R11e-2HPnD cards
To:     Felix Fietkau <nbd@nbd.name>
Cc:     linux-wireless@vger.kernel.org, Kalle Valo <kvalo@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

I read value from the SREV register of AR9582 -- got 0x001c04ff. I
looked through the code of ath9k and found out that in this case the
revision is 4. So, since AR_SREV_REVISION_9580_10 is defined as 4, I
logically concluded that AR_SREV_9580_10 would do the job. But you
suspicions turned to be right. I tested AR9580 now and it has the same
value as AR9582 in the SREV register -- 0x001c04ff. PCI Subsystem ID
is zero on those Mikrotik cards, so it is not useful. Felix, guys, may
be somebody have any thoughts how we can distinguish AR9582? Or that a
chip has only 2 chains? May be values from other registers?

=D1=81=D0=B1, 11 =D1=8F=D0=BD=D0=B2. 2020 =D0=B3. =D0=B2 13:37, Felix Fietk=
au <nbd@nbd.name>:
>
> On 2020-01-10 14:21, Denis Kalashnikov wrote:
> > Some of the Mikrotik R11e-2HPnD cards have EEPROM where is
> > flashed that a card has 3 chains, but actually all this cards
> > have only 2. This leads ath9k to write into the logs:
> > 'ath: phy0: Unable to reset channel, reset status -5' and
> > stations don't see that AP.
> >
> > Mikrotik R11e-2HPnD is based on AR9582 chip.
> >
> > Signed-off-by: Denis Kalashnikov <denis281089@gmail.com>
> > ---
> >
> > Changelog:
> >
> > Changes since v2:
> >   Use macros AR_SREV_9580_10 to select only AR9582 chips (they all
> >   have only 2 chains) instead of more general macros AR_SREV_9580
> >   that selects not only AR9582 but also AR9580 chips with 3 chains.
> I don't think you can detect AR9582 based on SREV. Where did you get
> this information from?
>
> - Felix
