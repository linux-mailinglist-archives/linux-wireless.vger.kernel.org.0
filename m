Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69F5F7F5558
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Nov 2023 01:30:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbjKWAaw convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 22 Nov 2023 19:30:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjKWAaw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 22 Nov 2023 19:30:52 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 763C51AE
        for <linux-wireless@vger.kernel.org>; Wed, 22 Nov 2023 16:30:44 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3AN0UakcE2592744, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3AN0UakcE2592744
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Nov 2023 08:30:36 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Thu, 23 Nov 2023 08:30:36 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Thu, 23 Nov 2023 08:30:36 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7]) by
 RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7%5]) with mapi id
 15.01.2375.007; Thu, 23 Nov 2023 08:30:36 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Jay Sweat <jjsweat@outlook.com>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: Realtek 8822ce p2p support
Thread-Topic: Realtek 8822ce p2p support
Thread-Index: AQHaHJ6/35nL8BzLVE+iP+/w63/TCrCFjBhAgAEOZs2AAHCucA==
Date:   Thu, 23 Nov 2023 00:30:36 +0000
Message-ID: <5ffd01e6c8a1464795d612de1c6fa8a4@realtek.com>
References: <IA1PR20MB5049CDB1D4CBA0FD5B68F15DA8BBA@IA1PR20MB5049.namprd20.prod.outlook.com>
 <16c31bac7aaf4c20917f500d6d2a52c2@realtek.com>
 <IA1PR20MB50490BFFD9F797722C9688BAA8BAA@IA1PR20MB5049.namprd20.prod.outlook.com>
In-Reply-To: <IA1PR20MB50490BFFD9F797722C9688BAA8BAA@IA1PR20MB5049.namprd20.prod.outlook.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-originating-ip: [172.21.69.94]
x-kse-serverinfo: RTEXMBS02.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



> -----Original Message-----
> From: Jay Sweat <jjsweat@outlook.com>
> Sent: Thursday, November 23, 2023 1:32 AM
> To: Ping-Ke Shih <pkshih@realtek.com>
> Cc: linux-wireless@vger.kernel.org
> Subject: Re: Realtek 8822ce p2p support
> 
> I am interesting, but Im not sure how much help I can be. I only have a basic knowledge of linux and next
> to no development skills.

First step is to download Linux kernel source and build rtw88 driver or whole kernel.
Also, you need a user-space application called wpa_supplicant [1] to make P2P connection.

Declare P2P capability by below patch, and then see how it works and debug... 

diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index 4a33d2e47f33..ad988d6b204b 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -110,7 +110,9 @@ static const struct ieee80211_iface_limit rtw_iface_limits[] = {
        },
        {
                .max = 1,
-               .types = BIT(NL80211_IFTYPE_AP),
+               .types = BIT(NL80211_IFTYPE_AP) |
+                        BIT(NL80211_IFTYPE_P2P_CLIENT) |
+                        BIT(NL80211_IFTYPE_P2P_GO);
        }
 };

@@ -2232,7 +2234,9 @@ int rtw_register_hw(struct rtw_dev *rtwdev, struct ieee80211_hw *hw)
        hw->wiphy->interface_modes = BIT(NL80211_IFTYPE_STATION) |
                                     BIT(NL80211_IFTYPE_AP) |
                                     BIT(NL80211_IFTYPE_ADHOC) |
-                                    BIT(NL80211_IFTYPE_MESH_POINT);
+                                    BIT(NL80211_IFTYPE_MESH_POINT) |
+                                    BIT(NL80211_IFTYPE_P2P_CLIENT) |
+                                    BIT(NL80211_IFTYPE_P2P_GO);
        hw->wiphy->available_antennas_tx = hal->antenna_tx;
        hw->wiphy->available_antennas_rx = hal->antenna_rx;


[1] https://w1.fi/cvs.html


