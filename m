Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C4C37D06C6
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Oct 2023 05:15:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233434AbjJTDPg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Oct 2023 23:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233405AbjJTDPe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Oct 2023 23:15:34 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C6851A3
        for <linux-wireless@vger.kernel.org>; Thu, 19 Oct 2023 20:15:29 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 39K3F8F003688896, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.93/5.92) with ESMTPS id 39K3F8F003688896
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Oct 2023 11:15:08 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Fri, 20 Oct 2023 11:15:09 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 20 Oct 2023 11:15:08 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7]) by
 RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7%5]) with mapi id
 15.01.2375.007; Fri, 20 Oct 2023 11:15:08 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Dmitry Antipov <dmantipov@yandex.ru>
CC:     Tom Rix <trix@redhat.com>, Kalle Valo <kvalo@kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH] wifi: rtw89: fix clang-specific -Wvoid-pointer-to-enum-cast
Thread-Topic: [PATCH] wifi: rtw89: fix clang-specific
 -Wvoid-pointer-to-enum-cast
Thread-Index: AQHaAnBCw39yzz4wEEKXQI7s1bYCxbBR/qSw
Date:   Fri, 20 Oct 2023 03:15:08 +0000
Message-ID: <661e7dffafdb403abc2c4cab23c7d1ed@realtek.com>
References: <20231019093805.66324-1-dmantipov@yandex.ru>
In-Reply-To: <20231019093805.66324-1-dmantipov@yandex.ru>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-originating-ip: [172.21.71.113]
x-kse-serverinfo: RTEXMBS04.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



> -----Original Message-----
> From: Dmitry Antipov <dmantipov@yandex.ru>
> Sent: Thursday, October 19, 2023 5:38 PM
> To: Ping-Ke Shih <pkshih@realtek.com>
> Cc: Tom Rix <trix@redhat.com>; Kalle Valo <kvalo@kernel.org>; linux-wireless@vger.kernel.org; Dmitry
> Antipov <dmantipov@yandex.ru>
> Subject: [PATCH] wifi: rtw89: fix clang-specific -Wvoid-pointer-to-enum-cast

Please point out "fw_element" in subject, so it would be clear to know what
we are dealing with. 

