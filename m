Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6E0D5B07
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Oct 2019 08:05:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729869AbfJNGE7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 14 Oct 2019 02:04:59 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:49982 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbfJNGE7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 14 Oct 2019 02:04:59 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x9E64r2s013665, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCAS11.realtek.com.tw[172.21.6.12])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x9E64r2s013665
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Oct 2019 14:04:53 +0800
Received: from RTITMBSVM04.realtek.com.tw ([fe80::e404:880:2ef1:1aa1]) by
 RTITCAS11.realtek.com.tw ([fe80::7c6d:ced5:c4ff:8297%15]) with mapi id
 14.03.0468.000; Mon, 14 Oct 2019 14:04:53 +0800
From:   Tony Chuang <yhchuang@realtek.com>
To:     Brian Norris <briannorris@chromium.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH] rtw88: use a for loop in rtw_power_mode_change(), not goto
Thread-Topic: [PATCH] rtw88: use a for loop in rtw_power_mode_change(), not
 goto
Thread-Index: AQHVgJw0eC5TBNqfpESio+zXHTMtFqdZqQ5g
Date:   Mon, 14 Oct 2019 06:04:51 +0000
Message-ID: <F7CD281DE3E379468C6D07993EA72F84D18FCAB4@RTITMBSVM04.realtek.com.tw>
References: <20191012012720.227399-1-briannorris@chromium.org>
In-Reply-To: <20191012012720.227399-1-briannorris@chromium.org>
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

> Subject: [PATCH] rtw88: use a for loop in rtw_power_mode_change(), not
> goto
> 
> No change in logic.
> 
> Signed-off-by: Brian Norris <briannorris@chromium.org>
Acked-by: Yan-Hsuan Chuang <yhchuang@realtek.com>

