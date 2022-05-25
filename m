Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F138A53343B
	for <lists+linux-wireless@lfdr.de>; Wed, 25 May 2022 02:18:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242891AbiEYASg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 May 2022 20:18:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236535AbiEYASc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 May 2022 20:18:32 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF7A970901
        for <linux-wireless@vger.kernel.org>; Tue, 24 May 2022 17:18:29 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 24P0I8Lh8011341, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 24P0I8Lh8011341
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 25 May 2022 08:18:08 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 25 May 2022 08:18:08 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 25 May 2022 08:18:07 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::34e7:ab63:3da4:27c6]) by
 RTEXMBS04.realtek.com.tw ([fe80::34e7:ab63:3da4:27c6%5]) with mapi id
 15.01.2308.021; Wed, 25 May 2022 08:18:07 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Kalle Valo <kvalo@kernel.org>
CC:     Johannes Berg <johannes@sipsolutions.net>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH v3 0/4] rtw88: Fix some Sparse Warnings
Thread-Topic: [PATCH v3 0/4] rtw88: Fix some Sparse Warnings
Thread-Index: AQHYb4QULME5rGflWkCKqtZfeI3TwK0uun2A
Date:   Wed, 25 May 2022 00:18:07 +0000
Message-ID: <206309821b8148bbb194c7d08a00d708@realtek.com>
References: <20220524153621.19027-1-Larry.Finger@lwfinger.net>
In-Reply-To: <20220524153621.19027-1-Larry.Finger@lwfinger.net>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS02.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?us-ascii?Q?Clean,_bases:_2022/5/24_=3F=3F_10:18:00?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


> -----Original Message-----
> From: Larry Finger <Larry.Finger@lwfinger.net>
> Sent: Tuesday, May 24, 2022 11:36 PM
> To: Kalle Valo <kvalo@kernel.org>
> Cc: Johannes Berg <johannes@sipsolutions.net>; linux-wireless@vger.kernel.org; Larry Finger
> <Larry.Finger@lwfinger.net>; Ping-Ke Shih <pkshih@realtek.com>
> Subject: [PATCH v3 0/4] rtw88: Fix some Sparse Warnings
> 
> Sparse shows warnings for symbols that can be static. In these cases.
> the wrong solution is suggested - again reinforcing the concept
> that all tools may suggest the wrong answer, and must be checked.
> 
> Constify all *_hw_spec variables
> 
> Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>

This patchset looks good to me. Thanks!

Acked-by: Ping-Ke Shih <pkshih@realtek.com>