> 
> When compiling with clang-18, I've noticed the following:
> 
> drivers/net/wireless/realtek/rtw89/fw.c:389:28: warning: cast to smaller
> integer type 'enum rtw89_fw_type' from 'const void *' [-Wvoid-pointer-to-enum-cast]
>   389 |         enum rtw89_fw_type type = (enum rtw89_fw_type)data;
>       |                                   ^~~~~~~~~~~~~~~~~~~~~~~~
> drivers/net/wireless/realtek/rtw89/fw.c:569:13: warning: cast to smaller
> integer type 'enum rtw89_rf_path' from 'const void *' [-Wvoid-pointer-to-enum-cast]
>   569 |                 rf_path = (enum rtw89_rf_path)data;
>       |                           ^~~~~~~~~~~~~~~~~~~~~~~~
> 
> So avoid brutal everything-to-const-void-and-back casts, introduce
> 'union rtw89_fw_element_data' to pass parameters to element handler
> callbacks, and adjust all of the related bits accordingly. Compile
> tested only.
> 
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> ---
>  drivers/net/wireless/realtek/rtw89/fw.c | 81 +++++++++++++++----------
>  1 file changed, 50 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
> index 7cfcf536d6fe..13a98c44d304 100644
> --- a/drivers/net/wireless/realtek/rtw89/fw.c
> +++ b/drivers/net/wireless/realtek/rtw89/fw.c
> @@ -13,6 +13,20 @@
>  #include "reg.h"
>  #include "util.h"
> 
> +union rtw89_fw_element_data {

"fw_element_data" could be confusing, because it looks like data from firmware file.
Prefer "fw_element_arg" or "fw_element_var", because the certain handler can handle
various cases of fw_element_id. 

Then, third argument of handler becomes 'const union rtw89_fw_element_arg arg'.

> +       size_t offset;
> +       enum rtw89_rf_path path;
> +       enum rtw89_fw_type type;

'rf_path' and 'fw_type' would be clearer. 

> +};
> +
> +struct rtw89_fw_element_handler {
> +       int (*fn)(struct rtw89_dev *rtwdev,
> +                 const struct rtw89_fw_element_hdr *elm,
> +                 const union rtw89_fw_element_data data);
> +       const union rtw89_fw_element_data data;
> +       const char *name;
> +};
> +
>  static void rtw89_fw_c2h_cmd_handle(struct rtw89_dev *rtwdev,
>                                     struct sk_buff *skb);
>  static int rtw89_h2c_tx_and_wait(struct rtw89_dev *rtwdev, struct sk_buff *skb,
> @@ -384,9 +398,9 @@ int __rtw89_fw_recognize(struct rtw89_dev *rtwdev, enum rtw89_fw_type type,
>  static
>  int __rtw89_fw_recognize_from_elm(struct rtw89_dev *rtwdev,
>                                   const struct rtw89_fw_element_hdr *elm,
> -                                 const void *data)
> +                                 const union rtw89_fw_element_data data)
>  {
> -       enum rtw89_fw_type type = (enum rtw89_fw_type)data;
> +       enum rtw89_fw_type type = data.type;
>         struct rtw89_fw_suit *fw_suit;
> 
>         fw_suit = rtw89_fw_suit_get(rtwdev, type);
> @@ -542,7 +556,7 @@ int rtw89_fw_recognize(struct rtw89_dev *rtwdev)
>  static
>  int rtw89_build_phy_tbl_from_elm(struct rtw89_dev *rtwdev,
>                                  const struct rtw89_fw_element_hdr *elm,
> -                                const void *data)
> +                                const union rtw89_fw_element_data data)
>  {
>         struct rtw89_fw_elm_info *elm_info = &rtwdev->fw.elm_info;
>         struct rtw89_phy_table *tbl;
> @@ -566,7 +580,7 @@ int rtw89_build_phy_tbl_from_elm(struct rtw89_dev *rtwdev,
>         case RTW89_FW_ELEMENT_ID_RADIO_B:
>         case RTW89_FW_ELEMENT_ID_RADIO_C:
>         case RTW89_FW_ELEMENT_ID_RADIO_D:
> -               rf_path = (enum rtw89_rf_path)data;
> +               rf_path = data.path;
>                 idx = elm->u.reg2.idx;
> 
>                 elm_info->rf_radio[idx] = tbl;
> @@ -604,10 +618,10 @@ int rtw89_build_phy_tbl_from_elm(struct rtw89_dev *rtwdev,
>  static
>  int rtw89_fw_recognize_txpwr_from_elm(struct rtw89_dev *rtwdev,
>                                       const struct rtw89_fw_element_hdr *elm,
> -                                     const void *data)
> +                                     union rtw89_fw_element_data data)

const union rtw89_fw_element_data data

miss 'const' here.

>  {
>         const struct __rtw89_fw_txpwr_element *txpwr_elm = &elm->u.txpwr;
> -       const unsigned long offset = (const unsigned long)data;
> +       const unsigned long offset = data.offset;
>         struct rtw89_efuse *efuse = &rtwdev->efuse;
>         struct rtw89_txpwr_conf *conf;
> 
> @@ -644,64 +658,69 @@ int rtw89_fw_recognize_txpwr_from_elm(struct rtw89_dev *rtwdev,
>         return 0;
>  }
> 
> -struct rtw89_fw_element_handler {
> -       int (*fn)(struct rtw89_dev *rtwdev,
> -                 const struct rtw89_fw_element_hdr *elm, const void *data);
> -       const void *data;
> -       const char *name;
> -};
> -
>  static const struct rtw89_fw_element_handler __fw_element_handlers[] = {
>         [RTW89_FW_ELEMENT_ID_BBMCU0] = {__rtw89_fw_recognize_from_elm,
> -                                       (const void *)RTW89_FW_BBMCU0, NULL},
> +                                       { .type = RTW89_FW_BBMCU0 }, NULL},
>         [RTW89_FW_ELEMENT_ID_BBMCU1] = {__rtw89_fw_recognize_from_elm,
> -                                       (const void *)RTW89_FW_BBMCU1, NULL},
> -       [RTW89_FW_ELEMENT_ID_BB_REG] = {rtw89_build_phy_tbl_from_elm, NULL, "BB"},
> -       [RTW89_FW_ELEMENT_ID_BB_GAIN] = {rtw89_build_phy_tbl_from_elm, NULL, NULL},
> +                                       { .type = RTW89_FW_BBMCU1 }, NULL},
> +       [RTW89_FW_ELEMENT_ID_BB_REG] = {rtw89_build_phy_tbl_from_elm,
> +                                       { 0 }, "BB"},

Can we just '{}' instead? And, straighten it to single one line as before, like

[RTW89_FW_ELEMENT_ID_BB_REG] = {rtw89_build_phy_tbl_from_elm, {], "BB"},

> +       [RTW89_FW_ELEMENT_ID_BB_GAIN] = {rtw89_build_phy_tbl_from_elm,
> +                                        { 0 }, NULL},
>         [RTW89_FW_ELEMENT_ID_RADIO_A] = {rtw89_build_phy_tbl_from_elm,
> -                                        (const void *)RF_PATH_A, "radio A"},
> +                                        { .path = RF_PATH_A }, "radio A"},
>         [RTW89_FW_ELEMENT_ID_RADIO_B] = {rtw89_build_phy_tbl_from_elm,
> -                                        (const void *)RF_PATH_B, NULL},
> +                                        { .path = RF_PATH_B }, NULL},
>         [RTW89_FW_ELEMENT_ID_RADIO_C] = {rtw89_build_phy_tbl_from_elm,
> -                                        (const void *)RF_PATH_C, NULL},
> +                                        { .path = RF_PATH_C }, NULL},
>         [RTW89_FW_ELEMENT_ID_RADIO_D] = {rtw89_build_phy_tbl_from_elm,
> -                                        (const void *)RF_PATH_D, NULL},
> -       [RTW89_FW_ELEMENT_ID_RF_NCTL] = {rtw89_build_phy_tbl_from_elm, NULL, "NCTL"},
> +                                        { .path = RF_PATH_D }, NULL},
> +       [RTW89_FW_ELEMENT_ID_RF_NCTL] = {rtw89_build_phy_tbl_from_elm,
> +                                        { 0 }, "NCTL"},
>         [RTW89_FW_ELEMENT_ID_TXPWR_BYRATE] = {
>                 rtw89_fw_recognize_txpwr_from_elm,
> -               (const void *)offsetof(struct rtw89_rfe_data, byrate.conf), "TXPWR",
> +               { .offset = offsetof(struct rtw89_rfe_data, byrate.conf) },
> +               "TXPWR",

Prefer keeping original single-one-line style.

>         },
>         [RTW89_FW_ELEMENT_ID_TXPWR_LMT_2GHZ] = {
>                 rtw89_fw_recognize_txpwr_from_elm,
> -               (const void *)offsetof(struct rtw89_rfe_data, lmt_2ghz.conf), NULL,
> +               { .offset = offsetof(struct rtw89_rfe_data, lmt_2ghz.conf) },
> +               NULL,
>         },
>         [RTW89_FW_ELEMENT_ID_TXPWR_LMT_5GHZ] = {
>                 rtw89_fw_recognize_txpwr_from_elm,
> -               (const void *)offsetof(struct rtw89_rfe_data, lmt_5ghz.conf), NULL,
> +               { .offset = offsetof(struct rtw89_rfe_data, lmt_5ghz.conf) },
> +               NULL,
>         },
>         [RTW89_FW_ELEMENT_ID_TXPWR_LMT_6GHZ] = {
>                 rtw89_fw_recognize_txpwr_from_elm,
> -               (const void *)offsetof(struct rtw89_rfe_data, lmt_6ghz.conf), NULL,
> +               { .offset = offsetof(struct rtw89_rfe_data, lmt_6ghz.conf) },
> +               NULL,
>         },
>         [RTW89_FW_ELEMENT_ID_TXPWR_LMT_RU_2GHZ] = {
>                 rtw89_fw_recognize_txpwr_from_elm,
> -               (const void *)offsetof(struct rtw89_rfe_data, lmt_ru_2ghz.conf), NULL,
> +               { .offset = offsetof(struct rtw89_rfe_data, lmt_ru_2ghz.conf) },
> +               NULL,
>         },
>         [RTW89_FW_ELEMENT_ID_TXPWR_LMT_RU_5GHZ] = {
>                 rtw89_fw_recognize_txpwr_from_elm,
> -               (const void *)offsetof(struct rtw89_rfe_data, lmt_ru_5ghz.conf), NULL,
> +               { .offset = offsetof(struct rtw89_rfe_data, lmt_ru_5ghz.conf) },
> +               NULL,
>         },
>         [RTW89_FW_ELEMENT_ID_TXPWR_LMT_RU_6GHZ] = {
>                 rtw89_fw_recognize_txpwr_from_elm,
> -               (const void *)offsetof(struct rtw89_rfe_data, lmt_ru_6ghz.conf), NULL,
> +               { .offset = offsetof(struct rtw89_rfe_data, lmt_ru_6ghz.conf) },
> +               NULL,
>         },
>         [RTW89_FW_ELEMENT_ID_TX_SHAPE_LMT] = {
>                 rtw89_fw_recognize_txpwr_from_elm,
> -               (const void *)offsetof(struct rtw89_rfe_data, tx_shape_lmt.conf), NULL,
> +               { .offset = offsetof(struct rtw89_rfe_data, tx_shape_lmt.conf) },
> +               NULL,
>         },
>         [RTW89_FW_ELEMENT_ID_TX_SHAPE_LMT_RU] = {
>                 rtw89_fw_recognize_txpwr_from_elm,
> -               (const void *)offsetof(struct rtw89_rfe_data, tx_shape_lmt_ru.conf), NULL,
> +               { .offset = offsetof(struct rtw89_rfe_data, tx_shape_lmt_ru.conf) },
> +               NULL,
>         },
>  };
> 
> --
> 2.41.0

