Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 990D31DB2B4
	for <lists+linux-wireless@lfdr.de>; Wed, 20 May 2020 14:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbgETMGW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 May 2020 08:06:22 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:32898 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbgETMGW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 May 2020 08:06:22 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04KC3F3Z151918;
        Wed, 20 May 2020 12:06:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=yZ4iTAxcmb9BmNsSUTH20REYWMTGdIsUfcYaP4mTS5s=;
 b=lUuK5vDVMpXEslMAplMqdkjdsg53Rx8Tp/ZKb1YyZ3oxf7SLLoPEyH+3SH3rXIs3WUxo
 dSHNYTZx+ctplo6INqf0bvA/SUOtp8NUQRZX18TBN4zd13ykkwUQtWYZxwpctwxx4JHU
 6+zxDoXbGnbfB7xe8swPq3oNx4JN1WfsXOCka6XX03eK9n0UrWYJi8c/ATYgCY+Rjrfd
 iOIOk75Vy293QvjjJitlNmSU6CK2gTWZgXm16WwFNj8ys5gCoKASrvsgLHR/7VGEfcu1
 ArcjgExsS6wZv2uk2r1xdXLdcilUYp3xjToXj4l1SetSuJJ+c+zH8i21ZvFgFg6HO8wH Dg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 3127kraqp0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 20 May 2020 12:06:02 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04KC397m104555;
        Wed, 20 May 2020 12:06:02 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 3150205y6p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 May 2020 12:06:01 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 04KC5xVd016623;
        Wed, 20 May 2020 12:05:59 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 20 May 2020 05:05:59 -0700
Date:   Wed, 20 May 2020 15:05:51 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>
Cc:     Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        YF Luo <yf.luo@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Yiwei Chung <yiwei.chung@mediatek.com>,
        Chih-Min Chen <chih-min.chen@mediatek.com>,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] mt76: mt7915: fix locking bug in mt7915_sta_rc_update()
Message-ID: <20200520120551.GG172354@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9626 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 bulkscore=0 suspectscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005200105
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9626 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 clxscore=1011 priorityscore=1501 mlxscore=0 impostorscore=0
 suspectscore=0 mlxlogscore=999 malwarescore=0 cotscore=-2147483648
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2005200105
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This function calls rcu_read_lock() twice instead of unlocking.

Fixes: e57b7901469f ("mt76: add mac80211 driver for MT7915 PCIe-based chipsets")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/net/wireless/mediatek/mt76/mt7915/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index 98567374c2c9..3f00f5439c7c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -790,7 +790,7 @@ mt7915_sta_rc_update(struct ieee80211_hw *hw,
 		rcu_read_unlock();
 		return;
 	}
-	rcu_read_lock();
+	rcu_read_unlock();
 
 	set_bit(changed, &msta->stats.changed);
 	ieee80211_queue_work(hw, &msta->stats_work);
-- 
2.26.2

