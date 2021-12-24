Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0374347ED7E
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Dec 2021 09:53:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352093AbhLXIxO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Dec 2021 03:53:14 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:30559 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1352098AbhLXIxM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Dec 2021 03:53:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1640335992; x=1671871992;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=70rDZT4Uy7vqOfDZX8NnydP0tdJSsNn2wsLJTTYUt3g=;
  b=ZH682U4+lkBrCXuFl0dZ8xZoN2uUj/JPLyHHhAn4MgyZKJOylvGVc0Md
   t0/HyN9mrroOioyZHNQbzqyEwo0AMmiId2ETahLFKSUjw2J0QNPVObQNJ
   oSvKusBl3cQGiow9neq4ELTT6DTqpIH7ffOUOneGyVJEdkGMPaqBqxlN3
   I=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 24 Dec 2021 00:53:12 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Dec 2021 00:53:11 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Fri, 24 Dec 2021 00:53:11 -0800
Received: from wgong-HP3-Z230-SFF-Workstation.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Fri, 24 Dec 2021 00:53:09 -0800
From:   Wen Gong <quic_wgong@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <quic_wgong@quicinc.com>
Subject: [PATCH v2 12/15] ath11k: add WMI_TLV_SERVICE_EXT_TPC_REG_SUPPORT service bit
Date:   Fri, 24 Dec 2021 03:52:33 -0500
Message-ID: <20211224085236.9064-13-quic_wgong@quicinc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211224085236.9064-1-quic_wgong@quicinc.com>
References: <20211224085236.9064-1-quic_wgong@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Firmware advertises support for SERVICE_EXT_TPC_REG via a WMI service bit.
Add the definition of this service bit so that a subsequent patch can
check whether or not firmware supports this service.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1

Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/wmi.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/wmi.h b/drivers/net/wireless/ath/ath11k/wmi.h
index 2c50dc8c3834..d285d18e99a8 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.h
+++ b/drivers/net/wireless/ath/ath11k/wmi.h
@@ -2090,6 +2090,8 @@ enum wmi_tlv_service {
 	/* The second 128 bits */
 	WMI_MAX_EXT_SERVICE = 256,
 
+	WMI_TLV_SERVICE_EXT_TPC_REG_SUPPORT = 280,
+
 	WMI_TLV_SERVICE_REG_CC_EXT_EVENT_SUPPORT = 281,
 
 	/* The third 128 bits */
-- 
2.31.1

