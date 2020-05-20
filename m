Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D10111DB2C4
	for <lists+linux-wireless@lfdr.de>; Wed, 20 May 2020 14:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbgETMKi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 May 2020 08:10:38 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:39016 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbgETMKi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 May 2020 08:10:38 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04KC7Qr2191920;
        Wed, 20 May 2020 12:10:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=irXy5qR4OqDLQFwI1T4hA3X4qeNb8B2ztZ5Le3JbTRg=;
 b=w+/y6zSLgHc/ranXjBAkzKFcV/xGO4BzuFZ+eGYi3OzoFc7PxVitHKtiRJ1euHzIcvpu
 hAA+u86bT4Jq7sfiWXADQaaLuyTV9ptCeB8HmbSa3egDMpHDkJTXCMTRFTjyOsYdOWoh
 rXrguINwI39YwZ4kRo2gEURQ0TmSTLtIDpoc64p/lUC+pgMScnntlo2j+wYFfjFJFcCg
 kJwmdE2gnf+dbGNRgsMAjyDP6pFzKR9HV4uQfoUu7FqNUpGlI1Wf3OM7XAPO0udr5/SH
 t2fAGKdK/RAIk0xCkOBKFCXXPQCDBdH/AyDN2oMMMKg4MdBNZVL6/QNGpredxpoIUTa2 HA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 31501r98a6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 20 May 2020 12:10:33 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04KC8Sid161806;
        Wed, 20 May 2020 12:08:33 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 314gm6yd7c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 May 2020 12:08:32 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 04KC8Vkx007064;
        Wed, 20 May 2020 12:08:32 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 20 May 2020 05:08:31 -0700
Date:   Wed, 20 May 2020 15:08:26 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     ryder.lee@mediatek.com
Cc:     Ryder Lee <ryder.lee@mediatek.com>, linux-wireless@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [bug report] mt76: add mac80211 driver for MT7915 PCIe-based chipsets
Message-ID: <20200520120826.GJ172354@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9626 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=951
 adultscore=0 phishscore=0 mlxscore=0 spamscore=0 suspectscore=3
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2005200106
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9626 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 spamscore=0
 mlxlogscore=972 clxscore=1015 priorityscore=1501 cotscore=-2147483648
 impostorscore=0 bulkscore=0 adultscore=0 malwarescore=0 phishscore=0
 mlxscore=0 suspectscore=3 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2005200106
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello Ryder Lee,

The patch e57b7901469f: "mt76: add mac80211 driver for MT7915
PCIe-based chipsets" from Apr 25, 2020, leads to the following static
checker warning:

	drivers/net/wireless/mediatek/mt76/mt7915/mcu.c:1576 mt7915_mcu_add_smps()
	error: 'wtbl_hdr' dereferencing possible ERR_PTR()

drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
  1558  int mt7915_mcu_add_smps(struct mt7915_dev *dev, struct ieee80211_vif *vif,
  1559                          struct ieee80211_sta *sta)
  1560  {
  1561          struct mt7915_vif *mvif = (struct mt7915_vif *)vif->drv_priv;
  1562          struct mt7915_sta *msta = (struct mt7915_sta *)sta->drv_priv;
  1563          struct wtbl_req_hdr *wtbl_hdr;
  1564          struct tlv *sta_wtbl;
  1565          struct sk_buff *skb;
  1566  
  1567          skb = mt7915_mcu_alloc_sta_req(dev, mvif, msta,
  1568                                         MT7915_STA_UPDATE_MAX_SIZE);
  1569          if (IS_ERR(skb))
  1570                  return PTR_ERR(skb);
  1571  
  1572          sta_wtbl = mt7915_mcu_add_tlv(skb, STA_REC_WTBL, sizeof(struct tlv));
  1573  
  1574          wtbl_hdr = mt7915_mcu_alloc_wtbl_req(dev, msta, WTBL_SET, sta_wtbl,
                ^^^^^^^^
No error handling.

  1575                                               &skb);
  1576          mt7915_mcu_wtbl_smps_tlv(skb, sta, sta_wtbl, wtbl_hdr);
  1577  
  1578          return __mt76_mcu_skb_send_msg(&dev->mt76, skb,
  1579                                         MCU_EXT_CMD_STA_REC_UPDATE, true);
  1580  }

regards,
dan carpenter
