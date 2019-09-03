Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 287A1A67DE
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2019 13:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728970AbfICL4N convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 3 Sep 2019 07:56:13 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:48655 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728094AbfICL4M (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 3 Sep 2019 07:56:12 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x83Btwk8003289, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCASV01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x83Btwk8003289
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 3 Sep 2019 19:55:58 +0800
Received: from RTITMBSVM04.realtek.com.tw ([fe80::e404:880:2ef1:1aa1]) by
 RTITCASV01.realtek.com.tw ([::1]) with mapi id 14.03.0468.000; Tue, 3 Sep
 2019 19:55:58 +0800
From:   Tony Chuang <yhchuang@realtek.com>
To:     Kalle Valo <kvalo@codeaurora.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "jano.vesely@gmail.com" <jano.vesely@gmail.com>,
        "linux@endlessm.com" <linux@endlessm.com>,
        "briannorris@chromium.org" <briannorris@chromium.org>,
        "gojun077@gmail.com" <gojun077@gmail.com>,
        "drake@endlessm.com" <drake@endlessm.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "jian-hong@endlessm.com" <jian-hong@endlessm.com>
Subject: RE: [PATCH rebased 0/2] rtw88: pci: interrupt routine improvement
Thread-Topic: [PATCH rebased 0/2] rtw88: pci: interrupt routine improvement
Thread-Index: AQHVYjf+tJUqi3DD9EqGXCYBRVE/qacZzA1DgAAL0HA=
Date:   Tue, 3 Sep 2019 11:55:56 +0000
Message-ID: <F7CD281DE3E379468C6D07993EA72F84D18C5FE8@RTITMBSVM04.realtek.com.tw>
References: <1567502047-24102-1-git-send-email-yhchuang@realtek.com>
 <871rwxr5xp.fsf@kamboji.qca.qualcomm.com>
In-Reply-To: <871rwxr5xp.fsf@kamboji.qca.qualcomm.com>
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

> From: Kalle Valo [mailto:kvalo@codeaurora.org]
> 
> <yhchuang@realtek.com> writes:
> 
> > From: Yan-Hsuan Chuang <yhchuang@realtek.com>
> >
> > This patch set includes two patches to improve PCI interrupt routine.
> > One is to reduce HW IRQ time, the other is to enable MSI.
> >
> > The patches can be found at:
> > https://patchwork.kernel.org/patch/11114043/
> > https://patchwork.kernel.org/patch/11126007/
> >
> > They were rebased properly to resolve conflicts.
> 
> In the future, please use version markings ("v2", "v3" etc) in the
> Subject and not something like "rebased". This makes my life easier as I
> can immeaditely see what is the latest version I should take.
> 

Oh, I just combine two patches with different version markings.
And I don't know how to write a proper subject in this case, maybe
I shouldn't use cover latter?

Yan-Hsuan

