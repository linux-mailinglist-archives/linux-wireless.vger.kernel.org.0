Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFB5644A13F
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Nov 2021 02:06:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238977AbhKIBJJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 8 Nov 2021 20:09:09 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:58773 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235911AbhKIBHv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 8 Nov 2021 20:07:51 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 1A914xdxE022482, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 1A914xdxE022482
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 9 Nov 2021 09:04:59 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Tue, 9 Nov 2021 09:04:59 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Tue, 9 Nov 2021 09:04:59 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::dc53:1026:298b:c584]) by
 RTEXMBS04.realtek.com.tw ([fe80::dc53:1026:298b:c584%5]) with mapi id
 15.01.2308.015; Tue, 9 Nov 2021 09:04:59 +0800
From:   Pkshih <pkshih@realtek.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [bug report] rtw89: add Realtek 802.11ax driver
Thread-Topic: [bug report] rtw89: add Realtek 802.11ax driver
Thread-Index: AQHX1K+UtVj0CjQXxUeUjuPlp/lx7av6XWnw
Date:   Tue, 9 Nov 2021 01:04:58 +0000
Message-ID: <52907f4646dc4ed6bb18b627ed6c243e@realtek.com>
References: <20211108144711.GA9468@kili>
In-Reply-To: <20211108144711.GA9468@kili>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS04.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?us-ascii?Q?Clean,_bases:_2021/11/8_=3F=3F_11:51:00?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-KSE-ServerInfo: RTEXH36504.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-AntiSpam-Outbound-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 11/09/2021 00:50:25
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 167127 [Nov 09 2021]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: pkshih@realtek.com
X-KSE-AntiSpam-Info: LuaCore: 465 465 eb31509370142567679dd183ac984a0cb2ee3296
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;realtek.com:7.1.1
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 11/09/2021 00:53:00
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


> -----Original Message-----
> From: Dan Carpenter <dan.carpenter@oracle.com>
> Sent: Monday, November 8, 2021 10:47 PM
> To: Pkshih <pkshih@realtek.com>
> Cc: linux-wireless@vger.kernel.org
> Subject: [bug report] rtw89: add Realtek 802.11ax driver
> 
> Hello Ping-Ke Shih,
> 
> The patch e3ec7017f6a2: "rtw89: add Realtek 802.11ax driver" from Oct
> 11, 2021, leads to the following Smatch static checker warning:
> 
> 	drivers/net/wireless/realtek/rtw89/mac.c:586 hfc_ch_ctrl()
> 	warn: array off by one? 'cfg[ch]'
> 
> drivers/net/wireless/realtek/rtw89/mac.c
>     568 static int hfc_ch_ctrl(struct rtw89_dev *rtwdev, u8 ch)
>     569 {
>     570         struct rtw89_hfc_param *param = &rtwdev->mac.hfc_param;
>     571         const struct rtw89_hfc_ch_cfg *cfg = param->ch_cfg;
>     572         int ret = 0;
>     573         u32 val = 0;
>     574
>     575         ret = rtw89_mac_check_mac_en(rtwdev, RTW89_MAC_0, RTW89_DMAC_SEL);
>     576         if (ret)
>     577                 return ret;
>     578
>     579         ret = hfc_ch_cfg_chk(rtwdev, ch);
>     580         if (ret)
>     581                 return ret;
>     582
>     583         if (ch > RTW89_DMA_B1HI)
>                     ^^^^^^^^^^^^^^^^^^^
> 
>     584                 return -EINVAL;
>     585
> --> 586         val = u32_encode_bits(cfg[ch].min, B_AX_MIN_PG_MASK) |
>     587               u32_encode_bits(cfg[ch].max, B_AX_MAX_PG_MASK) |
>     588               (cfg[ch].grp ? B_AX_GRP : 0);
> 
> This is an unpublished Smatch warning which uses an "assume every >
> comparison should be >= wrong until proven otherwise" approach.  In
> this case, Smatch can't tell the size of the cfg[] array.

I'm not clear how to fix this warning. Any suggestion?

The caller of this function is
	for (ch = RTW89_DMA_ACH0; ch < RTW89_DMA_H2C; ch++) {
		ret = hfc_ch_ctrl(rtwdev, ch);
		...
	}

So, 'ch' is between 0 and 11. Maybe, this checking can be removed?

> 
> Manually it looks like cfg can only be rtw8852a_hfc_chcfg_pcie[] which
> has RTW89_DMA_CH_NUM (13) elements.  Is there a reason why we don't use
> the last element?  

We don't use the last element, because channel 0 to 11 are the regular TX channels
that will transmit packets to air. The channel 12 (H2C) is a special channel we
send firmware commands from driver, so it doesn't need additional configurations.
More, the list of R_AX_ACH0_PAGE_CTRL series don't have one for channel 12 neither.

> Also it's puzzling that the last element is
> FWCMDQ instead of H2C.  So maybe that's the reason?

FWCMDQ is a queue or channel that is used to send H2C from driver to firmware.
So, FWCMD and H2C can be seen as synonyms, as well as FWCMDQ and H2CQ.

> 
>     589         rtw89_write32(rtwdev, R_AX_ACH0_PAGE_CTRL + ch * 4, val);
>     590
>     591         return 0;
>     592 }
> 

--
Ping-Ke

