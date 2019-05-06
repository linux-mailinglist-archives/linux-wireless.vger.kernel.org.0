Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2D43146D7
	for <lists+linux-wireless@lfdr.de>; Mon,  6 May 2019 10:54:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725883AbfEFIyU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 6 May 2019 04:54:20 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:33553 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbfEFIyU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 6 May 2019 04:54:20 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x468sFNW015495, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtitcasv02.realtek.com.tw[172.21.6.19])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x468sFNW015495
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 6 May 2019 16:54:15 +0800
Received: from RTITMBSVM04.realtek.com.tw ([fe80::e404:880:2ef1:1aa1]) by
 RTITCASV02.realtek.com.tw ([::1]) with mapi id 14.03.0439.000; Mon, 6 May
 2019 16:54:15 +0800
From:   Tony Chuang <yhchuang@realtek.com>
To:     Kalle Valo <kvalo@codeaurora.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH v2 4/5] rtw88: fix unassigned rssi_level in rtw_sta_info
Thread-Topic: [PATCH v2 4/5] rtw88: fix unassigned rssi_level in rtw_sta_info
Thread-Index: AQHVA+iBo/F2XY+WoE6Fo27GU6PknqZdyWDQ
Date:   Mon, 6 May 2019 08:54:14 +0000
Message-ID: <F7CD281DE3E379468C6D07993EA72F84D17EB4C9@RTITMBSVM04.realtek.com.tw>
References: <1556884415-23474-1-git-send-email-yhchuang@realtek.com>
        <1556884415-23474-5-git-send-email-yhchuang@realtek.com>
 <874l68vuhi.fsf@purkki.adurom.net>
In-Reply-To: <874l68vuhi.fsf@purkki.adurom.net>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.68.183]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



> -----Original Message-----
> From: Kalle Valo [mailto:kvalo@codeaurora.org]
> Sent: Monday, May 06, 2019 4:49 PM
> To: Tony Chuang
> Cc: linux-wireless@vger.kernel.org
> Subject: Re: [PATCH v2 4/5] rtw88: fix unassigned rssi_level in rtw_sta_info
> 
> <yhchuang@realtek.com> writes:
> 
> > From: Yan-Hsuan Chuang <yhchuang@realtek.com>
> >
> > The new rssi_level should be stored in si, otherwise the rssi_level will
> > never be updated and get a wrong RA mask, which is calculated by the
> > rssi level
> >
> > Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
> 
> Stanislaw suggested that this should go to 5.2. So what breaks from
> user's point of view if this is not applied?
> 

If the rssi level remains unchanged, then we could choose wrong ra_mask.
And some *bad rates* we be chosen by firmware.
The most hurtful scene would be *noisy environment* such as office, or public.
The latency would be high and overall throughput would be only half.
(This was tested, such as 4x Mbps -> 1x Mbps)

Yan-Hsuan
