Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 004AF773D19
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Aug 2023 18:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231950AbjHHQN4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Aug 2023 12:13:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232123AbjHHQM6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Aug 2023 12:12:58 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 51A9F7ED8;
        Tue,  8 Aug 2023 08:47:07 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 3788UJm14028255, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 3788UJm14028255
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 8 Aug 2023 16:30:19 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Tue, 8 Aug 2023 16:30:36 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 8 Aug 2023 16:30:35 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Tue, 8 Aug 2023 16:30:35 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Dan Carpenter <dan.carpenter@linaro.org>,
        Timlee <timlee@realtek.com>
CC:     Kalle Valo <kvalo@kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: RE: [PATCH] wifi: rtw89: fix a width vs precision bug
Thread-Topic: [PATCH] wifi: rtw89: fix a width vs precision bug
Thread-Index: AQHZybpDmVTowi+UH0ybzDOrOQuAoK/gEY2w
Date:   Tue, 8 Aug 2023 08:30:35 +0000
Message-ID: <63f8219b49604fc9805319c391ee44bf@realtek.com>
References: <0700c7b9-bfd3-4aa6-82bf-5bf3c74644e1@moroto.mountain>
In-Reply-To: <0700c7b9-bfd3-4aa6-82bf-5bf3c74644e1@moroto.mountain>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS03.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



> -----Original Message-----
> From: Dan Carpenter <dan.carpenter@linaro.org>
> Sent: Tuesday, August 8, 2023 1:36 PM
> To: Timlee <timlee@realtek.com>
> Cc: Ping-Ke Shih <pkshih@realtek.com>; Kalle Valo <kvalo@kernel.org>; linux-wireless@vger.kernel.org;
> kernel-janitors@vger.kernel.org
> Subject: [PATCH] wifi: rtw89: fix a width vs precision bug
> 
> The "buf" is skb->data that comes from the firmware.  We want to print
> "len" number of bytes.  But there is a missing period so the "len"
> variable is used for formatting (width) instead of limiting the output
> (precision).
> 
> Fixes: cad2bd8a136c ("wifi: rtw89: support firmware log with formatted text")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Thanks for the fix. 

Acked-by: Ping-Ke Shih <pkshih@realtek.com>

> ---
>  drivers/net/wireless/realtek/rtw89/fw.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
> index 2811a94b5f69..bcd9050f989f 100644
> --- a/drivers/net/wireless/realtek/rtw89/fw.c
> +++ b/drivers/net/wireless/realtek/rtw89/fw.c
> @@ -1165,7 +1165,7 @@ void rtw89_fw_log_dump(struct rtw89_dev *rtwdev, u8 *buf, u32 len)
>         return;
> 
>  plain_log:
> -       rtw89_info(rtwdev, "C2H log: %*s", len, buf);
> +       rtw89_info(rtwdev, "C2H log: %.*s", len, buf);
> 
>  }
> 
> --
> 2.39.2
> 
> 
> ------Please consider the environment before printing this e-mail.
