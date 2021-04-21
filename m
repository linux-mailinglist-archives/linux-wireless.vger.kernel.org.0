Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31D8C366CE0
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Apr 2021 15:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242128AbhDUNbc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Apr 2021 09:31:32 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:38590 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241644AbhDUNbb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Apr 2021 09:31:31 -0400
X-Greylist: delayed 867 seconds by postgrey-1.27 at vger.kernel.org; Wed, 21 Apr 2021 09:31:31 EDT
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13LDGLgx028054;
        Wed, 21 Apr 2021 13:16:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type : in-reply-to;
 s=corp-2020-01-29; bh=lvHlrK+MD4CobteVF1oYxOoc1hik2TwFpy2Fj01dlKk=;
 b=fhh4VScIPfIZEwLTHciJt04EY0Y68kttQmtAOCIA+9C7xW+xv3U7nkn46XBvzZ3RaBer
 UDdQEsGzDRSGsdEIiKfYUGXsxKLiXUcc/DsIckoe/9pz09SOlL8pnd8BlQ4VaHswvQVz
 ERhG84v+L1zs8+sejxc6EorE0XVkkHLBSF7/NqtS/6U961mUfkDHzNVAnu0zFer20UFQ
 KUbB+uW20uv+pBwvm8VLw9GCE+YdO2yiqCp9zbWXVNY681pH2aii1cIYqU+BnZkTvff9
 4ldeqOx0ZTxNSnD501zBgTdU11nc6ZKI4KY1XYk1/P0OtYoB+iheKK3NRzwCOS2POKLB bA== 
Received: from oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 381dum8p13-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Apr 2021 13:16:20 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 13LDFsu1132150;
        Wed, 21 Apr 2021 13:16:19 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3030.oracle.com with ESMTP id 3809m0kkev-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Apr 2021 13:16:19 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 13LDGICW133342;
        Wed, 21 Apr 2021 13:16:18 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 3809m0kkej-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Apr 2021 13:16:18 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 13LDGH0H016345;
        Wed, 21 Apr 2021 13:16:17 GMT
Received: from mwanda (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 21 Apr 2021 06:16:16 -0700
Date:   Wed, 21 Apr 2021 16:16:06 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     Ryder Lee <ryder.lee@mediatek.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Soul Huang <Soul.Huang@mediatek.com>,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH 3/3] mt76: mt7921: fix a precision vs width bug in printk
Message-ID: <YIAllkdDJrV5OSdL@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YIAlQKR3IpfKW5Sx@mwanda>
X-Mailer: git-send-email haha only kidding
X-Proofpoint-ORIG-GUID: j18SJFENXvV2rrmHVmlUHHQO5zv-r5Dv
X-Proofpoint-GUID: j18SJFENXvV2rrmHVmlUHHQO5zv-r5Dv
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Precision %.*s was intended instead of width %*s.  The original code
is potentially an information leak.

Fixes: c7cc5ec57303 ("mt76: mt7921: rework mt7921_mcu_debug_msg_event routine")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/net/wireless/mediatek/mt76/mt7921/mcu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
index aa55667b6ed7..45ad2c337d41 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
@@ -500,7 +500,7 @@ mt7921_mcu_debug_msg_event(struct mt7921_dev *dev, struct sk_buff *skb)
 			if (!msg->content[i])
 				msg->content[i] = ' ';
 		}
-		wiphy_info(mt76_hw(dev)->wiphy, "%*s", len, msg->content);
+		wiphy_info(mt76_hw(dev)->wiphy, "%.*s", len, msg->content);
 	}
 }
 
-- 
2.30.2

