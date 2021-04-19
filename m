Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20F1736398E
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Apr 2021 05:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233146AbhDSDBF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 18 Apr 2021 23:01:05 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:53578 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229845AbhDSDBF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 18 Apr 2021 23:01:05 -0400
X-UUID: 553d109fcd1d4fb2b96a799f7f9f3a64-20210419
X-UUID: 553d109fcd1d4fb2b96a799f7f9f3a64-20210419
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1705058396; Mon, 19 Apr 2021 11:00:32 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 19 Apr 2021 11:00:30 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 19 Apr 2021 11:00:30 +0800
From:   <sean.wang@mediatek.com>
To:     <nbd@nbd.name>, <lorenzo.bianconi@redhat.com>
CC:     <sean.wang@mediatek.com>, <Soul.Huang@mediatek.com>,
        <YN.Chen@mediatek.com>, <Leon.Yen@mediatek.com>,
        <Deren.Wu@mediatek.com>, <km.lin@mediatek.com>,
        <robin.chiu@mediatek.com>, <ch.yeh@mediatek.com>,
        <posh.sun@mediatek.com>, <Eric.Liang@mediatek.com>,
        <Stella.Chang@mediatek.com>, <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH 1/6] mt76: mt7921: move mt7921_dma_reset in dma.c
Date:   Mon, 19 Apr 2021 11:00:29 +0800
Message-ID: <1618801229-19920-1-git-send-email-sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <YHxinpO6Ev8qbbuf@lore-desk--annotate>
References: <YHxinpO6Ev8qbbuf@lore-desk--annotate>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 58BC0734E34B78BD1E36A79DC5C6911FDFD905B0E3E532FC6B0169310711979B2000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

>> From: Lorenzo Bianconi <lorenzo@kernel.org>
>>
>> Move mt7921_dma_reset routine in dma.c and make mt7921_dma_prefetch
>> static. Moreover add force parameter to mt7921_dma_reset signature.
>> This is a preliminary patch to reset dma mt7921_mcu_drv_pmctrl.
>>
>> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
>> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
>> ---
>>  .../net/wireless/mediatek/mt76/mt7921/dma.c   | 71 +++++++++++++++++++
>>  .../net/wireless/mediatek/mt76/mt7921/mac.c   | 66 +----------------
>>  .../wireless/mediatek/mt76/mt7921/mt7921.h    |  2 +-
>>  3 files changed, 73 insertions(+), 66 deletions(-)
>
>Hi Sean,
>
>I have just posted a preliminary series mandatory to enable deep sleep on mt7921.
>I can post my patches of this seires (the one you posted) on top of it, or if you prefer, can you please repost on top of my new series?

Thanks, I can post the series again rebased on the top of yours.

>
>Regards,
>Lorenzo
>
>>
>> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/dma.c
>> b/drivers/net/wireless/mediatek/mt76/mt7921/dma.c
>> index 992faf82ad09..f8815aa247eb 100644
>> --- a/drivers/net/wireless/mediatek/mt76/mt7921/dma.c
>> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/dma.c
>> @@ -206,6 +206,77 @@ static int mt7921_dmashdl_disabled(struct mt7921_dev *dev)
>>	return 0;
>
<snip>
