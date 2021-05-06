Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4E823759FF
	for <lists+linux-wireless@lfdr.de>; Thu,  6 May 2021 20:13:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbhEFSOn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 6 May 2021 14:14:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:59888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229974AbhEFSOn (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 6 May 2021 14:14:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BFD626113D;
        Thu,  6 May 2021 18:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620324824;
        bh=1cToQi/OwEb55Puda5i9FYHwpmlcEMvXZ1jcspKCzW8=;
        h=From:To:Cc:Subject:Date:From;
        b=X4AJDFCsSqewDdBVDcrVhykD7z+KJE36RUpXn4M3gQ4+A2TP2GtmNyoA9iApcewYh
         6fY/4w0G8FbTvM9ilcQrIxINodtOyZs91tFf6Ym/JnYCZSZOW04AXRjIsZfubanYsr
         1bZpgB90B8Ax/dtnusG+KvZMQNPi36wKtb5+zObuGiz5AKf5i1Fl/fHyciaXZgfoUo
         lx4qdyrEYYeeBnf6FwXoKgbJH5EZWP72m9fY/YVaz8g4KAkah1b9ojbgUqpPJqaUIv
         brR/9TqK1IN6uYn2kaNJkkTc2r1dYVFgriJnCa6rHlVjd5OQ6eiGHNYQ+RbFgb8MfY
         rO0pdGXlY0oHQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com
Subject: [PATCH 0/4] mt7921: enable rx offloads
Date:   Thu,  6 May 2021 20:13:31 +0200
Message-Id: <cover.1620322988.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Enable the following rx offloads:
- hw rx de-amsdu offload
- rx header traslation offload
- rx csum offload

Lorenzo Bianconi (4):
  mt76: mt7921: enable rx hw de-amsdu
  mt76: connac: add missing configuration in
    mt76_connac_mcu_wtbl_hdr_trans_tlv
  mt76: mt7921: enable rx header traslation offload
  mt76: mt7921: enable rx csum offload

 .../net/wireless/mediatek/mt76/mt7615/mcu.c   |  8 +--
 .../wireless/mediatek/mt76/mt76_connac_mcu.c  | 40 +++++++++++
 .../wireless/mediatek/mt76/mt76_connac_mcu.h  |  4 ++
 .../net/wireless/mediatek/mt76/mt7921/init.c  |  9 ++-
 .../net/wireless/mediatek/mt76/mt7921/mac.c   | 70 +++++++++++++++----
 .../net/wireless/mediatek/mt76/mt7921/mac.h   | 14 ++++
 .../net/wireless/mediatek/mt76/mt7921/main.c  | 18 +++++
 7 files changed, 141 insertions(+), 22 deletions(-)

-- 
2.30.2

