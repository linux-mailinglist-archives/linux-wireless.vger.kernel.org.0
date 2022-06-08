Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E92B5542A0A
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Jun 2022 10:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233106AbiFHIzK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Jun 2022 04:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232823AbiFHIyZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Jun 2022 04:54:25 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 708183B172B
        for <linux-wireless@vger.kernel.org>; Wed,  8 Jun 2022 01:14:58 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 25885kkaE020259, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 25885kkaE020259
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 8 Jun 2022 16:05:46 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 8 Jun 2022 16:05:46 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 8 Jun 2022 16:05:46 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::34e7:ab63:3da4:27c6]) by
 RTEXMBS04.realtek.com.tw ([fe80::34e7:ab63:3da4:27c6%5]) with mapi id
 15.01.2308.021; Wed, 8 Jun 2022 16:05:46 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Kalle Valo <kvalo@kernel.org>
CC:     Larry Finger <Larry.Finger@lwfinger.net>,
        Nathan Chancellor <nathan@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH v3 4/4] rtw88: Fix Sparse warning for rtw8821c_hw_spec
Thread-Topic: [PATCH v3 4/4] rtw88: Fix Sparse warning for rtw8821c_hw_spec
Thread-Index: AQHYb4QquNlgqX2VSESbLHcGkKULkq1D3fwAgAAnIgCAALd/MP//hVkAgACHK4CAAG9Eq4AAAM7w
Date:   Wed, 8 Jun 2022 08:05:46 +0000
Message-ID: <5c48cda63e844e3f9703506309854a63@realtek.com>
References: <20220524153716.20450-1-Larry.Finger@lwfinger.net>
        <Yp+hfo5Uual8ZUkR@dev-arch.thelio-3990X>
        <e28ce50b-c1e6-74ae-6f57-5f864ba0c93a@lwfinger.net>
        <45a6b6ea84c74ffeafff1b68c2e1c5e3@realtek.com>
        <aad47f4f-a5bc-e8e2-15d3-2baf2512b661@lwfinger.net>
        <764fc8f115dc411e82938311273d9b51@realtek.com> <87bkv3r43b.fsf@kernel.org>
In-Reply-To: <87bkv3r43b.fsf@kernel.org>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXDAG02.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?us-ascii?Q?Clean,_bases:_2022/6/8_=3F=3F_06:01:00?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="us-ascii"
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
> From: Kalle Valo <kvalo@kernel.org>
> Sent: Wednesday, June 8, 2022 3:45 PM
> To: Ping-Ke Shih <pkshih@realtek.com>
> Cc: Larry Finger <Larry.Finger@lwfinger.net>; Nathan Chancellor <nathan@kernel.org>; Johannes Berg
> <johannes@sipsolutions.net>; linux-wireless@vger.kernel.org
> Subject: Re: [PATCH v3 4/4] rtw88: Fix Sparse warning for rtw8821c_hw_spec
> 
> Ping-Ke Shih <pkshih@realtek.com> writes:
> 
> >
> > The ch_param[3] is only used by 8821c, so it doesn't affect other devices.
> > I will prepare a patch to fix it.
> 
> But why didn't the compiler catch this? Is there some evil cast
> somewhere which removes the const? We should fix that as well (in a
> separate patch).
> 

This is because we assign a const to .driver_data that is non-const kernel_ulong_t:

static const struct pci_device_id rtw_8821ce_id_table[] = {
	{
		.driver_data = (kernel_ulong_t)&rtw8821c_hw_spec
	},

When casting it back in pci_probe(), we need to add 'const' after Larry's patches:

rtwdev->chip = (struct rtw_chip_info *)id->driver_data;


I will prepare another patch to fix that.

Ping-Ke

