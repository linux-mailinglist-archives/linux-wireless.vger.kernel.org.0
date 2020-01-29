Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 228C914C96D
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Jan 2020 12:18:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbgA2LSU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 29 Jan 2020 06:18:20 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:57714 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbgA2LST (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 29 Jan 2020 06:18:19 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00TBEEMW098641;
        Wed, 29 Jan 2020 11:18:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2019-08-05;
 bh=3lA69pvmgvgQeZ7xeb05qM/NtDuWT0CsaqkaX8ar/24=;
 b=MPhLsiHCcv/ORex4zTfZVzbbnkoPCV+KAYZFvkQOeYo4hyNq7lZW4mTFYjgsddzc3gfr
 TZMAnJa0vAcG71BNjCs7GrYYaFApWE+pvD7Yguv9Urcu33xuzSNNsQQFdBDyPAqd2En0
 wXVq6Ezg54OvSR5CxBWcPCbiAIjDXzXQeJPwz4YYZbmeWeawIvpZUBgdBz2mnTgGYLRD
 kR+46vlCCMCIjYIUl+LbMSz2BWBVDJQ8dQaJIBsdg8bXeGd/9ddsdbxQ9F+M9yvRuJzC
 WK9HLaER+0PNBteUQSAFfI1Twvs3qdjIdGhjQmNLr0tz4cW6c6WjpZ+42r+lS287U39w nw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2xrdmqmd47-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Jan 2020 11:18:13 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00TBEocs084654;
        Wed, 29 Jan 2020 11:18:12 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2xtg7x2tf1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Jan 2020 11:18:12 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 00TBIAoC011911;
        Wed, 29 Jan 2020 11:18:10 GMT
Received: from kili.mountain (/129.205.23.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 29 Jan 2020 03:18:09 -0800
Date:   Wed, 29 Jan 2020 14:18:02 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     timlee@realtek.com
Cc:     linux-wireless@vger.kernel.org
Subject: [bug report] rtw88: support wowlan feature for 8822c
Message-ID: <20200129111802.kbphgme3t27ow2no@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9514 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=779
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001290094
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9514 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=847 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001290094
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello Chin-Yen Lee,

The patch 44bc17f7f5b3: "rtw88: support wowlan feature for 8822c"
from Dec 19, 2019, leads to the following static checker warning:

	drivers/net/wireless/realtek/rtw88/wow.c:300 rtw_wow_check_fw_status()
	error: uninitialized symbol 'ret'.

drivers/net/wireless/realtek/rtw88/wow.c
   284  static bool rtw_wow_check_fw_status(struct rtw_dev *rtwdev, bool wow_enable)
   285  {
   286          bool ret;
                     ^^^
This is not initialized.


   287  
   288          /* wait 100ms for wow firmware to finish work */
   289          msleep(100);
   290  
   291          if (wow_enable) {
   292                  if (!rtw_read8(rtwdev, REG_WOWLAN_WAKE_REASON))
   293                          ret = 0;

"ret" is bool so it should be "ret = false;" but really returning
true on error and false on success is not beautiful.  Also these return
values get propogated back so it should return negative error codes.

   294          } else {
   295                  if (rtw_read32_mask(rtwdev, REG_FE1IMR, BIT_FS_RXDONE) == 0 &&
   296                      rtw_read32_mask(rtwdev, REG_RXPKT_NUM, BIT_RW_RELEASE) == 0)
   297                          ret = 0;
   298          }
   299  
   300          if (ret)
   301                  rtw_err(rtwdev, "failed to check wow status %s\n",
   302                          wow_enable ? "enabled" : "disabled");
   303  
   304          return ret;
   305  }

regards,
dan carpenter
