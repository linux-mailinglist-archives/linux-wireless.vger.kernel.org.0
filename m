Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A89B9379A13
	for <lists+linux-wireless@lfdr.de>; Tue, 11 May 2021 00:29:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbhEJWas (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 10 May 2021 18:30:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:42826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230271AbhEJWal (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 10 May 2021 18:30:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8352A61581;
        Mon, 10 May 2021 22:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620685776;
        bh=Y+h1pRIZkPuwq+pJR/OlUZ50r7b3olVRI964OO47VeE=;
        h=From:To:Cc:Subject:Date:From;
        b=PeNYcF+gHG8+H3d2oTNuOn1/dVCgqyve/2C3S2/RTDURFzME5TWuwNaDUEqiuuH/d
         m6c+0OiOQlEDgQQd/93GDgx3MR9a4G63ajs4lAEMSIUimnGZ3Q7wBrPIGLGTn+rSxM
         ql8pd3JgtHD7IKLdE5Siwi9r5Mm/npZVQbmllEd5J9GWXKKfu+O4kba6JItImL6C37
         08z5oUQyHiUzOm3+sAnlWuwWqdqBWlc+WI6Rc6FBBsEmKs/yRCHdUpMe7E95vRTtNH
         fMdX30nla8HkQNx8B3PtcLSo59D6lCZNKGY5nkqwc6gre2G85yPmkrJJFvwkloLD6x
         5LO0MAtViPYTw==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com
Subject: [PATCH 0/5] mt7663s: enable runtime-pm support
Date:   Tue, 11 May 2021 00:29:19 +0200
Message-Id: <cover.1620685619.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

As already done for mt7663e, introduce runtime-pm support for mt7663s

Lorenzo Bianconi (5):
  mt76: sdio: do not run mt76_txq_schedule directly
  mt76: mt7663s: rely on pm reference counting
  mt76: mt7663s: rely on mt76_connac_pm_ref/mt76_connac_pm_unref in tx
    path
  mt76: mt7663s: enable runtime-pm
  mt76: mt7615: set macwork timeout according to runtime-pm

 .../wireless/mediatek/mt76/mt7615/debugfs.c   |  2 +-
 .../net/wireless/mediatek/mt76/mt7615/mac.c   | 29 ++++++++++----
 .../net/wireless/mediatek/mt76/mt7615/main.c  | 18 +++++----
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |  7 +++-
 .../wireless/mediatek/mt76/mt7615/pci_mac.c   |  7 ++--
 .../wireless/mediatek/mt76/mt7615/sdio_mcu.c  | 39 +++++++++++++------
 .../wireless/mediatek/mt76/mt7615/sdio_txrx.c | 16 ++++++--
 .../wireless/mediatek/mt76/mt76_connac_mac.c  |  4 +-
 drivers/net/wireless/mediatek/mt76/sdio.c     | 16 +++++---
 9 files changed, 95 insertions(+), 43 deletions(-)

-- 
2.31.1

