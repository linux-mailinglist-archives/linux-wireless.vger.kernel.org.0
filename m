Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26186CDDAC
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Oct 2019 10:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727278AbfJGItp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 7 Oct 2019 04:49:45 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:49538 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbfJGIto (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 7 Oct 2019 04:49:44 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x978nAC5178940;
        Mon, 7 Oct 2019 08:49:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2019-08-05;
 bh=chit8EzPB6oj9TLSzZOnkjtb0GRZV9OhiCx1X86A93U=;
 b=UDosYBAw5XJpWthZvi8Q2i2i7DToFddUD/J2yqO0XptwquqgtJnQ0JY0ZhwrcY7e4AB1
 THLHbNoxSrey9/qRsO/KpdeIxg24lVnY/maTOBOlHj7my/FFCS0YO/QK/wnW8YZW8wFg
 9v9nOAE7VJXlRWDrAy/uyCcE6vTc7fknFJtxAbalAu/8w/t5d86k/sw798sAwi6qch6g
 Xa++0PII5wN9aG0vimrfl3by12r9t9gIrVSeJgzJFYH9taaBjvVrRHQ9CHcNS8kBUcKX
 1FpBgVmon1cs+rlDJaina6/1GiAKXAA3G/dap4AFvDVjGuH8EOGVm9fJh9bmef3GTvle DA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2vek4q5dbn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Oct 2019 08:49:36 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x978nQb4168561;
        Mon, 7 Oct 2019 08:49:36 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2vf4ph4vxb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Oct 2019 08:49:36 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x978mBEd002935;
        Mon, 7 Oct 2019 08:48:12 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 07 Oct 2019 01:48:11 -0700
Date:   Mon, 7 Oct 2019 11:48:05 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Yan-Hsuan Chuang <yhchuang@realtek.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>, linux-wireless@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] rtw88: Fix an error message
Message-ID: <20191007084805.GA3865@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9402 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910070092
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9402 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910070092
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The WARN_ON() macro doesn't take an error message, the argument is a
condition so this won't display the warning message.

Fixes: 27e117e4b01b ("rtw88: add deep power save support")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/net/wireless/realtek/rtw88/ps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw88/ps.c b/drivers/net/wireless/realtek/rtw88/ps.c
index 83db6cf6a219..228309b411ec 100644
--- a/drivers/net/wireless/realtek/rtw88/ps.c
+++ b/drivers/net/wireless/realtek/rtw88/ps.c
@@ -108,7 +108,7 @@ void rtw_power_mode_change(struct rtw_dev *rtwdev, bool enter)
 		 * read/write. It should be treated as fatal error and
 		 * requires an entire analysis about the firmware/hardware
 		 */
-		WARN_ON("Hardware power state locked\n");
+		WARN(1, "Hardware power state locked\n");
 	}
 }
 EXPORT_SYMBOL(rtw_power_mode_change);
-- 
2.20.1

