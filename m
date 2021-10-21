Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6AE9435AB4
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Oct 2021 08:08:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbhJUGKk convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 21 Oct 2021 02:10:40 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:51993 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbhJUGKi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 21 Oct 2021 02:10:38 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 19L68LHR0003189, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36503.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 19L68LHR0003189
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 21 Oct 2021 14:08:21 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36503.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Thu, 21 Oct 2021 14:08:20 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Thu, 21 Oct 2021 14:08:20 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::dc53:1026:298b:c584]) by
 RTEXMBS04.realtek.com.tw ([fe80::dc53:1026:298b:c584%5]) with mapi id
 15.01.2308.015; Thu, 21 Oct 2021 14:08:20 +0800
From:   Pkshih <pkshih@realtek.com>
To:     Kevin Lo <kevlo@kevlo.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH wireless-drivers-next] rtw89: remove duplicate register definitions
Thread-Topic: [PATCH wireless-drivers-next] rtw89: remove duplicate register
 definitions
Thread-Index: AQHXxj6wIjMkyAVetE2SoE0Gg3EjSqvc93yg
Date:   Thu, 21 Oct 2021 06:08:20 +0000
Message-ID: <b3d4fc4d08564a30b67e434a2715d1ec@realtek.com>
References: <YXD+KL+xzFsnGShb@ns.kevlo.org>
In-Reply-To: <YXD+KL+xzFsnGShb@ns.kevlo.org>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS06.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?us-ascii?Q?Clean,_bases:_2021/10/21_=3F=3F_03:10:00?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-KSE-ServerInfo: RTEXH36503.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-AntiSpam-Outbound-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 10/21/2021 05:53:23
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 166865 [Oct 20 2021]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: pkshih@realtek.com
X-KSE-AntiSpam-Info: LuaCore: 463 463 5854868460de3f0d8e8c0a4df98aeb05fb764a09
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;realtek.com:7.1.1
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 10/21/2021 05:55:00
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


> -----Original Message-----
> From: Kevin Lo <kevlo@kevlo.org>
> Sent: Thursday, October 21, 2021 1:44 PM
> To: linux-wireless@vger.kernel.org
> Cc: Pkshih <pkshih@realtek.com>
> Subject: [PATCH wireless-drivers-next] rtw89: remove duplicate register definitions
> 
> Remove duplicate register definitions.
> 
> Signed-off-by: Kevin Lo <kevlo@kevlo.org>

Acked-by: Ping-Ke Shih <pkshih@realtek.com>

> ---
> diff --git a/drivers/net/wireless/realtek/rtw89/pci.h b/drivers/net/wireless/realtek/rtw89/pci.h
> index 34333c441aea..20e6767ea5c4 100644
> --- a/drivers/net/wireless/realtek/rtw89/pci.h
> +++ b/drivers/net/wireless/realtek/rtw89/pci.h
> @@ -276,11 +276,6 @@
>  #define B_AX_CH10_BUSY			BIT(0)
> 
>  /* Configure */
> -#define R_AX_PCIE_INIT_CFG1	0x1000
> -#define B_AX_PCIE_RXRST_KEEP_REG	BIT(23)
> -#define B_AX_PCIE_TXRST_KEEP_REG	BIT(22)
> -#define B_AX_DIS_RXDMA_PRE		BIT(2)
> -
>  #define R_AX_PCIE_INIT_CFG2		0x1004
>  #define B_AX_WD_ITVL_IDLE		GENMASK(27, 24)
>  #define B_AX_WD_ITVL_ACT		GENMASK(19, 16)
> ------Please consider the environment before printing this e-mail.
