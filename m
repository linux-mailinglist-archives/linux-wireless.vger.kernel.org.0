Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D8F15AA47
	for <lists+linux-wireless@lfdr.de>; Sat, 29 Jun 2019 12:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726888AbfF2Kse (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 29 Jun 2019 06:48:34 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:37886 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726839AbfF2Ksd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 29 Jun 2019 06:48:33 -0400
Received: by mail-io1-f66.google.com with SMTP id e5so18063524iok.4
        for <linux-wireless@vger.kernel.org>; Sat, 29 Jun 2019 03:48:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fIt5KzM/ixJUgaxVxAgAjIzZ64xGs3vpsVNRgWZXZsk=;
        b=oiQiocDfNxLTwtBe196+cV9zdTYHrnXeH5Yo+iN+p2u7p04RqQwG72QS7yjxg1vwoG
         gCKUL4oUQ7a0PZ8Sd2eYQL4fv3njQHi0UFdoVqZcK3azrl8F9EOa3C2GXJ+pHEQMxjRF
         aartjQfeg/uMtONvXF43tZeL+4ZQSIqiH3b1ha0683PAfk2OzqN+TDC63uITzMt0d17T
         Vq4kvJlR713pI24BbyFlmpQAUVTPhRxVnzWARAJ3zRGeHzsfT687t1nEedbksEJT14RC
         DnY1j1d7KVLS4cUewnBCr+jJHRBGwAeeMXGOEGcWLTX9eDIclNQEsxhHOnZV06Narrlh
         9Q2g==
X-Gm-Message-State: APjAAAW24QxjeG2PbRa066fCrBXJjhMBfQKRXE+vrONgz49ySXTAafh3
        O7lAE2eCol/oMYzuVS1k6zvRrMapUTjJYrBwTdx7pQ==
X-Google-Smtp-Source: APXvYqwhFFnf0hfqao3ziGPCskrkzFjEgL64tSKh6iSlAXk5hpWvL1Uri4mEYCDZDhAS94zp3nYnGKGcYh1Y4egTRoA=
X-Received: by 2002:a6b:2b08:: with SMTP id r8mr15079854ior.34.1561805312949;
 Sat, 29 Jun 2019 03:48:32 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1561804422.git.lorenzo@kernel.org>
In-Reply-To: <cover.1561804422.git.lorenzo@kernel.org>
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Date:   Sat, 29 Jun 2019 12:48:21 +0200
Message-ID: <CAJ0CqmUqv+uWcDkPnDAmjM2j=9fUZ0F4on4SH5LoQ4zPGmPuNw@mail.gmail.com>
Subject: Re: [PATCH 0/6] add hw dfs pattern detector support to mt7615 driver
To:     Felix Fietkau <nbd@nbd.name>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Roy Luo <royluo@google.com>, YF Luo <yf.luo@mediatek.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

>
> Introduce radar pattern detection support to mt7615 driver.
> Add Channel Switch Announcement support updating beacon template with
> CSA IE received from mac80211.
> Please note I have tested this series just through the radar pattern test
> knob added to debugfs and not through I real radar signal generator.
>

Changes since RFC:
- added Channel Switch Announcement support

> Lorenzo Bianconi (6):
>   mt76: mt7615: introduce mt7615_regd_notifier
>   mt76: mt7615: add hw dfs pattern detector support
>   mt76: mt7615: do not perform txcalibration before cac is complited
>   mt76: mt7615: unlock dfs bands
>   mt76: mt7615: add csa support
>   mt76: mt7615: add radar pattern test knob to debugfs
>
>  .../wireless/mediatek/mt76/mt7615/Makefile    |   3 +-
>  .../wireless/mediatek/mt76/mt7615/debugfs.c   |  38 +++++
>  .../net/wireless/mediatek/mt76/mt7615/dma.c   |   2 +-
>  .../net/wireless/mediatek/mt76/mt7615/init.c  |  44 ++++--
>  .../net/wireless/mediatek/mt76/mt7615/mac.c   |  88 +++++++++++
>  .../net/wireless/mediatek/mt76/mt7615/main.c  |  19 +++
>  .../net/wireless/mediatek/mt76/mt7615/mcu.c   | 147 ++++++++++++++++--
>  .../net/wireless/mediatek/mt76/mt7615/mcu.h   |  24 +++
>  .../wireless/mediatek/mt76/mt7615/mt7615.h    |  55 +++++++
>  9 files changed, 392 insertions(+), 28 deletions(-)
>  create mode 100644 drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c
>
> --
> 2.21.0
>
