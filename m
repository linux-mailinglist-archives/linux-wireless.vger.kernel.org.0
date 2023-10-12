Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A03F97C62A2
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Oct 2023 04:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232321AbjJLCR4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Oct 2023 22:17:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233929AbjJLCRz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Oct 2023 22:17:55 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74608F4
        for <linux-wireless@vger.kernel.org>; Wed, 11 Oct 2023 19:17:52 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 39C2HhzN6634962, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.92/5.92) with ESMTPS id 39C2HhzN6634962
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Oct 2023 10:17:44 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Thu, 12 Oct 2023 10:17:44 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Thu, 12 Oct 2023 10:17:43 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7]) by
 RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7%5]) with mapi id
 15.01.2375.007; Thu, 12 Oct 2023 10:17:43 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     "kvalo@kernel.org" <kvalo@kernel.org>
CC:     Kevin Yang <kevin_yang@realtek.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH 0/6] wifi: rtw89: generalize MAC registers to support WiFi 7 chips
Thread-Topic: [PATCH 0/6] wifi: rtw89: generalize MAC registers to support
 WiFi 7 chips
Thread-Index: AQHZ/K5hnoZBvIcEbUyk4Oq+P+ALV7BFapzA
Date:   Thu, 12 Oct 2023 02:17:43 +0000
Message-ID: <694fa5834aa04d3c98999ad169cc8d32@realtek.com>
References: <20231012014902.18523-1-pkshih@realtek.com>
In-Reply-To: <20231012014902.18523-1-pkshih@realtek.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-originating-ip: [172.21.69.25]
x-kse-serverinfo: RTEXMBS02.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



> -----Original Message-----
> From: Ping-Ke Shih <pkshih@realtek.com>
> Sent: Thursday, October 12, 2023 9:49 AM
> To: kvalo@kernel.org
> Cc: Kevin Yang <kevin_yang@realtek.com>; linux-wireless@vger.kernel.org
> Subject: [PATCH 0/6] wifi: rtw89: generalize MAC registers to support WiFi 7 chips
> 
> WiFi 7 registers of RTS, MU-EDCA and beamforming are different from
> existing chips, but we can still possibly reuse most of existing code.
> The initial beamformee code when associated is largely different, so make
> them as individual functions.
> 

Sorry. Please drop this v1 patchset because I correct commit message by v2.

Ping-Ke

