Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 340ED44EA7
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2019 23:43:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726305AbfFMVnW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Jun 2019 17:43:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:51274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725747AbfFMVnV (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Jun 2019 17:43:21 -0400
Received: from localhost.localdomain (unknown [151.66.40.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4991620B7C;
        Thu, 13 Jun 2019 21:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560462201;
        bh=r53BlAHoUOfmlj2Xnl/2XVbKfeFhjg1MlydYIE8jgoQ=;
        h=From:To:Cc:Subject:Date:From;
        b=TOTS7WUESiewHeX56nU1ofXB6PyO24IicbpAlnell6yS4TgsDl79E0Fbj86bGaH4x
         yk2ZvyyqsZqLSUCTNHCzTLVbvys+MTxkmhLMCDWt+0Nuw4MGISNU9KZMmzPIX+K5WU
         gFX0vg4roOIIXfm7ppkCtNeJy3EHWSQEmkqOQHg4=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, nbd@nbd.name,
        lorenzo.bianconi@redhat.com, sgruszka@redhat.com
Subject: [PATCH v3 wireless-drivers 0/3] mt76: usb: fix A-MSDU support
Date:   Thu, 13 Jun 2019 23:43:10 +0200
Message-Id: <cover.1560461404.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Reallocate the skb if there is no enough space to manage the AMSDU rx packets.
Do not always copy the first part of received frames if A-MSDU is enabled
for SG capable devices

Changes since v2:
- simplify mt76u_build_rx_skb
- add patch 2/3: mt76u: introduce mt76u_ep data structure
- align usb buffer size to usb max endpoint length
- set buf_size to PAGE_SIZE even for sg case

Changes since v1:
- do not allocate multiple page buffers but rely on fragmented skbs
  if there is no enough space to manage the AMSDU rx packets

Lorenzo Bianconi (3):
  mt76: usb: fix rx A-MSDU support
  mt76: mt76u: introduce mt76u_ep data structure
  mt76: usb: do not always copy the first part of received frames

 drivers/net/wireless/mediatek/mt76/mt76.h | 17 +++--
 drivers/net/wireless/mediatek/mt76/usb.c  | 75 +++++++++++++++++------
 2 files changed, 67 insertions(+), 25 deletions(-)

-- 
2.21.0

