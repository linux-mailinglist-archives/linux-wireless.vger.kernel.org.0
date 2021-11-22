Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B5D2458874
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Nov 2021 04:46:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233082AbhKVDt6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 21 Nov 2021 22:49:58 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:59734 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229862AbhKVDt6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 21 Nov 2021 22:49:58 -0500
X-UUID: 245e0f24186c4a2a94ac9e1c746407a0-20211122
X-UUID: 245e0f24186c4a2a94ac9e1c746407a0-20211122
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 735854659; Mon, 22 Nov 2021 11:46:49 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Mon, 22 Nov 2021 11:46:49 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 22 Nov 2021 11:46:48 +0800
From:   <sean.wang@mediatek.com>
To:     <lorenzo.bianconi@redhat.com>
CC:     <nbd@nbd.name>, <sean.wang@mediatek.com>,
        <Soul.Huang@mediatek.com>, <YN.Chen@mediatek.com>,
        <Leon.Yen@mediatek.com>, <Eric-SY.Chang@mediatek.com>,
        <Deren.Wu@mediatek.com>, <km.lin@mediatek.com>,
        <robin.chiu@mediatek.com>, <Eddie.Chen@mediatek.com>,
        <ch.yeh@mediatek.com>, <posh.sun@mediatek.com>,
        <ted.huang@mediatek.com>, <Eric.Liang@mediatek.com>,
        <Stella.Chang@mediatek.com>, <steve.lee@mediatek.com>,
        <jsiuda@google.com>, <frankgor@google.com>, <jemele@google.com>,
        <shawnku@google.com>, <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH 2/2] mt76: mt7921s: fix the device cannot sleep deeply in suspend
Date:   Mon, 22 Nov 2021 11:46:48 +0800
Message-ID: <1637552808-24472-1-git-send-email-sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <YZq9cBbzwtvzEKyN@lore-desk--annotate>
References: <YZq9cBbzwtvzEKyN@lore-desk--annotate>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>


<snip>

>> >>
>> >> -		if (test_bit(MT76_MCU_RESET, &dev->phy.state)) {
>> >> -			if (!mt76s_txqs_empty(dev))
>> >> -				continue;
>> >> -			else
>> >> -				wake_up(&sdio->wait);
>> >> -		}
>> >>	} while (nframes > 0);
>> >>
>> >> +	if (test_bit(MT76_MCU_RESET, &dev->phy.state) &&
>> >> +	    mt76s_txqs_empty(dev))
>> >> +		wake_up(&sdio->wait);
>> >> +
>>
>> If doing so, mt76s_txqs_empty may not always be true because enqueuing
>> packets to q_tx or MCU command to q_mcu simultanenously from the other
>> contexts in different cpu is possible.
>>
>> It seemed to me we should check it for each iteration to guarantee
>> that we can wake up the one that is waiting for the all the queues are empty at some time.
>
>IIUC what we are interested here is there are no queued frames into the hw queues during suspend or reset, right?

That is not completely true. Take the suspend procedure on mt7921s as an example.

That should be "There are no queued frames into the hw queues right after mt76_connac_mcu_set_hif_suspend."

The MCU data and WiFi are all handled in mt76s_txrx_worker so we should synchronize all of
the Tx queues are all empty and then handle mt76_connac_mcu_set_hif_suspend to guarantee
mt76_connac_mcu_set_hif_suspend is the last one to access the SDIO bus and there is no frame that accesses SDIO bus afterhand.

>
>>
>> >>	/* enable interrupt */
>> >>	sdio_writel(sdio->func, WHLPCR_INT_EN_SET, MCR_WHLPCR, NULL);
>> >>	sdio_release_host(sdio->func);
>> >>
>> >> Regards,
>> >> Lorenzo
>> >>
>> >> > --
>> >> > 2.25.1
>> >> >
>> >
>> >
>> >
>>
>
