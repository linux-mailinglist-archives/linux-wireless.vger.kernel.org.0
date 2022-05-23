Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1E3B5306E9
	for <lists+linux-wireless@lfdr.de>; Mon, 23 May 2022 02:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232334AbiEWAqO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 22 May 2022 20:46:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbiEWAqM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 22 May 2022 20:46:12 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BCC011141
        for <linux-wireless@vger.kernel.org>; Sun, 22 May 2022 17:46:09 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 24N0jf7mB000647, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 24N0jf7mB000647
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 23 May 2022 08:45:41 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 23 May 2022 08:45:41 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 23 May 2022 08:45:40 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::34e7:ab63:3da4:27c6]) by
 RTEXMBS04.realtek.com.tw ([fe80::34e7:ab63:3da4:27c6%5]) with mapi id
 15.01.2308.021; Mon, 23 May 2022 08:45:40 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Kalle Valo <kvalo@kernel.org>
CC:     Johannes Berg <johannes@sipsolutions.net>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH 1/4] rtw88: Fix Sparse warning for rtw8822b
Thread-Topic: [PATCH 1/4] rtw88: Fix Sparse warning for rtw8822b
Thread-Index: AQHYbHnbH9w9YKP6Ik6hgAtKEYBpL60roVrQ
Date:   Mon, 23 May 2022 00:45:40 +0000
Message-ID: <e4d1d6cfcd9a423990a1a1e1cae38c0a@realtek.com>
References: <20220520184528.4078-1-Larry.Finger@lwfinger.net>
 <20220520184528.4078-2-Larry.Finger@lwfinger.net>
In-Reply-To: <20220520184528.4078-2-Larry.Finger@lwfinger.net>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXDAG01.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?us-ascii?Q?Clean,_bases:_2022/5/22_=3F=3F_10:00:00?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


> -----Original Message-----
> From: Larry Finger <Larry.Finger@lwfinger.net>
> Sent: Saturday, May 21, 2022 2:45 AM
> To: Kalle Valo <kvalo@kernel.org>
> Cc: Johannes Berg <johannes@sipsolutions.net>; linux-wireless@vger.kernel.org; Larry Finger
> <Larry.Finger@lwfinger.net>; Pkshih <pkshih@realtek.com>
> Subject: [PATCH 1/4] rtw88: Fix Sparse warning for rtw8822b
> 
> Sparse lists the following for rtw88:
> 
>   CHECK   drivers/net/wireless/realtek/rtw88/rtw8822b.c
> drivers/net/wireless/realtek/rtw88/rtw8822b.c:2500:22: warning: symbol 'rtw8822b_hw_spec' was not
> declared. Should it be static?
> 
> Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
> ---
>  drivers/net/wireless/realtek/rtw88/rtw8822b.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822b.c
> b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
> index dccd722b8e62..60c4e75df035 100644
> --- a/drivers/net/wireless/realtek/rtw88/rtw8822b.c
> +++ b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
> @@ -2497,7 +2497,7 @@ static struct rtw_hw_reg_offset rtw8822b_edcca_th[] = {
>  	[EDCCA_TH_H2L_IDX] = {{.addr = 0x8a4, .mask = MASKBYTE1}, .offset = 0},
>  };
> 
> -struct rtw_chip_info rtw8822b_hw_spec = {
> +static struct rtw_chip_info rtw8822b_hw_spec = {

As Kalle's recommendation, this should be 'const'

>  	.ops = &rtw8822b_ops,
>  	.id = RTW_CHIP_TYPE_8822B,
>  	.fw_name = "rtw88/rtw8822b_fw.bin",

I do grep with 'rtw8822b_hw_spec': 

rtw8822b.c:struct rtw_chip_info rtw8822b_hw_spec = {
rtw8822b.c:EXPORT_SYMBOL(rtw8822b_hw_spec);
rtw8822be.c:            .driver_data = (kernel_ulong_t)&rtw8822b_hw_spec
rtw8822be.h:extern struct rtw_chip_info rtw8822b_hw_spec;

Making rtw8822b_hw_spec static can avoid sparse warning, but I worry that it can't
be loaded, because it is an "external" symbol and used by rtw8822be.ko.
Spuriously, it works. 

However, I think we should correct them by moving extern prototype to rtw8822b.h and
include rtw8822b.h by rtw8822be.c.


Ping-Ke

