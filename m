Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1AA91E4C7D
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2020 19:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391758AbgE0R60 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 27 May 2020 13:58:26 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:46040 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387653AbgE0R60 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 27 May 2020 13:58:26 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04RHwK55116779;
        Wed, 27 May 2020 17:58:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type : in-reply-to;
 s=corp-2020-01-29; bh=xV9m8ie4u5KMWmuoQ5MDNyWb/AfYQCSoWRmXFP95Y8w=;
 b=YoQZjwTGcxL+DaOr6BRj1QJbLPmh1W5Oh78YwJeDI7UTjmRDer340H7rvjtcTdXOc1GC
 jMPOtpZtuZR991FbU/T8bWQMh40pUMopXUrnS+LcTtPTKonzO4c7aEqsk5raT/+YXlYj
 aQfgha6pMxqeyeeChw9q/6CXn2/Qc3bInceb/ik/xhqonXJy62gzt187TZ55p/8kMtn9
 jCICkcg9RpV5lyJwYecL5Bx3fNBuW54sfsCdjTPhk6tzoJHIAwv92E7x18g045qnbrc4
 yiUzGd/dkN91blj6nZje1r3OLoX97mfXVJWBrSSr+WJS9+ipxbNzu2s2x+/DEd10EanT XA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 318xe1gxd2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 27 May 2020 17:58:20 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04RHvZNp042320;
        Wed, 27 May 2020 17:58:20 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 317j5shgt0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 May 2020 17:58:20 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 04RHwJD6020183;
        Wed, 27 May 2020 17:58:19 GMT
Received: from kili.mountain (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 27 May 2020 10:58:19 -0700
Date:   Wed, 27 May 2020 20:58:08 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Kalle Valo <kvalo@codeaurora.org>, Hu Jiahui <kirin.say@gmail.com>,
        Eric Dumazet <edumazet@google.com>
Cc:     security@kernel.org, linux-wireless@vger.kernel.org,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH v2] airo: Fix read overflows sending packets
Message-ID: <20200527175808.peynuk7a6webysv3@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANn89i+Pv6ANBWx-wy-aRXsPgDs=ERzumBvB2g3xiC7OfXXGwA@mail.gmail.com>
X-Mailer: git-send-email haha only kidding
User-Agent: NeoMutt/20170113 (1.7.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9633 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005270140
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9633 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 adultscore=0 cotscore=-2147483648 mlxscore=0 bulkscore=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 suspectscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005270140
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The problem is that we always copy a minimum of ETH_ZLEN (60) bytes from
skb->data even when skb->len is less than ETH_ZLEN so it leads to a read
overflow.

The fix is to pad skb->data with zeroes so that it's never less than
ETH_ZLEN bytes.

Cc: <stable@vger.kernel.org>
Reported-by: Hu Jiahui <kirin.say@gmail.com>
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
v2: remove an unnecessary if statement
    increment the ->tx_dropped count on failure
    fix found two more instances of the same bug.
    fix typo in the "Cc: <stable@vger.kernel.org>" tag

 drivers/net/wireless/cisco/airo.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/cisco/airo.c b/drivers/net/wireless/cisco/airo.c
index 8363f91df7ea..c80712e61ccf 100644
--- a/drivers/net/wireless/cisco/airo.c
+++ b/drivers/net/wireless/cisco/airo.c
@@ -1925,6 +1925,11 @@ static netdev_tx_t mpi_start_xmit(struct sk_buff *skb,
 		airo_print_err(dev->name, "%s: skb == NULL!",__func__);
 		return NETDEV_TX_OK;
 	}
+	if (skb_padto(skb, ETH_ZLEN)) {
+		dev->stats.tx_dropped++;
+		return NETDEV_TX_OK;
+	}
+
 	npacks = skb_queue_len (&ai->txq);
 
 	if (npacks >= MAXTXQ - 1) {
@@ -1975,8 +1980,7 @@ static int mpi_send_packet (struct net_device *dev)
 		return 0;
 	}
 
-	/* check min length*/
-	len = ETH_ZLEN < skb->len ? skb->len : ETH_ZLEN;
+	len = skb->len;
 	buffer = skb->data;
 
 	ai->txfids[0].tx_desc.offset = 0;
@@ -2118,7 +2122,6 @@ static void airo_end_xmit(struct net_device *dev) {
 static netdev_tx_t airo_start_xmit(struct sk_buff *skb,
 					 struct net_device *dev)
 {
-	s16 len;
 	int i, j;
 	struct airo_info *priv = dev->ml_priv;
 	u32 *fids = priv->fids;
@@ -2127,6 +2130,10 @@ static netdev_tx_t airo_start_xmit(struct sk_buff *skb,
 		airo_print_err(dev->name, "%s: skb == NULL!", __func__);
 		return NETDEV_TX_OK;
 	}
+	if (skb_padto(skb, ETH_ZLEN)) {
+		dev->stats.tx_dropped++;
+		return NETDEV_TX_OK;
+	}
 
 	/* Find a vacant FID */
 	for( i = 0; i < MAX_FIDS / 2 && (fids[i] & 0xffff0000); i++ );
@@ -2140,10 +2147,8 @@ static netdev_tx_t airo_start_xmit(struct sk_buff *skb,
 			return NETDEV_TX_BUSY;
 		}
 	}
-	/* check min length*/
-	len = ETH_ZLEN < skb->len ? skb->len : ETH_ZLEN;
         /* Mark fid as used & save length for later */
-	fids[i] |= (len << 16);
+	fids[i] |= (skb->len << 16);
 	priv->xmit.skb = skb;
 	priv->xmit.fid = i;
 	if (down_trylock(&priv->sem) != 0) {
@@ -2185,7 +2190,6 @@ static void airo_end_xmit11(struct net_device *dev) {
 static netdev_tx_t airo_start_xmit11(struct sk_buff *skb,
 					   struct net_device *dev)
 {
-	s16 len;
 	int i, j;
 	struct airo_info *priv = dev->ml_priv;
 	u32 *fids = priv->fids;
@@ -2201,6 +2205,10 @@ static netdev_tx_t airo_start_xmit11(struct sk_buff *skb,
 		airo_print_err(dev->name, "%s: skb == NULL!", __func__);
 		return NETDEV_TX_OK;
 	}
+	if (skb_padto(skb, ETH_ZLEN)) {
+		dev->stats.tx_dropped++;
+		return NETDEV_TX_OK;
+	}
 
 	/* Find a vacant FID */
 	for( i = MAX_FIDS / 2; i < MAX_FIDS && (fids[i] & 0xffff0000); i++ );
@@ -2214,10 +2222,8 @@ static netdev_tx_t airo_start_xmit11(struct sk_buff *skb,
 			return NETDEV_TX_BUSY;
 		}
 	}
-	/* check min length*/
-	len = ETH_ZLEN < skb->len ? skb->len : ETH_ZLEN;
         /* Mark fid as used & save length for later */
-	fids[i] |= (len << 16);
+	fids[i] |= (skb->len << 16);
 	priv->xmit11.skb = skb;
 	priv->xmit11.fid = i;
 	if (down_trylock(&priv->sem) != 0) {
-- 
2.11.0

