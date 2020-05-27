Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBF4F1E43DC
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2020 15:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388179AbgE0NhE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 27 May 2020 09:37:04 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:32846 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387581AbgE0NhE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 27 May 2020 09:37:04 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04RDVjAd135718;
        Wed, 27 May 2020 13:37:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type : in-reply-to;
 s=corp-2020-01-29; bh=2XBtzrcZVqGSKujAewp+bpOQ9FuQ+54UrpEQT6Efka8=;
 b=lM7zB2+VILUc8t+GoD7IVLjMOaFuCEGCPeHfLih7Mkl2cF1BZd8yY5bU/p5A+NqglcnB
 1/G+6xKc3YvAOmWRgEtmCa3tMaXVmm52drfbf4uUrkCvKtewZenUrqtsVG2dCtEA5sg7
 WkEFOeERvuP/0eXcCl7E9NMR8xa914bQot46o6/2pPDgyBU5xWxgAGAFDt+VjsR1fcOd
 3BQCRyCSB4po7nOJ/spe9bYIDsxqBHCR9JT1lI+iGtM2KKdq+pZnab+AjVEemg7xOi2v
 5FvYLlWbP2dXEFTkKgw7x/LWJj3XUmt0EUG6IP9DhaJXumizCkX8k0a2lgRTk8Lc5cWI aA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 318xbjygny-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 27 May 2020 13:37:00 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04RDXc4F000954;
        Wed, 27 May 2020 13:36:59 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 317dkuex1t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 May 2020 13:36:59 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 04RDawT0028515;
        Wed, 27 May 2020 13:36:58 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 27 May 2020 06:36:58 -0700
Date:   Wed, 27 May 2020 16:36:52 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Kalle Valo <kvalo@codeaurora.org>, Hu Jiahui <kirin.say@gmail.com>
Cc:     security@kernel.org, linux-wireless@vger.kernel.org,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH resend] airo: Fix read overflow in mpi_send_packet()
Message-ID: <20200527133301.GL22511@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <EED43E20-9B88-42EC-80B0-0245F0FAF980@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9633 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 bulkscore=0
 spamscore=0 suspectscore=0 mlxscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005270102
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9633 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 mlxscore=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 cotscore=-2147483648
 suspectscore=0 bulkscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2005270102
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The problem is that we always copy a minimum of ETH_ZLEN (60) bytes from
skb->data even when skb->len is less than ETH_ZLEN so it leads to a read
overflow.

The fix for is to pad skb->data with zeroes so that it's never less than
ETH_ZLEN bytes.

c: <stable@vger.kernel.org>
Reported-by: Hu Jiahui <kirin.say@gmail.com>
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
Resending to the public lists so that it can go through the normal
review process.

My other concern with this driver is why is the ->max_mtu 2400 when it
looks like we are allocating PKTSIZE (1840) byte buffers to hold it in
mpi_map_card()?  I don't fully understand the code but that seems like
it could be a buffer overflow as well.  I'm not sure what the
appropriate fix is for that.

 drivers/net/wireless/cisco/airo.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/cisco/airo.c b/drivers/net/wireless/cisco/airo.c
index 8363f91df7ea7..7c5634f72cc72 100644
--- a/drivers/net/wireless/cisco/airo.c
+++ b/drivers/net/wireless/cisco/airo.c
@@ -1925,6 +1925,11 @@ static netdev_tx_t mpi_start_xmit(struct sk_buff *skb,
 		airo_print_err(dev->name, "%s: skb == NULL!",__func__);
 		return NETDEV_TX_OK;
 	}
+	if (skb->len < ETH_ZLEN) {
+		if (skb_padto(skb, ETH_ZLEN))
+			return NETDEV_TX_OK;
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
-- 
2.26.2
