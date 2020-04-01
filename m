Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B30019B4C8
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Apr 2020 19:39:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728427AbgDARjV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Apr 2020 13:39:21 -0400
Received: from mail.adapt-ip.com ([173.164.178.19]:42172 "EHLO
        web.adapt-ip.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726750AbgDARjU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Apr 2020 13:39:20 -0400
Received: from localhost (localhost [127.0.0.1])
        by web.adapt-ip.com (Postfix) with ESMTP id 0FBDD4F7A75;
        Wed,  1 Apr 2020 17:39:20 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at web.adapt-ip.com
Received: from web.adapt-ip.com ([127.0.0.1])
        by localhost (web.adapt-ip.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id pi99NDKvZ-PD; Wed,  1 Apr 2020 17:39:17 +0000 (UTC)
Received: from [10.1.15.6] (gateway.adapt-ip.com [173.164.178.20])
        (Authenticated sender: thomas@adapt-ip.com)
        by web.adapt-ip.com (Postfix) with ESMTPSA id 6B2FC4F7A48;
        Wed,  1 Apr 2020 17:39:17 +0000 (UTC)
Subject: Re: [RFC 3/7] mac80211: handle channel frequency offset
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
References: <20200401062150.3324-1-thomas@adapt-ip.com>
 <20200401062150.3324-4-thomas@adapt-ip.com>
 <7fc6331597f53f5d100f3aa7e29434c20cf6fe90.camel@sipsolutions.net>
From:   Thomas Pedersen <thomas@adapt-ip.com>
Message-ID: <7b3b34dd-882a-73e7-f857-8e581c3f7bc0@adapt-ip.com>
Date:   Wed, 1 Apr 2020 10:39:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <7fc6331597f53f5d100f3aa7e29434c20cf6fe90.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 3/31/20 11:59 PM, Johannes Berg wrote:
> On Tue, 2020-03-31 at 23:21 -0700, Thomas Pedersen wrote:
>> ie. ignore
>> for mesh, ibss, HT/VHT specific stuff, TDLS, etc.
> 
> This makes sense, but I don't see that you prevent using mesh, ibss and
> perhaps TDLS on s1g channels?
> 
> Or do we not expect drivers/devices that support this, as well as S1G
> channels?

Well it's really orthogonal to S1G (maybe a new 2412.5Mhz channel opens
up :)). We should probably return an error 'if (chan->freq_offset)' or
so for features which have not yet been tested / implemented for
frequency offset.

-- 
thomas
