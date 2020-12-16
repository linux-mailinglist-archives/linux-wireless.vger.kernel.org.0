Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02C512DBCBD
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Dec 2020 09:34:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726026AbgLPIdF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 16 Dec 2020 03:33:05 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:45322 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725951AbgLPIdF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 16 Dec 2020 03:33:05 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BG8U74P030574;
        Wed, 16 Dec 2020 08:32:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type : in-reply-to;
 s=corp-2020-01-29; bh=63OGAu9VQeRjYwlw6Psn5yLKKjzSQO8Xr+txyy5uuBM=;
 b=t0fRkD/LE86EgcnP3hWeCRERpUMkrfTTkuHwfRfLFopnNGIjndo8UmqaV3a5AWR0nLde
 iEWBSLRpvtyazU8zQoYb8LXnE/sJETz/7ssQDoxiP6jasSN6Kt2xJqdf5IXD9gAJ6oPS
 fNrjL/84x3gKBHXb2oDh4ImhASfns0WYB0NJMSEK4WIaBCaj4u/TW7HNHRQSj2Lo/bWd
 2PbmJrPNc4DopytPhyDoiMCCLuAxdf3KXQRSYx0tNbADESX97YjUFJaPP47bc60xMzDf
 ecLwd0NT4fRm11I7oDTWyScQAeCwUHIzNfIiJfbTd7lACr+gKP+jBR+mU1A91Khr8BUa Gw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 35cntm6t7a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 16 Dec 2020 08:32:20 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BG8VELZ067765;
        Wed, 16 Dec 2020 08:32:20 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 35d7ep83m7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Dec 2020 08:32:20 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0BG8WI4o000719;
        Wed, 16 Dec 2020 08:32:18 GMT
Received: from mwanda (/10.175.200.55)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 16 Dec 2020 00:32:18 -0800
Date:   Wed, 16 Dec 2020 11:32:12 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Kalle Valo <kvalo@codeaurora.org>,
        Carl Huang <cjhuang@codeaurora.org>
Cc:     Carl Huang <cjhuang@codeaurora.org>, ath11k@lists.infradead.org,
        linux-wireless@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH 2/2] ath11k: Fix ath11k_pci_fix_l1ss()
Message-ID: <X9nGDHiTh+Z+asDy@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X9nF17L2/EKOSbn/@mwanda>
X-Mailer: git-send-email haha only kidding
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9836 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 bulkscore=0
 suspectscore=0 adultscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012160054
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9836 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 mlxscore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 impostorscore=0 priorityscore=1501 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012160054
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

All these conditions are reversed so presumably most of the function is
dead code.

Fixes: 0699940755e9 ("ath11k: pci: fix L1ss clock unstable problem")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/net/wireless/ath/ath11k/pci.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless/ath/ath11k/pci.c
index 857647aa57c8..9f9a824a4c2d 100644
--- a/drivers/net/wireless/ath/ath11k/pci.c
+++ b/drivers/net/wireless/ath/ath11k/pci.c
@@ -274,7 +274,7 @@ static int ath11k_pci_fix_l1ss(struct ath11k_base *ab)
 				      PCIE_QSERDES_COM_SYSCLK_EN_SEL_REG,
 				      PCIE_QSERDES_COM_SYSCLK_EN_SEL_VAL,
 				      PCIE_QSERDES_COM_SYSCLK_EN_SEL_MSK);
-	if (!ret) {
+	if (ret) {
 		ath11k_warn(ab, "failed to set sysclk: %d\n", ret);
 		return ret;
 	}
@@ -283,7 +283,7 @@ static int ath11k_pci_fix_l1ss(struct ath11k_base *ab)
 				      PCIE_USB3_PCS_MISC_OSC_DTCT_CONFIG1_REG,
 				      PCIE_USB3_PCS_MISC_OSC_DTCT_CONFIG1_VAL,
 				      PCIE_USB3_PCS_MISC_OSC_DTCT_CONFIG_MSK);
-	if (!ret) {
+	if (ret) {
 		ath11k_warn(ab, "failed to set dtct config1 error: %d\n", ret);
 		return ret;
 	}
@@ -292,7 +292,7 @@ static int ath11k_pci_fix_l1ss(struct ath11k_base *ab)
 				      PCIE_USB3_PCS_MISC_OSC_DTCT_CONFIG2_REG,
 				      PCIE_USB3_PCS_MISC_OSC_DTCT_CONFIG2_VAL,
 				      PCIE_USB3_PCS_MISC_OSC_DTCT_CONFIG_MSK);
-	if (!ret) {
+	if (ret) {
 		ath11k_warn(ab, "failed to set dtct config2: %d\n", ret);
 		return ret;
 	}
@@ -301,7 +301,7 @@ static int ath11k_pci_fix_l1ss(struct ath11k_base *ab)
 				      PCIE_USB3_PCS_MISC_OSC_DTCT_CONFIG4_REG,
 				      PCIE_USB3_PCS_MISC_OSC_DTCT_CONFIG4_VAL,
 				      PCIE_USB3_PCS_MISC_OSC_DTCT_CONFIG_MSK);
-	if (!ret) {
+	if (ret) {
 		ath11k_warn(ab, "failed to set dtct config4: %d\n", ret);
 		return ret;
 	}
-- 
2.29.2

