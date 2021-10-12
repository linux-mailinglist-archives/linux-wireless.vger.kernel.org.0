Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92E9B42A011
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Oct 2021 10:40:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234686AbhJLImF convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 12 Oct 2021 04:42:05 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:53203 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235122AbhJLImC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 12 Oct 2021 04:42:02 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 19C8dkZcB022566, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36503.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 19C8dkZcB022566
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 12 Oct 2021 16:39:46 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36503.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 12 Oct 2021 16:39:45 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 12 Oct 2021 16:39:45 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::cdd5:82a3:e854:7098]) by
 RTEXMBS04.realtek.com.tw ([fe80::cdd5:82a3:e854:7098%5]) with mapi id
 15.01.2106.013; Tue, 12 Oct 2021 16:39:45 +0800
From:   Pkshih <pkshih@realtek.com>
To:     =?iso-8859-1?Q?Toke_H=F8iland-J=F8rgensen?= <toke@redhat.com>,
        "kvalo@codeaurora.org" <kvalo@codeaurora.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH v7 08/24] rtw89: implement mac80211 ops
Thread-Topic: [PATCH v7 08/24] rtw89: implement mac80211 ops
Thread-Index: AQHXu/ifWPBlJj1udUquHUeAEk0B/qvI2nEAgAXGKOA=
Date:   Tue, 12 Oct 2021 08:39:45 +0000
Message-ID: <2301ebcf91804e6199e87a36a39c4deb@realtek.com>
References: <20211008035627.19463-1-pkshih@realtek.com>
 <20211008035627.19463-9-pkshih@realtek.com> <87h7drl8b9.fsf@toke.dk>
In-Reply-To: <87h7drl8b9.fsf@toke.dk>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS02.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?iso-8859-1?Q?Clean,_bases:_2021/10/12_=3F=3F_06:00:00?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-KSE-ServerInfo: RTEXH36503.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-AntiSpam-Outbound-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 10/12/2021 08:20:00
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 166655 [Oct 12 2021]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: pkshih@realtek.com
X-KSE-AntiSpam-Info: LuaCore: 463 463 5854868460de3f0d8e8c0a4df98aeb05fb764a09
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: realtek.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 10/12/2021 08:22:00
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


> -----Original Message-----
> From: Toke Høiland-Jørgensen <toke@redhat.com>
> Sent: Saturday, October 9, 2021 1:45 AM
> To: Pkshih <pkshih@realtek.com>; kvalo@codeaurora.org
> Cc: linux-wireless@vger.kernel.org
> Subject: Re: [PATCH v7 08/24] rtw89: implement mac80211 ops
> 
> Ping-Ke Shih <pkshih@realtek.com> writes:
> 
> > To yield better TX performance, wake TX queue is implemented.
> 
> I went looking for this, and was happy to find it! :)
> 
> Do you also support airtime reporting and/or AQL? And if not, any plans
> to do so?

Not yet. But, I can estimate the cost to make a plan.

Could I know the requirements of hardware? For now, this driver
only reports simple information like TX/RX rate, RSSI and etc. Is it
enough?

It seems like AQL configures weights of stations. Could I know how
to verify this function?


> 
> One small nit below:
> 
> > +static void rtw89_ops_wake_tx_queue(struct ieee80211_hw *hw,
> > +				    struct ieee80211_txq *txq)
> > +{
> > +	struct rtw89_dev *rtwdev = hw->priv;
> > +
> > +	ieee80211_schedule_txq(hw, txq);
> > +	queue_work(rtwdev->txq_wq, &rtwdev->txq_work);
> 
> Why the call to ieee80211_schedule_txq()? mac80211 calls that before
> calling wake_tx_queue() (through the schedule_and_wake_txq() helper), so
> it seems a bit superfluous here?
> 

You are right. I will remove it after v7 get merged.

--
Ping-Ke

