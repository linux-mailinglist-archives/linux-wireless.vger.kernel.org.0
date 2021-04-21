Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71AE8366CC2
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Apr 2021 15:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240753AbhDUN1Q (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Apr 2021 09:27:16 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:15454 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239158AbhDUN1P (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Apr 2021 09:27:15 -0400
X-Greylist: delayed 684 seconds by postgrey-1.27 at vger.kernel.org; Wed, 21 Apr 2021 09:27:15 EDT
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13LDDZDL017595;
        Wed, 21 Apr 2021 13:15:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type : in-reply-to;
 s=corp-2020-01-29; bh=voSpbjx/x56pXz5sZw/CvfaDp0mSkH/RSK4TECgB8kk=;
 b=LzC4TYjngueQCSNQfKQi2Qd94J8kyx4A6a3haihNzDz5SJ0ZUyLL2UyrwruK1AIC4LO9
 0BL2f7m8v050YsJz54oZ6U2rVGY52c+SHIWbgyuDQnmHyPt5ztA1ISWXeTj1EQjwK7++
 41pbviWy4SHIILXCtXji1DrbH82qT0xL1xizbN5G4hmG1fvRiTIyHeCxTYSt4Y/hZyCw
 6v8FEJq4qsocRz2xHNLhKpr4EatrYd9cy/R+2ikDMOeFFUKIQyo/gy8eYymVtIKYyUjH
 i3z8sL2R1BBCSEZZRl63KIfAVGEvsYUnhTiHkGR7XuU2Gj9fF6xJlL4KP/4+JpZxQuIr MA== 
Received: from oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3819340qkw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Apr 2021 13:15:26 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 13LDFMZi099267;
        Wed, 21 Apr 2021 13:15:25 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3030.oracle.com with ESMTP id 38098rqj3v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Apr 2021 13:15:25 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 13LDFOZk099410;
        Wed, 21 Apr 2021 13:15:24 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 38098rqj2w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Apr 2021 13:15:24 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 13LDFMOV023395;
        Wed, 21 Apr 2021 13:15:23 GMT
Received: from mwanda (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 21 Apr 2021 06:15:22 -0700
Date:   Wed, 21 Apr 2021 16:15:14 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH 2/3] mt76: mt7915: fix a precision vs width bug in printk
Message-ID: <YIAlYknkd0SoD6SY@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YIAlQKR3IpfKW5Sx@mwanda>
X-Mailer: git-send-email haha only kidding
X-Proofpoint-ORIG-GUID: _DsSEl4YivLeT4BCMHLoEUKFyR-Hx3Ze
X-Proofpoint-GUID: _DsSEl4YivLeT4BCMHLoEUKFyR-Hx3Ze
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Precision %.*s was intended instead of width %.*s.  The original code
will still print unintended data from beyond the end of skb->data.

Fixes: 665b2c780d63 ("mt76: mt7915: limit firmware log message printk to buffer length")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
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

