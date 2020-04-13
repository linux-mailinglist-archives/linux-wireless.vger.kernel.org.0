Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31C801A6831
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Apr 2020 16:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730808AbgDMOcZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Apr 2020 10:32:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26290 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728185AbgDMOcY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Apr 2020 10:32:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586788342;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EqyFmXGGL5gH7qnh4uLURlAxbznvoOmx0g2Mhp4F6Po=;
        b=OUL72FhdZQKHuRtqiznTDYyKd/BMhWCPZmfrgRJT0LKbKaAn3duR7vSZsUTpqkN0lRWipq
        5jTQUi/YsmM8yNI56tQ99V5OiyisC63OfciTQdKiPQ+zAYbilIZJMYoM2m+YKa/4Lq4w3V
        WZFhif/MFdRuYthjjAVIq4/u8CX8l3E=
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-329-nkGthp4iNiql4H3xUUnA-Q-1; Mon, 13 Apr 2020 10:32:20 -0400
X-MC-Unique: nkGthp4iNiql4H3xUUnA-Q-1
Received: by mail-ua1-f69.google.com with SMTP id 2so2171007uav.4
        for <linux-wireless@vger.kernel.org>; Mon, 13 Apr 2020 07:32:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EqyFmXGGL5gH7qnh4uLURlAxbznvoOmx0g2Mhp4F6Po=;
        b=XV3zj9zzSouS2U7WGg/C1g8iVqoCPJen3jVJaFN7ZX/BN4Ng3strji50/9vh6tj4P+
         Jq4XHOQlenRZ7Rb3YtuatGou3mC5UgJd8bzunPF+GTrqTW2X3gRnM2wwfBr1paspIYCZ
         PxX23IX2UNex3iwC69BJwMd1Bif/od8PYhOQtdc932HkAFLoaGvkczCeiI2z+WK1ueBU
         ZIu/H4xAS08sKTa4rBS5+OU+wMBRyvNpOBy8RXmnr988UqMP7+dRbbGO/iNRJr/i//q1
         J1BYjIQhNZ7kqVVHmG/2P32q3k9tx/ZVUKjv8Iva1pq+Zte/hF8aik0r+jjUdYzzM/aR
         B1xg==
X-Gm-Message-State: AGi0PuZg0OHmGwtwEJQKFw1nakaSGzJAuDwMkmZceWs/rt5jeUk7iUE6
        RSpjMgVY/FgG/i5M4CmG69/SmkbtOkU36UfbByQD+KpyW957ubyqYEoF50Q/aymF0LabyNhK92r
        PNPE2UO23K2+8DWZMzCtk908+zceA4Uax8/TTDjX/Y38=
X-Received: by 2002:a67:ed14:: with SMTP id l20mr11552266vsp.233.1586788340014;
        Mon, 13 Apr 2020 07:32:20 -0700 (PDT)
X-Google-Smtp-Source: APiQypKzuR6Ua5fS/D+pEUWq54ijuuvcxRCg6rajTuAm7fR56pI8I+sx8N2oN9MaIiBTLp6D4yvnSaU8KiJFAq+oHk0=
X-Received: by 2002:a67:ed14:: with SMTP id l20mr11552251vsp.233.1586788339731;
 Mon, 13 Apr 2020 07:32:19 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1586451954.git.lorenzo@kernel.org>
In-Reply-To: <cover.1586451954.git.lorenzo@kernel.org>
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Date:   Mon, 13 Apr 2020 16:33:12 +0200
Message-ID: <CAJ0CqmXQM-NvadLJF1=vVKTABUQOiUGrwhEoVPtnK0oc=QyGMA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] introduce usb support to mt7615 driver
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     Felix Fietkau <nbd@nbd.name>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

>
> Introduce support for mt7663u 802.11ac 2x2:2 chipset to mt7615 driver.
> Create mt7615-common module as container for mmio and usb shared code
>
> Changes since v1:
> - rebased ontop of mt76 master branch
>
> Lorenzo Bianconi (2):
>   mt76: mt7615: move core shared code in mt7615-common module
>   mt76: mt7615: introduce mt7663u support

Hi Felix,

please hold on with this series, I will post a new one rebased ontop
of mt76 master branch

Regards,
Lorenzo

>
>  drivers/net/wireless/mediatek/mt76/Makefile   |   2 +-
>  drivers/net/wireless/mediatek/mt76/mt76.h     |   1 +
>  .../net/wireless/mediatek/mt76/mt7615/Kconfig |  18 +-
>  .../wireless/mediatek/mt76/mt7615/Makefile    |  10 +-
>  .../wireless/mediatek/mt76/mt7615/debugfs.c   |   1 +
>  .../net/wireless/mediatek/mt76/mt7615/dma.c   |  39 --
>  .../wireless/mediatek/mt76/mt7615/eeprom.c    |   1 +
>  .../net/wireless/mediatek/mt76/mt7615/init.c  | 192 +--------
>  .../net/wireless/mediatek/mt76/mt7615/mac.c   | 249 ++++-------
>  .../net/wireless/mediatek/mt76/mt7615/mac.h   |   5 +-
>  .../net/wireless/mediatek/mt76/mt7615/main.c  |  66 +--
>  .../net/wireless/mediatek/mt76/mt7615/mcu.c   |  18 +-
>  .../net/wireless/mediatek/mt76/mt7615/mcu.h   |   5 +
>  .../net/wireless/mediatek/mt76/mt7615/mmio.c  |  30 ++
>  .../wireless/mediatek/mt76/mt7615/mt7615.h    |  22 +-
>  .../wireless/mediatek/mt76/mt7615/pci_init.c  | 187 +++++++++
>  .../wireless/mediatek/mt76/mt7615/pci_mac.c   | 184 ++++++++
>  .../net/wireless/mediatek/mt76/mt7615/regs.h  |  26 ++
>  .../net/wireless/mediatek/mt76/mt7615/usb.c   | 396 ++++++++++++++++++
>  .../wireless/mediatek/mt76/mt7615/usb_init.c  | 144 +++++++
>  .../wireless/mediatek/mt76/mt7615/usb_mcu.c   |  93 ++++
>  21 files changed, 1257 insertions(+), 432 deletions(-)
>  create mode 100644 drivers/net/wireless/mediatek/mt76/mt7615/pci_init.c
>  create mode 100644 drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c
>  create mode 100644 drivers/net/wireless/mediatek/mt76/mt7615/usb.c
>  create mode 100644 drivers/net/wireless/mediatek/mt76/mt7615/usb_init.c
>  create mode 100644 drivers/net/wireless/mediatek/mt76/mt7615/usb_mcu.c
>
> --
> 2.25.2
>

