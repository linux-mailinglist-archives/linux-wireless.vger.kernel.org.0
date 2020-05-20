Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36F5D1DB2CB
	for <lists+linux-wireless@lfdr.de>; Wed, 20 May 2020 14:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbgETML6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 May 2020 08:11:58 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:40176 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbgETMLq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 May 2020 08:11:46 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04KC7VE0191979;
        Wed, 20 May 2020 12:11:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=Sxm3BevQoxnZLIyVzRYA3qn4bXDWkSjkHWdHjyCXzB8=;
 b=TT0I6I7KyYPKgLGKvtqwfnaI5gA8BTO9BkOD9W9F/HJeDdosr+pAPneWm4Arh6im0gry
 2QSu6rNlP9VPhxXQk9sHmRG3FzjmPIEjyKKXtqrLRlUWY5tTV43OLmotpxvfahOk2MMB
 9qmZkm+BdmUQj4T7B2i2OU3JLeDvBXor+/EsJ9wlIjhj6IWhTq0xiH9rQ9G0HjAI6Awo
 ivXRaY9/TKGlNTK1AUdt71f4nJz4wju35xccul+ncmPnlHrQ5BE9QqXTdVXFe53cuvk7
 GiaJDoA+a1+Fxn4QxBaFZp+1NS1nfVeTSqw7WPdbTLZY9T0/Aq/dTNn5k61S0dnE9418 +Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 31501r98gr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 20 May 2020 12:11:41 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04KC9BNF125260;
        Wed, 20 May 2020 12:09:41 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 315020669j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 May 2020 12:09:41 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 04KC9elu007528;
        Wed, 20 May 2020 12:09:40 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 20 May 2020 05:09:39 -0700
Date:   Wed, 20 May 2020 15:09:33 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     ryder.lee@mediatek.com
Cc:     Ryder Lee <ryder.lee@mediatek.com>, linux-wireless@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [bug report] mt76: mt7915: fix possible deadlock in mt7915_stop
Message-ID: <20200520120845.GK172354@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9626 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 mlxlogscore=738
 adultscore=0 bulkscore=0 suspectscore=3 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005200106
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9626 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 spamscore=0
 mlxlogscore=759 clxscore=1015 priorityscore=1501 cotscore=-2147483648
 impostorscore=0 bulkscore=0 adultscore=0 malwarescore=0 phishscore=0
 mlxscore=0 suspectscore=3 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2005200106
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello Ryder Lee,

The patch 57b9df6fa5f5: "mt76: mt7915: fix possible deadlock in
mt7915_stop" from May 12, 2020, leads to the following static checker
warning:

    drivers/net/wireless/mediatek/mt76/mt7915/init.c:595 mt7915_register_ext_phy()
    error: we previously assumed 'phy' could be null (see line 592)

    drivers/net/wireless/mediatek/mt76/mt7615/init.c:371 mt7615_register_ext_phy()
    error: we previously assumed 'phy' could be null (see line 368)

drivers/net/wireless/mediatek/mt76/mt7915/init.c
   589          if (test_bit(MT76_STATE_RUNNING, &dev->mphy.state))
   590                  return -EINVAL;
   591  
   592          if (phy)
                    ^^^
   593                  return 0;
   594  
   595          INIT_DELAYED_WORK(&phy->mac_work, mt7915_mac_work);
                                  ^^^^^^^^^^^^^^
This will Oops.

   596          mt7915_cap_dbdc_enable(dev);
   597          mphy = mt76_alloc_phy(&dev->mt76, sizeof(*phy), &mt7915_ops);
   598          if (!mphy)
   599                  return -ENOMEM;
   600  
   601          phy = mphy->priv;
                ^^^^^^^^^^^^^^^^
phy is set here again.

   602          phy->dev = dev;
   603          phy->mt76 = mphy;
   604          phy->chainmask = dev->chainmask & ~dev->phy.chainmask;
   605          mphy->antenna_mask = BIT(hweight8(phy->chainmask)) - 1;
   606          mt7915_init_wiphy(mphy->hw);

See also:
drivers/net/wireless/mediatek/mt76/mt7615/init.c:371 mt7615_register_ext_phy() error: we previously assumed 'phy' could be null (see line 368)

regards,
dan carpenter
