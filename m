Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6A0F108FB6
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Nov 2019 15:17:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728001AbfKYORc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 Nov 2019 09:17:32 -0500
Received: from a27-185.smtp-out.us-west-2.amazonses.com ([54.240.27.185]:50060
        "EHLO a27-185.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727958AbfKYORc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 Nov 2019 09:17:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1574691451;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:MIME-Version:Content-Type;
        bh=d5+U297GSp7xCxvZhele6vkbKgTiQO4K4lr4nuR9UjY=;
        b=WeJmum7BxDwwge7Bnd9/pllnWQh5NQyE9kuWvkEvSc3TrNoE8ii6PHCgAdNu/Yd5
        w3U7832KllsRJiPHBSR8LEDrO4DRLxjtMsaz9fHlh2TcFxNLNpfczgrONdfFDKO2Kkg
        QUK7ZdraHsioJNj7h9/Kyp4gl16M4ddgF1hTRkbY=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1574691451;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:MIME-Version:Content-Type:Feedback-ID;
        bh=d5+U297GSp7xCxvZhele6vkbKgTiQO4K4lr4nuR9UjY=;
        b=afm4SufN1yfFMn6Sk5SbHLGT+7uStDxOLfDSNyc+YOWrJjeT16TJUCplGwLlrjPh
        aHfUVP/ZW4BVPWoW6sPhhXNTYkTR04BpGhdTxgpHthg49eAu/a8qoXF8USdvF0IMRSi
        ky0h2c9GvPZAKo3TmiOpNcKpQQGRlJNEaQNbXKD4=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E56C4C43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     nbd@nbd.name, linux-wireless@vger.kernel.org,
        lorenzo.bianconi@redhat.com, kevin.patrick.schmidt@googlemail.com
Subject: Re: [PATCH] mt76: eeprom: add support for big endian eeprom partition
References: <61e89623446ed8914e5969114c7ae8c623f3e3ba.1574502651.git.lorenzo@kernel.org>
        <87k17o83lk.fsf@tynnyri.adurom.net>
        <20191125135922.GC3528@localhost.localdomain>
Date:   Mon, 25 Nov 2019 14:17:31 +0000
In-Reply-To: <20191125135922.GC3528@localhost.localdomain> (Lorenzo Bianconi's
        message of "Mon, 25 Nov 2019 15:59:22 +0200")
Message-ID: <0101016ea2ecb0d7-213a9014-b00d-411c-bdd4-cd0afb89bb42-000000@us-west-2.amazonses.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-SES-Outgoing: 2019.11.25-54.240.27.185
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Lorenzo Bianconi <lorenzo@kernel.org> writes:

>> Lorenzo Bianconi <lorenzo@kernel.org> writes:
>> 
>> > mt76x0e users reported some devices (e.g TP-Link Archer VR200v) have
>> > been flashed with big endian radio partition. Add the possibility to
>> > specify eeprom endianness using big-endian dts property and in case
>> > covert eeprom data in little endian
>> >
>> > Tested-by: Kevin Schmidt <kevin.patrick.schmidt@googlemail.com>
>> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
>> > ---
>> >  drivers/net/wireless/mediatek/mt76/eeprom.c | 10 ++++++++++
>> >  1 file changed, 10 insertions(+)
>> >
>> > diff --git a/drivers/net/wireless/mediatek/mt76/eeprom.c b/drivers/net/wireless/mediatek/mt76/eeprom.c
>> > index 804224e81103..33d992d5662a 100644
>> > --- a/drivers/net/wireless/mediatek/mt76/eeprom.c
>> > +++ b/drivers/net/wireless/mediatek/mt76/eeprom.c
>> > @@ -64,6 +64,16 @@ mt76_get_of_eeprom(struct mt76_dev *dev, int len)
>> >  		goto out_put_node;
>> >  	}
>> >  
>> > +	if (of_property_read_bool(dev->dev->of_node, "big-endian")) {
>> > +		u8 *data = (u8 *)dev->eeprom.data;
>> > +		int i;
>> > +
>> > +		/* convert eeprom data in Little Endian */
>> > +		for (i = 0; i < round_down(len, 2); i += 2)
>> > +			put_unaligned_le16(get_unaligned_be16(&data[i]),
>> > +					   &data[i]);
>> > +	}
>> 
>> What about the bindings documentation? I don't see this "big-endian"
>> documented in the mt76 doc, at least.
>
> Right, I will fold a patch for it in v2.

And remember to CC the devicetree list, we need an ack from them.

-- 
Kalle Valo
