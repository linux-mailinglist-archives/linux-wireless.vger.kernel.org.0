Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 606B14569E6
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Nov 2021 07:02:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232503AbhKSGFL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 19 Nov 2021 01:05:11 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:52863 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbhKSGFK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 19 Nov 2021 01:05:10 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 1AJ6207u8014587, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 1AJ6207u8014587
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 19 Nov 2021 14:02:00 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Fri, 19 Nov 2021 14:01:59 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Thu, 18 Nov 2021 22:01:58 -0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::dc53:1026:298b:c584]) by
 RTEXMBS04.realtek.com.tw ([fe80::dc53:1026:298b:c584%5]) with mapi id
 15.01.2308.015; Fri, 19 Nov 2021 14:01:58 +0800
From:   Pkshih <pkshih@realtek.com>
To:     Pkshih <pkshih@realtek.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [bug report] rtw89: add Realtek 802.11ax driver
Thread-Topic: [bug report] rtw89: add Realtek 802.11ax driver
Thread-Index: AQHX15o4iaSmIG2pD0OVRczSh+nkKqwD9mBAgAZwCTA=
Date:   Fri, 19 Nov 2021 06:01:58 +0000
Message-ID: <c64e0cb0cae341dd9c70c869cf14a34c@realtek.com>
References: <20211112075159.GA15433@kili>
 <09773676e8884a7689be81a46664ee1f@realtek.com>
In-Reply-To: <09773676e8884a7689be81a46664ee1f@realtek.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXDAG01.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?us-ascii?Q?Clean,_bases:_2021/11/18_=3F=3F_10:30:00?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-KSE-ServerInfo: RTEXH36504.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-AntiSpam-Outbound-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 11/19/2021 05:39:55
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 167351 [Nov 19 2021]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: pkshih@realtek.com
X-KSE-AntiSpam-Info: LuaCore: 465 465 eb31509370142567679dd183ac984a0cb2ee3296
X-KSE-AntiSpam-Info: {Tracking_uf_ne_domains}
X-KSE-AntiSpam-Info: lore.kernel.org:7.1.1;realtek.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 11/19/2021 05:42:00
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


> -----Original Message-----
> From: Pkshih <pkshih@realtek.com>
> Sent: Monday, November 15, 2021 3:34 PM
> To: Dan Carpenter <dan.carpenter@oracle.com>
> Cc: linux-wireless@vger.kernel.org
> Subject: RE: [bug report] rtw89: add Realtek 802.11ax driver
> 
> > -----Original Message-----
> > From: Dan Carpenter <dan.carpenter@oracle.com>
> > Sent: Friday, November 12, 2021 3:52 PM
> > To: Pkshih <pkshih@realtek.com>
> > Cc: linux-wireless@vger.kernel.org
> > Subject: [bug report] rtw89: add Realtek 802.11ax driver
> >
> > Hello Ping-Ke Shih,
> >
> > The patch e3ec7017f6a2: "rtw89: add Realtek 802.11ax driver" from Oct
> > 11, 2021, leads to the following Smatch static checker warning:
> >
> > 	drivers/net/wireless/realtek/rtw89/fw.c:1383 rtw89_fw_h2c_rf_reg()
> > 	error: buffer overflow 'info->rtw89_phy_config_rf_h2c' 3 <= 3
> >
> > drivers/net/wireless/realtek/rtw89/phy.c
> >    662  static int rtw89_phy_config_rf_reg_fw(struct rtw89_dev *rtwdev,
> >    663                                        struct rtw89_fw_h2c_rf_reg_info *info)
> >    664  {
> >    665          u16 page = info->curr_idx / RTW89_H2C_RF_PAGE_SIZE;
> >    666          u16 len = (info->curr_idx % RTW89_H2C_RF_PAGE_SIZE) * 4;
> >    667          u8 i;
> >    668          int ret = 0;
> >    669
> >    670          if (page > RTW89_H2C_RF_PAGE_NUM) {
> >                     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > Lets assume "page == RTW89_H2C_RF_PAGE_NUM.
> >
> >    671                  rtw89_warn(rtwdev,
> >    672                             "rf reg h2c total page num %d larger than %d
> (RTW89_H2C_RF_PAGE_NUM)\n",
> >    673                             page, RTW89_H2C_RF_PAGE_NUM);
> >    674                  return -EINVAL;
> >    675          }
> >    676
> >    677          for (i = 0; i < page; i++) {
> >                             ^^^^^^^^^
> >
> >    678                  ret = rtw89_fw_h2c_rf_reg(rtwdev, info,
> >    679                                            RTW89_H2C_RF_PAGE_SIZE * 4, i);
> >    680                  if (ret)
> >    681                          return ret;
> >    682          }
> >    683          ret = rtw89_fw_h2c_rf_reg(rtwdev, info, len, i);
> >                                                              ^
> > So "i" is now RTW89_H2C_RF_PAGE_NUM and it leads to off by one out of
> > bounds error.
> >
> >    684          if (ret)
> >    685                  return ret;
> >    686          info->curr_idx = 0;
> >    687
> >    688          return 0;
> >    689  }
> >
> 
> When the info->curr_idx is between RTW89_H2C_RF_PAGE_SIZE * RTW89_H2C_RF_PAGE_NUM and
> RTW89_H2C_RF_PAGE_SIZE * (RTW89_H2C_RF_PAGE_NUM + 1), it falls into the case
> you mentioned. Fortunately, the input is predictable if we don't change
> RF parameters, so it doesn't lead wrong situation for now.
> 
> Anyway, I will refine this function to handle all cases. Thanks for
> your finding.
> 

I have sent a patch [1] to fix this.

[1] https://lore.kernel.org/linux-wireless/20211119055729.12826-1-pkshih@realtek.com/T/#u

--
Ping-Ke

