Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D830366D01
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Apr 2021 15:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240214AbhDUNlb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Apr 2021 09:41:31 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:62294 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229536AbhDUNlb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Apr 2021 09:41:31 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13LDcNHu006382;
        Wed, 21 Apr 2021 13:40:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type : in-reply-to;
 s=corp-2020-01-29; bh=CiyY0TY/FT7GLJEH1shy+3dTJnAndDqr1nVXcawFzIM=;
 b=QHTo7GuamBfRfZRfAZidoFKXUVHvYIvfxo+GTvRkMjq1NS1k4fGwhFxw2ynR5WTCTfK6
 +DWwokTQtnMRkkuW0lkeNd6QDM6TaJzgij+6k0Z+lJ/y0W4LXrdUGNUJb3l6qZRub7ko
 Cd+Or1zg0ED+3uH/oT+5mELGKIVeyR9jXp2r/yKbt1CF3c7RglG8EDMKCNHg2dvxjT7a
 00+I8ltgiq5M8IugRVJEzlIUrWIG589kQcOUivfUVCJJPZOuP683bCBMq2N7FKXjDmD0
 Ep4v/iz2qjlA2POrM6bdTWf10mIB/Q1TIKdib5EgEm3d58ZqbKjTFkXcUoGamvqdXGtv vQ== 
Received: from oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3818whgr19-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Apr 2021 13:40:50 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 13LDbYmI048456;
        Wed, 21 Apr 2021 13:40:49 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 3809eu9qy1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Apr 2021 13:40:49 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 13LDellH009579;
        Wed, 21 Apr 2021 13:40:48 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 21 Apr 2021 06:40:47 -0700
Date:   Wed, 21 Apr 2021 16:40:40 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH 2/3 v2] mt76: mt7915: fix a precision vs width bug in printk
Message-ID: <20210421134040.GI1959@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ecf5b648ea6d42994abbef8d9cde7e15a0a837.camel@sipsolutions.net>
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9961 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104210106
X-Proofpoint-ORIG-GUID: 65bgiovjOKDKye3hix_FCzryIttMqmp3
X-Proofpoint-GUID: 65bgiovjOKDKye3hix_FCzryIttMqmp3
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Precision %.*s was intended instead of width %*s.  The original code
will still print unintended data from beyond the end of skb->data.

Fixes: 665b2c780d63 ("mt76: mt7915: limit firmware log message printk to buffer length")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
v2: fix a typo in the commit message

 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 908e74a6b8e6..94195a1ad3b8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -521,7 +521,7 @@ mt7915_mcu_rx_log_message(struct mt7915_dev *dev, struct sk_buff *skb)
 		break;
 	}
 
-	wiphy_info(mt76_hw(dev)->wiphy, "%s: %*s", type,
+	wiphy_info(mt76_hw(dev)->wiphy, "%s: %.*s", type,
 		   (int)(skb->len - sizeof(*rxd)), data);
 }
 
-- 
2.30.2
