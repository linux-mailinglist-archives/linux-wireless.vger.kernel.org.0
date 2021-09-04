Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC1F8400AC6
	for <lists+linux-wireless@lfdr.de>; Sat,  4 Sep 2021 13:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351051AbhIDKR6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 4 Sep 2021 06:17:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:48578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235889AbhIDKR6 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 4 Sep 2021 06:17:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5D2AF60FA0;
        Sat,  4 Sep 2021 10:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630750616;
        bh=yX/49kd2vx8OVhHeRttdAwUBI65nF70ZF5J7DU5xtXo=;
        h=From:To:Cc:Subject:Date:From;
        b=APz6Tp2pGj8FBmpTTN4siMwTZKQ4H0jFX5ch7gWEH1SVb0d2V+KPoJxW8M8EtgtVT
         AbqnwaHogPk+hN/N6OI+ELPZ9dXbsbPz+Q+4gMWQJKwABaSxifgrXERt2q/GunFugZ
         v59/vvuP5AdWKh9lDMGc2OFuONZQqqNJ574Jv+y5oIU5GdverR6k7BS9GWAIkhs+eP
         eMG2qeBE5U5o+uO53CtXH7NfB7gwCXiP9x/1xQ7ZWQ2nsH5q5tgQkJJ7JspiaHXJQ5
         qTA0+yUIJ0Yf9CKazlouGap89CZA/mZR/ooRAocvOWEE2Ytg5uQwUJjHX3KjX/iCv8
         S3Tsl9DFaFfug==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, Deren.Wu@mediatek.com
Subject: [PATCH v4 0/5] add tx status reporting to mt7921 driver
Date:   Sat,  4 Sep 2021 12:16:42 +0200
Message-Id: <cover.1630750292.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Report tx rate from tx status packets instead of receiving periodic mcu
event. This improves flexibility, accuracy and AQL performance, and
simplifies code flow for better readability.
Add some code cleanup

Changes since v3:
- fix possible NULL pointer dereference in mt7921_mac_add_txs_skb()
Changes since v2:
- remove magic numbers and introduce definitions for them
Changes since v1:
- fix rate flags in mt7921_mac_sta_poll() for ht rates

Lorenzo Bianconi (5):
  mt76: mt7921: start reworking tx rate reporting
  mt76: mt7921: add support for tx status reporting
  mt76: mt7921: report tx rate directly from tx status
  mt76: mt7921: remove mcu rate reporting code
  mt76: mt7921: remove mt7921_sta_stats

 .../net/wireless/mediatek/mt76/mt7921/init.c  |   1 -
 .../net/wireless/mediatek/mt76/mt7921/mac.c   | 369 ++++++++++++------
 .../net/wireless/mediatek/mt76/mt7921/mac.h   |  20 +
 .../net/wireless/mediatek/mt76/mt7921/main.c  |  28 +-
 .../net/wireless/mediatek/mt76/mt7921/mcu.c   | 133 -------
 .../net/wireless/mediatek/mt76/mt7921/mcu.h   |  47 ---
 .../wireless/mediatek/mt76/mt7921/mt7921.h    |  21 +-
 7 files changed, 293 insertions(+), 326 deletions(-)

-- 
2.31.1

