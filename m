Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6F4C109CB3
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Nov 2019 12:04:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727872AbfKZLEq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 26 Nov 2019 06:04:46 -0500
Received: from a27-188.smtp-out.us-west-2.amazonses.com ([54.240.27.188]:48384
        "EHLO a27-188.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726231AbfKZLEq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 26 Nov 2019 06:04:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1574766285;
        h=From:To:Cc:Subject:Date:Message-Id;
        bh=EKXQcDsPK/bDtyYM/LEcq1mIgnehXkTX0ctPtZH6XMA=;
        b=ffYlX2bYFDxTJpj7nyrArKPKNeJDweiZ4txHSMS+AA2S0XhLaVGOlTDPeRE2htlw
        ss/V8HarS8X1XdBYaClVoFVmyazoNmS2+TtPmGfbeyeNuYyL6thBuf5IOtZljpHMWko
        1APRHmQlFpuhICrXTXnlQB4qYfighaRfSim7O7zc=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1574766285;
        h=From:To:Cc:Subject:Date:Message-Id:Feedback-ID;
        bh=EKXQcDsPK/bDtyYM/LEcq1mIgnehXkTX0ctPtZH6XMA=;
        b=hFitOCW9fqKzLuMc0LECvKDW+WtLSgzbiXIVK2k/dq0Zxz6TW+DcXGzmK8Z8Uq6W
        c9AbBuDDWCrRmeyUkBLo8HCHWxiliHg7hEiQrU8CW1HDbdVqqm3m2URvyAJ9pS/CzPV
        FMG+6hR+ZzTqw8HVMOiKlQF/D3PSLg9asW6By6a4=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 91E01C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     linux-wireless@vger.kernel.org
Cc:     ath11k@lists.infradead.org
Subject: [PATCH 00/10] ath11k: second round of post-bringup patches
Date:   Tue, 26 Nov 2019 11:04:45 +0000
Message-ID: <0101016ea76290b1-e34a2ab5-b550-4b38-8a3a-d9e249b22f74-000000@us-west-2.amazonses.com>
X-Mailer: git-send-email 2.7.4
X-SES-Outgoing: 2019.11.26-54.240.27.188
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Here's second of round of ath11k patches from ath11k-post-bringup
branch[1] which got queued while ath11k was in review.

Major features here are support for new firmare version and
performance improvements.

Please review.

Kalle

[1] https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/log/?h=ath11k-post-bringup

Anilkumar Kolli (2):
  ath11k: fix wmi service ready ext tlv parsing
  ath11k: update tcl cmd descriptor parameters for STA mode

Ganesh Sesetti (1):
  ath11k: Fix htt stats sounding info and pdev cca stats

John Crispin (1):
  ath11k: optimize RX path latency

Karthikeyan Periyasamy (2):
  ath11k: fix resource leak in ath11k_mac_sta_state
  ath11k: avoid WMM param truncation

Pradeep Kumar Chitrapu (1):
  ath11k: remove unused tx ring counters

Sriram R (1):
  ath11k: Fix skb_panic observed during msdu coalescing

Vasanthakumar Thiagarajan (1):
  ath11k: Fix target crash due to WBM_IDLE_LINK ring desc shortage

Vikas Patel (1):
  ath11k: Fixing TLV length issue in peer pktlog WMI command

 drivers/net/wireless/ath/ath11k/dp.c       |  15 ++-
 drivers/net/wireless/ath/ath11k/dp.h       |   5 +-
 drivers/net/wireless/ath/ath11k/dp_rx.c    |  71 ++++++++------
 drivers/net/wireless/ath/ath11k/dp_tx.c    |   7 --
 drivers/net/wireless/ath/ath11k/hal_desc.h |   5 +-
 drivers/net/wireless/ath/ath11k/hal_rx.c   |  49 +---------
 drivers/net/wireless/ath/ath11k/hal_rx.h   |  28 +-----
 drivers/net/wireless/ath/ath11k/hal_tx.c   |   6 +-
 drivers/net/wireless/ath/ath11k/hal_tx.h   |   4 +-
 drivers/net/wireless/ath/ath11k/mac.c      | 144 +++++++++++++++++------------
 drivers/net/wireless/ath/ath11k/wmi.c      |  16 +++-
 drivers/net/wireless/ath/ath11k/wmi.h      |   5 +-
 12 files changed, 162 insertions(+), 193 deletions(-)

-- 
2.7.4

