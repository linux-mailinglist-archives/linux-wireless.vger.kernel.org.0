Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 309C725E6AF
	for <lists+linux-wireless@lfdr.de>; Sat,  5 Sep 2020 11:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbgIEJ0P (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 5 Sep 2020 05:26:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:40130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726302AbgIEJ0P (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 5 Sep 2020 05:26:15 -0400
Received: from localhost.localdomain (unknown [151.66.86.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F5A0206A5;
        Sat,  5 Sep 2020 09:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599297975;
        bh=y92RWco/+UjmrGEayxLyQY8rFthCDMTImtMGXoUPCCA=;
        h=From:To:Cc:Subject:Date:From;
        b=D8dtl0kiF/fkQKETDzjLTb+2fMd4tfRT3CdByTGnhTbMs1Hu2DhPlAHfOQHNaWxFp
         +OJwN33ZDcoEpCWjtI7NCVhJFqTIPK7FqZar2WXmOKQWfx72rbotYiZUt1zKe6Yupq
         z+5sKZoWk4hSxBKMZhlxbc0ciFSIo54nGzNpz4wg=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        sean.wang@mediatek.com
Subject: [PATCH 0/7] add tx aggregation for mt7663s
Date:   Sat,  5 Sep 2020 11:26:00 +0200
Message-Id: <cover.1599297449.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce sdio tx aggregation to reduce bus transaction ands improve tx
throughput. For the moment the skb are copied in a dedicated buffer
since mmc APIs do not support sg table for zero-copy.
Fixed a quota leak in mt7663s_refill_sched_quota.
Do not update quota in case of tx errors.

Lorenzo Bianconi (7):
  mt76: mt7663s: do not use altx for ctl/mgmt taffic
  mt76: mt7663s: split mt7663s_tx_update_sched in
    mt7663s_tx_{pick,update}_quota
  mt76: mt7663s: introduce __mt7663s_xmit_queue routine
  mt76: move pad estimation out of mt76_skb_adjust_pad
  mt76: mt7663s: fix possible quota leak in mt7663s_refill_sched_quota
  mt76: mt7663s: introduce sdio tx aggregation
  mt76: mt7663: check isr read return value in mt7663s_rx_work

 drivers/net/wireless/mediatek/mt76/mac80211.c |   5 +-
 drivers/net/wireless/mediatek/mt76/mt76.h     |   5 +-
 .../net/wireless/mediatek/mt76/mt7615/sdio.c  |  14 +-
 .../wireless/mediatek/mt76/mt7615/sdio_txrx.c | 174 ++++++++++++------
 .../wireless/mediatek/mt76/mt7615/usb_mcu.c   |   6 +-
 .../wireless/mediatek/mt76/mt7615/usb_sdio.c  |   6 +-
 .../wireless/mediatek/mt76/mt76x02_usb_core.c |   5 +-
 drivers/net/wireless/mediatek/mt76/sdio.c     |   5 +-
 drivers/net/wireless/mediatek/mt76/tx.c       |   6 +-
 9 files changed, 145 insertions(+), 81 deletions(-)

-- 
2.26.2

