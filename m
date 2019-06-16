Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C241473A1
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Jun 2019 09:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbfFPHc4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 16 Jun 2019 03:32:56 -0400
Received: from alexa-out-ams-02.qualcomm.com ([185.23.61.163]:36278 "EHLO
        alexa-out-ams-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726069AbfFPHc4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 16 Jun 2019 03:32:56 -0400
Received: from ironmsg02-ams.qualcomm.com ([10.251.56.3])
  by alexa-out-ams-02.qualcomm.com with ESMTP; 16 Jun 2019 09:26:14 +0200
X-IronPort-AV: E=McAfee;i="6000,8403,9289"; a="8499830"
Received: from lx-merez1.mea.qualcomm.com ([10.18.173.103])
  by ironmsg02-ams.qualcomm.com with ESMTP; 16 Jun 2019 09:26:09 +0200
From:   Maya Erez <merez@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Maya Erez <merez@codeaurora.org>, linux-wireless@vger.kernel.org,
        wil6210@qti.qualcomm.com
Subject: [PATCH 00/11] wil6210 patches
Date:   Sun, 16 Jun 2019 10:25:56 +0300
Message-Id: <1560669967-23706-1-git-send-email-merez@codeaurora.org>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The following set of patces include multiple wil6210 bug fixes.

Ahmad Masri (4):
  wil6210: enlarge Tx status ring size
  wil6210: increase the frequency of status ring hw tail update
  wil6210: set WIL_WMI_CALL_GENERAL_TO_MS as wmi_call timeout
  wil6210: drop old event after wmi_call timeout

Alexei Avshalom Lazar (3):
  wil6210: do not reset FW in STA to P2P client interface switch
  wil6210: Add support for setting RBUFCAP configuration
  wil6210: update cid boundary check of wil_find_cid/_by_idx()

Dedy Lansky (1):
  wil6210: fix printout in wil_read_pmccfg

Maya Erez (2):
  wil6210: clear FW and ucode log address
  wil6210: publish max_msdu_size to FW on BCAST ring

Tzahi Sabo (1):
  wil6210: add support for reading multiple RFs temperature via debugfs

 drivers/net/wireless/ath/wil6210/cfg80211.c   |  22 ++++-
 drivers/net/wireless/ath/wil6210/debugfs.c    |  88 +++++++++++++++---
 drivers/net/wireless/ath/wil6210/main.c       |  19 +++-
 drivers/net/wireless/ath/wil6210/pcie_bus.c   |   1 +
 drivers/net/wireless/ath/wil6210/rx_reorder.c |  31 +++----
 drivers/net/wireless/ath/wil6210/txrx.c       |   9 +-
 drivers/net/wireless/ath/wil6210/txrx_edma.c  |  16 +++-
 drivers/net/wireless/ath/wil6210/txrx_edma.h  |   2 +-
 drivers/net/wireless/ath/wil6210/wil6210.h    |   6 ++
 drivers/net/wireless/ath/wil6210/wmi.c        | 127 ++++++++++++++++++++++----
 drivers/net/wireless/ath/wil6210/wmi.h        |  47 ++++++++--
 11 files changed, 297 insertions(+), 71 deletions(-)

-- 
1.9.1

