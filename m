Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD26472F2D7
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Jun 2023 04:54:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233196AbjFNCyK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 13 Jun 2023 22:54:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231720AbjFNCyJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 13 Jun 2023 22:54:09 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A18DEA
        for <linux-wireless@vger.kernel.org>; Tue, 13 Jun 2023 19:54:08 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 35E2rhcwF021142, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 35E2rhcwF021142
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Wed, 14 Jun 2023 10:53:43 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Wed, 14 Jun 2023 10:54:01 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 14 Jun 2023 10:54:01 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Wed, 14 Jun 2023 10:54:01 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Dmitry Antipov <dmantipov@yandex.ru>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Kalle Valo" <kvalo@kernel.org>
Subject: RE: [PATCH 2/3] [v4] wifi: rtw89: cleanup rtw89_iqk_info and related code
Thread-Topic: [PATCH 2/3] [v4] wifi: rtw89: cleanup rtw89_iqk_info and related
 code
Thread-Index: AQHZnd4jKKMQs6HoQUWpxM8BnHfKUq+JmuHg
Date:   Wed, 14 Jun 2023 02:54:01 +0000
Message-ID: <7ecd7081e8244cfbb64c05e365d7fe0e@realtek.com>
References: <975dee84-fa8f-1dbd-a2b8-2aba5a880b60@yandex.ru>
 <20230613100154.116586-1-dmantipov@yandex.ru>
 <20230613100154.116586-2-dmantipov@yandex.ru>
In-Reply-To: <20230613100154.116586-2-dmantipov@yandex.ru>
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
> Sent: Tuesday, June 13, 2023 6:02 PM
> To: Ping-Ke Shih <pkshih@realtek.com>
> Cc: linux-wireless@vger.kernel.org; Kalle Valo <kvalo@kernel.org>; Dmitry Antipov <dmantipov@yandex.ru>
> Subject: [PATCH 2/3] [v4] wifi: rtw89: cleanup rtw89_iqk_info and related code
> 
> Drop useless '_iqk_track()' and 'rtw8852a_iqk_track()' (they
> just change 'thermal_rek_en' field which is set but unused
> and so removed as well) functions, set but unused 'kcount'
> field of 'struct rtw89_iqk_info', convert 'thermal' to local
> variables where appropriate (it doesn't need to have longer
> storage duration because it is actually used for debugging
> purposes only), fix typos.

Since you send v4 to fix compiler error of 8851b, I think you can move
all typos into patch 3/3. 


