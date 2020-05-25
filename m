Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07B081E04A6
	for <lists+linux-wireless@lfdr.de>; Mon, 25 May 2020 04:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388375AbgEYCVA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 24 May 2020 22:21:00 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:59798 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388151AbgEYCVA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 24 May 2020 22:21:00 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 04P2KoUwA000792, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 04P2KoUwA000792
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 25 May 2020 10:20:50 +0800
Received: from RTEXMB01.realtek.com.tw (172.21.6.94) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 25 May 2020 10:20:49 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 25 May 2020 10:20:49 +0800
Received: from RTEXMB04.realtek.com.tw ([fe80::8001:f5f5:a41e:f8d4]) by
 RTEXMB04.realtek.com.tw ([fe80::8001:f5f5:a41e:f8d4%3]) with mapi id
 15.01.1779.005; Mon, 25 May 2020 10:20:49 +0800
From:   Tony Chuang <yhchuang@realtek.com>
To:     Kalle Valo <kvalo@codeaurora.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "kevlo@kevlo.org" <kevlo@kevlo.org>
Subject: RE: [PATCH] Revert "rtw88: no need to set registers for SDIO"
Thread-Topic: [PATCH] Revert "rtw88: no need to set registers for SDIO"
Thread-Index: AQHWLmsSvo/G/WdZGka1GdX2HzARfaiz6otjgAQuoEA=
Date:   Mon, 25 May 2020 02:20:49 +0000
Message-ID: <ffeca6916c00438482e15ab3a8bb2795@realtek.com>
References: <20200520055350.23328-1-yhchuang@realtek.com>
 <871rncb6xu.fsf@codeaurora.org>
In-Reply-To: <871rncb6xu.fsf@codeaurora.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.68.175]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


> <yhchuang@realtek.com> writes:
> 
> > From: Yan-Hsuan Chuang <yhchuang@realtek.com>
> >
> > This reverts commit 07d0f5534935e2daf63a4e1012af13d68e089fed.
> >
> > For rtw88 driver, the SDIO is going to be supported, so there is
> > no need to remove the SDIO related power sequence settings. And
> > while the power sequence parser will pass in the mask of the HCI,
> > the SDIO part will not be used to set registers accordingly.
> >
> > Moreover, the power sequence table is released as a whole package,
> > so the next time if we are going to update, the SDIO settings will
> > be overwritten. So, revert this now.
> >
> > Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
> 
> Oops, I was supposed to drop that patch but somehow I did apply it
> anyway. Sorry about that, I'll apply this revert.
> 

It's fine :). Thanks.

Yan-Hsuan

