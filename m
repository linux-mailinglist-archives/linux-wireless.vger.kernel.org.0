Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D976691AE1
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Feb 2023 10:09:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231691AbjBJJJZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 10 Feb 2023 04:09:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231915AbjBJJJE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 10 Feb 2023 04:09:04 -0500
Received: from nbd.name (nbd.name [46.4.11.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22DAC37700
        for <linux-wireless@vger.kernel.org>; Fri, 10 Feb 2023 01:07:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
        s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Su8zTzR2eBMkXZoHn096ACCwuReb2hQXURyH9ZRK9B8=; b=S0VEOQP7B/KfzPcUQM3ziZmqwQ
        iPkfll1AmhFKWsd95JlykBqHgtJu8RKFVySuoNV8tAXt+V7R66439THFvpCoPLlAmpaTIhPJ5pevV
        ImHkq5pqQAR7F+MMNvl43rjkZxnwu9HSLJAaYM0b+xwhskgiyy51vQumSH29+3AlDmzk=;
Received: from p200300daa717ad00b877f5316056673d.dip0.t-ipconnect.de ([2003:da:a717:ad00:b877:f531:6056:673d] helo=nf.local)
        by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <nbd@nbd.name>)
        id 1pQPNT-006VcP-EF; Fri, 10 Feb 2023 10:07:31 +0100
Message-ID: <ac497bae-838a-2402-a3a4-79913782ccf1@nbd.name>
Date:   Fri, 10 Feb 2023 10:07:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
Subject: Re: [PATCH] wifi: mt76: mt7921: fix rx filter incorrect by drv/fw
 inconsistent
To:     Deren Wu <deren.wu@mediatek.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     Sean Wang <sean.wang@mediatek.com>,
        Soul Huang <Soul.Huang@mediatek.com>,
        YN Chen <YN.Chen@mediatek.com>,
        Leon Yen <Leon.Yen@mediatek.com>,
        Eric-SY Chang <Eric-SY.Chang@mediatek.com>,
        KM Lin <km.lin@mediatek.com>,
        Robin Chiu <robin.chiu@mediatek.com>,
        CH Yeh <ch.yeh@mediatek.com>, Posh Sun <posh.sun@mediatek.com>,
        Stella Chang <Stella.Chang@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>
References: <b9ebeda5d445f66fceb17c48c8251093dfe94c57.1673947063.git.deren.wu@mediatek.com>
Content-Language: en-US
From:   Felix Fietkau <nbd@nbd.name>
In-Reply-To: <b9ebeda5d445f66fceb17c48c8251093dfe94c57.1673947063.git.deren.wu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 17.01.23 10:30, Deren Wu wrote:
> From: Neil Chen <yn.chen@mediatek.com>
> 
> The rx filter, in mt7921 series, may be changed in fw operation. There is
> a racing problem if rx filter controlled by both driver and firmware at
> the same time. To avoid this issue, let mt7921 driver set rx filter by new
> command MCU_CE_CMD_SET_RX_FILTER and allow the firmware controlling it
> only.
> 
> Reviewed-by: Lorenzo Bianconi <lorenzo@kernel.org>
> Co-developed-by: Deren Wu <deren.wu@mediatek.com>
> Signed-off-by: Deren Wu <deren.wu@mediatek.com>
> Signed-off-by: Neil Chen <yn.chen@mediatek.com>
Somebody on github reported that this patch breaks scanning. After 
looking over it once more, I noticed something very odd:
It seems that you are dropping the mac80211 FIF_* -> mt76 filter flags 
conversion and passing mac80211 flags to the firmware by using 
*total_flags as an argument to mt7921_mcu_set_rxfilter.
This does not make any sense to me.

Shouldn't you leave the existing conversion logic in place, and just 
pass the new dev->mt76.rxfilter value to the firmware?

- Felix
