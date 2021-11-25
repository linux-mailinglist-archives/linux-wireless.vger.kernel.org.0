Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2580945D66C
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Nov 2021 09:46:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346771AbhKYItp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 25 Nov 2021 03:49:45 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:8321 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347485AbhKYIs1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 25 Nov 2021 03:48:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1637829917; x=1669365917;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=n7JTmABnHGbCDFRTgvk6w5xUhqfeJdFM3tMJsvJWUyk=;
  b=MQ04OI2uJL1aNDvrCWNn6TNUfRnntwvazEk+LA2vxR74woR7+bt7jy/j
   zpHKfKADLSDXqoGuA/DJ/J0jD5KONXHuIzQy3h5AqOfACxGRIz2km6oSR
   Ant5/NvI0orTWRhQS+q/OCZoE/mo1bE1TDBJ30lp9lX5MGoes+0410gP2
   I=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 25 Nov 2021 00:45:16 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2021 00:45:16 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 25 Nov 2021 00:45:16 -0800
Received: from wgong-HP3-Z230-SFF-Workstation.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 25 Nov 2021 00:45:14 -0800
From:   Wen Gong <quic_wgong@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <quic_wgong@quicinc.com>
Subject: [PATCH v3 0/2] ath11k: add handler for board-2.bin without variant and read SMBIOS
Date:   Thu, 25 Nov 2021 03:44:56 -0500
Message-ID: <20211125084458.16352-1-quic_wgong@quicinc.com>
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

 drivers/net/wireless/ath/ath11k/core.c | 93 ++++++++++++++++++++++++--
 drivers/net/wireless/ath/ath11k/core.h | 11 +++
 drivers/net/wireless/ath/ath11k/qmi.c  |  4 ++
 3 files changed, 104 insertions(+), 4 deletions(-)

-- 
2.31.1

