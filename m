Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90A7212E89
	for <lists+linux-wireless@lfdr.de>; Fri,  3 May 2019 14:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727668AbfECMzS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 3 May 2019 08:55:18 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:37760 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727641AbfECMzS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 3 May 2019 08:55:18 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x43Cra0o131650;
        Fri, 3 May 2019 12:54:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2018-07-02;
 bh=/EJcOtCKHzyP28w2BqK4Nm8RSbHZ1MiSLldUmj3B1uQ=;
 b=jFv2J2yl4Awq0vybuY/lRpX7TFepbXcWknMK9WpSaMYRpkkGPjJsho2mRx8cIu0wTWbK
 urtRsetJ+T56pfSwZU4t8X+z3fPjInw9EA1bmkutdavMHBjFTunW2bE81PiDsXy+Nu4o
 LoN9KJdPRIKNrvyJNeXI/NWWAe8ET+go86YB1YWmc60/rko4tdzmdn4lhQhCgUQDQ0Xe
 wTevNiTmJ2iKqSn0zb/WMXdtdi9NN1oBc7+2gO47GuOi/0nSdDXa/nbfYyhF1x+ExKG5
 YPDbQYVAP0kefCtJ7DGOJthsEBxfTu+Y+a2o9E9l7tGD6J/YuGNCqRNtNyOGl9xzWSAq hw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2s6xhyxh0u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 May 2019 12:54:57 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x43CrxGG127592;
        Fri, 3 May 2019 12:54:57 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2s7p8aak8w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 May 2019 12:54:57 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x43CsqSS018138;
        Fri, 3 May 2019 12:54:52 GMT
Received: from mwanda (/196.104.111.181)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 03 May 2019 05:54:52 -0700
Date:   Fri, 3 May 2019 15:54:36 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>
Cc:     Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Roy Luo <royluo@google.com>, Kalle Valo <kvalo@codeaurora.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] mt76: Fix a signedness bug in mt7615_add_interface()
Message-ID: <20190502212341.GA31847@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9245 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905030081
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9245 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905030081
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The problem is that "mvif->omac_idx" is a u8 so it can't be negative
and the error handling won't work.  The get_omac_idx() function returns
-1 on error.

Fixes: 04b8e65922f6 ("mt76: add mac80211 driver for MT7615 PCIe-based chipsets")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/net/wireless/mediatek/mt76/mt7615/main.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index 80e6b211f60b..8d7a47d1b205 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -77,11 +77,12 @@ static int mt7615_add_interface(struct ieee80211_hw *hw,
 		goto out;
 	}
 
-	mvif->omac_idx = get_omac_idx(vif->type, dev->omac_mask);
-	if (mvif->omac_idx < 0) {
+	idx = get_omac_idx(vif->type, dev->omac_mask);
+	if (idx < 0) {
 		ret = -ENOSPC;
 		goto out;
 	}
+	mvif->omac_idx = idx;
 
 	/* TODO: DBDC support. Use band 0 and wmm 0 for now */
 	mvif->band_idx = 0;
-- 
2.18.0

