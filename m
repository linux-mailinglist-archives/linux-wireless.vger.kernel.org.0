Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 899AD1DB2BD
	for <lists+linux-wireless@lfdr.de>; Wed, 20 May 2020 14:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbgETMJS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 May 2020 08:09:18 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:45228 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbgETMJS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 May 2020 08:09:18 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04KC8SMR120219;
        Wed, 20 May 2020 12:09:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=KVoMHFSe7TOQiFQ+wI6NI/ZmHeDHo8k+OZvvPj/vpCY=;
 b=JDiPGMlaWOlXk0If30I9s2nvxe1wWZlobXEt+fhRf24cZf4TnwUk5eslpKSdHNJphVkk
 cHaYsUvMwJMdmrc5wVLIyXRIy8QNzWk+iSuTw8hIipAjIpISpxaSpyxDyyn9gnpF/95E
 Pm5BoVZE4GHNJ5YUSD/sPGdGssWbgNzSgqlIefklQCnQXsWtwcrLhEI7hphPbUIlE3Ou
 2D2oHG5t9Vr2gFiiBEMHERqMyssCPSubygJmeC8qxaf2Wqczh8Wu91jdHtXPYJ0x/2tq
 u977FTuUcBwof6lPR+Ie3QPf3J0ZCe/y5YPeAuhHaDJMDRtr0Nhwp8cpexq4J3f0Pc93 uQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 31284m2q8j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 20 May 2020 12:09:13 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04KC99wr107096;
        Wed, 20 May 2020 12:09:12 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 312t37f5tq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 May 2020 12:09:12 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 04KC90AU007292;
        Wed, 20 May 2020 12:09:00 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 20 May 2020 05:09:00 -0700
Date:   Wed, 20 May 2020 15:08:54 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     ryder.lee@mediatek.com
Cc:     Ryder Lee <ryder.lee@mediatek.com>, linux-wireless@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [bug report] mt76: adjust wcid size to support new 802.11ax
 generation
Message-ID: <20200520120854.GA161324@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9626 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxlogscore=999
 phishscore=0 mlxscore=0 malwarescore=0 suspectscore=3 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005200106
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9626 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 mlxscore=0
 cotscore=-2147483648 impostorscore=0 malwarescore=0 mlxlogscore=999
 lowpriorityscore=0 phishscore=0 spamscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005200106
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello Ryder Lee,

The patch 49e649c3e0a6: "mt76: adjust wcid size to support new
802.11ax generation" from Apr 25, 2020, leads to the following static
checker warning:

    drivers/net/wireless/mediatek/mt76/mt76x02.h:249 mt76x02_rx_get_sta()
    warn: impossible condition '(idx >= (2304 / 8 + (0))) => (0-255 >= 288)'

    drivers/net/wireless/mediatek/mt76/mt7603/mac.c:476 mt7603_rx_get_wcid()
    warn: impossible condition '(idx >= (2304 / 8 + (0))) => (0-255 >= 288)'

    drivers/net/wireless/mediatek/mt76/mt7603/mac.c:1241 mt7603_mac_add_txs()
    warn: impossible condition '(wcidx >= (2304 / 8 + (0))) => (0-255 >= 288)'

    drivers/net/wireless/mediatek/mt76/mt7615/mac.c:64 mt7615_rx_get_wcid()
    warn: impossible condition '(idx >= (2304 / 8 + (0))) => (0-255 >= 288)'

    drivers/net/wireless/mediatek/mt76/mt7615/mac.c:1305 mt7615_mac_add_txs()
    warn: impossible condition '(wcidx >= (2304 / 8 + (0))) => (0-255 >= 288)'

    drivers/net/wireless/mediatek/mt76/mt76x02_mac.c:564 mt76x02_send_tx_status()
    warn: always true condition '(stat->wcid < (2304 / 8 + (0))) => (0-255 < 288)'

