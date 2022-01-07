Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB24448753A
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jan 2022 11:08:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346657AbiAGKIt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 7 Jan 2022 05:08:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237222AbiAGKIs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 7 Jan 2022 05:08:48 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 664BEC061245;
        Fri,  7 Jan 2022 02:08:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=D2YLd/fsnlkv7EjOD1sLIxfj4yulGzoSnheV9bcseYQ=; b=pGyE2fv9JvgOyMiEbbK7WLVK4/
        g7iyQpVa4QH71BNvkZkJcPFOwfb6lldioQ0WD0IHOnM2BDySD7XD8XK/lIarubNADpzrjBhICyYCU
        ygucwh/myN7xxiVVMC7LF8tPdA772IQEEAlCfhSepUztNEMmkPv+DE9GiM0SoVEaazRo=;
Received: from p54ae97a7.dip0.t-ipconnect.de ([84.174.151.167] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1n5mAf-0003lU-SL; Fri, 07 Jan 2022 11:08:29 +0100
Message-ID: <97dbf02a-e3c7-aa4a-c404-45fc6189dc10@nbd.name>
Date:   Fri, 7 Jan 2022 11:08:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Subject: Re: [PATCH] mt76: mt7915: fix a couple information leaks
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Kalle Valo <kvalo@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        MeiChia Chiu <meichia.chiu@mediatek.com>,
        Money Wang <Money.Wang@mediatek.com>,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org,
        kernel-janitors@vger.kernel.org
References: <20220107073609.GH22086@kili>
 <f61c6a25c7ad1ed452b4facf38c7e451d47c5dc0.camel@sipsolutions.net>
From:   Felix Fietkau <nbd@nbd.name>
In-Reply-To: <f61c6a25c7ad1ed452b4facf38c7e451d47c5dc0.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2022-01-07 10:18, Johannes Berg wrote:
> On Fri, 2022-01-07 at 10:36 +0300, Dan Carpenter wrote:
>> Unfortunately this code has stumbled into some deep C standards
>> nonsense.  These two structs have a 3 byte struct hole at the end.  If
>> you partially initialize a struct then the C standard specifies that
>> all the struct holes are zeroed out.  But when you initialize all the
>> members of the struct, as this code does, then struct holes may be left
>> with uninitialized stack data.  This is from C11 section 6.7.9 and how
>> it is implemented in GCC.
> 
> Wow, nice find ...
> 
>> +	memset(&data, 0, sizeof(data));
>> +	data.cmd = cpu_to_le32(MURU_SET_TXC_TX_STATS_EN);
>> +	data.enable = enabled;
>> 
> 
> Maybe add a comment? This is not going to be obvious in the future.
> 
>>  	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD(MURU_CTRL),
>> &data,
>>  				sizeof(data), false);
> 
> Or maybe instead just mark the thing __packed (and/or explicitly add the
> padding if needed), it seems weird that we'd send something to the
> *firmware* that has a struct layout subject to compiler/arch padding
> rules.
I would also prefer explicitly adding the padding and leaving the rest 
of the code as-is.

- Felix
