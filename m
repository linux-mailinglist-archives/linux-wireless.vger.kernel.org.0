Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFD6F225B15
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Jul 2020 11:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727908AbgGTJPc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Jul 2020 05:15:32 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:58012 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbgGTJPc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Jul 2020 05:15:32 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 06K9FJEa8013205, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 06K9FJEa8013205
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 20 Jul 2020 17:15:19 +0800
Received: from RTEXMB01.realtek.com.tw (172.21.6.94) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 20 Jul 2020 17:15:19 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 20 Jul 2020 17:15:19 +0800
Received: from RTEXMB04.realtek.com.tw ([fe80::941:6388:7d34:5c44]) by
 RTEXMB04.realtek.com.tw ([fe80::941:6388:7d34:5c44%3]) with mapi id
 15.01.1779.005; Mon, 20 Jul 2020 17:15:19 +0800
From:   Tony Chuang <yhchuang@realtek.com>
To:     Kalle Valo <kvalo@codeaurora.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Andy Huang" <tehuang@realtek.com>,
        "bigeasy@linutronix.de" <bigeasy@linutronix.de>
Subject: RE: [PATCH v2] rtw88: 8821c: coex: add functions and parameters
Thread-Topic: [PATCH v2] rtw88: 8821c: coex: add functions and parameters
Thread-Index: AQHWXjraTvh3jbCqrkKUH2C7bzlC1KkQLkeKgAABtmA=
Date:   Mon, 20 Jul 2020 09:15:19 +0000
Message-ID: <33152a8d95804ef5bb68579c8b40ebe3@realtek.com>
References: <20200720020924.2254-1-yhchuang@realtek.com>
 <87lfje7dv1.fsf@codeaurora.org>
In-Reply-To: <87lfje7dv1.fsf@codeaurora.org>
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
> > From: Ping-Cheng Chen <pc.chen@realtek.com>
> >
> > Without this patch, RTL8821CE will not have coex support,
> > and will crash the system because of the NULL pointers
> > for the coex functions.
> >
> > While RTL8822C series are WiFi + BT combo chips, it needs
> > the co-existence mechanism for the device to work on both
> > WiFi and BT without interfering each other. And the coex
> > support has already been added before, most of the mechanisms
> > are implemented. The driver should just add corresponding
> > functions to operate on different types of chips and its
> > coex parameters.
> >
> > Fixes: f745eb9ca5bf ("rtw88: 8821c: Add 8821CE to Kconfig and Makefile")
> > Signed-off-by: Ping-Cheng Chen <pc.chen@realtek.com>
> > Signed-off-by: Tzu-En Huang <tehuang@realtek.com>
> > Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
> 
> What changed from v1?
> 

Just the name of the author, nothing else :)

Yen-Hsuan
