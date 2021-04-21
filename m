Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44A79366915
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Apr 2021 12:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239266AbhDUKVK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Apr 2021 06:21:10 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:60668 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239244AbhDUKVH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Apr 2021 06:21:07 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13LAJGiM135897;
        Wed, 21 Apr 2021 10:20:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=aW2XV99ki74xagENX2uKtHc0R0vvRO3bFUoVvlCTYu8=;
 b=xHss9sp7t5iGALFvdj6bCiIbKlNueJhBwn99P/AnYUO9fzWeciAg//OzPEzxac8yVGWN
 r4RUgRstc6flGUPvKwEKw5r/DGAdfrItSNTBXCmR6KkLPdC3Kg9z+X54xr/QvwuApLvm
 nM5QiH18d3QHglci07LTuYfZ8HERz5RZNeaZa6Mzh8eYFVkVP/dcztMr7oEddMWGh1ct
 LJnWi8p1exD4cNUTc8oKyBaQzbPc9vU58X0XMKZwaAegGAdUnRMYw2YS1NABlxh3MtxR
 UwmdwW5UTYOG7LeDXGIC9QAZFdt7pnV/fw3XO5X8W6xW7UXtGdod8JbZMSXovYNMni8w zA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 37yqmnhttd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Apr 2021 10:20:19 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13LAAwug050948;
        Wed, 21 Apr 2021 10:20:19 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3030.oracle.com with ESMTP id 38098rhfrc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Apr 2021 10:20:19 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 13LAKIcA087538;
        Wed, 21 Apr 2021 10:20:18 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 38098rhfqp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Apr 2021 10:20:18 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 13LAKG8t025239;
        Wed, 21 Apr 2021 10:20:16 GMT
Received: from mwanda (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 21 Apr 2021 03:20:15 -0700
Date:   Wed, 21 Apr 2021 13:20:10 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     ryder.lee@mediatek.com
Cc:     linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: [bug report] mt76: mt7615: fix CSA notification for DBDC
Message-ID: <YH/8WvgUZtp51WEP@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-ORIG-GUID: -CnXcfGQpXtifIJymuKOpR6hO9cycBEO
X-Proofpoint-GUID: -CnXcfGQpXtifIJymuKOpR6hO9cycBEO
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9960 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 adultscore=0
 impostorscore=0 spamscore=0 malwarescore=0 clxscore=1011
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 mlxlogscore=723
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104210079
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello Ryder Lee,

The patch 402a695b1ae6: "mt76: mt7615: fix CSA notification for DBDC"
from Feb 27, 2021, leads to the following static checker warning:

	drivers/net/wireless/mediatek/mt76/mt7615/mcu.c:385 mt7615_mcu_rx_csa_notify()
	error: undefined (user controlled) shift '(((1))) << (c->omac_idx)'

drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
   376  static void
   377  mt7615_mcu_rx_csa_notify(struct mt7615_dev *dev, struct sk_buff *skb)
   378  {
   379          struct mt7615_phy *ext_phy = mt7615_ext_phy(dev);
   380          struct mt76_phy *mphy = &dev->mt76.phy;
   381          struct mt7615_mcu_csa_notify *c;
   382  
   383          c = (struct mt7615_mcu_csa_notify *)skb->data;
                ^                                   ^^^^^^^^^
c is random data from the network

   384  
   385          if (ext_phy && ext_phy->omac_mask & BIT_ULL(c->omac_idx))
                                                            ^^^^^^^^^^^
Any value more than 61 will lead to undefined behavior.  (shift wrapping
mostly).

   386                  mphy = dev->mt76.phy2;
   387  
   388          ieee80211_iterate_active_interfaces_atomic(mphy->hw,
   389                          IEEE80211_IFACE_ITER_RESUME_ALL,
   390                          mt7615_mcu_csa_finish, mphy->hw);
   391  }

regards,
dan carpenter
