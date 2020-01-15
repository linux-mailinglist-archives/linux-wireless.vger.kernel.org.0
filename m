Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B1BC13CB50
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jan 2020 18:47:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728927AbgAORrQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Jan 2020 12:47:16 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:59442 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726778AbgAORrQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Jan 2020 12:47:16 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00FHcPwp060270;
        Wed, 15 Jan 2020 17:47:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type : in-reply-to;
 s=corp-2019-08-05; bh=UpcwOEuZTTeWdCRLUWu8hWXeYNMJ2bLR8Bd+B/THRzs=;
 b=C1bl7FiFiga3LjabcbnUlLIMmLTPhSUtjICpqX6q6BNWbuIKyMZjzZzckyQBR90N0Hx+
 kU5qy6DLLYdYVZxIgaEnoi2gd4zOvcShHwyPGqbS82GdZ+UGH786j+JRqQG+ZSMkarP5
 byb0l989V7O3iGnlWFntMTOwfwTMEGK/8d6Z7RFjxHC+XV8pbIZrCFUe12kOld1mpAhy
 W+17ubjS6tTrZvlY/5/h8m5g8zWLcFsqAg9ce1MNAcxwp79/Of3MCByhh0Y8Re0IbFAf
 nhwdp4fnQV8Ba+Rn9DUk1Y+62mK2P/xkT/3JzEyHQfqsjJMkmGHeU2jdqlAT/J9ijl6k 9g== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2xf73ynny3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Jan 2020 17:47:03 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00FHcrTq069176;
        Wed, 15 Jan 2020 17:47:03 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2xj61k5cp0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Jan 2020 17:47:02 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 00FHl1j4025399;
        Wed, 15 Jan 2020 17:47:01 GMT
Received: from kili.mountain (/129.205.23.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 15 Jan 2020 09:47:00 -0800
Date:   Wed, 15 Jan 2020 20:46:52 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        kernel-janitors@vger.kernel.org, John Crispin <john@phrozen.org>,
        Vasanthakumar Thiagarajan <vthiagar@codeaurora.org>,
        Anilkumar Kolli <akolli@codeaurora.org>,
        Bhagavathi Perumal S <bperumal@codeaurora.org>
Subject: [PATCH v2] ath11k: fix up some error paths
Message-ID: <20200115174652.dvkmznhfvjaoc47l@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200115091903.7EC3FC4479C@smtp.codeaurora.org>
X-Mailer: git-send-email haha only kidding
User-Agent: NeoMutt/20170113 (1.7.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9501 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=944
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001150135
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9501 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001150135
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

There are two error paths where "ret" wasn't set.  Also one error path
we set the error code to -EINVAL but we should just preserve the error
code from ath11k_hal_srng_get_entrysize().  That function only returns
-EINVAL so this doesn't change anything.

I removed the "ret = 0;" initializers so that hopefully GCC will be able
to detect these sorts of bugs in the future.

Fixes: d5c65159f289 ("ath11k: driver for Qualcomm IEEE 802.11ax devices")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
v2: rebase

 drivers/net/wireless/ath/ath11k/dp_tx.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/dp_tx.c b/drivers/net/wireless/ath/ath11k/dp_tx.c
index 918305dda106..873b2cb2bb4c 100644
--- a/drivers/net/wireless/ath/ath11k/dp_tx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_tx.c
@@ -630,7 +630,7 @@ int ath11k_dp_tx_htt_srng_setup(struct ath11k_base *ab, u32 ring_id,
 	dma_addr_t hp_addr, tp_addr;
 	enum htt_srng_ring_type htt_ring_type;
 	enum htt_srng_ring_id htt_ring_id;
-	int ret = 0;
+	int ret;
 
 	skb = ath11k_htc_alloc_skb(ab, len);
 	if (!skb)
@@ -642,9 +642,10 @@ int ath11k_dp_tx_htt_srng_setup(struct ath11k_base *ab, u32 ring_id,
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
@@ -669,10 +670,8 @@ int ath11k_dp_tx_htt_srng_setup(struct ath11k_base *ab, u32 ring_id,
 				 HAL_ADDR_MSB_REG_SHIFT;
 
 	ret = ath11k_hal_srng_get_entrysize(ring_type);
-	if (ret < 0) {
-		ret = -EINVAL;
+	if (ret < 0)
 		goto err_free;
-	}
 
 	ring_entry_sz = ret;
 
@@ -817,7 +816,7 @@ int ath11k_dp_tx_htt_rx_filter_setup(struct ath11k_base *ab, u32 ring_id,
 	int len = sizeof(*cmd);
 	enum htt_srng_ring_type htt_ring_type;
 	enum htt_srng_ring_id htt_ring_id;
-	int ret = 0;
+	int ret;
 
 	skb = ath11k_htc_alloc_skb(ab, len);
 	if (!skb)
@@ -826,9 +825,10 @@ int ath11k_dp_tx_htt_rx_filter_setup(struct ath11k_base *ab, u32 ring_id,
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

