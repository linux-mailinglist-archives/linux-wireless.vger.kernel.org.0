Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C33DB7559C2
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jul 2023 04:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbjGQCuQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 16 Jul 2023 22:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbjGQCuP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 16 Jul 2023 22:50:15 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9A3D61AA
        for <linux-wireless@vger.kernel.org>; Sun, 16 Jul 2023 19:50:14 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 36H2nvdK7030180, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 36H2nvdK7030180
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Mon, 17 Jul 2023 10:49:57 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Mon, 17 Jul 2023 10:50:05 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Mon, 17 Jul 2023 10:50:04 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Mon, 17 Jul 2023 10:50:04 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Dmitry Antipov <dmantipov@yandex.ru>,
        Bernie Huang <phhuang@realtek.com>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Kalle Valo" <kvalo@kernel.org>
Subject: RE: [PATCH 4/4] [v6] wifi: rtw88: simplify vif iterators
Thread-Topic: [PATCH 4/4] [v6] wifi: rtw88: simplify vif iterators
Thread-Index: AQHZqZGJszPb2+CBRE2hmZofQSlwpK+9XsGQ
Date:   Mon, 17 Jul 2023 02:50:04 +0000
Message-ID: <e4a4dbcf8308470f9b85772db68669e8@realtek.com>
References: <20230628072327.167196-1-dmantipov@yandex.ru>
 <20230628072327.167196-4-dmantipov@yandex.ru>
In-Reply-To: <20230628072327.167196-4-dmantipov@yandex.ru>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXDAG02.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



> -----Original Message-----
> From: Dmitry Antipov <dmantipov@yandex.ru>
> Sent: Wednesday, June 28, 2023 3:23 PM
> To: Bernie Huang <phhuang@realtek.com>
> Cc: linux-wireless@vger.kernel.org; Ping-Ke Shih <pkshih@realtek.com>; Kalle Valo <kvalo@kernel.org>;
> Dmitry Antipov <dmantipov@yandex.ru>
> Subject: [PATCH 4/4] [v6] wifi: rtw88: simplify vif iterators
> 
> Since all iterators called by 'rtw_iterate_vifs()' never uses
> 'mac' argument, it may be omitted, and 'struct rtw_vifs_entry'
> may be simplified accordingly.
> 
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>

Initially we used iterators of mac80211 that contains 'mac' argument, but
driver didn't really use it. So remove them will be fine. 

Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>

[...]

