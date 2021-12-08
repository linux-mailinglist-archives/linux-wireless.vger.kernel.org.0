Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36DBA46CE59
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Dec 2021 08:23:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240647AbhLHH1O (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Dec 2021 02:27:14 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:19918 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240668AbhLHH1N (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Dec 2021 02:27:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1638948222; x=1670484222;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=aP4aYYc3sR8tigYFU19bF4Ce7DkGODqkL4I450FFV28=;
  b=OENbj6/hBE0zi0/NbjHq7WE5xqaxscNp91VGmcm6gbih5Dwv6CTFJH3O
   wTBW6pPrCC3KUwqRqSiZQ+2MOs8TeTIrIpAaVkgvD3VppgwV6YZwfuIlN
   MdwwaJoO+CAMAvblRtlo0rHZ6388sKYbHBtLcByjqxCkG/7/e9TldEJyw
   k=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 07 Dec 2021 23:23:42 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2021 23:23:42 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 7 Dec 2021 23:23:41 -0800
Received: from wgong-HP3-Z230-SFF-Workstation.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 7 Dec 2021 23:23:40 -0800
From:   Wen Gong <quic_wgong@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <quic_wgong@quicinc.com>
Subject: [PATCH v4 0/2] ath11k: add handler for board-2.bin without variant and read SMBIOS
Date:   Wed, 8 Dec 2021 02:23:25 -0500
Message-ID: <20211208072327.19719-1-quic_wgong@quicinc.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

v4: 
   1. add helper function ath11k_core_create_fallback_board_name()
   2. rebased to ath.git ath-202112071521

v3:
   1. add patch "ath11k: add fallback board name without variant while searching board-2.bin"
   2. reabsed to latest ath.git master ath-202111221436

v2: rebased to latest ath.git master ath-202111170737

When it does not have matched board name with variant in board-2.bin,
ath11k will fallback to search without variant.

Also read the variant from SMBIOS.

Wen Gong (2):
  ath11k: add fallback board name without variant while searching
    board-2.bin
  ath11k: add read variant from SMBIOS for download board data

 drivers/net/wireless/ath/ath11k/core.c | 107 +++++++++++++++++++++++--
 drivers/net/wireless/ath/ath11k/core.h |  11 +++
 drivers/net/wireless/ath/ath11k/qmi.c  |   4 +
 3 files changed, 117 insertions(+), 5 deletions(-)


base-commit: 4f4f8aee394b73abf5e5f98c63187fdbf1d627f0
-- 
2.31.1

