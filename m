Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7C146E55F5
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Apr 2023 02:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbjDRAhf convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 17 Apr 2023 20:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjDRAhe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 17 Apr 2023 20:37:34 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF0532718
        for <linux-wireless@vger.kernel.org>; Mon, 17 Apr 2023 17:37:32 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 33I0b9Qw9008620, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 33I0b9Qw9008620
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Tue, 18 Apr 2023 08:37:09 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Tue, 18 Apr 2023 08:37:09 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 18 Apr 2023 08:37:09 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Tue, 18 Apr 2023 08:37:03 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Sascha Hauer <s.hauer@pengutronix.de>,
        linux-wireless <linux-wireless@vger.kernel.org>
CC:     Hans Ulli Kroll <linux@ulli-kroll.de>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Tim K <tpkuester@gmail.com>, "Alex G ." <mr.nuke.me@gmail.com>,
        Nick Morrow <morrownr@gmail.com>,
        Viktor Petrenko <g0000ga@gmail.com>,
        Andreas Henriksson <andreas@fatal.se>,
        ValdikSS <iam@valdikss.org.ru>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: RE: [PATCH v3 4/4] wifi: rtw88: call rtw8821c_switch_rf_set() according to chip variant
Thread-Topic: [PATCH v3 4/4] wifi: rtw88: call rtw8821c_switch_rf_set()
 according to chip variant
Thread-Index: AQHZcTWi+jI4vOtbCUmy915TdE5ybK8wOUHA
Date:   Tue, 18 Apr 2023 00:37:03 +0000
Message-ID: <63392288710b4a83bb966be6c8507b03@realtek.com>
References: <20230417140358.2240429-1-s.hauer@pengutronix.de>
 <20230417140358.2240429-5-s.hauer@pengutronix.de>
In-Reply-To: <20230417140358.2240429-5-s.hauer@pengutronix.de>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS01.realtek.com.tw, 9
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
> From: Sascha Hauer <s.hauer@pengutronix.de>
> Sent: Monday, April 17, 2023 10:04 PM
> To: linux-wireless <linux-wireless@vger.kernel.org>
> Cc: Hans Ulli Kroll <linux@ulli-kroll.de>; Larry Finger <Larry.Finger@lwfinger.net>; Ping-Ke Shih
> <pkshih@realtek.com>; Tim K <tpkuester@gmail.com>; Alex G . <mr.nuke.me@gmail.com>; Nick Morrow
> <morrownr@gmail.com>; Viktor Petrenko <g0000ga@gmail.com>; Andreas Henriksson <andreas@fatal.se>;
> ValdikSS <iam@valdikss.org.ru>; kernel@pengutronix.de; Sascha Hauer <s.hauer@pengutronix.de>
> Subject: [PATCH v3 4/4] wifi: rtw88: call rtw8821c_switch_rf_set() according to chip variant
> 
> We have to call rtw8821c_switch_rf_set() with SWITCH_TO_WLG or
> SWITCH_TO_BTG according to the chip variant as denoted in rfe_option.
> The information which argument to use for which variant has been
> taken from the vendor driver.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>

[...]

