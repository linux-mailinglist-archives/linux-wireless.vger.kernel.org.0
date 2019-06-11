Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C34333C81B
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Jun 2019 12:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405044AbfFKKIB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Jun 2019 06:08:01 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:38610 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404403AbfFKKIB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Jun 2019 06:08:01 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x5BA7tTa000371, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtitcasv02.realtek.com.tw[172.21.6.19])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x5BA7tTa000371
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 11 Jun 2019 18:07:55 +0800
Received: from RTITMBSVM04.realtek.com.tw ([fe80::e404:880:2ef1:1aa1]) by
 RTITCASV02.realtek.com.tw ([::1]) with mapi id 14.03.0439.000; Tue, 11 Jun
 2019 18:07:55 +0800
From:   Tony Chuang <yhchuang@realtek.com>
To:     Tony Chuang <yhchuang@realtek.com>,
        "kvalo@codeaurora.org" <kvalo@codeaurora.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH 00/11] rtw88: power index setting routine updates and fixes
Thread-Topic: [PATCH 00/11] rtw88: power index setting routine updates and
 fixes
Thread-Index: AQHVFfPP1LoFj+BGLU+zmlcqsrlVn6aWTpoA
Date:   Tue, 11 Jun 2019 10:07:54 +0000
Message-ID: <F7CD281DE3E379468C6D07993EA72F84D1803B44@RTITMBSVM04.realtek.com.tw>
References: <1559116487-5244-1-git-send-email-yhchuang@realtek.com>
In-Reply-To: <1559116487-5244-1-git-send-email-yhchuang@realtek.com>
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
> From: linux-wireless-owner@vger.kernel.org
> [mailto:linux-wireless-owner@vger.kernel.org] On Behalf Of
> yhchuang@realtek.com
> Sent: Wednesday, May 29, 2019 3:55 PM
> To: kvalo@codeaurora.org
> Cc: linux-wireless@vger.kernel.org
> Subject: [PATCH 00/11] rtw88: power index setting routine updates and fixes
> 

...

>  drivers/net/wireless/realtek/rtw88/debug.c         |  112 ++
>  drivers/net/wireless/realtek/rtw88/main.c          |   26 +-
>  drivers/net/wireless/realtek/rtw88/main.h          |   27 +-
>  drivers/net/wireless/realtek/rtw88/phy.c           | 1298
> +++++++++++---------
>  drivers/net/wireless/realtek/rtw88/phy.h           |   18 +-
>  drivers/net/wireless/realtek/rtw88/regd.c          |   69 +-
>  drivers/net/wireless/realtek/rtw88/regd.h          |    4 +
>  .../net/wireless/realtek/rtw88/rtw8822c_table.c    |  799 +++++++++++-
>  8 files changed, 1653 insertions(+), 700 deletions(-)
> 
> --

Hi Kalle

I am going to submit a v2 for this.
Will you suggest me to format the patches based on
wireless-drivers or wireless-drivers-next?
Thanks

Yan-Hsuan
