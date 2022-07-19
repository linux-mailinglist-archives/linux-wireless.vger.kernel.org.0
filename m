Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37A6657A86F
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Jul 2022 22:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240193AbiGSUpP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 19 Jul 2022 16:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240195AbiGSUpI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 19 Jul 2022 16:45:08 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9502F5A164
        for <linux-wireless@vger.kernel.org>; Tue, 19 Jul 2022 13:45:00 -0700 (PDT)
X-UUID: 445ce2604beb49b4986e3370fc1b2bcb-20220720
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.8,REQID:8e360afd-42f7-40bc-b004-7e208a4fe442,OB:0,LO
        B:0,IP:0,URL:5,TC:0,Content:3,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:53
X-CID-INFO: VERSION:1.1.8,REQID:8e360afd-42f7-40bc-b004-7e208a4fe442,OB:0,LOB:
        0,IP:0,URL:5,TC:0,Content:3,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACTIO
        N:release,TS:53
X-CID-META: VersionHash:0f94e32,CLOUDID:cf7d6933-b9e4-42b8-b28a-6364427c76bb,C
        OID:84f4aa2f8897,Recheck:0,SF:28|17|19|48,TC:nil,Content:3,EDM:-3,IP:nil,U
        RL:1,File:nil,QS:nil,BEC:nil,COL:0
X-UUID: 445ce2604beb49b4986e3370fc1b2bcb-20220720
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1680936540; Wed, 20 Jul 2022 04:44:55 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Wed, 20 Jul 2022 04:44:54 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Wed, 20 Jul 2022 04:44:54 +0800
From:   <sean.wang@mediatek.com>
To:     <lorenzo.bianconi@redhat.com>
CC:     <nbd@nbd.name>, <sean.wang@mediatek.com>,
        <Soul.Huang@mediatek.com>, <YN.Chen@mediatek.com>,
        <Leon.Yen@mediatek.com>, <Eric-SY.Chang@mediatek.com>,
        <Deren.Wu@mediatek.com>, <km.lin@mediatek.com>,
        <jenhao.yang@mediatek.com>, <robin.chiu@mediatek.com>,
        <Eddie.Chen@mediatek.com>, <ch.yeh@mediatek.com>,
        <posh.sun@mediatek.com>, <ted.huang@mediatek.com>,
        <Stella.Chang@mediatek.com>, <Tom.Chou@mediatek.com>,
        <steve.lee@mediatek.com>, <jsiuda@google.com>,
        <frankgor@google.com>, <jemele@google.com>,
        <abhishekpandit@google.com>, <shawnku@google.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH 1/4] mt76: mt7921e: fix race issue between reset and suspend/resume
Date:   Wed, 20 Jul 2022 04:44:53 +0800
Message-ID: <1658263493-14498-1-git-send-email-sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <YtXZwKyAh/MZ73rf@lore-desk--annotate>
References: <YtXZwKyAh/MZ73rf@lore-desk--annotate>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

>> From: Sean Wang <sean.wang@mediatek.com>
>>
>> It is unexpected that the reset work is running simultaneously with
>> the suspend or resume context and it is possible that reset work is

<snip>

>> @@ -363,6 +363,7 @@ static int mt7921_pci_suspend(struct device *device)
>>	int i, err;
>>
>>	pm->suspended = true;
>> +	cancel_work_sync(&dev->reset_work);
>
>should we just wait for the reset to complete here instead of cancelling? (e.g. flush_work)
>

yes, that seemed look better to me. It would wait until the queued reset request finishes.

>Regards,
>Lorenzo
>
>>	cancel_delayed_work_sync(&pm->ps_work);
>>	cancel_work_sync(&pm->wake_work);
>>
>> @@ -424,6 +425,9 @@ static int mt7921_pci_suspend(struct device
>> *device)
>>  restore_suspend:
>>	pm->suspended = false;
>>
>> +	if (err < 0)
>> +		mt7921_reset(&dev->mt76);
>> +
>>	return err;
>>  }
>>
>> @@ -437,7 +441,7 @@ static int mt7921_pci_resume(struct device
>> *device)
>>
>>	err = mt7921_mcu_drv_pmctrl(dev);
>>	if (err < 0)
>> -		return err;
>> +		goto failed;
>>
>>	mt7921_wpdma_reinit_cond(dev);
>>
>> @@ -467,11 +471,12 @@ static int mt7921_pci_resume(struct device *device)
>>		mt76_connac_mcu_set_deep_sleep(&dev->mt76, false);
>>
>>	err = mt76_connac_mcu_set_hif_suspend(mdev, false);
>> -	if (err)
>> -		return err;
>> -
>> +failed:
>>	pm->suspended = false;
>>
>> +	if (err < 0)
>> +		mt7921_reset(&dev->mt76);
>> +
>>	return err;
>>  }
>>
>> --
>> 2.25.1
>>
>
>
