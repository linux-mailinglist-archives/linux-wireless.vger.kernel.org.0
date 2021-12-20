Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D934247A522
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Dec 2021 07:50:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237608AbhLTGuh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Dec 2021 01:50:37 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:7304 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234245AbhLTGuh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Dec 2021 01:50:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1639983037; x=1671519037;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9b4fjRJttUTuRZlt/18dgyodwSFqYIP4t+yCyXJAPa4=;
  b=IymZKkEB8AJOe6r8WGqYcPvhrbo9WzEeHmipQUmG07rXkjCRPEoElMPv
   PeT+VM+SFcaKkRTQh77ReNr0B4NamdDceRWvpR8Jde177pCtW2EVl2gT7
   H3Ch0iqfwBFQIymTrnY2x55FAnOTkMzbCbsnQm7/5nqqMfr39sN9Cr8w4
   0=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 19 Dec 2021 22:50:36 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2021 22:50:36 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Sun, 19 Dec 2021 22:50:36 -0800
Received: from wgong-HP3-Z230-SFF-Workstation.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Sun, 19 Dec 2021 22:50:34 -0800
From:   Wen Gong <quic_wgong@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <quic_wgong@quicinc.com>
Subject: [PATCH v5 0/2] ath11k: add handler for board-2.bin without variant and read SMBIOS
Date:   Mon, 20 Dec 2021 01:48:27 -0500
Message-ID: <20211220064829.17557-1-quic_wgong@quicinc.com>
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

v5:
   1. rebased to ath.git ath-202112161538
   2. fix warning "failed to fetch board data for bus=pci,qmi-chip-id=0,qmi-board-id=255,variant=DE_1901 from ath11k/QCA6390/hw2.0/board-2.bin"

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

 drivers/net/wireless/ath/ath11k/core.c | 109 +++++++++++++++++++++++--
 drivers/net/wireless/ath/ath11k/core.h |  11 +++
 drivers/net/wireless/ath/ath11k/qmi.c  |   4 +
 3 files changed, 118 insertions(+), 6 deletions(-)


base-commit: 12018ad8603a598d773e2cae12542a1981c94886
-- 
2.31.1

