Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C521D27D5FA
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Sep 2020 20:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728301AbgI2SoS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 29 Sep 2020 14:44:18 -0400
Received: from mail.adapt-ip.com ([173.164.178.19]:57430 "EHLO
        web.adapt-ip.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728166AbgI2SoS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 29 Sep 2020 14:44:18 -0400
Received: from localhost (localhost [127.0.0.1])
        by web.adapt-ip.com (Postfix) with ESMTP id F1A204F9E07;
        Tue, 29 Sep 2020 18:44:17 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at web.adapt-ip.com
Received: from web.adapt-ip.com ([127.0.0.1])
        by localhost (web.adapt-ip.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Fe-Hc9RX2P2Y; Tue, 29 Sep 2020 18:44:15 +0000 (UTC)
Received: from mail.ibsgaard.io (c-73-223-60-234.hsd1.ca.comcast.net [73.223.60.234])
        (Authenticated sender: thomas@adapt-ip.com)
        by web.adapt-ip.com (Postfix) with ESMTPSA id 341014F9E04;
        Tue, 29 Sep 2020 18:44:15 +0000 (UTC)
MIME-Version: 1.0
Date:   Tue, 29 Sep 2020 11:44:14 -0700
From:   Thomas Pedersen <thomas@adapt-ip.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] mac80211: process S1G Operation element before HT
In-Reply-To: <8cb48d6d229aa1d01f815c3a2336799b780b510d.camel@sipsolutions.net>
References: <20200929181948.22894-1-thomas@adapt-ip.com>
 <8cb48d6d229aa1d01f815c3a2336799b780b510d.camel@sipsolutions.net>
User-Agent: Roundcube Webmail/1.4.7
Message-ID: <8e9418eff4fce082312af7ca9a81bc04@adapt-ip.com>
X-Sender: thomas@adapt-ip.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-09-29 11:32, Johannes Berg wrote:
> On Tue, 2020-09-29 at 11:19 -0700, Thomas Pedersen wrote:
>> The sband->ht_cap was being processed before S1G Operation
>> element.  Since the HT capability element should not be
>> present on the S1G band, avoid processing potential
>> garbage by moving the call to
>> ieee80211_apply_htcap_overrides() to after the S1G block.
> 
> Ah, heh. I hadn't even realized that.
> 
> What I meant though was something else: we have
> 
>         if (s1g_oper && sband->band == NL80211_BAND_S1GHZ) {
> 		...
> 		goto out;
> 	}
> 
> 	// process ht cap overrides (after this patch)
> 
> 	// check HT oper
> 
> 	// check VHT oper
> 
> 	// ...
> 
> So given that first condition, if you actually have an S1G AP *without*
> S1G operation element (for some reason), you'd start processing HT, 
> VHT,
> and whatever else capabilities, sending us down a misleading and likely
> very confusing path, which seems like it should be avoided?

Ah ok, yes the !s1g_oper case. I'll take a look.

-- 
thomas
