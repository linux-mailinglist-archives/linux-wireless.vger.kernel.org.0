Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 094B5534748
	for <lists+linux-wireless@lfdr.de>; Thu, 26 May 2022 02:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346633AbiEZAER convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 25 May 2022 20:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346603AbiEZAEP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 25 May 2022 20:04:15 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3312A4249A
        for <linux-wireless@vger.kernel.org>; Wed, 25 May 2022 17:04:10 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 24Q03rzfE011143, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 24Q03rzfE011143
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 26 May 2022 08:03:53 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 26 May 2022 08:03:52 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 26 May 2022 08:03:52 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::34e7:ab63:3da4:27c6]) by
 RTEXMBS04.realtek.com.tw ([fe80::34e7:ab63:3da4:27c6%5]) with mapi id
 15.01.2308.021; Thu, 26 May 2022 08:03:52 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     =?iso-8859-2?Q?Ond=F8ej_Jirman?= <megi@xff.cz>
CC:     "tony0620emma@gmail.com" <tony0620emma@gmail.com>,
        "kvalo@kernel.org" <kvalo@kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Bernie Huang <phhuang@realtek.com>
Subject: RE: [PATCH 3/6] rtw88: Add update beacon flow for AP mode
Thread-Topic: [PATCH 3/6] rtw88: Add update beacon flow for AP mode
Thread-Index: AQHYSmYzKfcDpBas3E6lf9szC4Rq2K0v+8qAgACXDOA=
Date:   Thu, 26 May 2022 00:03:52 +0000
Message-ID: <e10c2c9b0c15479594703f2d03b0fa03@realtek.com>
References: <20220407095858.46807-1-pkshih@realtek.com>
 <20220407095858.46807-4-pkshih@realtek.com>
 <20220525230121.zk6xdjycxdhe62nw@core>
In-Reply-To: <20220525230121.zk6xdjycxdhe62nw@core>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS06.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?iso-8859-2?Q?Clean,_bases:_2022/5/25_=3F=3F_10:00:00?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-KSE-ServerInfo: RTEXH36504.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


> -----Original Message-----
> From: Ondøej Jirman <megi@xff.cz>
> Sent: Thursday, May 26, 2022 7:01 AM
> To: Ping-Ke Shih <pkshih@realtek.com>
> Cc: tony0620emma@gmail.com; kvalo@kernel.org; linux-wireless@vger.kernel.org; Bernie Huang
> <phhuang@realtek.com>
> Subject: Re: [PATCH 3/6] rtw88: Add update beacon flow for AP mode
> 
> Hello Ping-Ke,
> 
> please see bugreport below:
> 
> >
> > +static int rtw_ops_set_tim(struct ieee80211_hw *hw, struct ieee80211_sta *sta,
> > +			   bool set)
> > +{
> > +	struct rtw_dev *rtwdev = hw->priv;
> > +
> > +	mutex_lock(&rtwdev->mutex);
> > +	rtw_fw_download_rsvd_page(rtwdev);
> > +	mutex_unlock(&rtwdev->mutex);
> 
> set_tim is supposed to be atomic. See:
> https://elixir.bootlin.com/linux/latest/source/include/net/mac80211.h#L3500
> 

Thanks for pointing out.
We will fix it.

Ping-Ke