vers/net/wireless/mediatek/mt76/mt76x02.h
   244  static inline struct mt76x02_sta *
   245  mt76x02_rx_get_sta(struct mt76_dev *dev, u8 idx)
   246  {
   247          struct mt76_wcid *wcid;
   248  
   249          if (idx >= ARRAY_SIZE(dev->wcid))

The dev->wcid[] array used to have 128 elements but now it has 288 so
a u8 idx isn't large enough.

   250                  return NULL;
   251  
   252          wcid = rcu_dereference(dev->wcid[idx]);
   253          if (!wcid)
   254                  return NULL;
   255  
   256          return container_of(wcid, struct mt76x02_sta, wcid);
   257  }
...
   470  static struct mt76_wcid *
   471  mt7603_rx_get_wcid(struct mt7603_dev *dev, u8 idx, bool unicast)
   472  {
   473          struct mt7603_sta *sta;
   474          struct mt76_wcid *wcid;
   475  
   476          if (idx >= ARRAY_SIZE(dev->mt76.wcid))
                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Same.

   477                  return NULL;
   478  
   479          wcid = rcu_dereference(dev->mt76.wcid[idx]);
   480          if (unicast || !wcid)
   481                  return wcid;
   482  
   483          if (!wcid->sta)
   484                  return NULL;
   485  
   486          sta = container_of(wcid, struct mt7603_sta, wcid);
   487          if (!sta->vif)
   488                  return NULL;
   489  
   490          return &sta->vif->sta.wcid;
   491  }
...
  1236          wcidx = FIELD_GET(MT_TXS3_WCID, txs);
                                  ^^^^^^^^^^^^
This is bits 24-31 so it may need to be adjusted.

  1237  
  1238          if (pid == MT_PACKET_ID_NO_ACK)
  1239                  return;
  1240  
  1241          if (wcidx >= ARRAY_SIZE(dev->mt76.wcid))
                    ^^^^^
u8 type.

  1242                  return;
  1243  
  1244          rcu_read_lock();

drivers/net/wireless/mediatek/mt76/mt7615/mac.c
    58  static struct mt76_wcid *mt7615_rx_get_wcid(struct mt7615_dev *dev,
    59                                              u8 idx, bool unicast)
    60  {
    61          struct mt7615_sta *sta;
    62          struct mt76_wcid *wcid;
    63  
    64          if (idx >= ARRAY_SIZE(dev->mt76.wcid))
                    ^^^
It's the same thing.  The type and the mask used (MT_RXD2_NORMAL_WLAN_IDX)
make this condition impossible.

    65                  return NULL;
    66  

See drivers/net/wireless/mediatek/mt76/mt7615/mac.c:1305 mt7615_mac_add_txs() warn: impossible condition '(wcidx >= (2304 / 8 + (0))) => (0-255 >= 288)'

drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
   551          struct mt76x02_sta *msta = NULL;
   552          struct mt76_dev *mdev = &dev->mt76;
   553          struct sk_buff_head list;
   554          u32 duration = 0;
   555          u8 cur_pktid;
   556          u32 ac = 0;
   557          int len = 0;
   558  
   559          if (stat->pktid == MT_PACKET_ID_NO_ACK)
   560                  return;
   561  
   562          rcu_read_lock();
   563  
   564          if (stat->wcid < ARRAY_SIZE(dev->mt76.wcid))
                    ^^^^^^^^^^
This is a u8 as well.

   565                  wcid = rcu_dereference(dev->mt76.wcid[stat->wcid]);
   566  
   567          if (wcid && wcid->sta) {
   568                  void *priv;
   569  
   570                  priv = msta = container_of(wcid, struct mt76x02_sta, wcid);
   571                  status.sta = container_of(priv, struct ieee80211_sta,
   572                                            drv_priv);
   573          }
...
   796  
   797          wcid = FIELD_GET(MT_RXWI_CTL_WCID, ctl);
                ^^^^             ^^^^^^^^^^^^^^^^
Here "wcid" is a u8 and MT_RXWI_CTL_WCID is bits 0-7 so both of these
may need to be adjusted.

   798          sta = mt76x02_rx_get_sta(&dev->mt76, wcid);
   799          status->wcid = mt76x02_rx_get_sta_wcid(sta, unicast);
   800  

regards,
dan carpenter
