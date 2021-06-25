Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC0213B4639
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Jun 2021 17:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231825AbhFYPDt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 25 Jun 2021 11:03:49 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:35142 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229653AbhFYPDs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 25 Jun 2021 11:03:48 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15PEuIdr028437;
        Fri, 25 Jun 2021 14:59:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=tbDoPXETfKm0wSWVuyJVc016FawRN91LSq+bkmm8CnA=;
 b=Pkge9wdirVh+MYeWjF3UVAapC0I49JTHjCpViaw0J2sL2UElv+98p4OUMtK7/LgvTu2a
 TKVQ9wGNEsY9c0amAXtn4vCpYPqoLSGqUgnzpECirWCpe1X6D4F76CDjj0Gig8BA/9e4
 1ERCmAax+pis+SYox34iletlh4upLb83N6xtpk5EbEjyfrtde2wtz1RoOyxtj8UIMOxI
 ZPNFZzUlZ0kkXAcY8MFOliZtcZJL7LMxBTAYRBsIAO5/1ORX2PeiErnjsZGkh/iWCna1
 i+M5rUmhopnh2jyWZkxFj8GIBEeGbRRwJ76klvnMxrvMqtvz5+eOV2mGNKuwXrq2GWuI oA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 39d2pe9j04-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Jun 2021 14:59:10 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15PEtmVJ099579;
        Fri, 25 Jun 2021 14:59:09 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3030.oracle.com with ESMTP id 39d2pyayy7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Jun 2021 14:59:09 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 15PEtxEt100498;
        Fri, 25 Jun 2021 14:59:08 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 39d2pyayxe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Jun 2021 14:59:08 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 15PEx3c6026879;
        Fri, 25 Jun 2021 14:59:03 GMT
Received: from mwanda (/102.222.70.252)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 25 Jun 2021 07:59:02 -0700
Date:   Fri, 25 Jun 2021 17:58:54 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] mt76: mt7915: fix info leak in mt7915_mcu_set_pre_cal()
Message-ID: <YNXvLvrvllpXgCIn@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-GUID: U5TCpDAlYzxOuFnYxZj1yGN63XwzthFs
X-Proofpoint-ORIG-GUID: U5TCpDAlYzxOuFnYxZj1yGN63XwzthFs
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Zero out all the unused members of "req" so that we don't disclose
stack information.

Fixes: 495184ac91bb ("mt76: mt7915: add support for applying pre-calibration data")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 863aa18b3024..21769e4f6bc7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -3481,7 +3481,7 @@ static int mt7915_mcu_set_pre_cal(struct mt7915_dev *dev, u8 idx,
 		u8 idx;
 		u8 rsv[4];
 		__le32 len;
-	} req;
+	} req = {};
 	struct sk_buff *skb;
 
 	skb = mt76_mcu_msg_alloc(&dev->mt76, NULL, sizeof(req) + len);
-- 
2.30.2

