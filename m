Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 279F22EBCC3
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Jan 2021 11:53:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbhAFKv4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 6 Jan 2021 05:51:56 -0500
Received: from mail.toke.dk ([45.145.95.4]:32965 "EHLO mail.toke.dk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726844AbhAFKvz (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 6 Jan 2021 05:51:55 -0500
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
        t=1609930270; bh=Z4mZUkE7Z9ZY+z1IvqXWeSPR1h3ZXhuXokAhd6RtGp0=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=gprq7LBe2GwEcqSN10ixDnglRGCoAMxMeoi/RqsCrHEx8pG+vg+SjQhQEFXd9nM9E
         /MpA1zz9uFDnUpBwftmX5VDZuBjNl7G4rsuO5kZhQ/quV3/hSICKh6AqItYeF1qTGt
         OHjVoGkvNWBK2HAuMwBG3+CIl/gzrvTP4EC8D5NYgYet0Q1XpjxLWJXvQMCFF2vDV6
         M+zqcSRKv3lrXCe7g07BiKWtH1mTCthe6wG5dFKfbqQTbeW8jtLHoDAoFIEDzp+Hwd
         n30A/sjfJINCOvOAaOO/HPSz546/iyT5L14lFnTGAeHdqEazKsZG9HI/yK6nUIMSzD
         wO0P0IGG4htZg==
To:     Ryder Lee <ryder.lee@mediatek.com>
Cc:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: Re: [PATCH] mac80211: check ATF flag in ieee80211_next_txq()
In-Reply-To: <d9aef825d186a91ff91f6a81045d49d375533b14.1609894402.git.ryder.lee@mediatek.com>
References: <d9aef825d186a91ff91f6a81045d49d375533b14.1609894402.git.ryder.lee@mediatek.com>
Date:   Wed, 06 Jan 2021 11:51:07 +0100
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87r1my49us.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ryder Lee <ryder.lee@mediatek.com> writes:

> The selected txq should be scheduled unconditionally if
> NL80211_EXT_FEATURE_AIRTIME_FAIRNESS is not set by driver.
>
> Also put the sta to the end of the active_txqs list if
> deficit is negative then move on to the next txq.

Why is this needed? If the feature is not set, no airtime should ever be
accounted to the station, and so sta->airtime[txqi->txq.ac].deficit will
always be 0 - so you're just adding another check that doesn't actually
change the behaviour, aren't you?

-Toke
