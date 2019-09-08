Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFAD9ACB9A
	for <lists+linux-wireless@lfdr.de>; Sun,  8 Sep 2019 10:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727347AbfIHIjK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 8 Sep 2019 04:39:10 -0400
Received: from alexa-out-ams-02.qualcomm.com ([185.23.61.163]:51394 "EHLO
        alexa-out-ams-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725832AbfIHIjK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 8 Sep 2019 04:39:10 -0400
X-Greylist: delayed 365 seconds by postgrey-1.27 at vger.kernel.org; Sun, 08 Sep 2019 04:39:09 EDT
Received: from ironmsg03-ams.qualcomm.com ([10.251.56.4])
  by alexa-out-ams-02.qualcomm.com with ESMTP; 08 Sep 2019 10:33:03 +0200
Received: from lx-merez1.mea.qualcomm.com ([10.18.173.103])
  by ironmsg03-ams.qualcomm.com with ESMTP; 08 Sep 2019 10:32:58 +0200
From:   Maya Erez <merez@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Maya Erez <merez@codeaurora.org>, linux-wireless@vger.kernel.org,
        wil6210@qti.qualcomm.com
Subject: [PATCH 00/11] wil6210 patches
Date:   Sun,  8 Sep 2019 11:32:44 +0300
Message-Id: <1567931575-27984-1-git-send-email-merez@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The following wil6210 patches include various bug fixes.

Ahmad Masri (1):
  wil6210: fix PTK re-key race

Alexei Avshalom Lazar (1):
  wil6210: verify cid value is valid

Dedy Lansky (4):
  wil6210: add wil_netif_rx() helper function
  wil6210: add debugfs to show PMC ring content
  wil6210: make sure DR bit is read before rest of the status message
  wil6210: properly initialize discovery_expired_work

Lior David (3):
  wil6210: use writel_relaxed in wil_debugfs_iomem_x32_set
  wil6210: fix RX short frame check
  wil6210: ignore reset errors for FW during probe

Maya Erez (2):
  wil6210: add support for pci linkdown recovery
  wil6210: report boottime_ns in scan results

 drivers/net/wireless/ath/wil6210/cfg80211.c     |  15 +-
 drivers/net/wireless/ath/wil6210/debugfs.c      |  16 +-
 drivers/net/wireless/ath/wil6210/main.c         |  35 +++-
 drivers/net/wireless/ath/wil6210/netdev.c       |   4 +
 drivers/net/wireless/ath/wil6210/pcie_bus.c     | 111 ++++++++++-
 drivers/net/wireless/ath/wil6210/pm.c           |   6 +
 drivers/net/wireless/ath/wil6210/pmc.c          |  26 +++
 drivers/net/wireless/ath/wil6210/pmc.h          |   1 +
 drivers/net/wireless/ath/wil6210/txrx.c         | 244 +++++++++++++++++++++---
 drivers/net/wireless/ath/wil6210/txrx.h         |  42 ++++
 drivers/net/wireless/ath/wil6210/txrx_edma.c    |  38 ++--
 drivers/net/wireless/ath/wil6210/txrx_edma.h    |   6 -
 drivers/net/wireless/ath/wil6210/wil6210.h      |  21 ++
 drivers/net/wireless/ath/wil6210/wil_platform.h |   8 +
 drivers/net/wireless/ath/wil6210/wmi.c          |  38 +++-
 drivers/net/wireless/ath/wil6210/wmi.h          |   3 +
 16 files changed, 550 insertions(+), 64 deletions(-)

-- 
1.9.1

