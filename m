Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4DEC23B902
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Aug 2020 12:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729921AbgHDKpz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 4 Aug 2020 06:45:55 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:38734 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729801AbgHDKpx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 4 Aug 2020 06:45:53 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 074AfvB0061907;
        Tue, 4 Aug 2020 10:45:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=XzIUTpiHbaUP7Ep8zZtBldS+bK07BMIVeB9fyRRtjig=;
 b=GOwIiWlfm3NVavzvx1t5k6YSBgWgpIg0rqRKl+jChPeBEYd9VbwSpqe5lEVY5dTLZWWt
 5PASePdbgz/acoOpUndAcnNLwL9B5F0osRR3EfTuHB+5VJWH3qJjnvFCmi9nrcSQSVBQ
 oOWzs/QMmWarE8cnUicqBmB9bfL8ef4Ky0ul99XX0RKPLPPDfEfon/8522nChLQK7KEI
 CNrxLi3FH7GDUog5afY8FJ2EIotKdEiuecPwMkdnpFsX2QTMGRHgWqkNi82p6cOi7DZQ
 W6ndcrGekHIXFYMoRQr6n5rjX0kxbc0qnvVrGH/mlGXahZUO6X+Esj3NIIPm6nkftkd9 FQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 32nc9yj4uj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 04 Aug 2020 10:45:46 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 074Agq3i002634;
        Tue, 4 Aug 2020 10:45:45 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 32pdnpvhgm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 Aug 2020 10:45:45 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 074AjfPD005043;
        Tue, 4 Aug 2020 10:45:41 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 04 Aug 2020 03:45:40 -0700
Date:   Tue, 4 Aug 2020 13:45:35 +0300
From:   <dan.carpenter@oracle.com>
To:     lorenzo@kernel.org
Cc:     linux-mediatek@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: [bug report] mt76: mt7615: wake device before accessing regmap in
 debugfs
Message-ID: <20200804104535.GA398141@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9702 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 spamscore=0 mlxscore=0
 bulkscore=0 adultscore=0 phishscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008040080
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9702 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 mlxscore=0
 suspectscore=3 phishscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0
 adultscore=0 clxscore=1011 malwarescore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008040080
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello Lorenzo Bianconi,

The patch ea4906c4be49: "mt76: mt7615: wake device before accessing
regmap in debugfs" from Jul 3, 2020, leads to the following static
checker warning:

	drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c:179 mt7615_reset_test_set()
	warn: inconsistent returns 'dev->mt76.mutex'.

drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c
   159  static int
   160  mt7615_reset_test_set(void *data, u64 val)
   161  {
   162          struct mt7615_dev *dev = data;
   163          struct sk_buff *skb;
   164  
   165          if (!mt7615_wait_for_mcu_init(dev))
   166                  return 0;
   167  
   168          mt7615_mutex_acquire(dev);
   169  
   170          skb = alloc_skb(1, GFP_KERNEL);
   171          if (!skb)
   172                  return -ENOMEM;
                        ^^^^^^^^^^^^^^
This is returning with the mutex held.  What is the mutex protecting?
We could move the allocation and the skb_put() before the
mt7615_mutex_acquire().

   173  
   174          skb_put(skb, 1);
   175          mt76_tx_queue_skb_raw(dev, 0, skb, 0);
   176  
   177          mt7615_mutex_release(dev);
   178  
   179          return 0;
   180  }

regards,
dan carpenter
