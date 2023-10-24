Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2EFE7D452B
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Oct 2023 03:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231846AbjJXB4C convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Oct 2023 21:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbjJXB4B (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Oct 2023 21:56:01 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED132A6
        for <linux-wireless@vger.kernel.org>; Mon, 23 Oct 2023 18:55:57 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 39O1thoK73876040, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.93/5.92) with ESMTPS id 39O1thoK73876040
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Oct 2023 09:55:43 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Tue, 24 Oct 2023 09:55:42 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 24 Oct 2023 09:55:41 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7]) by
 RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7%5]) with mapi id
 15.01.2375.007; Tue, 24 Oct 2023 09:55:41 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Dmitry Antipov <dmantipov@yandex.ru>
CC:     Kalle Valo <kvalo@kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH 1/3] [v2] wifi: rtlwifi: cleanup struct rtl_hal
Thread-Topic: [PATCH 1/3] [v2] wifi: rtlwifi: cleanup struct rtl_hal
Thread-Index: AQHaBZHkagQPeOdV0U+hnwQby5dxErBYLyjw
Date:   Tue, 24 Oct 2023 01:55:41 +0000
Message-ID: <b5b39e670e56433bb91d4aa8573efa96@realtek.com>
References: <5b9ea29daaaa4ebb8bc75cd384aaee80@realtek.com>
 <20231023091722.52509-1-dmantipov@yandex.ru>
In-Reply-To: <20231023091722.52509-1-dmantipov@yandex.ru>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-originating-ip: [172.21.71.113]
x-kse-serverinfo: RTEXMBS03.realtek.com.tw, 9
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
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



> -----Original Message-----
> From: Dmitry Antipov <dmantipov@yandex.ru>
> Sent: Monday, October 23, 2023 5:17 PM
> To: Ping-Ke Shih <pkshih@realtek.com>
> Cc: Kalle Valo <kvalo@kernel.org>; linux-wireless@vger.kernel.org; Dmitry Antipov <dmantipov@yandex.ru>
> Subject: [PATCH 1/3] [v2] wifi: rtlwifi: cleanup struct rtl_hal
> 
> Remove unused and set but otherwise unused 'bbrf_ready', 'external_pa',
> 'pa_mode', 'rx_tag', 'rts_en', 'wow_enable' and 'wow_enabled' fields
> of 'struct rtl_hal', adjust related code. Compile tested only.
> 
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>

Acked-by: Ping-Ke Shih <pkshih@realtek.com>

