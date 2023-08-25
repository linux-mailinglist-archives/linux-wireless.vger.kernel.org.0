Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EFDC787D4A
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Aug 2023 03:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238620AbjHYBkK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 24 Aug 2023 21:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240350AbjHYBjz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 24 Aug 2023 21:39:55 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EA7C51FD5
        for <linux-wireless@vger.kernel.org>; Thu, 24 Aug 2023 18:39:23 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 37P1FYYV0020678, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 37P1FYYV0020678
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 25 Aug 2023 09:15:34 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Fri, 25 Aug 2023 09:15:57 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 25 Aug 2023 09:15:57 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Fri, 25 Aug 2023 09:15:57 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Jinjie Ruan <ruanjinjie@huawei.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Kalle Valo <kvalo@kernel.org>
Subject: RE: [PATCH] rtlwifi: rtl8723: Remove unused function rtl8723_cmd_send_packet()
Thread-Topic: [PATCH] rtlwifi: rtl8723: Remove unused function
 rtl8723_cmd_send_packet()
Thread-Index: AQHZ1lOWkAjsez9OlkeRjFbEIjyFWK/6NmIA
Date:   Fri, 25 Aug 2023 01:15:57 +0000
Message-ID: <725d733226e642a88b7745b1e7f96542@realtek.com>
References: <20230824062339.1885385-1-ruanjinjie@huawei.com>
In-Reply-To: <20230824062339.1885385-1-ruanjinjie@huawei.com>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



> -----Original Message-----
> From: Jinjie Ruan <ruanjinjie@huawei.com>
> Sent: Thursday, August 24, 2023 2:24 PM
> To: linux-wireless@vger.kernel.org; Ping-Ke Shih <pkshih@realtek.com>; Kalle Valo <kvalo@kernel.org>
> Cc: ruanjinjie@huawei.com
> Subject: [PATCH] rtlwifi: rtl8723: Remove unused function rtl8723_cmd_send_packet()

Subject should be "wifi: ...."

> 
> The function rtl8723_cmd_send_packet() is not used anywhere, so remove it.
> 
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Others look good to me. 

Acked-by: Ping-Ke Shih <pkshih@realtek.com>


