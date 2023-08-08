Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B86567735CE
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Aug 2023 03:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbjHHBWx convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 7 Aug 2023 21:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbjHHBWw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 7 Aug 2023 21:22:52 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3339410CF
        for <linux-wireless@vger.kernel.org>; Mon,  7 Aug 2023 18:22:50 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 3781LdnqE019428, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 3781LdnqE019428
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 8 Aug 2023 09:21:39 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Tue, 8 Aug 2023 09:21:55 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 8 Aug 2023 09:21:55 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Tue, 8 Aug 2023 09:21:55 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Yang Yingliang <yangyingliang@huawei.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     "kvalo@kernel.org" <kvalo@kernel.org>
Subject: RE: [PATCH -next] wifi: rtlwifi: use eth_broadcast_addr() to assign broadcast address
Thread-Topic: [PATCH -next] wifi: rtlwifi: use eth_broadcast_addr() to assign
 broadcast address
Thread-Index: AQHZxrKkROrQy+8xeESt6N5eKljAR6/fn/Jw
Date:   Tue, 8 Aug 2023 01:21:55 +0000
Message-ID: <79c02ca0927442419c091bcbc36cac08@realtek.com>
References: <20230804090120.1332091-1-yangyingliang@huawei.com>
In-Reply-To: <20230804090120.1332091-1-yangyingliang@huawei.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS06.realtek.com.tw, 9
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
> From: Yang Yingliang <yangyingliang@huawei.com>
> Sent: Friday, August 4, 2023 5:01 PM
> To: linux-wireless@vger.kernel.org
> Cc: Ping-Ke Shih <pkshih@realtek.com>; kvalo@kernel.org; yangyingliang@huawei.com
> Subject: [PATCH -next] wifi: rtlwifi: use eth_broadcast_addr() to assign broadcast address
> 
> Use eth_broadcast_addr() to assign broadcast address instead
> of memcpy().
> 
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>

Acked-by: Ping-Ke Shih <pkshih@realtek.com>


> ---
>  drivers/net/wireless/realtek/rtlwifi/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/realtek/rtlwifi/core.c b/drivers/net/wireless/realtek/rtlwifi/core.c
> index 4fb16f5f6f83..3835b639d453 100644
> --- a/drivers/net/wireless/realtek/rtlwifi/core.c
> +++ b/drivers/net/wireless/realtek/rtlwifi/core.c
> @@ -1656,7 +1656,7 @@ static int rtl_op_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
>                         memcpy(rtlpriv->sec.key_buf[key_idx],
>                                key->key, key->keylen);
>                         rtlpriv->sec.key_len[key_idx] = key->keylen;
> -                       memcpy(mac_addr, bcast_addr, ETH_ALEN);
> +                       eth_broadcast_addr(mac_addr);
>                 } else {        /* pairwise key */
>                         rtl_dbg(rtlpriv, COMP_SEC, DBG_DMESG,
>                                 "set pairwise key\n");
> --
> 2.25.1
> 
> 
> ------Please consider the environment before printing this e-mail.
