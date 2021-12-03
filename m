Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BF52467C45
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Dec 2021 18:10:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353363AbhLCRNm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 3 Dec 2021 12:13:42 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:57174 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1353315AbhLCRNe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 3 Dec 2021 12:13:34 -0500
X-UUID: c9138cccd5844242bf72352b9fb3100b-20211204
X-UUID: c9138cccd5844242bf72352b9fb3100b-20211204
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1451301830; Sat, 04 Dec 2021 01:10:04 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Sat, 4 Dec 2021 01:10:03 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 4 Dec 2021 01:10:03 +0800
From:   <sean.wang@mediatek.com>
To:     <lorenzo.bianconi@redhat.com>
CC:     <nbd@nbd.name>, <sven@narfation.org>, <jf@simonwunderlich.de>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        "Sean Wang" <sean.wang@mediatek.com>
Subject: Re: mt76: MT7921K monitor mode not working
Date:   Sat, 4 Dec 2021 01:10:02 +0800
Message-ID: <1638551402-3864-1-git-send-email-sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <YapBMGjLcjuBo/vw@lore-desk--annotate>
References: <YapBMGjLcjuBo/vw@lore-desk--annotate>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

>> On Thursday, 2 December 2021 23:13:31 CET Lorenzo Bianconi wrote:
>> > IIRC you need to disable runtime-pm and deep-sleep to proper enable
>> > monitor
>> > mode:
>> >
>> > echo 0 > /sys/kernel/debug/ieee80211/phy<x>/mt76/runtime-pm
>> > echo 0 > /sys/kernel/debug/ieee80211/phy<x>/mt76/deep-sleep
>> >
>> > Can you please give it whirl?
>>
>> Jan gave me the card. I've set it to a rather busy channel (2.4GHz
>> channel 11), created a monitor interface, attached tcpdump and then
>> waited what happens. I didn't get anything and then I've tried to set
>> runtime-pm and deep- sleep to 0. This didn't change the behavior for
>> me at lot. I saw two packets and then it went silent again.
>>
>> I wanted to try the same on a different card (ath11k) in the same
>> system. But it crashed my complete system - so I had to recreate the
>> test setup. This time, I've set runtime-pm + deep-sleep to 0 before
>> creating mon0. After doing this, it seemed to work.
>
>interesting, adding Sean to the loop here.
>It seems the fw is mainting a different state in this case.

fw cannot receive any frame on monitor mode in deeply doze mode

so it seemed to me we need a patch to explicitly disable pm runtime in driver when monitor interface is enabled until it is being disabled.

>
>@Sean: any pointers?
>
>Regards,
>Lorenzo
>
>>
>> Kind regards,
>>	Sven
>
