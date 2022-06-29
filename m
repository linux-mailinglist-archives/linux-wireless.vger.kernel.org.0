Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0F76560757
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Jun 2022 19:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbiF2R0M (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 29 Jun 2022 13:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbiF2R0L (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 29 Jun 2022 13:26:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7CCA24F1F
        for <linux-wireless@vger.kernel.org>; Wed, 29 Jun 2022 10:26:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9F373B82475
        for <linux-wireless@vger.kernel.org>; Wed, 29 Jun 2022 17:26:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7A25C34114;
        Wed, 29 Jun 2022 17:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656523568;
        bh=bKTdzuoJYJi8iUDK8FYlg/CfAY2KxQzHuONLRYR5ryc=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=UIfXmBOXktNxmwj8pWEraq/TIgnYHR9+Ol6MEvCu7LBjHOoPe8esHCyzzc28axvz6
         Z2GXxBk3euuOJ8HnHlmA583jarEWeWAGdya6PcqQsdcZ7UgPIb9gJv8KAaQ4b2awZi
         aPxriO35n0tgWgzfO4ugABLk1wp7dYYqVDHyEZBap4C2diD1H/4Y/xbyVdwiHE1BoK
         ikL6wEXcMOhBy6dZQqHCgUA74OBMAmt5iZ229an8gNQYUYNKjDLAFJNXnpNJBowpyo
         w6doemrccCyDwwdzPYW5JQnwG7ucaJ4rsrd9cHuJd5vdVcLtZehuFm7Suh4zcL1mbV
         X4iL0OgU7fccA==
From:   Kalle Valo <kvalo@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     sean.wang@mediatek.com, nbd@nbd.name, lorenzo.bianconi@redhat.com,
        Soul.Huang@mediatek.com, YN.Chen@mediatek.com,
        Leon.Yen@mediatek.com, Eric-SY.Chang@mediatek.com,
        Deren.Wu@mediatek.com, km.lin@mediatek.com,
        jenhao.yang@mediatek.com, robin.chiu@mediatek.com,
        Eddie.Chen@mediatek.com, ch.yeh@mediatek.com,
        posh.sun@mediatek.com, ted.huang@mediatek.com,
        Stella.Chang@mediatek.com, Tom.Chou@mediatek.com,
        steve.lee@mediatek.com, jsiuda@google.com, frankgor@google.com,
        kuabhs@google.com, druth@google.com, abhishekpandit@google.com,
        shawnku@google.com, linux-wireless@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 1/2] mt76: mt7921: reduce log severity levels for informative messages
References: <753f19393f169ad4a5fc127f68e16074f1617306.1655944385.git.objelf@gmail.com>
        <b2769038-798c-fe93-478b-8d5bbd97b29f@collabora.com>
Date:   Wed, 29 Jun 2022 20:26:01 +0300
In-Reply-To: <b2769038-798c-fe93-478b-8d5bbd97b29f@collabora.com>
        (AngeloGioacchino Del Regno's message of "Thu, 23 Jun 2022 10:48:07
        +0200")
Message-ID: <871qv7peja.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
writes:

> Il 23/06/22 02:35, sean.wang@mediatek.com ha scritto:
>> From: Sean Wang <sean.wang@mediatek.com>
>>
>> Use dev_info instead for the informative messages.
>>
>> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
>> ---
>>   drivers/net/wireless/mediatek/mt76/mt7921/mac.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
>> index eb1bfb682e02..2ce3a833176e 100644
>> --- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
>> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
>> @@ -740,7 +740,7 @@ void mt7921_mac_reset_work(struct work_struct *work)
>>   	struct mt76_connac_pm *pm = &dev->pm;
>>   	int i;
>>   -	dev_err(dev->mt76.dev, "chip reset\n");
>> +	dev_info(dev->mt76.dev, "chip reset\n");
>
> Since this function is normally expected to be called and this message is
> describing the wanted flow and/or this worker function starting, I'd say
> that this is not a really important information anyway...
>
> What about changing that one to a dev_dbg() instead?

Yeah, that would be better.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
