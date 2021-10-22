Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C724C436ED1
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Oct 2021 02:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231839AbhJVA2w convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 21 Oct 2021 20:28:52 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:49682 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231518AbhJVA2v (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 21 Oct 2021 20:28:51 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 19M0QV2b8000554, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36503.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 19M0QV2b8000554
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 22 Oct 2021 08:26:31 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36503.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Fri, 22 Oct 2021 08:26:30 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Fri, 22 Oct 2021 08:26:30 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::dc53:1026:298b:c584]) by
 RTEXMBS04.realtek.com.tw ([fe80::dc53:1026:298b:c584%5]) with mapi id
 15.01.2308.015; Fri, 22 Oct 2021 08:26:30 +0800
From:   Pkshih <pkshih@realtek.com>
To:     Kevin Lo <kevlo@kevlo.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH wireless-drivers-next] rtw89: fix return value in hfc_pub_cfg_chk
Thread-Topic: [PATCH wireless-drivers-next] rtw89: fix return value in
 hfc_pub_cfg_chk
Thread-Index: AQHXxkVsr6e1roetX0aUMBS7DDo4QaveJ0Aw
Date:   Fri, 22 Oct 2021 00:26:30 +0000
Message-ID: <b100f663e7c346b09ed901bd72728410@realtek.com>
References: <YXEJey8lKksAZif4@ns.kevlo.org>
In-Reply-To: <YXEJey8lKksAZif4@ns.kevlo.org>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS06.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?us-ascii?Q?Clean,_bases:_2021/10/21_=3F=3F_10:00:00?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-KSE-ServerInfo: RTEXH36503.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-AntiSpam-Outbound-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 10/22/2021 00:10:10
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 166878 [Oct 22 2021]
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
X-KSE-Antiphishing-Bases: 10/22/2021 00:14:00
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


> -----Original Message-----
> From: Kevin Lo <kevlo@kevlo.org>
> Sent: Thursday, October 21, 2021 2:32 PM
> To: linux-wireless@vger.kernel.org
> Cc: Pkshih <pkshih@realtek.com>
> Subject: [PATCH wireless-drivers-next] rtw89: fix return value in hfc_pub_cfg_chk
> 
> It seems to me when pub_cfg->grp0 + pub_cfg->grp1 != pub_cfg->pub_max is true,
> it should return -EFAULT rather than 0.  Otherwise, the function doesn't need
> to exist.
> 
> Signed-off-by: Kevin Lo <kevlo@kevlo.org>

Acked-by: Ping-Ke Shih <pkshih@realtek.com>

> ---
> diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
> index 69384c43c046..afcd07ab1de7 100644
> --- a/drivers/net/wireless/realtek/rtw89/mac.c
> +++ b/drivers/net/wireless/realtek/rtw89/mac.c
> @@ -560,7 +560,7 @@ static int hfc_pub_cfg_chk(struct rtw89_dev *rtwdev)
>  	const struct rtw89_hfc_pub_cfg *pub_cfg = &param->pub_cfg;
> 
>  	if (pub_cfg->grp0 + pub_cfg->grp1 != pub_cfg->pub_max)
> -		return 0;
> +		return -EFAULT;

Fortunately, current checking is always equal, so it doesn't affect the result.

> 
>  	return 0;
>  }


--
Ping-Ke

