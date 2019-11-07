Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C8ECF25FE
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2019 04:31:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733080AbfKGDbr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 6 Nov 2019 22:31:47 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:36093 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727581AbfKGDbq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 6 Nov 2019 22:31:46 -0500
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID xA73VY6b030682, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCASV01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id xA73VY6b030682
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 7 Nov 2019 11:31:34 +0800
Received: from RTITMBSVM04.realtek.com.tw ([fe80::e404:880:2ef1:1aa1]) by
 RTITCASV01.realtek.com.tw ([::1]) with mapi id 14.03.0468.000; Thu, 7 Nov
 2019 11:31:34 +0800
From:   Tony Chuang <yhchuang@realtek.com>
To:     Brian Norris <briannorris@chromium.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     Dan Carpenter <dan.carpenter@oracle.com>
Subject: RE: [PATCH] rtw88: signal completion even on firmware-request failure
Thread-Topic: [PATCH] rtw88: signal completion even on firmware-request
 failure
Thread-Index: AQHVlRKrECz/BSR3qECSDaAklSLTC6d/DWag
Date:   Thu, 7 Nov 2019 03:31:33 +0000
Message-ID: <F7CD281DE3E379468C6D07993EA72F84D191E2AC@RTITMBSVM04.realtek.com.tw>
References: <20191106213055.133424-1-briannorris@chromium.org>
In-Reply-To: <20191106213055.133424-1-briannorris@chromium.org>
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

> Subject: [PATCH] rtw88: signal completion even on firmware-request failure
> 
> Otherwise, the waiters (e.g., "modprobe rtwpci") will block forever.
> 
> Fixes: f530c1961af2 ("rtw88: fix potential NULL pointer access for firmware")
> Cc: Dan Carpenter <dan.carpenter@oracle.com>
> Cc: Yan-Hsuan Chuang <yhchuang@realtek.com>
> Signed-off-by: Brian Norris <briannorris@chromium.org>
Acked-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
