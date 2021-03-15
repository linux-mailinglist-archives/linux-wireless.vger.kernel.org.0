Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7F7233AE9C
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Mar 2021 10:24:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbhCOJYS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 15 Mar 2021 05:24:18 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:47528 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbhCOJX6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 15 Mar 2021 05:23:58 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12F98uDI029713;
        Mon, 15 Mar 2021 09:23:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=s9DhrO9uH8gUV9s+eQAL8ndad6+WRFuEKy/GLRVpLz8=;
 b=VASFXSXih63jUvTq0rnxe2gTefl0anjOLM/NK0zWhN/cYqSEF35pBMgdpE/71Z834i7r
 JgmbaczBWR2pnNPEoq8HdbO35hbDQAHJsD8BzsjxXMXcjd5fi926l+TZFW/JA/FkyLR8
 +Pjqdegyh1u1S0Bod2uUpnv1Ayw4KxPtWJ5y911+00RUxFB15SRmdBF17K55pAi7Ymj4
 qba33q63UiDcqyLDOC9rpEnSWfh1wq4Np4tyW+Dfx/J4z/16/M3FxQcFVWHeNPjsCsDu
 h0U+yksLM7yC7V81gBD48iWx8jk4Wi+mx484lk7R9jGq+f8rElbzj56jYzdrmSxwFhV1 Iw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 378nbm34d2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Mar 2021 09:23:49 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12F99iIB182825;
        Mon, 15 Mar 2021 09:23:47 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 3797axdxar-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Mar 2021 09:23:47 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 12F9NjkI023768;
        Mon, 15 Mar 2021 09:23:45 GMT
Received: from mwanda (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 15 Mar 2021 02:23:45 -0700
Date:   Mon, 15 Mar 2021 12:23:37 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Yan-Hsuan Chuang <tony0620emma@gmail.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        Tzu-En Huang <tehuang@realtek.com>,
        linux-wireless@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH v2] rtw88: Fix an error code in rtw_debugfs_set_rsvd_page()
Message-ID: <YE8nmatMDBDDWkjq@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9923 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 bulkscore=0
 malwarescore=0 adultscore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103150064
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9923 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 impostorscore=0
 malwarescore=0 adultscore=0 mlxscore=0 clxscore=1015 mlxlogscore=999
 lowpriorityscore=0 phishscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103150064
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The sscanf() function returns the number of matches (0 or 1 in this
case).  It doesn't return error codes.  We should return -EINVAL if the
string is invalid

Fixes: c376c1fc87b7 ("rtw88: add h2c command in debugfs")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
v2: Style change.  Keep "num" variable.

 drivers/net/wireless/realtek/rtw88/debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw88/debug.c b/drivers/net/wireless/realtek/rtw88/debug.c
index 948cb79050ea..e7d51ac9b689 100644
--- a/drivers/net/wireless/realtek/rtw88/debug.c
+++ b/drivers/net/wireless/realtek/rtw88/debug.c
@@ -270,7 +270,7 @@ static ssize_t rtw_debugfs_set_rsvd_page(struct file *filp,
 
 	if (num != 2) {
 		rtw_warn(rtwdev, "invalid arguments\n");
-		return num;
+		return -EINVAL;
 	}
 
 	debugfs_priv->rsvd_page.page_offset = offset;
-- 
2.30.1

