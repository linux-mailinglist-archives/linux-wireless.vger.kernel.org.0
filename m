Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8959337F51B
	for <lists+linux-wireless@lfdr.de>; Thu, 13 May 2021 11:55:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231678AbhEMJ43 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 May 2021 05:56:29 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:46376 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231261AbhEMJ42 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 May 2021 05:56:28 -0400
X-UUID: 56211f3a84e74f0ea03de903bf80b6ea-20210513
X-UUID: 56211f3a84e74f0ea03de903bf80b6ea-20210513
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 98008978; Thu, 13 May 2021 17:55:17 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 13 May 2021 17:55:16 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 13 May 2021 17:55:15 +0800
From:   <sean.wang@mediatek.com>
To:     <nbd@nbd.name>, <lorenzo.bianconi@redhat.com>
CC:     <sean.wang@mediatek.com>, <Soul.Huang@mediatek.com>,
        <YN.Chen@mediatek.com>, <Leon.Yen@mediatek.com>,
        <Deren.Wu@mediatek.com>, <km.lin@mediatek.com>,
        <robin.chiu@mediatek.com>, <ch.yeh@mediatek.com>,
        <posh.sun@mediatek.com>, <Eric.Liang@mediatek.com>,
        <Stella.Chang@mediatek.com>, <jemele@google.com>,
        <yenlinlai@google.com>, <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH 9/9] mt76: mt7921: add back connection monitor support
Date:   Thu, 13 May 2021 17:55:15 +0800
Message-ID: <1620899715-4351-1-git-send-email-sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <79633d77-a326-fb46-6356-65dddea9da44@nbd.name--annotate>
References: <79633d77-a326-fb46-6356-65dddea9da44@nbd.name--annotate>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

>On 2021-05-10 17:14, sean.wang@mediatek.com wrote:
>> From: Sean Wang <sean.wang@mediatek.com>
>>
>> Hw beacon cmd to the mt7921 firmware doesn't only filter out the
>> beacon, but also performs its own connection monitoring, including
>> periodic keep-alives to the AP and probing the AP on beacon loss. Will
>> indicate the host with the event when the firmware detects the connection is lost.
>>
>> Fixes: 1d8efc741df8 ("mt76: mt7921: introduce Runtime PM support")
>> Reviewed-by: Lorenzo Bianconi <lorenzo@kernel.org>
>> Signed-off-by: Deren Wu <deren.wu@mediatek.com>
>> Signed-off-by: YN Chen <yn.chen@mediatek.com>
>> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
>What happened to Patch 8?
>I don't see it on the list or patchwork.

I've sent again the patch 8. Please help take a look.
>
>
>- Felix
