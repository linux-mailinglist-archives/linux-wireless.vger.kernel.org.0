Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DDB031D121
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Feb 2021 20:45:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbhBPTpH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 16 Feb 2021 14:45:07 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:36136 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbhBPTpE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 16 Feb 2021 14:45:04 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11GJU6Dc103377;
        Tue, 16 Feb 2021 19:43:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=/RzkUbQssNrChoJbsFzMyOJqLi8svV08ZdR02bW1EGo=;
 b=HmY8ctUv9oVdHe+i/lUxYIWtl/5eeeKkX7uxMS+ha5oUY4eG0p6Avzf2QMhx+CApW0ul
 vko4y+64K7kO+HrlxVscT+SJhxccq6OHuVtI2MELAM0w2UosaQO7r+lJdXebi3hVlC9l
 2n1uFhKTcjZvTgEqVsF/952BDS8iQ1uiesD0zFisxA/C2pQK+wec2Ussqe3YhEHxj8B8
 OQLQTVnpCmlp7F1yIzuEA4ViPASXhDBJQPf3fnIluwBxlOCwOLmmgNrz4NOjQFrviOYE
 qaDKndGKUitmJoruLwqM2M7N3x8bYhYa2o+SkFV8cwXdzVCHbFRVEo2a9oeiDnhYzleM wQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 36p7dng1d9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Feb 2021 19:43:58 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11GJVW1u145849;
        Tue, 16 Feb 2021 19:43:57 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 36prhryfdj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Feb 2021 19:43:57 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 11GJhsBV009394;
        Tue, 16 Feb 2021 19:43:55 GMT
Received: from mwanda (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 16 Feb 2021 11:43:53 -0800
Date:   Tue, 16 Feb 2021 22:43:43 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Yan-Hsuan Chuang <tony0620emma@gmail.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        Tzu-En Huang <tehuang@realtek.com>,
        linux-wireless@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] rtw88: Fix an error code in rtw_debugfs_set_rsvd_page()
Message-ID: <YCwgb/4F4Y+tyE56@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9897 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0 mlxscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102160162
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9897 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 spamscore=0 adultscore=0 clxscore=1011 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102160162
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The sscanf() function returns either 0 or 1 here.  It doesn't return
error codes.  We should return -EINVAL if the string is invalid.

Fixes: c376c1fc87b7 ("rtw88: add h2c command in debugfs")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/net/wireless/realtek/rtw88/debug.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/debug.c b/drivers/net/wireless/realtek/rtw88/debug.c
index 948cb79050ea..99be7fcb5d71 100644
--- a/drivers/net/wireless/realtek/rtw88/debug.c
+++ b/drivers/net/wireless/realtek/rtw88/debug.c
@@ -262,15 +262,12 @@ static ssize_t rtw_debugfs_set_rsvd_page(struct file *filp,
 	struct rtw_dev *rtwdev = debugfs_priv->rtwdev;
 	char tmp[32 + 1];
 	u32 offset, page_num;
-	int num;
 
 	rtw_debugfs_copy_from_user(tmp, sizeof(tmp), buffer, count, 2);
 
-	num = sscanf(tmp, "%d %d", &offset, &page_num);
-
-	if (num != 2) {
+	if (sscanf(tmp, "%d %d", &offset, &page_num) != 2) {
 		rtw_warn(rtwdev, "invalid arguments\n");
-		return num;
+		return -EINVAL;
 	}
 
 	debugfs_priv->rsvd_page.page_offset = offset;
-- 
2.30.0

