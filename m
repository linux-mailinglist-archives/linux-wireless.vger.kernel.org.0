Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4587036615B
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Apr 2021 23:06:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233909AbhDTVGL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Apr 2021 17:06:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:43992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233548AbhDTVGL (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Apr 2021 17:06:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1BD0A6135F;
        Tue, 20 Apr 2021 21:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618952739;
        bh=p7XH/kqvjwyGpt2o6ruBQnGMax6igugp4pbgAgcVHos=;
        h=From:To:Cc:Subject:Date:From;
        b=FA5VQGjgPVS5wjF/EZoxG20VEefUaspEG5NVvTZsUvOrAsiPyr37I5VaXDlnVeDBf
         eiMAUheFUDeHUFZGa3IwqjN9BazAlslCCHejF6FLy87qlGMHeMSU0ZuzI+SbzjL4bT
         Hon8iKN1oWv4IYTY2iEK3nS/Xz25NrkuY5oW40B6BxHYwnD3hjhDgnbETp7EVAGjdS
         qoTaH5dvQ7C1rlM8fQowCJzXEBPzJFAefP/LfbnzZRCKl66a7v2IGwIWfTBaXIWwPT
         8EDfM/Rki33K0XsfwXtrzsL0x2J/0eLA51AE719TcJLtEMW62gE1m2cTH9WrOPIY1I
         n1IgmR5PmbI9g==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, ryder.lee@mediatek.com
Subject: [PATCH 0/2] mt76: move token management in mt76 module
Date:   Tue, 20 Apr 2021 23:05:30 +0200
Message-Id: <cover.1618952061.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Move token management in mt76 common module since it is shared between
mt7615, mt7915 and mt7921 drivers

Lorenzo Bianconi (2):
  mt76: move token_lock, token and token_count in mt76_dev
  mt76: move token utilities in mt76 common module

 drivers/net/wireless/mediatek/mt76/mt76.h     | 54 +++++++++++++--
 .../net/wireless/mediatek/mt76/mt7615/mac.c   | 14 ++--
 .../net/wireless/mediatek/mt76/mt7615/mmio.c  |  1 +
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |  3 -
 .../wireless/mediatek/mt76/mt7615/pci_init.c  |  3 +-
 .../wireless/mediatek/mt76/mt7615/pci_mac.c   | 10 +--
 .../net/wireless/mediatek/mt76/mt7915/init.c  |  3 +-
 .../net/wireless/mediatek/mt76/mt7915/mac.c   | 64 +++--------------
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |  5 --
 .../net/wireless/mediatek/mt76/mt7915/pci.c   |  1 +
 .../net/wireless/mediatek/mt76/mt7921/init.c  |  4 +-
 .../net/wireless/mediatek/mt76/mt7921/mac.c   | 58 +++-------------
 .../wireless/mediatek/mt76/mt7921/mt7921.h    |  5 --
 .../net/wireless/mediatek/mt76/mt7921/pci.c   |  1 +
 drivers/net/wireless/mediatek/mt76/tx.c       | 68 +++++++++++++++++++
 15 files changed, 153 insertions(+), 141 deletions(-)

-- 
2.30.2

