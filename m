Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DAC5E109862
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Nov 2019 05:52:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729641AbfKZEwc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 Nov 2019 23:52:32 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:57846 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729626AbfKZEwb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 Nov 2019 23:52:31 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAQ4n5en136542;
        Tue, 26 Nov 2019 04:52:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2019-08-05;
 bh=px4UVOHmBMQFSbsmmo+gAq1ZrSLk2MVlqZaq1ybrBa4=;
 b=KXvWCB5eytJ+Lf/dFLDRjZrNAzrt1wt39nIxAJbB3rLLIbrsgdnxcYpx6T+oqV4XKS4m
 fAgoDDcc4Pl71r1v3vDovWlqKVE8jam6AJe0rGO0J6dDqLcxa2uZ2FC3hGhoosnI5wUc
 fu79M+KkUBD+gS6bisbLELX7VjzqN90Ov5S6kjsykQ5cmHIgHuA+vgY6cSiYkIVfvOxL
 RTaz1zW1vas0K+11SVyR3nJgX1fNbhQrY+l2RuvWyke7Vdq5oCMgggT4Zox4Hj59kQGR
 cEBkg8egH7rY1N1ix/cl646ZlBt4KCwtPjlurmSNtYm6vaolqWq19t5NBvokV4uFfNfC wQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2wev6u43xd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Nov 2019 04:52:14 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAQ4n1Jt137817;
        Tue, 26 Nov 2019 04:50:14 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2wgvh99tmh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Nov 2019 04:50:14 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xAQ4o94a016699;
        Tue, 26 Nov 2019 04:50:10 GMT
Received: from kili.mountain (/129.205.23.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 25 Nov 2019 20:50:09 -0800
Date:   Tue, 26 Nov 2019 07:49:56 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Roy Luo <royluo@google.com>, Kalle Valo <kvalo@codeaurora.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] mt76: Off by one in mt76_calc_rx_airtime()
Message-ID: <20191121213935.2cbgh3qmd4hv4v5a@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: NeoMutt/20170113 (1.7.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9452 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=756
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1911260039
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9452 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=817 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1911260039
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The sband->bitrates[] array has "sband->n_bitrates" elements so this
check needs to be >= instead of > or we could read beyond the end of the
array.

These values come from when we call mt76_register_device():

	ret = mt76_register_device(&dev->mt76, true, mt7603_rates,
				   ARRAY_SIZE(mt7603_rates));

Here sband->bitrates[] is mt7603_rates[] and ->n_bitrates is the
ARRAY_SIZE()

Fixes: 5ce09c1a7907 ("mt76: track rx airtime for airtime fairness and survey")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/net/wireless/mediatek/mt76/airtime.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/airtime.c b/drivers/net/wireless/mediatek/mt76/airtime.c
index 55116f395f9a..a4a785467748 100644
--- a/drivers/net/wireless/mediatek/mt76/airtime.c
+++ b/drivers/net/wireless/mediatek/mt76/airtime.c
@@ -242,7 +242,7 @@ u32 mt76_calc_rx_airtime(struct mt76_dev *dev, struct mt76_rx_status *status,
 			return 0;
 
 		sband = dev->hw->wiphy->bands[status->band];
-		if (!sband || status->rate_idx > sband->n_bitrates)
+		if (!sband || status->rate_idx >= sband->n_bitrates)
 			return 0;
 
 		rate = &sband->bitrates[status->rate_idx];
-- 
2.11.0

