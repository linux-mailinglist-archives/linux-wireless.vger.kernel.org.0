Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13211360CE9
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Apr 2021 16:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234299AbhDOOz1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 15 Apr 2021 10:55:27 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:41108 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S234316AbhDOOyE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 15 Apr 2021 10:54:04 -0400
X-UUID: d687350312654a6e863c8db7f3be8075-20210415
X-UUID: d687350312654a6e863c8db7f3be8075-20210415
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 311545127; Thu, 15 Apr 2021 22:53:37 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 15 Apr 2021 22:53:30 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 15 Apr 2021 22:53:30 +0800
From:   <sean.wang@mediatek.com>
To:     <nbd@nbd.name>, <lorenzo.bianconi@redhat.com>
CC:     <sean.wang@mediatek.com>, <Soul.Huang@mediatek.com>,
        <YN.Chen@mediatek.com>, <robin.chiu@mediatek.com>,
        <ch.yeh@mediatek.com>, <posh.sun@mediatek.com>,
        <Eric.Liang@mediatek.com>, <Stella.Chang@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH 1/2] mt76: mt7921: add debugfs knob for performing wifi reset
Date:   Thu, 15 Apr 2021 22:53:29 +0800
Message-ID: <1618498409-7155-1-git-send-email-sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <YHhFXcgsfziGlCag@lore-desk>
References: <YHhFXcgsfziGlCag@lore-desk>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

>> From: Sean Wang <sean.wang@mediatek.com>
>>
>> Introduce chip_reset knob in mt7921 debugfs to export a way to users
>> able to trigger wifi reset.
>>
>> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
>> ---
>>  drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c | 11 +++++++++++
>>  1 file changed, 11 insertions(+)
>>
>> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c
>> b/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c
>> index 024524173115..1342a0b645e3 100644
>> --- a/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c
>> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c
>> @@ -302,6 +302,16 @@ static int mt7921_config(void *data, u64 val)
>>
>>  DEFINE_DEBUGFS_ATTRIBUTE(fops_config, NULL, mt7921_config, "%lld\n");
>>
>> +static int mt7921_chip_reset(void *data, u64 val) {
>> +	struct mt7921_dev *dev = data;
>> +
>> +	mt7921_reset(&dev->mt76);
>> +
>> +	return 0;
>> +}
>> +DEFINE_DEBUGFS_ATTRIBUTE(fops_reset, NULL, mt7921_chip_reset,
>> +"%lld\n");
>
>can we use chip_config for this?

i think we can resue the the knob for chip_reset. i will do it in the next version.

>
>Regards,
>Lorenzo
>
>> +
>>  int mt7921_init_debugfs(struct mt7921_dev *dev)  {
>>	struct dentry *dir;
>> @@ -322,6 +332,7 @@ int mt7921_init_debugfs(struct mt7921_dev *dev)
>>	debugfs_create_file("idle-timeout", 0600, dir, dev,
>>			    &fops_pm_idle_timeout);
>>	debugfs_create_file("chip_config", 0600, dir, dev, &fops_config);
>> +	debugfs_create_file("chip_reset", 0600, dir, dev, &fops_reset);
>>
>>	return 0;
>>  }
>> --
>> 2.25.1
>>
>
