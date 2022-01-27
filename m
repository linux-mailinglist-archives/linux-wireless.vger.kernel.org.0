Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFD5B49DA39
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Jan 2022 06:33:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236191AbiA0Fdn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Jan 2022 00:33:43 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:2542 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233121AbiA0Fdn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Jan 2022 00:33:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1643261623; x=1674797623;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=yQ3INR6n570uHvp11Q1QrySW8cBpez/o3z3TkFMm0dc=;
  b=DqIcKK77tV+45O459S2ItjNs7Zws0OuvKBjl4/0CVge7HSLoEKLuHi8i
   oULNuOEVPeLJ0FlVmH0WttcMDdOvaru4wFgNQ/0JUswofBjNwf7gyJVre
   UujrENn3IorNFA3KoyxEkjHC8k0g8+czrdQ2F6M+jeb9SOL+tV5FnUAxg
   I=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 26 Jan 2022 21:33:42 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 21:33:42 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 26 Jan 2022 21:33:42 -0800
Received: from mpubbise-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 26 Jan 2022 21:33:40 -0800
From:   Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Subject: [PATCH RFC 0/8] Follow-on series for WCN6750
Date:   Thu, 27 Jan 2022 11:03:21 +0530
Message-ID: <1643261609-13500-1-git-send-email-quic_mpubbise@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This is a follow-on series for WCN6750 adding several
features, fixes and throughput enhancements.

Manikanta Pubbisetty (8):
  ath11k: Enable low power mode when WLAN is not active
  ath11k: Register shutdown handler for WCN6750
  ath11k: Cold boot calibration support on WCN6750
  ath11k: Cap NSS of HE peer to radio supported NSS
  ath11k: Enable threaded NAPI on WCN6750
  ath11k: Increase TCL data ring size
  ath11k: Add multi TX ring support for WCN6750
  ath11k: Add Coredump support of MSA region for WCN6750
---
Note: This series is dependent on another series adding
      support for WCN6750 in ATH11K.
      https://patchwork.kernel.org/project/linux-wireless/list/?series=605793

 drivers/net/wireless/ath/ath11k/Kconfig    |   1 +
 drivers/net/wireless/ath/ath11k/Makefile   |   1 +
 drivers/net/wireless/ath/ath11k/ahb.c      | 126 +++++++++++++++++++++-
 drivers/net/wireless/ath/ath11k/ahb.h      |   8 +-
 drivers/net/wireless/ath/ath11k/core.c     | 168 ++++++++++++++++++++++++-----
 drivers/net/wireless/ath/ath11k/core.h     |   5 +-
 drivers/net/wireless/ath/ath11k/coredump.c |  87 +++++++++++++++
 drivers/net/wireless/ath/ath11k/coredump.h |  71 ++++++++++++
 drivers/net/wireless/ath/ath11k/dp.c       |  23 ++--
 drivers/net/wireless/ath/ath11k/dp.h       |   5 +-
 drivers/net/wireless/ath/ath11k/dp_tx.c    |  14 +--
 drivers/net/wireless/ath/ath11k/hal.c      |   4 +-
 drivers/net/wireless/ath/ath11k/hal.h      |   4 +-
 drivers/net/wireless/ath/ath11k/hal_tx.c   |   4 +-
 drivers/net/wireless/ath/ath11k/hal_tx.h   |   2 +
 drivers/net/wireless/ath/ath11k/hw.c       | 113 ++++++++++++++++++-
 drivers/net/wireless/ath/ath11k/hw.h       |  17 ++-
 drivers/net/wireless/ath/ath11k/mac.c      |  28 ++++-
 drivers/net/wireless/ath/ath11k/pci_cmn.c  |   4 +-
 drivers/net/wireless/ath/ath11k/qmi.c      |  47 +++++++-
 drivers/net/wireless/ath/ath11k/qmi.h      |  12 ++-
 drivers/net/wireless/ath/ath11k/thermal.c  |  12 +++
 22 files changed, 685 insertions(+), 71 deletions(-)
 create mode 100644 drivers/net/wireless/ath/ath11k/coredump.c
 create mode 100644 drivers/net/wireless/ath/ath11k/coredump.h

-- 
2.7.4

