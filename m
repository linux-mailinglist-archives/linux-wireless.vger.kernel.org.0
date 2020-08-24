Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76DAA24F0F6
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Aug 2020 03:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbgHXBug convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 23 Aug 2020 21:50:36 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:55765 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726600AbgHXBug (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 23 Aug 2020 21:50:36 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 07O1oXPG1003630, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 07O1oXPG1003630
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 24 Aug 2020 09:50:33 +0800
Received: from RTEXMB05.realtek.com.tw (172.21.6.98) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 24 Aug 2020 09:50:33 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 24 Aug 2020 09:50:32 +0800
Received: from RTEXMB04.realtek.com.tw ([fe80::941:6388:7d34:5c44]) by
 RTEXMB04.realtek.com.tw ([fe80::941:6388:7d34:5c44%3]) with mapi id
 15.01.1779.005; Mon, 24 Aug 2020 09:50:32 +0800
From:   Tony Chuang <yhchuang@realtek.com>
To:     Brian Norris <briannorris@chromium.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH] rtw88: don't treat NULL pointer as an array
Thread-Topic: [PATCH] rtw88: don't treat NULL pointer as an array
Thread-Index: AQHWeAB4uJN/vdOmkEGwwlrKe37FlalGgY2A
Date:   Mon, 24 Aug 2020 01:50:32 +0000
Message-ID: <64d1446a178a48fc997c35b79b5cea23@realtek.com>
References: <20200821211716.1631556-1-briannorris@chromium.org>
In-Reply-To: <20200821211716.1631556-1-briannorris@chromium.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.68.175]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

> 
> I'm not a standards expert, but this really looks to be undefined
> behavior, when chip->dig_cck may be NULL. (And, we're trying to do a
> NULL check a few lines down, because some chip variants will use NULL.)
> 
> Fixes: fc637a860a82 ("rtw88: 8723d: Set IG register for CCK rate")

Acked-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---
>  drivers/net/wireless/realtek/rtw88/phy.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/wireless/realtek/rtw88/phy.c
> b/drivers/net/wireless/realtek/rtw88/phy.c
> index 8d93f3159746..9687b376d221 100644
> --- a/drivers/net/wireless/realtek/rtw88/phy.c
> +++ b/drivers/net/wireless/realtek/rtw88/phy.c
> @@ -147,12 +147,13 @@ void rtw_phy_dig_write(struct rtw_dev *rtwdev, u8
> igi)
>  {
>  	struct rtw_chip_info *chip = rtwdev->chip;
>  	struct rtw_hal *hal = &rtwdev->hal;
> -	const struct rtw_hw_reg *dig_cck = &chip->dig_cck[0];
>  	u32 addr, mask;
>  	u8 path;
> 
> -	if (dig_cck)
> +	if (chip->dig_cck) {
> +		const struct rtw_hw_reg *dig_cck = &chip->dig_cck[0];
>  		rtw_write32_mask(rtwdev, dig_cck->addr, dig_cck->mask, igi >> 1);
> +	}
> 
>  	for (path = 0; path < hal->rf_path_num; path++) {
>  		addr = chip->dig[path].addr;

Thanks.
Yen-Hsuan
