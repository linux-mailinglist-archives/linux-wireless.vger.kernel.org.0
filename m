Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F836153C1E
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Feb 2020 00:53:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbgBEXxW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 5 Feb 2020 18:53:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:46152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727170AbgBEXxW (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 5 Feb 2020 18:53:22 -0500
Received: from localhost.lan (unknown [151.48.147.3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A98B720672;
        Wed,  5 Feb 2020 23:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580946801;
        bh=B8S0cSFMRnPunM7hGtX/UcwnafhXYWO8syCal9DZtok=;
        h=From:To:Cc:Subject:Date:From;
        b=lzq4ZJubu6RaCFBk4DiJfqbqp21Hej3HqsZGy1x2b/qM82J2QZ/wQm9h7QclDLEUw
         1m6IWQnHymqSnnhkv+5E8CWMeA4ftL28jE2YAiMJOLWZly5pQ+dTxeJQaqOIkaRs/q
         LizbOna1lXTb6TMoarKlCaU+udHk1AMYOOUu3lQk=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org
Subject: [PATCH 0/3] remove mmio dependency from mcu event code
Date:   Thu,  6 Feb 2020 00:53:07 +0100
Message-Id: <cover.1580945999.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Remove mmio dependency from mt76_mcu_rx_event and mt76_mcu_get_response in
order to reuse them in usb code and remove duplicated code

Lorenzo Bianconi (3):
  mt76: reuse mt76_mcu in mt76u_mcu
  mt76: generalize mt76_mcu_rx_event routine
  mt76: generalize mt76_mcu_get_response routine

 drivers/net/wireless/mediatek/mt76/mcu.c      | 15 ++++---
 drivers/net/wireless/mediatek/mt76/mt76.h     | 43 ++++++++++---------
 .../net/wireless/mediatek/mt76/mt7603/dma.c   |  4 +-
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   |  2 +-
 .../net/wireless/mediatek/mt76/mt76x02_txrx.c |  3 +-
 .../wireless/mediatek/mt76/mt76x02_usb_mcu.c  | 22 ++++++----
 drivers/net/wireless/mediatek/mt76/usb.c      |  6 ++-
 7 files changed, 52 insertions(+), 43 deletions(-)

-- 
2.21.1

