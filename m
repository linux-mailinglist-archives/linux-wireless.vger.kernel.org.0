Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F004F78E4C6
	for <lists+linux-wireless@lfdr.de>; Thu, 31 Aug 2023 04:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236892AbjHaClO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 30 Aug 2023 22:41:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232768AbjHaClN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 30 Aug 2023 22:41:13 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 46EC91BF
        for <linux-wireless@vger.kernel.org>; Wed, 30 Aug 2023 19:41:08 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 37V2eK2M1021782, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 37V2eK2M1021782
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 31 Aug 2023 10:40:20 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Thu, 31 Aug 2023 10:40:38 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 31 Aug 2023 10:40:37 +0800
Received: from RTEXDAG02.realtek.com.tw ([fe80::4487:9c61:3072:c8d4]) by
 RTEXDAG02.realtek.com.tw ([fe80::4487:9c61:3072:c8d4%5]) with mapi id
 15.01.2375.007; Thu, 31 Aug 2023 10:40:37 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     kernel test robot <lkp@intel.com>,
        "kvalo@kernel.org" <kvalo@kernel.org>
CC:     "oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>,
        "Kevin Yang" <kevin_yang@realtek.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH 1/6] wifi: rtw89: mcc: initialize start flow
Thread-Topic: [PATCH 1/6] wifi: rtw89: mcc: initialize start flow
Thread-Index: AQHZ2h+JnUG3RF/gi0SW0F+ZdLzKurACUGuAgAFkJHA=
Date:   Thu, 31 Aug 2023 02:40:37 +0000
Message-ID: <649b583bd1da41bd895cb84345485af9@realtek.com>
References: <20230829021918.14599-2-pkshih@realtek.com>
 <202308302155.2snig4j9-lkp@intel.com>
In-Reply-To: <202308302155.2snig4j9-lkp@intel.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.25]
x-kse-serverinfo: RTEXMBS06.realtek.com.tw, 9
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



> -----Original Message-----
> From: kernel test robot <lkp@intel.com>
> Sent: Wednesday, August 30, 2023 9:25 PM
> To: Ping-Ke Shih <pkshih@realtek.com>; kvalo@kernel.org
> Cc: oe-kbuild-all@lists.linux.dev; Kevin Yang <kevin_yang@realtek.com>; linux-wireless@vger.kernel.org
> Subject: Re: [PATCH 1/6] wifi: rtw89: mcc: initialize start flow
> 
> >> ERROR: modpost: "__umoddi3" [drivers/net/wireless/realtek/rtw89/rtw89_core.ko] undefined!

I will use div_u64_rem() instead, and send v2.

Ping-Ke

