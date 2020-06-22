Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09C8A2039E8
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jun 2020 16:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729322AbgFVOtL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 22 Jun 2020 10:49:11 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44052 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728504AbgFVOtK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 22 Jun 2020 10:49:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592837349;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=naZjlXqAUuz9QFqq0p2KUyyeqf2h2ajScjOSS4MNLek=;
        b=iZAt9jWIDdGmUycXcEExUMtQwPB4mAEGmrh+FKOLhyf00tQ8fp+aHiKUONC2CgcxB/o1gC
        4byHJy2zFc5J0HbajANz673LFxUAGuPKG57FBoDYRnDHj17Yg33DxcMznocvl7DLG6Tgm8
        DiWA9q7dYPxj2919VZwtJodp42DVtzE=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-416-6gWTBsdxPpudXkp1QfgPCg-1; Mon, 22 Jun 2020 10:49:05 -0400
X-MC-Unique: 6gWTBsdxPpudXkp1QfgPCg-1
Received: by mail-oi1-f200.google.com with SMTP id e6so8159416oib.0
        for <linux-wireless@vger.kernel.org>; Mon, 22 Jun 2020 07:49:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=naZjlXqAUuz9QFqq0p2KUyyeqf2h2ajScjOSS4MNLek=;
        b=ZrwXUZBHbnT9ETgtuae0nJbr6Fitp3dNNtRNorjhV6tBVcOWOWVCzkkb4krs3GUhtI
         BT12yegpXdtDaSnKdQ4yhYQn23oUb8KdpiZANbwixhGgDs5opkmGL05CKUMVIMnaQqE8
         wl8wPRPJOvJ8X0aJTCn81gCxMyGB89Kk+J7IZc877oI2dnLiqiun8dm+et/G5uZ0qNy7
         fkW0r/p4kVV9/s66crJVX9l/fkRMwXaz+w7Fr/WzBh2QqxySotDHvPq44hqhTcqD9nlQ
         aoJJ+9RDvtlyrB/Ha11V/i/TlILdfTQDkEQAZg33zHi9iNZjqfNfWYSM/qYJmRBzpOTf
         IxBw==
X-Gm-Message-State: AOAM532i7i35S2c285YPJZRIBzOXv8c/+m7YCKhTlaEZF1KCsdqJdL/k
        qtnuUlGXT8rW3+birWugUxPndq9uCfmtEUf5+hvTB5I3IZDEVSz8ArAwB/mgTowGaaftiVK5Ygn
        T8lsggEWVD9Y5t5paruWhcNGEUp80kHHsmRi/5IgGIJ0=
X-Received: by 2002:a9d:39b6:: with SMTP id y51mr12985163otb.175.1592837344596;
        Mon, 22 Jun 2020 07:49:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw6oTCLYY5ewTtAXQxagLn65iRqRaS/ifJ30YW9dcHRfGmRzdPnCFDN3sUXNC+/uj6SNSIpnbpPZl7QUh97fIk=
X-Received: by 2002:a9d:39b6:: with SMTP id y51mr12985144otb.175.1592837344375;
 Mon, 22 Jun 2020 07:49:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200618090556.pepjdbnba2gqzcbe@butterfly.localdomain>
 <20200618111859.GC698688@lore-desk.lan> <20200619150132.2zrc3ojqhtbn432u@butterfly.localdomain>
 <20200621205412.GB271428@localhost.localdomain>
In-Reply-To: <20200621205412.GB271428@localhost.localdomain>
From:   Oleksandr Natalenko <oleksandr@redhat.com>
Date:   Mon, 22 Jun 2020 16:48:53 +0200
Message-ID: <CAHcwAbR4govGK3RPyfKWRgFRhFanWtpJLrB_PEjcoiBDJ3_Adg@mail.gmail.com>
Subject: Re: mt7612 suspend/resume issue
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Felix Fietkau <nbd@nbd.name>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello, Lorenzo.

On Sun, Jun 21, 2020 at 10:54 PM Lorenzo Bianconi <lorenzo@kernel.org> wrote:
> > > +static int __maybe_unused
> > > +mt76x2e_suspend(struct pci_dev *pdev, pm_message_t state)
> > > +{
> > > +   struct mt76_dev *mdev = pci_get_drvdata(pdev);
> > > +   struct mt76x02_dev *dev = container_of(mdev, struct mt76x02_dev, mt76);
> > > +   int i, err;
>
> can you please double-check what is the PCI state requested during suspend?

Do you mean ACPI S3 (this is the state the system enters)?  If not,
what should I check and where?

Thanks.

-- 
  Best regards,
    Oleksandr Natalenko (post-factum)
    Principal Software Maintenance Engineer

