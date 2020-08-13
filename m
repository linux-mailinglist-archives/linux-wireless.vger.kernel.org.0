Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E5EE243B5C
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Aug 2020 16:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726249AbgHMOQf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Aug 2020 10:16:35 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:52808 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbgHMOQe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Aug 2020 10:16:34 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07DED9sg153761;
        Thu, 13 Aug 2020 14:13:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=hReHtbilarffvDjNu7dz5RQ1aPGTpcjqtoy9B6EgYbE=;
 b=RlOjJrJGBnVnMbAjGhU7v6quEXMqD8MRFt1F6BV5ER3jp3bl4j1ixvh+i2l1Pc4DNXh0
 Lfom1t52mTJMSykOuI5mrrPJfL6LSlsH9jf+jN1p1NgGkbCJkRZ4adLUDesr2bAah1l2
 7Cu7gaX0NZDgQgCsjrDTVDDC0k0XF1JexsQw90S2lUCgCooCWFIE3+bCw4SmlwByRymn
 JxPzZb8FihpNDd240iCIz5f9Z+GHYRbt+k5OpcPqMrb2sUxHCrRk14y3y/YImRmRbPnh
 t+6+yVeV50zeagiC8LBtCzJWaIkgTAasaCZeodssaWxl2ypQzONrpbEOb0w7MiHnAgE8 Cw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 32w73c800a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 13 Aug 2020 14:13:09 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07DE9Rls049806;
        Thu, 13 Aug 2020 14:13:08 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 32t5y9vds5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Aug 2020 14:13:08 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 07DED2q9032552;
        Thu, 13 Aug 2020 14:13:02 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 13 Aug 2020 14:13:01 +0000
Date:   Thu, 13 Aug 2020 17:12:53 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     QCA ath9k Development <ath9k-devel@qca.qualcomm.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Vasanthakumar Thiagarajan <vasanth@atheros.com>,
        "John W. Linville" <linville@tuxdriver.com>,
        Senthil Balasubramanian <senthilkumar@atheros.com>,
        Sujith <Sujith.Manoharan@atheros.com>,
        linux-wireless@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] ath9k: Fix potential out of bounds in
 ath9k_htc_txcompletion_cb()
Message-ID: <20200813141253.GA457408@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9711 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 suspectscore=2 mlxscore=0 adultscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008130106
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9711 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 bulkscore=0 phishscore=0 suspectscore=2 mlxscore=0 priorityscore=1501
 spamscore=0 clxscore=1011 lowpriorityscore=0 adultscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008130107
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The value of "htc_hdr->endpoint_id" comes from skb->data so Smatch marks
it as untrusted so we have to check it before using it as an array
offset.

This is similar to a bug that syzkaller found in commit e4ff08a4d727
("ath9k: Fix use-after-free Write in ath9k_htc_rx_msg") so it is
probably a real issue.

Fixes: fb9987d0f748 ("ath9k_htc: Support for AR9271 chipset.")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/net/wireless/ath/ath9k/htc_hst.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/ath/ath9k/htc_hst.c b/drivers/net/wireless/ath/ath9k/htc_hst.c
index d2e062eaf561..510e61e97dbc 100644
--- a/drivers/net/wireless/ath/ath9k/htc_hst.c
+++ b/drivers/net/wireless/ath/ath9k/htc_hst.c
@@ -339,6 +339,8 @@ void ath9k_htc_txcompletion_cb(struct htc_target *htc_handle,
 
 	if (skb) {
 		htc_hdr = (struct htc_frame_hdr *) skb->data;
+		if (htc_hdr->endpoint_id >= ARRAY_SIZE(htc_handle->endpoint))
+			goto ret;
 		endpoint = &htc_handle->endpoint[htc_hdr->endpoint_id];
 		skb_pull(skb, sizeof(struct htc_frame_hdr));
 
-- 
2.28.0

