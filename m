Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CC61181A66
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Mar 2020 14:52:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729747AbgCKNw4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Mar 2020 09:52:56 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:50020 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729695AbgCKNwz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Mar 2020 09:52:55 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02BDmOEx164241;
        Wed, 11 Mar 2020 13:52:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=SBe9Kbu74oZCq4ntccHPVuFD0Y4+f3seyI6PfS0faYE=;
 b=fNiqoxvBD6Xjn6GyUb4fL4ggv7TMunlYWYdjCXehjZgJ0vEpmb5YWPe0DHDFg1yseIal
 3hkEr8GnTqJdjNC+pbGmU5LCV5dWMtTcbO3xd+HkRsSC+w2mfpdeTBdCePSEjMxhTspn
 DgVilGDUsG1Qb0xZru3n6peyHHRUq8S9CdcSdef142Ox9U3EQk7NZGBwo7ThSvFPrsVd
 4IWnsnKnde/q1PBnv6+GdJ3fgIh9Jjr4R4wW8UX5xbKkwXobdykoYoxWqezO9RgR4BxL
 AVrcHq+qwfnehkCTbq9DMPESv+wyRImkAxjG/0vwmYIYkqNTQpu/8rktUpUjcUzZOn0W Vg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2yp9v66st4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Mar 2020 13:52:39 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02BDoJEi073447;
        Wed, 11 Mar 2020 13:52:38 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2yp8q02hk9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Mar 2020 13:52:38 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 02BDqavN001379;
        Wed, 11 Mar 2020 13:52:36 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 11 Mar 2020 06:52:35 -0700
Date:   Wed, 11 Mar 2020 16:52:27 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>
Cc:     Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Roy Luo <royluo@google.com>, Kalle Valo <kvalo@codeaurora.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] mt76: mt7615: remove a stray if statement
Message-ID: <20200311135227.GA16505@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9556 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 mlxscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003110088
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9556 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 mlxlogscore=999
 phishscore=0 adultscore=0 clxscore=1011 impostorscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003110088
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This if statement was supposed to be deleted, but it wasn't.  It means
that we sometimes don't set the sensitivity correctly.

Fixes: 2cad515ece8a ("mt76: mt7615: add missing settings for simultaneous dual-band support")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/net/wireless/mediatek/mt76/mt7615/mac.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index 145366dbc39b..64b6bc3c1e02 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -1630,7 +1630,6 @@ mt7615_mac_adjust_sensitivity(struct mt7615_phy *phy,
 				 MT_WF_PHY_PD_OFDM(ext_phy, val));
 		} else {
 			val = *sensitivity + 256;
-			if (!ext_phy)
 			mt76_rmw(dev, MT_WF_PHY_RXTD_CCK_PD(ext_phy),
 				 MT_WF_PHY_PD_CCK_MASK(ext_phy),
 				 MT_WF_PHY_PD_CCK(ext_phy, val));
-- 
2.20.1

