Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E317D5BA37C
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Sep 2022 02:26:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbiIPAZ0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 15 Sep 2022 20:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiIPAZX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 15 Sep 2022 20:25:23 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EB0A241980;
        Thu, 15 Sep 2022 17:25:21 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 28G0OcFgA011362, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 28G0OcFgA011362
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 16 Sep 2022 08:24:38 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 16 Sep 2022 08:24:59 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 16 Sep 2022 08:24:59 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::402d:f52e:eaf0:28a2]) by
 RTEXMBS04.realtek.com.tw ([fe80::402d:f52e:eaf0:28a2%5]) with mapi id
 15.01.2375.007; Fri, 16 Sep 2022 08:24:59 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Kevin Yang <kevin_yang@realtek.com>
CC:     Kalle Valo <kvalo@kernel.org>, Kevin Yang <kevin_yang@realtek.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: RE: [PATCH] wifi: rtw89: uninitialized variable on error in rtw89_early_fw_feature_recognize()
Thread-Topic: [PATCH] wifi: rtw89: uninitialized variable on error in
 rtw89_early_fw_feature_recognize()
Thread-Index: AQHYyQ1o/mFdmIMpL0eBK9/XzDvoD63hMxKA
Date:   Fri, 16 Sep 2022 00:24:58 +0000
Message-ID: <8bd6294dfbc74c3f8ac5e75156be9884@realtek.com>
References: <YyMzDtX/3fUBnonC@kili>
In-Reply-To: <YyMzDtX/3fUBnonC@kili>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS03.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?us-ascii?Q?Clean,_bases:_2022/9/15_=3F=3F_10:57:00?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-KSE-ServerInfo: RTEXH36504.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


> -----Original Message-----
> From: Dan Carpenter <dan.carpenter@oracle.com>
> Sent: Thursday, September 15, 2022 10:14 PM
> To: Ping-Ke Shih <pkshih@realtek.com>; Kevin Yang <kevin_yang@realtek.com>
> Cc: Kalle Valo <kvalo@kernel.org>; Kevin Yang <kevin_yang@realtek.com>; linux-wireless@vger.kernel.org;
> kernel-janitors@vger.kernel.org
> Subject: [PATCH] wifi: rtw89: uninitialized variable on error in rtw89_early_fw_feature_recognize()
> 
> If request_partial_firmware_into_buf() fails then "firmware" is not
> initialized and the release_firmware(firmware) will crash.
> 
> Fixes: deebea35d699 ("wifi: rtw89: early recognize FW feature to decide if chanctx")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Acked-by: Ping-Ke Shih <pkshih@realtek.com>

Thank you.

> ---
>  drivers/net/wireless/realtek/rtw89/fw.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
> index 8e4d0e18fa71..2be70b907762 100644
> --- a/drivers/net/wireless/realtek/rtw89/fw.c
> +++ b/drivers/net/wireless/realtek/rtw89/fw.c
> @@ -268,7 +268,7 @@ void rtw89_early_fw_feature_recognize(struct device *device,
>  						device, &buf, sizeof(buf), 0);
>  	if (ret) {
>  		dev_err(device, "failed to early request firmware: %d\n", ret);
> -		goto out;
> +		return;
>  	}
> 
>  	ver_code = buf.mfw_hdr.sig != RTW89_MFW_SIG ?
> --
> 2.35.1
> 
> 
> ------Please consider the environment before printing this e-mail.
