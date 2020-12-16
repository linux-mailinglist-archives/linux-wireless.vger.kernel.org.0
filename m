Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F42B2DBCBB
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Dec 2020 09:32:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725988AbgLPIcO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 16 Dec 2020 03:32:14 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:51284 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725951AbgLPIcO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 16 Dec 2020 03:32:14 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BG8UIDc095718;
        Wed, 16 Dec 2020 08:31:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=JzSZXbinXV21Z8vjxrONRNP3I5CvUYvCri5fHXXzL00=;
 b=mBrTG8U9jvDP6wsyn5A09A5bQB/CCS4kwRnRYJxTY5uXHeqVQHf2XwjXrzgIBUrwT6Iu
 HBcs8CgacPezSmuatOzPiXmm8uvIvuN6RMeDHBHb5TCuVbGRUr+ouancxrirpPAawmQo
 FCI1+0ALkh3kpXPd6XlBAfMUFCp+4t6AS+Fz5Xx754QcV/5cd1UbfsQg59aYnB4L6yNp
 eFmQ6eQ5/nMmJFLhQ3JiTEkqahADf4v5Hmzq6XsIoYqN2v669KKJzJV3gg+NHFefkdjO
 YmPnMkKB1DB+dhJ72LYBUyhdfnOLrq+FMNkD2yO+mf2EroNA3sCIKxqOBIep1/gFs4kX pA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 35cn9reugv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 16 Dec 2020 08:31:28 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BG8UC5H171916;
        Wed, 16 Dec 2020 08:31:28 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 35d7sxgfyh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Dec 2020 08:31:28 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0BG8VQA4000444;
        Wed, 16 Dec 2020 08:31:26 GMT
Received: from mwanda (/10.175.200.55)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 16 Dec 2020 00:31:26 -0800
Date:   Wed, 16 Dec 2020 11:31:19 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Kalle Valo <kvalo@codeaurora.org>,
        Carl Huang <cjhuang@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH 1/2] ath11k: Fix error code in ath11k_core_suspend()
Message-ID: <X9nF17L2/EKOSbn/@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9836 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012160054
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9836 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 impostorscore=0 lowpriorityscore=0 clxscore=1011 spamscore=0
 malwarescore=0 priorityscore=1501 phishscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012160054
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The "if (!ret)" condition is inverted and it should be "if (ret)".  It
means that we return success when we had intended to return an error
code.

Fixes: d1b0c33850d2 ("ath11k: implement suspend for QCA6390 PCI devices")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/net/wireless/ath/ath11k/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index b97c38b9a270..350b7913622c 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -185,7 +185,7 @@ int ath11k_core_suspend(struct ath11k_base *ab)
 	ath11k_hif_ce_irq_disable(ab);
 
 	ret = ath11k_hif_suspend(ab);
-	if (!ret) {
+	if (ret) {
 		ath11k_warn(ab, "failed to suspend hif: %d\n", ret);
 		return ret;
 	}
-- 
2.29.2

