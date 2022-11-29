Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE50663B688
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Nov 2022 01:22:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234884AbiK2AWy convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Nov 2022 19:22:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234888AbiK2AWw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Nov 2022 19:22:52 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CFD8B11A0D
        for <linux-wireless@vger.kernel.org>; Mon, 28 Nov 2022 16:22:49 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 2AT0LuPwA017503, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 2AT0LuPwA017503
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 29 Nov 2022 08:21:56 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Tue, 29 Nov 2022 08:22:40 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 29 Nov 2022 08:22:40 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::15b5:fc4b:72f3:424b]) by
 RTEXMBS04.realtek.com.tw ([fe80::15b5:fc4b:72f3:424b%5]) with mapi id
 15.01.2375.007; Tue, 29 Nov 2022 08:22:40 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Kalle Valo <kvalo@kernel.org>
CC:     Kevin Yang <kevin_yang@realtek.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH 4/6] wifi: rtw89: mac: process MCC related C2H
Thread-Topic: [PATCH 4/6] wifi: rtw89: mac: process MCC related C2H
Thread-Index: AQHY+wxMFA5vmLa6FUaozuPdYh37Sq5UZScwgAC00yA=
Date:   Tue, 29 Nov 2022 00:22:40 +0000
Message-ID: <6444fb9949e14656b3ccf0adb6babb63@realtek.com>
References: <20221118051042.29968-1-pkshih@realtek.com>
        <20221118051042.29968-5-pkshih@realtek.com> <87o7sr5hq9.fsf@kernel.org>
In-Reply-To: <87o7sr5hq9.fsf@kernel.org>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS03.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?us-ascii?Q?Clean,_bases:_2022/11/28_=3F=3F_10:37:00?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



> -----Original Message-----
> From: Kalle Valo <kvalo@kernel.org>
> Sent: Monday, November 28, 2022 9:31 PM
> To: Ping-Ke Shih <pkshih@realtek.com>
> Cc: Kevin Yang <kevin_yang@realtek.com>; linux-wireless@vger.kernel.org
> Subject: Re: [PATCH 4/6] wifi: rtw89: mac: process MCC related C2H
> 
> Ping-Ke Shih <pkshih@realtek.com> writes:
> 
> > From: Zong-Zhe Yang <kevin_yang@realtek.com>
> >
> > Process C2H(s) related to MCC (multi-channel concurrency). These handling,
> > which either call rtw89_complete_cond() or show message in debug mode, can
> > be considered atomic/lock-free. So, they should be safe to be processed
> > directly after C2H pre-check in previous patch.
> >
> > Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
> > Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> 
> [...]
> 
> > +static
> > +void (* const rtw89_mac_c2h_mcc_handler[])(struct rtw89_dev *rtwdev,
> > +					   struct sk_buff *c2h, u32 len) = {
> > +	[RTW89_MAC_C2H_FUNC_MCC_RCV_ACK] = rtw89_mac_c2h_mcc_rcv_ack,
> > +	[RTW89_MAC_C2H_FUNC_MCC_REQ_ACK] = rtw89_mac_c2h_mcc_req_ack,
> > +	[RTW89_MAC_C2H_FUNC_MCC_TSF_RPT] = rtw89_mac_c2h_mcc_tsf_rpt,
> > +	[RTW89_MAC_C2H_FUNC_MCC_STATUS_RPT] = rtw89_mac_c2h_mcc_status_rpt,
> > +};
> 
> static const?
> 

These are function pointers, so const is before instance name, 
i.e. '... const rtw89_mac_c2h_mcc_handler ..'

Checking it with objdump, which shows '.rodata' also:

$ objdump -t mac.o | grep rtw89_mac_c2h_mcc_handler
00000000000000a0 l     O .rodata        0000000000000020 rtw89_mac_c2h_mcc_handler

--
Ping-Ke

