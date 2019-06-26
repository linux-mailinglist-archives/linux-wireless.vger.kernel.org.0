Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C65F565DA
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Jun 2019 11:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726077AbfFZJqo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 26 Jun 2019 05:46:44 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:51931 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725379AbfFZJqo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 26 Jun 2019 05:46:44 -0400
X-UUID: 2945cb3f5e0b44f4a9b32e27d89fac6d-20190626
X-UUID: 2945cb3f5e0b44f4a9b32e27d89fac6d-20190626
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1401304215; Wed, 26 Jun 2019 17:46:36 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 26 Jun 2019 17:46:34 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 26 Jun 2019 17:46:34 +0800
Message-ID: <1561542394.32588.0.camel@mtkswgap22>
Subject: Re: [RFC 0/5] add hw dfs pattern detector support to mt7615 driver
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
CC:     <nbd@nbd.name>, <lorenzo.bianconi@redhat.com>,
        <linux-wireless@vger.kernel.org>, <royluo@google.com>,
        <yf.luo@mediatek.com>
Date:   Wed, 26 Jun 2019 17:46:34 +0800
In-Reply-To: <cover.1561499275.git.lorenzo@kernel.org>
References: <cover.1561499275.git.lorenzo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-TM-SNTS-SMTP: 8923B52383B668B249EA3BE4C2D3B233A8F2ED6BEF5C92591938F82E0FB844032000:8
X-MTK:  N
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2019-06-26 at 00:01 +0200, Lorenzo Bianconi wrote:
> Introduce radar pattern detection support to mt7615 driver. Please note I have
> tested this series just through the radar pattern test knob added to debugfs
> and not through I real radar signal generator.
> CSA is currently missing (I am currently working on it).
> This series is based on 'mt76: move nl80211_dfs_regions in mt76_dev data
> structure' https://patchwork.kernel.org/patch/11010723/
> 
> Lorenzo Bianconi (5):
>   mt76: mt7615: introduce mt7615_regd_notifier
>   mt76: mt7615: add hw dfs pattern detector support
>   mt76: mt7615: do not perform txcalibration before cac is complited
>   mt76: mt7615: unlock dfs bands
>   mt76: mt7615: add radar pattern test knob to debugfs
> 
>  .../wireless/mediatek/mt76/mt7615/Makefile    |   3 +-
>  .../wireless/mediatek/mt76/mt7615/debugfs.c   |  38 ++++++
>  .../net/wireless/mediatek/mt76/mt7615/dma.c   |   2 +-
>  .../net/wireless/mediatek/mt76/mt7615/init.c  |  43 +++++--
>  .../net/wireless/mediatek/mt76/mt7615/mac.c   |  88 +++++++++++++
>  .../net/wireless/mediatek/mt76/mt7615/main.c  |   6 +
>  .../net/wireless/mediatek/mt76/mt7615/mcu.c   | 121 ++++++++++++++++--
>  .../net/wireless/mediatek/mt76/mt7615/mcu.h   |  23 ++++
>  .../wireless/mediatek/mt76/mt7615/mt7615.h    |  55 ++++++++
>  9 files changed, 356 insertions(+), 23 deletions(-)
>  create mode 100644 drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c
> 
For the series
Acked-by: Ryder Lee <ryder.lee@mediatek.com>

