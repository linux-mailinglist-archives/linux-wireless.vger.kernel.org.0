Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 190EA8D134
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Aug 2019 12:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbfHNKrQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 14 Aug 2019 06:47:16 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:35240 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbfHNKrQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 14 Aug 2019 06:47:16 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7EAiScZ106080;
        Wed, 14 Aug 2019 10:47:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2019-08-05;
 bh=eKra3x3RanWfd2QP38dZBJ+NM2qqte9TkMuz8A9fS+Y=;
 b=APnOxSlUsUU9UaMv9BSgc+qHqpPWqYH1d2pJXgHkv+gxkVELZMwOp4KR027rQ18i5ewG
 NyDXixkmOrQE7PXZFToDDloAocUP0CyQx31NJdZYgNP11hxxf1nqROG/i7/jZ7FdLwqA
 u45zNPO16Gs0LDjozamI43Dgg8TudvC0VClQ3btHTuervN4XEh8wAQbX8l27CQL6wsgS
 hH38y3srbG4cKkxjm4aILF2TaPEea/pJu79v8jVKDcPDjxOsoGmgI4DDa2jVCp4tCFls
 1MoMFW94qH52Sqs4lOjEWaJFxzW+8NHabZvFhH4KWhrctnEbUcn4M5ZtUAtYEWynulJE YA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2u9pjqkvge-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Aug 2019 10:47:09 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7EAkiad096175;
        Wed, 14 Aug 2019 10:47:08 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2ubwqt2j0v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Aug 2019 10:47:05 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x7EAkoOP025838;
        Wed, 14 Aug 2019 10:46:50 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 14 Aug 2019 03:46:49 -0700
Date:   Wed, 14 Aug 2019 13:46:42 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Yan-Hsuan Chuang <yhchuang@realtek.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>, linux-wireless@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] rtw88: Fix an error message
Message-ID: <20190814104642.GA14268@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9348 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908140111
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9348 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908140111
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The WARN_ON() macro takes a condition, not a warning message.  I've
changed this to use WARN() instead.

Fixes: 4136214f7c46 ("rtw88: add BT co-existence support")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/net/wireless/realtek/rtw88/coex.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw88/coex.c b/drivers/net/wireless/realtek/rtw88/coex.c
index 4577fceddc5e..13701ec40302 100644
--- a/drivers/net/wireless/realtek/rtw88/coex.c
+++ b/drivers/net/wireless/realtek/rtw88/coex.c
@@ -1059,7 +1059,7 @@ static void rtw_coex_set_ant_path(struct rtw_dev *rtwdev, bool force, u8 phase)
 		pos_type = COEX_SWITCH_TO_WLG_BT;
 		break;
 	default:
-		WARN_ON("unknown phase when setting antenna path\n");
+		WARN(1, "unknown phase when setting antenna path\n");
 		return;
 	}
 
-- 
2.20.1

