Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 678DA2AFEBB
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Nov 2020 06:40:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbgKLFij convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 12 Nov 2020 00:38:39 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:58645 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727654AbgKLCZs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Nov 2020 21:25:48 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 0AC2PgD72009430, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb03.realtek.com.tw[172.21.6.96])
        by rtits2.realtek.com.tw (8.15.2/2.70/5.88) with ESMTPS id 0AC2PgD72009430
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 12 Nov 2020 10:25:42 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2044.4; Thu, 12 Nov 2020 10:25:41 +0800
Received: from RTEXMB04.realtek.com.tw ([fe80::89f7:e6c3:b043:15fa]) by
 RTEXMB04.realtek.com.tw ([fe80::89f7:e6c3:b043:15fa%3]) with mapi id
 15.01.2044.006; Thu, 12 Nov 2020 10:25:41 +0800
From:   Pkshih <pkshih@realtek.com>
To:     Kalle Valo <kvalo@codeaurora.org>
CC:     "tony0620emma@gmail.com" <tony0620emma@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH 02/11] rtw88: coex: remove unnecessary feature/function
Thread-Topic: [PATCH 02/11] rtw88: coex: remove unnecessary feature/function
Thread-Index: AQHWt9F/dvsfS7sP9UWmXSCxK8NofanCm7J5gAEqu1A=
Date:   Thu, 12 Nov 2020 02:25:41 +0000
Message-ID: <d5daf99862c0411ca21f2b236985c9f8@realtek.com>
References: <20201111022108.9834-1-pkshih@realtek.com>
        <20201111022108.9834-3-pkshih@realtek.com>
 <871rh0cmu9.fsf@codeaurora.org>
In-Reply-To: <871rh0cmu9.fsf@codeaurora.org>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.213]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



> -----Original Message-----
> From: kvalo=codeaurora.org@mg.codeaurora.org [mailto:kvalo=codeaurora.org@mg.codeaurora.org] On
> Behalf Of Kalle Valo
> Sent: Wednesday, November 11, 2020 4:36 PM
> To: Pkshih
> Cc: tony0620emma@gmail.com; linux-wireless@vger.kernel.org
> Subject: Re: [PATCH 02/11] rtw88: coex: remove unnecessary feature/function
> 
> <pkshih@realtek.com> writes:
> 
> > From: Ching-Te Ku <ku920601@realtek.com>
> >
> > It is redundant to update WLAN RSSI, remove the update WLAN RSSI part.
> > Remove unused function.
> 
> Why is it redundant? The "Why?" is the most important part of the commit
> log.
> 

Will describe "why' in v2. Thanks.

---
Ping-Ke




