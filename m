Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 786F641F21E
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Oct 2021 18:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232107AbhJAQ2c (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 1 Oct 2021 12:28:32 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:61401 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353926AbhJAQ2c (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 1 Oct 2021 12:28:32 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1633105607; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=zDIZm7tiCGJ2BQu6voFNyUciNkkPNIVPSpavjhKm6l8=; b=ealH8y+Glucakfd/08SXPT3VPatzg4HUI05XDQGmn80eGtg7iH/e86cB1Hs8EfVeWZQkV4pb
 cpmE/bRA12gkYea6LYOwzQXXuY1qWTsTZ10s0p9QgtfVx05sl5g8zQ1d25hM6fLiFUb/4/lX
 NKndxuf/d15FCcZJBaCxaO9voSk=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 615736b947d64efb6d8c7e55 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 01 Oct 2021 16:26:33
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id AF56CC4360C; Fri,  1 Oct 2021 16:26:33 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 66DC9C4338F;
        Fri,  1 Oct 2021 16:26:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 66DC9C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v6 03/24] rtw89: add core and trx files
References: <20210820043538.12424-1-pkshih@realtek.com>
        <20210820043538.12424-4-pkshih@realtek.com>
Date:   Fri, 01 Oct 2021 19:26:26 +0300
In-Reply-To: <20210820043538.12424-4-pkshih@realtek.com> (Ping-Ke Shih's
        message of "Fri, 20 Aug 2021 12:35:17 +0800")
Message-ID: <877dewiudp.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> writes:

> Implement main flows that contains register/unregister mac80211 hw with
> hardware capability, power on/off sequence, STA state actions, and
> TX/RX path.
>
> The chip info is read from efuse while probing PCI, and then it can be
> used to induce supported channel, band, bitrate, ht/vht/he capability,
> and etc. Then, we register hardware with these capabilities.
>
> When network interface is up, driver does power-on sequence to enable MAC,
> BB and RF function blocks. Oppositely, do power-off sequence when
> interface is going to down.
>
> To maintain STA state, five callbacks are implemented -- add, assoc,
> disassoc, disconnect and remove. In which state, driver tells firmware STA
> info via H2C.
>
> TX flow:
> When a SKB is going to be transmitted, we must know its type first. If
> the type is mgmt or fwcmd made by driver, SKB is queued into corresponding
> DMA channel and PCI ring. The other type is data frame that is more
> complex, because it needs to establish BA session to have better throughput
> with AMPDU and AMSDU.
> In order to have better PCI DMA efficiency, we don't kick off DMA every
> SKB. With wake TX queue, kick off DMA after a bunch of SKBs are written.
> To achieve this, we have two HCI ops -- tx_write and tx_kick_off.
>
> BA establishment work:
> For data frames, we start to establish BA session if the STA is associated
> with APMDU capability and the TID session isn't established, and then the
> BA work is used to ask mac80211 to start AMPDU actions. Driver implements
> AMPDU action callbacks to know the session is established, so that we can
> set AGG_EN bit in TX descriptor to enable AMPDU.
>
> RX flow:
> When a RX SKB is delivered from PCI, rtw89_core_rx() process it depneds on
> its type -- WIFI, C2H or PPDU. If type is C2H, it's queued into a C2H
> queue, and wake a work to handle the C2H packet. If type is WIFI, it's a
> normal RX packet. When mgmt or data frame is received, it is queued
> into pending RX SKB queue to wait for corresponding PPDU packet (another
> RX packet with PPDU type) to fill its rx_status, like RSSI. And, then
> indicate this packet to mac80211. When control frame is received, indicate
> it to mac80211 immediately.
>
> Track work:
> Use track work to monitor PHY status to know the changes of environment,
> and then update RA status or do RFK accordingly.
>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

[...]

> +static __always_inline void RTW89_SET_TXWD(u8 *txdesc, u32 val, u8 offset, u32 mask)
> +{
> +	u32 *txd32 = (u32 *)txdesc;
> +
> +	le32p_replace_bits((__le32 *)(txd32 + offset), val, mask);
> +}

I'm not convinced about this either, please just use inline.

Also having functions in upper case is not really something I recommend.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
