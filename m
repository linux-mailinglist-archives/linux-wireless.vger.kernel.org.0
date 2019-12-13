Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A03211E26A
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Dec 2019 11:55:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbfLMKzJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Dec 2019 05:55:09 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:49312 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbfLMKzJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Dec 2019 05:55:09 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBDAfs8G185214;
        Fri, 13 Dec 2019 10:55:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2019-08-05;
 bh=fPiyxite5xS8FFK2YqA7v+HjG20stHfsChDxAGg28jk=;
 b=ohvllYSqQo0tjaSaHmkp0/PPKu5/PxcwQP0kyTV2wIkKiXwp9Q7X1tOR5sytabuI/0uE
 p04nprbwFDDiZ+TT7LfdvIO75seZQQYJoyHjZrAfEY4qX5/abaRdqIfiRy0T5d6AXoq+
 41tIj84wJSmq9JIEZpBCPllQSZKxYiB6bTcvmWOJseYDLckP/0nWX7mcnjWZfIrBTki6
 I2yku1LQbB42rVHNFmmAjbiibE9lc2b5GPTA+/atApPiS/kc8iRUP8w/+ebF3xOBLVLk
 GcquYChwDHpy/FDr2flGjTwhzaOUoB1rrrptlUnixOZxj6F3tdGnBkaF4Z6qD5jYoBSf wA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2wr4qs0bek-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Dec 2019 10:55:00 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBDAk6Uo134988;
        Fri, 13 Dec 2019 10:55:00 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2wumw5xqu5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Dec 2019 10:54:59 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xBDAsw2B012029;
        Fri, 13 Dec 2019 10:54:58 GMT
Received: from kili.mountain (/129.205.23.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 13 Dec 2019 02:54:57 -0800
Date:   Fri, 13 Dec 2019 13:54:48 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     John Crispin <john@phrozen.org>,
        Vasanthakumar Thiagarajan <vthiagar@codeaurora.org>,
        Anilkumar Kolli <akolli@codeaurora.org>,
        Bhagavathi Perumal S <bperumal@codeaurora.org>,
        ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] ath11k: fix up some error paths
Message-ID: <20191213105448.b7lic5ddih6c3sqy@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: NeoMutt/20170113 (1.7.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9469 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=746
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912130086
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9469 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=804 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912130086
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

There are two error paths where "ret" wasn't set.  Ideally the compiler
would have warned about these bugs, but we initialized "ret" to zero so
it silenced the warning.  I have removed that.  Also if
ath11k_hal_srng_get_entrysize() fails then we need to free some
resources before returning.

Fixes: d5c65159f289 ("ath11k: driver for Qualcomm IEEE 802.11ax devices")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/net/wireless/ath/ath11k/dp_tx.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/dp_tx.c b/drivers/net/wireless/ath/ath11k/dp_tx.c
index a8b9557c2346..ea7564245c58 100644
--- a/drivers/net/wireless/ath/ath11k/dp_tx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_tx.c
@@ -606,7 +606,7 @@ int ath11k_dp_tx_htt_srng_setup(struct ath11k_base *ab, u32 ring_id,
 	dma_addr_t hp_addr, tp_addr;
 	enum htt_srng_ring_type htt_ring_type;
 	enum htt_srng_ring_id htt_ring_id;
-	int ret = 0;
+	int ret;
 
 	skb = ath11k_htc_alloc_skb(ab, len);
 	if (!skb)
@@ -618,9 +618,10 @@ int ath11k_dp_tx_htt_srng_setup(struct ath11k_base *ab, u32 ring_id,
 	hp_addr = ath11k_hal_srng_get_hp_addr(ab, srng);
 	tp_addr = ath11k_hal_srng_get_tp_addr(ab, srng);
 
-	if (ath11k_dp_tx_get_ring_id_type(ab, mac_id, ring_id,
-					  ring_type, &htt_ring_type,
-					  &htt_ring_id))
+	ret = ath11k_dp_tx_get_ring_id_type(ab, mac_id, ring_id,
+					    ring_type, &htt_ring_type,
+					    &htt_ring_id);
+	if (ret)
 		goto err_free;
 
 	skb_put(skb, len);
@@ -646,7 +647,7 @@ int ath11k_dp_tx_htt_srng_setup(struct ath11k_base *ab, u32 ring_id,
 
 	ret = ath11k_hal_srng_get_entrysize(ring_type);
 	if (ret < 0)
-		return -EINVAL;
+		goto err_free;
 
 	ring_entry_sz = ret;
 
@@ -791,7 +792,7 @@ int ath11k_dp_tx_htt_rx_filter_setup(struct ath11k_base *ab, u32 ring_id,
 	int len = sizeof(*cmd);
 	enum htt_srng_ring_type htt_ring_type;
 	enum htt_srng_ring_id htt_ring_id;
-	int ret = 0;
+	int ret;
 
 	skb = ath11k_htc_alloc_skb(ab, len);
 	if (!skb)
@@ -800,9 +801,10 @@ int ath11k_dp_tx_htt_rx_filter_setup(struct ath11k_base *ab, u32 ring_id,
 	memset(&params, 0, sizeof(params));
 	ath11k_hal_srng_get_params(ab, srng, &params);
 
-	if (ath11k_dp_tx_get_ring_id_type(ab, mac_id, ring_id,
-					  ring_type, &htt_ring_type,
-					  &htt_ring_id))
+	ret = ath11k_dp_tx_get_ring_id_type(ab, mac_id, ring_id,
+					    ring_type, &htt_ring_type,
+					    &htt_ring_id);
+	if (ret)
 		goto err_free;
 
 	skb_put(skb, len);
-- 
2.11.0

