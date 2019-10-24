Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75D84E2CF2
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Oct 2019 11:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393038AbfJXJO2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 24 Oct 2019 05:14:28 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:50808 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727653AbfJXJO2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 24 Oct 2019 05:14:28 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x9O9EDpw030334, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCAS11.realtek.com.tw[172.21.6.12])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x9O9EDpw030334
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Oct 2019 17:14:13 +0800
Received: from RTITMBSVM04.realtek.com.tw ([fe80::e404:880:2ef1:1aa1]) by
 RTITCAS11.realtek.com.tw ([fe80::7c6d:ced5:c4ff:8297%15]) with mapi id
 14.03.0468.000; Thu, 24 Oct 2019 17:14:12 +0800
From:   Tony Chuang <yhchuang@realtek.com>
To:     Kalle Valo <kvalo@codeaurora.org>,
        kbuild test robot <lkp@intel.com>
CC:     Andy Huang <tehuang@realtek.com>,
        "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        Chris Chiu <chiu@endlessm.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [wireless-drivers-next:master 91/97] include/linux/bits.h:23:11: warning: right shift count is negative
Thread-Topic: [wireless-drivers-next:master 91/97]
 include/linux/bits.h:23:11: warning: right shift count is negative
Thread-Index: AQHVij/zuYt41C6geUOgPtZKjVCrT6dpbcEVgAAUTjA=
Date:   Thu, 24 Oct 2019 09:14:11 +0000
Message-ID: <F7CD281DE3E379468C6D07993EA72F84D190F16B@RTITMBSVM04.realtek.com.tw>
References: <201910241518.1B6Ev5VT%lkp@intel.com>
 <875zketvxg.fsf@kamboji.qca.qualcomm.com>
In-Reply-To: <875zketvxg.fsf@kamboji.qca.qualcomm.com>
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

> From: linux-wireless-owner@vger.kernel.org
> [mailto:linux-wireless-owner@vger.kernel.org] On Behalf Of Kalle Valo
> Sent: Thursday, October 24, 2019 4:00 PM
> To: kbuild test robot
> Cc: Andy Huang; kbuild-all@lists.01.org; Tony Chuang; Chris Chiu;
> linux-wireless@vger.kernel.org
> Subject: Re: [wireless-drivers-next:master 91/97] include/linux/bits.h:23:11:
> warning: right shift count is negative
> 
> + linux-wireless
> 
> Tony, can you send a followup patch to fix this warning?
> 

Sure, will send a fix later.

Yan-Hsuan
