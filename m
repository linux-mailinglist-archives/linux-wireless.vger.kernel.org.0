Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDEB968231
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jul 2019 04:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbfGOCYP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 14 Jul 2019 22:24:15 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:37916 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbfGOCYP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 14 Jul 2019 22:24:15 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x6F2OBP2012615, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCASV02.realtek.com.tw[172.21.6.19])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x6F2OBP2012615
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 15 Jul 2019 10:24:11 +0800
Received: from RTITMBSVM04.realtek.com.tw ([fe80::e404:880:2ef1:1aa1]) by
 RTITCASV02.realtek.com.tw ([::1]) with mapi id 14.03.0439.000; Mon, 15 Jul
 2019 10:24:10 +0800
From:   Tony Chuang <yhchuang@realtek.com>
To:     Brian Norris <briannorris@chromium.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH] rtw88: make functions static
Thread-Topic: [PATCH] rtw88: make functions static
Thread-Index: AQHVORrTo8iomYKVBEG4St2hzEydHqbK9bcw
Date:   Mon, 15 Jul 2019 02:24:09 +0000
Message-ID: <F7CD281DE3E379468C6D07993EA72F84D1867CEE@RTITMBSVM04.realtek.com.tw>
References: <20190713013215.215008-1-briannorris@chromium.org>
In-Reply-To: <20190713013215.215008-1-briannorris@chromium.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.68.183]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

> Subject: [PATCH] rtw88: make functions static
> 
> They're only used in phy.c.
> 
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---
>  drivers/net/wireless/realtek/rtw88/phy.c | 13 ++++++++++---
>  drivers/net/wireless/realtek/rtw88/phy.h | 13 -------------
>  2 files changed, 10 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/net/wireless/realtek/rtw88/phy.c
> b/drivers/net/wireless/realtek/rtw88/phy.c
> index 4ec8dcf17361..4bb36eba7080 100644
> --- a/drivers/net/wireless/realtek/rtw88/phy.c
> +++ b/drivers/net/wireless/realtek/rtw88/phy.c
> @@ -140,7 +140,7 @@ void rtw_phy_init(struct rtw_dev *rtwdev)
>  	dm_info->igi_history[0] = rtw_read32_mask(rtwdev, addr, mask);
>  }
> 
> -void rtw_phy_dig_write(struct rtw_dev *rtwdev, u8 igi)
> +static void rtw_phy_dig_write(struct rtw_dev *rtwdev, u8 igi)
>  {
>  	struct rtw_chip_info *chip = rtwdev->chip;
>  	struct rtw_hal *hal = &rtwdev->hal;
> @@ -1603,8 +1603,15 @@ static s8 rtw_phy_get_tx_power_limit(struct
> rtw_dev *rtwdev, u8 band,
>  	return (s8)rtwdev->chip->max_power_index;
>  }
> 
> -void rtw_get_tx_power_params(struct rtw_dev *rtwdev, u8 path, u8 rate,
> u8 bw,
> -			     u8 ch, u8 regd, struct rtw_power_params *pwr_param)
> +struct rtw_power_params {
> +	u8 pwr_base;
> +	s8 pwr_offset;
> +	s8 pwr_limit;
> +};
> +
> +static void rtw_get_tx_power_params(struct rtw_dev *rtwdev, u8 path, u8
> rate,
> +				    u8 bw, u8 ch, u8 regd,
> +				    struct rtw_power_params *pwr_param)
>  {
>  	struct rtw_hal *hal = &rtwdev->hal;
>  	struct rtw_txpwr_idx *pwr_idx;
> diff --git a/drivers/net/wireless/realtek/rtw88/phy.h
> b/drivers/net/wireless/realtek/rtw88/phy.h
> index 7c8eb732b13c..0f90ea24c6d7 100644
> --- a/drivers/net/wireless/realtek/rtw88/phy.h
> +++ b/drivers/net/wireless/realtek/rtw88/phy.h
> @@ -103,19 +103,6 @@ static inline int rtw_check_supported_rfe(struct
> rtw_dev *rtwdev)
>  	return 0;
>  }
> 
> -void rtw_phy_dig_write(struct rtw_dev *rtwdev, u8 igi);
> -
> -struct rtw_power_params {
> -	u8 pwr_base;
> -	s8 pwr_offset;
> -	s8 pwr_limit;
> -};
> -
> -void
> -rtw_get_tx_power_params(struct rtw_dev *rtwdev, u8 path,
> -			u8 rate, u8 bw, u8 ch, u8 regd,
> -			struct rtw_power_params *pwr_param);
> -
>  #define	MASKBYTE0		0xff
>  #define	MASKBYTE1		0xff00
>  #define	MASKBYTE2		0xff0000
> --


I am sorry I have to NACK it.

Nothing wrong about this patch. Because in the last patch set I sent has
11 patches, but one of them is not applied by Kalle.
And I am going to resend it, which will use rtw_get_tx_power_params
in debug.c

Thanks,
Yan-Hsuan

