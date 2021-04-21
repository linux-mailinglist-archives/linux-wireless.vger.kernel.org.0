Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19A45366C8D
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Apr 2021 15:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241212AbhDUNTv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Apr 2021 09:19:51 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:53276 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240953AbhDUNSY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Apr 2021 09:18:24 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13LD9pJ4157315;
        Wed, 21 Apr 2021 13:17:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=meF497oFUEUVOCM41KHiP9Z6G2djfW/D09lrDw/FHh8=;
 b=OEbj3ivKGEHo2xata6oRKs96yxKp/N75VC2ZewBB6DL/Wm0tu0uzr31wlSYZ+KMvD4Ok
 Pjc/VymR/gkAVTOoZGG/mGf1xXISknsiWSZiQMbwogZt8FdPd0+ujGpnQnFRdzGqjVAB
 /Uc7+i5rayIZp9xbX2SyCnKl9Me5Lm4QtLuscpDXxY16tg1rFMiOoI3xrUKh4b5JjcWz
 iSaLgkTWgb/8Y5OZn/ckC7qErO0fOGFYpWDmO6uo6k2IVXG+AWqYsP6xoeC5QDa3TGCS
 dUtfhqOdB3LelMyx3a8ZZOmHv4V72Gl0Q0vudPsXmVmXSmDS1qxLVw+iteef/3vSkX/v bw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 37yn6caake-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Apr 2021 13:17:39 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13LDC5IW144525;
        Wed, 21 Apr 2021 13:17:39 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3020.oracle.com with ESMTP id 3809eu8twa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Apr 2021 13:17:39 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 13LDE2TJ151465;
        Wed, 21 Apr 2021 13:17:38 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 3809eu8tw1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Apr 2021 13:17:38 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 13LDHb6s017703;
        Wed, 21 Apr 2021 13:17:38 GMT
Received: from mwanda (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 21 Apr 2021 06:17:37 -0700
Date:   Wed, 21 Apr 2021 16:17:31 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     ryder.lee@mediatek.com
Cc:     linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: [bug report] mt76: mt7615: fix TSF configuration
Message-ID: <YIAl62mky03Byme+@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-GUID: RDazDupxIhTdpc8Iq3vzY78uVZucxBhq
X-Proofpoint-ORIG-GUID: RDazDupxIhTdpc8Iq3vzY78uVZucxBhq
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9961 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 priorityscore=1501
 bulkscore=0 suspectscore=0 impostorscore=0 mlxscore=0 lowpriorityscore=0
 clxscore=1015 spamscore=0 mlxlogscore=774 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104210102
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello Ryder Lee,

This is a semi-automatic email about new static checker warnings.

The patch a4a5a430b076: "mt76: mt7615: fix TSF configuration" from 
Feb 23, 2021, leads to the following Smatch complaint:

    drivers/net/wireless/mediatek/mt76/mt7615/usb_sdio.c:74 mt7663_usb_sdio_set_rates()
    warn: variable dereferenced before check 'sta' (see line 70)

drivers/net/wireless/mediatek/mt76/mt7615/usb_sdio.c
    69		u32 w5, w27, addr, val;
    70		u16 idx = sta->vif->mt76.omac_idx;
                          ^^^^^^^^^^^^^^
The patch adds a new dereference

    71	
    72		lockdep_assert_held(&dev->mt76.mutex);
    73	
    74		if (!sta)
                     ^^^
The old code checks for NULL

    75			return -EINVAL;
    76	

regards,
dan carpenter
