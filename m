Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A904F11E258
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Dec 2019 11:51:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbfLMKvu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Dec 2019 05:51:50 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:46242 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbfLMKvu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Dec 2019 05:51:50 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBDAfs1P185228;
        Fri, 13 Dec 2019 10:51:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2019-08-05;
 bh=sYuHbmgp+vL6aqOTDzJlsU5U4y286O/xbpzdP9S1hvc=;
 b=fptM8tqE0aftiXY8jpixYbmYJIj1GgGxmvC23TbRw2NfmU4ad3hlTBQvQFVaktYCQYdB
 5emfOO4holhAHthiKzsFmKCatqe6yg5woDzjndoYAHX6W0kJAbwPJm01TVCjb3yi5o1i
 /L7hNdeyA6TMzwzFEtqO1zg/mJOjDdS/pY7nuXeykyWU2XKvTJtD6Pa/9YduoaDE9CGN
 kpCBj2KRpAsynjFrbtp9DQeMMKb8i8OB7vY0/MYl1J17oywOiRFvm7qdi/6onXxRut4r
 lGyPdt3nT7AZuHOC07Y5cvRUbkhwWc3vitEumI+ZP+1swyqjrQ/ktwCRXYs6AbOBnsz1 8Q== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2wr4qs0b22-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Dec 2019 10:51:40 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBDAk7oK134991;
        Fri, 13 Dec 2019 10:51:39 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2wumw5wqc0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Dec 2019 10:51:39 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xBDApcWD002894;
        Fri, 13 Dec 2019 10:51:38 GMT
Received: from kili.mountain (/129.205.23.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 13 Dec 2019 02:51:37 -0800
Date:   Fri, 13 Dec 2019 13:51:27 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Venkateswara Naralasetty <vnaralas@codeaurora.org>,
        Muna Sinada <msinada@codeaurora.org>,
        Shashidhar Lakkavalli <slakkavalli@datto.com>,
        Miles Hu <milehu@codeaurora.org>, ath11k@lists.infradead.org,
        linux-wireless@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] ath11k: checking for NULL vs IS_ERR()
Message-ID: <20191213105127.kijiazxwtghmubyk@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: NeoMutt/20170113 (1.7.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9469 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=865
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912130086
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9469 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=923 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912130086
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The ath11k_ce_alloc_ring() function returns error pointers on error, not
NULL.  The rest of the driver assumes that "pipe->src_ring" is either
valid or NULL so this patch introduces a temporary varaible to avoid
leaving it as an error pointer.

Fixes: d5c65159f289 ("ath11k: driver for Qualcomm IEEE 802.11ax devices")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/net/wireless/ath/ath11k/ce.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/ce.c b/drivers/net/wireless/ath/ath11k/ce.c
index a6572b414303..cdd40c8fc867 100644
--- a/drivers/net/wireless/ath/ath11k/ce.c
+++ b/drivers/net/wireless/ath/ath11k/ce.c
@@ -441,6 +441,7 @@ static int ath11k_ce_alloc_pipe(struct ath11k_base *ab, int ce_id)
 {
 	struct ath11k_ce_pipe *pipe = &ab->ce.ce_pipe[ce_id];
 	const struct ce_attr *attr = &host_ce_config_wlan[ce_id];
+	struct ath11k_ce_ring *ring;
 	int nentries;
 	int desc_sz;
 
@@ -450,24 +451,26 @@ static int ath11k_ce_alloc_pipe(struct ath11k_base *ab, int ce_id)
 		pipe->send_cb = ath11k_ce_send_done_cb;
 		nentries = roundup_pow_of_two(attr->src_nentries);
 		desc_sz = ath11k_hal_ce_get_desc_size(HAL_CE_DESC_SRC);
-		pipe->src_ring = ath11k_ce_alloc_ring(ab, nentries, desc_sz);
-		if (!pipe->src_ring)
-			return -ENOMEM;
+		ring = ath11k_ce_alloc_ring(ab, nentries, desc_sz);
+		if (IS_ERR(ring))
+			return PTR_ERR(ring);
+		pipe->src_ring = ring;
 	}
 
 	if (attr->dest_nentries) {
 		pipe->recv_cb = attr->recv_cb;
 		nentries = roundup_pow_of_two(attr->dest_nentries);
 		desc_sz = ath11k_hal_ce_get_desc_size(HAL_CE_DESC_DST);
-		pipe->dest_ring = ath11k_ce_alloc_ring(ab, nentries, desc_sz);
-
-		if (!pipe->dest_ring)
-			return -ENOMEM;
+		ring = ath11k_ce_alloc_ring(ab, nentries, desc_sz);
+		if (IS_ERR(ring))
+			return PTR_ERR(ring);
+		pipe->dest_ring = ring;
 
 		desc_sz = ath11k_hal_ce_get_desc_size(HAL_CE_DESC_DST_STATUS);
-		pipe->status_ring = ath11k_ce_alloc_ring(ab, nentries, desc_sz);
-		if (!pipe->status_ring)
-			return -ENOMEM;
+		ring = ath11k_ce_alloc_ring(ab, nentries, desc_sz);
+		if (IS_ERR(ring))
+			return PTR_ERR(ring);
+		pipe->status_ring = ring;
 	}
 
 	return 0;
-- 
2.11.0

