Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4307530BD3B
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Feb 2021 12:36:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231375AbhBBLe6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 2 Feb 2021 06:34:58 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:39762 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231312AbhBBLcl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 2 Feb 2021 06:32:41 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 112BOwGw190982;
        Tue, 2 Feb 2021 11:31:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=mIAj0+BtQpwVNeD3mExb1e30dz1P2CVY0gpH20dJPwM=;
 b=Dl+OduYa/ToMiitDUCbixlER3h2NJcJ6WerwpbuxJaSSf7fAcN1ldv0dSIYcclAgDn92
 FSWG28NHsXdfUDEa3z4NFHQUQXhR/tDN+Dj5DQqrm64A7usugUyPh1qbuo1A3t4tGCgw
 7oLQyDmKf2yADaQc3WRCqMacmizIEik8dPDf81nwIgXZvcJiu9gZqd+E/eqtK3FpM3PJ
 qGJWl+vvPWJFps3HnS/nsx/qb63Fikoi2b74Wid+YtMkSwl9knxlCEBBipp7pp/6xQYX
 QFmsGL0yFx+CV/k0SkFFUTqGaT1RX1G+aPaT+8UYfmSmhU00+hfXhhClRR7J9qUNxdIB yw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 36cydkt8x7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Feb 2021 11:31:49 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 112BUwI1059872;
        Tue, 2 Feb 2021 11:31:47 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 36dhby3rjq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Feb 2021 11:31:47 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 112BVjDM023682;
        Tue, 2 Feb 2021 11:31:46 GMT
Received: from mwanda (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 02 Feb 2021 03:31:45 -0800
Date:   Tue, 2 Feb 2021 14:31:38 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Kalle Valo <kvalo@codeaurora.org>, Peter Oh <peter.oh@eero.com>
Cc:     Carl Huang <cjhuang@codeaurora.org>, ath11k@lists.infradead.org,
        linux-wireless@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH v2] ath11k: fix a locking bug in ath11k_mac_op_start()
Message-ID: <YBk4GoeE+yc0wlJH@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9882 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 suspectscore=0
 spamscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102020080
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9882 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 clxscore=1011
 spamscore=0 lowpriorityscore=0 phishscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102020079
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This error path leads to a Smatch warning:

	drivers/net/wireless/ath/ath11k/mac.c:4269 ath11k_mac_op_start()
	error: double unlocked '&ar->conf_mutex' (orig line 4251)

We're not holding the lock when we do the "goto err;" so it leads to a
double unlock.  The fix is to hold the lock for a little longer.

Fixes: c83c500b55b6 ("ath11k: enable idle power save mode")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
v2: reviewers were concern that v1 was racy

 drivers/net/wireless/ath/ath11k/mac.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index c1608f64ea95..464d3425488b 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -4248,8 +4248,6 @@ static int ath11k_mac_op_start(struct ieee80211_hw *hw)
 	/* Configure the hash seed for hash based reo dest ring selection */
 	ath11k_wmi_pdev_lro_cfg(ar, ar->pdev->pdev_id);
 
-	mutex_unlock(&ar->conf_mutex);
-
 	rcu_assign_pointer(ab->pdevs_active[ar->pdev_idx],
 			   &ab->pdevs[ar->pdev_idx]);
 
@@ -4262,6 +4260,9 @@ static int ath11k_mac_op_start(struct ieee80211_hw *hw)
 			goto err;
 		}
 	}
+
+	mutex_unlock(&ar->conf_mutex);
+
 	return 0;
 
 err:
-- 
2.30.0

