Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6C5872F585
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Jun 2023 09:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233912AbjFNHIs convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 14 Jun 2023 03:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231878AbjFNHIr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 14 Jun 2023 03:08:47 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B43B898
        for <linux-wireless@vger.kernel.org>; Wed, 14 Jun 2023 00:08:44 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 35E78JxbC031036, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 35E78JxbC031036
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Wed, 14 Jun 2023 15:08:19 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Wed, 14 Jun 2023 15:08:37 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 14 Jun 2023 15:08:37 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Wed, 14 Jun 2023 15:08:37 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Dmitry Antipov <dmantipov@yandex.ru>, Kalle Valo <kvalo@kernel.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH 2/2] [v3] wifi: rtlwifi: cleanup USB interface
Thread-Topic: [PATCH 2/2] [v3] wifi: rtlwifi: cleanup USB interface
Thread-Index: AQHZnogXZB0GuhP6tkmC1M576RydPq+J4Lmw
Date:   Wed, 14 Jun 2023 07:08:37 +0000
Message-ID: <dcf1857e8fe9484dac9d269ae5384971@realtek.com>
References: <e030e496-b667-b1de-492b-8b0cc04ffe14@yandex.ru>
 <20230614061832.40882-1-dmantipov@yandex.ru>
 <20230614061832.40882-2-dmantipov@yandex.ru>
In-Reply-To: <20230614061832.40882-2-dmantipov@yandex.ru>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS02.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



> -----Original Message-----
> From: Dmitry Antipov <dmantipov@yandex.ru>
> Sent: Wednesday, June 14, 2023 2:19 PM
> To: Kalle Valo <kvalo@kernel.org>
> Cc: Ping-Ke Shih <pkshih@realtek.com>; linux-wireless@vger.kernel.org; Dmitry Antipov
> <dmantipov@yandex.ru>
> Subject: [PATCH 2/2] [v3] wifi: rtlwifi: cleanup USB interface
> 
> Drop unused '_usb_writen_sync()' and relevant pointer
> from 'struct rtl_io', handle possible write error in
> '_usb_write_async()', adjust related code.
> 
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>

Acked-by: Ping-Ke Shih <pkshih@realtek.com>

> ---
> v3: readjust to new series and keep pr_{info,err}() things (Kalle Valo)

I think this patch doesn't change pr_{info,err}, right ?


