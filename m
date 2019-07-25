Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FEFF74972
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jul 2019 10:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389945AbfGYIzh convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 25 Jul 2019 04:55:37 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:50978 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389932AbfGYIzh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 25 Jul 2019 04:55:37 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x6P8tUqA029958, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCAS12.realtek.com.tw[172.21.6.16])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x6P8tUqA029958
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 25 Jul 2019 16:55:30 +0800
Received: from RTITMBSVM04.realtek.com.tw ([fe80::e404:880:2ef1:1aa1]) by
 RTITCAS12.realtek.com.tw ([::1]) with mapi id 14.03.0439.000; Thu, 25 Jul
 2019 16:55:29 +0800
From:   Tony Chuang <yhchuang@realtek.com>
To:     Kalle Valo <kvalo@codeaurora.org>
CC:     Brian Norris <briannorris@chromium.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [RFC PATCH] rtw88: use txpwr_lmt_cfg_pair struct, not arrays
Thread-Topic: [RFC PATCH] rtw88: use txpwr_lmt_cfg_pair struct, not arrays
Thread-Index: AQHVQq4lzwsI0XBcs027K+5Cn7dZRqbbB6ZA
Date:   Thu, 25 Jul 2019 08:55:29 +0000
Message-ID: <F7CD281DE3E379468C6D07993EA72F84D187E16E@RTITMBSVM04.realtek.com.tw>
References: <20190713013232.215138-1-briannorris@chromium.org>
        <20190724112304.7DDF960909@smtp.codeaurora.org>
        <F7CD281DE3E379468C6D07993EA72F84D187DDAE@RTITMBSVM04.realtek.com.tw>
 <87ef2ezmb7.fsf@kamboji.qca.qualcomm.com>
In-Reply-To: <87ef2ezmb7.fsf@kamboji.qca.qualcomm.com>
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

> Tony Chuang <yhchuang@realtek.com> writes:
> 
> >> Brian Norris <briannorris@chromium.org> wrote:
> >>
> >> > We're just trusting that these tables are of the right dimensions, when
> >> > we could do better by just using the struct directly. Let's expose the
> >> > struct txpwr_lmt_cfg_pair instead.
> >> >
> >> > The table changes were made by using some Vim macros, so that should
> >> > help prevent any translation mistakes along the way.
> >> >
> >> > Remaining work: get the 'void *data' out of the generic struct
> >> > rtw_table; all of these tables really deserve to be their own data
> >> > structure, with proper type fields.
> >> >
> >> > Signed-off-by: Brian Norris <briannorris@chromium.org>
> >>
> >> To me this looks like a clear improvement and I'm inclined to apply it. Tony,
> >> what do you think?
> >
> > I think it indeed is better to use struct instead of arrays to access the table.
> > But what I am trying to do is to figure a way to write a proper struct for
> > radio_[ab] tables. Since the parsing logic is more complicated than others.
> >
> > Once I finished them, I will send a patch to change the tables.
> 
> Are you saying that your patch will also clean up these txpwr tables and
> I should drop this patch? Or can I apply this?
> 

You can apply this. And I can take care of the rest of them. :)
Thanks.

Tony

