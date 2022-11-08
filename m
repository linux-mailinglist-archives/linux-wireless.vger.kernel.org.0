Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E56A620651
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Nov 2022 02:50:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232851AbiKHBug convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 7 Nov 2022 20:50:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiKHBue (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 7 Nov 2022 20:50:34 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 31F831DF18
        for <linux-wireless@vger.kernel.org>; Mon,  7 Nov 2022 17:50:34 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 2A81nmtP7024589, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 2A81nmtP7024589
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 8 Nov 2022 09:49:48 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.9; Tue, 8 Nov 2022 09:50:26 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 8 Nov 2022 09:50:26 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::15b5:fc4b:72f3:424b]) by
 RTEXMBS04.realtek.com.tw ([fe80::15b5:fc4b:72f3:424b%5]) with mapi id
 15.01.2375.007; Tue, 8 Nov 2022 09:50:26 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>,
        "kvalo@kernel.org" <kvalo@kernel.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH v2] wifi: rtw89: use u32_encode_bits() to fill MAC quota value
Thread-Topic: [PATCH v2] wifi: rtw89: use u32_encode_bits() to fill MAC quota
 value
Thread-Index: AQHY8xL7uwkfCE/Zqk6qrRDHJiaYwK40QmvA
Date:   Tue, 8 Nov 2022 01:50:26 +0000
Message-ID: <202a8ca82878417d87e2f8c40c564360@realtek.com>
References: <20221108013858.10806-1-pkshih@realtek.com>
In-Reply-To: <20221108013858.10806-1-pkshih@realtek.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS01.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?us-ascii?Q?Clean,_bases:_2022/11/7_=3F=3F_10:50:00?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


> -----Original Message-----
> From: Ping-Ke Shih <pkshih@realtek.com>
> Sent: Tuesday, November 8, 2022 9:39 AM
> To: kvalo@kernel.org
> Cc: linux-wireless@vger.kernel.org
> Subject: [PATCH v2] wifi: rtw89: use u32_encode_bits() to fill MAC quota value
> 
> Coverity reported shift 16 bits could cause sign extension and might get
> an unexpected value. Since the input values are predefined and no this
> kind of case, original code is safe so far. But, still changing them to
> use u32_encode_bits() will be more clear and prevent mistakes in the
> future.
> 
> The original message of Coverity is:
>   Suspicious implicit sign extension: "max_cfg->cma0_dma" with type "u16"
>   (16 bits, unsigned) is promoted in "max_cfg->cma0_dma << 16" to type
>   "int" (32 bits, signed), then sign-extended to type "unsigned long"
>   (64 bits, unsigned).  If "max_cfg->cma0_dma << 16" is greater than
>   0x7FFFFFFF, the upper bits of the result will all be 1."
> 
> Reported-by: coverity-bot <keescook+coverity-bot@chromium.org>
> Addresses-Coverity-ID: 1527095 ("Integer handling issues")
> Fixes: e3ec7017f6a2 ("rtw89: add Realtek 802.11ax driver")
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

Sorry, I forget to add changelog of v2.

v2: use u32_encode_bits() instead of FIELD_PREP() to set field value.

> ---
>  drivers/net/wireless/realtek/rtw89/mac.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
> index bb49033b587d2..814ca4bc22587 100644
> --- a/drivers/net/wireless/realtek/rtw89/mac.c
> +++ b/drivers/net/wireless/realtek/rtw89/mac.c
> @@ -1487,10 +1487,8 @@ static int dle_mix_cfg(struct rtw89_dev *rtwdev, const struct rtw89_dle_mem *cfg
>  #define INVALID_QT_WCPU U16_MAX
>  #define SET_QUOTA_VAL(_min_x, _max_x, _module, _idx)			\
>  	do {								\
> -		val = ((_min_x) &					\
> -		       B_AX_ ## _module ## _MIN_SIZE_MASK) |		\
> -		      (((_max_x) << 16) &				\
> -		       B_AX_ ## _module ## _MAX_SIZE_MASK);		\
> +		val = u32_encode_bits(_min_x, B_AX_ ## _module ## _MIN_SIZE_MASK) | \
> +		      u32_encode_bits(_max_x, B_AX_ ## _module ## _MAX_SIZE_MASK);  \
>  		rtw89_write32(rtwdev,					\
>  			      R_AX_ ## _module ## _QTA ## _idx ## _CFG,	\
>  			      val);					\
> --
> 2.25.1
> 
> 
> ------Please consider the environment before printing this e-mail.
