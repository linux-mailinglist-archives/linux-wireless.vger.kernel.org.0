Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57B736FA364
	for <lists+linux-wireless@lfdr.de>; Mon,  8 May 2023 11:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232528AbjEHJcg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 8 May 2023 05:32:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233230AbjEHJc1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 8 May 2023 05:32:27 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98EA819AC
        for <linux-wireless@vger.kernel.org>; Mon,  8 May 2023 02:32:24 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-69-brS-yiycNlis48Sqk4qp5Q-1; Mon, 08 May 2023 10:32:21 +0100
X-MC-Unique: brS-yiycNlis48Sqk4qp5Q-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 8 May
 2023 10:32:20 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Mon, 8 May 2023 10:32:20 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Ping-Ke Shih' <pkshih@realtek.com>,
        "kvalo@kernel.org" <kvalo@kernel.org>,
        "tony0620emma@gmail.com" <tony0620emma@gmail.com>
CC:     "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "dan.carpenter@linaro.org" <dan.carpenter@linaro.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH] wifi: rtw88: correct qsel_to_ep[] type as int
Thread-Topic: [PATCH] wifi: rtw88: correct qsel_to_ep[] type as int
Thread-Index: AQHZgYryZgLW+vSJekGO/5DhQRcjra9QGqGQ
Date:   Mon, 8 May 2023 09:32:20 +0000
Message-ID: <cae9e544d8ca49be8ae2344597d3d481@AcuMS.aculab.com>
References: <20230508085539.46795-1-pkshih@realtek.com>
In-Reply-To: <20230508085539.46795-1-pkshih@realtek.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,PDS_BAD_THREAD_QP_64,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ping-Ke Shih
> Sent: 08 May 2023 09:56
> 
> qsel_to_ep[] can be assigned negative value, so change type from 'u8' to
> 'int'. Otherwise, Smatch static checker warns:
>   drivers/net/wireless/realtek/rtw88/usb.c:219 rtw_usb_parse() warn:
>   assigning (-22) to unsigned variable 'rtwusb->qsel_to_ep[8]'

I think s8 would do.
Either that or an alternative error value.

	David

> 
> Cc: stable@vger.kernel.org
> Fixes: a6f187f92bcc ("wifi: rtw88: usb: fix priority queue to endpoint mapping")
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Link: https://lore.kernel.org/linux-wireless/c3f70197-829d-48ed-ae15-66a9de80fa90@kili.mountain/
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> ---
>  drivers/net/wireless/realtek/rtw88/usb.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/realtek/rtw88/usb.h b/drivers/net/wireless/realtek/rtw88/usb.h
> index 30647f0dd61c6..ad1d7955c6a51 100644
> --- a/drivers/net/wireless/realtek/rtw88/usb.h
> +++ b/drivers/net/wireless/realtek/rtw88/usb.h
> @@ -78,7 +78,7 @@ struct rtw_usb {
>  	u8 pipe_interrupt;
>  	u8 pipe_in;
>  	u8 out_ep[RTW_USB_EP_MAX];
> -	u8 qsel_to_ep[TX_DESC_QSEL_MAX];
> +	int qsel_to_ep[TX_DESC_QSEL_MAX];
>  	u8 usb_txagg_num;
> 
>  	struct workqueue_struct *txwq, *rxwq;
> --
> 2.25.1

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

