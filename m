Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C63442CCC3
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Oct 2021 23:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbhJMV0a (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Oct 2021 17:26:30 -0400
Received: from mailgw02.mediatek.com ([216.200.240.185]:43504 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbhJMV03 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Oct 2021 17:26:29 -0400
X-UUID: eeecd68d068b412db96c107000599f93-20211013
X-UUID: eeecd68d068b412db96c107000599f93-20211013
Received: from mtkcas66.mediatek.inc [(172.29.193.44)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (musrelay.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 139760616; Wed, 13 Oct 2021 14:24:22 -0700
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 MTKMBS62N2.mediatek.inc (172.29.193.42) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 13 Oct 2021 14:23:00 -0700
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 14 Oct 2021 05:22:59 +0800
From:   <sean.wang@mediatek.com>
To:     <lorenzo.bianconi@redhat.com>
CC:     <nbd@nbd.name>, <sean.wang@mediatek.com>,
        <Soul.Huang@mediatek.com>, <YN.Chen@mediatek.com>,
        <Leon.Yen@mediatek.com>, <Eric-SY.Chang@mediatek.com>,
        <Mark-YW.Chen@mediatek.com>, <Deren.Wu@mediatek.com>,
        <km.lin@mediatek.com>, <robin.chiu@mediatek.com>,
        <Eddie.Chen@mediatek.com>, <ch.yeh@mediatek.com>,
        <posh.sun@mediatek.com>, <ted.huang@mediatek.com>,
        <Eric.Liang@mediatek.com>, <Stella.Chang@mediatek.com>,
        <Tom.Chou@mediatek.com>, <steve.lee@mediatek.com>,
        <jsiuda@google.com>, <frankgor@google.com>, <jemele@google.com>,
        <abhishekpandit@google.com>, <shawnku@google.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH v4 11/16] mt76: sdio: extend sdio module to support CONNAC2
Date:   Thu, 14 Oct 2021 05:22:58 +0800
Message-ID: <1634160178-17533-1-git-send-email-sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <YWcuGcFPGCtaPh+2@lore-desk--annotate>
References: <YWcuGcFPGCtaPh+2@lore-desk--annotate>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

>[...]
>>
>> In the current driver, we can see we only created one Rx queue
>> (dev->q_rx with qid = 0) in mt76s_alloc_queues for processing all incoming packets including MCU events and wifi packets.
>>
>> And from the point of view of the device, mt7663s use the hardware
>> queue 0 for all MCU events and wifi packets; mt7921s use the hardware
>> queue 1 for all MCU events and wifi packets.
>>
>> So if we don't remap from hardware queue 1 to dev->q_rx[0] for mt7921s
>> to handle incoming packets, we will get the kernel panic on accessing the invalid pointer on dev->q_rx[1].
>>
>>	Sean
>>
>> >Regards,
>> >Lorenzo
>> >
>>
>> <snip>
>
>ok, what about doing something like the patch below?
>If it works for you, I will post a formal patch.

go ahead. that looks fine to me.

>
>Regards,
>Lorenzo
>

<snip>
