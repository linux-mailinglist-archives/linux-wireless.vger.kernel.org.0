Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF9262E83A4
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Jan 2021 13:40:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbhAAMhN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 1 Jan 2021 07:37:13 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:50806 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726604AbhAAMhN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 1 Jan 2021 07:37:13 -0500
X-UUID: 61368b82a4f3403786080416252c66a8-20210101
X-UUID: 61368b82a4f3403786080416252c66a8-20210101
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1432165963; Fri, 01 Jan 2021 20:36:22 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 1 Jan 2021 20:36:20 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 1 Jan 2021 20:36:14 +0800
From:   <sean.wang@mediatek.com>
To:     <ryder.lee@mediatek.com>
CC:     <nbd@nbd.name>, <lorenzo.bianconi@redhat.com>,
        <sean.wang@mediatek.com>, <Soul.Huang@mediatek.com>,
        <YN.Chen@mediatek.com>, <robin.chiu@mediatek.com>,
        <ch.yeh@mediatek.com>, <posh.sun@mediatek.com>,
        <Eric.Liang@mediatek.com>, <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH -next v4 03/13] mt76: mt7921: add MAC support
Date:   Fri, 1 Jan 2021 20:36:13 +0800
Message-ID: <1609504573-16814-1-git-send-email-sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1609455495.20208.8.camel@mtkswgap22--annotate>
References: <1609455495.20208.8.camel@mtkswgap22--annotate>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

>On Thu, 2020-12-31 at 02:06 +0800, sean.wang@mediatek.com wrote:
>> From: Sean Wang <sean.wang@mediatek.com>
>>
>> Add Rx packet description parsing, Tx packet description compositon,
>> handle packet recycling and provide MAC information mt76 core needs to
>> support mac80211.
>>
>> Co-developed-by: Lorenzo Bianconi <lorenzo@kernel.org>
>> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
>> Co-developed-by: Soul Huang <Soul.Huang@mediatek.com>
>> Signed-off-by: Soul Huang <Soul.Huang@mediatek.com>
>> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
>> ---
>>  .../wireless/mediatek/mt76/mt7921/Makefile    |    2 +-
>>  .../net/wireless/mediatek/mt76/mt7921/mac.c   | 1364 +++++++++++++++++
>
>Why not put mac.h into this patch?

I remember mcu.c would refer to something in mac.h but it seems better move mac.h to here.

>
>>  2 files changed, 1365 insertions(+), 1 deletion(-)  create mode
>> 100644 drivers/net/wireless/mediatek/mt76/mt7921/mac.c
>
>> +int mt7921_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
>> +			  enum mt76_txq_id qid, struct mt76_wcid *wcid,
>> +			  struct ieee80211_sta *sta,
>> +			  struct mt76_tx_info *tx_info)
>> +{
>> +	struct mt7921_dev *dev = container_of(mdev, struct mt7921_dev, mt76);
>> +	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(tx_info->skb);
>> +	struct ieee80211_key_conf *key = info->control.hw_key;
>> +	struct mt76_tx_cb *cb = mt76_tx_skb_cb(tx_info->skb);
>> +	struct mt76_txwi_cache *t;
>> +	struct mt7921_txp_common *txp;
>> +	int id;
>> +	u8 *txwi = (u8 *)txwi_ptr;
>
>Moreover, hardware cannot add LLC-SNAP when skb->data_len is 0, which causes Tx stuck. We found this case happened on mt7915 (station mode) quality test with few packets whose skb->len = 14
>
>So,https://github.com/nbd168/wireless/commit/6b6605e4061c94c9909ff82acc0e02bfd3a8d40e
>

We'll add the fixes in the next version including mcu one you suggested in the other mail thread.

Happy new year
	Sean

>Ryder
>
