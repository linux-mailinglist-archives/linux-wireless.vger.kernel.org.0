Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99E9130A798
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Feb 2021 13:28:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbhBAM1a (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 1 Feb 2021 07:27:30 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:52370 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbhBAM10 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 1 Feb 2021 07:27:26 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 111CE8J2173357;
        Mon, 1 Feb 2021 12:26:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=Drq82AAAZybV+JfLoh1I4PB5deHmrlfF6kc31xE4YQ4=;
 b=fykI8TT8vGGXGX5EZWEiyspa/Gf7gOxE2kOHblTBsGpbzT0i5M39XUKLz3kmssSs2sby
 iiZX9LZv1f2CxqbCwNqw3xEL3oEAOf2ETrmzcGTHviXfKV+Vag1B5nd+Cf9XrarvI6zf
 mrpcxC+Z9W4O/J1ebOJA0SIjW8OqC1pZlXVZsSFdBDuBKv+9RjysQ0hN9AXCV4TOuczN
 SvWdYgBS6cUJDQs2ESW+BwB6QDt4dTRt9e9mUTUfgN8qLRj7pAlTysMYTS4NbJYjYvYS
 /IhAG4xQ4Amz98Yj+VMTEGcysM7YEhmHOmQEZ9AZ+StuHT007j2GzuEiJvtI9RjuLIbW zQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 36cxvqvyt6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Feb 2021 12:26:36 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 111CA7F1146790;
        Mon, 1 Feb 2021 12:24:34 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 36dh7pn35n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Feb 2021 12:24:34 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 111COXa4012862;
        Mon, 1 Feb 2021 12:24:33 GMT
Received: from mwanda (/10.175.186.133)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 01 Feb 2021 04:24:33 -0800
Date:   Mon, 1 Feb 2021 15:24:27 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Carl Huang <cjhuang@codeaurora.org>, ath11k@lists.infradead.org,
        linux-wireless@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] ath11k: fix a locking bug in ath11k_mac_op_start()
Message-ID: <YBfy+zc3XkiyIe6t@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9881 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 phishscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102010064
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9881 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 mlxscore=0 priorityscore=1501 spamscore=0 impostorscore=0 clxscore=1015
 suspectscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102010064
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This error path leads to a Smatch warning:

    drivers/net/wireless/ath/ath11k/mac.c:4269 ath11k_mac_op_start()
    error: double unlocked '&ar->conf_mutex' (orig line 4251)

We're not holding the lock when we do the "goto err;" so it leads to a
double unlock.  We should hold the lock because the error path sets
"ar->state" so the right fix is to take the lock before doing the goto.

Fixes: c83c500b55b6 ("ath11k: enable idle power save mode")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/net/wireless/ath/ath11k/mac.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index c1608f64ea95..12e981e9e3d7 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -4259,6 +4259,7 @@ static int ath11k_mac_op_start(struct ieee80211_hw *hw)
 						1, pdev->pdev_id);
 		if (ret) {
 			ath11k_err(ab, "failed to enable idle ps: %d\n", ret);
+			mutex_lock(&ar->conf_mutex);
 			goto err;
 		}
 	}
-- 
2.29.2

