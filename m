Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB4D28D029
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Oct 2020 16:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387742AbgJMOXp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 13 Oct 2020 10:23:45 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:57088 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387516AbgJMOXp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 13 Oct 2020 10:23:45 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09DEMT6f125408;
        Tue, 13 Oct 2020 14:23:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=Gua3e7jpjAK2X0infEUPPR/D600V/78SU9JEB+Q7nfs=;
 b=eVqCIC0OMV8e/xuGM+p493cxwJ6ys+VUoe4zqEB3f3Hs8MKIvoQ1N0TLInY8jyBi/6qx
 pKmilCw4np653opkeuENlqEDGHiJk6hAYSicJN4mp6Td9Px03qpxNzgJQdPoo+T788pY
 9RE06ighRYwAflqPxrACO627pRo1UBhZObdYb5K7N23W7fJwEgsDgCBi7T0nucc/puB2
 L/XYC1z9Fem/RoqSUXA0AgD+737RPbXAWXQdM3j1MhemF2gdqSYKwPNhKDGvf4mRnVtO
 gGnGW/2EL4p8z3h+3XsUBRc/cI8tqGbN02PRlYqlyr9gvhYTxAj6T1QNRJmkRHZ730/f vw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 3434wkjfk1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 13 Oct 2020 14:23:38 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09DEJdlJ018799;
        Tue, 13 Oct 2020 14:23:37 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 343phn8443-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Oct 2020 14:23:37 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 09DENZhA020670;
        Tue, 13 Oct 2020 14:23:36 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 13 Oct 2020 07:23:35 -0700
Date:   Tue, 13 Oct 2020 17:23:30 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     tehuang@realtek.com
Cc:     linux-wireless@vger.kernel.org
Subject: [bug report] rtw88: add dump firmware fifo support
Message-ID: <20201013142330.GA490753@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9772 signatures=668681
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 bulkscore=0 mlxlogscore=842 malwarescore=0 mlxscore=0 suspectscore=3
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010130109
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9772 signatures=668681
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 mlxscore=0
 malwarescore=0 phishscore=0 suspectscore=3 impostorscore=0 clxscore=1011
 spamscore=0 priorityscore=1501 bulkscore=0 adultscore=0 mlxlogscore=872
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010130108
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello Tzu-En Huang,

The patch 0fbc2f0f34cc: "rtw88: add dump firmware fifo support" from
Sep 25, 2020, leads to the following static checker warning:

	drivers/net/wireless/realtek/rtw88/fw.c:1485 rtw_fw_dump_fifo()
	warn: this array is probably non-NULL. 'rtwdev->chip->fw_fifo_addr'

drivers/net/wireless/realtek/rtw88/fw.c
  1482  int rtw_fw_dump_fifo(struct rtw_dev *rtwdev, u8 fifo_sel, u32 addr, u32 size,
  1483                       u32 *buffer)
  1484  {
  1485          if (!rtwdev->chip->fw_fifo_addr) {
                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^
Delete this check?

  1486                  rtw_dbg(rtwdev, RTW_DBG_FW, "chip not support dump fw fifo\n");
  1487                  return -ENOTSUPP;
  1488          }
  1489  
  1490          if (size == 0 || !buffer)
  1491                  return -EINVAL;

regards,
dan carpenter
