Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A7E32D17F2
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Dec 2020 18:57:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726137AbgLGRzm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 7 Dec 2020 12:55:42 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:38666 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726110AbgLGRzl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 7 Dec 2020 12:55:41 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B7HsLgT168731;
        Mon, 7 Dec 2020 17:54:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=OgfeLb1sEogV44Jwb3bnAORDTi/aJ1Q4byLVqo2TbaA=;
 b=OEbzMuxvFzaycBNb7IlH4w4mkq3rxF8R9KAorRIqGu9xqGFNjvmArZ0jEoi9hY9s3ZrE
 cHKq6CZq3nRhceZgh8jXuj7uDnBET8G3R8mcVe6uudH0QmBCHFR4tDORcUb+NlhM8VJ1
 CWVgmZHnIA4uW/WlrXGpSeIKja8ML2gy1biu5PWQ7akHCG4sJaej5L7fAylJL0xcd02m
 dA2ua272Z8mplrmmG7A3H3XDhdOwTdVBaqYJMZqWKSRBaY2UrR4tRBTeYJV9ae24WalT
 F0/XT1vkLI6hVOezZiYJkK8CHtuvMEs71RXMTezmzWF5edwoF9UwE1yOCmdbtaGJ85eN Kw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 3581mqpnmg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 07 Dec 2020 17:54:53 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B7Hjf7S067382;
        Mon, 7 Dec 2020 17:54:53 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 358m4wkkdf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Dec 2020 17:54:53 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0B7HsqO2015906;
        Mon, 7 Dec 2020 17:54:52 GMT
Received: from mwanda (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 07 Dec 2020 09:54:50 -0800
Date:   Mon, 7 Dec 2020 20:54:28 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Kalle Valo <kvalo@codeaurora.org>,
        Ritesh Singh <ritesi@codeaurora.org>
Cc:     Maharaja Kennadyrajan <mkenna@codeaurora.org>,
        ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] ath11k: unlock on error path in ath11k_mac_op_add_interface()
Message-ID: <X85sVGVP/0XvlrEJ@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9828 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 phishscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012070115
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9828 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 clxscore=1011 malwarescore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 impostorscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012070116
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

These error paths need to drop the &ar->conf_mutex before returning.

Fixes: 690ace20ff79 ("ath11k: peer delete synchronization with firmware")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/net/wireless/ath/ath11k/mac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index ebed24ec7368..12cc16003e30 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -4615,13 +4615,13 @@ static int ath11k_mac_op_add_interface(struct ieee80211_hw *hw,
 		if (ret) {
 			ath11k_warn(ar->ab, "failed to delete peer vdev_id %d addr %pM\n",
 				    arvif->vdev_id, vif->addr);
-			return ret;
+			goto err;
 		}
 
 		ret = ath11k_wait_for_peer_delete_done(ar, arvif->vdev_id,
 						       vif->addr);
 		if (ret)
-			return ret;
+			goto err;
 
 		ar->num_peers--;
 	}
-- 
2.29.2

