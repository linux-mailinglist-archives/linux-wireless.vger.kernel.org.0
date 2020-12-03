Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 036762CD194
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Dec 2020 09:47:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388505AbgLCIoe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 3 Dec 2020 03:44:34 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:58008 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387572AbgLCIod (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 3 Dec 2020 03:44:33 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B38ZAEe104390;
        Thu, 3 Dec 2020 08:43:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=Rv4NUpXxbZ3K7b++6pr1dHddciFpGxEvAqMNzShnc/U=;
 b=z/U8ZhkfaIroac3b+0lKDRBET1yleRhKSMd3H2gyerpq7gZGj61ck4Ti985Fjgj798Su
 i8nH3Bu+ZX+KgCf8EqO1bK3UlUewtiIkGaHac9MmhCH990u0NSyLC9qb7w9bCSRwQIUK
 R5cEIBVZrpYYbX/S3tlaAc3tAQvLPaR21lQZuYFoH3o/04T5aimXk7V2t9ACWdGSithg
 k+pVMzfWcDwT0uQCcPvR9YEU9FwsWmXKF1CT81Eh0KimacP1Z27z0V3uGFglym4AdrPI
 YIo5Vu7kqeYqhKvf3von+OZGUPihGL4I4oT0+ZiuoMtUkXeqMIpjnmjbk4t/ioDP9cNg Ew== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 353c2b4ny1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 03 Dec 2020 08:43:46 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B38dQOX173054;
        Thu, 3 Dec 2020 08:43:45 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 3540g1a9fe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Dec 2020 08:43:45 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0B38hiwV025930;
        Thu, 3 Dec 2020 08:43:44 GMT
Received: from mwanda (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 03 Dec 2020 00:43:43 -0800
Date:   Thu, 3 Dec 2020 11:43:37 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Yan-Hsuan Chuang <tony0620emma@gmail.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        Stanislaw Gruszka <sgruszka@redhat.com>,
        Brian Norris <briannorris@chromium.org>,
        linux-wireless@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH net] rtw88: debug: Fix uninitialized memory in debugfs code
Message-ID: <X8ilOfVz3pf0T5ec@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9823 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 adultscore=0 mlxscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012030053
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9823 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 lowpriorityscore=0
 clxscore=1011 bulkscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 spamscore=0 adultscore=0 mlxscore=0 priorityscore=1501 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012030052
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This code does not ensure that the whole buffer is initialized and none
of the callers check for errors so potentially none of the buffer is
initialized.  Add a memset to eliminate this bug.

Fixes: e3037485c68e ("rtw88: new Realtek 802.11ac driver")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/net/wireless/realtek/rtw88/debug.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/debug.c b/drivers/net/wireless/realtek/rtw88/debug.c
index 5974a8ef8b34..12efc23bbfcb 100644
--- a/drivers/net/wireless/realtek/rtw88/debug.c
+++ b/drivers/net/wireless/realtek/rtw88/debug.c
@@ -147,6 +147,8 @@ static int rtw_debugfs_copy_from_user(char tmp[], int size,
 {
 	int tmp_len;
 
+	memset(tmp, 0, size);
+
 	if (count < num)
 		return -EFAULT;
 
-- 
2.29.2

