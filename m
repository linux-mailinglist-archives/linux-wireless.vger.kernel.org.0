Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD389108C1
	for <lists+linux-wireless@lfdr.de>; Wed,  1 May 2019 16:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbfEAOGc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 May 2019 10:06:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:34548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726473AbfEAOG3 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 May 2019 10:06:29 -0400
Received: from localhost.localdomain (unknown [151.66.22.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8964021670;
        Wed,  1 May 2019 14:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556719588;
        bh=BuExp7n+b39TN/8hxW4eC/KnaXxjrPug+5B07O4gmug=;
        h=From:To:Cc:Subject:Date:From;
        b=hDa9gz/pPbEtcUpNpnF2UYzDa3nB9Rb+otLlV5WNRbW7Wmc2iPtcV8pYxcpmvfwms
         ZcyCy0MM1/dBVsTuYpub8xLBaWIM1+ESDwHBEXBrsuF6h1w/z+W1PEWBmFxVgDi2tS
         FKmuFTPogy5bd8BP6OUOjgxJDHDYlbJuZKBNXS44=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com
Subject: [PATCH 0/4] mt76: add tx napi polling support to mt7603/mt7615
Date:   Wed,  1 May 2019 16:06:19 +0200
Message-Id: <cover.1556718795.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Use napi polling for tx cleanup in mt7603 and mt7615 drivers in order
to allow tx scheduling and tx cleanup to run concurrently

Lorenzo Bianconi (4):
  mt76: move tx_napi in mt76_dev
  mt76: mt7603: use napi polling for tx cleanup
  mt76: mt7615: use napi polling for tx cleanup
  mt76: move netif_napi_del in mt76_dma_cleanup

 drivers/net/wireless/mediatek/mt76/dma.c      |  1 +
 drivers/net/wireless/mediatek/mt76/mt76.h     |  1 +
 .../net/wireless/mediatek/mt76/mt7603/core.c  |  2 +-
 .../net/wireless/mediatek/mt76/mt7603/dma.c   | 29 +++++++++++++++++--
 .../net/wireless/mediatek/mt76/mt7603/mac.c   |  4 ++-
 .../net/wireless/mediatek/mt76/mt7615/dma.c   | 23 +++++++++++++--
 .../net/wireless/mediatek/mt76/mt7615/pci.c   |  2 +-
 drivers/net/wireless/mediatek/mt76/mt76x02.h  |  1 -
 .../net/wireless/mediatek/mt76/mt76x02_mmio.c | 18 ++++++------
 9 files changed, 63 insertions(+), 18 deletions(-)

-- 
2.20.1

