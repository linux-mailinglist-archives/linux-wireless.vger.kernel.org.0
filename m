Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4729F4C06AA
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Feb 2022 02:11:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235989AbiBWBLv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Feb 2022 20:11:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231278AbiBWBLv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Feb 2022 20:11:51 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 910E460D9
        for <linux-wireless@vger.kernel.org>; Tue, 22 Feb 2022 17:11:22 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 21N1B4Ph8003363, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 21N1B4Ph8003363
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 23 Feb 2022 09:11:04 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 23 Feb 2022 09:11:04 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 23 Feb 2022 09:11:04 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::35e4:d9d1:102d:605e]) by
 RTEXMBS04.realtek.com.tw ([fe80::35e4:d9d1:102d:605e%5]) with mapi id
 15.01.2308.020; Wed, 23 Feb 2022 09:11:04 +0800
From:   Pkshih <pkshih@realtek.com>
To:     Johannes Berg <johannes@sipsolutions.net>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     Johannes Berg <johannes.berg@intel.com>
Subject: RE: [PATCH] rtw89: fix HE PHY bandwidth capability
Thread-Topic: [PATCH] rtw89: fix HE PHY bandwidth capability
Thread-Index: AQHYKB3IS13LfKuRe0OqokuuAjdIz6ygSDBQ
Date:   Wed, 23 Feb 2022 01:11:03 +0000
Message-ID: <c498cb83da3e4147a26cf1f2df21e96b@realtek.com>
References: <20220222195524.1e3cc6f7e4c3.I72ea8a9cad5eff93bcb3a0912727d03605ddb6e6@changeid>
In-Reply-To: <20220222195524.1e3cc6f7e4c3.I72ea8a9cad5eff93bcb3a0912727d03605ddb6e6@changeid>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS02.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?us-ascii?Q?Clean,_bases:_2022/2/22_=3F=3F_10:00:00?=
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
> From: Johannes Berg <johannes@sipsolutions.net>
> Sent: Wednesday, February 23, 2022 2:55 AM
> To: linux-wireless@vger.kernel.org
> Cc: Pkshih <pkshih@realtek.com>; Johannes Berg <johannes.berg@intel.com>
> Subject: [PATCH] rtw89: fix HE PHY bandwidth capability
> 
> From: Johannes Berg <johannes.berg@intel.com>
> 
> Bit 0 is reserved on 5/6 GHz and bit 1 is reserved on 2.4 GHz,
> so the driver should only set the non-reserved bits according
> to band.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>

Acked-by: Ping-Ke Shih <pkshih@realtek.com>

Thanks for the fix.

> ---
>  drivers/net/wireless/realtek/rtw89/core.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
> index a0737eea9f81..1f0bea9a148c 100644
> --- a/drivers/net/wireless/realtek/rtw89/core.c
> +++ b/drivers/net/wireless/realtek/rtw89/core.c
> @@ -2087,8 +2087,12 @@ static void rtw89_init_he_cap(struct rtw89_dev *rtwdev,
>  				  IEEE80211_HE_MAC_CAP4_AMSDU_IN_AMPDU;
>  		if (i == NL80211_IFTYPE_STATION)
>  			mac_cap_info[5] = IEEE80211_HE_MAC_CAP5_HT_VHT_TRIG_FRAME_RX;
> -		phy_cap_info[0] = IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_IN_2G |
> -				  IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_80MHZ_IN_5G;
> +		if (band == NL80211_BAND_2GHZ)
> +			phy_cap_info[0] =
> +				IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_IN_2G;
> +		else
> +			phy_cap_info[0] =
> +				IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_80MHZ_IN_5G;
>  		phy_cap_info[1] = IEEE80211_HE_PHY_CAP1_DEVICE_CLASS_A |
>  				  IEEE80211_HE_PHY_CAP1_LDPC_CODING_IN_PAYLOAD |
>  				  IEEE80211_HE_PHY_CAP1_HE_LTF_AND_GI_FOR_HE_PPDUS_0_8US;
> --
> 2.35.1

