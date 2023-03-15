Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B401E6BAFEF
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Mar 2023 13:09:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbjCOMJk convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Mar 2023 08:09:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjCOMJj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Mar 2023 08:09:39 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1E9353DB3
        for <linux-wireless@vger.kernel.org>; Wed, 15 Mar 2023 05:09:35 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 32FC9F2v8030267, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 32FC9F2v8030267
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Wed, 15 Mar 2023 20:09:15 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Wed, 15 Mar 2023 20:09:27 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 15 Mar 2023 20:09:27 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::b4a2:2bcc:48d1:8b02]) by
 RTEXMBS04.realtek.com.tw ([fe80::b4a2:2bcc:48d1:8b02%5]) with mapi id
 15.01.2375.007; Wed, 15 Mar 2023 20:09:26 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Kalle Valo <kvalo@kernel.org>
CC:     Bernie Huang <phhuang@realtek.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH 2/5] wifi: rtw89: add function to wait for completion of TX skbs
Thread-Topic: [PATCH 2/5] wifi: rtw89: add function to wait for completion of
 TX skbs
Thread-Index: AQHZUwMd+NR5pgHPjU6+dSB+fp1fy677jXH9gAAE8zA=
Date:   Wed, 15 Mar 2023 12:09:26 +0000
Message-ID: <360e6dd64e3645c68742fc4c603b3c2b@realtek.com>
References: <20230310034631.45299-1-pkshih@realtek.com>
        <20230310034631.45299-3-pkshih@realtek.com> <87v8j2mmqt.fsf@kernel.org>
In-Reply-To: <87v8j2mmqt.fsf@kernel.org>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS03.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?us-ascii?Q?Clean,_bases:_2023/3/15_=3F=3F_11:02:00?=
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
> From: Kalle Valo <kvalo@kernel.org>
> Sent: Wednesday, March 15, 2023 4:40 PM
> To: Ping-Ke Shih <pkshih@realtek.com>
> Cc: Bernie Huang <phhuang@realtek.com>; linux-wireless@vger.kernel.org
> Subject: Re: [PATCH 2/5] wifi: rtw89: add function to wait for completion of TX skbs
> 
> Ping-Ke Shih <pkshih@realtek.com> writes:
> 
> > From: Po-Hao Huang <phhuang@realtek.com>
> >
> > Allocate a per-skb completion to track those skbs we are interested in
> > and wait for them to complete transmission with TX status. To avoid
> > race condition between process and softirq without addtional locking,
> > we use a work to free the tx_wait struct later when waiter is finished
> > referencing it. This must be called in process context and with a
> > timeout value greater than zero since it might sleep.
> >
> > We use another workqueue so works can be processed concurrently and
> > when the PCI device is removed unexpectedly, all pending works can be
> > flushed. This prevents some works that were scheduled but never processed
> > leads to memory leak.
> >
> > Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
> > Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> 
> [...]
> 
> > +static void rtw89_core_free_tx_wait_work(struct work_struct *work)
> > +{
> > +     struct rtw89_tx_wait_info *wait =
> > +                     container_of(work, struct rtw89_tx_wait_info, work);
> > +     struct rtw89_dev *rtwdev = wait->rtwdev;
> > +     int done, ret;
> > +
> > +     ret = read_poll_timeout(atomic_read, done, done, 1000, 100000, false,
> > +                             &wait->wait_done);
> > +
> > +     if (ret)
> > +             rtw89_err(rtwdev, "tx wait timed out, stop polling\n");
> > +     else
> > +             kfree(wait);
> > +}
> 
> I admit I didn't try to understand this patch in detail but this
> function just looks odd to me. Why there's polling able to free
> something?
> 

Three works are involved in the "wait/completion".

work 1. remain-on-channel work
   It trigger TX null data and wait (kmalloc 'wait' object, and wait for completion)

work 2. TX completion by napi_poll
   It returns TX status (failed or succeed to TX), and complete the 'wait' object,
   and queue rtw89_core_free_tx_wait_work() to free 'wait' object.

   We queue this by work 2, because time of work 1 is predictable, but
   it is hard to estimate time of work 2. The read_poll_timeout() is for
   the work 1 predictable time.

work 3. This work is to do garbage collection of 'wait' object
   It polls if work 1 is done before doing free 'wait' object.


Things are complex because work 1 and 2 are done asynchronously, so one
of them can't free 'wait' object, or it will causes use-after-free in other
side.

Use case 1: (work 1 could free 'wait' object)
    work 1         work 2          work 3
    wait
                   completion
    wait ok
                                   free 'wait'

Use case 2: (work 2 could free 'wait' object)
    work 1         work 2          work 3
    wait
    wait timeout
                   completion
                                   free 'wait'


I can add a comment as a hint why we can use a read_poll_timeout() to assist
in freeing something. 

Ping-Ke

