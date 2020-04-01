Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFDF919B56F
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Apr 2020 20:27:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732435AbgDAS1A (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Apr 2020 14:27:00 -0400
Received: from mail.adapt-ip.com ([173.164.178.19]:42944 "EHLO
        web.adapt-ip.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730420AbgDAS1A (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Apr 2020 14:27:00 -0400
Received: from localhost (localhost [127.0.0.1])
        by web.adapt-ip.com (Postfix) with ESMTP id E3B4A4F7A92;
        Wed,  1 Apr 2020 18:26:59 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at web.adapt-ip.com
Received: from web.adapt-ip.com ([127.0.0.1])
        by localhost (web.adapt-ip.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id lyTUkriN34k0; Wed,  1 Apr 2020 18:26:57 +0000 (UTC)
Received: from [10.1.15.6] (gateway.adapt-ip.com [173.164.178.20])
        (Authenticated sender: thomas@adapt-ip.com)
        by web.adapt-ip.com (Postfix) with ESMTPSA id 59D044F7A8E;
        Wed,  1 Apr 2020 18:26:57 +0000 (UTC)
Subject: Re: [RFC 0/7] add a KHz component to wireless channels
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
References: <20200401062150.3324-1-thomas@adapt-ip.com>
 <1fb3634babea0a8bd0021493919d3ebd0e279087.camel@sipsolutions.net>
From:   Thomas Pedersen <thomas@adapt-ip.com>
Message-ID: <03b79029-c168-06df-2d8e-ef4179bd9ba2@adapt-ip.com>
Date:   Wed, 1 Apr 2020 11:26:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <1fb3634babea0a8bd0021493919d3ebd0e279087.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 4/1/20 12:15 AM, Johannes Berg wrote:
> On Tue, 2020-03-31 at 23:21 -0700, Thomas Pedersen wrote:
> 
>> Some cfg80211 and nl80211 internals have been converted to handle units
>> of KHz, which is not unprecedented (net/wireless/reg.c), and the
>> collateral damage is localized.
> 
> :)
> 
>> One thing which is still unclear is backward compatibility in nl80211.
>> If a frequency offset is supplied to an older kernel, it'll just
>> silently fail to do the right thing.
> 
> But will it? It mostly requires to have a struct ieee80211_channel
> registered with the wiphy for a given frequency, and won't find that?

I was worried the wrong ("rounded down") channel would be found, but I
think the point is mostly moot since that channel wouldn't exist either.

> But speaking of which - I was expecting to see a new *band* here for
> S1G, so that you can actually register the channels properly in the
> wiphy struct? Or is that just not part of this patchset yet?

Yeah just trying to focus on the frequency offset stuff and keep S1G out
of it for now. Do you think it would be helpful to cap it with the new
S1G band definition?

-- 
thomas
