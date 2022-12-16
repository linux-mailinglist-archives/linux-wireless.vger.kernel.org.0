Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B46C64E6E5
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Dec 2022 06:26:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbiLPF0G convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 16 Dec 2022 00:26:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiLPF0F (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 16 Dec 2022 00:26:05 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C05142A735
        for <linux-wireless@vger.kernel.org>; Thu, 15 Dec 2022 21:25:59 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 2BG5Oxd26020898, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 2BG5Oxd26020898
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 16 Dec 2022 13:24:59 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.9; Fri, 16 Dec 2022 13:25:49 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 16 Dec 2022 13:25:49 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::15b5:fc4b:72f3:424b]) by
 RTEXMBS04.realtek.com.tw ([fe80::15b5:fc4b:72f3:424b%5]) with mapi id
 15.01.2375.007; Fri, 16 Dec 2022 13:25:49 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>,
        "kvalo@kernel.org" <kvalo@kernel.org>
CC:     Gary Chang <gary.chang@realtek.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH] wifi: rtw89: 8852c: rfk: correct DPK settings
Thread-Topic: [PATCH] wifi: rtw89: 8852c: rfk: correct DPK settings
Thread-Index: AQHZEQiwUVG9ybj2LEK4COTTeaCQN65v+0KA
Date:   Fri, 16 Dec 2022 05:25:49 +0000
Message-ID: <de0bd2ff079a48fca4a2f5e235f1443e@realtek.com>
References: <20221216043927.9547-1-pkshih@realtek.com>
In-Reply-To: <20221216043927.9547-1-pkshih@realtek.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS04.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?us-ascii?Q?Clean,_bases:_2022/12/16_=3F=3F_01:29:00?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



> -----Original Message-----
> From: Ping-Ke Shih <pkshih@realtek.com>
> Sent: Friday, December 16, 2022 12:39 PM
> To: kvalo@kernel.org
> Cc: Gary Chang <gary.chang@realtek.com>; linux-wireless@vger.kernel.org
> Subject: [PATCH] wifi: rtw89: 8852c: rfk: correct DPK settings

Since this title is the same as previous patch, please drop this patch, and
I'll send v2 to change the title.

Sorry for the inconvenience. 

Ping-Ke

