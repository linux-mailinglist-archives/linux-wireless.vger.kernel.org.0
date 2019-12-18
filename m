Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2B3D124909
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Dec 2019 15:06:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727102AbfLROGB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Dec 2019 09:06:01 -0500
Received: from alexa-out-ams-02.qualcomm.com ([185.23.61.163]:54572 "EHLO
        alexa-out-ams-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726984AbfLROGB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Dec 2019 09:06:01 -0500
X-Greylist: delayed 365 seconds by postgrey-1.27 at vger.kernel.org; Wed, 18 Dec 2019 09:06:00 EST
Received: from ironmsg03-ams.qualcomm.com ([10.251.56.4])
  by alexa-out-ams-02.qualcomm.com with ESMTP; 18 Dec 2019 14:59:55 +0100
Received: from lx-merez2.mea.qualcomm.com ([10.18.173.102])
  by ironmsg03-ams.qualcomm.com with ESMTP; 18 Dec 2019 14:59:49 +0100
From:   Maya Erez <merez@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Maya Erez <merez@codeaurora.org>, linux-wireless@vger.kernel.org,
        wil6210@qti.qualcomm.com
Subject: [PATCH 0/8] wil6210 patches
Date:   Wed, 18 Dec 2019 15:59:39 +0200
Message-Id: <20191218135947.5903-1-merez@codeaurora.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The following patches include wil6210 fixes

Ahmad Masri (2):
  wil6210: dump Rx status message on errors
  wil6210: support set_multicast_to_unicast cfg80211 operation

Alexei Avshalom Lazar (3):
  wil6210: minimize the time that mem_lock is held
  wil6210: take mem_lock for writing in crash dump collection
  wil6210: add verification for cid upper bound

Dedy Lansky (3):
  wil6210: reduce ucode_debug memory region
  wil6210: fix MID valid bits in Rx status message
  wil6210: add support for set_cqm_rssi_config

 drivers/net/wireless/ath/wil6210/cfg80211.c   | 34 ++++++++
 drivers/net/wireless/ath/wil6210/main.c       | 10 ++-
 drivers/net/wireless/ath/wil6210/txrx.c       | 32 +++++++-
 drivers/net/wireless/ath/wil6210/txrx_edma.c  | 10 +++
 drivers/net/wireless/ath/wil6210/txrx_edma.h  |  8 +-
 drivers/net/wireless/ath/wil6210/wil6210.h    |  6 +-
 .../net/wireless/ath/wil6210/wil_crash_dump.c | 17 ++--
 drivers/net/wireless/ath/wil6210/wmi.c        | 80 ++++++++++++++++++-
 drivers/net/wireless/ath/wil6210/wmi.h        | 33 ++++++++
 9 files changed, 213 insertions(+), 17 deletions(-)

-- 
2.23.0

