Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD3C84558A0
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Nov 2021 11:07:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245568AbhKRKKS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 18 Nov 2021 05:10:18 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:63888 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244453AbhKRKJO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 18 Nov 2021 05:09:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1637229974; x=1668765974;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=fesCBQVeE61jL1NpbtR+zGFtftyBldNp7hqjXZl6euM=;
  b=Johezxn6QgdL//T20vZgVS06VeQPbWgIgx9rAWLC9kcgDTdPqv2Vub7h
   /3umm540x4XZNJCK0Wy9p0ZgF8FA4ZwU1AyeThv2oi+c9Bdm7UXeOtRL/
   CkNBT+S8m4jdh7iP8ePrREfz1oIekCeiB54QnLc2FhD1b3+BfdyOoEGzE
   A=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 18 Nov 2021 02:06:12 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2021 02:06:12 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 18 Nov 2021 02:06:12 -0800
Received: from wgong-HP3-Z230-SFF-Workstation.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 18 Nov 2021 02:06:10 -0800
From:   Wen Gong <quic_wgong@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <quic_wgong@quicinc.com>
Subject: [PATCH v2 0/2] ath11k: add 11d scan offload support for QCA6390/WCN6855
Date:   Thu, 18 Nov 2021 05:05:55 -0500
Message-ID: <20211118100557.9029-1-quic_wgong@quicinc.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

v2:
   1. rebased to latest ath.git master ath-202111170737
   2. add "ath11k: add configure country code for QCA6390 and WCN6855", it is needed for 
      patch "ath11k: add 11d scan offload support"

Wen Gong (2):
  ath11k: add configure country code for QCA6390 and WCN6855
  ath11k: add 11d scan offload support

 drivers/net/wireless/ath/ath11k/core.c |  30 +++++
 drivers/net/wireless/ath/ath11k/core.h |   9 ++
 drivers/net/wireless/ath/ath11k/mac.c  | 162 ++++++++++++++++++++++++-
 drivers/net/wireless/ath/ath11k/mac.h  |   7 ++
 drivers/net/wireless/ath/ath11k/pci.c  |   1 +
 drivers/net/wireless/ath/ath11k/reg.c  |  15 +++
 drivers/net/wireless/ath/ath11k/wmi.c  | 145 ++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/wmi.h  |  39 ++++++
 8 files changed, 407 insertions(+), 1 deletion(-)


base-commit: 63ec871bc50a306aac550e2d85f697ca2d5f5deb
-- 
2.31.1

