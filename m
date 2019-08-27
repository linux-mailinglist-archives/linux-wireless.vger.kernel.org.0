Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1E89E62A
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2019 12:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729161AbfH0Kvm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 27 Aug 2019 06:51:42 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:34960 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbfH0Kvm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 27 Aug 2019 06:51:42 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 27C5C60C5F; Tue, 27 Aug 2019 10:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1566903101;
        bh=dXh5psJH6KJJwOule8YyV+lVoNFEfbqfaGzAIfFICjk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gVxpTkSpLlaBiMFIfcR7epwWKbcMZ678oYJ2rlddCMUmTf/G/Cj1iP/CavPa1u9GH
         Mu9/L32YQvUzj88J3ekb+D4kkUkC4j7Xd1FNgtmGPBOcqbmefHtGJB8dqvDozCooeq
         iDbToqppgB/uXxOagBGbnNZAlSKt3B4ut2G8GdCo=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id DE32F60271;
        Tue, 27 Aug 2019 10:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1566903100;
        bh=dXh5psJH6KJJwOule8YyV+lVoNFEfbqfaGzAIfFICjk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=T1TEoDfVyZADU302XoSqoVVv+q1iRcGcfduhF6tujJ5Da1UZtQwc4MTCCBvlHFoKJ
         JF8X6pRW2R/6cVl4EBRjlx93Czshdn/mYpHCCvclibn7FIvA1NT3HQAKwXXklx/l9e
         31og8cOBU8FLcvXBAn4qIO+Ocnk0Oaik5mSNyTAo=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 27 Aug 2019 16:21:40 +0530
From:   Vasanthakumar Thiagarajan <vthiagar@codeaurora.org>
To:     Nicolas Cavallari <Nicolas.Cavallari@green-communications.fr>
Cc:     Kalle Valo <kvalo@codeaurora.org>, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org, devicetree@vger.kernel.org,
        linux-wireless-owner@vger.kernel.org
Subject: Re: [PATCH 31/49] ath11k: add mac.c
In-Reply-To: <c37a9fc4-aa74-a333-a67c-cce66ad78ec0@green-communications.fr>
References: <1566316095-27507-1-git-send-email-kvalo@codeaurora.org>
 <1566316095-27507-32-git-send-email-kvalo@codeaurora.org>
 <c37a9fc4-aa74-a333-a67c-cce66ad78ec0@green-communications.fr>
Message-ID: <1da054e86da63423a5e58c22c2c79d79@codeaurora.org>
X-Sender: vthiagar@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2019-08-23 20:32, Nicolas Cavallari wrote:
> On 20/08/2019 17:47, Kalle Valo wrote:
>> +	ar->hw->wiphy->interface_modes = BIT(NL80211_IFTYPE_STATION) |
>> +					 BIT(NL80211_IFTYPE_AP) |
>> +					 BIT(NL80211_IFTYPE_MESH_POINT);
> 
> [...]
> 
>> +	ar->hw->wiphy->flags |= WIPHY_FLAG_IBSS_RSN;
> 
> so IBSS-RSN is supported without IBSS support ?

Sure. IBSS-RSN is not relevant when IBSS is not supported, I guess.
We'll take care of this. Thanks.

Vasanth
