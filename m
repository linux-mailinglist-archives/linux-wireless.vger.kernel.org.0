Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C87513EBB21
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Aug 2021 19:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbhHMROQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Aug 2021 13:14:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231683AbhHMROL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Aug 2021 13:14:11 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8D97C0617AE
        for <linux-wireless@vger.kernel.org>; Fri, 13 Aug 2021 10:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:Reply-To:Cc:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=WLGoQgxsWNND6v+7dsn5qVcqH18AC3WvFBP1RoKIvQU=; b=YFJx/7yBNAdvGhNrFO3XuUBThf
        +C/RwIgCdxjIXSDayDxteP6+Ec5yLyOzwsz81ug8EwFsa2dWEvBFjJfpv4YviUxbnT+GBI1jD2eR6
        e/q6ZHjaPRgdSWE0AqmObVrF8FRshD83fuOuuTPpt5CwEXN3JqUPvW9AOEQHjTdgsstk=;
Received: from p4ff13206.dip0.t-ipconnect.de ([79.241.50.6] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1mEakQ-0001o2-5O; Fri, 13 Aug 2021 19:13:34 +0200
Subject: Re: [PATCH v5 04/11] mt76: mt7915: allow processing TXS for 'NO_SKB'
 pkt-ids
To:     greearb@candelatech.com, linux-wireless@vger.kernel.org
References: <20210804134505.3208-1-greearb@candelatech.com>
 <20210804134505.3208-4-greearb@candelatech.com>
From:   Felix Fietkau <nbd@nbd.name>
Message-ID: <5b629ea2-d269-26af-f7a5-d389fa584555@nbd.name>
Date:   Fri, 13 Aug 2021 19:13:33 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210804134505.3208-4-greearb@candelatech.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2021-08-04 15:44, greearb@candelatech.com wrote:
> From: Ben Greear <greearb@candelatech.com>
> 
> This will let us update stats and wcid.rate for every TXS
> callback we receive for a particular wcid.
> 
> For now, the TXS is not requested for NO_SKB frames, however.
> That will be allowed in next patch.
> 
> Signed-off-by: Ben Greear <greearb@candelatech.com>
> ---
>  .../net/wireless/mediatek/mt76/mt7915/mac.c    | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
> index 6f92e207680f..2228dad71657 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
> @@ -1047,6 +1047,7 @@ void mt7915_mac_write_txwi(struct mt7915_dev *dev, __le32 *txwi,
>  	txwi[4] = 0;
>  
>  	val = FIELD_PREP(MT_TXD5_PID, pid);
> +	/* NOTE:  mt7916 does NOT request TXS for 'NO_SKB' frames by default. */
I think this comment can be dropped, given that you're adding extra
checks in the next patch that clarify this.
>  	if (pid >= MT_PACKET_ID_FIRST)
>  		val |= MT_TXD5_TX_STATUS_HOST;
>  	txwi[5] = cpu_to_le32(val);

- Felix

