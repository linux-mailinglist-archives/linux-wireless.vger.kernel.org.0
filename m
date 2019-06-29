Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9D555AC24
	for <lists+linux-wireless@lfdr.de>; Sat, 29 Jun 2019 17:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbfF2PUQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 29 Jun 2019 11:20:16 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:27710 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726819AbfF2PUQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 29 Jun 2019 11:20:16 -0400
X-UUID: 0276ae1d7325446182df794f0847c346-20190629
X-UUID: 0276ae1d7325446182df794f0847c346-20190629
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1857504110; Sat, 29 Jun 2019 23:20:05 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Sat, 29 Jun 2019 23:20:03 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Sat, 29 Jun 2019 23:20:03 +0800
Message-ID: <1561821603.28134.0.camel@mtkswgap22>
Subject: Re: [PATCH 0/6] add hw dfs pattern detector support to mt7615 driver
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
CC:     Felix Fietkau <nbd@nbd.name>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Roy Luo <royluo@google.com>, YF Luo <yf.luo@mediatek.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>
Date:   Sat, 29 Jun 2019 23:20:03 +0800
In-Reply-To: <CAJ0CqmUqv+uWcDkPnDAmjM2j=9fUZ0F4on4SH5LoQ4zPGmPuNw@mail.gmail.com>
References: <cover.1561804422.git.lorenzo@kernel.org>
         <CAJ0CqmUqv+uWcDkPnDAmjM2j=9fUZ0F4on4SH5LoQ4zPGmPuNw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-TM-SNTS-SMTP: 7E5AA41A2FD52F434A1429F5D0062ECB28319E0CFA40222A8F6C55D77452995D2000:8
X-MTK:  N
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sat, 2019-06-29 at 12:48 +0200, Lorenzo Bianconi wrote:
> >
> > Introduce radar pattern detection support to mt7615 driver.
> > Add Channel Switch Announcement support updating beacon template with
> > CSA IE received from mac80211.
> > Please note I have tested this series just through the radar pattern test
> > knob added to debugfs and not through I real radar signal generator.
> >
> 
> Changes since RFC:
> - added Channel Switch Announcement support
> 
> > Lorenzo Bianconi (6):
> >   mt76: mt7615: introduce mt7615_regd_notifier
> >   mt76: mt7615: add hw dfs pattern detector support
> >   mt76: mt7615: do not perform txcalibration before cac is complited
> >   mt76: mt7615: unlock dfs bands
> >   mt76: mt7615: add csa support
> >   mt76: mt7615: add radar pattern test knob to debugfs
> >
> >  .../wireless/mediatek/mt76/mt7615/Makefile    |   3 +-
> >  .../wireless/mediatek/mt76/mt7615/debugfs.c   |  38 +++++
> >  .../net/wireless/mediatek/mt76/mt7615/dma.c   |   2 +-
> >  .../net/wireless/mediatek/mt76/mt7615/init.c  |  44 ++++--
> >  .../net/wireless/mediatek/mt76/mt7615/mac.c   |  88 +++++++++++
> >  .../net/wireless/mediatek/mt76/mt7615/main.c  |  19 +++
> >  .../net/wireless/mediatek/mt76/mt7615/mcu.c   | 147 ++++++++++++++++--
> >  .../net/wireless/mediatek/mt76/mt7615/mcu.h   |  24 +++
> >  .../wireless/mediatek/mt76/mt7615/mt7615.h    |  55 +++++++
> >  9 files changed, 392 insertions(+), 28 deletions(-)
> >  create mode 100644 drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c
> >
> > --
> > 2.21.0


Acked-by: Ryder Lee <ryder.lee@mediatek.com> for the series.
> >


