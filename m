Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8BD2F18CE6F
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2020 14:06:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbgCTNGF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 Mar 2020 09:06:05 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:45858 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727015AbgCTNGF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 Mar 2020 09:06:05 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jFHLW-00AsrY-Hv; Fri, 20 Mar 2020 14:05:54 +0100
Message-ID: <d45e2002e97c28acc1f9c7b9c41b5a3ba1d69452.camel@sipsolutions.net>
Subject: Re: [PATCH] rtw88: add debugfs to fix tx rate
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Tony Chuang <yhchuang@realtek.com>,
        Ben Greear <greearb@candelatech.com>,
        Kalle Valo <kvalo@codeaurora.org>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Brian Norris <briannorris@chromium.org>
Date:   Fri, 20 Mar 2020 14:05:53 +0100
In-Reply-To: <fbab3328d183406c923b30381389841f@realtek.com>
References: <20200313065114.23433-1-yhchuang@realtek.com>
         <87eetwo87q.fsf@kamboji.qca.qualcomm.com>
         <2e492e530d744713871f885e324106ef@realtek.com>
         <87eetrlanb.fsf@kamboji.qca.qualcomm.com>
         <ce990869ebf0478d98cd7e8416b36289@realtek.com>
         <875zf3kn05.fsf@kamboji.qca.qualcomm.com>
         <f4e7401c-c86b-8b2f-9e93-865322f71945@candelatech.com>
         <fbab3328d183406c923b30381389841f@realtek.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2020-03-18 at 09:02 +0000, Tony Chuang wrote:
> 
> This command just mask out some of rates that are not allowed. But the
> firmware has its own rate adaptive mechanism to choose the rates. So mask
> out all of the other rate doesn't make sure the packets will be transmitted by
> the only rate that was not masked. The hardware/firmware will try to choose
> a better rate (ex. 1Mbps or 6Mbps) if they think it's necessary. Also the device
> will fallback the rates to try to find a better rate to transfer data to the peer.

[...]

> We probably have to modify the command parser, from user-space and the
> nl80211 domain, because as far I don't see a good way to add fix rate
> option on the NL80211_CMD_SET_TX_BITRATE_MASK without changing
> the existing mechanism. If the mechanism is changed, then the "old" drivers
> will fail to interpret the nl80211 attributes. So I think add a new one, which
> can fix the TX rate, disable the rate adaptive, etc., will be better if necessary.

IMHO we should consider the use case here.

_Why_ do you need something like this?

Brian can probably comment on this - I think ChromeOS (used to) use(s)
some kind of fixed rate at the beginning of the connection to force low
rates? But I also remember this interacting badly with some APs that
just don't want to enable low rates at all...


I think we also have a similar debugfs entry in iwlwifi which literally
forces a single rate/configuration (including antenna) for the device to
use, to test certain things. I'm not convinced that it'd be easy and
would make a lot of sense to add support for all these kinds of knobs to
nl80211 since they're really just used in limited testing scenarios.


So IMHO the "can this be put into nl80211" isn't necessarily the most
important thing - we don't *have* to clutter that with various knobs
that are only supported by some drivers, and then only used for testing
...

johannes

