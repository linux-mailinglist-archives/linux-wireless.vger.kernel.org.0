Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB192DAE0D
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Dec 2020 14:34:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbgLONdg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 15 Dec 2020 08:33:36 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:37146 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726266AbgLONd0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 15 Dec 2020 08:33:26 -0500
X-UUID: 9b17ef357ac04b6e84b5f4d5ba5043f8-20201215
X-UUID: 9b17ef357ac04b6e84b5f4d5ba5043f8-20201215
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1249573677; Tue, 15 Dec 2020 21:32:39 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 15 Dec 2020 21:32:37 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 15 Dec 2020 21:32:38 +0800
From:   <sean.wang@mediatek.com>
To:     <drinkcat@chromium.org>
CC:     <nbd@nbd.name>, <lorenzo.bianconi@redhat.com>,
        <sean.wang@mediatek.com>, <Soul.Huang@mediatek.com>,
        <YN.Chen@mediatek.com>, <robin.chiu@mediatek.com>,
        <ch.yeh@mediatek.com>, <Eric.Liang@mediatek.com>,
        <ryder.lee@mediatek.com>, <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH -next v2] mt76: mt7921: introduce mt7921e support
Date:   Tue, 15 Dec 2020 21:32:35 +0800
Message-ID: <1608039155-29313-1-git-send-email-sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <CANMq1KAgYKBXGPMgpMpAF=6rWv3zVsHBBjwX1fOCRC2THCYM5Q@mail.gmail.com--annotate>
References: <CANMq1KAgYKBXGPMgpMpAF=6rWv3zVsHBBjwX1fOCRC2THCYM5Q@mail.gmail.com--annotate>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: E16242EE3AAC3FA2620671A2FC26BB456ECD5CE05658212073630134F05869002000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

On Mon, Dec 14, 2020 at 8:56 PM <sean.wang@mediatek.com> wrote:
>>
>> From: Sean Wang <sean.wang@mediatek.com>
>>
>> Introduce support for mt7921e 802.11ax (Wi-Fi 6) 2x2:2SS chipset.
>>
>> Co-developed-by: Lorenzo Bianconi <lorenzo@kernel.org>
>> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
>> Co-developed-by: Soul Huang <Soul.Huang@mediatek.com>
>> Signed-off-by: Soul Huang <Soul.Huang@mediatek.com>
>> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
>> ---
>> v2:
>>  - Mark the patch as -next
>> ---
>>  drivers/net/wireless/mediatek/mt76/Kconfig    |    1 +
>>  drivers/net/wireless/mediatek/mt76/Makefile   |    1 +
>>  .../net/wireless/mediatek/mt76/mt7921/Kconfig |   10 +
>>  .../wireless/mediatek/mt76/mt7921/Makefile    |    6 +
>>  .../wireless/mediatek/mt76/mt7921/debugfs.c   |  180 ++
>>  .../net/wireless/mediatek/mt76/mt7921/dma.c   |  356 +++
>>  .../wireless/mediatek/mt76/mt7921/eeprom.c    |  247 ++
>>  .../wireless/mediatek/mt76/mt7921/eeprom.h    |  126 +
>>  .../net/wireless/mediatek/mt76/mt7921/init.c  |  482 +++
>>  .../net/wireless/mediatek/mt76/mt7921/mac.c   | 1387 +++++++++
>>  .../net/wireless/mediatek/mt76/mt7921/mac.h   |  367 +++
>>  .../net/wireless/mediatek/mt76/mt7921/main.c  |  854 ++++++
>>  .../net/wireless/mediatek/mt76/mt7921/mcu.c   | 2588 +++++++++++++++++
>>  .../net/wireless/mediatek/mt76/mt7921/mcu.h   |  991 +++++++
>>  .../wireless/mediatek/mt76/mt7921/mt7921.h    |  379 +++
>>  .../net/wireless/mediatek/mt76/mt7921/pci.c   |  209 ++
>>  .../net/wireless/mediatek/mt76/mt7921/regs.h  |  455 +++
>>  17 files changed, 8639 insertions(+)
>
>I'm not likely to review this, but, this is a _huge_ patch, is there a way to split it in easier to digest parts?
>

we will split the series for areas (e.g: dma, mcu, ..) and make sure each patch compile properly.

>[snip]
>
>> +static void
>> +mt7921_mcu_debug_msg_event(struct mt7921_dev *dev, struct sk_buff
>> +*skb) {
>> +       struct mt7921_mcu_rxd *rxd = (struct mt7921_mcu_rxd *)skb->data;
>> +       struct debug_msg {
>> +               __le16 id;
>> +               u8 type;
>> +               u8 flag;
>> +               __le32 value;
>> +               __le16 len;
>> +               u8 content[512];
>> +       } __packed * debug_msg;
>> +       u16 cur_len;
>> +       int i;
>> +
>> +       skb_pull(skb, sizeof(*rxd));
>> +       debug_msg = (struct debug_msg *)skb->data;
>> +
>> +       cur_len = min_t(u16, le16_to_cpu(debug_msg->len), 512);
>> +
>> +       if (debug_msg->type == 0x3) {
>> +               for (i = 0 ; i < cur_len; i++)
>> +                       if (!debug_msg->content[i])
>> +                               debug_msg->content[i] = ' ';
>> +
>> +               trace_printk("%s", debug_msg->content);
>
>Please do not use trace_printk in production code [1,2], it is only meant for debug use. Consider using trace events, or dev_dbg.

ack, we will use dev_dbg instead.

>
>[1] https://elixir.bootlin.com/linux/v5.8/source/kernel/trace/trace.c#L3158
>[2] https://elixir.bootlin.com/linux/v5.8/source/include/linux/kernel.h#L766
>
>> +       }
>> +}
>> +
>
