Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 177C3366CC7
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Apr 2021 15:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241443AbhDUN1u (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Apr 2021 09:27:50 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:54476 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238455AbhDUN1t (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Apr 2021 09:27:49 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13LDCEw9005847;
        Wed, 21 Apr 2021 13:15:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=FlzphcOCSgX+2k3rUk5ygmbE2dHWikxsYFYPqUAoI5A=;
 b=vDAk9jhA93QJm/tDNOkTo9apIGr5dShybhB+BrCKFXqBJL86F6Gl+N9stG+JyVEMDCOi
 sKmqXkx9QnkYcWXMLJ/5sBCOCoOU6FVdx8tKPOUuXDH1M/vnd/S4r3NmRIexi6SVpqwL
 XYbwAucWPfh66eyIPDbZz//gmFF6pJdVIoYWBiToKA4IleZ+tthQwPDOStg6pGgJ75Mg
 E2eA6tCy010xvN3MwyvfZ7nFXPtEtgL+Bd+SmKGD9mPx1wUdfkf6oejeBODEbYU/4tOB
 +hWTurCU2xa6xeDdRachcbvTmWhU5r+h5Ll03v8SlyCU/NSXaTjO9/dq68lqd5Pb83nK gw== 
Received: from oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 381bjn8pra-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Apr 2021 13:15:02 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 13LDF26f098309;
        Wed, 21 Apr 2021 13:15:02 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3030.oracle.com with ESMTP id 38098rqhhq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Apr 2021 13:15:02 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 13LDF1uk098159;
        Wed, 21 Apr 2021 13:15:01 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 38098rqhdt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Apr 2021 13:15:01 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 13LDEqlP015391;
        Wed, 21 Apr 2021 13:14:52 GMT
Received: from mwanda (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 21 Apr 2021 06:14:52 -0700
Date:   Wed, 21 Apr 2021 16:14:40 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <objelf@gmail.com>,
        Soul Huang <Soul.Huang@mediatek.com>,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH 1/3] mt76: mt7615: fix a precision vs width bug in printk
Message-ID: <YIAlQKR3IpfKW5Sx@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-GUID: IN-xhjViv_z8hvaYiIkNq2YIg1Cs348v
X-Proofpoint-ORIG-GUID: IN-xhjViv_z8hvaYiIkNq2YIg1Cs348v
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Precision "%.*s" was intended instead of width "%*s".  The original code
will print garbage from beyond the end of the skb->data.

Fixes: d76d6c3ba2b0 ("mt76: mt7615: limit firmware log message printk to buffer length")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index 9b9f8d88e9bb..00b1b657cb21 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -424,7 +424,7 @@ mt7615_mcu_rx_log_message(struct mt7615_dev *dev, struct sk_buff *skb)
 		break;
 	}
 
-	wiphy_info(mt76_hw(dev)->wiphy, "%s: %*s", type,
+	wiphy_info(mt76_hw(dev)->wiphy, "%s: %.*s", type,
 		   (int)(skb->len - sizeof(*rxd)), data);
 }
 
-- 
2.30.2

