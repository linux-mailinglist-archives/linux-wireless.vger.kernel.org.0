Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FD6D2EBEB5
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Jan 2021 14:33:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726807AbhAFNbt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 6 Jan 2021 08:31:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726792AbhAFNbs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 6 Jan 2021 08:31:48 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24789C06134D
        for <linux-wireless@vger.kernel.org>; Wed,  6 Jan 2021 05:31:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=kLEk8p56/LKORuReiIiQpbhmzF1RSMKBphSSZjmMIBA=; b=eCykt8EcsLGRa6LPmX7wPupJ1c
        xDOy5ftJkco60H8gAXNGuy0AbMbcTPYJ8oLPDkzkpiSOTXjJRxfKV8TmhtrQ2j4ynEJVVtC9dz+tC
        6VNziLka48UYLWOB5I2biNhUoGKup8LP47QeYd/8Lvb1rMkBcUdXdk4vhI2UD+3NJF0Y=;
Received: from p54ae91f2.dip0.t-ipconnect.de ([84.174.145.242] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1kx8tu-0000EP-Ks; Wed, 06 Jan 2021 14:30:58 +0100
Subject: Re: [PATCH] mac80211: check ATF flag in ieee80211_next_txq()
To:     =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@toke.dk>,
        Ryder Lee <ryder.lee@mediatek.com>
Cc:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <d9aef825d186a91ff91f6a81045d49d375533b14.1609894402.git.ryder.lee@mediatek.com>
 <87r1my49us.fsf@toke.dk>
From:   Felix Fietkau <nbd@nbd.name>
Message-ID: <68ab89bc-70f4-e822-3d96-21ba3bd6511f@nbd.name>
Date:   Wed, 6 Jan 2021 14:30:57 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <87r1my49us.fsf@toke.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2021-01-06 11:51, Toke Høiland-Jørgensen wrote:
> Ryder Lee <ryder.lee@mediatek.com> writes:
> 
>> The selected txq should be scheduled unconditionally if
>> NL80211_EXT_FEATURE_AIRTIME_FAIRNESS is not set by driver.
>>
>> Also put the sta to the end of the active_txqs list if
>> deficit is negative then move on to the next txq.
> 
> Why is this needed? If the feature is not set, no airtime should ever be
> accounted to the station, and so sta->airtime[txqi->txq.ac].deficit will
> always be 0 - so you're just adding another check that doesn't actually
> change the behaviour, aren't you?
I think it might make sense to keep airtime reporting even when airtime
fairness is disabled at run time, so this patch makes sense to me.
Instead of this patch, the right place to deal with this would probably
be ieee80211_sta_register_airtime.

- Felix
