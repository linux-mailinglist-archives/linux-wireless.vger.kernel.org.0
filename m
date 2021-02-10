Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 865773164AB
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Feb 2021 12:10:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbhBJLJd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 10 Feb 2021 06:09:33 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:45500 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230497AbhBJLIB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 10 Feb 2021 06:08:01 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11AB61il007600;
        Wed, 10 Feb 2021 11:07:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=/HcY0L+hVre+1Y5T5E95Gl7D3u8ZZ3P87p6ptxp6v/Q=;
 b=uGWFUg6fUw0ct+gite4kZ1JVjIE1T4hxBI4OQTMiL8wkYa1pbsfgH/ooo7yKGVm0c5xU
 Cu/pbCb7xhHXCRXtJ/BQvVR69CDRRl+IBlTU4Xp5sN4KkHgeEZQ2y0ExnvZqxvmtfMCU
 Hu6PfZ573kXosntVWHrwUrdUE3R8TVW82X6mc7hfERfQVLGKvyJ/Z+S1iK5PHP9ubSls
 l3z9UHAGLOsQYSYOJ9HozGsm5kAt1Uf+UNVU9UOqI0ZXSSIBopDWQTdaaZRXO7NPbgKM
 j3/X6wTeosGx3Y2a2JhIrUUuO/Tn/7BfzF0awZ8E4QJ1xZiOE+0v/i1LjgQfJxqrJGTT 8Q== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 36m4upsfdx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Feb 2021 11:07:18 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11AB5Tmp106324;
        Wed, 10 Feb 2021 11:07:16 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 36j512gktd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Feb 2021 11:07:16 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 11AB7F56001345;
        Wed, 10 Feb 2021 11:07:15 GMT
Received: from mwanda (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 10 Feb 2021 03:07:15 -0800
Date:   Wed, 10 Feb 2021 14:07:09 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     sean.wang@mediatek.com
Cc:     linux-wireless@vger.kernel.org
Subject: [bug report] mt76: mt7921: add MCU support
Message-ID: <YCO+XQxBe+3D+dA1@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9890 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102100109
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9890 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 mlxscore=0
 mlxlogscore=999 spamscore=0 impostorscore=0 malwarescore=0 clxscore=1011
 suspectscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102100108
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello Sean Wang,

The patch 1c099ab44727: "mt76: mt7921: add MCU support" from Jan 28,
2021, leads to the following static checker warning:

	drivers/net/wireless/mediatek/mt76/mt7921/mcu.c:409 mt7921_mcu_tx_rate_report()
	error: potentially dereferencing uninitialized 'stats'.

drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
   390  static void
   391  mt7921_mcu_tx_rate_report(struct mt7921_dev *dev, struct sk_buff *skb,
   392                            u16 wlan_idx)
   393  {
   394          struct mt7921_mcu_wlan_info_event *wtbl_info =
   395                  (struct mt7921_mcu_wlan_info_event *)(skb->data);
   396          struct rate_info rate = {};
   397          u8 curr_idx = wtbl_info->rate_info.rate_idx;
   398          u16 curr = le16_to_cpu(wtbl_info->rate_info.rate[curr_idx]);
   399          struct mt7921_mcu_peer_cap peer = wtbl_info->peer_cap;
   400          struct mt76_phy *mphy = &dev->mphy;
   401          struct mt7921_sta_stats *stats;
   402          struct mt7921_sta *msta;
   403          struct mt76_wcid *wcid;
   404  
   405          if (wlan_idx >= MT76_N_WCIDS)
   406                  return;
   407          wcid = rcu_dereference(dev->mt76.wcid[wlan_idx]);
   408          if (!wcid) {
   409                  stats->tx_rate = rate;
                        ^^^^^^^^^^^^^^^^^^^^^
Not initialized

   410                  return;
   411          }
   412  
   413          msta = container_of(wcid, struct mt7921_sta, wcid);
   414          stats = &msta->stats;
                ^^^^^^^^^^^^^^^^^^^^

   415  
   416          /* current rate */
   417          mt7921_mcu_tx_rate_parse(mphy, &peer, &rate, curr);
   418          stats->tx_rate = rate;
   419  }

regards,
dan carpenter
