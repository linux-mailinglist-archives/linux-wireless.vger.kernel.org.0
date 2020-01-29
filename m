Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C68014CFC5
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Jan 2020 18:39:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727355AbgA2Rjm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 29 Jan 2020 12:39:42 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:35198 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726679AbgA2Rjm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 29 Jan 2020 12:39:42 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00THd9BE126228;
        Wed, 29 Jan 2020 17:39:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2019-08-05;
 bh=tr7gEXy7VyEAfiCPoAPHT51+Uv8d46qh3HaBdWx9DyY=;
 b=InmgxSRfxnrmXMUdd6hZFTwq7ROQ9hM65S0xFOTPX51KwAV0J3cBVl9lwsU2GdQySnfT
 a5qIIvSmmb59lFVQNaySczLjKBgNfN0Ri6H1TCGkBAPba4OdnKUdyD0jp0jFv120Tb7H
 H1vM+3ZZgCmAqN2FGBhfXVK8vZyR1J9QRgPlhyoD3/zHgS6Vi5/S8whjTrjySFabNHz0
 5Q3lyW+hjH7nGAIz9Z00m1++eiCXkAFHBkJJitv+h/d1zCPYZ8tMb3SCtTkdR+qd9Ft7
 /2bOVq2o6XaHpO5rbd1ftNy6X1tvZXskBi3hAwsIl4gN8ljX2eddf3IkDJGiTqB42pxt kw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2xrd3uf1tt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Jan 2020 17:39:35 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00THcFVl127704;
        Wed, 29 Jan 2020 17:39:34 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2xuc2x4mjy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Jan 2020 17:39:34 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 00THdWMi012513;
        Wed, 29 Jan 2020 17:39:32 GMT
Received: from kili.mountain (/129.205.23.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 29 Jan 2020 09:39:31 -0800
Date:   Wed, 29 Jan 2020 20:39:24 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Yan-Hsuan Chuang <yhchuang@realtek.com>,
        Chin-Yen Lee <timlee@realtek.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>, linux-wireless@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] rtw88: Use kfree_skb() instead of kfree()
Message-ID: <20200129173923.rfufhv5c5pxwodm6@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: NeoMutt/20170113 (1.7.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9514 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=982
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001290145
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9514 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001290145
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

sk_buff structs need to be freed with kfree_skb(), not kfree().

Fixes: b6c12908a33e ("rtw88: Add wowlan net-detect support")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/net/wireless/realtek/rtw88/fw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw88/fw.c b/drivers/net/wireless/realtek/rtw88/fw.c
index 243441453ead..5bdfc70c4529 100644
--- a/drivers/net/wireless/realtek/rtw88/fw.c
+++ b/drivers/net/wireless/realtek/rtw88/fw.c
@@ -745,7 +745,7 @@ static struct sk_buff *rtw_nlo_info_get(struct ieee80211_hw *hw)
 		loc  = rtw_get_rsvd_page_probe_req_location(rtwdev, ssid);
 		if (!loc) {
 			rtw_err(rtwdev, "failed to get probe req rsvd loc\n");
-			kfree(skb);
+			kfree_skb(skb);
 			return NULL;
 		}
 		nlo_hdr->location[i] = loc;
-- 
2.11.0

