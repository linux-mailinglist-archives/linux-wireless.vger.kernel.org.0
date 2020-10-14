Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E596F28D86E
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Oct 2020 04:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727161AbgJNCYt convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 13 Oct 2020 22:24:49 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:52318 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726830AbgJNCYt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 13 Oct 2020 22:24:49 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 09E2OfTqA028248, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 09E2OfTqA028248
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 14 Oct 2020 10:24:41 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2044.4; Wed, 14 Oct 2020 10:24:41 +0800
Received: from RTEXMB04.realtek.com.tw ([fe80::89f7:e6c3:b043:15fa]) by
 RTEXMB04.realtek.com.tw ([fe80::89f7:e6c3:b043:15fa%3]) with mapi id
 15.01.2044.006; Wed, 14 Oct 2020 10:24:41 +0800
From:   Andy Huang <tehuang@realtek.com>
To:     "'Dan Carpenter'" <dan.carpenter@oracle.com>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [bug report] rtw88: add dump firmware fifo support
Thread-Topic: [bug report] rtw88: add dump firmware fifo support
Thread-Index: AQHWoWx0Kgs2XDNhbUWYN/LN0gZwvamWXsoA
Date:   Wed, 14 Oct 2020 02:24:41 +0000
Message-ID: <faef9a43454b4aae819244eb5a90571b@realtek.com>
References: <20201013142330.GA490753@mwanda>
In-Reply-To: <20201013142330.GA490753@mwanda>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.231]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

> Hello Tzu-En Huang,
> 
> The patch 0fbc2f0f34cc: "rtw88: add dump firmware fifo support" from Sep 25,
> 2020, leads to the following static checker warning:
> 
> 	drivers/net/wireless/realtek/rtw88/fw.c:1485 rtw_fw_dump_fifo()
> 	warn: this array is probably non-NULL. 'rtwdev->chip->fw_fifo_addr'
> 
> drivers/net/wireless/realtek/rtw88/fw.c
>   1482  int rtw_fw_dump_fifo(struct rtw_dev *rtwdev, u8 fifo_sel, u32 addr,
> u32 size,
>   1483                       u32 *buffer)
>   1484  {
>   1485          if (!rtwdev->chip->fw_fifo_addr) {
>                     ^^^^^^^^^^^^^^^^^^^^^^^^^^^ Delete this check?
> 
>   1486                  rtw_dbg(rtwdev, RTW_DBG_FW, "chip not
> support dump fw fifo\n");
>   1487                  return -ENOTSUPP;
>   1488          }
>   1489
>   1490          if (size == 0 || !buffer)
>   1491                  return -EINVAL;
> 
> regards,
> dan carpenter

Thanks for the report, and I saw Tom had sent a patch to fix it. I acked on the patch.

Tzu-En


