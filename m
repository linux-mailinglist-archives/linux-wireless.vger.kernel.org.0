Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9EDA4612D8
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Nov 2021 11:48:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353715AbhK2Kv2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Nov 2021 05:51:28 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:39875 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353769AbhK2Kt2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Nov 2021 05:49:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1638182771; x=1669718771;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=xQfZW3W2SqB9B/GUUGAEVORZfsPc106MbuUl7YPBwH4=;
  b=Nc9VgAL223HbZZe8pkGj+1t/l7hSBFppiScBgpqJzlUaeJspOob79JoG
   L5oqRb0hI/+hTOqAy2ZcYrglsiQo82yuM7s8BkIqfEO/a8H09kuqKClgF
   nnH8QzFSvaWjN2B+Ltj+ghOGsCzK7dTuRkiu8EEqSn55Ybr95UTCb3IW+
   8=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 29 Nov 2021 02:46:10 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2021 02:46:10 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Mon, 29 Nov 2021 02:46:10 -0800
Received: from seevalam-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Mon, 29 Nov 2021 02:46:08 -0800
From:   Seevalamuthu Mariappan <quic_seevalam@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Seevalamuthu Mariappan <quic_seevalam@quicinc.com>
Subject: [PATCH] ath11k: Fix QMI file type enum value
Date:   Mon, 29 Nov 2021 16:15:54 +0530
Message-ID: <1638182754-18408-1-git-send-email-quic_seevalam@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

bdf_type for caldata in QMI_WLANFW_BDF_DOWNLOAD_REQ_V01 is wrongly
sent as 1. But, expected bdf_type value for caldata and EEPROM is 2 and 3
respectively. It leads to firmware crash. Fix ath11k_qmi_file_type enum
values.

Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.5.0.1-01100-QCAHKSWPL_SILICONZ-1
Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.4.0.1-00192-QCAHKSWPL_SILICONZ-1

Fixes: 336e7b53c82f ("ath11k: clean up BDF download functions")
Signed-off-by: Seevalamuthu Mariappan <quic_seevalam@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/qmi.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/qmi.h b/drivers/net/wireless/ath/ath11k/qmi.h
index 3bb0f9e..d9e95b7 100644
--- a/drivers/net/wireless/ath/ath11k/qmi.h
+++ b/drivers/net/wireless/ath/ath11k/qmi.h
@@ -41,7 +41,7 @@ struct ath11k_base;
 
 enum ath11k_qmi_file_type {
 	ATH11K_QMI_FILE_TYPE_BDF_GOLDEN,
-	ATH11K_QMI_FILE_TYPE_CALDATA,
+	ATH11K_QMI_FILE_TYPE_CALDATA = 2,
 	ATH11K_QMI_FILE_TYPE_EEPROM,
 	ATH11K_QMI_MAX_FILE_TYPE,
 };
-- 
2.7.4

