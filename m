Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5E6F1138C
	for <lists+linux-wireless@lfdr.de>; Thu,  2 May 2019 08:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725795AbfEBGvi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 2 May 2019 02:51:38 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:54540 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbfEBGvi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 2 May 2019 02:51:38 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x426mxFA070421;
        Thu, 2 May 2019 06:51:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2018-07-02;
 bh=/RmzrTfONRFiitzSLgYIDeNN1+wwGKsI+P5sFGMsCvc=;
 b=rEgMZxF4Dpn69S8fXvcAzfM3vkwxIDJ9C+8Mfjj5tBlXv6e3ZTd56uc5QNgX1AM89IU+
 EcyBFbFcWE2emoIgfoMOrjUeMexu65K0aZ6U/huCEF0lWRu8dNXHFQPDg1c/SI/a6fFe
 C/4ZjHly3X0nOv9rh7tDPC7Gs8XYbPQmgEyBRcAekX87i3ykCmJhBitpxgtM/zGkJxro
 /MkiS9/cWae9PK2zkN4DlZUoLBgUGPeQ9WXe4wZCS8oFM9Sfinl8ZR4R/15qnHLvcvr2
 PTakdFAqFekPWfoAcWyG+7TkvVcutsEZvEss0Xc5TmC0V4dbjD/WsYoQQwN4C9QRsCS3 iQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2s6xhyejae-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 May 2019 06:51:36 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x426ojqI109675;
        Thu, 2 May 2019 06:51:35 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2s7rtbj6kb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 May 2019 06:51:35 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x426pYxk024496;
        Thu, 2 May 2019 06:51:34 GMT
Received: from mwanda (/196.97.155.240)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 01 May 2019 23:51:32 -0700
Date:   Thu, 2 May 2019 09:51:25 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     siva8118@gmail.com
Cc:     linux-wireless@vger.kernel.org
Subject: [bug report] rsi: add firmware loading for 9116 device
Message-ID: <20190502065125.GA9844@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9244 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905020053
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9244 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905020053
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello Siva Rebbagondla,

The patch e5a1ecc97e5f: "rsi: add firmware loading for 9116 device"
from Apr 3, 2019, leads to the following static checker warning:

	drivers/net/wireless/rsi/rsi_91x_sdio.c:940 rsi_sdio_ta_reset()
	error: uninitialized symbol 'data'.

drivers/net/wireless/rsi/rsi_91x_sdio.c
   926  static int rsi_sdio_ta_reset(struct rsi_hw *adapter)
   927  {
   928          int status;
   929          u32 addr;
   930          u8 *data;
                ^^^^^^^^

   931  
   932          status = rsi_sdio_master_access_msword(adapter, TA_BASE_ADDR);
   933          if (status < 0) {
   934                  rsi_dbg(ERR_ZONE,
   935                          "Unable to set ms word to common reg\n");
   936                  return status;
   937          }
   938  
   939          rsi_dbg(INIT_ZONE, "%s: Bring TA out of reset\n", __func__);
   940          put_unaligned_le32(TA_HOLD_THREAD_VALUE, data);
                                                         ^^^^
Not initialized.

   941          addr = TA_HOLD_THREAD_REG | RSI_SD_REQUEST_MASTER;
   942          status = rsi_sdio_write_register_multiple(adapter, addr,
   943                                                    (u8 *)&data,
                                                          ^^^^^^^^^^^
It's really hard to test reset functions of course...  :(

   944                                                    RSI_9116_REG_SIZE);
   945          if (status < 0) {
   946                  rsi_dbg(ERR_ZONE, "Unable to hold TA threads\n");
   947                  return status;
   948          }
   949  
   950          put_unaligned_le32(TA_SOFT_RST_CLR, data);
   951          addr = TA_SOFT_RESET_REG | RSI_SD_REQUEST_MASTER;
   952          status = rsi_sdio_write_register_multiple(adapter, addr,
   953                                                    (u8 *)&data,
   954                                                    RSI_9116_REG_SIZE);
   955          if (status < 0) {
   956                  rsi_dbg(ERR_ZONE, "Unable to get TA out of reset\n");
   957                  return status;
   958          }

regards,
dan carpenter
