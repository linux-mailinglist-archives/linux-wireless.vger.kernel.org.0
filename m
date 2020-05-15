Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6895C1D45B6
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2020 08:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbgEOGRA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 15 May 2020 02:17:00 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:58704 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726607AbgEOGRA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 15 May 2020 02:17:00 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 04F6Guj96003484, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 04F6Guj96003484
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 15 May 2020 14:16:56 +0800
Received: from RTEXMB05.realtek.com.tw (172.21.6.98) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 15 May 2020 14:16:56 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 15 May 2020 14:16:55 +0800
Received: from RTEXMB04.realtek.com.tw ([fe80::8001:f5f5:a41e:f8d4]) by
 RTEXMB04.realtek.com.tw ([fe80::8001:f5f5:a41e:f8d4%3]) with mapi id
 15.01.1779.005; Fri, 15 May 2020 14:16:55 +0800
From:   Tony Chuang <yhchuang@realtek.com>
To:     Kevin Lo <kevlo@kevlo.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH] rtw88: no need to set registers for SDIO
Thread-Topic: [PATCH] rtw88: no need to set registers for SDIO
Thread-Index: AQHWKn/Dqydgzu91sEWaS30901+BzqioqyMw
Date:   Fri, 15 May 2020 06:16:55 +0000
Message-ID: <9ba0e2a24a82436b9fe2595d86afccbc@realtek.com>
References: <20200515061153.GA15714@ns.kevlo.org>
In-Reply-To: <20200515061153.GA15714@ns.kevlo.org>
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

Kevin Lo <kevlo@kevlo.org> writes:
> Subject: [PATCH] rtw88: no need to set registers for SDIO
> 
> There's no need to set SDIO related registers when powering up/down the chip.
> 
> Signed-off-by: Kevin Lo <kevlo@kevlo.org>
> ---
> diff --git a/drivers/net/wireless/realtek/rtw88/rtw8723d.c
> b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
> index b517af417e0e..5e0b7999bc8a 100644
> --- a/drivers/net/wireless/realtek/rtw88/rtw8723d.c
> +++ b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
> @@ -2092,16 +2092,6 @@ static const struct rtw_pwr_seq_cmd
> trans_carddis_to_cardemu_8723d[] = {
>  	 RTW_PWR_INTF_ALL_MSK,
>  	 RTW_PWR_ADDR_MAC,
>  	 RTW_PWR_CMD_WRITE, BIT(3) | BIT(7), 0},
> -	{0x0086,
> -	 RTW_PWR_CUT_ALL_MSK,
> -	 RTW_PWR_INTF_SDIO_MSK,
> -	 RTW_PWR_ADDR_SDIO,
> -	 RTW_PWR_CMD_WRITE, BIT(0), 0},
> -	{0x0086,
> -	 RTW_PWR_CUT_ALL_MSK,
> -	 RTW_PWR_INTF_SDIO_MSK,
> -	 RTW_PWR_ADDR_SDIO,
> -	 RTW_PWR_CMD_POLLING, BIT(1), BIT(1)},
>  	{0x004A,
>  	 RTW_PWR_CUT_ALL_MSK,
>  	 RTW_PWR_INTF_USB_MSK,

I don't think we should remove SDIO part in the power sequence.
The power sequence parse will recognize the HCI interface. So the
SDIO settings will not be applied at all. We can keep them here until
the SDIO module is added and supported.

Yen-Hsuan
