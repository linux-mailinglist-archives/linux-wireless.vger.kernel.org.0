Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69249421F9C
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Oct 2021 09:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232478AbhJEHs2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 5 Oct 2021 03:48:28 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:44003 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbhJEHs1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 5 Oct 2021 03:48:27 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1633419997; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=tKG4v9mTqjOEYS5RuTNaOlXMiTmoTtINCejr3KmPZRQ=; b=FZwu3R/1hwVhlCmINPcUXVGEyxcFY3KyuFGZRAE+L67fwRCsPX7YJicyYicN7aBR5usghpbn
 MWbBzMA6U0NT4RkJk5c98vs8qht1+gHkcZjqfULcwGgcCJjduAo6qd0R172vM4zdatnWyGP4
 dcCWUf+PpTWVzYmN2+Byf+5dZMw=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 615c02d782bb2c5fd52addb3 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 05 Oct 2021 07:46:31
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 9F6F7C43616; Tue,  5 Oct 2021 07:46:31 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 65440C4338F;
        Tue,  5 Oct 2021 07:46:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 65440C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Pkshih <pkshih@realtek.com>, Arnd Bergmann <arnd@arndb.de>
Cc:     "linux-wireless\@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v6 03/24] rtw89: add core and trx files
References: <20210820043538.12424-1-pkshih@realtek.com>
        <20210820043538.12424-4-pkshih@realtek.com>
        <877dewiudp.fsf@codeaurora.org>
        <4b2f1c6b06e040d19b64d07500e0447b@realtek.com>
Date:   Tue, 05 Oct 2021 10:46:26 +0300
In-Reply-To: <4b2f1c6b06e040d19b64d07500e0447b@realtek.com> (Pkshih's message
        of "Tue, 5 Oct 2021 07:16:44 +0000")
Message-ID: <87pmsjgbhp.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Pkshih <pkshih@realtek.com> writes:

>> -----Original Message-----
>> From: kvalo=codeaurora.org@mg.codeaurora.org
>> <kvalo=codeaurora.org@mg.codeaurora.org> On
>> Behalf Of Kalle Valo
>> Sent: Saturday, October 2, 2021 12:26 AM
>> To: Pkshih <pkshih@realtek.com>
>> Cc: linux-wireless@vger.kernel.org
>> Subject: Re: [PATCH v6 03/24] rtw89: add core and trx files
>> 
>> Ping-Ke Shih <pkshih@realtek.com> writes:
>> 
>> > Implement main flows that contains register/unregister mac80211 hw with
>> > hardware capability, power on/off sequence, STA state actions, and
>> > TX/RX path.
>> >
>> > The chip info is read from efuse while probing PCI, and then it can be
>> > used to induce supported channel, band, bitrate, ht/vht/he capability,
>> > and etc. Then, we register hardware with these capabilities.
>> >
>> > When network interface is up, driver does power-on sequence to enable MAC,
>> > BB and RF function blocks. Oppositely, do power-off sequence when
>> > interface is going to down.
>> >
>> > To maintain STA state, five callbacks are implemented -- add, assoc,
>> > disassoc, disconnect and remove. In which state, driver tells firmware STA
>> > info via H2C.
>> >
>> > TX flow:
>> > When a SKB is going to be transmitted, we must know its type first. If
>> > the type is mgmt or fwcmd made by driver, SKB is queued into corresponding
>> > DMA channel and PCI ring. The other type is data frame that is more
>> > complex, because it needs to establish BA session to have better throughput
>> > with AMPDU and AMSDU.
>> > In order to have better PCI DMA efficiency, we don't kick off DMA every
>> > SKB. With wake TX queue, kick off DMA after a bunch of SKBs are written.
>> > To achieve this, we have two HCI ops -- tx_write and tx_kick_off.
>> >
>> > BA establishment work:
>> > For data frames, we start to establish BA session if the STA is associated
>> > with APMDU capability and the TID session isn't established, and then the
>> > BA work is used to ask mac80211 to start AMPDU actions. Driver implements
>> > AMPDU action callbacks to know the session is established, so that we can
>> > set AGG_EN bit in TX descriptor to enable AMPDU.
>> >
>> > RX flow:
>> > When a RX SKB is delivered from PCI, rtw89_core_rx() process it depneds on
>> > its type -- WIFI, C2H or PPDU. If type is C2H, it's queued into a C2H
>> > queue, and wake a work to handle the C2H packet. If type is WIFI, it's a
>> > normal RX packet. When mgmt or data frame is received, it is queued
>> > into pending RX SKB queue to wait for corresponding PPDU packet (another
>> > RX packet with PPDU type) to fill its rx_status, like RSSI. And, then
>> > indicate this packet to mac80211. When control frame is received, indicate
>> > it to mac80211 immediately.
>> >
>> > Track work:
>> > Use track work to monitor PHY status to know the changes of environment,
>> > and then update RA status or do RFK accordingly.
>> >
>> > Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
>> 
>> [...]
>> 
>> > +static __always_inline void RTW89_SET_TXWD(u8 *txdesc, u32 val,
>> > u8 offset, u32 mask)
>> > +{
>> > +	u32 *txd32 = (u32 *)txdesc;
>> > +
>> > +	le32p_replace_bits((__le32 *)(txd32 + offset), val, mask);
>> > +}
>> 
>> I'm not convinced about this either, please just use inline.
>
> This is because 'mask' argument of le32p_replace_bits() must be constant
> only. If I use inline and build this driver with ccflags-y += -Os,
> compiler reports errors:
>
> In function 'field_multiplier',
>     inlined from 'le32_encode_bits' at ./include/linux/bitfield.h:154:1,
>     inlined from 'le32p_replace_bits' at ./include/linux/bitfield.h:154:1,
>     inlined from 'RTW89_SET_FWCMD_UA32.constprop' at /work/git-root/rtwlan/rtw89/fw.h:1397:2:
> ./include/linux/bitfield.h:119:3: error: call to '__bad_mask' declared with attribute error: bad bitfield mask
>   119 |   __bad_mask();
>       |   ^~~~~~~~~~~~
>
> I check the implement of le32p_replace_bits(), it looks like
>
> static __always_inline void type##p_replace_bits(__##type *p,           \
>                                         base val, base field)           \
> {                                                                       \
>         *p = (*p & ~to(field)) | type##_encode_bits(val, field);        \
> }
>
> So, I imitate the function to use __always_inline, and then it works.
>
> Do you think I don't need to consider the case of Os?
> But, -Os seems a standard option of Linux kernel.
>
> ifdef CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE
> KBUILD_CFLAGS += -O2
> else ifdef CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE_O3
> KBUILD_CFLAGS += -O3
> else ifdef CONFIG_CC_OPTIMIZE_FOR_SIZE
> KBUILD_CFLAGS += -Os
> endif

Yeah, we need to support -Os.

Arnd, what do you suggest? Is __always_inline good solution for this? I
think we should at least add a comment explaining why it's needed.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
