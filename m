Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAD964644AD
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Dec 2021 02:57:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345723AbhLACA3 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 30 Nov 2021 21:00:29 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:47859 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345669AbhLACA2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 30 Nov 2021 21:00:28 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 1B11v2H61026763, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36503.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 1B11v2H61026763
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 1 Dec 2021 09:57:02 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36503.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 1 Dec 2021 09:57:02 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 30 Nov 2021 17:57:02 -0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e095:6756:b2cf:3baa]) by
 RTEXMBS04.realtek.com.tw ([fe80::e095:6756:b2cf:3baa%5]) with mapi id
 15.01.2308.015; Wed, 1 Dec 2021 09:57:01 +0800
From:   Pkshih <pkshih@realtek.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [bug report] rtw89: add Realtek 802.11ax driver
Thread-Topic: [bug report] rtw89: add Realtek 802.11ax driver
Thread-Index: AQHX5dcF3lwC/wISd0+z1v2dREdN4awc38sw
Date:   Wed, 1 Dec 2021 01:57:01 +0000
Message-ID: <fc004575dc9e48a389f16af7b6c4fa7d@realtek.com>
References: <20211130104230.GE5827@kili>
In-Reply-To: <20211130104230.GE5827@kili>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS05.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?us-ascii?Q?Clean,_bases:_2021/11/30_=3F=3F_11:16:00?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-KSE-ServerInfo: RTEXH36503.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


> -----Original Message-----
> From: Dan Carpenter <dan.carpenter@oracle.com>
> Sent: Tuesday, November 30, 2021 6:43 PM
> To: Pkshih <pkshih@realtek.com>
> Cc: linux-wireless@vger.kernel.org
> Subject: [bug report] rtw89: add Realtek 802.11ax driver
> 
> Hello Ping-Ke Shih,
> 
> The patch e3ec7017f6a2: "rtw89: add Realtek 802.11ax driver" from Oct
> 11, 2021, leads to the following Smatch static checker warning:
> 
> 	drivers/net/wireless/realtek/rtw89/mac80211.c:31 rtw89_ops_tx()
> 	error: uninitialized symbol 'qsel'.
> 
> drivers/net/wireless/realtek/rtw89/mac80211.c
>     16 static void rtw89_ops_tx(struct ieee80211_hw *hw,
>     17                          struct ieee80211_tx_control *control,
>     18                          struct sk_buff *skb)
>     19 {
>     20         struct rtw89_dev *rtwdev = hw->priv;
>     21         struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
>     22         struct ieee80211_vif *vif = info->control.vif;
>     23         struct ieee80211_sta *sta = control->sta;
>     24         int ret, qsel;
>     25
>     26         ret = rtw89_core_tx_write(rtwdev, vif, sta, skb, &qsel);
>     27         if (ret) {
>     28                 rtw89_err(rtwdev, "failed to transmit skb: %d\n", ret);
>     29                 ieee80211_free_txskb(hw, skb);
> 
> Missing return; here?

Yes. Thanks for the finding.
I will send a patch to fix it.

--
Ping-Ke

