Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 289D61E4D5C
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2020 20:48:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728037AbgE0Ssp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 27 May 2020 14:48:45 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:50440 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727880AbgE0Ssn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 27 May 2020 14:48:43 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04RIgBmk090245;
        Wed, 27 May 2020 18:48:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type : in-reply-to;
 s=corp-2020-01-29; bh=jmNFa9+CztBRoiWYFP9+gHfWDzlJqON7/epS5Zkn6lk=;
 b=Ru96PTVzByW49Z4YlQPLBjo1+vfSV1G+F6XPgIVGNXHfN7e/S6TfygA+qOjPwoMlzfmM
 psNbSU63uCr+KwWi7Gaag3fHZyMNm8Wqel+Nylb8908gVhtSodBrAsTPQf9AJOQrbj3R
 qT7Bah6YoYQOva9I/xEIehyjC0JTu+8wgAWFAq9UwMMueoY4XeH8q4TW0edCfgg68QHK
 OV8+khyusyibd6Xc0WfbcJ8PE+5IGdcie0EyNJb8V6s0n3/zSmvXqy7DXVIuOsFdRrbo
 SbrVW/J09h88ym9psybZ/OFZj2SzQB8alz8TEnqYSGcO+Mc1QrIse1Lp64DbOJMN5vnD Tw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 318xbk171m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 27 May 2020 18:48:38 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04RIh2cO164388;
        Wed, 27 May 2020 18:48:37 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 317ddra645-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 May 2020 18:48:37 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 04RImb8R019953;
        Wed, 27 May 2020 18:48:37 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 27 May 2020 11:48:36 -0700
Date:   Wed, 27 May 2020 21:48:30 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Kalle Valo <kvalo@codeaurora.org>, Hu Jiahui <kirin.say@gmail.com>,
        Eric Dumazet <edumazet@google.com>
Cc:     security@kernel.org, linux-wireless@vger.kernel.org,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH v3] airo: Fix read overflows sending packets
Message-ID: <20200527184830.GA1164846@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANn89iKWzfAeK96iL_snfJ1jGnaWq0B5odZtC5o1_ccB8ECV9w@mail.gmail.com>
X-Mailer: git-send-email haha only kidding
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9633 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 phishscore=0 adultscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005270143
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9633 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 mlxscore=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 cotscore=-2147483648
 suspectscore=0 bulkscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2005270143
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The problem is that we always copy a minimum of ETH_ZLEN (60) bytes from
skb->data even when skb->len is less than ETH_ZLEN so it leads to a read
overflow.

The fix is to pad skb->data to at least ETH_ZLEN bytes.

Cc: <stable@vger.kernel.org>
Reported-by: Hu Jiahui <kirin.say@gmail.com>
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
v2: remove an unnecessary if statement
    increment the ->tx_dropped count on failure
    fix found two more instances of the same bug.
    fix typo in the "Cc: <stable@vger.kernel.org>" tag
v3: I had thought that skb_padto() updated skb->len so that it would
    always be more than ETH_ZLEN meaning that we could delete the checks
    for smaller values:  "len = skb->len < ETH_ZLEN ? ETH_ZLEN : skb->len;"
    But I was wrong and those are still required.

 drivers/net/wireless/cisco/airo.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/wireless/cisco/airo.c b/drivers/net/wireless/cisco/airo.c
index 8363f91df7ea7..827bb6d74815a 100644
--- a/drivers/net/wireless/cisco/airo.c
+++ b/drivers/net/wireless/cisco/airo.c
@@ -1925,6 +1925,10 @@ static netdev_tx_t mpi_start_xmit(struct sk_buff *skb,
 		airo_print_err(dev->name, "%s: skb == NULL!",__func__);
 		return NETDEV_TX_OK;
 	}
+	if (skb_padto(skb, ETH_ZLEN)) {
+		dev->stats.tx_dropped++;
+		return NETDEV_TX_OK;
+	}
 	npacks = skb_queue_len (&ai->txq);
 
 	if (npacks >= MAXTXQ - 1) {
@@ -2127,6 +2131,10 @@ static netdev_tx_t airo_start_xmit(struct sk_buff *skb,
 		airo_print_err(dev->name, "%s: skb == NULL!", __func__);
 		return NETDEV_TX_OK;
 	}
+	if (skb_padto(skb, ETH_ZLEN)) {
+		dev->stats.tx_dropped++;
+		return NETDEV_TX_OK;
+	}
 
 	/* Find a vacant FID */
 	for( i = 0; i < MAX_FIDS / 2 && (fids[i] & 0xffff0000); i++ );
@@ -2201,6 +2209,10 @@ static netdev_tx_t airo_start_xmit11(struct sk_buff *skb,
 		airo_print_err(dev->name, "%s: skb == NULL!", __func__);
 		return NETDEV_TX_OK;
 	}
+	if (skb_padto(skb, ETH_ZLEN)) {
+		dev->stats.tx_dropped++;
+		return NETDEV_TX_OK;
+	}
 
 	/* Find a vacant FID */
 	for( i = MAX_FIDS / 2; i < MAX_FIDS && (fids[i] & 0xffff0000); i++ );
-- 
2.26.2

