Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC86261A11
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Sep 2020 20:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731672AbgIHSaf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Sep 2020 14:30:35 -0400
Received: from mail.adapt-ip.com ([173.164.178.19]:51560 "EHLO
        web.adapt-ip.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731639AbgIHSaf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Sep 2020 14:30:35 -0400
Received: from localhost (localhost [127.0.0.1])
        by web.adapt-ip.com (Postfix) with ESMTP id A6F4C4F9A8E;
        Tue,  8 Sep 2020 18:30:34 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at web.adapt-ip.com
Received: from web.adapt-ip.com ([127.0.0.1])
        by localhost (web.adapt-ip.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id L4IYMSMXuQur; Tue,  8 Sep 2020 18:30:31 +0000 (UTC)
Received: from mail.ibsgaard.io (c-73-223-60-234.hsd1.ca.comcast.net [73.223.60.234])
        (Authenticated sender: thomas@adapt-ip.com)
        by web.adapt-ip.com (Postfix) with ESMTPSA id 88BCF4F9935;
        Tue,  8 Sep 2020 18:30:31 +0000 (UTC)
MIME-Version: 1.0
Date:   Tue, 08 Sep 2020 11:30:30 -0700
From:   Thomas Pedersen <thomas@adapt-ip.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Jouni Malinen <j@w1.fi>
Subject: Re: [PATCH v2 00/22] add support for S1G association
In-Reply-To: <da06b5074a5d40d811a67656048f3afa262ff134.camel@sipsolutions.net>
References: <20200831205600.21058-1-thomas@adapt-ip.com>
 <da06b5074a5d40d811a67656048f3afa262ff134.camel@sipsolutions.net>
User-Agent: Roundcube Webmail/1.4.7
Message-ID: <c00bc0f836b1fc82bce9e83f7975d092@adapt-ip.com>
X-Sender: thomas@adapt-ip.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-09-06 09:04, Johannes Berg wrote:
> On Mon, 2020-08-31 at 13:55 -0700, Thomas Pedersen wrote:
>> 
>> Note the mac80211_hwsim S1G support introduces a regression in a few
>> hostap hwsim tests. This is because when processing the reported 
>> bands,
>> hostap assumes freq < 4000 is 11b, and the actual 11b/g band is
>> overwritten by the S1G band info. Though it does count as a userspace
>> regression, I'm not sure there is much to do about it besides apply a
>> small patch to hostapd which treats freq < 2000 as an unknown band.
>> 
>> After the hostap workaround
>> (https://lists.infradead.org/pipermail/hostap/2020-August/038748.html),
>> these patches continue to pass the hwsim tests as well as HEAD.
> 
> 
> That sounds like we could "hack around" it by sending the S1G data
> first, and then the 2.4 GHz, so the latter overwrites it on broken
> versions?

Yes that could work.

> Not sure it's worth it though, I'd say it depends a bit on what real
> hardware plans are?
> 
> I mean, if it's only hwsim for now ... who cares? And if it's going to
> be special hardware that only does S1G, then also meh, you need newer
> versions to support it, big deal.

AFAIK there are no multi-band S1G chips. The initial focus (from WFA) 
seems
to be industrial IOT.

> But if OTOH a commonly used chipset like e.g. ath9k or ath10k will get
> S1G support, then that'd be more relevant?

-- 
thomas
