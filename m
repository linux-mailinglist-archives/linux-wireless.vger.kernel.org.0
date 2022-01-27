Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8343549DA1E
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Jan 2022 06:25:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236131AbiA0FZY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Jan 2022 00:25:24 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:1083 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231364AbiA0FZW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Jan 2022 00:25:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1643261122; x=1674797122;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=1jFvZWQjavY+CPDhnHeG5LR9GlHQDdSOlwVOgyyZ/jk=;
  b=JVWBhl4M4lGAniTxlpCevdV3XHkpKG8CX5gAhnbBGuKn5pwSlLpg46nT
   TmSdN8nCnbI0LECgLLzuoTehPEyAVDXqDf/B73HYnniw+9BA6PAKJ4TWP
   h+4yEA3zL7XHv8ze4XCL8y7exOVGc+iO/hofSMnyb0/2qt0zD9Z/yhpdy
   Y=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 26 Jan 2022 21:25:21 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 21:25:21 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 26 Jan 2022 21:25:20 -0800
Received: from mpubbise-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 26 Jan 2022 21:25:18 -0800
From:   Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Subject: [PATCH 0/2] Add WoW support for WCN6750
Date:   Thu, 27 Jan 2022 10:54:51 +0530
Message-ID: <1643261093-12400-1-git-send-email-quic_mpubbise@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add WoW support for WCN6750.

Manikanta Pubbisetty (2):
  ath11k: Add WoW support for WCN6750
  dt: bindings: net: add bindings to add WoW support for WCN6750
---
Note: This series is dependent on Carl's series adding WoW support
      and another series adding support for WCN6750 in ATH11K.
      https://patchwork.kernel.org/project/linux-wireless/list/?series=606880
      https://patchwork.kernel.org/project/linux-wireless/list/?series=605793

 .../bindings/net/wireless/qcom,ath11k.yaml         |  17 +++
 drivers/net/wireless/ath/ath11k/ahb.c              | 120 ++++++++++++++++++++-
 drivers/net/wireless/ath/ath11k/ahb.h              |  15 ++-
 drivers/net/wireless/ath/ath11k/core.c             |   9 +-
 drivers/net/wireless/ath/ath11k/hw.h               |   3 +-
 drivers/net/wireless/ath/ath11k/pci_cmn.c          |  34 +++++-
 drivers/net/wireless/ath/ath11k/pci_cmn.h          |   6 +-
 drivers/net/wireless/ath/ath11k/wow.c              |   8 ++
 8 files changed, 205 insertions(+), 7 deletions(-)

-- 
2.7.4

