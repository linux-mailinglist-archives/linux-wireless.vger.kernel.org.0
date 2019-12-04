Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E4A1113394
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Dec 2019 19:19:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731566AbfLDSR5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Dec 2019 13:17:57 -0500
Received: from nbd.name ([46.4.11.11]:40912 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728738AbfLDSR5 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Dec 2019 13:17:57 -0500
Received: from p5dcfb666.dip0.t-ipconnect.de ([93.207.182.102] helo=bertha.datto.lan)
        by ds12 with esmtpa (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1icZDj-0005Od-VP; Wed, 04 Dec 2019 19:17:52 +0100
From:   John Crispin <john@phrozen.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        John Crispin <john@phrozen.org>
Subject: [PATCH V2 0/9] ath11k: resend pending patches
Date:   Wed,  4 Dec 2019 19:17:36 +0100
Message-Id: <20191204181745.27297-1-john@phrozen.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kalle merged ath11k into his next tree and then applied the huge backlog
from patchwork. This is a resend of pending patches that no longer apply
due to merge order conflicts.

Changes in V2:
* fix up the comments from Vassant

John Crispin (9):
  ath11k: add wmi helper for turning STA PS on/off
  ath11k: disable PS for STA interfaces by default upon bringup
  ath11k: drop memset when setting up a tx cmd desc
  ath11k: rename ath11k_wmi_base instances from wmi_sc to wmi_ab
  ath11k: add WMI calls to manually add/del/pause/resume TWT dialogs
  ath11k: add debugfs for TWT debug calls
  ath11k: move some tx_status parsing to debugfs code
  ath11k: optimise ath11k_dp_tx_completion_handler
  ath11k: optimize ath11k_hal_tx_status_parse

 drivers/net/wireless/ath/ath11k/core.c        |   4 +-
 drivers/net/wireless/ath/ath11k/core.h        |   3 +-
 drivers/net/wireless/ath/ath11k/debug.c       | 197 +++++++++
 drivers/net/wireless/ath/ath11k/debug.h       |   8 +
 drivers/net/wireless/ath/ath11k/debugfs_sta.c |  66 +--
 drivers/net/wireless/ath/ath11k/dp.c          |  16 +-
 drivers/net/wireless/ath/ath11k/dp.h          |  11 +-
 drivers/net/wireless/ath/ath11k/dp_tx.c       |  81 ++--
 drivers/net/wireless/ath/ath11k/hal_tx.c      |  74 +---
 drivers/net/wireless/ath/ath11k/hal_tx.h      |  13 +-
 drivers/net/wireless/ath/ath11k/htc.c         |   2 +-
 drivers/net/wireless/ath/ath11k/mac.c         |  15 +-
 drivers/net/wireless/ath/ath11k/testmode.c    |   2 +-
 drivers/net/wireless/ath/ath11k/wmi.c         | 407 ++++++++++++++----
 drivers/net/wireless/ath/ath11k/wmi.h         | 123 +++++-
 15 files changed, 771 insertions(+), 251 deletions(-)

-- 
2.20.1

