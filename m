Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 722E9318C84
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Feb 2021 14:50:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231660AbhBKNrc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 11 Feb 2021 08:47:32 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:35260 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231824AbhBKNop (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 11 Feb 2021 08:44:45 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11BDhp3Z089539;
        Thu, 11 Feb 2021 13:43:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=0i2N/jO0dPex40RjcS6p4za3vsHr9iX4YPROKDqBJ2M=;
 b=Lp1zBMblw2cvf715IbjVgPx4HmKyQsRJRKeeLw8TnHusqHZ4VL2agxJY3qVk/OtFn+MI
 8AzZb8FlFbB0Ja8kkz8jCSsuc114cBYf/y8YiGOLiHsOt8SSEqw/H/OqIzuvWwWj+G4k
 Qey6/cUSY4FZ0aKuV/VWlHj6SXzvJXpAwCYK5ebI+AUOQ1+VXjnR57dqYNK040dZaR6x
 TfWvRla6gLsL5ENx219CG8IVQZFUeNHLkFzRVQgeNl2DiyMhmlqGR+EhgwVeOAryL2A0
 JYYrd8I2jW1GnHRKVJ0UoCxEuyfuGMQh0W6uV2yj2Qa8mTOMSO72hqCvaOJPwe8XQwlU Rg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 36hkrn7e2x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Feb 2021 13:43:55 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11BDZ75X165066;
        Thu, 11 Feb 2021 13:43:54 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 36j5201fq9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Feb 2021 13:43:54 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 11BDhqXl025485;
        Thu, 11 Feb 2021 13:43:53 GMT
Received: from mwanda (/10.175.210.142)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 11 Feb 2021 05:43:52 -0800
Date:   Thu, 11 Feb 2021 16:43:47 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     lorenzo@kernel.org
Cc:     linux-wireless@vger.kernel.org
Subject: [bug report] mt76: mt76_connac: create mcu library
Message-ID: <YCU0k+mAXAEYbiW4@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9891 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 phishscore=0
 mlxscore=0 malwarescore=0 mlxlogscore=961 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102110118
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9891 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 priorityscore=1501 bulkscore=0 spamscore=0 impostorscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=900 adultscore=0 clxscore=1011
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102110119
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello Lorenzo Bianconi,

The patch d0e274af2f2e: "mt76: mt76_connac: create mcu library" from
Jan 26, 2021, leads to the following static checker warning:

	drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c:837 mt76_connac_mcu_add_sta_cmd()
	error: 'wtbl_hdr' dereferencing possible ERR_PTR()

drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
   810  int mt76_connac_mcu_add_sta_cmd(struct mt76_phy *phy,
   811                                  struct ieee80211_vif *vif,
   812                                  struct ieee80211_sta *sta,
   813                                  struct mt76_wcid *wcid,
   814                                  bool enable, int cmd)
   815  {
   816          struct mt76_vif *mvif = (struct mt76_vif *)vif->drv_priv;
   817          struct mt76_dev *dev = phy->dev;
   818          struct wtbl_req_hdr *wtbl_hdr;
   819          struct tlv *sta_wtbl;
   820          struct sk_buff *skb;
   821  
   822          skb = mt76_connac_mcu_alloc_sta_req(dev, mvif, wcid);
   823          if (IS_ERR(skb))
   824                  return PTR_ERR(skb);
   825  
   826          mt76_connac_mcu_sta_basic_tlv(skb, vif, sta, enable);
   827          if (enable && sta)
   828                  mt76_connac_mcu_sta_tlv(phy, skb, sta, vif);
   829  
   830          sta_wtbl = mt76_connac_mcu_add_tlv(skb, STA_REC_WTBL,
   831                                             sizeof(struct tlv));
   832  
   833          wtbl_hdr = mt76_connac_mcu_alloc_wtbl_req(dev, wcid,
   834                                                    WTBL_RESET_AND_SET,
   835                                                    sta_wtbl, &skb);

if (IS_ERR(wtbl_hdr)) {
	do some cleanup?
	return PTR_ERR(wtbl_hdr);
}

   836          if (enable) {
   837                  mt76_connac_mcu_wtbl_generic_tlv(dev, skb, vif, sta, sta_wtbl,
   838                                                   wtbl_hdr);
   839                  if (sta)
   840                          mt76_connac_mcu_wtbl_ht_tlv(dev, skb, sta, sta_wtbl,
   841                                                      wtbl_hdr);
   842          }
   843  
   844          return mt76_mcu_skb_send_msg(dev, skb, cmd, true);
   845  }

regards,
dan carpenter
