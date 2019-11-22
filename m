Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C83C1076E3
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Nov 2019 19:01:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbfKVSBV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 22 Nov 2019 13:01:21 -0500
Received: from mail.adapt-ip.com ([173.164.178.19]:59752 "EHLO
        mail.adapt-ip.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbfKVSBV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 22 Nov 2019 13:01:21 -0500
Received: from localhost (unknown [127.0.0.1])
        by mail.adapt-ip.com (Postfix) with ESMTP id 859022F04DF;
        Fri, 22 Nov 2019 18:01:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at web.adapt-ip.com
Received: from mail.adapt-ip.com ([127.0.0.1])
        by localhost (web.adapt-ip.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Uyk9Cc9qvoGF; Fri, 22 Nov 2019 10:01:19 -0800 (PST)
Received: from [10.1.10.171] (vpn.adapt-ip.com [173.164.178.20])
        (using TLSv1.2 with cipher AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: thomas@adapt-ip.com)
        by mail.adapt-ip.com (Postfix) with ESMTPSA id 271532F048D;
        Fri, 22 Nov 2019 10:01:19 -0800 (PST)
Subject: Re: [PATCH v2 0/3] fix a STA PS bug and add PS support to
 mac80211_hwsim
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
References: <20191119053538.25979-1-thomas@adapt-ip.com>
 <85ed0881d0aeecd886b27bd482fa61fa86d96729.camel@sipsolutions.net>
From:   Thomas Pedersen <thomas@adapt-ip.com>
Message-ID: <f0ae4c07-d3c3-768f-49c0-1f2a6c5a687d@adapt-ip.com>
Date:   Fri, 22 Nov 2019 10:01:18 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <85ed0881d0aeecd886b27bd482fa61fa86d96729.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 11/22/19 4:38 AM, Johannes Berg wrote:
> Hi,
> 
> On Mon, 2019-11-18 at 21:35 -0800, Thomas Pedersen wrote:
>> This patchset tries to make mac80211 power save testable with the hostap
>> hwsim tests, and fixes a bug in STA power save.
>>
>> Basic tests for AP and STA power save will be submitted to hostap
>> separately.
> 
> Cool :)
> 
> I was going to apply all of these, but then it turned out that the first
> one causes a bunch of hwsim tests to fail?

OK. If you point me toward which tests started to fail I can take a
look.

> It seems quite possible that this is just a mac80211 bug somewhere, but
> I'd want to look at this more closely, so I've dropped it back to "Under
> Review" in patchwork again.
> 
> Any thoughts?
> 
> johannes
> 


-- 
-- thomas
