Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED59A4B1A61
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Feb 2022 01:25:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346318AbiBKAZp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Feb 2022 19:25:45 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345707AbiBKAZo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Feb 2022 19:25:44 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 355125F6C
        for <linux-wireless@vger.kernel.org>; Thu, 10 Feb 2022 16:25:42 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 21B0PSPs8001800, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 21B0PSPs8001800
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 11 Feb 2022 08:25:28 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 11 Feb 2022 08:25:28 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 11 Feb 2022 08:25:27 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::35e4:d9d1:102d:605e]) by
 RTEXMBS04.realtek.com.tw ([fe80::35e4:d9d1:102d:605e%5]) with mapi id
 15.01.2308.020; Fri, 11 Feb 2022 08:25:27 +0800
From:   Pkshih <pkshih@realtek.com>
To:     Kalle Valo <kvalo@kernel.org>
CC:     "Larry.Finger@lwfinger.net" <Larry.Finger@lwfinger.net>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: Funny log entries for rtw88_8821ce
Thread-Topic: Funny log entries for rtw88_8821ce
Thread-Index: AQHYFvVq2DWVmxZS7E2VYxG/u8dgWqx9tPKAgAQJ/QCAB6gl/f//rFuAgAPTOxKAAKLmIA==
Date:   Fri, 11 Feb 2022 00:25:27 +0000
Message-ID: <ef1b6cf1c82c49faab84610ad960f72a@realtek.com>
References: <c356d5ae-a7b3-3065-1121-64c446e70333@lwfinger.net>
        <32f2ece8acdb67f74757cb705e5467847d6bcae0.camel@realtek.com>
        <ef7361eb-17ce-5ecf-a46a-a9f0c5aab35b@lwfinger.net>
        <87czjxbukz.fsf@tynnyri.adurom.net>
        <6baf4ae2f36c89269f74f0905ce81f38adc3a284.camel@realtek.com>
 <87mtiy3iha.fsf@kernel.org>
In-Reply-To: <87mtiy3iha.fsf@kernel.org>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXDAG02.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?us-ascii?Q?Clean,_bases:_2022/2/10_=3F=3F_10:33:00?=
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
> Sent: Thursday, February 10, 2022 10:27 PM
> To: Pkshih <pkshih@realtek.com>
> Cc: Larry.Finger@lwfinger.net; linux-wireless@vger.kernel.org
> Subject: Re: Funny log entries for rtw88_8821ce
> 
> Pkshih <pkshih@realtek.com> writes:
> 
> > Then, I have a question about the message of setting SAR:
> > 	rtw_info(rtwdev, "On freq %u to %u, set SAR %d in 1/%lu dBm\n"
> >
> > When a user sets SAR via iw, this message can reflect the action performed
> > by driver. Is this rtw_info acceptable?
> 
> In general the preference for user space commands is not to print
> anything to the log when debug messages are disabled, but of course
> there can be exceptions if the reasons are good. Why do you want to
> print this always? What benefit does it bring for the user?
> 

Understand. My original thinking still focus on debug purpose.

Because the SAR doesn't have a 'get' method to check status, and it affects
TX power but a user can't be aware that clearly. If someone told me his
laptop has low wifi performance, this message can be a good clue to address
the problem.

Fortunately, I still can use debugfs to debug this case, so I will change
this message to debug level.

--
Ping-Ke

