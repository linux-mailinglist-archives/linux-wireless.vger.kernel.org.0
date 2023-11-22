Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D17F7F3B4D
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Nov 2023 02:29:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235039AbjKVB3V convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 21 Nov 2023 20:29:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234922AbjKVB3U (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 21 Nov 2023 20:29:20 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 513EBBB
        for <linux-wireless@vger.kernel.org>; Tue, 21 Nov 2023 17:29:16 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3AM1TAXP01912306, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3AM1TAXP01912306
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Nov 2023 09:29:10 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Wed, 22 Nov 2023 09:29:10 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Wed, 22 Nov 2023 09:29:09 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7]) by
 RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7%5]) with mapi id
 15.01.2375.007; Wed, 22 Nov 2023 09:29:09 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Jay Sweat <jjsweat@outlook.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: Realtek 8822ce p2p support
Thread-Topic: Realtek 8822ce p2p support
Thread-Index: AQHaHJ6/35nL8BzLVE+iP+/w63/TCrCFjBhA
Date:   Wed, 22 Nov 2023 01:29:09 +0000
Message-ID: <16c31bac7aaf4c20917f500d6d2a52c2@realtek.com>
References: <IA1PR20MB5049CDB1D4CBA0FD5B68F15DA8BBA@IA1PR20MB5049.namprd20.prod.outlook.com>
In-Reply-To: <IA1PR20MB5049CDB1D4CBA0FD5B68F15DA8BBA@IA1PR20MB5049.namprd20.prod.outlook.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-originating-ip: [172.21.69.94]
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



> -----Original Message-----
> From: Jay Sweat <jjsweat@outlook.com>
> Sent: Wednesday, November 22, 2023 1:18 AM
> To: linux-wireless@vger.kernel.org
> Subject: Realtek 8822ce p2p support
> 
> Hello,
> I am trying to enable miracast via gnome network displays, which requires p2p, on my arch linux device with
> a soldered realtek 8822ce adapter. As far as I can tell, then hardware supports p2p ( linux says so and
> miracast works in windows) but it is not enabled and/or implemented in the driver. I was just wondering
> if this was a feature that would be added or if I am just wasting my time.

8822ce can play as STA or AP role, so it is possible to support P2P basically. 
Are you interested in this work?

Ping-Ke 

