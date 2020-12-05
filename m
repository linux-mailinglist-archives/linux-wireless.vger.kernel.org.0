Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E4552CFB07
	for <lists+linux-wireless@lfdr.de>; Sat,  5 Dec 2020 11:42:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725920AbgLEKjw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 5 Dec 2020 05:39:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:45092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729208AbgLEKgb (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 5 Dec 2020 05:36:31 -0500
From:   Lorenzo Bianconi <lorenzo@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org
Subject: [PATCH 0/2] remove wake queue tx logic for usb/sdio
Date:   Sat,  5 Dec 2020 11:35:24 +0100
Message-Id: <cover.1607164041.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Similar to mmio, remove queue wake logic for sdio and usb code path

Lorenzo Bianconi (2):
  mt76: usb: remove wake logic in mt76u_status_worker
  mt76: sdio: remove wake logic in mt76s_process_tx_queue

 drivers/net/wireless/mediatek/mt76/sdio.c | 15 +++------------
 drivers/net/wireless/mediatek/mt76/usb.c  |  7 -------
 2 files changed, 3 insertions(+), 19 deletions(-)

-- 
2.28.0

